$PBExportHeader$w_calculate_job_time.srw
$PBExportComments$Calculate the job execution time according to the shop floor calendar
forward
global type w_calculate_job_time from Window
end type
type dw_jobs from datawindow within w_calculate_job_time
end type
type dw_shop_time from datawindow within w_calculate_job_time
end type
end forward

global type w_calculate_job_time from Window
int X=672
int Y=264
int Width=1582
int Height=992
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_jobs dw_jobs
dw_shop_time dw_shop_time
end type
global w_calculate_job_time w_calculate_job_time

type variables
Boolean   bAllScheduled  //Whether all jobs scheduled
Boolean   bRightShift      //Whether this is the right shift

Date        dStartDatePointer //The available start date
Date        dEndDate            //The end date
Date        dJobStartDate      //The job start date

Time        tStartTimePointer //The start time pointer
Time        tEndTime            //The end time pointer

Decimal   nAvailableHours   //Available hour in the current shift
Decimal   nRunTimeLeft      //Run time left for schedule

String      szMachine           //Current Machine
end variables

forward prototypes
public subroutine calculate_time (datawindow dw_hard_queue)
public subroutine end_date_time (date dDate, time tStartTime, decimal rRunTime)
public function decimal hours_after (date dStartDate, time tStartTime, date dEndDate, time tEndTime)
public function integer update_datawindow (datawindow dWin)
public function decimal get_shift_info (long icurrentshift)
public subroutine change_up (string szmachine, long isequence, string szworkorder, date dstartdate, time dstarttime)
public subroutine change_up_2 (string szmachine, long isequence, string szworkorder, date denddate, time dendtime)
public subroutine change_sequence (string szmachine)
public subroutine change_seq (string szworkorder, long irow)
end prototypes

public subroutine calculate_time (datawindow dw_hard_queue);//**************************************************************************
//* Author				: Jim Wu
//* Start Date			: 12/27/94
//* Customer   		: All
//* Monitor Ver		: 3.0
//* Development Tool	: PowerBuilder 3.0 / Watcom SQL
//* Description      : This function will dynamically calcualte the job 
//*                    execution time according to the schedule of shop
//*                    calendar
//************************************************************************
//* Declaration
//************************************************************************

Long iRow

Int  iCurrentShift   //Current row in the shop floor calendar
Int  iJobCount       //Current job row in the job hard queue

String szModString	//The modifying string
String szWorkOrder   //The work order number
String szProcessId   //The process id

Date dDueDate        //Due date
Date dShiftStartDate //The shift starting date
Date dShiftEndDate   //The shift ending date

Time tShiftStartTime //The shift starting time
Time tShiftEndTime   //The shift ending time
Time tJobStartTime	//The job starting time

Dec    rRunTime		//The run time

//*******************************************************************
//* Initialization
//*******************************************************************

iJobCount		= 1
iCurrentShift	= 1
bAllScheduled 	= FALSE
bRightShift		= FALSE

//********************************************************************
//* Main Routine
//********************************************************************

dJobStartDate  	= Today ()  //First job in the queue must start now
tJobStartTime  	= Now ()
dStartDatePointer	= dJobStartDate
tStartTimePointer	= tJobStartTime

dw_shop_time.Retrieve(szMachine, dStartDatePointer)

//Search the first shift which CONTAINS the current job moment

Do while (Not bRightShift) and (iCurrentShift <= dw_shop_time.RowCount())

	dShiftStartDate	= dw_shop_time.GetItemDate(iCurrentShift, "work_date")
	tShiftStartTime	= dw_shop_time.GetItemTime(iCurrentShift, "begin_time")
	rRunTime 	= dw_shop_time.GetItemNumber(iCurrentShift, "up_hours")
	If IsNull(rRunTime) then
		rRunTime	= 0
	End If
	
	End_date_time(dShiftStartDate, tShiftStartTime, rRunTime)

	dShiftEndDate		= dEndDate   //Get the end date and time for the shift
	tShiftEndTime		= tEndTime
	nAvailableHours	= Hours_after(dJobStartDate, tJobStartTime, dShiftEndDate, tShiftEndTime)

	If nAvailableHours > 0 then
		bRightShift	= TRUE

		//Check whether the job is in the down-time block
		If (dJobStartDate < dShiftStartDate) &
			OR ( (dJobStartDate = dShiftStartDate) AND (tJobStartTime <= tShiftStartTime)) then
			dJobStartDate	= dShiftStartDate	//If it is, then starts at the
			tJobStartTime	= tShiftStartTime //shift begin
		End If
	Else
		iCurrentShift 	= iCurrentShift + 1
	End If			

Loop

If Not (bRightShift) then	//If there is no right shift found
	nAvailableHours	= 999999
Else
	nAvailableHours	= Hours_after(dJobStartDate, tJobStartTime, dShiftEndDate, tShiftEndTime)
End If

If dw_hard_queue.RowCount() > 0 then
	nRunTimeLeft		= dw_hard_queue.GetItemNumber(iJobCount, "runtime")
	If nRunTimeLeft <= 0 then
		nRunTimeLeft	= 1
	End If
	dw_hard_queue.SetItem(iJobCount, "start_date", dJobStartDate)
	dw_hard_queue.SetItem(iJobCount, "start_time", tJobStartTime)
	tStartTimePointer	= tJobStartTime
	dStartDatePointer = dJobStartDate
	If dw_hard_queue.Update() > 0 then
		commit ;
	Else
		rollback ;
	end if
End If
		
Do while Not bAllScheduled

	//Check whether the job beginning time is fit in the current shift
	
	If nRunTimeLeft <= nAvailableHours then	//It can fit into the current shift
	
		//Put the job into the shift
		End_date_time(dStartDatePointer, tStartTimePointer, nRunTimeLeft)
		
		dw_hard_queue.SetItem(iJobCount, "end_date", dEndDate) //nEndDate is from END_DATE_TIME()
		dw_hard_queue.SetItem(iJobCount, "end_time", tEndTime) //tEndTime is from END_DATE_TIME()

		If dw_hard_queue.Update() > 0 then
			commit ;
		Else
			rollback ;
		end if
		
		dStartDatePointer	= dEndDate				//Get the current shift start moment
		tStartTimePointer	= tEndTime

		nAvailableHours 	= (nAvailableHours - nRunTimeLeft)
		iJobCount			= iJobCount + 1

		If iJobCount > dw_hard_queue.RowCount() then
			bAllScheduled	= TRUE
		Else
			If nAvailableHours = 0 then	//No more hours left in the current shift
				iCurrentShift	= iCurrentShift + 1	//Then get next shift
				get_shift_info(iCurrentShift)		//Get the shift info
				nRunTimeLeft	= dw_hard_queue.GetItemNumber(iJobCount, "runtime")
				If nRunTimeLeft <= 0 then
					nRunTimeLeft	= 1
				End If
				dw_hard_queue.SetItem(iJobCount, "start_date", dShiftStartDate)
				dw_hard_queue.SetItem(iJobCount, "start_time", tShiftStartTime)
				dJobStartDate	= dShiftStartDate
				tJobStartTime	= tShiftStartTime

				If dw_hard_queue.Update() > 0 then
					commit ;
				Else	
					rollback ;
				end if
			Else
				nRunTimeLeft	= dw_hard_queue.GetItemNumber(iJobCount, "runtime")
				If nRunTimeLeft <= 0 then
					nRunTimeLeft	= 1
				End If
				dw_hard_queue.SetItem(iJobCount, "start_date", dStartDatePointer)
				dw_hard_queue.SetItem(iJobCount, "start_time", tStartTimePointer)
				dJobStartDate	= dStartDatePointer
				tJobStartTime	= tStartTimePointer

				If dw_hard_queue.Update() > 0 then
					commit ;
				Else
					rollback ;
				end if
			End If																		
		End If
	Else 	//the job should be extended into the next shift
		nRunTimeLeft	= nRunTimeLeft - nAvailableHours
		iCurrentShift	= iCurrentShift + 1
		get_shift_info(iCurrentShift)
	End If							
Loop	


end subroutine

public subroutine end_date_time (date dDate, time tStartTime, decimal rRunTime);Integer iHowmanyDays
Decimal nHours

rRunTime			=	rRunTime + Hour(tStartTime) + (Minute(tStartTime) / 60) 
iHowManyDays	= Truncate( (rRunTime / 24), 0)
nHours			= Mod (rRunTime , 24)

dEndDate			= RelativeDate( dDate, iHowManyDays)
tEndTime			= RelativeTime(00:00:00, (nHours * 3600))			 



end subroutine

public function decimal hours_after (date dStartDate, time tStartTime, date dEndDate, time tEndTime);Return ( (DaysAfter(dStartdate, dEndDate) * 24) + (SecondsAfter(tStartTime, tEndTime) / 3600) )

end function

public function integer update_datawindow (datawindow dWin);If dWin.Update() > 0 then
	Commit;
	Return 1
Else
	Rollback;
	Return 0
End If

end function

public function decimal get_shift_info (long icurrentshift);If iCurrentShift <= dw_shop_time.RowCount() then  //Still having more
	dStartDatePointer	= dw_shop_time.GetItemDate(iCurrentShift, "work_date")
	tStartTimePointer	= dw_shop_time.GetItemTime(iCurrentShift, "begin_time")
	nAvailableHours	= dw_shop_time.GetItemNumber(iCurrentShift   , "up_hours")
Else 
	nAvailableHours	= 999999999 //No more shifts
	bAllScheduled	= TRUE	
End If

Return nAvailableHours
end function

public subroutine change_up (string szmachine, long isequence, string szworkorder, date dstartdate, time dstarttime);DECLARE mp_up_dw_1 PROCEDURE FOR 'dbo.mp_up_wd_1;1'  
         @a_machine_no = :szmachine,   
         @a_sequence = :isequence,   
         @a_workorder = :szworkorder,   
         @a_start_date = :dstartdate,   
         @a_start_time = :dstarttime  ;

Integer li_rtn_code 

EXECUTE mp_up_dw_1 ;

FETCH mp_up_dw_1 INTO :li_rtn_code ;

IF li_rtn_code = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

CLOSE mp_up_dw_1 ;


end subroutine

public subroutine change_up_2 (string szmachine, long isequence, string szworkorder, date denddate, time dendtime);DECLARE mp_up_dw_2 PROCEDURE FOR 'dbo.mp_up_wd_2;1'  
         @a_machine_no = :szmachine,   
         @a_sequence = :isequence,   
         @a_workorder = :szworkorder,   
         @a_end_date = :denddate,   
         @a_end_time = :dendtime  ;

Integer li_rtn_code 

EXECUTE mp_up_dw_2 ;

FETCH mp_up_dw_2 INTO :li_rtn_code ;

IF li_rtn_code = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

CLOSE mp_up_dw_2 ;


end subroutine

public subroutine change_sequence (string szmachine);INTEGER li_Rtn_Code 

DECLARE inc_serial PROCEDURE FOR 'dbo.mp_inc_serial;1'  
         @a_machine = szmachine  ;

EXECUTE inc_serial ;

FETCH inc_serial INTO :li_rtn_code ;

IF li_rtn_code = 0 then
	commit ;
Else
	rollback ;
End if
end subroutine

public subroutine change_seq (string szworkorder, long irow);Integer li_rtn_code 

DECLARE mp_change_seq PROCEDURE FOR 'dbo.mp_change_seq;1' 
         @a_workorder =  szworkorder,  @a_rowcount =  iRow ;

EXECUTE mp_change_seq ;

IF SQLCA.SQLCODE <> 0 THEN
  messagebox("error",sqlca.sqlerrtext )
END IF	

FETCH mp_change_seq INTO :li_rtn_code ;

IF li_rtn_code = 0 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF

end subroutine

event open;//**************************************************************************
//* Author				: Jim Wu
//* Start Date			: 12/27/94
//* Customer   		: All
//* Monitor Ver		: 3.0
//* Development Tool	: PowerBuilder 3.0 / Watcom SQL
//************************************************************************
//* Declaration
//************************************************************************

Long iRow

String szworkorder

dw_shop_time.SetTransObject(sqlca)
dw_jobs.SetTransObject(sqlca)

//************************************************************************
//* Initialization
//************************************************************************

szMachine	= Message.StringParm
dw_jobs.Retrieve(Message.StringParm)

IF SQLCA.sqlreturndata <> 'Watcom SQL' THEN

	For iRow = 1 to dw_jobs.RowCount()
		dw_jobs.SetItem(iRow, "sequence", iRow)

		If dw_jobs.update() > 0 then
			commit ;
		Else
			rollback ;
		end if	
	Next

ELSE

	For iRow = 1 to dw_jobs.RowCount()
		dw_jobs.SetItem(iRow, "sequence", iRow)
	NEXT

	If dw_jobs.update() > 0 then
		commit ;
	Else
		rollback ;
	end if	

END IF

calculate_time(dw_jobs)

Close(w_calculate_job_time)
end event

on w_calculate_job_time.create
this.dw_jobs=create dw_jobs
this.dw_shop_time=create dw_shop_time
this.Control[]={this.dw_jobs,&
this.dw_shop_time}
end on

on w_calculate_job_time.destroy
destroy(this.dw_jobs)
destroy(this.dw_shop_time)
end on

type dw_jobs from datawindow within w_calculate_job_time
int X=192
int Y=508
int Width=494
int Height=360
int TabOrder=20
boolean Visible=false
string DataObject="d_order_list_new_two"
boolean LiveScroll=true
end type

type dw_shop_time from datawindow within w_calculate_job_time
int X=969
int Y=508
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
string DataObject="dw_select_time_from_shop_floor_calendar"
boolean LiveScroll=true
end type


$PBExportHeader$w_production_grid.srw
$PBExportComments$Production Grid
forward
global type w_production_grid from Window
end type
type ddlb_plant from dropdownlistbox within w_production_grid
end type
type sle_order from singlelineedit within w_production_grid
end type
type dw_vendors from datawindow within w_production_grid
end type
type dw_demand_per_part from datawindow within w_production_grid
end type
type dw_list_parts from datawindow within w_production_grid
end type
type dw_check_router from datawindow within w_production_grid
end type
type dw_stack from datawindow within w_production_grid
end type
type dw_part_mfg from datawindow within w_production_grid
end type
type dw_workorder_detail from datawindow within w_production_grid
end type
type dw_part_info from datawindow within w_production_grid
end type
type dw_product_line from datawindow within w_production_grid
end type
type ddlb_type from dropdownlistbox within w_production_grid
end type
type st_label from statictext within w_production_grid
end type
type dw_machine_list_for_part from datawindow within w_production_grid
end type
type rb_7 from radiobutton within w_production_grid
end type
type rb_6 from radiobutton within w_production_grid
end type
type rb_5 from radiobutton within w_production_grid
end type
type rb_4 from radiobutton within w_production_grid
end type
type rb_3 from radiobutton within w_production_grid
end type
type rb_2 from radiobutton within w_production_grid
end type
type rb_1 from radiobutton within w_production_grid
end type
type dw_list_parts_bom from datawindow within w_production_grid
end type
type dw_bom from datawindow within w_production_grid
end type
type dw_machine_process from datawindow within w_production_grid
end type
type dw_mps_in_work_order from datawindow within w_production_grid
end type
type dw_work_detail from datawindow within w_production_grid
end type
type dw_process_info from datawindow within w_production_grid
end type
type dw_current_demand from datawindow within w_production_grid
end type
type cbx_daily from checkbox within w_production_grid
end type
type dw_process_id from datawindow within w_production_grid
end type
type dw_part_online_info from datawindow within w_production_grid
end type
type cbx_time from checkbox within w_production_grid
end type
type cbx_onhand from checkbox within w_production_grid
end type
type dw_machine_list from datawindow within w_production_grid
end type
type st_name1 from statictext within w_production_grid
end type
type st_name7 from statictext within w_production_grid
end type
type st_name6 from statictext within w_production_grid
end type
type st_name5 from statictext within w_production_grid
end type
type st_name4 from statictext within w_production_grid
end type
type st_name3 from statictext within w_production_grid
end type
type st_name2 from statictext within w_production_grid
end type
type st_9 from statictext within w_production_grid
end type
type st_8 from statictext within w_production_grid
end type
type st_7 from statictext within w_production_grid
end type
type st_6 from statictext within w_production_grid
end type
type st_5 from statictext within w_production_grid
end type
type st_4 from statictext within w_production_grid
end type
type st_3 from statictext within w_production_grid
end type
type st_2 from statictext within w_production_grid
end type
type dw_demand from datawindow within w_production_grid
end type
type ddlb_type_value from dropdownlistbox within w_production_grid
end type
type dw_crosstab from datawindow within w_production_grid
end type
type dw_machine_load from datawindow within w_production_grid
end type
type dw_unscheduled_mps from datawindow within w_production_grid
end type
type st_drag from statictext within w_production_grid
end type
end forward

global type w_production_grid from Window
int X=0
int Y=0
int Width=2926
int Height=1920
boolean TitleBar=true
string Title="Global Production Schedule (Weekly)"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean Resizable=true
WindowState WindowState=maximized!
event rebuild_crosstab pbm_custom01
event create_new_job pbm_custom02
event build_new_job pbm_custom03
event build_crosstab_row pbm_custom04
event view_calendar pbm_custom05
ddlb_plant ddlb_plant
sle_order sle_order
dw_vendors dw_vendors
dw_demand_per_part dw_demand_per_part
dw_list_parts dw_list_parts
dw_check_router dw_check_router
dw_stack dw_stack
dw_part_mfg dw_part_mfg
dw_workorder_detail dw_workorder_detail
dw_part_info dw_part_info
dw_product_line dw_product_line
ddlb_type ddlb_type
st_label st_label
dw_machine_list_for_part dw_machine_list_for_part
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_list_parts_bom dw_list_parts_bom
dw_bom dw_bom
dw_machine_process dw_machine_process
dw_mps_in_work_order dw_mps_in_work_order
dw_work_detail dw_work_detail
dw_process_info dw_process_info
dw_current_demand dw_current_demand
cbx_daily cbx_daily
dw_process_id dw_process_id
dw_part_online_info dw_part_online_info
cbx_time cbx_time
cbx_onhand cbx_onhand
dw_machine_list dw_machine_list
st_name1 st_name1
st_name7 st_name7
st_name6 st_name6
st_name5 st_name5
st_name4 st_name4
st_name3 st_name3
st_name2 st_name2
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
dw_demand dw_demand
ddlb_type_value ddlb_type_value
dw_crosstab dw_crosstab
dw_machine_load dw_machine_load
dw_unscheduled_mps dw_unscheduled_mps
st_drag st_drag
end type
global w_production_grid w_production_grid

type variables
Boolean bCancel           //Whether cancel the operation
Boolean bWorkOrder      //Dragdrop from work order
Boolean bCrossTab        //Dragdrop from Crosstab
Boolean bOutside           //Outside process
Boolean bCalendar         //Calendar

Decimal nQty                //Quantity
Decimal nCrossTabQtyLeft
Decimal nAccumQty        //Qty accumlated up to current column
Decimal nAccumRuntime //Runtime accumlated up to current column
Decimal nQtyPastDue
Decimal nQty1
Decimal nQty2
Decimal nQty3
Decimal nQty4
Decimal nQty5
Decimal nQty6

String     szPart              //Part number
String     szDestination    //Destination
String     szMachine        //Machine
String     szWorkOrder     //Work Order
String     szProcessId      //Process Id

Long      iCrossTabCol    //Crosstable col
Long      iCrossTabRow  //Crosstable row
Long      iWorkOrderCol  //Work order col
Long      iWorkOrderRow //Work order row
Long      iMaxMachineNo = 7 //Machine number
Long      iMachineCount  //Machine count number
Long      iLastCol            //Last col clicked in crosstab
Long      iLastRow           //Last row clicked in crosstab

Date      dDate1, dDate2, dDate3, dDate4, dDate5
Date      dDate6, dDate7 // Date1~7: Dates shown
Date      dBeginDate      //Begin date for demand retrieve
Date      dEndDate         //End date for demand retrieve

RadioButton MachineList[7]

Long      iGreenColor      //Green color

Integer   iSelection = 1   

st_generic_structure stParm
end variables

forward prototypes
public function date next_day (date today)
public subroutine display_dates ()
public function date get_date (int icol)
public subroutine calculate_time ()
public subroutine assigne_sequence ()
public subroutine calculate_bom_net_out ()
public subroutine initialize_machines ()
public subroutine display_related_machines (string szpart)
public subroutine dragdrop_to_machine ()
public function int get_earliest_machine ()
public subroutine build_product_line_dropdown ()
public subroutine build_new_job (long ilastrow, long ilastcol)
public subroutine build_workorder_detail (string szorder, string szpart, decimal nqty)
public subroutine delete_workorder_detail (string szworkorder)
public subroutine undo_mps_in_workorder (string szworkorder)
public subroutine wf_get_finished_parts ()
public subroutine wf_get_activities ()
public subroutine update_bom_net_out_new ()
public subroutine updt_qty_in_components_new (string szparentpart, decimal nparentqty)
public subroutine erase_all_bom_net_out_new ()
public subroutine create_crosstab_new (date ddate)
public subroutine wf_recalc_crosstab_row (string szpart, date ddate)
public subroutine wf_display_vendors (string szpart)
public subroutine wf_update_qty_assigned (string szPart, date dDate, string szWorkOrder)
public function decimal wf_qty_in_workorder_detail (string szpart)
public subroutine wf_rebuild_crosstab ()
public function decimal wf_parts_per_hour (string szpart)
public function decimal wf_parts_per_cycle (string szpart)
end prototypes

on rebuild_crosstab;If cbx_daily.checked then
	st_name2.visible = TRUE
	st_name3.visible = TRUE
	st_name4.visible = TRUE
	st_name5.visible = TRUE
	st_name6.visible = TRUE
	st_name7.visible = TRUE
Else
	st_name2.visible = FALSE
	st_name3.visible = FALSE
	st_name4.visible = FALSE
	st_name5.visible = FALSE
	st_name6.visible = FALSE
	st_name7.visible = FALSE
End If	

display_dates()				//Display the new dates
Create_crosstab_new(dDate7)//Build cross tab
end on

on build_new_job;build_new_job(iLastRow, iLastCol)
end on

on build_crosstab_row;wf_recalc_crosstab_row(szPart, dDate7)
end on

on view_calendar;bFinish		= FALSE
bCalendar	= TRUE
Timer(1)

OpenWithParm(w_view_calendar, String(dDate1))
end on

public function date next_day (date today);Integer iMonth				//Number of month
Integer iYear				//Number of year
Integer iDay				//Number of day
Integer iDaysInMonth		//Total days in month

iDay   = day(today)
iMonth = month(today)
iYear  = year(today)

If cbx_daily.checked then
	iDay = iDay + 1			//Daily
Else
	iDay    = iDay + 7		//Weekly
End If

If iDay > days_in_month(iMonth, iYear) then
	iDay = iDay - days_in_month(iMonth, iYear) 
	If iMonth = 12 then
		iMonth = 1
		iYear  = iYear + 1
	Else
		iMonth = iMonth + 1
	End If
End If

Return Date(iYear, iMonth, iDay) 




end function

public subroutine display_dates ();dDate2 = next_day(dDate1)
dDate3 = next_day(dDate2)
dDate4 = next_day(dDate3)
dDate5 = next_day(dDate4)
dDate6 = next_day(dDate5)
dDate7 = next_day(dDate6)

st_3.text = string (dDate1)
st_4.text = string (dDate2)
st_5.text = string (dDate3)
st_6.text = string (dDate4)
st_7.text = string (dDate5)
st_8.text = string (dDate6)
st_9.text = string (dDate7)

st_name1.text =LeftA( DayName(dDate1), 3)
st_name2.text =LeftA( DayName(dDate2), 3)
st_name3.text =LeftA( DayName(dDate3), 3)
st_name4.text =LeftA( DayName(dDate4), 3)
st_name5.text =LeftA( DayName(dDate5), 3)
st_name6.text =LeftA( DayName(dDate6), 3)
st_name7.text =LeftA( DayName(dDate7), 3)



end subroutine

public function date get_date (int icol);If iCol = 2 then
	Return dDate1
End If

If iCol = 3 then
	Return dDate2
End If

If iCol = 4 then
	Return dDate3
End If

If iCol = 5 then
	Return dDate4
End If

If iCol = 6 then
	Return dDate5
End If

If iCol = 7 then
	Return dDate6
End If

If iCol = 8 then
	Return dDate7
End If

If iCol = 9 then
	Return RelativeDate(dDate7 , 7 )
End if



end function

public subroutine calculate_time ();Long iRow

Str_progress  sparm

sparm.Title = "Calculating Job Execution Time"

//OpenWithParm(w_progress, sparm)
//w_progress.wf_progress(1, "Calculating Job Execution Time For Machine " +szMachine)
OpenWithParm(w_calculate_job_time, szMachine)

//Close(w_progress)

////********************************************************************
////* Declaration
////********************************************************************
//
//Int  iRow            //Current row
//Int  iDetailItemRow
//
//String szModString
//String szWorkOrder
//String szProcessId
//
//Date dStartDate      //Start date
//Date dEndDate        //End date
//Date dDueDate        //Due date
//
//Time tStartTime      //Start time
//Time tEndTime        //End time
//
//Integer iStartDate   //Start date
//Integer iStartMon    //Start month
//Integer iStartYear   //Start year
//Integer iEndDate     //End   date
//Integer iEndMon      //End   month
//Integer iEndYear     //End   year
//Integer iStartHr     //Start Hour
//Integer iStartMin    //Start Minute
//Integer iStartSec    //Start Second
//Integer iEndHr       //End Hour
//Integer iEndMin      //End Min
//Integer iEndSec      //End Second
//Integer iTemp        //Temporay buffer
//
//Dec    rRunTime
//Dec    rTemp
//Dec    rQnty
//
////********************************************************************
////* Main Routine
////********************************************************************
//
//dStartDate  = Today ()
//tStartTime  = Now ()
//
//For iRow = 1 TO dw_machine_load.RowCount ()
//
//	szWorkOrder = dw_machine_load.GetItemString(iRow, "work_order")
//	rRunTime = dw_machine_load.GetItemNumber(iRow, "Runtime")
//	dw_machine_load.SetItem(iRow, "Start_date", dStartDate)
//	dw_machine_load.SetItem(iRow, "Start_time", tStartTime)		
//
//	iStartDate  = Day(dStartDate)
//	iStartMon   = Month(dStartDate)
//	iStartYear  = Year(dStartDate)
//	
//	iStartHr    = Hour(tStartTime)
//	iStartMin   = Minute(tStartTime)
//	iStartSec   = Second(tStartTime)
//
//	iEndDate = iStartDate + ( (iStartHr+rRunTime) / 24 )
//	iTemp    = Truncate( ((iStartHr+rRunTime) / 24), 0)
//	iTemp    = iTemp * 24
//	
//	iEndHr   = (iStartHr + rRunTime) - iTemp
//    
//	iTemp    = rRunTime
//
//	iEndMin  = iStartMin  + ((rRunTime - iTemp) * 60)
//
//	iEndSec  = iStartSec
//
//	If iEndMin >= 60 Then
//		iEndHr  = iEndHr  + 1
//		iEndMin = iEndMin - 60
//	End If
//
//	If iEndHr  >= 24 Then
//		iEndDate = iEndDate + 1
//		iEndHr   = iEndHr   - 24 
//	End If
//
//	iEndMon  = iStartMon
//	iEndYear	= iStartYear
//
//	
//	If iEndDate > days_in_month(iEndMon, iEndYear) then
//		iEndDate = iEndDate - days_in_month(iEndMon, iEndYear)
//		iEndMon  = iEndMon + 1
//	End If
//
//	If iEndMon > 12 then
//		iEndMon = iEndMon - 12
//		iEndYear = iEndYear + 1
//	End If
//
//	dEndDate = Date (iEndYear, iEndMon, iEndDate)
//	tEndTime = Time (iEndHr,   iEndMin, iEndSec )
//
//	dw_machine_load.SetItem(iRow, "start_date", dStartDate)
//	dw_machine_load.SetItem(iRow, "start_time", tStartTime)
//	dw_machine_load.SetItem(iRow, "end_date"  , dEndDate  )
//	dw_machine_load.SetItem(iRow, "end_time"  , tEndTime  )
//
//	dStartDate = dEndDate
//	tStartTime = tEndTime
//
//	dDueDate   = dw_machine_load.GetItemDate(iRow, "due_date") 
//
//	dw_machine_load.Modify('sequence.color = tif (dEndDate > dDueDate, "215", "550")')
//
//Next
//
//
//If dw_machine_load.Update() > 0 Then
//	Commit;
//Else
//	RollBack;
//End If

end subroutine

public subroutine assigne_sequence ();Int iCurrentRow

FOR iCurrentRow=1 TO dw_machine_load.RowCount()
	dw_machine_load.SetItem(iCurrentRow, "Sequence", iCurrentRow)
NEXT

If dw_machine_load.Update() > 0 Then
	Commit;
Else
	RollBack;
End If

calculate_time()

dw_machine_load.Retrieve(szMachine)

Return 
end subroutine

public subroutine calculate_bom_net_out ();
end subroutine

public subroutine initialize_machines ();MachineList[1]	= rb_1
MachineList[2]	= rb_2
MachineList[3]	= rb_3
MachineList[4]	= rb_4
MachineList[5]	= rb_5
MachineList[6]	= rb_6
MachineList[7]	= rb_7


end subroutine

public subroutine display_related_machines (string szpart);Integer iCount
Integer iBest
Integer iTotalMachines

For iCount = 1 to iMaxMachineNo
	MachineList[iCount].visible 	= FALSE
	MachineList[iCount].enabled	= FALSE
Next

dw_machine_list_for_part.Retrieve(szpart)
dw_machine_list_for_part.SetSort("sequence a")
dw_machine_list_for_part.Sort()

iTotalMachines	= dw_machine_list_for_part.RowCount()

For iCount = 1 to iTotalMachines
	MachineList[iCount].text 		= dw_machine_list_for_part.GetItemString(iCount, "machine")
	MachineList[iCount].visible 	= TRUE
	MachineList[iCount].enabled	= TRUE
	If iCount >= iMaxMachineNo then
		iCount	= iTotalMachines + 1
	End If
Next

iBest = get_earliest_machine()			//Select the best machine 

For iCount = 1 to iMaxMachineNo
	If iCount <> iBest then
		MachineList[iCount].textcolor = 0
	Else
		MachineList[iCount].textcolor = iGreenColor
	End If
Next 
		
end subroutine

public subroutine dragdrop_to_machine ();If bCrossTab then
	//If bOutSide then		//If this is outside process
	//	OpenWithParm(w_create_outside_shipper, szMachine)
	//Else
		Open(w_prompt_for_total_qty_in_schedule_ver2)
	//End If
	bCrossTab = FALSE
End If


end subroutine

public function int get_earliest_machine ();Integer iCount
Integer iBestMachineNo
Integer iLastRow

Date    dEndDate
Date    dLastDate

Time    tTime
Time    tLastTime

dEndDate	= Date("12/31/2999")
tTime		= Now()

iBestMachineNo = 0

For iCount = 1 to iMaxMachineNo
	If MachineList[iCount].visible then
		dw_machine_load.Retrieve(MachineList[iCount].text)
		If dw_machine_load.RowCount() > 0 then
			iLastRow		= dw_machine_load.RowCount()
			tLastTime	= dw_machine_load.GetItemTime(iLastRow, "end_time")
			dLastDate	= dw_machine_load.GetItemDate(iLastRow, "end_date")

			If dLastDate < dEndDate then
				dEndDate	= dLastDate
				tTime		= tLastTime
				iBestMachineNo = iCount
			Else
				If dEndDate = dLastDate then
					If tLastTime < tTime then
						tTime		= tLastTime							 				
						iBestMachineNo	= iCount
					End If
				End If
			End If
		Else
			dEndDate	= Today()
			tTime		= Now()
			iBestMachineNo = iCount
		End If
	End If

Next			 


Return iBestMachineNo
end function

public subroutine build_product_line_dropdown ();Long iCount

ddlb_type_value.Reset()

For iCount = 1 to dw_product_line.RowCount()
	ddlb_type_value.AddItem(dw_product_line.GetItemString(iCount, "id"))
Next


	
end subroutine

public subroutine build_new_job (long ilastrow, long ilastcol);//************************************************************************
//* Declaration
//************************************************************************
Long iRow         //Current row number
Long iProcessRow  //Row in the part/process datawindow
Long iWorkOrder   //Work ordeer
Long iNewRow      //New row number
Long iRtn         //Returned value from system function
Long iRed         //Red color
Long iGreen       //Green color
Long iCycle_Time  //Cycle time
Long iCycle_Unit  //Cycle unit
Long iCount			//Count number

Dec nTemp          //Temporary variable
Dec nRunTime       //Run Time
Dec nQtyLeft       //Qty left to be scheduled
Dec nCurrentQty    //Current qty
Dec nCurrentAssign //Current assign
Dec nPartsPerHour  //parts per cycle

String szProcessId
String szCurrentJob

//***********************************************************************
//* Main routine
//***********************************************************************
//-----------------------------------------------------------------------
// Get new work order from parameter file 
//-----------------------------------------------------------------------
Select parameters.next_serial  
Into :iWorkOrder  
From parameters  ;

Update parameters  
Set next_serial = next_serial + 1  ;

//------------------------------------------------------------------------
// Get process id 
//------------------------------------------------------------------------

dw_process_id.Retrieve(szPart)  						//Locate the part
If dw_process_id.RowCount() > 0 Then            //Assign the process ID 
	szProcessId = dw_process_id.GetItemString(1,"Process_Id")
End If

dw_process_id.Retrieve(szProcessId)
If dw_process_id.RowCount() > 0 then
	iCycle_unit = dw_process_id.GetItemNumber(1, "cycle_unit")
	iCycle_time = dw_process_id.GetItemNumber(1, "cycle_time")
Else
	szProcessId	= "NONE"
End If

//-----------------------------------------------------------------------
// Create work order header information
//-----------------------------------------------------------------------
dw_machine_load.SelectRow(0,FALSE)                     
iNewRow = 1 + dw_machine_load.RowCount()
	
dw_machine_load.InsertRow(iNewRow)
dw_machine_load.SelectRow(iNewRow,TRUE)

dw_machine_load.SetItem(iNewRow,"Sequence"   , iNewRow)
dw_machine_load.SetItem(iNewRow,"Work_Order" , String(iWorkOrder))
//dw_machine_load.SetItem(iNewRow,"Due_Date" , dw_3.GetItemDate(iRow,"Due"))

dw_part_mfg.Retrieve(szPart)
If dw_part_mfg.RowCount() > 0 then
	nPartsPerHour	= dw_part_mfg.GetItemNumber(1, "parts_per_hour")
Else
	nPartsPerHour	= 10
End If

dw_machine_load.SetItem(iNewRow,"RunTime"    , nAccumQty / nPartsPerHour)
dw_machine_load.SetItem(iNewRow,"Machine_No" , szMachine)
dw_machine_load.SetItem(iNewRow,"Process_Id" , szProcessId)
dw_machine_load.SetItem(iNewRow,"cycle_time" , (iCycle_time * iCycle_unit))

iRtn = dw_machine_load.Update()
If iRtn = 1 Then
	Commit;

	dw_unscheduled_mps.Retrieve(szPart, Date("1/23/1963"), dEndDate) //Update qty assigned
	nQtyLeft = nQty

	For iRow = 1 to dw_unscheduled_mps.RowCount()

		szCurrentJob	= dw_unscheduled_mps.GetItemString(iRow, "job")

		If Trim(szCurrentJob) = "" then
			nCurrentQty    = dw_unscheduled_mps.GetItemNumber(iRow, "qnty")
			dw_unscheduled_mps.SetItem(iRow, "qty_assigned", nCurrentQty)
			dw_unscheduled_mps.SetItem(iRow, "job", String(iWorkOrder))

			If dw_unscheduled_mps.Update() > 0 then
				Commit;
			Else
				Rollback;
				MessageBox ("Database Error", "Can not save data in [w_mps2]", Exclamation!)
			End If
		End If				 		

	Next 

	For iCount = 2 to iLastCol
		If Not (IsNull(dw_crosstab.GetItemNumber(iLastRow, iCount))) then
			dw_crosstab.SetItem(iLastRow, iCount, 0)
		End If
	Next

	Build_workorder_detail(String(iWorkOrder), szPart, nAccumQty)
	assigne_sequence()
	dw_machine_load.retrieve( szMachine )
	
Else
	RollBack;
End If






end subroutine

public subroutine build_workorder_detail (string szorder, string szpart, decimal nqty);Long iRow					//Current row 

Boolean bFound				//Whether the part exists

Decimal nDetailQty		//Qty in work order detail line
Decimal nPartsPerHour	//Parts per hour
Decimal nPartsPerCycle	//Parts per cycle
Decimal nRunTime			//Runtime for job detail
Decimal nJobRunTime		//Job runtime 
Decimal nQtyLeft			//Quantity left

iRow			= 1
nDetailQty	= 0

dw_workorder_detail.Retrieve(szOrder)

Do while ( iRow <= dw_workorder_detail.RowCount()) AND (Not bFound)
	If dw_workorder_detail.GetItemString(iRow, "part") = szPart then
		bFound		= TRUE
		nDetailQty	= dw_workorder_detail.GetItemNumber(iRow, "qty_required")
	Else
		iRow	= iRow + 1
	End If
Loop

If bFound then
	dw_workorder_detail.SetItem(iRow, "qty_required", nDetailQty + nQty)
	nQtyLeft	= nDetailQty + nQty - f_get_value(dw_workorder_detail.GetItemNumber(iRow, "qty_completed"))
Else
	dw_workorder_detail.InsertRow(1)
	iRow	= 1
	dw_workorder_detail.SetItem(iRow, "workorder", szOrder)
	dw_workorder_detail.SetItem(iRow, "part", szPart)
	dw_workorder_detail.SetItem(iRow, "qty_required", nQty)
	dw_workorder_detail.SetItem(iRow, "qty_completed", 0)
	nQtyLeft	= nQty
End If

nPartsPerHour	= wf_parts_per_hour(szPart)
If nPartsPerHour > 0 then
	nRunTime		= nQtyLeft / nPartsPerHour
Else
	nRunTime		= 0		
End If	

nPartsPerCycle	= wf_parts_per_cycle(szPart)

dw_workorder_detail.SetItem(iRow, "parts_per_cycle", nPartsPerCycle)
dw_workorder_detail.SetItem(iRow, "run_time", nRunTime)
dw_workorder_detail.SetItem(iRow, "parts_per_hour", nPartsPerHour)
//If nRunTime > nJobRunTime then
//	nJobRunTime	= nRunTime
//End If

If dw_workorder_detail.Update() > 0 then
	Commit;
Else
	Rollback;
End If
			
end subroutine

public subroutine delete_workorder_detail (string szworkorder);Long 		iRow
Long		iCount

String	szPart
String	szPartList[]

dw_workorder_detail.Retrieve(szWorkOrder)

iCount	= 0
For iRow = 1 to dw_workorder_detail.RowCount()

	iCount ++
	szPart	= dw_workorder_detail.GetItemString(iRow, "part")
	szPartList[iCount]	= szPart
	
Next

DELETE FROM workorder_detail  
WHERE workorder = :szWorkOrder;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;

	For iRow = 1 to iCount
		stParm.value1	= szPartList[iRow]
		stParm.value3	= "M"
//		OpenWithParm(w_calculate_assigned_qty_in_mps, stParm)	//Recalc quantity
      f_update_qty_asgnd_part ( szPartList[iRow] ) // new fn. by mams sp based 		
		wf_recalc_crosstab_row(szPart, dDate7)
	Next

End If
	
	



end subroutine

public subroutine undo_mps_in_workorder (string szworkorder);Long iRow

dw_mps_in_work_order.Retrieve(szWorkOrder)

For iRow = 1 to dw_mps_in_work_order.RowCount()
	dw_mps_in_work_order.SetItem(iRow, "qty_assigned", 0)
	dw_mps_in_work_order.SetItem(iRow, "workorder", " ")
Next

If dw_mps_in_work_order.Update() > 0 then
	Commit;
	//Create_crosstab_new(dDate7)
Else
	Rollback;
End If
end subroutine

public subroutine wf_get_finished_parts ();String szCurrentPart
String szType

ddlb_type_value.Reset()

Declare PartCur Cursor for Select Part, Type From Part Using sqlca;

Open PartCur;

Fetch PartCur into :szCurrentPart, :szType;

Do while sqlca.sqlcode = 0
	If szType  = "F" then
		ddlb_type_value.AddItem(szCurrentPart)
	End If
	Fetch PartCur into :szCurrentPart, :szType;
Loop

Close PartCur;

	
end subroutine

public subroutine wf_get_activities ();String szCurrentActivity

ddlb_type_value.Reset()

Declare ActivityCur Cursor for Select Code From Activity_codes Using sqlca;

Open ActivityCur;

Fetch ActivityCur into :szCurrentActivity;

Do while sqlca.sqlcode = 0
	ddlb_type_value.AddItem(szCurrentActivity)
	Fetch ActivityCur into :szCurrentActivity;
Loop

Close ActivityCur;

	
end subroutine

public subroutine update_bom_net_out_new ();Long    iRow				//Row for the parent part list
Long    iComponentRow	//Row for the component part list

String  szPart				//Parent part number
String  szComponentPart //Component part number
String  szMicroHelp		//Micro Help

Decimal nParentQty
Decimal nComponentQty
Decimal nOnHandQty		

For iRow	= 1 to dw_crosstab.RowCount()

	szPart		= dw_crosstab.GetItemString(iRow, "part")
	dw_part_online_info.Retrieve(szPart)

	If dw_part_online_info.RowCount() > 0 then

		nOnHandQty	= dw_part_online_info.GetItemNumber(1, "on_hand")
		dw_list_parts.SetFilter("part='" + szPart + "'")
		dw_list_parts.Filter()
	
		nParentQty	= nOnHandQty

		If dw_list_parts.RowCount() > 0 then
			nParentQty	= dw_list_parts.GetItemNumber(1, "bom_net_out") + nOnHandQty
			dw_list_parts.SetItem(1, "bom_net_out", nParentQty)
		End If

	Else
		nParentQty	= 0
	End If

	szMicroHelp = "Net out qty for parent part:" + Trim(szPart)
	w_production_grid.SetMicroHelp(szMicroHelp)

	updt_qty_in_components_new(szPart, nOnHandQty)
	
Next 

	
	







end subroutine

public subroutine updt_qty_in_components_new (string szparentpart, decimal nparentqty);//************************************************************************
//* Declaration
//************************************************************************
Long iMaxLoop				//Max Estimated loop number for checking infinite loop
Long iComponentRow		//Current row in component list
Long iStackRow				//Current row in stack datawindow
Long iRow					//Row number

Decimal nComponentQty	//Current component qty
Decimal nOrigQty			//Keep the original qty

String szComponentPart	//Name of component
String szMicroHelp
String szPart				//Current part number
String szTopPart			//

//************************************************************************
//* Initialization
//************************************************************************

iMaxLoop		= 50
iStackRow	= 0

szTopPart	= szParentPart
//************************************************************************
//* Main Route
//************************************************************************

dw_stack.Reset()
dw_stack.InsertRow(1)	
dw_stack.SetItem(1, "part", szParentPart)
dw_stack.SetItem(1, "quantity", nParentQty)

Do while (dw_stack.RowCount() > 0) AND (iStackRow <= iMaxLoop)

	iStackRow	= iStackRow + 1
	szPart		= dw_stack.GetItemString(1, "part")
	nParentQty	= dw_stack.GetItemNumber(1, "quantity")
	dw_stack.DeleteRow(1)

	dw_bom.Retrieve(szPart)
		
	For iComponentRow = 1 to dw_bom.RowCount()

		szComponentPart	= dw_bom.GetItemString(iComponentRow, "part")
		nComponentQty		= dw_bom.GetItemNumber(iComponentRow, "quantity")

		dw_list_parts.SetFilter("part='" + szComponentPart + "'")
		dw_list_parts.Filter()

		If dw_list_parts.RowCount() > 0 then

			nOrigQty			= dw_list_parts.GetItemNumber(1, "bom_net_out")		
			szMicroHelp		= szMicroHelp + " / Component:" + szComponentPart
			w_production_grid.SetMicroHelp(szMicroHelp)

			dw_stack.InsertRow(1)
			dw_stack.SetItem(1, "part", szComponentPart)
			dw_stack.SetItem(1, "quantity", nComponentQty * nParentQty)

			nComponentQty	= (nComponentQty * nParentQty) + nOrigQty

			dw_list_parts.SetItem(1, "bom_net_out", nComponentQty)

		End If
	Next 	
Loop

If (iStackRow > iMaxLoop) then
	MessageBox("Warning", "There might be an infinite loop in the bill of part:" + szTopPart, StopSign!)
End If	

w_production_grid.SetMicroHelp(" ")	
end subroutine

public subroutine erase_all_bom_net_out_new ();Long iRow

dw_list_parts.Reset()

For iRow = 1 to dw_list_parts_bom.RowCount()
	dw_list_parts.InsertRow(1)
	dw_list_parts.SetItem(1, "part", dw_list_parts_bom.GetItemString(iRow, "part"))
	dw_list_parts.SetItem(1, "bom_net_out", 0)
Next


end subroutine

public subroutine create_crosstab_new (date ddate);//***********************************************************************
//* Declaration
//***********************************************************************
Str_progress  sparm

Integer iRow			//Current row# for dw_demand
Integer iCrossTabRow	//Current row# for dw_crosstab
Integer iCrossTabCol //Current col# for dw_crosstab
Integer iTotalRows  	//Total rows in dw_demand
Integer iDays			//The difference between current date and selected date

Boolean bCreateNew   //Whether to create new row
Boolean bProcess		//Whether to process
    
String  szPart			//Part currently read
String  szPrevPart	//Previous part read
String  szType			//The type of the part
String  szActivity	//Type activity code for the part	

Decimal nQty			//Current demand
Decimal nAssigned    //Qty assigned
Decimal nOnHand		//Qty on hand

//***********************************************************************
//* Initialization
//***********************************************************************

sparm.Title = "Searching/Filtering Demands"

OpenWithParm(w_progress, sparm)
w_progress.cb_cancel.visible	= FALSE

dw_crosstab.Reset()
iCrossTabRow = 0

//***********************************************************************
//* Main Routine
//***********************************************************************

Choose Case iSelection
	Case 1	//All parts
		dw_demand.DataObject	= "dw_demand"
		dw_demand.SetTransObject(sqlca)
		dw_demand.Retrieve(dDate)	

	Case 2	// Product Line
		dw_demand.DataObject	= "dw_demand_per_product_line"
		dw_demand.SetTransObject(sqlca)
		dw_demand.Retrieve(dDate, ddlb_type_value.text)
	
	Case 3	// Flow Router
		dw_demand.DataObject	= "dw_demand_per_top_flow_part"
		dw_demand.SetTransObject(sqlca)
		dw_demand.Retrieve(dDate, ddlb_type_value.text)

	Case 4	// Finished Part
		dw_demand.DataObject	= "dw_demand_per_finished_part"
		dw_demand.SetTransObject(sqlca)
		dw_demand.Retrieve(dDate)	

	Case 5	// Activity
		dw_demand.DataObject	= "dw_demand_per_activity"
		dw_demand.SetTransObject(sqlca)
		dw_demand.Retrieve(dDate, ddlb_type_value.text)

	Case 6   // Sales Order
		dw_demand.DataObject	= "dw_demand_per_sales_order"
		dw_demand.SetTransObject(sqlca)
		dw_demand.Retrieve(sle_order.text, dDate)


End Choose



iTotalRows = dw_demand.RowCount()

For iRow = 1 to iTotalRows

	szPart		= dw_demand.GetItemString(iRow, "part")
	bCreateNew 	= FALSE
	bProcess		= TRUE

	//--------------------------------------------------------------------
	// Only first time or encouting a big part number then we create a new
	// new row
	//--------------------------------------------------------------------
	If iCrossTabRow = 0 then		//First time
		bCreateNew = TRUE
	else		
		If szPart > dw_crosstab.GetItemString(iCrossTabRow,1) then //Bigger part no
			bCreateNew = TRUE
		End If
	End If

	If bCreateNew then

		w_progress.wf_progress(iRow  / iTotalRows, "Part Number:" + szPart)

		If bProcess then
			dw_crosstab.InsertRow(0)
			iCrossTabRow = iCrossTabRow + 1
			dw_crosstab.SetItem(iCrossTabRow, 1, szPart)

			If cbx_onhand.Checked then	//If net out onhand
				If bCreateNew then
					dw_list_parts.SetFilter("part='" + szPart + "'")
					dw_list_parts.Filter()
					If dw_list_parts.RowCount() > 0 then
						//dw_list_parts.SetRow(1)
						//dw_list_parts.SetColumn("bom_net_out")
						//nOnHand	= Dec(dw_list_parts.GetText())
						nOnHand	= dw_list_parts.GetItemNumber(1, "bom_net_out")
					Else
						nOnHand = 0
					End If
				End If
			End If
		End If
	End If
	
	If bProcess then
		iDays = DaysAfter(dDate1, dw_demand.GetItemDate(iRow, "due"))
		If iDays < 0 then 	//Past due
			iCrossTabCol = 2
		Else
			If cbx_daily.checked then
				iCrossTabCol = 3 + Int(iDays)
			Else
				iCrossTabCol = 3 + Int(iDays/7)
			End If
		End If

		nQty      = f_get_value(dw_crosstab.GetItemNumber(iCrossTabRow, iCrossTabCol))
		nAssigned = dw_demand.GetItemNumber(iRow, "qty_assigned")

		If IsNull(nAssigned) then
			nAssigned = 0
		End If

		nQty      = nQty + dw_demand.GetItemNumber(iRow, "qnty") - nAssigned 

		If cbx_onhand.Checked  then
			If nQty >= nOnHand then
				nQty = nQty - nOnHand
				nAssigned 	= 0
				nOnHand 		= 0
			Else 
				nOnHand 	= nOnHand - nQty
				nQty		= 0		
			End If
		End If

		dw_crosstab.SetItem(iCrossTabRow, iCrossTabCol, Long(String(nQty))) 
	End If

	szPrevPart	= szPart

Next

If iTotalRows > 0 then
	w_progress.wf_progress(1,  "Part Number:" + szPart)
End If

Close(w_progress)
							
end subroutine

public subroutine wf_recalc_crosstab_row (string szpart, date ddate);//***********************************************************************
//* Declaration
//***********************************************************************
str_progress  sparm

Integer iRow			//Current row# for dw_demand
Integer iCol			//Current col# fro dw_demand
Integer iCrossTabRow	//Current row in the crosstab
Integer iCrossTabCol	//Current col in the crosstab
Integer iTotalRows  	//Total rows in dw_demand
Integer iDays			//The difference between current date and selected date

Boolean bCreateNew   //Whether to create new row
Boolean bProcess		//Whether to process
    
String  szPrevPart	//The previous part number	
String  szType			//The type of the part
String  szActivity	//Type activity code for the part	

Decimal nQty			//Current demand
Decimal nAssigned    //Qty assigned
Decimal nOnHand		//Qty on hand

//***********************************************************************
//* Initialization
//***********************************************************************

iCrossTabRow		= dw_crosstab.Find("part='" + szPart + "'", 1, 9999999)
If iCrossTabRow <= 0 then
	Return
End If

sparm.Title = "Searching/Filtering Demands"

OpenWithParm(w_progress, sparm)

SetNull(nQty)

For iCol = 2 to 8
	dw_crosstab.SetItem(iCrossTabRow, iCol, nQty)
Next

//***************************************************************************
//* Main Routine
//***********************************************************************

dw_demand_per_part.Retrieve(szPart, dDate)

iTotalRows = dw_demand_per_part.RowCount()

For iRow = 1 to iTotalRows

	bProcess		= TRUE
	bCreateNew	= FALSE

	If iRow = 1 then		//First time
		bCreateNew = TRUE
	End If

	w_progress.wf_progress(iRow  / iTotalRows, "Part Number:" + szPart)

	If bCreateNew then

		Choose Case ddlb_type.text

			Case "Product Line" 									//Selected Product Line
				If szPart <> szPrevPart then 					//Adding this line can speed up the system
					dw_part_info.Retrieve(szPart)
					If dw_part_info.RowCount() > 0 then		//Same product line
						bProcess	= (dw_part_info.GetItemString(1, "product_line") = ddlb_type_value.text)
					Else
						bProcess	= FALSE							//Part not found
					End If
				Else
					bProcess	= FALSE
				End If

			Case	"Flow Router" 									//Flow Router
				If szPart <> szPrevPart then 					//Adding this line can speed up the system
					dw_check_router.Retrieve(ddlb_type_value.text, szPart)
					bProcess	= (dw_check_router.RowCount() > 0)
				Else
					bProcess	= FALSE
				End If

			Case "Finished Part"
				Select part.type  
				Into :szType  
    			From part  
   			Where part.part = :szPart   ;

				bProcess	= (szType = "F")

			Case "Activity"
			  	Select part_mfg.activity  
		    	Into :szActivity  
    			From part_mfg  
   			Where part_mfg.part = :szPart   ;

				bProcess	= (szActivity = ddlb_type_value.text)				

		End Choose

		If bProcess then

			If cbx_onhand.Checked then	//If net out onhand
				If bCreateNew then
	
					If dw_list_parts.RowCount() > 0 then
						nOnHand	= dw_list_parts.GetItemNumber(1, "bom_net_out")
					Else
						nOnHand = 0
					End If
				End If
			End If
		End If
	End If
	
	If bProcess then
		iDays = DaysAfter(dDate1, dw_demand_per_part.GetItemDate(iRow, "due"))
		If iDays < 0 then 	//Past due
			iCrossTabCol = 2
		Else
			If cbx_daily.checked then
				iCrossTabCol = 3 + Int(iDays)
			Else
				iCrossTabCol = 3 + Int(iDays/7)
			End If
		End If

		nQty      = dw_crosstab.GetItemNumber(iCrossTabRow, iCrossTabCol)
		nAssigned = dw_demand_per_part.GetItemNumber(iRow, "qty_assigned")

		If IsNull(nAssigned) then
			nAssigned = 0
		End If

		nQty      = nQty + dw_demand_per_part.GetItemNumber(iRow, "qnty") - nAssigned 

		If cbx_onhand.Checked  then
			If nQty >= nOnHand then
				nQty = nQty - nOnHand
				nAssigned 	= 0
				nOnHand 		= 0
			Else 
				nOnHand 	= nOnHand - nQty
				nQty		= 0		
			End If
		End If

		If nQty > 0 then
			dw_crosstab.SetItem(iCrossTabRow, iCrossTabCol, Long(String(nQty))) 
		End If

	End If

	szPrevPart	= szPart

Next

Close(w_progress)
							
end subroutine

public subroutine wf_display_vendors (string szpart);Integer iCount
Integer iBest
Integer iTotalVendors

For iCount = 1 to iMaxMachineNo
	MachineList[iCount].visible = FALSE
Next

dw_vendors.Retrieve(szpart)
iTotalVendors	= dw_vendors.RowCount()

For iCount = 1 to iTotalVendors
	MachineList[iCount].text 		= dw_vendors.GetItemString(iCount, "vendor")
	MachineList[iCount].visible 	= TRUE
	If iCount >= iMaxMachineNo then
		iCount = iTotalVendors + 1
	End If			
Next


end subroutine

public subroutine wf_update_qty_assigned (string szPart, date dDate, string szWorkOrder);Long iRow
Decimal nQtyRequired

dw_demand_per_part.Retrieve(szPart, dDate)

For iRow = 1 to dw_demand_per_part.RowCount()
		nQtyRequired	= dw_demand_per_part.GetItemNumber(iRow, "qnty")
		dw_demand_per_part.SetItem(iRow, "qty_assigned", nQtyRequired)
		dw_demand_per_part.SetItem(iRow, "workorder", szWorkOrder)
Next

If dw_demand_per_part.Update() > 0 then
	Commit;
Else
	Rollback;
End If	
end subroutine

public function decimal wf_qty_in_workorder_detail (string szpart);Decimal nQty

  SELECT sum(workorder_detail.qty_required )  
    INTO :nQty  
    FROM workorder_detail  
   WHERE workorder_detail.part = :szPart   ;

Return f_get_value(nQty)
end function

public subroutine wf_rebuild_crosstab ();If cbx_daily.checked then
	st_name2.visible = TRUE
	st_name3.visible = TRUE
	st_name4.visible = TRUE
	st_name5.visible = TRUE
	st_name6.visible = TRUE
	st_name7.visible = TRUE
Else
	st_name2.visible = FALSE
	st_name3.visible = FALSE
	st_name4.visible = FALSE
	st_name5.visible = FALSE
	st_name6.visible = FALSE
	st_name7.visible = FALSE
End If	

display_dates()				//Display the new dates
Create_crosstab_new(dDate7)//Build cross tab
end subroutine

public function decimal wf_parts_per_hour (string szpart);Decimal nPartsPerHour

SELECT part_mfg.parts_per_hour  
  INTO :nPartsPerHour  
  FROM part_mfg  
 WHERE part_mfg.part = :szPart   ;

Return nPartsPerHour
end function

public function decimal wf_parts_per_cycle (string szpart);Decimal nPartsPerCycle

SELECT part_mfg.parts_per_cycle  
  INTO :nPartsPerCycle  
  FROM part_mfg  
 WHERE part_mfg.part = :szPart   ;

nPartsPerCycle	= f_get_value(nPartsPerCycle)

If nPartsPerCycle	= 0 then
	Return 1
Else
	Return nPartsPerCycle
End If
end function

on open;//*************************************************************************
//* Declaration
//************************************************************************

dw_demand.SetTransObject(sqlca)					//Demand for all part
dw_crosstab.SetTransObject(sqlca)				//Cross tab
dw_machine_list.SetTransObject(sqlca)			//List of all machines
dw_machine_load.SetTransObject(sqlca)			//All jobs in queue for the machine
dw_part_online_info.SetTransObject(sqlca)		//On hand qty for the part
dw_current_demand.SetTransObject(sqlca)		//Demand for the clicked col/row
dw_process_info.SetTransObject(sqlca)			//Get Cycle time from process
dw_process_id.SetTransObject(sqlca)				//Get Process Id from part
dw_machine_process.SetTransObject(sqlca)     //Get the machine/process releation table
dw_list_parts_bom.SetTransObject(sqlca)  		//List of all parts
dw_bom.SetTransObject(sqlca)						//List of all components in BOM
dw_machine_list_for_part.SetTransObject(sqlca) //List of all machines
dw_unscheduled_mps.SetTransObject(sqlca)		//List of all unscheduled mps items
dw_product_line.SetTransObject(sqlca)			//List of product lines
dw_work_detail.SetTransObject(sqlca)			//Get the mps detail
dw_mps_in_work_order.SetTransObject(sqlca)	//List all mps in work order
dw_part_info.SetTransObject(sqlca)				//Retrieve product line from part
dw_workorder_detail.SetTransObject(sqlca)		//Retrieve detail info for work order
dw_part_mfg.SetTransObject(sqlca)				//Retrieve mfg information
dw_check_router.SetTransObject(sqlca)			//Check the flow router relation
dw_demand_per_part.SetTransObject(sqlca)		//Demand per part
dw_vendors.SetTransObject(sqlca)					//List of vendors 

//*****************************************************************************
//* Initialization
//************************************************************************

iGreenColor	= rb_1.textColor

ddlb_type.text	= "All Parts"						//Set display by "ALL PARTS"
dw_product_line.Retrieve()							//Get all product lines
//build_product_line_dropdown()					//Build product line

initialize_machines()								//Reset all machines
dw_list_parts_bom.Retrieve()						//Get all parts
dw_machine_list.Retrieve()							//Get all machines

dDate1 = today()
display_dates()										//Display all dates on screen

//Create_crosstab_new(dDate7)						//Build cross tab




gf_get_info ( 'w_production_grid', 0 )


end on

on activate;gnv_App.of_GetFrame().ChangeMenu(m_production_grid)
end on

on timer;If bCalendar then

	If bFinish then

		bCalendar	= FALSE
		If Not cbx_time.checked then
			Timer(0)
		End If

		If szReturnedString > " " then
			dDate1 = Date(szReturnedString)
			This.TriggerEvent("rebuild_crosstab")			
		End If
	End If
Else

	Calculate_time()
	Create_crosstab_new(dDate7)

End If
end on

on w_production_grid.create
this.ddlb_plant=create ddlb_plant
this.sle_order=create sle_order
this.dw_vendors=create dw_vendors
this.dw_demand_per_part=create dw_demand_per_part
this.dw_list_parts=create dw_list_parts
this.dw_check_router=create dw_check_router
this.dw_stack=create dw_stack
this.dw_part_mfg=create dw_part_mfg
this.dw_workorder_detail=create dw_workorder_detail
this.dw_part_info=create dw_part_info
this.dw_product_line=create dw_product_line
this.ddlb_type=create ddlb_type
this.st_label=create st_label
this.dw_machine_list_for_part=create dw_machine_list_for_part
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_list_parts_bom=create dw_list_parts_bom
this.dw_bom=create dw_bom
this.dw_machine_process=create dw_machine_process
this.dw_mps_in_work_order=create dw_mps_in_work_order
this.dw_work_detail=create dw_work_detail
this.dw_process_info=create dw_process_info
this.dw_current_demand=create dw_current_demand
this.cbx_daily=create cbx_daily
this.dw_process_id=create dw_process_id
this.dw_part_online_info=create dw_part_online_info
this.cbx_time=create cbx_time
this.cbx_onhand=create cbx_onhand
this.dw_machine_list=create dw_machine_list
this.st_name1=create st_name1
this.st_name7=create st_name7
this.st_name6=create st_name6
this.st_name5=create st_name5
this.st_name4=create st_name4
this.st_name3=create st_name3
this.st_name2=create st_name2
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_demand=create dw_demand
this.ddlb_type_value=create ddlb_type_value
this.dw_crosstab=create dw_crosstab
this.dw_machine_load=create dw_machine_load
this.dw_unscheduled_mps=create dw_unscheduled_mps
this.st_drag=create st_drag
this.Control[]={this.ddlb_plant,&
this.sle_order,&
this.dw_vendors,&
this.dw_demand_per_part,&
this.dw_list_parts,&
this.dw_check_router,&
this.dw_stack,&
this.dw_part_mfg,&
this.dw_workorder_detail,&
this.dw_part_info,&
this.dw_product_line,&
this.ddlb_type,&
this.st_label,&
this.dw_machine_list_for_part,&
this.rb_7,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.dw_list_parts_bom,&
this.dw_bom,&
this.dw_machine_process,&
this.dw_mps_in_work_order,&
this.dw_work_detail,&
this.dw_process_info,&
this.dw_current_demand,&
this.cbx_daily,&
this.dw_process_id,&
this.dw_part_online_info,&
this.cbx_time,&
this.cbx_onhand,&
this.dw_machine_list,&
this.st_name1,&
this.st_name7,&
this.st_name6,&
this.st_name5,&
this.st_name4,&
this.st_name3,&
this.st_name2,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_demand,&
this.ddlb_type_value,&
this.dw_crosstab,&
this.dw_machine_load,&
this.dw_unscheduled_mps,&
this.st_drag}
end on

on w_production_grid.destroy
destroy(this.ddlb_plant)
destroy(this.sle_order)
destroy(this.dw_vendors)
destroy(this.dw_demand_per_part)
destroy(this.dw_list_parts)
destroy(this.dw_check_router)
destroy(this.dw_stack)
destroy(this.dw_part_mfg)
destroy(this.dw_workorder_detail)
destroy(this.dw_part_info)
destroy(this.dw_product_line)
destroy(this.ddlb_type)
destroy(this.st_label)
destroy(this.dw_machine_list_for_part)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_list_parts_bom)
destroy(this.dw_bom)
destroy(this.dw_machine_process)
destroy(this.dw_mps_in_work_order)
destroy(this.dw_work_detail)
destroy(this.dw_process_info)
destroy(this.dw_current_demand)
destroy(this.cbx_daily)
destroy(this.dw_process_id)
destroy(this.dw_part_online_info)
destroy(this.cbx_time)
destroy(this.cbx_onhand)
destroy(this.dw_machine_list)
destroy(this.st_name1)
destroy(this.st_name7)
destroy(this.st_name6)
destroy(this.st_name5)
destroy(this.st_name4)
destroy(this.st_name3)
destroy(this.st_name2)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_demand)
destroy(this.ddlb_type_value)
destroy(this.dw_crosstab)
destroy(this.dw_machine_load)
destroy(this.dw_unscheduled_mps)
destroy(this.st_drag)
end on

type ddlb_plant from dropdownlistbox within w_production_grid
int X=457
int Y=16
int Width=347
int Height=400
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_order from singlelineedit within w_production_grid
int X=18
int Y=112
int Width=421
int Height=64
int TabOrder=180
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;Parent.TriggerEvent("rebuild_crosstab")
end on

type dw_vendors from datawindow within w_production_grid
int X=256
int Y=2080
int Width=256
int Height=352
int TabOrder=100
boolean Visible=false
string DataObject="dw_list_of_vendors_per_part"
boolean LiveScroll=true
end type

type dw_demand_per_part from datawindow within w_production_grid
int Y=2080
int Width=238
int Height=352
int TabOrder=90
boolean Visible=false
string DataObject="dw_demand_per_part"
boolean TitleBar=true
string Title="  "
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_list_parts from datawindow within w_production_grid
int X=2834
int Y=320
int Width=293
int Height=368
int TabOrder=160
boolean Visible=false
string DataObject="dw_external_part_bom_net"
boolean TitleBar=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type dw_check_router from datawindow within w_production_grid
int X=3922
int Y=1664
int Width=338
int Height=360
int TabOrder=280
boolean Visible=false
string DataObject="dw_check_router"
boolean LiveScroll=true
end type

type dw_stack from datawindow within w_production_grid
int X=2834
int Y=720
int Width=293
int Height=256
int TabOrder=240
boolean Visible=false
string DataObject="dw_external_stack"
boolean LiveScroll=true
end type

type dw_part_mfg from datawindow within w_production_grid
int X=3561
int Y=1664
int Width=329
int Height=360
int TabOrder=270
boolean Visible=false
string DataObject="dw_part_mfg"
boolean LiveScroll=true
end type

type dw_workorder_detail from datawindow within w_production_grid
int X=3255
int Y=1660
int Width=293
int Height=352
int TabOrder=260
boolean Visible=false
string DataObject="dw_consolidated_workorder"
boolean LiveScroll=true
end type

type dw_part_info from datawindow within w_production_grid
int X=3278
int Y=1336
int Width=283
int Height=284
int TabOrder=210
boolean Visible=false
string DataObject="dw_part_info"
boolean LiveScroll=true
end type

type dw_product_line from datawindow within w_production_grid
int X=2834
int Y=992
int Width=297
int Height=284
int TabOrder=200
boolean Visible=false
string DataObject="dw_production_line"
boolean LiveScroll=true
end type

type ddlb_type from dropdownlistbox within w_production_grid
int X=18
int Y=16
int Width=421
int Height=400
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All Parts",&
"Product Line",&
"Flow Router",&
"Finished Part",&
"Activity",&
"Sales Order"}
end type

on selectionchanged;sle_order.visible	= FALSE

Choose Case ddlb_type.text

	Case "All Parts"
		iSelection	= 1
		ddlb_type_value.visible = FALSE
		Parent.TriggerEvent("rebuild_crosstab")
		ddlb_type_value.visible = FALSE

	Case "Product Line"
		iSelection	= 2
		build_product_line_dropdown()	
		ddlb_type_value.visible = TRUE

	Case "Flow Router"
		iSelection	= 3
		wf_get_finished_parts()
		ddlb_type_value.visible = TRUE		

	Case "Finished Part"
		iSelection	= 4
		ddlb_type_value.visible	= FALSE
		Parent.TriggerEvent("rebuild_crosstab")

	Case "Activity"
		iSelection	= 5
		wf_get_activities()
		ddlb_type_value.visible = TRUE		

	Case "Sales Order"
		iSelection			= 6
		sle_order.visible	= TRUE

End Choose


end on

type st_label from statictext within w_production_grid
int X=18
int Y=1312
int Width=439
int Height=48
boolean Enabled=false
string Text="Available Machines:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_machine_list_for_part from datawindow within w_production_grid
int X=2834
int Y=1296
int Width=293
int Height=288
int TabOrder=250
boolean Visible=false
string DataObject="dw_list_of_machine_for_part"
boolean LiveScroll=true
end type

type rb_7 from radiobutton within w_production_grid
int X=2450
int Y=1312
int Width=366
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

type rb_6 from radiobutton within w_production_grid
int X=2121
int Y=1312
int Width=329
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

type rb_5 from radiobutton within w_production_grid
int X=1792
int Y=1312
int Width=329
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

type rb_4 from radiobutton within w_production_grid
int X=1463
int Y=1312
int Width=329
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

type rb_3 from radiobutton within w_production_grid
int X=1134
int Y=1312
int Width=329
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

type rb_2 from radiobutton within w_production_grid
int X=805
int Y=1312
int Width=329
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

type rb_1 from radiobutton within w_production_grid
int X=475
int Y=1312
int Width=329
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Machine1 "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_machine_load.visible then
	dw_machine_load.visible = FALSE
Else
	dw_machine_load.visible = TRUE
	dw_machine_load.title	= "Soft queue for " + this.text
	dw_machine_load.Retrieve(this.text)
End If
end on

on dragdrop;szMachine	= this.text
dragdrop_to_machine()
end on

type dw_list_parts_bom from datawindow within w_production_grid
int Y=1744
int Width=238
int Height=320
int TabOrder=80
boolean Visible=false
string DataObject="dw_list_parts_for_bom_net_out"
boolean LiveScroll=true
end type

type dw_bom from datawindow within w_production_grid
int X=256
int Y=1744
int Width=256
int Height=320
int TabOrder=70
boolean Visible=false
string DataObject="d_bom"
boolean LiveScroll=true
end type

type dw_machine_process from datawindow within w_production_grid
int X=530
int Y=1744
int Width=256
int Height=320
int TabOrder=60
boolean Visible=false
string DataObject="dw_machine_process"
boolean LiveScroll=true
end type

type dw_mps_in_work_order from datawindow within w_production_grid
int X=805
int Y=1744
int Width=256
int Height=320
int TabOrder=50
boolean Visible=false
string DataObject="dw_mps_in_work_order"
boolean LiveScroll=true
end type

type dw_work_detail from datawindow within w_production_grid
int X=1079
int Y=1744
int Width=256
int Height=320
int TabOrder=40
boolean Visible=false
string DataObject="d_work_order_detail"
boolean LiveScroll=true
end type

type dw_process_info from datawindow within w_production_grid
int X=2505
int Y=1744
int Width=274
int Height=320
int TabOrder=120
boolean Visible=false
string DataObject="dw_process_info"
boolean LiveScroll=true
end type

type dw_current_demand from datawindow within w_production_grid
int X=1353
int Y=1744
int Width=274
int Height=320
int TabOrder=140
boolean Visible=false
string DataObject="dw_demand_in_selected_dates"
boolean LiveScroll=true
end type

type cbx_daily from checkbox within w_production_grid
int X=823
int Width=475
int Height=64
string Text="Daily Schedule"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If cbx_daily.Checked then
	parent.title = "Global Production Schedule (Daily)"
Else
	parent.title = "Global Production Schedule (Weekly)"
End If

parent.TriggerEvent("rebuild_crosstab")
end on

type dw_process_id from datawindow within w_production_grid
int X=1646
int Y=1744
int Width=274
int Height=320
int TabOrder=130
boolean Visible=false
string DataObject="d_part_process"
boolean LiveScroll=true
end type

type dw_part_online_info from datawindow within w_production_grid
int X=2231
int Y=1744
int Width=256
int Height=320
int TabOrder=110
boolean Visible=false
string DataObject="dw_part_online_info"
boolean LiveScroll=true
end type

type cbx_time from checkbox within w_production_grid
int X=1975
int Width=549
int Height=64
string Text="Real Time Display"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If cbx_time.checked then
	timer(f_time_interval())
Else
	timer(0)
end If
end on

type cbx_onhand from checkbox within w_production_grid
int X=1390
int Width=512
int Height=64
string Text="Net Out On Hand"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If cbx_onhand.Checked then
	//Erase_all_bom_net_out()
	//Update_bom_net_out()
	Erase_all_bom_net_out_new()
	Update_bom_net_out_new()
End If

//Create_crosstab(dDate7)
//Create_crosstab_new(dDate7)

//dw_list_parts.SetFilter("part > ' '")
//dw_list_parts.Filter()
//
//dw_list_parts.SetSort("1a")
//dw_list_parts.Sort()
//
end on

type dw_machine_list from datawindow within w_production_grid
int X=530
int Y=2080
int Width=256
int Height=352
int TabOrder=190
boolean Visible=false
string DataObject="d_machine_status_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;Long iRow

iRow = dw_machine_list.GetClickedRow()

If iRow > 0 then
	szMachine = dw_machine_list.GetItemString(iRow, "machine_no")
	dw_machine_load.Retrieve(dw_machine_list.GetItemString(iRow, "machine_no"))
	dw_machine_load.SelectRow(0, FALSE)
	dw_machine_load.SelectRow(iRow, TRUE)
End If
end on

on dragdrop;If bCrossTab then
	MessageBox ("Warning", "Please drag-drop to the datawindow at right", StopSign!)
End If
end on

type st_name1 from statictext within w_production_grid
int X=823
int Y=64
int Width=261
int Height=64
boolean Enabled=false
string Text="Sun"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_name7 from statictext within w_production_grid
int X=2469
int Y=64
int Width=274
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Sat"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_name6 from statictext within w_production_grid
int X=2194
int Y=64
int Width=247
int Height=64
boolean Visible=false
string Text="Fri"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_name5 from statictext within w_production_grid
int X=1920
int Y=64
int Width=247
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="Thu"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_name4 from statictext within w_production_grid
int X=1646
int Y=64
int Width=219
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Wed"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_name3 from statictext within w_production_grid
int X=1371
int Y=64
int Width=256
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="Thu"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_name2 from statictext within w_production_grid
int X=1097
int Y=64
int Width=247
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="Mon"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_production_grid
int X=2469
int Y=128
int Width=247
int Height=64
boolean Enabled=false
string Text="Date7"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_production_grid
int X=2194
int Y=128
int Width=247
int Height=64
boolean Enabled=false
string Text="Date6"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_production_grid
int X=1920
int Y=128
int Width=247
int Height=64
boolean Enabled=false
string Text="Date5"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_production_grid
int X=1646
int Y=128
int Width=247
int Height=64
boolean Enabled=false
string Text="Date4"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_production_grid
int X=1371
int Y=128
int Width=247
int Height=64
boolean Enabled=false
string Text="Date3"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_production_grid
int X=1097
int Y=128
int Width=247
int Height=64
boolean Enabled=false
string Text="Date2"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_production_grid
int X=823
int Y=128
int Width=270
int Height=64
boolean Enabled=false
string Text="Date1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_production_grid
int X=530
int Y=128
int Width=256
int Height=64
boolean Enabled=false
string Text="PastDue"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_demand from datawindow within w_production_grid
int X=1938
int Y=1744
int Width=274
int Height=320
int TabOrder=30
boolean Visible=false
string DataObject="dw_demand"
boolean LiveScroll=true
end type

type ddlb_type_value from dropdownlistbox within w_production_grid
int X=18
int Y=112
int Width=421
int Height=512
int TabOrder=170
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All Parts",&
"Product Line"}
end type

on selectionchanged;parent.TriggerEvent("rebuild_crosstab")
end on

type dw_crosstab from datawindow within w_production_grid
int X=18
int Y=208
int Width=2798
int Height=1088
int TabOrder=150
string DragIcon="DRAG1PG.ICO"
string DataObject="dw_crosstab_new"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;Integer iRow
Integer iCol
Integer iCount
Integer iDemand

Decimal nCurrentQty          //To keep the current qty at (row, col)

iRow = dw_crosstab.GetClickedRow()
iCol = dw_crosstab.GetClickedColumn()
iCrossTabCol = iCol				//Save the col in the Instance variable
iCrossTabRow = iRow				//Save the row in the Instance variable

If iRow > 0 and iCol > 1 and iCol <= 9 then

	szPart = dw_crosstab.GetItemString(iRow, 1)
	nQty   = 0

	If iCol = 2 then
		SetNull(dBeginDate)
	Else 
		dBeginDate 	= Get_date(iCol - 1)
	End If
	
	dEndDate   		= Get_date(iCol)

	nQty   			= dw_crosstab.GetItemNumber(iRow, iCol)

	bCrossTab 		= TRUE

	dw_crosstab.drag(begin!)

	If f_get_activity(szPart) <> "OUTSIDE" then
		st_label.text	= "Available machines:"
		w_production_grid.SetMicroHelp("Drag to machine for schedule")
		display_related_machines(szPart)
		bOutside	= FALSE
	Else
		st_label.text	= "Available vendors:"
		w_production_grid.SetMicroHelp("Drag to vendor for outside process")
		bOutside	= TRUE	
		wf_display_vendors(szPart)	
	End If

	nAccumQty	= 0
	For iCount = 2 to iCol
		nCurrentQty	= dw_crosstab.GetItemNumber(irow, iCount)
		If nCurrentQty > 0 then
			nAccumQty	= nAccumQty + nCurrentQty		
		End If
	Next

	iLastRow	= iRow
	iLastCol	= iCol

	st_drag.x			= PointerX()
	st_drag.y			= PointerY() - 10
	st_drag.visible	= TRUE

	st_drag.text		= "Total qty in work order:" + &
								String(Truncate(wf_qty_in_workorder_detail(szPart), 0))
	
End If

dw_unscheduled_mps.visible = FALSE
end on

on dragdrop;Integer iRow

If bWorkOrder then
	If MessageBox("Warning", "Delete Work Order# "+szWorkOrder, Exclamation!, OKCancel!) = 1 then
		dw_machine_load.DeleteRow(iWorkOrderRow)	//Delete the current work order
		If dw_machine_load.Update() > 0 then		
			Commit;
			assigne_sequence()
			dw_machine_load.Retrieve(szMachine)
			Delete_workorder_detail(szWorkOrder)
		Else
			RollBack;
		End If
	End If
	bWorkOrder = FALSE
End If
end on

on doubleclicked;dw_unscheduled_mps.visible = TRUE
If IsNull(dBeginDate) then
	dBeginDate = Date("01/23/1963")
End If
dw_unscheduled_mps.Retrieve(szPart, dBeginDate, dEndDate)
end on

type dw_machine_load from datawindow within w_production_grid
int X=402
int Y=352
int Width=2107
int Height=640
int TabOrder=230
boolean Visible=false
string DragIcon="DRAG1PG.ICO"
string DataObject="d_order_list_new"
boolean TitleBar=true
string Title="Soft Queue"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

on dragdrop;If bCrossTab then
	Open(w_prompt_for_total_qty_in_schedule_ver2)
	bCrossTab = FALSE
End If


end on

on clicked;iWorkOrderRow = dw_machine_load.GetClickedRow()

bWorkOrder = FALSE

If iWorkOrderRow > 0 then
	dw_machine_load.Drag(begin!)
	bWorkOrder = TRUE
	szWorkOrder = dw_machine_load.GetItemString(iWorkOrderRow, "work_order")
	dw_machine_load.SelectRow(0, FALSE)
	dw_machine_load.SelectRow(iWorkOrderRow, TRUE)
End If	
end on

on losefocus;this.visible = FALSE
end on

type dw_unscheduled_mps from datawindow within w_production_grid
int X=329
int Y=416
int Width=2258
int Height=768
int TabOrder=220
boolean Visible=false
string DataObject="dw_unscheduled_mps"
boolean TitleBar=true
string Title="Detail Information"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on losefocus;this.visible = FALSE
end on

type st_drag from statictext within w_production_grid
int X=846
int Y=436
int Width=855
int Height=52
boolean Visible=false
boolean Enabled=false
string Text="Message"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


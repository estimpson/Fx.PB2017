$PBExportHeader$w_prompt_for_total_qty_in_schedule_ver2.srw
$PBExportComments$Prompt total quantity for schedule (verstion2)
forward
global type w_prompt_for_total_qty_in_schedule_ver2 from Window
end type
type cb_2 from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_work_order from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_19 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_job_detail from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_job_header from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_template from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_runtime from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_18 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type ddlb_part from dropdownlistbox within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_mps from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type cb_1 from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_unable from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_process_id from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_17 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_16 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_15 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_14 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type cb_purchase from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
end type
type cb_auto from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_work_order_detail from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_deadstart_datetime from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_stop_datetime from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_13 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_11 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_group_tech from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_9 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_setup_time from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_8 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_12 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_hard_queue from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_hours from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_days from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_10 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_7 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_6 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_5 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type dw_part_mfg from datawindow within w_prompt_for_total_qty_in_schedule_ver2
end type
type cb_exit from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
end type
type cb_save from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_4 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_4 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_3 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_3 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_2 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_2 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type st_1 from statictext within w_prompt_for_total_qty_in_schedule_ver2
end type
type sle_1 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
end type
type gb_4 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
end type
type gb_3 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
end type
type gb_2 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
end type
type gb_1 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
end type
type r_1 from rectangle within w_prompt_for_total_qty_in_schedule_ver2
end type
type ln_1 from line within w_prompt_for_total_qty_in_schedule_ver2
end type
type r_runtime from rectangle within w_prompt_for_total_qty_in_schedule_ver2
end type
type oval_2 from oval within w_prompt_for_total_qty_in_schedule_ver2
end type
type ln_end from line within w_prompt_for_total_qty_in_schedule_ver2
end type
type ln_start from line within w_prompt_for_total_qty_in_schedule_ver2
end type
end forward

type st_Part_Runtime from structure
    string Part
    decimal {2} RunTime
end type

global type w_prompt_for_total_qty_in_schedule_ver2 from Window
int X=0
int Y=0
int Width=2935
int Height=2464
boolean TitleBar=true
long BackColor=77897888
boolean ControlMenu=true
cb_2 cb_2
sle_work_order sle_work_order
st_19 st_19
dw_job_detail dw_job_detail
dw_job_header dw_job_header
dw_template dw_template
sle_runtime sle_runtime
st_18 st_18
ddlb_part ddlb_part
dw_mps dw_mps
cb_1 cb_1
st_unable st_unable
sle_process_id sle_process_id
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
cb_purchase cb_purchase
cb_auto cb_auto
dw_work_order_detail dw_work_order_detail
st_deadstart_datetime st_deadstart_datetime
st_stop_datetime st_stop_datetime
st_13 st_13
st_11 st_11
sle_group_tech sle_group_tech
st_9 st_9
sle_setup_time sle_setup_time
st_8 st_8
st_12 st_12
dw_hard_queue dw_hard_queue
sle_hours sle_hours
sle_days sle_days
st_10 st_10
st_7 st_7
st_6 st_6
st_5 st_5
dw_part_mfg dw_part_mfg
cb_exit cb_exit
cb_save cb_save
sle_4 sle_4
st_4 st_4
sle_3 sle_3
st_3 st_3
sle_2 sle_2
st_2 st_2
st_1 st_1
sle_1 sle_1
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
r_1 r_1
ln_1 ln_1
r_runtime r_runtime
oval_2 oval_2
ln_end ln_end
ln_start ln_start
end type
global w_prompt_for_total_qty_in_schedule_ver2 w_prompt_for_total_qty_in_schedule_ver2

type variables
String szMachine                     //Machine Number

DateTime dtStopDateTime        //Endding DateTime for
                                             //Hard Queue

DateTime dtDropDeadDateTime//Drop Dead Start Date/Time

Long  iMPSRowId                    //MPS Row Id Number
Long  iStackEnd1 = 0               //End Pointer for stack1
Long  iStackEnd2 = 0               //End Pointer for stack2
Long  iStack1[]
Long  iStack2[]
Long  iPartRunTimePtr              //Part run time array pointer
Long  iPartPtr                           //Part porinter
Long  iWorkOrder     = 0            //Work order

Decimal nTotalHours                //Total hours
Decimal nPartsPerHour             //Hourly rate

Boolean bDraw = TRUE            //Whether draw runtime
Boolean bViewBundle = FALSE  //View part to bundle

st_Part_Runtime PartRuntime[]

st_generic_structure stParm       //To keep parameters


end variables

forward prototypes
public function string wf_get_group_tech (string szpart)
public function decimal wf_get_setup_time (string szpart)
public subroutine wf_draw_runtime (decimal nruntime)
public function decimal wf_get_hourly_rate (string szpart)
public subroutine wf_write_into_stack (int istackno)
public subroutine wf_read_from_stack (int istackno)
public function boolean wf_part_highlighted (string szPart)
public function decimal wf_get_max_runtime ()
public function integer wf_part_in_list (string szpart)
public subroutine wf_setup_screen (string szpart, decimal nqty)
public subroutine wf_create_new_job ()
public subroutine wf_update_runtime (long irow, decimal nruntime, decimal nQty)
public subroutine wf_update_qty_assigned ()
public subroutine wf_calc_job_time (string szMachine)
public function decimal wf_calculate_quantity (string szpart, boolean bDelete)
public subroutine wf_add_into_job (long iworkorder)
public function long wf_get_part_row (long iworkorder, string szpart)
public function decimal wf_parts_per_cycle (string szpart)
public function decimal wf_parts_per_hour (string szpart)
end prototypes

public function string wf_get_group_tech (string szpart);String szGroupTech

  SELECT part.group_technology  
    INTO :szGroupTech  
    FROM part  
   WHERE part.part = :szPart   ;

Return szGroupTech

end function

public function decimal wf_get_setup_time (string szpart);Decimal nSetupTime
String  szProcessId

  SELECT part_mfg.process_id,   
         part_mfg.setup_time  
    INTO :szProcessId,   
         :nSetupTime  
    FROM part_mfg  
   WHERE part_mfg.part = :szPart   ;


	sle_process_id.text	= szProcessId

Return nSetupTime

end function

public subroutine wf_draw_runtime (decimal nruntime);Integer iDays
Integer iHours
Decimal nTotalRunTime

If sle_work_order.text <> "New" then
	r_runtime.width	= 0
	Return
End If

If nRunTime > nTotalHours then
	Timer(0.35)
	st_unable.visible	= TRUE
	r_runtime.visible	= FALSE
	sle_hours.text		= "0"
	sle_days.text		= "0"
Else
	Timer(0)
	st_unable.visible	= FALSE
	r_runtime.visible	= TRUE
	nTotalRunTime		= ln_end.BeginX - ln_start.BeginX
	r_runtime.width	= nTotalRunTime * (nRunTime / nTotalHours)
	iDays					= Truncate( (nTotalHours - nRunTime) / 24, 0) 
	iHours				= (nTotalHours - nRunTime) - (iDays * 24)
	sle_days.text		= String(iDays )
	sle_hours.text		= String(iHours)
	If nRunTime = 0 then
		r_runtime.visible	= FALSE
	End If
End If
end subroutine

public function decimal wf_get_hourly_rate (string szpart);Decimal nPartsPerHour

  SELECT part_mfg.parts_per_hour  
    INTO :nPartsPerHour  
    FROM part_mfg  
   WHERE part_mfg.part = :szPart   ;

Return f_get_value(nPartsPerHour)
end function

public subroutine wf_write_into_stack (int istackno);Long iStack[]
Long iRow
Long iStackEnd = 0
Long iCol

If iStackNo = 1 then
	iCol = 10
Else
	iCol = 11
End If

For iRow = 1 to dw_mps.RowCount()
	If dw_mps.IsSelected(iRow) then
		iStackEnd ++
		iStack[iStackEnd]	= dw_mps.GetItemNumber(iRow, iCol)
	End If
Next

If iStackNo = 1 then
	iStack1[]	= iStack[]
	iStackEnd1	= iStackEnd
Else
	iStack2[]	= iStack[]
	iStackEnd2	= iStackEnd
End If		
		

end subroutine

public subroutine wf_read_from_stack (int istackno);Long iStack[]
Long iStackEnd = 0
Long iRow
Long iIdCount
Long iCol

Boolean bFound

If iStackNo = 1 then
	iCol = 10
End If

If iStackNo = 2 then
	iCol = 11
End If

If iStackNo = 21 then			//In mode 2 read from mode 1
	iCol = 11
End If

If iStackNo = 12 then			//In mode 1 read from mode 2
	iCol = 10
End If
	

If (iStackNo = 1) Or (iStackNo = 21) then
	iStack[]	= iStack1[]
	iStackEnd= iStackEnd1
Else
	iStack[]	= iStack2[]
	iStackEnd= iStackEnd2
End If

For iRow = 1 to dw_mps.RowCount()

	iIdCount	= 1
	bFound	= FALSE
	
	Do while (Not bFound) AND (iIdCount <= iStackEnd)

		If dw_mps.GetItemNumber(iRow, iCol) = iStack[iIdCount] then
			dw_mps.SelectRow(iRow, TRUE)
			bFound	= TRUE
		Else
			iIdCount ++
		End If
	Loop
Next				





end subroutine

public function boolean wf_part_highlighted (string szPart);Long 		iCount
Boolean 	bFound

bFound	= FALSE
iCount	= 1
iPartPtr	= 0

Do while (Not bFound) AND (iCount <= dw_mps.RowCount())
	If dw_mps.IsSelected(iCount) AND (dw_mps.GetItemString(iCount, 1) = szPart) then
		bFound	= TRUE
		iPartPtr	= iCount
	Else
		iCount ++
	End If
Loop

Return bFound


end function

public function decimal wf_get_max_runtime ();Long iCount
Decimal nRunTime

nRunTime = 0

For iCount = 1 to dw_template.RowCount()
	If Dec(dw_template.GetItemString(iCount, "value2")) > nRunTime then
		nRunTime	= Dec(dw_template.GetItemString(iCount, "value2"))
	End If
Next

Return nRunTime	
end function

public function integer wf_part_in_list (string szpart);Long 		iCount

iCount	= dw_template.Find("value1='" + szPart + "'", 1, 999999)

Return iCount


end function

public subroutine wf_setup_screen (string szpart, decimal nqty);sle_3.Text	= String(Truncate(nQty, 2))

dw_part_mfg.Retrieve(szPart)
If dw_part_mfg.RowCount() > 0 then
	sle_2.Text	= String(dw_part_mfg.GetItemNumber(1, "mfg_lot_size"))
Else
	sle_2.Text	= '0'
	sle_4.text	= '0'
End If

If Dec(sle_2.text) > 0 then
	sle_4.Text	= String (Int ( (nQty / Dec(sle_2.text)) + 0.999999) * Dec(sle_2.text))
End If

sle_runtime.Text	= String(Truncate(wf_get_max_runtime(), 2))
end subroutine

public subroutine wf_create_new_job ();//************************************************************************
//* Declaration
//************************************************************************

Long iRow					//Current row number

Decimal nRunTime			//The runtime for detail item
Decimal nJobRunTime		//The runtime for the whole job
Decimal nPartsPerCycle	//The parts per cycle
Decimal nPartsPerHour	//The parts per hour

String szPart				//The part number

//***********************************************************************
//* Main routine
//***********************************************************************
//-----------------------------------------------------------------------
// Get new work order from parameter file 
//-----------------------------------------------------------------------

//bFinish	= FALSE
//OpenWithParm(w_get_parm_value, "next_serial")
//Do While (Not bFinish)		//Waiting the return from w_get_parm_value
//Loop
//iWorkOrder	= Message.DoubleParm

if SQLCA.of_getnextparmvalue ( 'next_workorder', iWorkOrder ) then
	dw_job_header.InsertRow(1)
	dw_job_header.SetItem(1, "work_order", String(iWorkOrder))
	dw_job_header.SetItem(1, "due_date", w_production_grid.dEndDate)
	dw_job_header.SetItem(1, "machine_no", w_production_grid.szMachine)
	dw_job_header.SetItem(1, "process_id", sle_process_id.text)
	dw_job_header.SetItem(1, "runtime", Dec(sle_runtime.text))
	dw_job_header.SetItem(1, "sequence", 9999)
	
	If dw_job_header.Update() > 0 then
		For iRow = 1 to dw_template.RowCount()
			dw_job_detail.InsertRow(1)
			dw_job_detail.SetItem(1, "workorder", String(iWorkOrder))
			dw_job_detail.SetItem(1, "qty_required", Dec(dw_template.GetItemString(iRow, "value3")))
			dw_job_detail.SetItem(1, "run_time", Dec(dw_template.GetItemString(iRow, "value2")))
			szPart	= dw_template.GetItemString(iRow, "value1")
			dw_job_detail.SetItem(1, "part", szPart )
			dw_job_detail.SetItem(1, "qty_completed", 0)
			dw_job_detail.SetItem(1, "parts_per_cycle", wf_parts_per_cycle(szPart))
		Next
	
		If dw_job_detail.Update() > 0 then
			Commit;
		Else
			Rollback;
		End If
	Else
		Rollback;
	End If		
else
	rollback;
end if 

end subroutine

public subroutine wf_update_runtime (long irow, decimal nruntime, decimal nQty);dw_template.SetItem(iRow, 2, String(nRunTime))
dw_template.SetItem(iRow, "value3", String(nQty))
end subroutine

public subroutine wf_update_qty_assigned ();Long iRow
Decimal nQtyRequired

//dw_mps.DataObject = "dw_unscheduled_mps_with_same_process_id"
//dw_mps.SetTransObject(sqlca)
//dw_mps.Title		= "Requirement with same process id:" + sle_process_id.text
//dw_mps.Retrieve(sle_process_id.text, Date("01/01/63"), w_mps_2.dDate7)
//wf_read_from_stack(2)
//wf_read_from_stack(21)

For iRow = 1 to dw_mps.RowCount()
	If dw_mps.IsSelected(iRow) then
		nQtyRequired	= dw_mps.GetItemNumber(iRow, "qnty")
		dw_mps.SetItem(iRow, "qty_assigned", nQtyRequired)
		If Not bViewBundle then
			dw_mps.SetItem(iRow, "workorder", String(iWorkOrder))
		Else
			dw_mps.SetItem(iRow, "master_prod_sched_workorder", String(iWorkOrder))
		End If
	End If
Next

If dw_mps.Update() > 0 then
	Commit;
Else
	Rollback;
End If	
end subroutine

public subroutine wf_calc_job_time (string szMachine);Long iRow

Str_progress  sparm

sparm.Title = "Calculating Job Execution Time"

OpenWithParm(w_calculate_job_time, szMachine)
end subroutine

public function decimal wf_calculate_quantity (string szpart, boolean bDelete);Long iRow
Decimal nQty

nQty		= 0

For iRow = 1 to dw_mps.RowCount()
	If (dw_mps.GetItemString(iRow, "part") = szPart) AND (dw_mps.IsSelected(iRow)) then
		nQty	= nQty + dw_mps.GetItemNumber(iRow, "qnty")
	End If
Next

If Not bDelete then
	wf_setup_screen(szPart, nQty)		//Setup screen
	iRow	= wf_part_in_list(szPart)

	If iRow <= 0 then
		dw_template.InsertRow(1)
		dw_template.SetItem(1, "value1", szPart)
		dw_template.SetItem(1, "value2", String(nQty / nPartsPerHour))
		dw_template.SetItem(1, "value3", String(nQty))
	Else	
		wf_update_runtime(iRow, nQty / nPartsPerHour, nQty)
	End If
End If

Return nQty
end function

public subroutine wf_add_into_job (long iworkorder);//************************************************************************
//* Declaration
//************************************************************************

Long 		iRow				//Current row number
Long 		iPartRow			//Row number for current part

Decimal 	nQty				//To keep the quantity
Decimal 	nRunTime			//To keep the run time
Decimal 	nJobRunTime		//to keep the run time for job

String	szPart			//Part number

//***********************************************************************
//* Main routine
//***********************************************************************

dw_job_header.Retrieve(String(iWorkOrder))

If dw_job_header.RowCount() > 0 then
	nJobRunTime	= dw_job_header.GetItemNumber(1, "runtime")
	nJobRunTime	= f_get_value(nJobRunTime) + Dec(sle_runtime.text)
	dw_job_header.SetItem(1, "runtime", nJobRunTime)
	If dw_job_header.Update() > 0 then
		Commit;
	Else
		Rollback;
	End If 
End If

For iRow = 1 to dw_template.RowCount()
	
	szPart	= dw_template.GetItemString(iRow, "value1")
	iPartRow	= wf_get_part_row(iWorkOrder, szPart)

	If iPartRow = 0 then
		dw_job_detail.InsertRow(1)
		dw_job_detail.SetItem(1, "workorder", String(iWorkOrder))
		dw_job_detail.SetItem(1, "qty_completed", 0)
		iPartRow	= 1
		nQty		= 0
		nRunTime	= 0
	Else
		nQty		= dw_job_detail.GetItemNumber(iPartRow, "qty_required")
		nRunTime	= dw_job_detail.GetItemNumber(iPartRow, "run_time")
	End If

	nQty			= nQty + Dec(dw_template.GetItemString(iRow, "value3"))
	nRunTime		= nRunTime + Dec(dw_template.GetItemString(iRow, "value2"))

	dw_job_detail.SetItem(iPartRow, "qty_required", nQty)
	dw_job_detail.SetItem(iPartRow, "run_time", nRunTime )
	dw_job_detail.SetItem(iPartRow, "part", szPart )
	dw_job_detail.SetItem(iPartRow, "parts_per_cycle", wf_parts_per_cycle(szPart))

	If dw_job_detail.Update() > 0 then
		Commit;
	Else
		Rollback;
	End If
		
Next


	





end subroutine

public function long wf_get_part_row (long iworkorder, string szpart);Long 		iRow
Boolean 	bFound

dw_job_detail.Retrieve(String(iWorkOrder))

bFound	= FALSE
iRow		= 1

Do while (Not bFound) AND ( iRow <= dw_job_detail.RowCount())
	If szPart	= dw_job_detail.GetItemString(iRow, "part") then
		bFound	= TRUE
	Else
		iRow ++		
	End If	
Loop

If (Not bFound) then
	iRow	= 0
End If

Return iRow 
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

public function decimal wf_parts_per_hour (string szpart);Decimal nPartsPerHour

SELECT part_mfg.parts_per_hour  
  INTO :nPartsPerHour  
  FROM part_mfg  
 WHERE part_mfg.part = :szPart   ;

Return nPartsPerHour
end function

event open;Long 		iRow
String	szRuntime

dw_part_mfg.SetTransObject(sqlca)				//Part Mfg Information
dw_mps.SetTransObject(sqlca)						//Current demand
dw_hard_queue.SetTransObject(sqlca)				//Hard Queue Information
dw_work_order_detail.SetTransObject(sqlca)	//Related Work Order Detail Info
dw_job_header.SetTransObject(sqlca)				//Work order header information
dw_job_detail.SetTransObject(sqlca)				//Work order detail information

dw_mps.Retrieve(w_production_grid.szPart, Date("01/01/63"), w_production_grid.dDate7)
dw_part_mfg.Retrieve(w_production_grid.szPart)

sle_1.Text		= w_production_grid.szPart
sle_3.Text		= String(Truncate(w_production_grid.nAccumQty, 2))
szMachine		= w_production_grid.szMachine
ddlb_part.AddItem(sle_1.text)
ddlb_part.Text	= sle_1.text

dw_hard_queue.Retrieve(szMachine)
If dw_hard_queue.RowCount() > 0 then
	iRow				= dw_hard_queue.RowCount()
	dtStopDateTime	= DateTime(	dw_hard_queue.GetItemDate(iRow, "end_date"), &
										dw_hard_queue.GetItemTime(iRow, "end_time"))
Else
	dtStopDateTime	= DateTime(Today(), Now())
End If	

st_stop_datetime.text		= String(dtStopDateTime)	
st_deadstart_datetime.text	= String(w_production_grid.dEndDate) + " 00:00:00"

sle_setup_time.text			= String(wf_get_setup_time(w_production_grid.szPart))
sle_group_tech.text			= wf_get_group_tech(w_production_grid.szPart)

For iRow = 1 to dw_mps.RowCount()
	If dw_mps.GetItemDate(iRow, "due") < w_production_grid.dEndDate then
		dw_mps.SelectRow(iRow, TRUE)
	End If
Next 	

nTotalHours	= f_hours_between(Date(dtStopDateTime), Time(dtStopDateTime), &
										w_production_grid.dEndDate, Time("00:00:00"))

nPartsPerHour	= wf_get_hourly_rate(w_production_grid.szPart) 
sle_work_order.text	= "New"

If nPartsPerHour = 0 then
	MessageBox("Warning", "Hourly rate for part:" + w_production_grid.szPart + " is missing", StopSign!) 
	bDraw	= FALSE
Else
	wf_draw_runtime(Dec(sle_3.text) / nPartsPerHour)
	sle_runtime.text	= String(Truncate(Dec(sle_3.text) / nPartsPerHour, 2))
End If

// dw_template is used to keep the runtime for each part bundled

szRunTime	= String(f_get_value(Dec(sle_runtime.text)))
dw_template.InsertRow(1)
dw_template.SetItem(1, 1, sle_1.text)
dw_template.SetItem(1, 2, szRunTime)
dw_template.SetItem(1, 3, sle_3.text)

wf_setup_screen(w_production_grid.szPart, w_production_grid.nAccumQty)

dw_work_order_detail.Retrieve(szMachine, sle_process_id.text)

end event

on deactivate;//close(this)
end on

on w_prompt_for_total_qty_in_schedule_ver2.create
this.cb_2=create cb_2
this.sle_work_order=create sle_work_order
this.st_19=create st_19
this.dw_job_detail=create dw_job_detail
this.dw_job_header=create dw_job_header
this.dw_template=create dw_template
this.sle_runtime=create sle_runtime
this.st_18=create st_18
this.ddlb_part=create ddlb_part
this.dw_mps=create dw_mps
this.cb_1=create cb_1
this.st_unable=create st_unable
this.sle_process_id=create sle_process_id
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.cb_purchase=create cb_purchase
this.cb_auto=create cb_auto
this.dw_work_order_detail=create dw_work_order_detail
this.st_deadstart_datetime=create st_deadstart_datetime
this.st_stop_datetime=create st_stop_datetime
this.st_13=create st_13
this.st_11=create st_11
this.sle_group_tech=create sle_group_tech
this.st_9=create st_9
this.sle_setup_time=create sle_setup_time
this.st_8=create st_8
this.st_12=create st_12
this.dw_hard_queue=create dw_hard_queue
this.sle_hours=create sle_hours
this.sle_days=create sle_days
this.st_10=create st_10
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.dw_part_mfg=create dw_part_mfg
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.sle_4=create sle_4
this.st_4=create st_4
this.sle_3=create sle_3
this.st_3=create st_3
this.sle_2=create sle_2
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.r_1=create r_1
this.ln_1=create ln_1
this.r_runtime=create r_runtime
this.oval_2=create oval_2
this.ln_end=create ln_end
this.ln_start=create ln_start
this.Control[]={this.cb_2,&
this.sle_work_order,&
this.st_19,&
this.dw_job_detail,&
this.dw_job_header,&
this.dw_template,&
this.sle_runtime,&
this.st_18,&
this.ddlb_part,&
this.dw_mps,&
this.cb_1,&
this.st_unable,&
this.sle_process_id,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.cb_purchase,&
this.cb_auto,&
this.dw_work_order_detail,&
this.st_deadstart_datetime,&
this.st_stop_datetime,&
this.st_13,&
this.st_11,&
this.sle_group_tech,&
this.st_9,&
this.sle_setup_time,&
this.st_8,&
this.st_12,&
this.dw_hard_queue,&
this.sle_hours,&
this.sle_days,&
this.st_10,&
this.st_7,&
this.st_6,&
this.st_5,&
this.dw_part_mfg,&
this.cb_exit,&
this.cb_save,&
this.sle_4,&
this.st_4,&
this.sle_3,&
this.st_3,&
this.sle_2,&
this.st_2,&
this.st_1,&
this.sle_1,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.r_1,&
this.ln_1,&
this.r_runtime,&
this.oval_2,&
this.ln_end,&
this.ln_start}
end on

on w_prompt_for_total_qty_in_schedule_ver2.destroy
destroy(this.cb_2)
destroy(this.sle_work_order)
destroy(this.st_19)
destroy(this.dw_job_detail)
destroy(this.dw_job_header)
destroy(this.dw_template)
destroy(this.sle_runtime)
destroy(this.st_18)
destroy(this.ddlb_part)
destroy(this.dw_mps)
destroy(this.cb_1)
destroy(this.st_unable)
destroy(this.sle_process_id)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.cb_purchase)
destroy(this.cb_auto)
destroy(this.dw_work_order_detail)
destroy(this.st_deadstart_datetime)
destroy(this.st_stop_datetime)
destroy(this.st_13)
destroy(this.st_11)
destroy(this.sle_group_tech)
destroy(this.st_9)
destroy(this.sle_setup_time)
destroy(this.st_8)
destroy(this.st_12)
destroy(this.dw_hard_queue)
destroy(this.sle_hours)
destroy(this.sle_days)
destroy(this.st_10)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.dw_part_mfg)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.sle_3)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.r_1)
destroy(this.ln_1)
destroy(this.r_runtime)
destroy(this.oval_2)
destroy(this.ln_end)
destroy(this.ln_start)
end on

on timer;st_unable.visible	= (Not st_unable.visible)
end on

type cb_2 from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
int X=110
int Y=1184
int Width=247
int Height=108
int TabOrder=130
string Text="Clear"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_work_order.text	= "New"
iWorkOrder				= 0
end on

type sle_work_order from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=544
int Width=480
int Height=88
int TabOrder=100
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_19 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=544
int Width=347
int Height=72
boolean Enabled=false
string Text="Work Order"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_job_detail from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=1317
int Y=2048
int Width=402
int Height=352
int TabOrder=200
boolean Visible=false
string DataObject="dw_work_order_detail"
boolean LiveScroll=true
end type

type dw_job_header from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=896
int Y=2048
int Width=402
int Height=352
int TabOrder=190
boolean Visible=false
string DataObject="dw_workorder_header_info"
boolean LiveScroll=true
end type

type dw_template from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=1079
int Y=896
int Width=1225
int Height=416
int TabOrder=180
boolean Visible=false
string DataObject="dw_external_template"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type sle_runtime from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=448
int Width=480
int Height=88
int TabOrder=90
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_18 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=448
int Width=293
int Height=64
boolean Enabled=false
string Text="Run Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_part from dropdownlistbox within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=64
int Width=480
int Height=384
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;wf_calculate_quantity(this.text, FALSE)				
end on

type dw_mps from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=1079
int Y=64
int Width=1792
int Height=768
int TabOrder=50
string DataObject="dw_unscheduled_mps"
boolean TitleBar=true
string Title="Current Requirement"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;Long 		iRow
Long 		iCount
String 	szPart
Boolean  bDelete

iRow	= this.GetClickedRow()

bDelete	= FALSE

If iRow > 0 then
	szPart			= this.GetItemString(iRow, "part")
	this.SelectRow(iRow, (Not this.IsSelected(iRow)))
	nPartsPerHour	= wf_get_hourly_rate(szPart)

	If this.IsSelected(iRow) then	//Add into the ddlb_part
		If ddlb_part.FindItem(this.GetItemString(iRow, "part"), 1) = -1 then
			ddlb_part.AddItem(this.GetItemString(iRow, "part"))
			ddlb_part.Text	= szPart
		End If			
	Else		//Check if no current part highlighed, then take out 
		If Not wf_part_highlighted(szPart) then
			bDelete	= TRUE
			iCount	= ddlb_part.FindItem(this.GetItemString(iRow, "part"), 1) 
			If iCount > 0 then
				ddlb_part.DeleteItem(iCount)
				iCount	= dw_template.Find("value1='" + szPart + "'", 1, 999)
				If iCount > 0 then
					dw_template.DeleteRow(iCount)
				End If
			End If
		End if
	End If

	wf_calculate_quantity(szPart, bDelete)				

End If

sle_runtime.text	= String(Truncate(wf_get_max_runtime(), 2))
If Dec(sle_runtime.text) > 0 then
	wf_draw_runtime(Dec(sle_runtime.text))
End If
	
end event

type cb_1 from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
int X=274
int Y=1056
int Width=517
int Height=108
int TabOrder=220
string Text="View Bundle"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If sle_process_id.text = "NONE" then
	MessageBox("Warning", "Cound not bundle parts with NONE process id", StopSign!)
	Return
End If

bViewBundle	= (Not bViewBundle)

If bViewBundle then
	wf_write_into_stack(1)
	dw_mps.DataObject = "dw_unscheduled_mps_with_same_process_id"
	dw_mps.SetTransObject(sqlca)
	dw_mps.Title		= "Requirement with same process id:" + sle_process_id.text
//	dw_mps.Retrieve(sle_process_id.text, Date("01/01/63"), w_mps_2.dDate7)
	this.text			= "View Original"
	wf_read_from_stack(2)
	wf_read_from_stack(21)
Else
	wf_write_into_stack(2)
	dw_mps.DataObject	= "dw_unscheduled_mps"
	dw_mps.SetTransObject(sqlca)
//	dw_mps.Retrieve(w_mps_2.szPart, Date("01/01/63"), w_mps_2.dDate7)
//	dw_mps.title		= "Requirement for part:"+ w_mps_2.szPart
	this.text							= "View Bundle"
	//wf_read_from_stack(1)
	wf_read_from_stack(12)
End If

dw_mps.BringToTop	= TRUE
ddlb_part.Text	= sle_1.text

end on

type st_unable from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=759
int Y=1348
int Width=832
int Height=96
boolean Visible=false
boolean Enabled=false
string Text="Unable to Schedule"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
long BorderColor=33554431
int TextSize=-14
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_process_id from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=1330
int Y=1680
int Width=311
int Height=96
int TabOrder=270
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_17 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=1097
int Y=1716
int Width=165
int Height=64
boolean Enabled=false
string Text="Id"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_16 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=1097
int Y=1664
int Width=219
int Height=64
boolean Enabled=false
string Text="Process"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_15 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=594
int Y=1716
int Width=165
int Height=64
boolean Enabled=false
string Text="Tech"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=1716
int Width=178
int Height=64
boolean Enabled=false
string Text="Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_purchase from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
int X=274
int Y=928
int Width=517
int Height=108
int TabOrder=150
boolean Enabled=false
string Text="Purchasing"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_auto from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
int X=274
int Y=800
int Width=517
int Height=108
int TabOrder=140
boolean Enabled=false
string Text="Auto Schedule"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_work_order_detail from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=1079
int Y=832
int Width=1792
int Height=480
int TabOrder=210
string DataObject="dw_work_order_detail_per_part_and_mach"
boolean TitleBar=true
string Title="Hard Queue"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	iWorkOrder				= Long (this.GetItemString(iRow, "work_order_work_order"))
	sle_work_order.text	= this.GetItemString(iRow, "work_order_work_order")
	r_runtime.Width		= 0
End If
end on

type st_deadstart_datetime from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=2414
int Y=1408
int Width=466
int Height=64
boolean Enabled=false
string Text="02/24/95 00:00:00"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
long BorderColor=8421504
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_stop_datetime from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=23
int Y=1408
int Width=517
int Height=64
boolean Enabled=false
string Text="02/24/95 00:00:00"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
long BorderColor=8421504
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=2651
int Y=1664
int Width=160
int Height=64
boolean Enabled=false
string Text="Hours"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=2377
int Y=1664
int Width=128
int Height=64
boolean Enabled=false
string Text="Days"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_group_tech from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=768
int Y=1680
int Width=311
int Height=96
int TabOrder=260
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=594
int Y=1664
int Width=165
int Height=64
boolean Enabled=false
string Text="Group "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_setup_time from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=251
int Y=1676
int Width=311
int Height=96
int TabOrder=290
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=1664
int Width=178
int Height=64
boolean Enabled=false
string Text="Setup"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=338
int Y=1348
int Width=389
int Height=60
boolean Enabled=false
string Text="Stop Date/Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_hard_queue from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=18
int Y=2048
int Width=494
int Height=352
int TabOrder=160
boolean Visible=false
string DataObject="dw_work_order_in_begin_date_time_order"
boolean LiveScroll=true
end type

type sle_hours from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=2523
int Y=1680
int Width=110
int Height=96
int TabOrder=280
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_days from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=2249
int Y=1680
int Width=110
int Height=96
int TabOrder=250
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=1755
int Y=1664
int Width=530
int Height=64
boolean Enabled=false
string Text="Time to Due Date"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=1705
int Y=1348
int Width=549
int Height=60
boolean Enabled=false
string Text="Current Requirement"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=2487
int Y=1348
int Width=256
int Height=64
boolean Enabled=false
string Text="Due Date"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=27
int Y=1348
int Width=293
int Height=64
boolean Enabled=false
string Text="Hard Queue"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_part_mfg from datawindow within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=2048
int Width=375
int Height=360
int TabOrder=170
boolean Visible=false
string DataObject="dw_part_mfg"
boolean LiveScroll=true
end type

type cb_exit from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
int X=695
int Y=1184
int Width=247
int Height=108
int TabOrder=120
string Text="Exit"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(Parent)
end on

type cb_save from commandbutton within w_prompt_for_total_qty_in_schedule_ver2
int X=402
int Y=1184
int Width=247
int Height=108
int TabOrder=110
string Text="Save"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer iTempRow
Integer iTotalRows
String  szPart

Timer(0)

If iWorkOrder > 0 then
	wf_add_into_job(iWorkOrder)
Else
	wf_create_new_job()
End If

//wf_update_qty_assigned()
wf_calc_job_time(w_production_grid.szMachine)

iTotalRows	= dw_template.RowCount()

For iTempRow = 1 to iTotalRows
	szPart			= dw_template.GetItemString(iTempRow, "value1")
	stParm.value1	= szPart
	stParm.value2	= dw_template.GetItemString(iTempRow, "value3")
	stParm.value3	= "M"
//	OpenWithParm(w_calculate_assigned_qty_in_mps, stParm)	//Recalc quantity
   f_update_qty_asgnd_part ( szPart ) // new fn. by mams sp based
	w_production_grid.wf_recalc_crosstab_row(szPart, w_production_grid.dDate7)
Next

close(w_prompt_for_total_qty_in_schedule_ver2)

end event

type sle_4 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=352
int Width=480
int Height=88
int TabOrder=80
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=352
int Width=421
int Height=64
boolean Enabled=false
string Text="Qty Suggested"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=256
int Width=480
int Height=88
int TabOrder=70
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;Long iRow

iRow	= wf_part_in_list(ddlb_part.text)

If iRow > 0 then
	dw_template.SetItem(iRow, "value3", this.text)
End If
	
end on

type st_3 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=256
int Width=421
int Height=64
boolean Enabled=false
string Text="Qty Req"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=160
int Width=480
int Height=88
int TabOrder=60
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=160
int Width=421
int Height=64
boolean Enabled=false
string Text="Mfg Lot"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_prompt_for_total_qty_in_schedule_ver2
int X=73
int Y=64
int Width=421
int Height=64
boolean Enabled=false
string Text="Part Number"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_prompt_for_total_qty_in_schedule_ver2
int X=512
int Y=128
int Width=480
int Height=88
int TabOrder=30
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=8421504
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
int X=1042
int Width=1847
int Height=1344
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
int X=18
int Y=736
int Width=1024
int Height=608
int TabOrder=230
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
int X=18
int Width=1024
int Height=736
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_prompt_for_total_qty_in_schedule_ver2
int X=37
int Y=1600
int Width=2834
int Height=192
int TabOrder=240
string Text="Machine / Requirement Information"
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within w_prompt_for_total_qty_in_schedule_ver2
int X=18
int Y=1344
int Width=2889
int Height=480
boolean Enabled=false
int LineThickness=4
long LineColor=275605865
long FillColor=77897888
end type

type ln_1 from line within w_prompt_for_total_qty_in_schedule_ver2
boolean Enabled=false
int BeginX=18
int BeginY=1568
int EndX=2871
int EndY=1568
int LineThickness=4
long LineColor=65535
end type

type r_runtime from rectangle within w_prompt_for_total_qty_in_schedule_ver2
int X=110
int Y=1472
int Width=878
int Height=96
boolean Enabled=false
int LineThickness=4
long LineColor=8421504
long FillColor=65280
end type

type oval_2 from oval within w_prompt_for_total_qty_in_schedule_ver2
int X=1614
int Y=1348
int Width=73
int Height=64
boolean Enabled=false
int LineThickness=4
long LineColor=8421504
long FillColor=65280
end type

type ln_end from line within w_prompt_for_total_qty_in_schedule_ver2
boolean Enabled=false
int BeginX=2615
int BeginY=1472
int EndX=2615
int EndY=1600
int LineThickness=16
long LineColor=255
end type

type ln_start from line within w_prompt_for_total_qty_in_schedule_ver2
boolean Enabled=false
int BeginX=110
int BeginY=1472
int EndX=110
int EndY=1600
int LineThickness=16
long LineColor=255
end type


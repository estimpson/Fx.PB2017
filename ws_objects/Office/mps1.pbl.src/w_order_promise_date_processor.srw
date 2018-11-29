$PBExportHeader$w_order_promise_date_processor.srw
$PBExportComments$(mps1)
forward
global type w_order_promise_date_processor from w_sheet_4t
end type
type cbx_overlap from checkbox within w_order_promise_date_processor
end type
type st_machine from statictext within w_order_promise_date_processor
end type
type st_message_for_drop from statictext within w_order_promise_date_processor
end type
type st_9 from statictext within w_order_promise_date_processor
end type
type sle_days from singlelineedit within w_order_promise_date_processor
end type
type sle_promise_date from singlelineedit within w_order_promise_date_processor
end type
type ln_shift2 from line within w_order_promise_date_processor
end type
type ln_shift1 from line within w_order_promise_date_processor
end type
type ln_date2 from line within w_order_promise_date_processor
end type
type ln_date3 from line within w_order_promise_date_processor
end type
type ln_date6 from line within w_order_promise_date_processor
end type
type ln_date1 from line within w_order_promise_date_processor
end type
type ln_date9 from line within w_order_promise_date_processor
end type
type ln_date8 from line within w_order_promise_date_processor
end type
type ln_date7 from line within w_order_promise_date_processor
end type
type ln_date4 from line within w_order_promise_date_processor
end type
type ln_date11 from line within w_order_promise_date_processor
end type
type ln_date22 from line within w_order_promise_date_processor
end type
type ln_date33 from line within w_order_promise_date_processor
end type
type ln_date35 from line within w_order_promise_date_processor
end type
type ln_date36 from line within w_order_promise_date_processor
end type
type ln_date37 from line within w_order_promise_date_processor
end type
type ln_date38 from line within w_order_promise_date_processor
end type
type ln_date39 from line within w_order_promise_date_processor
end type
type ln_date5 from line within w_order_promise_date_processor
end type
type ln_date12 from line within w_order_promise_date_processor
end type
type ln_date13 from line within w_order_promise_date_processor
end type
type ln_date14 from line within w_order_promise_date_processor
end type
type ln_date15 from line within w_order_promise_date_processor
end type
type ln_date16 from line within w_order_promise_date_processor
end type
type ln_date17 from line within w_order_promise_date_processor
end type
type ln_date18 from line within w_order_promise_date_processor
end type
type ln_date19 from line within w_order_promise_date_processor
end type
type ln_date20 from line within w_order_promise_date_processor
end type
type ln_date21 from line within w_order_promise_date_processor
end type
type ln_date23 from line within w_order_promise_date_processor
end type
type ln_date24 from line within w_order_promise_date_processor
end type
type ln_date25 from line within w_order_promise_date_processor
end type
type ln_date26 from line within w_order_promise_date_processor
end type
type ln_date27 from line within w_order_promise_date_processor
end type
type ln_date28 from line within w_order_promise_date_processor
end type
type ln_date29 from line within w_order_promise_date_processor
end type
type ln_date30 from line within w_order_promise_date_processor
end type
type ln_date31 from line within w_order_promise_date_processor
end type
type ln_date32 from line within w_order_promise_date_processor
end type
type ln_date34 from line within w_order_promise_date_processor
end type
type ln_date10 from line within w_order_promise_date_processor
end type
type str_mps from structure within w_order_promise_date_processor
end type
end forward

type str_mps from structure
    string ss_part
    date sdt_duedate
    date sdt_startdead
    decimal {6} sd_quantity
    integer si_xpos
    integer si_ypos
    decimal {6} sd_runtime
    time st_starttime
    string ss_machine
    string ss_workorder
    decimal {2} sc_qty_completed
end type

global type w_order_promise_date_processor from w_sheet_4t
integer x = 214
integer y = 221
integer height = 1560
string title = "Order Promise Date Processor"
string menuname = "m_order_promise_date"
event ue_clicked_mps pbm_custom01
event ue_double_clicked_mps pbm_custom02
event ue_dragdrop_mps pbm_custom03
event ue_save_note pbm_custom04
event ue_close_uo_note pbm_custom05
event ue_save_mps_datetime pbm_custom06
event ue_optimize pbm_custom07
cbx_overlap cbx_overlap
st_machine st_machine
st_message_for_drop st_message_for_drop
st_9 st_9
sle_days sle_days
sle_promise_date sle_promise_date
ln_shift2 ln_shift2
ln_shift1 ln_shift1
ln_date2 ln_date2
ln_date3 ln_date3
ln_date6 ln_date6
ln_date1 ln_date1
ln_date9 ln_date9
ln_date8 ln_date8
ln_date7 ln_date7
ln_date4 ln_date4
ln_date11 ln_date11
ln_date22 ln_date22
ln_date33 ln_date33
ln_date35 ln_date35
ln_date36 ln_date36
ln_date37 ln_date37
ln_date38 ln_date38
ln_date39 ln_date39
ln_date5 ln_date5
ln_date12 ln_date12
ln_date13 ln_date13
ln_date14 ln_date14
ln_date15 ln_date15
ln_date16 ln_date16
ln_date17 ln_date17
ln_date18 ln_date18
ln_date19 ln_date19
ln_date20 ln_date20
ln_date21 ln_date21
ln_date23 ln_date23
ln_date24 ln_date24
ln_date25 ln_date25
ln_date26 ln_date26
ln_date27 ln_date27
ln_date28 ln_date28
ln_date29 ln_date29
ln_date30 ln_date30
ln_date31 ln_date31
ln_date32 ln_date32
ln_date34 ln_date34
ln_date10 ln_date10
end type
global w_order_promise_date_processor w_order_promise_date_processor

type variables
Long	il_RowId, &
	il_SalesOrder

Integer	ii_InitDateLineX, &
	ii_InitDateLineY, &
	ii_DateLineLength, &
	ii_InitFlowRouterX, &
	ii_InitFlowRouterY, &
	ii_InitFlowRouterWidth, &
	ii_InitMachineX, &
	ii_InitMachineY, &
	ii_InitScheduleX, &
	ii_InitScheduleY, &
	ii_TotalGridLines, &
	ii_DateLineDistanceX, &
	ii_DistanceY, &
	ii_DistanceX, &
	ii_InitDateX, &
	ii_InitDateY, &
	ii_Demand_Ptr,&
	ii_InitShiftX, &
	ii_InitShiftY

String	is_Part, &
	is_Activity, &
	is_Machine, &
	is_ParentPart

Date	idt_LastMachineDate, &
	idt_DemandBeginDate, &
	idt_StartDate

Decimal	id_RunTime

u_machines	uo_Machine[]
u_static_text_3d	uo_Activity[]
u_demands	uo_Schedule[]
u_static_text	uo_DateList[]
u_static_text	uo_DateNameList[]
u_static_text	uo_Label[]
u_shifts		uo_Shift[]
u_generic_note	uo_MPS_Note


Line	iln_GridLine[]

Window	iw_Screen = w_order_promise_date_processor, &
	iw_ParentWindow

str_MPS	istr_MPS[], istr_NULL_MPS[]

Boolean	ib_OkToDrop
end variables

forward prototypes
public subroutine wf_initialize_screen ()
public subroutine wf_draw_dates ()
public subroutine wf_position_date (date as_Date)
public subroutine wf_initialize_date_lines ()
public subroutine wf_initialize_control_value ()
public subroutine wf_reset_screen_size (integer as_value, string as_flag)
public function integer wf_screen_size (string as_flag)
public subroutine wf_draw_mps (string as_orgin, string as_rowid)
public subroutine wf_position_schedule (integer ai_count, string as_part, integer as_ypos, date adt_startdate, time at_starttime, decimal ad_runtime)
public subroutine wf_adjust_schedule (integer ai_currentptr)
public subroutine wf_reposition_mps (integer ai_currentptr, integer ai_beginxpos)
public subroutine wf_position_label (integer ai_mps_ptr)
public function datetime wf_datetime_from_pos (integer ai_xpos)
public subroutine wf_enable_mps (boolean ab_Flag)
public function integer wf_pos_from_datetime (datetime adtt_datetime)
public subroutine wf_draw_shifts (string as_machine)
public subroutine wf_position_shift (integer ai_shiftptr, date adt_shiftdate, time at_shifttime, decimal ad_runtime)
public function string wf_flow_router_part (string as_parentpart, string as_part)
public function string wf_parent_part (long al_Order, long al_RowId)
public subroutine wf_position_promise_date (integer as_XPos)
public function datetime wf_machine_available_datatime (string as_machine)
public subroutine wf_position_machine (integer ai_machineptr, integer ai_ypos, date adt_lastdate, time at_lasttime)
public subroutine wf_get_parent_window (window aw_ParentWindow)
public function boolean wf_update_mps (string as_part, date adt_startdate, time at_starttime, date adt_duedate, time at_duetime)
public function boolean wf_update_order_detail (date ad_date)
public function decimal wf_hard_queue_quantity (string as_part)
public function decimal wf_job_completed_qty (string as_part)
public function string wf_work_order (string as_part)
end prototypes

on ue_clicked_mps;Integer	li_Count

st_message_for_drop.visible	= FALSE
ii_Demand_Ptr	= 0
ii_Demand_Ptr	= message.longparm

If ii_Demand_Ptr > 0 AND  ii_Demand_Ptr <= Upperbound( uo_Schedule ) then
	If isValid( uo_Schedule[ ii_Demand_Ptr ] ) then
		st_Machine.text	= uo_Schedule[ii_Demand_ptr].is_Machine
		wf_draw_shifts(st_Machine.text)
	end if
End If
end on

event ue_double_clicked_mps;Integer	li_Count

String	ls_WorkOrder

st_message_for_drop.visible	= FALSE
ii_Demand_Ptr	= 0
ii_Demand_Ptr	= message.longparm

If ii_Demand_Ptr > 0 then
	OpenUserObject(uo_mps_note, 650, 250)
	uo_MPS_note.BringToTop		= TRUE
	uo_MPS_note.uf_assign_parent(w_order_promise_date_processor)
	uo_MPS_note.mle_note.text	= uo_Schedule[ii_Demand_ptr].is_Note	
	st_Machine.text				= uo_Schedule[ii_Demand_ptr].is_Machine
	ls_WorkOrder					= uo_Schedule[ii_Demand_ptr].is_WorkOrder
	wf_draw_shifts(st_Machine.text)
	If ls_WorkOrder > ' ' then
//		OpenWithParm(w_job_information, ls_workorder)	
//		OpenWithParm(w_job_information, lstr_Parm)
//		w_job_information.wf_setup_screen(	ls_WorkOrder, &
//														w_order_promise_date_processor)
//		w_job_information.wf_display_percentage(&
//								w_job_information.wf_get_percentage(ls_WorkOrder))
	End If
End If
end event

on ue_dragdrop_mps;Integer	li_Count

st_message_for_drop.visible	= FALSE
ii_Demand_Ptr	= 0
ii_Demand_Ptr	= message.longparm

If ii_Demand_Ptr > 0 AND ii_Demand_Ptr <= upperbound( uo_Schedule ) then
	if isValid(uo_Schedule[ii_Demand_ptr]) then
		st_Machine.text	= uo_Schedule[ii_Demand_ptr].is_Machine
		wf_draw_shifts(st_Machine.text)
		wf_enable_mps(FALSE)
		uo_Schedule[ii_Demand_Ptr].Drag(Begin!)
	end if
End If
end on

on ue_save_note;uo_Schedule[ii_Demand_Ptr].is_Note	= uo_MPS_note.mle_note.text
CloseUserObject(uo_MPS_note)
If uo_Schedule[ii_Demand_Ptr].is_Note > ' ' then
	uo_Schedule[ii_Demand_Ptr].p_note.PictureName	= "mpsnote.bmp"
Else
	uo_Schedule[ii_Demand_Ptr].p_note.PictureName	= "mpsnont.bmp"
End If
end on

on ue_close_uo_note;CloseUserObject(uo_MPS_note)
end on

on ue_save_mps_datetime;/*
Description	:To save the MPS start/end date/time.
Author		:Jim Wu
Start Date	:01/26/96
Modification:
*/

/* Declaration */
Integer	li_Count

Boolean	lb_NoErrors

/* Initialization */
lb_NoErrors	= TRUE
li_Count		= 1

/* Main Process */

Do while (li_Count <= Upperbound(uo_Schedule)) AND (lb_NoErrors)
	lb_NoErrors	= wf_update_mps(	uo_Schedule[li_Count].is_Part, &
											uo_Schedule[li_Count].idt_StartDate, &
											uo_Schedule[li_Count].it_StartTime, &
											uo_Schedule[li_Count].idt_DueDate, &
											uo_Schedule[li_Count].it_DueTime)	
	li_Count ++												
Loop

If lb_NoErrors then
	lb_NoErrors = wf_update_order_detail( Date(sle_promise_date.text))
	If lb_NoErrors then
		COMMIT;
		iw_ParentWindow.PostEvent("ue_retrieve_detail")
	Else
		ROLLBACK;
	End if
Else
	ROLLBACK;
End If
end on

on ue_optimize;/*
Description	:To automatically optimize the schedule
Author		:Jim Wu
Start Date	:01/26/96
Modification:
*/

/* Declaration */

Integer	li_Count

/* Initialication */

li_Count	= Upperbound(uo_Schedule)

/* Main Process */

If li_Count	> 0  then
	uo_Schedule[li_Count].X	= ii_InitDateLineX
	wf_adjust_schedule(li_Count)
End If
end on

public subroutine wf_initialize_screen ();wf_draw_dates()
wf_draw_mps(String(il_SalesOrder), String(il_RowId))
end subroutine

public subroutine wf_draw_dates ();/*
Description	:To create dynamic user object and use them to display dates.
Author		:Jim Wu
Date			:01/23/96
Modification:
*/

/* Declaration */

Integer	li_Count, &
			li_Total, &
			li_CurrentX, &
			li_CurrentY, &
			li_Distance, &
			li_Days

/* Initialization */


/* Main Process */

li_Total	= UpperBound(uo_DateList)
For li_Count = 1 to li_Total
	CloseUserObject(uo_DateList[li_Count])
Next

li_Total	= UpperBound(uo_DateNameList)
For li_Count	= 1 to li_Total
	CloseUserObject(uo_DateNameList[li_Count])
Next

wf_reset_screen_size(2926, "WIDTH")

For li_Count = 1 to ii_TotalGridLines
	iln_GridLine[li_Count].visible	= FALSE
Next

li_Days	= Long(sle_days.text)
For li_Count = 1 to li_Days
	OpenUserObject(uo_DateList[li_Count])
	OpenUserObject(uo_DateNameList[li_Count])
	uo_DateNameList[li_Count].TextSize	= -9
Next

li_CurrentX = ii_InitDateX
li_CurrentY = ii_InitDateY
li_Distance = ii_DateLineDistanceX

For li_Count = 1 to li_Days

	uo_DateList[li_Count].x 		= li_CurrentX
	uo_DateList[li_Count].y 		= li_CurrentY
	uo_DateNameList[li_Count].x	= li_CurrentX
	uo_DateNameList[li_Count].y	= li_CurrentY - 50
	
	li_CurrentX  += li_Distance
	If li_CurrentX > wf_screen_size("WIDTH") then
		wf_reset_screen_size(li_CurrentX + li_Distance, "WIDTH")
	End If
	
	If li_CurrentX > ln_shift1.EndX then
		ln_shift1.EndX	= li_CurrentX
		ln_shift2.EndX	= li_CurrentX
	End If

Next

If li_Days > 0 then
	wf_Position_date(idt_StartDate)
End If


end subroutine

public subroutine wf_position_date (date as_Date);/*
Description	:To set the date info on the screen
Author		:Jim Wu
Date			:01/23/96
Modification:
*/

/* Declaration */
Integer 	li_Count, &	
			li_TotalDays

Date		ldt_CurDate

/* Initialization */

ldt_CurDate		= as_Date
li_TotalDays	= Long(sle_days.text)

/* Main Process */

For li_Count = 1 to li_TotalDays

	uo_DateList[li_Count].text			= String(ldt_CurDate)
	uo_DateNameList[li_Count].text	= LeftA(DayName(ldt_CurDate), 3)

	ldt_CurDate = RelativeDate(ldt_CurDate, 1)

	If li_Count <= ii_TotalGridLines then
		iln_GridLine[li_Count].BeginX	= uo_DateList[li_Count].X
		iln_GridLine[li_Count].EndX	= uo_DateList[li_Count].X
		iln_GridLine[li_Count].BeginY	= ii_InitDateLineY
		iln_GridLine[li_Count].EndY	= ii_InitDateLineY + ii_DateLineLength
		iln_GridLine[li_Count].Visible= TRUE	
	End If

Next

end subroutine

public subroutine wf_initialize_date_lines ();iln_GridLine[1]	= ln_date1
iln_GridLine[2]	= ln_date2
iln_GridLine[3]	= ln_date3
iln_GridLine[4]	= ln_date4
iln_GridLine[5]	= ln_date5
iln_GridLine[6]	= ln_date6
iln_GridLine[7]	= ln_date7
iln_GridLine[8]	= ln_date8
iln_GridLine[9]	= ln_date9
iln_GridLine[10]	= ln_date10
iln_GridLine[11]	= ln_date11
iln_GridLine[12]	= ln_date12
iln_GridLine[13]	= ln_date13
iln_GridLine[14]	= ln_date14
iln_GridLine[15]	= ln_date15
iln_GridLine[16]	= ln_date16
iln_GridLine[17]	= ln_date17
iln_GridLine[18]	= ln_date18
iln_GridLine[19]	= ln_date19
iln_GridLine[20]	= ln_date20
iln_GridLine[21]	= ln_date21
iln_GridLine[22]	= ln_date22
iln_GridLine[23]	= ln_date23
iln_GridLine[24]	= ln_date24
iln_GridLine[25]	= ln_date25
iln_GridLine[26]	= ln_date26
iln_GridLine[27]	= ln_date27
iln_GridLine[28]	= ln_date28
iln_GridLine[29]	= ln_date29
iln_GridLine[30]	= ln_date30
iln_GridLine[31]	= ln_date31
iln_GridLine[32]	= ln_date32
iln_GridLine[33]	= ln_date33
iln_GridLine[34]	= ln_date34
iln_GridLine[35]	= ln_date35
iln_GridLine[36]	= ln_date36
iln_GridLine[37]	= ln_date37
iln_GridLine[38]	= ln_date38
iln_GridLine[39]	= ln_date39






end subroutine

public subroutine wf_initialize_control_value ();ii_InitDateLineX			= 549
ii_InitDateLineY			= 193
ii_DateLineLength			= 1696
ii_DateLineDistanceX		= 311
ii_InitFlowRouterX		= 19
ii_InitFlowRouterY		= 305
ii_InitFlowRouterWidth	= 525
ii_InitMachineX			= 549
ii_InitMachineY			= 305
ii_InitScheduleX			= 549
ii_InitScheduleY			= 305
ii_DistanceY				= 112
ii_DistanceX				= 311
ii_TotalGridLines			= 39
ii_InitDateX				= 549
ii_InitDateY				= 113
ii_InitShiftX				= 549
ii_InitShiftY				= 205
idt_StartDate				= Today()
ib_OkToDrop					= TRUE
end subroutine

public subroutine wf_reset_screen_size (integer as_value, string as_flag);If as_Flag	= "WIDTH" then
	w_order_promise_date_processor.Width	= as_Value
Else
	w_order_promise_date_processor.Height	= as_Value
End If
end subroutine

public function integer wf_screen_size (string as_flag);If as_Flag	= "WIDTH" then
	Return w_order_promise_date_processor.Width
Else
	Return w_order_promise_date_processor.Height
End If
end function

public subroutine wf_draw_mps (string as_orgin, string as_rowid);/*
Description	:To draw the exploded MPS objects in graphic mode
Author		:Jim Wu
Date			:01/22/96
Mofidication:
*/

/* Declaration */
Decimal	ld_Quantity, &
			ld_RunTime, &
			lc_JobCompleted

DateTime	ldtt_MachineDateTime, &
			ldtt_DueDate, &
			ldtt_StartDead, &
			ldtt_MachineDate, &
			ldt_StartTime, &
			ldt_MachineTime

Date		ldt_DueDate, &
			ldt_StartDead, &
			ldt_MachineDate

String	ls_Part, &
			ls_Machine, &
			ls_Activity, &
			ls_WorkOrder

Integer	li_Count, &
			li_Total, &
			li_XPos, &
			li_YPos, &
			li_MPSCount

Time		lt_StartTime, &
			lt_MachineTime

/* Initialization */
DECLARE	curMPS CURSOR FOR
  SELECT master_prod_sched.part,
			master_prod_sched.due,
			master_prod_sched.dead_start,
			master_prod_sched.qnty,
			master_prod_sched.run_time,
			master_prod_sched.start_time,
			master_prod_sched.machine,
			master_prod_sched.workorder
    FROM master_prod_sched  
   WHERE master_prod_sched.origin 	= :as_Orgin AND
			master_prod_sched.source   = :as_RowId
ORDER BY master_prod_sched.dead_start DESC  ;

istr_MPS	= istr_NULL_MPS

/* Main Process */

li_Count	= 0

OPEN curMPS;

FETCH curMPS INTO :ls_Part, 
						:ldtt_DueDate, 
						:ldtt_StartDead, 
						:ld_Quantity,
						:ld_RunTime,
						:ldt_StartTime,
						:ls_Machine,
						:ls_WorkOrder;

ldt_DueDate		= date(ldtt_DueDate)
ldt_StartDead 	= date(ldtt_StartDead)
lt_StartTime	= Time(ldt_StartTime)



Do while SQLCA.SQLCode = 0 
	li_Count ++
	istr_MPS[li_Count].ss_Part				= ls_Part
	istr_MPS[li_Count].sdt_DueDate		= ldt_DueDate
	istr_MPS[li_Count].sdt_StartDead		= ldt_StartDead
	istr_MPS[li_Count].sd_Quantity		= ld_Quantity
	istr_MPS[li_Count].sd_RunTime			= ld_RunTime
	istr_MPS[li_Count].st_StartTime		= lt_StartTime
	istr_MPS[li_count].ss_Machine			= ls_Machine
	istr_MPS[li_Count].ss_WorkOrder		= ls_WorkOrder
	istr_MPS[li_Count].sc_qty_completed	= wf_job_completed_qty( ls_part )

	FETCH curMPS INTO :ls_Part, 
							:ldtt_DueDate, 
							:ldtt_StartDead, 
							:ld_Quantity,
							:ld_RunTime,
							:ldt_StartTime,
							:ls_Machine,
							:ls_WorkOrder;

	ldt_DueDate		= date(ldtt_DueDate)
	ldt_StartDead 	= date(ldtt_StartDead)
	lt_StartTime	= Time(ldt_StartTime)

Loop

CLOSE curMPS;

li_XPos		= ii_InitScheduleX
li_YPos		= ii_InitScheduleY
li_Total		= UpperBound(istr_MPS)
li_MPSCount	= 0

For li_Count = 1 to li_Total
	ls_Part			= istr_MPS[li_Count].ss_Part
	ldt_StartDead	= istr_MPS[li_Count].sdt_StartDead
	ldt_DueDate		= istr_MPS[li_Count].sdt_DueDate
	ld_Quantity		= istr_MPS[li_Count].sd_Quantity
	ld_RunTime		= istr_MPS[li_Count].sd_RunTime
	lt_StartTime	= istr_MPS[li_Count].st_StartTime
	ls_Machine		= istr_MPS[li_Count].ss_Machine
	lc_JobCompleted= istr_MPS[li_Count].sc_qty_completed
	
	ls_Activity		= wf_flow_router_part(is_ParentPart, ls_Part)
	ls_WorkOrder	= istr_MPS[li_Count].ss_WorkOrder
	
	If ls_Activity > ' ' then
		li_MPSCount ++
		OpenUserObject(uo_Schedule[li_MPSCount])
		uo_Schedule[li_MPSCount].uf_get_parent(w_order_promise_date_processor)
		uo_Schedule[li_MPSCount].visible			= TRUE
		uo_Schedule[li_MPSCount].i_i_Ptr			= li_MPSCount
		uo_Schedule[li_MPSCount].is_Machine		= ls_Machine
		uo_Schedule[li_MPSCount].is_Part			= ls_Part
		uo_Schedule[li_MPSCount].id_RunTime		= ld_RunTime
		uo_Schedule[li_MPSCount].is_WorkOrder	= ls_WorkOrder
		uo_Schedule[li_MPSCount].BringToTop		= TRUE
		
		If ld_RunTime <= 0.5 then
			ld_RunTime	= 1
		Else
			If ld_RunTime > 1000 then
				ld_RunTime	= 1000
			End If
		End If

		uo_Schedule[li_MPSCount].Width	  		= (ii_DistanceX * &
																ld_RunTime ) / 24 
		uo_Schedule[li_MPSCount].st_Part.Width	= uo_Schedule[li_MPSCount].Width
		uo_Schedule[li_MPSCount].st_Part.Text	= ''
		uo_Schedule[li_MPSCount].Visible 		= TRUE
		uo_Schedule[li_MPSCount].ic_QtyCompleted	= lc_JobCompleted
		uo_Schedule[li_MPSCount].ic_QtyRequired	= ld_Quantity
		uo_Schedule[li_MPSCount].uf_set_hours_completed( )
		uo_Schedule[li_MPSCount].is_WorkOrder	= wf_work_order( ls_part )

		OpenUserObject(uo_Label[li_MPSCount])
		uo_Label[li_MPSCount].Text					= ls_Part
		uo_Label[li_MPSCount].Width				= LenA(ls_Part) * 50
		uo_Label[li_MPSCount].TextSize			= -8
		uo_Label[li_MPSCount].Alignment			= Left!

		wf_position_schedule(li_MPSCount, ls_Part, li_YPos , ldt_StartDead, &
							 		lt_StartTime, ld_RunTime)

		OpenUserObject(uo_Activity[li_MPSCount])
		uo_Activity[li_MPSCount].Text				= ls_Activity
		uo_Activity[li_MPSCount].TextSize		= -8
		uo_Activity[li_MPSCount].Move(ii_InitFlowRouterX, li_YPos)
		uo_Activity[li_MPSCount].Width			= ii_InitFlowRouterWidth

		ldtt_MachineDateTime	= wf_machine_available_datatime(ls_Machine)
		ldt_MachineDate		= Date(ldtt_MachineDateTime)
		lt_MachineTime			= Time(ldtt_MachineDateTime)				
		OpenUserObject(uo_Machine[li_MPSCount])
		uo_Machine[li_MPSCount].BackColor	= 255
		uo_Machine[li_MPSCount].text			= ls_machine
		wf_position_machine(li_MPSCount, li_Ypos, &
								  ldt_MachineDate, lt_MachineTime)

		li_YPos		  += ii_DistanceY
	End If
Next

If Upperbound(uo_Schedule) > 0 then
	wf_position_promise_date(uo_Schedule[1].x + uo_Schedule[1].Width)
End If
end subroutine

public subroutine wf_position_schedule (integer ai_count, string as_part, integer as_ypos, date adt_startdate, time at_starttime, decimal ad_runtime);/*
Description	:To graphically draw the schedule object
Author		:Jim Wu
Date			:01/22/96
Modification:
*/

/* Declaration */
Decimal 	ld_StartHour
Decimal 	ld_StartMin

Long		ll_Color 

Boolean	lb_Add

/* Initialization */


/* Main Process */

If adt_StartDate < Today() then
	adt_StartDate	= Today()
	at_StartTime	= Now()
Else
	If (adt_StartDate = Today()) AND (at_StartTime < Now()) then
		at_StartTime= Now()
	End If
End If

ld_StartHour = Hour(at_StartTime)
ld_StartMin  = Minute(at_StartTime)

uo_Schedule[ai_Count].Move(&
	ii_InitScheduleX + (DaysAfter(Date(uo_DateList[1].text), adt_Startdate) * &
	ii_DistanceX) + (ii_DistanceX * (ld_StartHour + &
	(ld_StartMin / 60)) / 24) &
	, as_YPos)
uo_Schedule[ai_Count].Width			= (ad_Runtime * ii_DistanceX / 24)
uo_Schedule[ai_Count].st_Part.Width	= uo_Schedule[ai_Count].Width
wf_position_label(ai_Count)

end subroutine

public subroutine wf_adjust_schedule (integer ai_currentptr);/*
Description	:To adjust affected schedules after the current MPS schedule 
				 has been changed.
Author		:Jim Wu
Start Date	:1/23/96
Mofication	:
*/

/* Declaration */
Integer 	li_MPS_Ptr, &
			li_XEndPos

/* Initialization */

/* Main Process */

li_XEndPos	= 	uo_Schedule[ai_CurrentPtr].X

If ai_CurrentPtr < Upperbound(uo_Schedule) then
	If li_XEndPos < uo_Schedule[ai_CurrentPtr + 1].X + &
						 uo_Schedule[ai_CurrentPtr + 1].Width then
		li_XEndPos	= uo_Schedule[ai_CurrentPtr + 1].X + &
						  uo_Schedule[ai_CurrentPtr + 1].Width
	End If
End If

For li_MPS_Ptr	= 	ai_CurrentPtr  to 1 Step -1
	If li_XEndPos < 	uo_Machine[li_MPS_Ptr].X +  &
							uo_Machine[li_MPS_Ptr].Width then
		li_XEndPos	=	uo_Machine[li_MPS_Ptr].X + &
							uo_Machine[li_MPS_Ptr].Width
	End If

	wf_reposition_mps(li_MPS_Ptr, li_XEndPos)
	
	li_XEndPos	=	uo_Schedule[li_MPS_Ptr].X + &
						uo_Schedule[li_MPS_Ptr].Width
Next

If Upperbound(uo_Schedule) > 0 then
	wf_position_promise_date(uo_Schedule[1].x + uo_Schedule[1].Width)
End If


end subroutine

public subroutine wf_reposition_mps (integer ai_currentptr, integer ai_beginxpos);/*
Description	:Reposition the MPS schedule on the screen according to the
				 shopfloor calendar.
Author		:Jim Wu
Start Date	:01/23/96
Modification:
*/

/* Declaration */
Date		ldt_Date

Time		lt_Time

DateTime	ldtt_DateTime, &
			ldtt_StartDateTime

String	ls_Machine, &
			ls_Part

Decimal	ld_RunTime

/* Initialization */


/* Main Process */

ldtt_StartDateTime	= wf_datetime_from_pos(ai_BeginXPos)
ls_Machine				= uo_Schedule[ai_CurrentPtr].is_Machine
ls_Part					= uo_Schedule[ai_CurrentPtr].is_Part
ld_RunTime				= uo_Schedule[ai_CurrentPtr].id_RunTime
ldtt_StartDateTime	= f_block_start_datetime(ls_Machine, &
							  Date(ldtt_StartDateTime), &
							  Time(ldtt_StartDateTime))
ldtt_DateTime			= f_block_end_datetime(ls_Machine, &
							  Date(ldtt_StartDateTime), &
							  Time(ldtt_StartDateTime), &
							  ld_RunTime)

uo_Schedule[ai_CurrentPtr].idt_StartDate	= Date(ldtt_StartDateTime)
uo_Schedule[ai_CurrentPtr].it_StartTime	= Time(ldtt_StartDateTime)
uo_Schedule[ai_CurrentPtr].idt_DueDate		= Date(ldtt_DateTime)
uo_Schedule[ai_CurrentPtr].it_DueTime		= Time(ldtt_StartDateTime)

ld_RunTime				= (wf_pos_from_datetime(ldtt_DateTime) - &
								wf_pos_from_datetime(ldtt_StartDateTime)) * 24 / &
								ii_DistanceX

wf_position_schedule(ai_CurrentPtr, &
							ls_Part, &
							uo_Schedule[ai_CurrentPtr].Y, &
							Date(ldtt_StartDateTime), &
							Time(ldtt_StartDateTime), &
							ld_RunTime)
							

end subroutine

public subroutine wf_position_label (integer ai_mps_ptr);uo_Label[ai_mps_ptr].Move(	uo_Schedule[ai_mps_ptr].x + &
									uo_Schedule[ai_mps_ptr].width + 35,&
									uo_Schedule[ai_mps_ptr].y)
end subroutine

public function datetime wf_datetime_from_pos (integer ai_xpos);/*
Decription	:To calculate the data time based on the X position
Author		:Jim Wu
Start Date	:01/23/96
Modification:
*/

/* Declaration */
Integer	li_Days

Decimal	li_TotalHrs

Date		ldt_Date

/* Initialization */

/* Main Process */

li_TotalHrs	= Truncate((ai_XPos - ii_InitDateLineX) * 24 &
								/ ii_DateLineDistanceX, 0)
li_Days		= Truncate(li_TotalHrs/24, 0)
li_TotalHrs	= li_TotalHrs - (li_Days * 24)

Return DateTime(RelativeDate(Date(uo_DateList[1].Text), li_Days), &
					 RelativeTime(Time("00:00:00"), li_TotalHrs * 3600))

end function

public subroutine wf_enable_mps (boolean ab_Flag);Integer li_Count

For li_Count = 1 to Upperbound(uo_Schedule)
	uo_Schedule[li_Count].Enabled				= ab_Flag
	uo_Schedule[li_Count].st_Part.Enabled	= ab_Flag
Next
end subroutine

public function integer wf_pos_from_datetime (datetime adtt_datetime);Date		ld_Date, &
			ld_StartDate

Integer	li_Hr, &
			li_Min, &
			li_Second

Decimal	ld_Days

ld_StartDate= Date(uo_DateList[1].text)
ld_Date		= Date(adtt_datetime)
li_Hr			= Hour(Time(adtt_datetime))
li_Min		= Minute(Time(adtt_datetime))
li_Second	= Second(Time(adtt_datetime))
ld_Days		= DaysAfter(ld_StartDate, ld_Date) + &
				  (li_Hr + (li_Min / 60)) / 24					  

Return ii_InitScheduleX + ld_Days * ii_DistanceX

end function

public subroutine wf_draw_shifts (string as_machine);/*
Description	:To draw the shift objects.
Author		:Jim Wu
Start Date	:01/23/96
Modification:
*/

/* Declaration */
Date		ldt_StartDate, &
			ldt_EndDate, &
			ldt_ShiftDate

Datetime	ldtt_StartDate, &
			ldtt_EndDate, &
			ldtt_ShiftDate, &
			ldt_ShiftTime

Time		lt_ShiftTime

Decimal	ld_Runtime

Integer	li_Count

DECLARE curShopCalendar CURSOR FOR  
 SELECT shop_floor_calendar_new.work_date,   
        shop_floor_calendar_new.begin_time,   
        shop_floor_calendar_new.up_hours  
   FROM shop_floor_calendar_new 
  WHERE shop_floor_calendar_new.machine    =  :as_Machine AND
		  shop_floor_calendar_new.work_date >= :ldtt_StartDate AND
	     shop_floor_calendar_new.work_date <= :ldtt_EndDate  ;

/* Initialization */

ldt_StartDate	= Date(uo_DateList[1].text)
ldt_EndDate		= RelativeDate(ldt_StartDate, Integer(sle_days.text))
ldtt_StartDate	= datetime(ldt_StartDate)
ldtt_EndDate	= datetime(ldt_EndDate)

/* Main Process */

For li_Count = 1 to Upperbound(uo_Shift)
	CloseUserObject(uo_Shift[li_Count])
Next

li_Count	= 0

OPEN curShopCalendar;

FETCH curShopCalendar INTO :ldtt_ShiftDate, :ldt_ShiftTime, :ld_RunTime;

ldt_shiftdate = date(ldtt_shiftdate)
lt_shifttime = time(ldt_shifttime)

Do while SQLCA.SQLCode = 0 
	li_Count ++
	OpenUserObject(uo_Shift[li_Count])
	uo_Shift[li_Count].i_i_Ptr					= li_Count
	uo_Shift[li_Count].i_t_ShiftBeginTime	= lt_ShiftTime
	uo_Shift[li_Count].i_dt_StartDate		= ldt_ShiftDate
	uo_Shift[li_Count].i_d_ShiftHour			= ld_RunTime
	wf_position_shift(li_Count, ldt_ShiftDate, lt_ShiftTime, ld_RunTime)
	ldtt_StartDate	= datetime(ldt_StartDate)
	ldtt_EndDate	= datetime(ldt_EndDate)
	FETCH curShopCalendar INTO :ldt_ShiftDate, :lt_ShiftTime, :ld_RunTime;
	ldt_shiftdate = date(ldtt_shiftdate)
	lt_shifttime = time(ldt_shifttime)

Loop

CLOSE curShopCalendar;
end subroutine

public subroutine wf_position_shift (integer ai_shiftptr, date adt_shiftdate, time at_shifttime, decimal ad_runtime);/*
Description	:To graphically draw the shift object
Author		:Jim Wu
Date			:01/23/96
Modification:
*/

/* Declaration */
Integer 	li_StartHour
Integer 	li_StartMin

/* Initialization */


/* Main Process */

li_StartHour = Hour(at_ShiftTime)
li_StartMin  = Minute(at_ShiftTime)

uo_Shift[ai_ShiftPtr].Move(&
	ii_InitScheduleX + (DaysAfter(Date(uo_DateList[1].text), adt_Shiftdate) * &
	ii_DistanceX) + (ii_DistanceX * (li_StartHour + &
	(li_StartMin / 60)) / 24) &
	, ii_InitShiftY)

uo_Shift[ai_ShiftPtr].Width	= ad_RunTime * ii_DistanceX / 24



end subroutine

public function string wf_flow_router_part (string as_parentpart, string as_part);/*
Description	:Check whether the part is in the flow router.
Author		:Jim Wu
Start Date	:1/24/96
Modification:
*/

/* Declaration */
String	ls_Activity

/* Initialization */


/* Main Process */

SELECT activity_router.code  
  INTO :ls_Activity
  FROM activity_router  
 WHERE ( activity_router.parent_part = :as_ParentPart ) AND  
       ( activity_router.part = :as_Part )   ;

Return ls_Activity 
end function

public function string wf_parent_part (long al_Order, long al_RowId);/*
Description	:To select the part number from the order/row id.
Author		:Jim Wu
Start Date	:1/24/96
Modification:
*/

/* Declaratiion */
String ls_part

/* Initializatiion */

/* Main Process */

SELECT order_detail.part_number  
  INTO :ls_Part  
  FROM order_detail  
 WHERE ( order_detail.order_no = :al_Order ) AND  
       ( order_detail.row_id = :al_RowId )   ;

Return ls_Part
end function

public subroutine wf_position_promise_date (integer as_XPos);/*
Description	:Position the sle_promise_date
Author		:Jim Wu
Date			:01/24/96
Modification:
*/

/* Declaration */
Integer	li_Days

/* Initialization */


/* Main Process */

li_Days					= Truncate((as_XPos - ii_InitDateLineX) / &
							  ii_DistanceX, 0)
sle_promise_date.x	= as_XPos
sle_promise_date.text= String(RelativeDate(Date(uo_DateList[1].text), li_Days))
end subroutine

public function datetime wf_machine_available_datatime (string as_machine);/*
Description	:To calculate the first machine available date/time.
Author		:Jim Wu
Start Date	:1/24/96
Modification:
*/

/* Declaration */

Date		ldt_EndDate
Time		lt_EndTime

DateTime	ldtt_Result, ldtt_EndDate, ldt_EndTime

DECLARE 	curDateTime CURSOR FOR  
SELECT 	work_order.end_date,   
       	work_order.end_time  
  FROM 	work_order  
 WHERE 	work_order.machine_no = :as_Machine   
ORDER BY work_order.end_date DESC,   
         work_order.end_time DESC  ;

/* Initialization */
ldtt_Result	= DateTime(Today(), Now())

/* Main Process */

OPEN curDateTime;

FETCH curDateTime INTO :ldtt_EndDate, :ldt_EndTime;
ldt_EndDate = date(ldtt_EndDate)
lt_EndTime = time(ldt_EndTime)

If SQLCA.SQLCODE = 0 then
	ldtt_Result	= DateTime(ldt_EndDate, lt_EndTime)
End If

CLOSE curDateTime;

Return ldtt_Result

end function

public subroutine wf_position_machine (integer ai_machineptr, integer ai_ypos, date adt_lastdate, time at_lasttime);/*
Description	:To draw the machine object.
Author		:Jim Wu
Date			:01/24/96
Modification:
*/

/* Declaration */

Integer	li_Xpos, &
			li_Hr, &
			li_Min

/* Initialization */


/* Main Process */

li_Hr 	= Hour(at_LastTime)
li_Min  	= Minute(at_LastTime)
li_XPos	= ii_InitScheduleX + (DaysAfter(Date(uo_DateList[1].text), adt_Lastdate) * &
	ii_DistanceX) + (ii_DistanceX * (li_Hr + (li_Min / 60)) / 24) 

uo_Machine[ai_MachinePtr].Move(ii_InitShiftX , ai_YPos )

uo_Machine[ai_MachinePtr].Width	= (li_XPos - ii_InitShiftX)



end subroutine

public subroutine wf_get_parent_window (window aw_ParentWindow);/*
Description	:To get the parent window
Author		:Jim Wu
Start Date	:01/26/96
Modification:
*/

/* Declaration */

/* Initialization */

/* Main Process */
iw_ParentWindow	= aw_ParentWindow


end subroutine

public function boolean wf_update_mps (string as_part, date adt_startdate, time at_starttime, date adt_duedate, time at_duetime);/*
Description	:To save the MPS date/time.
Author		:Jim Wu
Date			:01/26/96
Modification:
*/

/* Declaration */

datetime ldt_startdate, ldt_starttime, ldt_duedate, ldt_duetime

/* Initialization */

ldt_startdate	= datetime(adt_startdate)
ldt_starttime	= datetime(adt_startdate, at_starttime)
ldt_duedate		= datetime(adt_duedate)
ldt_duetime		= datetime(adt_duedate, at_duetime)

/* Main Process */

UPDATE 	master_prod_sched  
	SET 	due 			= :ldt_DueDate,   
        	due_time 	= :ldt_DueTime,   
        	dead_start 	= :ldt_StartDate,   
        	start_time	= :ldt_StartTime  
WHERE (	master_prod_sched.part	 = :as_Part) AND
		( 	master_prod_sched.origin = :il_SalesOrder ) AND  
      ( 	master_prod_sched.source = :il_RowId )   ;


Return	(SQLCA.SQLCODE = 0)

end function

public function boolean wf_update_order_detail (date ad_date);/* 
Description	:To save the promised date as order detail data.
Author		:Jim Wu
Start Date	:01/26/96
Modification:
*/

/* Declaration */

datetime ldt_date

/* Initialication */

ldt_date = datetime(ad_date)

/* Main Process */

UPDATE order_detail  
	SET due_date = :ldt_Date  
 WHERE ( order_detail.order_no 	= :il_SalesOrder ) AND  
       ( order_detail.row_id		= :il_RowId )   ;

Return (SQLCA.SQLCODE = 0)
end function

public function decimal wf_hard_queue_quantity (string as_part);/*
Description	:	To get the total quantity in hard queue
Author		:	Jim Wu
Start Date	:	04/14/96
Modification:
*/


/* Declaration */
decimal	lc_quantity

/* Initialization */


/* Main Process */

SELECT sum( balance )  
  INTO :lc_quantity  
  FROM workorder_detail  
 WHERE part = :as_part   ;

Return lc_quantity
end function

public function decimal wf_job_completed_qty (string as_part);/*
Description	:	To get the total quantity in hard queue
Author		:	Jim Wu
Start Date	:	04/14/96
Modification:
*/


/* Declaration */
decimal	lc_quantity

/* Initialization */


/* Main Process */

SELECT sum( qty_completed )  
  INTO :lc_quantity  
  FROM workorder_detail  
 WHERE part = :as_part   ;

Return lc_quantity
end function

public function string wf_work_order (string as_part);string ls_work_order

SELECT workorder_detail.workorder  
  INTO :ls_work_order  
  FROM workorder_detail  
 WHERE workorder_detail.part = :as_part   ;

return ls_work_order
end function

on dragdrop;If ii_Demand_Ptr > 0  then
	uo_Schedule[ii_Demand_Ptr].Move(PointerX() - &
			(uo_Schedule[ii_Demand_Ptr].Width / 2), uo_Schedule[ii_Demand_Ptr].Y)
	wf_position_label(ii_Demand_Ptr)
	wf_adjust_schedule(ii_Demand_Ptr)
	wf_position_promise_date(uo_Schedule[1].x + uo_Schedule[1].Width)
	uo_Schedule[ii_Demand_Ptr].uf_set_hours_completed()
End If

wf_enable_mps(TRUE)


end on

event open;call super::open;st_Generic_Structure	lstr_Parm

lstr_Parm		= Message.PowerObjectParm

il_SalesOrder	= Long(lstr_Parm.Value1)
il_RowId			= Long(lstr_Parm.Value2)

is_ParentPart	= wf_parent_part(il_SalesOrder, il_RowId)

If is_ParentPart > ' ' then
	wf_initialize_date_lines()
	wf_initialize_control_value()
	wf_initialize_screen()
	Timer(.5)
Else
	MessageBox('Warning', 'The original part number is not found in sales order.', &
					StopSign!)
	Return
End If

end event

on timer;If sle_promise_date.textcolor	= 255 then
	sle_promise_date.textColor	= 0
Else
	sle_promise_date.textColor	= 255
End If
end on

on dragwithin;//ib_OkToDrop	= TRUE
//
//If ii_Demand_Ptr > 0 then
//	ib_OkToDrop	= ( (PointerX() - &
//						 uo_Schedule[ii_Demand_Ptr].Width / 2) >= ii_InitDateLineX )
//	If ib_OkToDrop then
//		If ii_Demand_Ptr < Upperbound(uo_Schedule) then
//			ib_OkToDrop	= ( (PointerX() - uo_Schedule[ii_Demand_Ptr].Width / 2) &
//								 > uo_Schedule[ii_Demand_Ptr + 1].X)
//		End If
//	End If
//End If
//
//st_message_for_drop.Visible	= Not (ib_OkToDrop)
//If Not ib_OkToDrop then
//	st_message_for_drop.Move(PointerX() - &
//				(uo_Schedule[ii_Demand_Ptr].Width / 2), PointerY() - 150)
//End If			
end on

on w_order_promise_date_processor.create
int iCurrent
call super::create
if this.MenuName = "m_order_promise_date" then this.MenuID = create m_order_promise_date
this.cbx_overlap=create cbx_overlap
this.st_machine=create st_machine
this.st_message_for_drop=create st_message_for_drop
this.st_9=create st_9
this.sle_days=create sle_days
this.sle_promise_date=create sle_promise_date
this.ln_shift2=create ln_shift2
this.ln_shift1=create ln_shift1
this.ln_date2=create ln_date2
this.ln_date3=create ln_date3
this.ln_date6=create ln_date6
this.ln_date1=create ln_date1
this.ln_date9=create ln_date9
this.ln_date8=create ln_date8
this.ln_date7=create ln_date7
this.ln_date4=create ln_date4
this.ln_date11=create ln_date11
this.ln_date22=create ln_date22
this.ln_date33=create ln_date33
this.ln_date35=create ln_date35
this.ln_date36=create ln_date36
this.ln_date37=create ln_date37
this.ln_date38=create ln_date38
this.ln_date39=create ln_date39
this.ln_date5=create ln_date5
this.ln_date12=create ln_date12
this.ln_date13=create ln_date13
this.ln_date14=create ln_date14
this.ln_date15=create ln_date15
this.ln_date16=create ln_date16
this.ln_date17=create ln_date17
this.ln_date18=create ln_date18
this.ln_date19=create ln_date19
this.ln_date20=create ln_date20
this.ln_date21=create ln_date21
this.ln_date23=create ln_date23
this.ln_date24=create ln_date24
this.ln_date25=create ln_date25
this.ln_date26=create ln_date26
this.ln_date27=create ln_date27
this.ln_date28=create ln_date28
this.ln_date29=create ln_date29
this.ln_date30=create ln_date30
this.ln_date31=create ln_date31
this.ln_date32=create ln_date32
this.ln_date34=create ln_date34
this.ln_date10=create ln_date10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_overlap
this.Control[iCurrent+2]=this.st_machine
this.Control[iCurrent+3]=this.st_message_for_drop
this.Control[iCurrent+4]=this.st_9
this.Control[iCurrent+5]=this.sle_days
this.Control[iCurrent+6]=this.sle_promise_date
this.Control[iCurrent+7]=this.ln_shift2
this.Control[iCurrent+8]=this.ln_shift1
this.Control[iCurrent+9]=this.ln_date2
this.Control[iCurrent+10]=this.ln_date3
this.Control[iCurrent+11]=this.ln_date6
this.Control[iCurrent+12]=this.ln_date1
this.Control[iCurrent+13]=this.ln_date9
this.Control[iCurrent+14]=this.ln_date8
this.Control[iCurrent+15]=this.ln_date7
this.Control[iCurrent+16]=this.ln_date4
this.Control[iCurrent+17]=this.ln_date11
this.Control[iCurrent+18]=this.ln_date22
this.Control[iCurrent+19]=this.ln_date33
this.Control[iCurrent+20]=this.ln_date35
this.Control[iCurrent+21]=this.ln_date36
this.Control[iCurrent+22]=this.ln_date37
this.Control[iCurrent+23]=this.ln_date38
this.Control[iCurrent+24]=this.ln_date39
this.Control[iCurrent+25]=this.ln_date5
this.Control[iCurrent+26]=this.ln_date12
this.Control[iCurrent+27]=this.ln_date13
this.Control[iCurrent+28]=this.ln_date14
this.Control[iCurrent+29]=this.ln_date15
this.Control[iCurrent+30]=this.ln_date16
this.Control[iCurrent+31]=this.ln_date17
this.Control[iCurrent+32]=this.ln_date18
this.Control[iCurrent+33]=this.ln_date19
this.Control[iCurrent+34]=this.ln_date20
this.Control[iCurrent+35]=this.ln_date21
this.Control[iCurrent+36]=this.ln_date23
this.Control[iCurrent+37]=this.ln_date24
this.Control[iCurrent+38]=this.ln_date25
this.Control[iCurrent+39]=this.ln_date26
this.Control[iCurrent+40]=this.ln_date27
this.Control[iCurrent+41]=this.ln_date28
this.Control[iCurrent+42]=this.ln_date29
this.Control[iCurrent+43]=this.ln_date30
this.Control[iCurrent+44]=this.ln_date31
this.Control[iCurrent+45]=this.ln_date32
this.Control[iCurrent+46]=this.ln_date34
this.Control[iCurrent+47]=this.ln_date10
end on

on w_order_promise_date_processor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_overlap)
destroy(this.st_machine)
destroy(this.st_message_for_drop)
destroy(this.st_9)
destroy(this.sle_days)
destroy(this.sle_promise_date)
destroy(this.ln_shift2)
destroy(this.ln_shift1)
destroy(this.ln_date2)
destroy(this.ln_date3)
destroy(this.ln_date6)
destroy(this.ln_date1)
destroy(this.ln_date9)
destroy(this.ln_date8)
destroy(this.ln_date7)
destroy(this.ln_date4)
destroy(this.ln_date11)
destroy(this.ln_date22)
destroy(this.ln_date33)
destroy(this.ln_date35)
destroy(this.ln_date36)
destroy(this.ln_date37)
destroy(this.ln_date38)
destroy(this.ln_date39)
destroy(this.ln_date5)
destroy(this.ln_date12)
destroy(this.ln_date13)
destroy(this.ln_date14)
destroy(this.ln_date15)
destroy(this.ln_date16)
destroy(this.ln_date17)
destroy(this.ln_date18)
destroy(this.ln_date19)
destroy(this.ln_date20)
destroy(this.ln_date21)
destroy(this.ln_date23)
destroy(this.ln_date24)
destroy(this.ln_date25)
destroy(this.ln_date26)
destroy(this.ln_date27)
destroy(this.ln_date28)
destroy(this.ln_date29)
destroy(this.ln_date30)
destroy(this.ln_date31)
destroy(this.ln_date32)
destroy(this.ln_date34)
destroy(this.ln_date10)
end on

type cbx_overlap from checkbox within w_order_promise_date_processor
integer x = 18
integer y = 48
integer width = 421
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Overlap Mode"
end type

type st_machine from statictext within w_order_promise_date_processor
integer y = 204
integer width = 530
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_message_for_drop from statictext within w_order_promise_date_processor
boolean visible = false
integer y = 204
integer width = 549
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Unable to reschedule"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_order_promise_date_processor
integer x = 18
integer y = 112
integer width = 384
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Days to Display"
boolean focusrectangle = false
end type

type sle_days from singlelineedit within w_order_promise_date_processor
integer x = 475
integer y = 96
integer width = 73
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "14"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_promise_date from singlelineedit within w_order_promise_date_processor
integer x = 2542
integer y = 208
integer width = 183
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "1/31/96"
boolean autohscroll = false
end type

type ln_shift2 from line within w_order_promise_date_processor
long linecolor = 33554432
integer linethickness = 4
integer beginy = 288
integer endx = 2871
integer endy = 288
end type

type ln_shift1 from line within w_order_promise_date_processor
long linecolor = 33554432
integer linethickness = 4
integer beginy = 192
integer endx = 2853
integer endy = 192
end type

type ln_date2 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 859
integer beginy = 192
integer endx = 859
integer endy = 1888
end type

type ln_date3 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 1152
integer beginy = 192
integer endx = 1152
integer endy = 1888
end type

type ln_date6 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 1682
integer beginy = 192
integer endx = 1682
integer endy = 1888
end type

type ln_date1 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 549
integer beginy = 192
integer endx = 549
integer endy = 1888
end type

type ln_date9 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2688
integer beginy = 192
integer endx = 2688
integer endy = 1888
end type

type ln_date8 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2377
integer beginy = 192
integer endx = 2377
integer endy = 1888
end type

type ln_date7 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2030
integer beginy = 192
integer endx = 2030
integer endy = 1888
end type

type ln_date4 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 1426
integer beginy = 192
integer endx = 1426
integer endy = 1888
end type

type ln_date11 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 208
integer endx = 2834
integer endy = 1904
end type

type ln_date22 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 224
integer endx = 2834
integer endy = 1920
end type

type ln_date33 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 240
integer endx = 2834
integer endy = 1936
end type

type ln_date35 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 256
integer endx = 2834
integer endy = 1952
end type

type ln_date36 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 272
integer endx = 2834
integer endy = 1968
end type

type ln_date37 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 288
integer endx = 2834
integer endy = 1984
end type

type ln_date38 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 304
integer endx = 2834
integer endy = 2000
end type

type ln_date39 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 320
integer endx = 2834
integer endy = 2016
end type

type ln_date5 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 336
integer endx = 2834
integer endy = 2032
end type

type ln_date12 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 352
integer endx = 2834
integer endy = 2048
end type

type ln_date13 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2926
integer beginy = 208
integer endx = 2926
integer endy = 1904
end type

type ln_date14 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 384
integer endx = 2834
integer endy = 2080
end type

type ln_date15 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 400
integer endx = 2834
integer endy = 2096
end type

type ln_date16 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 416
integer endx = 2834
integer endy = 2112
end type

type ln_date17 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 432
integer endx = 2834
integer endy = 2128
end type

type ln_date18 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 448
integer endx = 2834
integer endy = 2144
end type

type ln_date19 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 464
integer endx = 2834
integer endy = 2160
end type

type ln_date20 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 480
integer endx = 2834
integer endy = 2176
end type

type ln_date21 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 496
integer endx = 2834
integer endy = 2192
end type

type ln_date23 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 512
integer endx = 2834
integer endy = 2208
end type

type ln_date24 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 528
integer endx = 2834
integer endy = 2224
end type

type ln_date25 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 544
integer endx = 2834
integer endy = 2240
end type

type ln_date26 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 560
integer endx = 2834
integer endy = 2256
end type

type ln_date27 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 576
integer endx = 2834
integer endy = 2272
end type

type ln_date28 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 592
integer endx = 2834
integer endy = 2288
end type

type ln_date29 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 608
integer endx = 2834
integer endy = 2304
end type

type ln_date30 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 624
integer endx = 2834
integer endy = 2320
end type

type ln_date31 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 640
integer endx = 2834
integer endy = 2336
end type

type ln_date32 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 656
integer endx = 2834
integer endy = 2352
end type

type ln_date34 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 672
integer endx = 2834
integer endy = 2368
end type

type ln_date10 from line within w_order_promise_date_processor
long linecolor = 33554432
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2834
integer beginy = 688
integer endx = 2834
integer endy = 2384
end type


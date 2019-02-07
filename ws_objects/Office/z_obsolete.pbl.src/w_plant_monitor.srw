$PBExportHeader$w_plant_monitor.srw
$PBExportComments$(mps1) Changed the routine so it can display shifts.
forward
global type w_plant_monitor from Window
end type
type ddlb_ from dropdownlistbox within w_plant_monitor
end type
type uo_time_grid2 from u_time_grid within w_plant_monitor
end type
type st_message from statictext within w_plant_monitor
end type
type st_machine from statictext within w_plant_monitor
end type
type ddlb_display from dropdownlistbox within w_plant_monitor
end type
type st_1 from statictext within w_plant_monitor
end type
type hsb_date from hscrollbar within w_plant_monitor
end type
type ddlb_flash from dropdownlistbox within w_plant_monitor
end type
type vsb_machine from vscrollbar within w_plant_monitor
end type
type st_3 from statictext within w_plant_monitor
end type
type sle_days_to_display from singlelineedit within w_plant_monitor
end type
type r_new_shift from u_shifts within w_plant_monitor
end type
type sle_1 from singlelineedit within w_plant_monitor
end type
type st_39 from statictext within w_plant_monitor
end type
type st_25 from statictext within w_plant_monitor
end type
type st_order from statictext within w_plant_monitor
end type
type sle_check from singlelineedit within w_plant_monitor
end type
type st_check from statictext within w_plant_monitor
end type
type dw_earliest_releases from datawindow within w_plant_monitor
end type
type sle_order from singlelineedit within w_plant_monitor
end type
type dw_comm_mat_set from datawindow within w_plant_monitor
end type
type p_1 from picture within w_plant_monitor
end type
type dw_customer_in_order from datawindow within w_plant_monitor
end type
type dw_groups_in_location from datawindow within w_plant_monitor
end type
type dw_machine_in_group from datawindow within w_plant_monitor
end type
type ddlb_machine_type from dropdownlistbox within w_plant_monitor
end type
type dw_sorted_jobs from datawindow within w_plant_monitor
end type
type dw_mps_item_by_parent_id from datawindow within w_plant_monitor
end type
type dw_mps_item_by_id from datawindow within w_plant_monitor
end type
type dw_check_machine from datawindow within w_plant_monitor
end type
type dw_work_order_detail from datawindow within w_plant_monitor
end type
type dw_jobs_for_machine from datawindow within w_plant_monitor
end type
type dw_schedule from datawindow within w_plant_monitor
end type
type dw_mps_in_work_order from datawindow within w_plant_monitor
end type
type dw_jobs from datawindow within w_plant_monitor
end type
type dw_jobs_in_time_order from datawindow within w_plant_monitor
end type
type dw_machine_list from datawindow within w_plant_monitor
end type
type dw_workorder from datawindow within w_plant_monitor
end type
type sle_drag from singlelineedit within w_plant_monitor
end type
type mle_message from multilineedit within w_plant_monitor
end type
type st_time from statictext within w_plant_monitor
end type
type uo_time_grid1 from u_time_grid within w_plant_monitor
end type
type ddlb_type_value from dropdownlistbox within w_plant_monitor
end type
type gb_selection from groupbox within w_plant_monitor
end type
type r_shift_block from rectangle within w_plant_monitor
end type
type ln_1 from line within w_plant_monitor
end type
type ln_time from line within w_plant_monitor
end type
type ln_3 from line within w_plant_monitor
end type
type oval_2 from oval within w_plant_monitor
end type
type oval_3 from oval within w_plant_monitor
end type
type oval_4 from oval within w_plant_monitor
end type
type oval_5 from oval within w_plant_monitor
end type
type oval_6 from oval within w_plant_monitor
end type
type oval_7 from oval within w_plant_monitor
end type
type oval_8 from oval within w_plant_monitor
end type
type oval_9 from oval within w_plant_monitor
end type
type oval_10 from oval within w_plant_monitor
end type
type oval_11 from oval within w_plant_monitor
end type
type oval_12 from oval within w_plant_monitor
end type
type oval_1 from oval within w_plant_monitor
end type
type ln_date1 from line within w_plant_monitor
end type
type ln_date2 from line within w_plant_monitor
end type
type ln_date3 from line within w_plant_monitor
end type
type ln_date4 from line within w_plant_monitor
end type
type ln_date5 from line within w_plant_monitor
end type
type ln_date6 from line within w_plant_monitor
end type
type ln_date7 from line within w_plant_monitor
end type
type ln_date8 from line within w_plant_monitor
end type
type ln_date14 from line within w_plant_monitor
end type
type ln_date13 from line within w_plant_monitor
end type
type ln_date12 from line within w_plant_monitor
end type
type ln_date11 from line within w_plant_monitor
end type
type ln_date10 from line within w_plant_monitor
end type
type ln_date9 from line within w_plant_monitor
end type
type ln_date16 from line within w_plant_monitor
end type
type ln_date17 from line within w_plant_monitor
end type
type ln_date18 from line within w_plant_monitor
end type
type ln_date19 from line within w_plant_monitor
end type
type ln_date20 from line within w_plant_monitor
end type
type ln_date21 from line within w_plant_monitor
end type
type ln_date22 from line within w_plant_monitor
end type
type ln_date23 from line within w_plant_monitor
end type
type ln_date24 from line within w_plant_monitor
end type
type ln_date25 from line within w_plant_monitor
end type
type ln_date26 from line within w_plant_monitor
end type
type ln_date27 from line within w_plant_monitor
end type
type ln_date28 from line within w_plant_monitor
end type
type ln_date29 from line within w_plant_monitor
end type
type ln_date30 from line within w_plant_monitor
end type
type ln_date31 from line within w_plant_monitor
end type
type ln_date32 from line within w_plant_monitor
end type
type ln_date33 from line within w_plant_monitor
end type
type ln_date34 from line within w_plant_monitor
end type
type ln_date35 from line within w_plant_monitor
end type
type ln_date36 from line within w_plant_monitor
end type
type ln_date37 from line within w_plant_monitor
end type
type ln_date38 from line within w_plant_monitor
end type
type ln_date39 from line within w_plant_monitor
end type
type ln_date40 from line within w_plant_monitor
end type
type ln_date41 from line within w_plant_monitor
end type
type ln_date15 from line within w_plant_monitor
end type
type ln_date42 from line within w_plant_monitor
end type
end forward

type related_jobs_list from structure
    string parent_job
    string child_job
end type

type related_mps_list from structure
    long id
    long parent_id
    string Job
end type

type job_index from structure
    long job_index
    long job_color
    long sales_order
    string part
    long qty_onhand
    long qty_required
    date job_end_date
    date release_date
end type

global type w_plant_monitor from Window
int X=0
int Y=0
int Width=3543
int Height=1792
boolean TitleBar=true
string Title="Machine Schedule Monitor "
long BackColor=77897888
boolean ControlMenu=true
boolean Resizable=true
event redraw pbm_custom01
event update_shift pbm_custom02
event ue_select_job pbm_custom03
event ue_double_clicked_job pbm_custom04
event ue_drag_job pbm_custom05
event ue_change_view_date pbm_custom06
event ue_recalc_time pbm_custom07
event ue_delete_job pbm_custom08
event ue_soft_queue pbm_custom09
event ue_flash_selection pbm_custom10
event ue_fresh_screen pbm_custom11
event ue_machine_policy pbm_custom12
event ue_double_clicked_shift pbm_custom13
event ue_drag_shift pbm_custom14
event we_nchittest pbm_nchittest
event ue_redraw_job ( any a_s_machine )
event ue_manual_wo ( )
ddlb_ ddlb_
uo_time_grid2 uo_time_grid2
st_message st_message
st_machine st_machine
ddlb_display ddlb_display
st_1 st_1
hsb_date hsb_date
ddlb_flash ddlb_flash
vsb_machine vsb_machine
st_3 st_3
sle_days_to_display sle_days_to_display
r_new_shift r_new_shift
sle_1 sle_1
st_39 st_39
st_25 st_25
st_order st_order
sle_check sle_check
st_check st_check
dw_earliest_releases dw_earliest_releases
sle_order sle_order
dw_comm_mat_set dw_comm_mat_set
p_1 p_1
dw_customer_in_order dw_customer_in_order
dw_groups_in_location dw_groups_in_location
dw_machine_in_group dw_machine_in_group
ddlb_machine_type ddlb_machine_type
dw_sorted_jobs dw_sorted_jobs
dw_mps_item_by_parent_id dw_mps_item_by_parent_id
dw_mps_item_by_id dw_mps_item_by_id
dw_check_machine dw_check_machine
dw_work_order_detail dw_work_order_detail
dw_jobs_for_machine dw_jobs_for_machine
dw_schedule dw_schedule
dw_mps_in_work_order dw_mps_in_work_order
dw_jobs dw_jobs
dw_jobs_in_time_order dw_jobs_in_time_order
dw_machine_list dw_machine_list
dw_workorder dw_workorder
sle_drag sle_drag
mle_message mle_message
st_time st_time
uo_time_grid1 uo_time_grid1
ddlb_type_value ddlb_type_value
gb_selection gb_selection
r_shift_block r_shift_block
ln_1 ln_1
ln_time ln_time
ln_3 ln_3
oval_2 oval_2
oval_3 oval_3
oval_4 oval_4
oval_5 oval_5
oval_6 oval_6
oval_7 oval_7
oval_8 oval_8
oval_9 oval_9
oval_10 oval_10
oval_11 oval_11
oval_12 oval_12
oval_1 oval_1
ln_date1 ln_date1
ln_date2 ln_date2
ln_date3 ln_date3
ln_date4 ln_date4
ln_date5 ln_date5
ln_date6 ln_date6
ln_date7 ln_date7
ln_date8 ln_date8
ln_date14 ln_date14
ln_date13 ln_date13
ln_date12 ln_date12
ln_date11 ln_date11
ln_date10 ln_date10
ln_date9 ln_date9
ln_date16 ln_date16
ln_date17 ln_date17
ln_date18 ln_date18
ln_date19 ln_date19
ln_date20 ln_date20
ln_date21 ln_date21
ln_date22 ln_date22
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
ln_date33 ln_date33
ln_date34 ln_date34
ln_date35 ln_date35
ln_date36 ln_date36
ln_date37 ln_date37
ln_date38 ln_date38
ln_date39 ln_date39
ln_date40 ln_date40
ln_date41 ln_date41
ln_date15 ln_date15
ln_date42 ln_date42
end type
global w_plant_monitor w_plant_monitor

type variables
u_machines     	MachineList[]

u_static_text	sDate[], &
		sNullDate[], &
	       	sDateName[], &
		sNullDateName[]
		
Date 	dShiftDate, &
	dReleaseDate

Long iDistanceY = 100            //iDistance in Y coordinate
Long iDistanceX = 345          //Distance  in X coordinate
Long iJobX                           //X pos for current job
Long iJobY                           //Y pos for current job
Long iInitShiftX  = 465           //Initial Shift Pos for X
Long iInitShiftY  = 269	 //Initial Y position
Long iTotalShifts                   //Total shifts available
Long iShiftCount                    //The current shift counter
Long iBlackColor
Long iCurrentShiftNo             //The current shift number
Long iSoftQueueRow             //The current row in soft queue
Long iGreenColor  = 65280     //Red color
Long iRelatedJobsCount = 0   //Related jobs count
Long iRelatedMpsCount  = 0   //Related mps count
Long iProcessedMpsCount = 0 //Processed MPS count
Long iLineCount = 0            	//Line count
Long iCurrentJobNo              //Current job number
Long iJobLabelCount = 0       //Current job label count number
Long iSoftQueueCol              //Current column in soft queue
Long iOrderDetailCount	//How many detail items	
Long iFlashColor		//Color to flash
Long iSalesOrder		//Sales Order
Long iMachineRow		//The current machine row
Long iTimeCount		//How many times in time event

String szJob                         //Current job number
String szMachine                  //Current Machine number
String szOrderDetail[]	//Order detail
String szPart		//To keep the part number
String szReturnedstring

Int    iMaxJobLabel    = 10    //Max for total job labels
Int    iMaxMachineNo = 15   //Total machines on screen
Int    iMaxJobNo        = 106   //Total jobs available
Int    iInitMachineX    = 20     //Initial X pos for machine
Int    iInitMachineY    = 375   //Initial Y pos for machine
Int    iInitJobX           = 465   //Initial X pos for job
Int    iJobCount         = 0       //Job counter
Int    iMachineCount  = 0       //Machine Count
Int    iTotalJobs         = 0      //Total job number for current machine
Int    iShiftBarY         = 229   //The pos of gray bar for shift
Int    iShiftBarHeight  = 84     //The height of gray bar
Int    iLastInIndex		//The last index in JobIndex[]
Int    iLastOverCompIndex	//The last index in the over-completed job #	
Int    iMessageBarWidth = 238//The length for message bar
Int    iInitDateX = 476
Int    iInitDateY = 177
Int    iCurInitJobX = 465
Int    ii_OrigGridLineX[]
Int    ii_factor = 1		//1: Display by date, 3:by time

Integer	i_i_TotalDays = 14
Integer	i_i_TotalGridLines = 42
Integer	i_i_GridLineWidth = 1500
Integer	i_i_InitGridLineY = 257
Integer	i_i_DayCounter

u_jobs	JobList[], &
	CurrentJob

u_shifts 	ShiftList[], &
	NullShiftList[], &
	CurrentShift

Boolean  bDrawShift
Boolean  bDragShift              //Drag new shift
Boolean  bDragExistingShift   //Drag existing shift
Boolean  bFlash		//Whether to flash
Boolean  i_b_FreshScreen	//Whether to fresh screen
Boolean  ib_display_by_date	= TRUE

Time       tShiftBeginTime      //Shift Start
Time       tShiftEndTime         //Shift End

Decimal   nShiftHour             //Hours for shift
Decimal	nQtyOnHand	//On Hand qty
Decimal	nQtyRequired	//Qty required

Line                     LineList[20]
Related_mps_list   RelatedMpsList[]     	     //Related Mps list
Related_mps_list   ProcessedMpsList[]      //List of processed MPS pair
Related_jobs_list   RelatedJobsList[]         //Save all related jobs
Job_index	JobIndex[]	     //Job index
Job_index	OverCompIndex[]        //List of jobs of over-completed	

st_generic_structure stParm			

Long	i_i_ColorList[]

Line	i_ln_GridLine[]


end variables

forward prototypes
public subroutine initialize_machine ()
public function date next_day (date today)
public subroutine display_dates (date today)
public subroutine initialize_job ()
public subroutine assign_rec ()
public function string select_job (integer x, integer y)
public subroutine redraw ()
public subroutine initialize_date (date ddate)
public function string select_machine (long x, long y)
public subroutine draw_time_bar ()
public function string select_dragdrop_machine (long Y)
public function date get_calc_date (date Today, long iOffSet)
public subroutine draw_shifts ()
public subroutine invisible_shifts ()
public function decimal hours_after (date dStartDate, time tStartTime, date dEndDate, time tEndTime)
public subroutine select_shift (integer x, integer y)
public subroutine locate_shift_date_time (integer currentx)
public subroutine recalc_machine_job_time (string szmachine)
public subroutine rearrange_sequence (string szMachine)
public subroutine flag_machine (string szjob)
public function long get_machine_color (string szpart, string szmachine)
public function integer get_machine_no (integer Y)
public subroutine search_related_jobs (string szjob)
public subroutine initialize_lines ()
public subroutine link_jobs ()
public function boolean is_on_screen (string szjob)
public subroutine updt_related_jobs_list (long iid, string szflag, string szcurrentjob, datawindow dwmpswin)
public function boolean mps_is_not_processed (long iId, long iParent_id)
public subroutine invisible_jobs ()
public subroutine initialize_labels ()
public subroutine set_order_for_job (string szparentjob, string szjob, int iparentjobno, int ijobno)
public subroutine label_jobs ()
public function boolean machine_in_group (string szmachine, string szgroup)
public subroutine get_group ()
public subroutine get_customers ()
public function boolean right_customer (string szorder)
public function int wf_job_order_in_machine (string szmachine, string szjob)
public subroutine wf_mat_shortage_list ()
public function integer wf_get_job_sequence (string szjob)
public function boolean wf_job_is_short_material (string szjob)
public function boolean wf_job_part_in_sales_order (string szjob)
public subroutine wf_job_list_for_sales_order ()
public subroutine wf_create_list_of_late_parts ()
public subroutine wf_list_of_late_jobs ()
public function boolean wf_find_late_part (string szjob, date djobenddate)
public function integer wf_get_job_index_number (long ijobrow)
public subroutine wf_refresh_machine (long imachinerow)
public function boolean wf_have_jobs (string szmachine)
public function boolean wf_job_is_touched (string szjob)
public function long wf_job_color (long l_i_job)
public subroutine wf_initialize_color_list ()
public subroutine wf_set_color_list ()
public subroutine picture_shift (string szmachine, long icurrenty, time tstarttime, decimal nuphours, ref u_shifts rshift, date dstartdate)
public subroutine wf_enable_job_objects (boolean l_b_Status)
public subroutine wf_display_message (string szjob, string sztype, integer ai_jobptr)
public subroutine wf_x_move (integer ai_value, integer ai_direction)
public subroutine wf_y_move (integer ai_value, integer ai_direction)
public subroutine wf_set_x_position (integer ai_value)
public subroutine wf_set_y_position (integer ai_value)
public function string wf_first_job_part (string as_WorkOrder)
public function boolean wf_close_job_windows ()
public subroutine wf_display_machines ()
public function long wf_machine_pos_y (string as_machine)
public subroutine draw_job (integer icurrenty, date dstartdate, time tstarttime, decimal nruntime, string l_s_machine, string as_job)
public subroutine wf_destroy_objects ()
public subroutine wf_bubble_help (integer ai_x, integer ai_y, integer ai_height, string as_help)
public function boolean wf_any_late_part (string as_job, date djobenddate)
public subroutine wf_save_job_to_history (string as_job)
end prototypes

on redraw;redraw()
If szMachine > "" then
	draw_shifts()
End If
end on

on update_shift;dw_schedule.SetItem(iCurrentShiftNo, "begin_time", tShiftBeginTime)
dw_schedule.SetItem(iCurrentShiftNo, "up_hours", nShiftHour)

If dw_schedule.Update() > 0 then
	Commit;
Else
	Rollback;
End If

szMachine	= st_machine.text

draw_shifts()											//Redraw the shifts

Recalc_machine_job_time(st_machine.text)		//Recalc the execution for machine
Redraw()													//Redraw the jobs on screen
end on

on ue_select_job;String	szMessageType
Long		l_i_JobPtr

l_i_JobPtr		= Long(szReturnedString)
sle_1.text 		= JobList[l_i_JobPtr].i_s_job
 
If sle_1.text > " " then
	If (ddlb_flash.text > " ") AND bFlash then
		szMessageType	= "FLASH"
	Else
		szMessageType	= "NORMAL"
	End If
	wf_display_message(sle_1.text, szMessageType, l_i_JobPtr)		
End If

szMachine		= szReturnedPart

If szMachine > "" then
	st_machine.text	= szMachine 
	draw_shifts()
End If


end on

event ue_double_clicked_job;If sle_1.text > "" then								//Double click the current job
//	OpenWithParm(w_job_information, sle_1.text )
	OpenSheetWithParm(w_job_information, sle_1.text, wmainscreen, 4, Original! )	
End If
end event

event ue_drag_job;String	szMessageType

Long		l_i_JobPtr

l_i_JobPtr							= Long(szReturnedString)
szMachine							= szReturnedPart
CurrentJob							= JobList[l_i_JobPtr]
sle_1.text							= CurrentJob.i_s_Job

wf_enable_job_objects(FALSE)

sle_drag.Move(JobList[l_i_JobPtr].X, JobList[l_i_JobPtr].Y)
sle_drag.Width		= JobList[l_i_JobPtr].Width
sle_drag.Drag(Begin!)

bDragShift	= FALSE
end event

event ue_change_view_date;If Long(sle_days_to_display.text) > 0 then
	bDrawShift	= TRUE
	Open(w_select_view_job_date)
Else
	MessageBox(monsys.msg_title, "Invalid number for 'Days to display'", StopSign!)
End If
end event

event ue_recalc_time;Long iRow

Str_progress  sparm

sparm.Title = "Job Execution Time"

OpenWithParm(w_progress, sparm)

For iRow = 1 to dw_machine_list.RowCount()

	szMachine	= dw_machine_list.GetItemString(iRow, "machine_no")
	w_progress.wf_progress(iRow  / dw_machine_list.RowCount(), "Calculating Job Execution Time For Machine " +szMachine)
	If wf_have_jobs(szMachine) then
		OpenWithParm(w_calculate_job_time, szMachine)
	End If

Next

Close(w_progress)
ReDraw()
end event

event ue_soft_queue;OpenSheetWithParm ( w_create_jobs_from_soft_queue, szMachine, wmainscreen, 3, Original! )
end event

on ue_flash_selection;Long iCount

If bFlash then

	Choose Case ddlb_flash.text

		Case "Material Shortage"
			wf_mat_shortage_list()
			iFlashColor	= 255
			bFlash		= TRUE
			Timer(.5)

		Case "Sales Order"
			wf_job_list_for_sales_order()
			iFlashColor	= 65280
			bFlash		= TRUE
			Timer(.5)	

		Case "Late Jobs"
			wf_list_of_late_jobs()
			iFlashColor	= 255  //16711680
			bFlash		= TRUE
			Timer(.5)
		
	End Choose

Else
	sle_order.visible	= FALSE
	For iCount = 1 to iLastInIndex
		JobList[JobIndex[iCount].Job_index].st_job.BackColor = JobIndex[iCount].Job_color
	Next
End If
end on

on ue_fresh_screen;iMachineRow	= 0
iTimeCount	= 0

st_check.visible		=  i_b_FreshScreen
sle_check.visible		=  i_b_FreshScreen

st_check.BringToTop	=  i_b_FreshScreen
sle_check.BringToTop	= i_b_FreshScreen
end on

event ue_machine_policy;Close(w_job_information)
OpenSheet(w_production_policy, wmainscreen, 3, Original!)			//set up policy for production 
w_production_policy.BringToTop	= TRUE

end event

on ue_double_clicked_shift;str_shiftparm1  istr_shift  

iCurrentShiftNo	= Long(szReturnedString)

istr_shift.s_machine 	=   szMachine
istr_shift.dt_begindatetime = DateTime ( ShiftList [iCurrentShiftNo].i_dt_StartDate, ShiftList [ iCurrentShiftNo].i_t_ShiftBeginTime )

Openwithparm ( w_create_new_shift_wizard, istr_shift )

draw_shifts ( )

end on

on ue_drag_shift;//iCurrentShiftNo		= Long(szReturnedString)
//
//If iCurrentShiftNo > 0 then
//	tShiftBeginTime	= ShiftList[iCurrentShiftNo].i_t_ShiftBeginTime
//	nShiftHour			= ShiftList[iCurrentShiftNo].i_d_ShiftHour
//	dShiftDate			= ShiftList[iCurrentShiftNo].i_dt_StartDate
//	bDragExistingShift = TRUE
//	sle_drag.Move(ShiftList[iCurrentShiftNo].X, ShiftList[iCurrentShiftNo].Y)
//	sle_drag.Width		= ShiftList[iCurrentShiftNo].Width
//	sle_drag.Drag(Begin!)
//Else
//	bDragExistingShift = FALSE
//End If
//
//bDragShift	= TRUE
end on

on we_nchittest;st_message.visible	= FALSE
end on

event ue_redraw_job;LONG l_l_count

STRING l_s_machine[]
		 
l_s_machine = a_s_machine
	
FOR l_l_count = 1 TO  UPPERBOUND ( l_s_machine )
		
	w_plant_monitor.Recalc_machine_job_time ( l_s_machine [ l_l_count ] )

NEXT

gnv_App.of_GetFrame().setmicrohelp ( 'Redrawing the jobs.... ' )
w_plant_monitor.Redraw ( )
gnv_App.of_GetFrame().setmicrohelp ( 'Ready.. ' )
	

end event

event ue_manual_wo;opensheet(w_manual_wo_create,wmainscreen, 4, Original!)
end event

public subroutine initialize_machine ();
end subroutine

public function date next_day (date today);Integer iMonth				//Number of month
Integer iYear				//Number of year
Integer iDay				//Number of day
Integer iDaysInMonth		//Total days in month

iDay   = day(today)
iMonth = month(today)
iYear  = year(today)

If iDay = days_in_month(iMonth, iYear) then
	iDay = 1
	If iMonth = 12 then
		iMonth = 1
		iYear  = iYear + 1
	Else
		iMonth = iMonth + 1
	End If
Else
	iDay = iDay + 1
End If

Return Date(iYear, iMonth, iDay) 




end function

public subroutine display_dates (date today);Integer 	l_i_Count
Integer	l_i_TotalDays
Integer	li_GridLineX

Date		l_d_CurDate

l_d_CurDate		= Today


if not ib_display_by_date then
	sle_days_to_display.text	= '2'
end if

l_i_TotalDays	= Long(sle_days_to_display.text)
li_GridLineX	= iCurInitJobX
	
For l_i_Count = 1 to l_i_TotalDays 

	sDate[l_i_Count].text		= String(l_d_CurDate)
	If ib_display_by_date then
		sDateName[l_i_Count].text	= LeftA(DayName(l_d_CurDate), 3)
	Else
		SDateName[l_i_Count].text	= String(l_d_CurDate) + ' (' + &
											LeftA(DayName(l_d_CurDate), 3) + ')'
		SDateName[l_i_Count].bringtotop	= TRUE
	End If

	l_d_CurDate = next_day(l_d_CurDate)

	If l_i_Count <= i_i_TotalGridLines then
		i_ln_GridLine[l_i_Count].BeginX	= li_GridLineX
		i_ln_GridLine[l_i_Count].EndX		= li_GridLineX
		i_ln_GridLine[l_i_Count].BeginY	= i_i_InitGridLineY
		i_ln_GridLine[l_i_Count].EndY		= i_i_InitGridLineY + &
													  i_i_GridLineWidth	
		i_ln_GridLine[l_i_Count].Visible	= TRUE	
		ii_OrigGridLineX[l_i_Count]		= i_ln_GridLine[l_i_Count].BeginX

		li_GridLineX							+= (ii_factor * iDistanceX)

	End If

Next
















end subroutine

public subroutine initialize_job ();//************************************************************************
//* Declaration
//************************************************************************

Long iRow
Long iCurrentY
Long iCount
Long l_i_TotalDays

Date dStartDate
Date dEndDate

Time tStartTime
Time tEndTime

Decimal nRunTime

String szCurMachine

Boolean bSearchMore
Boolean bProcess			//Whether to process the current job 

//*************************************************************************
//*Initialization
//************************************************************************

l_i_TotalDays			= Long(sle_Days_to_display.text)
dw_jobs.Retrieve(Date(sDate[1].text), Date(sDate[l_i_TotalDays].text))
bSearchMore 			= TRUE
iCurrentY  				= iInitMachineY - iDistanceY
iMachineCount 			= 0
iTotalJobs  			= 0
iRow						= 1
iJobCount 				= 0
iLastOverCompIndex	= 0

wf_display_machines()

Do while bSearchMore AND (iRow <= dw_jobs.RowCount())

	bProcess	= TRUE
	If ddlb_machine_type.text = "Group" then     	//If list for group
		bProcess	= machine_in_group(dw_jobs.GetItemString(iRow, "machine_no"), ddlb_type_value.text)
	End If
		
	If (bProcess) AND (NOT IsNull(dw_jobs.GetItemString(iRow, "type"))) then
		bProcess	= (dw_jobs.GetItemString(iRow, "type") <> "S") 
	End If

	If bProcess then		
		If dw_jobs.GetItemString(iRow, "machine_no") <> szCurMachine then
			szCurMachine 	= dw_jobs.GetItemString(iRow, "machine_no")
			iCurrentY		= wf_machine_pos_y( szCurMachine )
		End If

		If iCurrentY > 0 then
			dStartDate 	= dw_jobs.GetItemDate(iRow, "start_Date")
			tStartTime 	= dw_jobs.GetItemTime(iRow, "start_time")
			dEndDate		= dw_jobs.GetItemDate(iRow, "End_date")
			tEndTime		= dw_jobs.GetItemTime(iRow, "End_time")
	
			If dw_jobs.GetItemNumber(iRow, "runtime") > 0 then
				nRunTime = Hours_After(dStartDate, tStartTime, dEndDate, tEndTime)
			Else
				nRunTime	= 0
			End If

			szJob		  	= dw_jobs.GetItemString(iRow, "work_order")
			iJobCount  	= iJobCount + 1

			Draw_job(iCurrentY, dStartDate, tStartTime, &
						nRunTime, szCurMachine, szJob)
		End If

	End If

	iRow = iRow + 1

Loop
		
vsb_machine.MaxPosition	= (UpperBound(MachineList) * iDistanceY)
vsb_machine.Position		= 0
hsb_date.Position			= 0



	

end subroutine

public subroutine assign_rec ();//JobList[1] = r_1
//JobList[2] = r_2
//JobList[3] = r_3
//JobList[4] = r_4
//JobList[5] = r_5
//JobList[6] = r_6
//JobList[7] = r_7
//JobList[8] = r_8
//JobList[9] = r_9
//JobList[10] = r_10
//JobList[11] = r_11
//JobList[12] = r_12
//JobList[13] = r_13
//JobList[14] = r_14
//JobList[15] = r_15
//JobList[16] = r_16
//JobList[17] = r_17
//JobList[18] = r_18
//JobList[19] = r_19
//JobList[20] = r_20
//JobList[21] = r_21
//JobList[22] = r_22
//JobList[23] = r_23
//JobList[24] = r_24
//JobList[25] = r_25
//JobList[26] = r_26
//JobList[27] = r_27
//JobList[28] = r_28
//JobList[29] = r_29
//JobList[30] = r_30
//JobList[31] = r_31

//JobList[32] = r_32
//JobList[33] = r_33
//JobList[34] = r_34
//JobList[35] = r_35
//JobList[36] = r_36
//JobList[37] = r_37
//JobList[38] = r_38
//JobList[39] = r_39
//JobList[40] = r_40
//JobList[41] = r_41
//JobList[42] = r_42
//JobList[43] = r_43
//JobList[44] = r_44
//JobList[45] = r_45
//JobList[46] = r_46
//JobList[47] = r_47
//JobList[48] = r_48
//JobList[49] = r_49
//JobList[50] = r_50
//JobList[51] = r_51
//JobList[52] = r_52
//JobList[53] = r_53
//JobList[54] = r_54
//JobList[55] = r_55
//JobList[56] = r_56
//JobList[57] = r_57
//JobList[58] = r_58
//JobList[59] = r_59
//JobList[60] = r_60
//JobList[61] = r_61
//JobList[62] = r_62
//JobList[63] = r_63
//JobList[64] = r_64
//JobList[65] = r_65
//JobList[66] = r_66
//JobList[67] = r_67
//JobList[68] = r_68
//JobList[69] = r_69
//JobList[70] = r_70
//JobList[71] = r_71
//JobList[72] = r_72
//JobList[73] = r_73
//JobList[74] = r_74
//JobList[75] = r_75
//JobList[76] = r_76
//JobList[77] = r_77
//JobList[78] = r_78
//JobList[79] = r_79
//JobList[80] = r_80
//JobList[81] = r_81
//JobList[82] = r_82
//JobList[83] = r_83
//JobList[84] = r_84
//JobList[85] = r_85
//JobList[86] = r_86
//JobList[87] = r_87
//JobList[88] = r_88
//JobList[89] = r_89
//JobList[90] = r_90
//JobList[91] = r_91
//JobList[92] = r_92
//JobList[93] = r_93
//JobList[94] = r_94
//JobList[95] = r_95
//JobList[96] = r_96
//JobList[97] = r_97
//JobList[98] = r_98
//JobList[99] = r_99
//JobList[100] = r_100
//JobList[101] = r_101
//JobList[102] = r_102
//JobList[103] = r_103
//JobList[104] = r_104
//JobList[105] = r_105
//JobList[106] = r_106
//
end subroutine

public function string select_job (integer x, integer y);Long iCount
Long iBeginX, iBeginY
Long iEndX, iEndY
Boolean bFound
String szJobSelected

iCount = 1
szJobSelected = ""
iJobX = 0
iJobY = 0
 
Do while (Not bFound) AND (iCount <= iJobCount)
	iBeginX 	= JobList[iCount].X
	iBeginY 	= JobList[iCount].Y
	iEndX		= iBeginX + JobList[iCount].Width
	iEndY		= iBeginY + JobList[iCount].Height

	If (X >= iBeginX) AND (X <= iEndX) AND (Y >= iBeginY) AND (Y <= iEndY) then
		bFound = TRUE
		szJobSelected = JobList[iCount].Tag
		iJobX  = X
		iJobY  = Y
		CurrentJob = JobList[iCount]
	End If

	iCount = iCount + 1

Loop

Return szJobSelected
	
end function

public subroutine redraw ();Date	l_d_Date
Int 	iCount

For iCount = 1 to iMachineCount
	MachineList[iCount].Visible 	= FALSE
	CloseUserObject(MachineList[iCount])
Next

For iCount = 1 to iJobCount
	JobList[iCount].visible	= FALSE
	CloseUserObject(JobList[iCount])
Next

For iCount = 1 to i_i_TotalGridLines
	i_ln_GridLine[iCount].visible	= FALSE
Next

l_d_Date	= Date(sDate[1].text)
For iCount = 1 to i_i_DayCounter
	CloseUserObject(sDate[iCount])
	CloseUserObject(sDateName[iCount])
Next

sDate				= sNullDate
sDateName		= sNullDateName

iCurInitJobX	= iInitJobX

Initialize_date(l_d_Date)
Initialize_job()

draw_time_bar()
end subroutine

public subroutine initialize_date (date ddate);Integer iDistance
Integer iCurrentX
Integer iCurrentY
Integer iCount
Integer l_i_TotalDays


For iCount = 1 to i_i_TotalGridLines
	i_ln_GridLine[iCount].visible	= FALSE
Next

if not ib_display_by_date then
	sle_days_to_display.text 	= '2'
end if

l_i_TotalDays	= Long(sle_days_to_display.text)
For iCount = 1 to l_i_TotalDays
	OpenUserObject(sDate[iCount])
	OpenUserObject(sDateName[iCount])
	sDateName[iCount].TextSize	= -9
Next

iCurrentX = iCurInitJobX + 50
iCurrentY = iInitDateY

iDistance 					= iDistanceX

For iCount = 1 to l_i_TotalDays

	sDate[iCount].x 		= iCurrentX
	sDate[iCount].y 		= iCurrentY
	sDateName[iCount].x	= iCurrentX
	sDateName[iCount].y	= iCurrentY - 50
	sDate[iCount].il_OrigPos		= sDate[iCount].X
	sDateName[iCount].il_OrigPos	= sDateName[iCount].X
	iCurrentX = iCurrentX + (ii_factor * iDistance)

	
Next

Display_dates(dDate)

i_i_DayCounter	= l_i_TotalDays


end subroutine

public function string select_machine (long x, long y);Long iCount
Long iBeginX, iBeginY
Long iEndX, iEndY
Long iMachineX, iMachineY

Boolean bFound
String szMachineSelected

iCount = 1
szMachineSelected = ""
iMachineX = 0
iMachineY = 0

Do while (Not bFound) AND (iCount <= iMachineCount)
	iBeginX 	= MachineList[iCount].X
	iBeginY 	= MachineList[iCount].Y
	iEndX		= iBeginX + MachineList[iCount].Width
	iEndY		= iBeginY + MachineList[iCount].Height

	If (X >= iBeginX) AND (X <= iEndX) AND (Y >= iBeginY) AND (Y <= iEndY) then
		bFound = TRUE
		szMachineSelected = MachineList[iCount].Text
		iMachineX  = X
		iMachineY  = Y
	End If

	iCount = iCount + 1

Loop

Return szMachineSelected
	
end function

public subroutine draw_time_bar ();Decimal nStartHour
Decimal nStartMin

nStartHour = Hour(Now())
nStartMin  = Minute(Now())

ln_time.BeginX = iCurInitJobX + (DaysAfter(Date(sDate[1].text), Today()) * iDistanceX) + (ii_factor * iDistanceX * (nStartHour + (nStartMin / 60)) / 24)
ln_time.EndX	= ln_time.BeginX

st_time.x				= ln_time.beginX
If Not ln_time.visible then
	ln_time.visible 	= TRUE
End If

st_time.text			= String(Now())


end subroutine

public function string select_dragdrop_machine (long Y);Long iCount
Long iBeginX, iBeginY
Long iEndX, iEndY
Long iMachineX, iMachineY

Boolean bFound
String szMachineSelected

iCount = 1
szMachineSelected = ""
iMachineX = 0
iMachineY = 0

Do while (Not bFound) AND (iCount <= iMachineCount)
	iBeginX 	= MachineList[iCount].X
	iBeginY 	= MachineList[iCount].Y
	iEndX		= iBeginX + MachineList[iCount].Width
	iEndY		= iBeginY + MachineList[iCount].Height

	If (Y >= iBeginY) AND (Y <= iEndY) then
		bFound = TRUE
		szMachineSelected = MachineList[iCount].Text
		iMachineX  = X
		iMachineY  = Y
	End If

	iCount = iCount + 1

Loop

Return szMachineSelected
	
end function

public function date get_calc_date (date Today, long iOffSet);Integer iMonth				//Number of month
Integer iYear				//Number of year
Integer iDay				//Number of day
Integer iDaysInMonth		//Total days in month
Long    iRow

If iOffSet > 0 then

	For iRow = 1 to iOffSet

		iDay   = day(today)
		iMonth = month(today)
		iYear  = year(today)

		If iDay = days_in_month(iMonth, iYear) then
			iDay = 1
			If iMonth = 12 then
				iMonth = 1
				iYear  = iYear + 1
			Else
				iMonth = iMonth + 1
			End If
		Else
			iDay = iDay + 1
		End If

		Today = Date(iYear, iMonth, iDay)

	Next

Else

	For iRow = 1 to ( (-1) * iOffSet)

		iDay   = day(today)
		iMonth = month(today)
		iYear  = year(today)

		If iDay = 1 then
			If iMonth = 1 then
				iMonth = 12
				iYear  = iYear - 1
			Else
				iMonth = iMonth - 1
			End If
			iDay = days_in_month(iMonth, iYear)
		Else
			iDay = iDay - 1
		End If

		Today = Date(iYear, iMonth, iDay)

	Next

End If

Return Today 




end function

public subroutine draw_shifts ();//************************************************************************
//* Declaration
//************************************************************************

Long iRow
Long iCurrentY
Long iTotal

Date dStartDate
Time tStartTime
Decimal nUpHours
 
String szCurMachine
String szLastMachine

Boolean bSearchMore

//*************************************************************************
//*Initialization
//************************************************************************

Invisible_shifts()

dw_schedule.Retrieve(szMachine, Date(sDate[1].text), Get_calc_date(Date(sDate[i_i_DayCounter].text) , 1))

iCurrentY  		= iInitShiftY - iDistanceY
iTotalShifts  	= 0
iRow				= 1
iShiftCount		= 0
bSearchMore		= TRUE

If dw_schedule.RowCount() > 0 then
	
	iTotal	= dw_schedule.RowCount()

	Do while bSearchMore AND (iRow <= dw_schedule.RowCount() )

		szCurMachine   = dw_schedule.GetItemString(iRow, "machine")

		If szCurMachine <> szLastMachine then
			iCurrentY 		= iCurrentY + iDistanceY
			iTotalShifts 	= 1
		Else
			iTotalShifts 	= iTotalShifts + 1
		End If

		tStartTime 	= dw_schedule.GetItemTime(iRow, "begin_time")
		nUpHours		= dw_schedule.GetItemNumber(iRow, "up_hours")
		dStartDate	= dw_schedule.GetItemDate(iRow, "work_date")
		
		iShiftCount ++
		szLastMachine	= szCurMachine

		OpenUserObject(ShiftList[iShiftCount])
		ShiftList[iShiftCount].i_i_Ptr				= iShiftCount
		ShiftList[iShiftCount].i_t_ShiftBeginTime	= tStartTime
		ShiftList[iShiftCount].i_d_ShiftHour		= nUpHours
		ShiftList[iShiftCount].i_dt_StartDate		= dStartDate

		picture_shift(szMachine, iCurrentY, tStartTime, nUpHours, ShiftList[iShiftCount], dStartDate)

		//If iMachineCount > iMaxMachineNo then
		//	bSearchMore = FALSE
		//End If

		iRow = iRow + 1

	Loop

End If		


	

end subroutine

public subroutine invisible_shifts ();Long	l_i_Count

For l_i_Count = 1 to iShiftCount
	ShiftList[l_i_Count].visible	= FALSE
	CloseUserObject(ShiftList[l_i_Count])
Next

ShiftList	= NullShiftList

r_shift_block.visible	= FALSE
r_shift_block.visible	= TRUE

iShiftCount					= 0

end subroutine

public function decimal hours_after (date dStartDate, time tStartTime, date dEndDate, time tEndTime);Return ( (DaysAfter(dStartdate, dEndDate) * 24) + (SecondsAfter(tStartTime, tEndTime) / 3600) )
end function

public subroutine select_shift (integer x, integer y);Long iCount
Long iBeginX, iBeginY
Long iEndX, iEndY

iCurrentShiftNo= 0
iCount 		= 1
iJobX 		= 0
iJobY 		= 0 

bDragExistingShift	= FALSE
 
Do while (Not bDragExistingShift) AND (iCount <= iShiftCount)
	iBeginX 	= ShiftList[iCount].X
	iBeginY 	= ShiftList[iCount].Y
	iEndX		= iBeginX + ShiftList[iCount].Width
	iEndY		= iBeginY + ShiftList[iCount].Height

	If (X >= iBeginX) AND (X <= iEndX) AND (Y >= iBeginY) AND (Y <= iEndY) then
		bDragExistingShift = TRUE
		iJobX  = X
		iJobY  = Y
		CurrentShift 			= ShiftList[iCount]
		iCurrentShiftNo	= iCount
		dShiftDate			= dw_schedule.GetItemDate(iCount, "work_date")
		tShiftBeginTime	= dw_schedule.GetItemTime(iCount, "begin_time")
		nShiftHour			= dw_schedule.GetItemNumber(iCount, "up_hours")		
	End If

	iCount = iCount + 1

Loop

bDragShift	= FALSE

If Not (bDragExistingShift) then
	iBeginX 	= r_new_shift.X
	iBeginY 	= r_new_shift.Y
	iEndX		= iBeginX + r_new_shift.Width
	iEndY		= iBeginY + r_new_shift.Height

	If (X >= iBeginX) AND (X <= iEndX) AND (Y >= iBeginY) AND (Y <= iEndY) then
		iJobX  = X
		iJobY  = Y
		CurrentShift = r_new_shift
		bDragShift	= TRUE
	End If
End If 
end subroutine

public subroutine locate_shift_date_time (integer currentx);Boolean bFound				//Whether the shift being found within two dates

Integer iRow				//To keep the current date counter number
Integer iBeginHour		//To keep the begin hour
Integer iBeginMinute		//To keep the begin minute
Integer iBeginSecond		//To keep the begin second

Date    dWorkDate

  	
iRow	= 7

Do while (iRow > 1) AND (Not bFound) 
	If (CurrentX >= sDate[iRow].x) then
		bFound		= TRUE
		dWorkDate	= Date(sDate[iRow].text)
	Else
		iRow 	= iRow - 1
	End If
Loop

If bFound AND (st_machine.text > "") then
	iRow	= iRow - 1
	CurrentX		= CurrentX - sDate[iRow].X
	iBeginHour	= CurrentX * 24 / iDistanceX
	iBeginMinute= ((CurrentX * 24 / iDistanceX) - iBeginHour) * 60
	iBeginSecond= (((CurrentX * 24 / iDistanceX) - iBeginHour) * 60 &
					  - iBeginMinute)	* 60

	dw_schedule.Reset()
	dw_schedule.InsertRow(1)
	dw_schedule.SetItem(1, "machine", st_machine.text)
	dw_schedule.SetItem(1, "work_date", dWorkDate)
	dw_schedule.SetItem(1, "up_hours", 8)
	dw_schedule.SetItem(1, "begin_time", Time(iBeginHour, iBeginMinute, iBeginSecond))

	If dw_schedule.Update() > 0 then
		Commit;
		Draw_shifts()
		tShiftBeginTime	= Time(iBeginHour, iBeginMinute,  iBeginSecond)
		nShiftHour			= 8
//		Open(w_shift_time_scale)
	Else
		Rollback;
	End If
	
End If	 

end subroutine

public subroutine recalc_machine_job_time (string szmachine);Long iRow

Str_progress  sparm

sparm.Title = "Calculating Job Execution Time"

OpenWithParm(w_progress, sparm)
w_progress.wf_progress(1, "Calculating Job Execution Time For Machine " +szMachine)
OpenWithParm(w_calculate_job_time, szMachine)

UPDATE machine  
   SET redraw_graph = 'N'  
 WHERE machine_no = :szMachine   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If	

invisible_shifts()

Close(w_progress)
end subroutine

public subroutine rearrange_sequence (string szMachine);Long iRow

dw_jobs_in_time_order.Retrieve(szMachine)

For iRow = 1 to dw_jobs_in_time_order.RowCount()
	dw_jobs_in_time_order.SetItem(iRow, "sequence", iRow)
Next

If dw_jobs_in_time_order.Update() > 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine flag_machine (string szjob);String szPart
Long   iRow

dw_work_order_detail.Retrieve(szJob)

If dw_work_order_detail.RowCount() > 0 then
	szPart	= dw_work_order_detail.GetItemString(1, "part")	
End If	

For iRow = 1 to iMachineCount 
	MachineList[iRow].textcolor	= Get_Machine_Color(szPart, MachineList[iRow].text)
Next	
end subroutine

public function long get_machine_color (string szpart, string szmachine);dw_check_machine.Retrieve(szPart, szMachine)

If dw_check_machine.RowCount() > 0 then
	Return iGreenColor
Else
	Return 0
End If
end function

public function integer get_machine_no (integer Y);Long iCount
Long iBeginY
Long iEndY
Long iMachineNo			//To keep the selected machine no

Boolean bFound

iCount 		= 1
iMachineNo	=0

Do while (Not bFound) AND (iCount <= iMachineCount)
	iBeginY 	= MachineList[iCount].Y
	iEndY		= iBeginY + MachineList[iCount].Height

	If (Y >= iBeginY) AND (Y <= iEndY) then
		bFound 		= TRUE
		iMachineNo	= iCount
	End If

	iCount = iCount + 1

Loop

Return iMachineNo
	
end function

public subroutine search_related_jobs (string szjob);//************************************************************************
//* Declaration
//***********************************************************************
Long iRow							//To keep the current row number
Long iId								//To keep the current mps id number
Long iParentId						//To keep the current parent mps id number

String szAssignedJob				//To keep the job assigned
String szCurrentJob				//To keep the current job
Str_progress  sparm

//***********************************************************************
//* Initialization
//***********************************************************************
iRelatedMpsCount	= 0			//Reset to zero before search
iRelatedJobsCount = 0			//Reset to zero before search
iProcessedMpsCount= 0         //Reset to zefo before search

sparm.Title = "Checking Related Jobs"
OpenWithParm(w_progress, sparm)

//***********************************************************************
//* Main Routine
//***********************************************************************

dw_mps_in_work_order.Retrieve(szJob)		//Get all the mps items in the current job

For iRow = 1 to dw_mps_in_work_order.RowCount()	//Initialize the stack
	iId				= dw_mps_in_work_order.GetItemNumber(iRow, "id")
	iParentId		= dw_mps_in_work_order.GetItemNumber(iRow, "parent_id")
	szAssignedJob	= dw_mps_in_work_order.GetItemString(iRow, "job")
	If szAssignedJob > "0" then 						//If there is any job already assigned
		RelatedMpsList[iRelatedMpsCount + 1].Id			= iId
		RelatedMpsList[iRelatedMpsCount + 1].Parent_Id	= iParentId
		RelatedMpsList[iRelatedMpsCount + 1].Job			= szAssignedJob
		iRelatedMpsCount											= iRelatedMpsCount + 1
	End If
Next	

Do while iRelatedMpsCount > 0 			//Search the stack for any remaining
	iId					= RelatedMpsList[iRelatedMpsCount].Id
	iParentId			= RelatedMpsList[iRelatedMpsCount].Parent_Id
	szCurrentJob		= RelatedMpsList[iRelatedMpsCount].Job	
	iRelatedMpsCount	= iRelatedMpsCount - 1

	ProcessedMpsList[iProcessedMpsCount + 1].Id			= iId
	ProcessedMpsList[iProcessedMpsCount + 1].Parent_id	= iParentId
	iProcessedMpsCount 											= iProcessedMpsCount + 1

	updt_related_jobs_list(iParentId, "Child", szCurrentJob, dw_mps_item_by_id)
	updt_related_jobs_list(iId, "Parent", szCurrentJob, dw_mps_item_by_parent_id)
	w_progress.wf_progress(1, "Checking Related Jobs for Work Order:" + szCurrentJob)
Loop

Close(w_progress)


				
		
	
	
		

end subroutine

public subroutine initialize_lines ();i_ln_GridLine[1]	= ln_date1
i_ln_GridLine[2]	= ln_date2
i_ln_GridLine[3]	= ln_date3
i_ln_GridLine[4]	= ln_date4
i_ln_GridLine[5]	= ln_date5
i_ln_GridLine[6]	= ln_date6
i_ln_GridLine[7]	= ln_date7
i_ln_GridLine[8]	= ln_date8
i_ln_GridLine[9]	= ln_date9
i_ln_GridLine[10]	= ln_date10
i_ln_GridLine[11]	= ln_date11
i_ln_GridLine[12]	= ln_date12
i_ln_GridLine[13]	= ln_date13
i_ln_GridLine[14]	= ln_date14
i_ln_GridLine[15]	= ln_date15
i_ln_GridLine[16]	= ln_date16
i_ln_GridLine[17]	= ln_date17
i_ln_GridLine[18]	= ln_date18
i_ln_GridLine[19]	= ln_date19
i_ln_GridLine[20]	= ln_date20
i_ln_GridLine[21]	= ln_date21
i_ln_GridLine[22]	= ln_date22
i_ln_GridLine[23]	= ln_date23
i_ln_GridLine[24]	= ln_date24
i_ln_GridLine[25]	= ln_date25
i_ln_GridLine[26]	= ln_date26
i_ln_GridLine[27]	= ln_date27
i_ln_GridLine[28]	= ln_date28
i_ln_GridLine[29]	= ln_date29
i_ln_GridLine[30]	= ln_date30
i_ln_GridLine[31]	= ln_date31
i_ln_GridLine[32]	= ln_date32
i_ln_GridLine[33]	= ln_date33
i_ln_GridLine[34]	= ln_date34
i_ln_GridLine[35]	= ln_date35
i_ln_GridLine[36]	= ln_date36
i_ln_GridLine[37]	= ln_date37
i_ln_GridLine[38]	= ln_date38
i_ln_GridLine[39]	= ln_date39
i_ln_GridLine[40]	= ln_date40
i_ln_GridLine[41]	= ln_date41
i_ln_GridLine[42]	= ln_date42





end subroutine

public subroutine link_jobs ();//Long iCount				//Count
//Long iChildJobNo		//Job count number for child job
//Long iParentJobNo		//Job count number for parent job
//
//String szChildJob		//Child Job
//String szParentJob	//Parent Job
//
//iLineCount	= 0
//
//For iCount = 1 to iRelatedJobsCount
//	szChildJob	= RelatedJobsList[iCount].Child_job
//	szParentJob	= RelatedJobsList[iCount].Parent_job
//	If Is_On_Screen(szChildJob) then
//		iChildJobNo	= iCurrentJobNo
//		If Is_On_Screen(szParentJob) then
//			iParentJobNo	= iCurrentJobNo
//			LineList[iLineCount + 1].BeginX	= JobList[iParentJobNo].X + (JobList[iParentJobNo].Width / 2)
//			LineList[iLineCount + 1].BeginY	= JobList[iParentJobNo].Y + (JobList[iParentJobNo].Height / 2)
//			LineList[iLineCount + 1].EndX		= JobList[iChildJobNo].X + (JobList[iChildJobNo].Width / 2)
//			LineList[iLineCount + 1].EndY		= JobList[iChildJobNo].Y + (JobList[iChildJobNo].Height / 2)
//			LineList[iLineCount + 1].Visible	= True
//			iLineCount								= iLineCount + 1
//			set_order_for_job(szParentJob, szChildJob, iParentJobNo, iChildJobNo)
//		End If
//	End If
//	
//Next
//
//Label_jobs()
//
end subroutine

public function boolean is_on_screen (string szjob);Long iCount
Boolean bFound

iCount 	= 1
bFound	= FALSE

Do while (Not bFound) AND (iCount <= iJobCount) 
	If szJob	= JobList[iCount].tag then
		bFound 			= TRUE
		iCurrentJobNo	= iCount
		JobList[iCount].Visible = TRUE
	Else
		iCount			= iCount + 1
	End If
Loop

Return bFound
end function

public subroutine updt_related_jobs_list (long iid, string szflag, string szcurrentjob, datawindow dwmpswin);Long    iParentId

Integer iRow
Integer iCount							//To keep the current count number

String  szAssignedJob				//To keep the current assigned job number

dwMPSWin.Retrieve(iId)				//Get parent or Child MPS item
For iCount = 1 to dwMPSWin.RowCount() 
	szAssignedJob	= dwMPSWin.GetItemString(1, "job")
	If szAssignedJob > "0" then	//If there is a job assigned
		If szFlag = "Child" then	//If current MPS is a child MPS item			 
			RelatedJobsList[iRelatedJobsCount + 1].Parent_job	= szAssignedJob
			RelatedJobsList[iRelatedJobsCount + 1].Child_job	= szCurrentJob
		Else								//If this is a parent MPS item
			RelatedJobsList[iRelatedJobsCount + 1].Child_job	= szAssignedJob
			RelatedJobsList[iRelatedJobsCount + 1].Parent_job	= szCurrentJob
		End If	
		iRelatedJobsCount	= iRelatedJobsCount + 1
	End If

	dw_mps_in_work_order.Retrieve(szAssignedJob)		//Get all the mps items in the current job
	For iRow = 1 to dw_mps_in_work_order.RowCount()	//Initialize the stack
		iId				= dw_mps_in_work_order.GetItemNumber(iRow, "id")
		iParentId		= dw_mps_in_work_order.GetItemNumber(iRow, "parent_id")
		szAssignedJob	= dw_mps_in_work_order.GetItemString(iRow, "job")
		If Mps_is_not_processed(iId, iParentId) AND (szAssignedJob > "0") then 						//If there is any job already assigned
			RelatedMpsList[iRelatedMpsCount + 1].Id			= iId
			RelatedMpsList[iRelatedMpsCount + 1].Parent_Id	= iParentId
			RelatedMpsList[iRelatedMpsCount + 1].Job			= szAssignedJob
			iRelatedMpsCount											= iRelatedMpsCount + 1
		End If
	Next	
Next
end subroutine

public function boolean mps_is_not_processed (long iId, long iParent_id);Long    iCount
Boolean bFound

iCount	= 1
bFound   = FALSE

Do while (Not bFound) AND (iCount <= iProcessedMpsCount)

	If (iId = ProcessedMpsList[iCount].Id) AND (iParent_Id = ProcessedMpsList[iCount].Parent_id) then
		bFound	= TRUE
	Else
		iCount = iCount + 1
	End If

Loop

Return (Not bFound)		 
	
end function

public subroutine invisible_jobs ();Integer iCount

For iCount = 1 to iJobCount
	JobList[iCount].visible 	= FALSE
Next
end subroutine

public subroutine initialize_labels ();
end subroutine

public subroutine set_order_for_job (string szparentjob, string szjob, int iparentjobno, int ijobno);//************************************************************************
//* Declaration
//***********************************************************************
Integer iValue
Integer iParentValue
Integer iCount
Integer iCurrentValue

Boolean bDone

//***********************************************************************
//* Main Routine
//***********************************************************************

iCount	= 1	
//------------------ Check the child job --------------------------------
Do while (Not bDone) AND (iCount <= dw_sorted_jobs.RowCount())
	If szJob	= dw_sorted_jobs.GetItemString(iCount, "szJob") then
		bDone	= TRUE
		iValue= dw_sorted_jobs.GetItemNumber(iCount, "nValue")
	Else
		iCount= iCount + 1	
	End If
Loop

If (Not bDone) then	//If the child job not found, then insert a new row
	iValue	= 0
	dw_sorted_jobs.InsertRow(1)
	dw_sorted_jobs.SetItem(1, "szJob", szJob)
	dw_sorted_jobs.SetItem(1, "nValue", iValue)
	dw_sorted_jobs.SetItem(1, "iJobCount", iJobNo)
End If
 	
//--------------------- Check the parent job ----------------------------
iCount				= 1
bDone					= FALSE
Do while (Not bDone) AND (iCount <= dw_sorted_jobs.RowCount()) 
	If szParentJob	= dw_sorted_jobs.GetItemString(iCount, "szJob")	then
		bDone			= TRUE
		iParentValue= dw_sorted_jobs.GetItemNumber(iCount, "nValue")
	Else
		iCount		= iCount + 1
	End If
Loop

If bDone then
	If (iParentValue <= iValue) then
		iParentValue	= (iValue + 5)
	End If
	dw_sorted_jobs.SetItem(iCount, "nValue", iParentValue)
Else
	iParentValue		= (iValue + 10)
	dw_sorted_jobs.InsertRow(1)
	dw_sorted_jobs.SetItem(1, "szJob", szParentJob)
	dw_sorted_jobs.SetItem(1, "nValue", iParentValue)	
	dw_sorted_jobs.SetItem(1, "iJobCount", iParentJobNo)
End If

For iCount	= 1 to dw_sorted_jobs.RowCount()
	iCurrentValue	= dw_sorted_jobs.GetItemNumber(iCount, "nValue")
	dw_sorted_jobs.SetItem(iCount, "nValue", 2 * iCurrentValue)
Next

				 	

end subroutine

public subroutine label_jobs ();
end subroutine

public function boolean machine_in_group (string szmachine, string szgroup);dw_machine_in_group.Retrieve(szMachine, szGroup)
Return (dw_machine_in_group.RowCount() > 0)
end function

public subroutine get_group ();Integer iCount

ddlb_type_value.Reset()

For iCount = 1 to dw_groups_in_location.RowCount()
	ddlb_type_value.AddItem(dw_groups_in_location.GetItemString(iCount, "group_no"))
Next

	
end subroutine

public subroutine get_customers ();String szCurrentCustomer

ddlb_type_value.Reset()

Declare CustomerCur Cursor for Select Customer From Customer Using sqlca;

Open CustomerCur;

Fetch CustomerCur into :szCurrentCustomer;

Do while sqlca.sqlcode = 0
	ddlb_type_value.AddItem(szCurrentCustomer)
	Fetch CustomerCur into :szCurrentCustomer;
Loop

Close CustomerCur;

	
end subroutine

public function boolean right_customer (string szorder);dw_customer_in_order.Retrieve(Long(szOrder))

If dw_customer_in_order.RowCount() > 0 then
	Return (dw_customer_in_order.GetItemString(1, "customer") = ddlb_type_value.text)
Else
	Return FALSE
End If
end function

public function int wf_job_order_in_machine (string szmachine, string szjob);Long 		iRow
Boolean	bFound
String   szCurrentJob

dw_jobs_for_machine.Retrieve(szMachine)
iRow		= 1
bFound	= FALSE

Do while (Not bFound) AND (iRow <= dw_jobs_for_machine.RowCount())
	szCurrentJob	= dw_jobs_for_machine.GetItemString(iRow, "work_order") 
	If szCurrentJob = szJob then
		bFound 	= TRUE
	Else
		iRow		= iRow + 1
	End If
Loop

If bFound then
	Return iRow
Else
	Return 0
End If
end function

public subroutine wf_mat_shortage_list ();Long iRow 
Long iTotalRows
Long iCount
Long iJobSequence

String szJOb

str_progress stProgress

iLastInIndex	= 0
iTotalRows		= dw_jobs.RowCount()
iRow				= 1
 
stProgress.title	= "Check material shortage"
OpenWithParm(w_progress, stProgress)

Do While (iRow > 0) AND (iRow <= iTotalRows)
	szJob		= dw_jobs.GetItemString(iRow, "work_order")

	w_progress.wf_progress(iRow / iTotalRows, "Checking job# " + szJob)
	iJobSequence	= wf_get_job_sequence(szJob)
	If iJobSequence > 0 then	
	  If wf_job_is_short_material(szJob) Then
			iLastInIndex ++
			JobIndex[iLastInIndex].Job_index	= iJobSequence
			JobIndex[iLastInIndex].Job_color	= JobList[iJobSequence].st_job.BackColor
			JobIndex[iLastInIndex].Part		= szPart
			JobIndex[iLastInIndex].Qty_onhand= nQtyOnHand
			JobIndex[iLastInIndex].Qty_required= nQtyRequired
			JobList[iJobSequence].p_status.PictureName	= "matshort.bmp"	
		Else
			JobList[iJobSequence].p_status.PictureName	= "ok.bmp"
		End If
	End If
	iRow ++

Loop

Close(w_progress)

		
end subroutine

public function integer wf_get_job_sequence (string szjob);Long iRow
Long iTotalRows

Boolean bFound

iTotalRows	= upperbound( JobList )
iRow			= 1
bFound		= FALSE

Do while (Not bFound) AND (iRow <= iTotalRows)
	If isValid( JobList[ iRow ] ) then
		If JobList[iRow].i_s_Job = szJob then
			bFound	= TRUE
		Else
			iRow ++
		End if
	Else	
		iRow ++
	End If
Loop

If Not bFound then
	iRow	= 0
End If

Return iRow
end function

public function boolean wf_job_is_short_material (string szjob);Long iRow
Long iTotalRows

String	szPrevPart

Decimal	nQty

Boolean  bShortMat	= FALSE

dw_comm_mat_set.Retrieve(szJob)
dw_comm_mat_set.SetSort("bill_of_material_part a")
dw_comm_mat_set.Sort()

iTotalRows	= dw_comm_mat_set.RowCount()

szPrevPart		= ''
nQtyOnHand			= 0
nQtyRequired	= 0
iRow				= 1

Do while (Not bShortMat) AND (iRow <= iTotalRows)
	szPart	= dw_comm_mat_set.GetItemString(iRow, "bill_of_material_part")
	nQty		= dw_comm_mat_set.GetItemNumber(iRow, "component_qty")

	If szPrevPart <> szPart then
		If szPrevPart = '' then
			szPrevPart	= szPart
			nQtyOnHand			= f_get_value(Dec(f_get_part_info(szPart, "ON HAND")))
			// included on 6/22/99 to consider objects issued to the job from audit_trail
			if nQtyOnHand = 0 then
				select sum(quantity)
				  into :nQtyOnHand 
				  from audit_trail 
				 where (workorder= :szjob and part = :szpart) ;
				if isnull(nQtyOnHand) then nQtyOnHand=0 
			end if 	 
			nQtyRequired	= f_get_value(nQty)
		Else
			bShortMat		= (nQtyRequired > nQtyOnHand)
			If Not bShortMat then		//If the last part is OK
				nQtyOnHand		= f_get_value(Dec(f_get_part_info(szPart, "ON HAND")))		
				nQtyRequired= f_get_value(nQty)
				szPrevPart	= szPart
			End If
		End If
	Else
		nQtyRequired		= nQtyRequired + nQty
	End If

	iRow ++

Loop

If Not bShortMat then
	bShortMat		= (nQtyRequired > nQtyOnHand)
End If

Return bShortMat			
end function

public function boolean wf_job_part_in_sales_order (string szjob);Long iRow
Long iTotalRows 
Long iCount

Boolean bPartInJob = FALSE

dw_work_order_detail.Retrieve(szJob)
iTotalRows	= dw_work_order_detail.RowCount()
iRow			= 1

Do while (Not bPartInJob) AND (iRow <= iTotalRows)

	szPart	= dw_work_order_detail.GetItemString(iRow, "part")

	For iCount = 1 to iOrderDetailCount
		bPartInJob	= (szPart = szOrderDetail[iCount])

		If bPartInJob then
			iCount	= iOrderDetailCount + 1
		End If

	Next	

	iRow ++
Loop

Return bPartInJob
end function

public subroutine wf_job_list_for_sales_order ();Long iRow 
Long iTotalRows
Long iCount
Long iJobSequence

String szJOb

str_progress stProgress
 
iLastInIndex	= 0
iTotalRows		= dw_jobs.RowCount()
iRow				= 1

stProgress.title	= "Check jobs for sales order"
OpenWithParm(w_progress, stProgress)

Do While (iRow > 0) AND (iRow <= iTotalRows)
	
	szJob		= dw_jobs.GetItemString(iRow, "work_order")

	w_progress.wf_progress(iRow / iTotalRows, "Checking job# " + szJob)
	If wf_job_part_in_sales_order(szJob) then
		iLastInIndex ++
		iJobSequence	= wf_get_job_sequence(szJob)
		JobIndex[iLastInIndex].Job_index	= iJobSequence
		JobIndex[iLastInIndex].Job_color	= JobList[iJobSequence].BackColor
		JobIndex[iLastInIndex].Part		= szPart
	End If

	iRow ++

Loop

Close(w_progress)

		
end subroutine

public subroutine wf_create_list_of_late_parts ();
end subroutine

public subroutine wf_list_of_late_jobs ();Long iRow 
Long iJobRow
Long iTotalRows
Long iCount
Long iJobSequence

Boolean bPartLate

Date dJobEndDate
Date dReleaseDate
 
String szJOb
String szPart

str_progress stProgress

iLastInIndex	= 0
iTotalRows		= dw_jobs.RowCount()
iRow				= 1

stProgress.title	= "Checking late jobs"
OpenWithParm(w_progress, stProgress)

Do While (iRow > 0) AND (iRow <= iTotalRows)
	
	szJob		= dw_jobs.GetItemString(iRow, "work_order")

	w_progress.wf_progress(iRow / iTotalRows, "Checking job# " + szJob)

	dw_work_order_detail.Retrieve(szJob)
	iJobRow		= 1
	bPartLate	= FALSE
	dJobEndDate	= dw_jobs.GetItemDate(iRow, "end_date")

	Do while (Not bPartLate) AND (iJobRow <= dw_work_order_detail.RowCount())

		szPart	= dw_work_order_detail.GetItemString(iJobRow, "part")

		If f_get_part_info(szPart, "TYPE") = 'F' then	//Only for finished part

			iCount	= dw_earliest_releases.Find("part_number = '" + szPart + "'", 1, 99999)

			If iCount > 0 then
				Do while (Not bPartLate) AND (iCount <= dw_earliest_releases.RowCount())
					If (dw_earliest_releases.GetItemString(iCount, "part_number") = szPart) then
						dReleaseDate= dw_earliest_releases.GetItemDate(iCount, "due_date")
						bPartLate	= (dJobEndDate > dReleaseDate	)
						iSalesOrder	= dw_earliest_releases.GetItemNumber(iCount, "order_no")
					End if
					iCount ++
				Loop
			End If

		End If

		iJobRow ++

	Loop

	iJobSequence	= wf_get_job_sequence(szJob)
	If iJobsequence > 0 Then
		If bPartLate then
			iLastInIndex ++
			JobIndex[iLastInIndex].Job_index		= iJobSequence
			JobIndex[iLastInIndex].Job_color		= JobList[iJobSequence].st_job.BackColor
			JobList[iJobSequence].p_status.PictureName	= "clock.bmp"
			JobIndex[iLastInIndex].Sales_order	= iSalesOrder //iSales order is generated from wf_any_late_part
			JobIndex[iLastInIndex].Job_end_date	= dJobEndDate
			JobIndex[iLastInIndex].Release_Date	= dReleaseDate
			JobIndex[iLastInIndex].Part			= szPart
		Else
			JobList[iJobSequence].p_status.PictureName	= "ok.bmp"
		End If
   End If
	iRow ++

Loop

Close(w_progress)

		
end subroutine

public function boolean wf_find_late_part (string szjob, date djobenddate);Long iRow
Long iTotalRows 
Long iCount

String szPart


MessageBox("FYI", "wf_any_late_part")

Boolean bPartInJob 	= FALSE
Boolean bPartLate		= FALSE	

dw_work_order_detail.Retrieve(szJob)
iTotalRows	= dw_work_order_detail.RowCount()
iRow			= 1
bPartLate	= FALSE

Do while (Not bPartLate) AND (Not bPartInJob) AND (iRow <= iTotalRows)

	szPart	= dw_work_order_detail.GetItemString(iRow, "part")

	If f_get_part_info(szPart, "TYPE") = 'F' then	//Only for finished part

		iCount	= dw_earliest_releases.Find("part_number = '" + szPart + "'", 1, 99999)
		If iCount > 0 then
			Do while (Not bPartLate) AND (iCount <= iOrderDetailCount) AND &
						(dw_earliest_releases.GetItemString(iCount, "part_number") = szPart)

				bPartLate	= (dJobEndDate > 	dw_earliest_releases.GetItemDate(iCount, "date_stamp"))
				iSalesOrder	= dw_earliest_releases.GetItemNumber(iCount, "order_no")

				iCount ++
			Loop
		End If

	End If

	iRow ++

Loop

Return bPartLate
end function

public function integer wf_get_job_index_number (long ijobrow);Long iCount
Long iRow

Boolean bFound	= FALSE

iRow = 1
Do while (iRow <= iLastInIndex) AND (Not bFound)
	If iJobRow = JobIndex[iRow].Job_index then
		bFound	= TRUE
	Else
		iRow ++
	End If
Loop

If Not bFound then
	iRow	= 0
End If

Return iRow

end function

public subroutine wf_refresh_machine (long imachinerow);String szRefresh
String szMachine

szMachine	= dw_machine_list.GetItemString(iMachineRow, "machine_no")

SELECT machine.redraw_graph  
  INTO :szRefresh  
  FROM machine  
 WHERE machine.machine_no = :szMachine   ;

If szRefresh = 'Y' then
	recalc_machine_job_time(szMachine)
	redraw()
End If
end subroutine

public function boolean wf_have_jobs (string szmachine);String szJob
Long	 l_i_Total

l_i_Total	= 0

SELECT Count(work_order.work_order)
  INTO :l_i_Total  
  FROM work_order  
 WHERE work_order.machine_no = :szMachine   ;

If l_i_Total > 0 then
	Return TRUE
Else
	Return FALSE
End If	
end function

public function boolean wf_job_is_touched (string szjob);Decimal nTotalQty

Select sum(workorder_detail.qty_completed )  
 Into :nTotalQty  
 From workorder_detail  
 Where workorder_detail.workorder = :szJob   ;

nTotalQty	= f_get_value(nTotalQty)
If nTotalQty = 0 then
	Return 	TRUE
Else
	Return	FALSE
End If		


end function

public function long wf_job_color (long l_i_job);Return i_i_ColorList[Mod(l_i_Job, 11) + 1]
end function

public subroutine wf_initialize_color_list ();i_i_ColorList[1]	= Oval_1.FillColor


end subroutine

public subroutine wf_set_color_list ();i_i_ColorList[1]	= oval_1.FillColor
i_i_ColorList[2]	= oval_2.FillColor
i_i_ColorList[3]	= oval_3.FillColor
i_i_ColorList[4]	= oval_4.FillColor
i_i_ColorList[5]	= oval_5.FillColor
i_i_ColorList[6]	= oval_6.FillColor
i_i_ColorList[7]	= oval_7.FillColor
i_i_ColorList[8]	= oval_8.FillColor
i_i_ColorList[9]	= oval_9.FillColor
i_i_ColorList[10]	= oval_10.FillColor
i_i_ColorList[11]	= oval_11.FillColor
i_i_ColorList[12]	= oval_12.FillColor




end subroutine

public subroutine picture_shift (string szmachine, long icurrenty, time tstarttime, decimal nuphours, ref u_shifts rshift, date dstartdate);Decimal nStartHour
Decimal nStartMin

nStartHour = Hour(tStartTime)
nStartMin  = Minute(tStartTime)

rShift.Y = iCurrentY
rShift.X = iCurInitJobX + (DaysAfter(Date(sDate[1].text), dstartdate) * ii_factor * iDistanceX) + (ii_factor * iDistanceX * (nStartHour + (nStartMin / 60)) / 24)

rShift.BackColor	= 65280
rShift.Width	  	= ii_factor * iDistanceX * nUpHours / 24
rShift.Tag			= String(tStartTime)
rShift.Visible 	= TRUE
rShift.il_OrigPos	= rShift.X




end subroutine

public subroutine wf_enable_job_objects (boolean l_b_Status);Long 	l_i_Count

For l_i_Count = 1 to iJobCount
	JobList[l_i_Count].Enabled	= l_b_Status
Next

end subroutine

public subroutine wf_display_message (string szjob, string sztype, integer ai_jobptr);Long iRow
Long iTotalRows
Long iJobRow
Long iJobIndex

String	szMessage

If szType = "NORMAL" then

	dw_work_order_detail.Retrieve(szJob)
	iTotalRows	= dw_work_order_detail.RowCount()
	szMessage	= "Parts:"

	For iRow = 1 to iTotalRows
		If iRow	= 1 then
			szMessage	= szMessage + Trim(dw_work_order_detail.GetItemString(iRow, "part"))
		Else
			szMessage	= szMessage + "," + Trim(dw_work_order_detail.GetItemString(iRow, "part"))
		End If
	Next

Else

	iJobRow		= wf_get_job_sequence(szJob)
	iJobIndex	= wf_get_job_index_number(iJobRow)

	If iJobIndex > 0 then
		Choose Case ddlb_flash.text
			Case "Material Shortage"
				szMessage	= 	"Mat Short:" + Trim(JobIndex[iJobIndex].Part) + &
									" OnHand:" + String(JobIndex[iJobIndex].Qty_onhand) + &
									" Req:" + String(JobIndex[iJobIndex].Qty_required)
			Case "Sales Order"
				szMessage	=  "Part in order:" + JobIndex[iJobIndex].part

			Case "Late Jobs"
				szMessage	= 	"Late Order:" + String(JobIndex[iJobIndex].Sales_order) + &
									" Part Late:" + JobIndex[iJobIndex].Part + &
									" Date Req:" + String(JobIndex[iJobIndex].Release_Date) + &
									" Date Finish:" + String(JobIndex[iJobIndex].Job_end_date)

		End Choose
	End If

End If

mle_message.text	= szMessage
end subroutine

public subroutine wf_x_move (integer ai_value, integer ai_direction);/* 
Description	:To move all objects horizontally.
Author		:Jim Wu
Start Date	:02/06/96
Modification:
*/

/* Declaration */
Long	li_Count, &
		li_Total, &
		li_Pos

/* Initialization */


/* Main Process */

li_Total	= Upperbound(sDate)
For li_Count = 1 to li_Total
	sDateName[li_Count].x			+= (ai_direction * ai_value)
	sDate[li_Count].x					+= (ai_direction * ai_value)
	sDate[li_Count].visible			=	(sDate[li_Count].x > iInitJobX - 150)
	sDateName[li_count].visible	= sDate[li_Count].visible
	sDate[li_Count].BringToTop		= TRUE
Next

li_Total	= Integer(sle_days_to_display.text)
For li_Count = 1 to li_Total
	li_Pos	= i_ln_GridLine[li_Count].BeginX	+ (ai_direction * ai_value)
	i_ln_GridLine[li_count].BeginX	= li_Pos
	i_ln_GridLine[li_count].EndX		= li_Pos
Next

iCurInitJobX	+= (ai_direction * ai_value)
draw_time_bar()

li_Total	= Upperbound(JobList)
For li_Count = 1 to li_Total
	if IsValid( JobList[ li_count ] ) then
		JobList[li_Count].x	+= (ai_direction * ai_value)
	end if
Next

li_Total	= Upperbound(ShiftList)
For li_Count = 1 to li_Total
	if isValid( ShiftList[ li_count ] ) then
		ShiftList[li_Count].x				+= (ai_direction * ai_value)
		ShiftList[li_Count].BringToTop	= FALSE
	end if
Next
end subroutine

public subroutine wf_y_move (integer ai_value, integer ai_direction);/* 
Description	:To move all objects horizontally.
Author		:Jim Wu
Start Date	:02/06/96
Modification:
*/

/* Declaration */
Long	li_Count, &
		li_Total, &
		li_Position

/* Initialization */
li_Total	= Upperbound(JobList)

/* Main Process */

For li_Count = 1 to li_Total
	if isValid( JobList[li_count] ) then
		JobList[li_Count].Y			+= (ai_direction * ai_value)
		If JobList[li_Count].Y >= iInitMachineY - 30 AND &
			(JobList[li_Count].Y + JobList[li_Count].Height) <= hsb_date.Y then
			JobList[li_Count].Visible	= TRUE
		Else
			JobList[li_Count].Visible	= FALSE
		End If
	end if
Next

li_Total		= iMachineCount

For li_Count = 1 to li_Total
	if isValid( MachineList[li_Count] ) then
		li_Position			= MachineList[li_Count].Y
		li_Position			+= (ai_direction * ai_value)
		If li_Position >= iInitMachineY - 30 AND &
			(li_Position + MachineList[li_Count].Height) < hsb_date.Y then
			MachineList[li_Count].Visible	= TRUE
		Else
			MachineList[li_Count].Visible	= FALSE
		End If
		MachineList[li_Count].Y	= li_Position
	end if
Next



end subroutine

public subroutine wf_set_x_position (integer ai_value);/* 
Description	:To set the horizontal position when drag the scroll box.
Author		:Jim Wu
Start Date	:02/06/96
Modification:
*/

/* Declaration */
Long	li_Count, &
		li_Total, &
		li_Pos

/* Initialization */
li_Total	= Upperbound(JobList)

/* Main Process */

li_Total	= Upperbound(sDate)
For li_Count = 1 to li_Total
	sDateName[li_Count].x			= sDateName[li_Count].il_OrigPos + ai_value
	sDate[li_Count].x					= sDate[li_Count].il_OrigPos + ai_value
	sDate[li_Count].visible			=	(sDate[li_Count].x > iInitJobX - 150)
	sDateName[li_count].visible	= sDate[li_Count].visible
	sDate[li_Count].BringToTop		= TRUE
Next

li_Total	= Integer(sle_days_to_display.text)
For li_Count = 1 to li_Total
	li_Pos	= ii_OrigGridLineX[li_Count] + ai_value
	i_ln_GridLine[li_count].BeginX	= li_Pos
	i_ln_GridLine[li_count].EndX		= li_Pos
Next

iCurInitJobX	= iInitJobx + ai_value
draw_time_bar()

li_Total		= Upperbound(JobList)
For li_Count = 1 to li_Total
	OpenUserObject(JobList[li_Count])
	JobList[li_Count].x	= JobList[li_Count].il_OrigPos + ai_value
Next

li_Total	= Upperbound(ShiftList)
For li_Count = 1 to li_Total
	ShiftList[li_Count].x	= ShiftList[li_Count].il_OrigPos + ai_value
Next


end subroutine

public subroutine wf_set_y_position (integer ai_value);/* 
Description	:To set the vertical position when drag the scroll box.
Author		:Jim Wu
Start Date	:02/06/96
Modification:
*/

/* Declaration */
Long	li_Count, &
		li_Total, &
		li_Pos, &
		li_position

/* Initialization */

/* Main Process */

li_Total	= Upperbound(JobList)

For li_Count = 1 to li_Total
	OpenUserObject(JobList[li_Count])
	if isValid( JobList[li_count] ) then
		JobList[li_Count].Y			= JobList[li_Count].il_OrigPosY + ai_value	
		If JobList[li_Count].Y >= iInitMachineY - 20 AND &
			(JobList[li_Count].Y + JobList[li_Count].Height) <= hsb_date.Y then
			JobList[li_Count].Visible	= TRUE
		Else
			JobList[li_Count].Visible	= FALSE
		End If
	end if
Next

li_Total		= iMachineCount

For li_Count = 1 to li_Total
	if isValid( MachineList[li_Count] ) then
		OpenUserObject(MachineList[li_Count])
		li_Position 		= MachineList[li_Count].il_OrigPosY + ai_value
		If li_Position >= iInitMachineY - 20 AND &
			(li_Position + MachineList[li_Count].Height) < hsb_date.Y then
			MachineList[li_Count].Visible	= TRUE
		Else
			MachineList[li_Count].Visible	= FALSE
		End If
		MachineList[li_Count].Y	= li_Position
	end if
Next

//li_Total	= Upperbound(JobList)
//For li_Count = 1 to li_Total
//	OpenUserObject(JobList[li_Count])
//	JobList[li_Count].Y			= JobList[li_Count].il_OrigPosY + ai_value
//	JobList[li_Count].visible	= (JobList[li_Count].Y >=iInitMachineY - 10)
//Next
//
//li_Total	= Upperbound(MachineList)
//For li_Count = 1 to li_Total
//	OpenUserObject(MachineList[li_Count])
//	MachineList[li_Count].Y			= MachineList[li_Count].il_OrigPosY + ai_value
//	MachineList[li_Count].visible	= (MachineList[li_Count].Y >= iInitMachineY - 10)
//Next

end subroutine

public function string wf_first_job_part (string as_WorkOrder);/*
Description	:	To get the first part number in the work order detail.
Author		:	Jim Wu
Start Date	:	01/07/96
Modification:
*/

/* Declaration */
String	ls_Part

/* Initializatiion */


/* Modification */

SELECT workorder_detail.part  
  INTO :ls_Part  
  FROM workorder_detail  
 WHERE workorder_detail.workorder = :as_WorkOrder   ;

Return ls_part


end function

public function boolean wf_close_job_windows ();///*
//Description	:To close all the opened job windows.
//Author		:Jim Wu
//Start Date	:02/17/96
//Modification:
//*/
//
//
///* Declaration */
//
//
///* Initialization */
//
//
///* Main Process */
//
//If IsValid(w_job_information) then
//	Close(w_job_information)
//End If
//
//If IsValid(w_job_material_information) then
//	Close(w_job_material_information)
//End If
//
//If IsValid(w_job_material_yield) then
//	Close(w_job_material_yield)
//End If
//
//If IsValid(w_job_output_information) then
//	Close(w_job_output_information)
//End If
//
//If IsValid(w_job_performance) then
//	Close(w_job_performance)
//End If
//
//If IsValid(w_job_process) then
//	Close(w_job_process)
//End If
//
//If IsValid(w_job_status) then
//	Close(w_job_status)
//End If

Return TRUE
end function

public subroutine wf_display_machines ();/*
Description	:	To display the list of machines.
Author		:	Jim Wu
Start Date	:	03/02/96
Modification:  Uses dw_machine_list instead of cursor
*/

/* Declaration */
string	ls_machine

long		ll_CurrentY

/* Initialization */

iMachineCount	= 0
ll_CurrentY  	= iInitMachineY 

/* Main Process */

DO WHILE dw_machine_list.RowCount ( ) > 0
	ls_Machine = dw_machine_list.GetItemString ( 1, 'machine_no' )
	iMachineCount 	= iMachineCount + 1

	OpenUserObject(MachineList[iMachineCount])

	MachineList[iMachineCount].Move(iInitMachineX, ll_CurrentY)
	MachineList[iMachineCount].Text 				= ls_machine
	MachineList[iMachineCount].il_OrigPosY		= ll_CurrentY
	MachineList[iMachineCount].il_Ptr			= iMachineCount

	If MachineList[iMachineCount].Y + &
		MachineList[iMachineCount].Height < hsb_date.Y then
		MachineList[iMachineCount].BringToTop	= TRUE
	Else
		MachineList[iMachineCount].Visible		= FALSE
	End If

	ll_CurrentY 		+=	iDistanceY
	dw_machine_list.DeleteRow ( 1 )

loop
dw_machine_list.Retrieve ( )
end subroutine

public function long wf_machine_pos_y (string as_machine);/*
Description	:	To get the Y position for specified machine.
Author		:	Jim Wu
Start Date	:	03/02/96
Modification:
*/

/* Declaration */
integer	li_ptr

long		ll_pos_y

boolean	lb_found

/* Initialization */
li_ptr	= 1
lb_found	= FALSE
ll_pos_y	= 0

/* Main Process */

do while (NOT lb_found) AND (li_ptr <= iMachineCount)
	lb_found	= (MachineList[li_ptr].text = as_machine)
	ll_pos_y	= MachineList[li_ptr].y
	li_ptr ++
loop

if lb_found then
	return ll_pos_y
else
	return 0
end if		
end function

public subroutine draw_job (integer icurrenty, date dstartdate, time tstarttime, decimal nruntime, string l_s_machine, string as_job);Decimal nStartHour
Decimal nStartMin

Long	iColor, &
		ll_Pos_X
Boolean	bAdd

nStartHour = Hour(tStartTime)
nStartMin  = Minute(tStartTime)

OpenUserObject(JobList[iJobCount])
JobList[iJobCount].uf_get_parent(w_plant_monitor)

ll_pos_x	= 	iCurInitJobX + f_get_value( (DaysAfter(Date(sDate[1].text), &
				dstartdate) * ii_factor * iDistanceX) + &
				(ii_factor * iDistanceX * (nStartHour + (nStartMin / 60)) / 24))

JobList[iJobCount].Move( ll_pos_x, iCurrentY)

JobList[iJobCount].i_i_Ptr		= iJobCount
JobList[iJobCount].i_s_Machine= l_s_Machine


If nRunTime <= 0 then
	nRunTime	= 1

	bAdd		= TRUE
	If iLastOverCompIndex > 0 then
		bAdd	= (OverCompIndex[iLastOverCompIndex].Job_index <> iMachineCount)
	End If
					
	If bAdd then
		iLastOverCompIndex ++
	
		OverCompIndex[iLastOverCompIndex].Job_index		= iMachineCount
		OverCompIndex[iLastOverCompIndex].Sales_order	= Long(szJob)
	End If

End If

If nRunTime > 1000 then
	nRunTime	= 1000
End If

JobList[iJobCount].st_job.BackColor 	= wf_job_color(Long(as_Job))

JobList[iJobCount].Width	  				= ( ii_factor * iDistanceX * nRunTime ) / 24 
JobList[iJobCount].st_job.Width			= JobList[iJobCount].Width
JobList[iJobCount].st_job.Text			= "    " + wf_first_job_part(as_Job)
JobList[iJobCount].Visible 				= TRUE
JobList[iJobCount].BringToTop				= FALSE
JobList[iJobCount].il_OrigPos				= JobList[iJobCount].x
JobList[iJobCount].il_OrigPosY			= JobList[iJobCount].y
JobList[iJobCount].i_s_Job					= as_Job
end subroutine

public subroutine wf_destroy_objects ();long	ll_ptr, &
		ll_count

ll_count	= upperbound( MachineList )

for ll_ptr = 1 to ll_count
	if isValid( MachineList[ ll_ptr ] ) then
		CloseUserObject( MachineList[ ll_ptr ] )
	end if
next

ll_count	= upperbound( JobList )

for ll_ptr = 1 to ll_count
	if isValid( JobList[ ll_ptr ] ) then
		CloseUserObject( JobList[ ll_ptr ] )
	end if
next

ll_count	= upperbound( ShiftList )

for ll_ptr = 1 to ll_count
	if isValid( ShiftList[ ll_ptr ] ) then
		CloseUserObject( ShiftList[ ll_ptr ] )
	end if
next

ll_count	= upperbound( NullShiftList )

for ll_ptr = 1 to ll_count
	if isValid( NullShiftList[ ll_ptr ] ) then
		CloseUserObject( NullShiftList[ ll_ptr ] )
	end if
next 



ll_count	= upperbound( sDate )

for ll_ptr = 1 to ll_count
	if isValid( sDate[ ll_ptr ] ) then
		CloseUserObject( sDate[ ll_ptr ] )
	end if

	if isValid( sDateName[ ll_ptr ] ) then
		CloseUserObject( sDateName[ ll_ptr ] )
	end if

next

ll_count	= upperbound( sNullDate )

for ll_ptr = 1 to ll_count
	if isValid( sNullDate[ ll_ptr ] ) then
		CloseUserObject( sNullDate[ ll_ptr ] )
	end if
next

ll_count	= upperbound( sNullDateName )

for ll_ptr = 1 to ll_count
	if isValid( sNullDateName[ ll_ptr ] ) then
		CloseUserObject( sNullDateName[ ll_ptr ] )
	end if
next

end subroutine

public subroutine wf_bubble_help (integer ai_x, integer ai_y, integer ai_height, string as_help);st_message.x			= ai_x
st_message.y			= ai_y + ai_height + 10
st_message.text		= as_help
st_message.visible	= TRUE
end subroutine

public function boolean wf_any_late_part (string as_job, date djobenddate);Long iRow
Long iTotalRows 
Long iCount

String l_s_part

MessageBox(monsys.msg_title, "wf_any_late_part")

Boolean bPartInJob 	= FALSE
Boolean bPartLate		= FALSE	

dw_work_order_detail.Retrieve(szJob)
iTotalRows	= dw_work_order_detail.RowCount()
iRow			= 1
bPartLate	= FALSE

Do while (Not bPartLate) AND (Not bPartInJob) AND (iRow <= iTotalRows)

	l_s_part	= dw_work_order_detail.GetItemString(iRow, "part")

	If f_get_part_info(l_s_part, "TYPE") = 'F' then	//Only for finished part

		iCount	= dw_earliest_releases.Find("part_number = '" + l_s_part + "'", 1, 99999)
		If iCount > 0 then
			Do while (Not bPartLate) AND (iCount <= iOrderDetailCount) AND &
						(dw_earliest_releases.GetItemString(iCount, "part_number") = l_s_part)

				bPartLate	= (dJobEndDate > 	dw_earliest_releases.GetItemDate(iCount, "date_stamp"))
				iSalesOrder	= dw_earliest_releases.GetItemNumber(iCount, "order_no")

				iCount ++
			Loop
		End If

	End If

	iRow ++

Loop

Return bPartLate
end function

public subroutine wf_save_job_to_history (string as_job);String 	l_s_WorkOrder   
String	szTool
String   l_s_Machine    
String   szProcessId
String   szCustomerPart
String   szEmployee   
String	szType   
String	szMaterialShortage   
String	szLotControlActivated  
String	szCycleUnit   

Decimal  nCycleRequired   
Decimal	nCycleCompleted   
Decimal  nSetupTime   
Decimal  nCyclesHour   
Decimal  nStandardPack   
Decimal  nAccumRuntime   

Decimal	nCycleTime   
Decimal  nRunTime   

Long		iSequence   

Datetime	dtDueDate   
Datetime dtStartDate   
Datetime dtEndDate   
dateTime	dtStartTime   
dateTime	dtEndTime   

  SELECT work_order.work_order,   
         work_order.tool,   
         work_order.due_date,   
         work_order.cycles_required,   
         work_order.cycles_completed,   
         work_order.machine_no,   
         work_order.process_id,   
         work_order.customer_part,   
         work_order.setup_time,   
         work_order.cycles_hour,   
         work_order.standard_pack,   
         work_order.sequence,   
         work_order.cycle_time,   
         work_order.start_date,   
         work_order.start_time,   
         work_order.end_date,   
         work_order.end_time,   
         work_order.runtime,   
         work_order.employee,   
         work_order.type,   
         work_order.accum_run_time,   
         work_order.cycle_unit,   
         work_order.material_shortage,   
         work_order.lot_control_activated  
    INTO :l_s_WorkOrder,   
         :szTool,   
         :dtDueDate,   
         :nCycleRequired,   
         :nCycleCompleted,   
         :l_s_Machine ,   
         :szProcessId,   
         :szCustomerPart,   
         :nSetuptime,   
         :nCyclesHour,   
         :nStandardPack,   
         :iSequence,   
         :nCycleTime,   
         :dtStartDate,   
         :dtStartTime,   
         :dtEndDate,   
         :dtEndTime,   
         :nRunTime,   
         :szEmployee,   
         :szType,   
         :nAccumruntime,   
         :szCycleUnit,   
         :szMaterialShortage,   
         :szLotControlActivated  
    FROM work_order  
   WHERE work_order.work_order = :as_job   ;

If SQLCA.SQLCode = 0 then
	  INSERT INTO workorder_header_history  
         ( work_order,   
           tool,   
           due_date,   
           cycles_required,   
           cycles_completed,   
           machine_no,   
           process_id,   
           customer_part,   
           setup_time,   
           cycles_hour,   
           standard_pack,   
           sequence,   
           cycle_time,   
           start_date,   
           start_time,   
           end_date,   
           end_time,   
           runtime,   
           employee,   
           type,   
           accum_run_time,   
           cycle_unit,   
           material_shortage,   
           lot_control_activated )  
  VALUES ( :l_s_WorkOrder,   
           :szTool,   
           :dtDueDate,   
           :nCycleRequired,   
           :nCycleCompleted,   
           :l_s_Machine ,   
           :szProcessId,   
           :szCustomerPart,   
           :nSetupTime,   
           :nCyclesHour,   
           :nStandardPack,   
           :iSequence,   
           :nCycleTime,   
           :dtStartDate,   
           :dtStartTime,   
           :dtEndDate,   
           :dtEndTime,   
           :nRunTime,   
           :szEmployee,   
           :szType,   
           :nAccumRunTime,   
           :szCycleUnit,   
           :szMaterialShortage,   
           :szLotControlActivated )  ;

	If SQLCA.SQLCode  = 0 then
		Commit;
	Else
		Rollback;
		MessageBox(monsys.msg_title, SQLCA.SQLErrText, Information!)
	End If

End If
end subroutine

on open;//************************************************************************
//* Declaration
//************************************************************************
String cShow_name

dw_jobs.SetTransObject(sqlca)							//List of all jobs
dw_workorder.SetTransObject(sqlca)					//Work order info
dw_machine_list.SetTransObject(sqlca)				//List of all machine
dw_schedule.SetTransObject(sqlca)					//Shop floor schedule
dw_jobs_for_machine.SetTransObject(sqlca)			//List of all jobs for machine
dw_work_order_detail.SetTransObject(sqlca)		//List of work order detail
dw_mps_in_work_order.SetTransObject(sqlca)		//List mps for the job
dw_jobs_in_time_order.SetTransObject(sqlca)		//List jobs in time order
dw_check_machine.SetTransObject(sqlca)				//Used to check the part/machine relation
dw_mps_item_by_id.SetTransObject(sqlca)			//Search mps item by id number
dw_mps_item_by_parent_id.SetTransObject(sqlca) 	//Search mps item by parent id number
dw_machine_in_group.SetTransObject(sqlca)      	//Check whether the machine is in group
dw_groups_in_location.SetTransObject(sqlca)		//Retrieve group in location
dw_customer_in_order.SetTransObject(sqlca)		//Retrieve customer in sales order
dw_comm_mat_set.SetTransObject(sqlca)				//Common material set
dw_earliest_releases.SetTransObject(sqlca)		//The earliest releases

//************************************************************************
//* Initilization
//************************************************************************

SELECT parameters.show_program_name  
INTO  :cShow_name  
FROM   parameters  ;

If cShow_name	= 'Y' then
	this.title	= this.title + " [w_plant_monitor]"
End If

dw_machine_list.Retrieve()
dw_machine_list.SetFilter ( 'status = ~'R~'' )
dw_machine_list.Filter ( )
dw_groups_in_location.Retrieve()

ddlb_machine_type.text	= "A"


sle_days_to_display.text	= String(i_i_TotalDays)

wf_set_color_list()			
Initialize_labels()			//Reset labels
Initialize_lines()			//Reset lines

Initialize_date(Today())	//Reset dates
Initialize_machine()			//Reset machines
Initialize_job()				//Reset jobs

iBlackColor				= r_shift_block.FillColor
hsb_date.MinPosition	= 0
hsb_date.MaxPosition	= 14 * iDistanceX

draw_time_bar()

timer(f_time_interval())


end on

on timer;Long iCount
 
If bFlash then
	For iCount = 1 to iLastInIndex
		If JobList[JobIndex[iCount].Job_index].st_job.BackColor = iFlashColor then
			JobList[JobIndex[iCount].Job_index].st_job.BackColor = JobIndex[iCount].Job_color
		Else
			JobList[JobIndex[iCount].Job_index].st_job.BackColor = iFlashColor
		End If
	Next
End If

If iLastOverCompIndex > 0 then
	For iCount = 1 to iLastOverCompIndex
		If MachineList[OverCompIndex[iCount].Job_index].TextColor = 65280 then
			MachineList[OverCompIndex[iCount].Job_index].TextColor = 0
		Else
			MachineList[OverCompIndex[iCount].Job_index].TextColor = 65280
		End If
	Next
End If

st_time.x		= ln_time.beginX
If Not ln_time.visible then
	ln_time.visible = TRUE
End If

st_time.text			= String(Now())
st_time.BringToTop	= TRUE

If i_b_FreshScreen then
	iTimeCount ++
	If iTimeCount > 1 then
		iTimeCount	= 0
		If dw_machine_list.RowCount() > 0 then
			If iMachineRow >= dw_machine_list.RowCount() then
				sle_check.visible	= FALSE
				sle_check.width	= 0
				iMachineRow	= 1
				sle_check.visible	= TRUE
			Else
				iMachineRow ++
			End If
			wf_refresh_machine(iMachineRow)
			st_check.text	= "Check:" + Trim(dw_machine_list.GetItemString(iMachineRow, "machine_no"))
			sle_check.width	= iMessageBarWidth * iMachineRow / dw_machine_list.RowCount()
		End If
	Else
		iTimeCount ++	
	End If
End If			

end on

on resize;vsb_machine.x		= this.width 	- vsb_machine.width - 20
vsb_machine.height= this.height	- 453 - hsb_date.height
hsb_date.y			= vsb_machine.y + vsb_machine.height
hsb_date.width		= this.width	- vsb_machine.width

vsb_machine.bringtotop	= TRUE
hsb_date.bringtotop		= TRUE


end on

event activate;IF gnv_App.of_GetFrame().MenuName <> 'm_plant_monitor' THEN &        
	gnv_App.of_GetFrame().Changemenu ( m_plant_monitor )

//gnv_App.of_GetFrame().ChangeMenu(m_plant_monitor) 

wf_close_job_windows()
end event

event close;wf_destroy_objects()
wf_close_job_windows()
if isvalid(w_manual_wo_create) then close(w_manual_wo_create)
	
end event

event dragdrop;//*********************************************************************
//* Declaration
//*********************************************************************
Int bDailyDistanceLeft
Int iHour
Int iMinute
Int iSecond

Date dCurrentDate
Time tCurrentTime

Long 	iXLeft
Long 	iYLeft
Long 	iMachineNo	//to keep the machine count
Long 	l_i_PointerX, &
		l_i_PointerY

Decimal nHour

Boolean bAssign	//Whether assign the job to different machine
//************************************************************************
//* Main Routine
//***********************************************************************

Timer(0)
sle_drag.Visible		= FALSE	

If bDragShift then	//If dragging the new shift
	If (PointerX() >= 485) and &
		(PointerY() >= 229) and (PointerY() <= (229 + 89)) then
		locate_shift_date_time(PointerX() - (r_new_shift.Width / 2))
	End If
Else						//If dragging a job object
	// Deduct (CurrentJob.Width / 2) is for the visual effect. so the front edge
	// will be the starting time instead of the central of the block

	l_i_PointerX		= PointerX()
	l_i_PointerY		= PointerY()

	iXLeft = l_i_PointerX - (CurrentJob.Width / 2) - iInitJobX - iDistanceX
	If iXLeft > 0 then
		bDailyDistanceLeft = iXLeft
	Else
		bDailyDistanceLeft = l_i_PointerX - (CurrentJob.Width / 2) - iInitJobX
	End If

	dCurrentDate = Date(sDate[1].text)

	Do while iXLeft > 0 
		bDailyDistanceLeft = iXLeft
		dCurrentDate = next_day(dCurrentDate)
		iXLeft = iXLeft - iDistanceX
	Loop

	If bDailyDistanceLeft > 0 then
		nHour 	= 24 * bDailyDistanceLeft / 366
		iHour 	= Truncate(nHour, 0)
		iMinute 	= (nHour - iHour) * 60
		iSecond	= 0
		tCurrentTime = time(iHour, iMinute, iSecond)

		dw_workorder.Retrieve(sle_1.text)
		If dw_workorder.RowCount() > 0 then
			dw_workorder.SetItem(1, "start_date", dCurrentDate)
			dw_workorder.SetItem(1, "start_time", tCurrentTime)

			iMachineNo	= get_machine_no(l_i_PointerY)

			bAssign	= FALSE

			If (iMachineNo > 0) Then
				If MachineList[iMachineNo].text <> szMachine then
					bAssign	= TRUE				
					If MachineList[iMachineNo].TextColor <> iGreenColor then
						bAssign = (MessageBox("This job sould not run on " + MachineList[iMachineNo].text, &
									 "Do you still want to run anyway", Exclamation!, OKCancel!, 2) = 1)												 
					End If

					If bAssign then	//Assign the job to the 
						dw_workorder.SetItem(1, "work_order", sle_1.text)
						dw_workorder.SetItem(1, "machine_no", MachineList[iMachineNo].text)
						dw_workorder.SetItem(1, "sequence"  , 99999)	
					End If
				End If
			End If

			If dw_workorder.Update() > 0 then
				Commit;
				CurrentJob.x = l_i_PointerX - (CurrentJob.Width / 2)
			Else
				Rollback;
			End If
		End If

		If bAssign then		//If assign to different machine, need rearragement
			Rearrange_sequence(MachineList[iMachineNo].text)
			OpenWithParm(w_calculate_job_time, MachineList[iMachineNo].text)
		End If

		Rearrange_sequence(szMachine)	//Reset the sequence according to the time order
		OpenWithParm(w_calculate_job_time, szMachine)

		ReDraw()		

	Else
		MessageBox( monsys.msg_title, "Scheculed Time is out of bound", StopSign!)
	End If	

End If

wf_enable_job_objects(TRUE)
bDragShift				= FALSE
bDragExistingShift	= FALSE
Timer(5)


	
	

end event

on rbuttondown;//If iJobX > 0 AND iJobY > 0 then
//	sle_drag.Width 	= CurrentJob.Width
//	sle_drag.Height	= CurrentJob.Height
//	sle_drag.Drag(Begin!)
//	If sle_1.text > "" then			//Dragging the job object
//		Flag_machine(sle_1.text)	//Flag all related machines
//	End If		
//End If
end on

on clicked;szMachine	= Select_machine(PointerX(), PointerY())
If szMachine > "" then
	st_machine.text	= szMachine
	draw_shifts()
Else
	select_shift(PointerX(), PointerY())
End If
end on

on doubleclicked;st_generic_structure stParm

select_shift(PointerX(), PointerY())

If iCurrentShiftNo > 0 then	
	Open(w_shift_time_scale)
End If


end on

on w_plant_monitor.create
this.ddlb_=create ddlb_
this.uo_time_grid2=create uo_time_grid2
this.st_message=create st_message
this.st_machine=create st_machine
this.ddlb_display=create ddlb_display
this.st_1=create st_1
this.hsb_date=create hsb_date
this.ddlb_flash=create ddlb_flash
this.vsb_machine=create vsb_machine
this.st_3=create st_3
this.sle_days_to_display=create sle_days_to_display
this.r_new_shift=create r_new_shift
this.sle_1=create sle_1
this.st_39=create st_39
this.st_25=create st_25
this.st_order=create st_order
this.sle_check=create sle_check
this.st_check=create st_check
this.dw_earliest_releases=create dw_earliest_releases
this.sle_order=create sle_order
this.dw_comm_mat_set=create dw_comm_mat_set
this.p_1=create p_1
this.dw_customer_in_order=create dw_customer_in_order
this.dw_groups_in_location=create dw_groups_in_location
this.dw_machine_in_group=create dw_machine_in_group
this.ddlb_machine_type=create ddlb_machine_type
this.dw_sorted_jobs=create dw_sorted_jobs
this.dw_mps_item_by_parent_id=create dw_mps_item_by_parent_id
this.dw_mps_item_by_id=create dw_mps_item_by_id
this.dw_check_machine=create dw_check_machine
this.dw_work_order_detail=create dw_work_order_detail
this.dw_jobs_for_machine=create dw_jobs_for_machine
this.dw_schedule=create dw_schedule
this.dw_mps_in_work_order=create dw_mps_in_work_order
this.dw_jobs=create dw_jobs
this.dw_jobs_in_time_order=create dw_jobs_in_time_order
this.dw_machine_list=create dw_machine_list
this.dw_workorder=create dw_workorder
this.sle_drag=create sle_drag
this.mle_message=create mle_message
this.st_time=create st_time
this.uo_time_grid1=create uo_time_grid1
this.ddlb_type_value=create ddlb_type_value
this.gb_selection=create gb_selection
this.r_shift_block=create r_shift_block
this.ln_1=create ln_1
this.ln_time=create ln_time
this.ln_3=create ln_3
this.oval_2=create oval_2
this.oval_3=create oval_3
this.oval_4=create oval_4
this.oval_5=create oval_5
this.oval_6=create oval_6
this.oval_7=create oval_7
this.oval_8=create oval_8
this.oval_9=create oval_9
this.oval_10=create oval_10
this.oval_11=create oval_11
this.oval_12=create oval_12
this.oval_1=create oval_1
this.ln_date1=create ln_date1
this.ln_date2=create ln_date2
this.ln_date3=create ln_date3
this.ln_date4=create ln_date4
this.ln_date5=create ln_date5
this.ln_date6=create ln_date6
this.ln_date7=create ln_date7
this.ln_date8=create ln_date8
this.ln_date14=create ln_date14
this.ln_date13=create ln_date13
this.ln_date12=create ln_date12
this.ln_date11=create ln_date11
this.ln_date10=create ln_date10
this.ln_date9=create ln_date9
this.ln_date16=create ln_date16
this.ln_date17=create ln_date17
this.ln_date18=create ln_date18
this.ln_date19=create ln_date19
this.ln_date20=create ln_date20
this.ln_date21=create ln_date21
this.ln_date22=create ln_date22
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
this.ln_date33=create ln_date33
this.ln_date34=create ln_date34
this.ln_date35=create ln_date35
this.ln_date36=create ln_date36
this.ln_date37=create ln_date37
this.ln_date38=create ln_date38
this.ln_date39=create ln_date39
this.ln_date40=create ln_date40
this.ln_date41=create ln_date41
this.ln_date15=create ln_date15
this.ln_date42=create ln_date42
this.Control[]={this.ddlb_,&
this.uo_time_grid2,&
this.st_message,&
this.st_machine,&
this.ddlb_display,&
this.st_1,&
this.hsb_date,&
this.ddlb_flash,&
this.vsb_machine,&
this.st_3,&
this.sle_days_to_display,&
this.r_new_shift,&
this.sle_1,&
this.st_39,&
this.st_25,&
this.st_order,&
this.sle_check,&
this.st_check,&
this.dw_earliest_releases,&
this.sle_order,&
this.dw_comm_mat_set,&
this.p_1,&
this.dw_customer_in_order,&
this.dw_groups_in_location,&
this.dw_machine_in_group,&
this.ddlb_machine_type,&
this.dw_sorted_jobs,&
this.dw_mps_item_by_parent_id,&
this.dw_mps_item_by_id,&
this.dw_check_machine,&
this.dw_work_order_detail,&
this.dw_jobs_for_machine,&
this.dw_schedule,&
this.dw_mps_in_work_order,&
this.dw_jobs,&
this.dw_jobs_in_time_order,&
this.dw_machine_list,&
this.dw_workorder,&
this.sle_drag,&
this.mle_message,&
this.st_time,&
this.uo_time_grid1,&
this.ddlb_type_value,&
this.gb_selection,&
this.r_shift_block,&
this.ln_1,&
this.ln_time,&
this.ln_3,&
this.oval_2,&
this.oval_3,&
this.oval_4,&
this.oval_5,&
this.oval_6,&
this.oval_7,&
this.oval_8,&
this.oval_9,&
this.oval_10,&
this.oval_11,&
this.oval_12,&
this.oval_1,&
this.ln_date1,&
this.ln_date2,&
this.ln_date3,&
this.ln_date4,&
this.ln_date5,&
this.ln_date6,&
this.ln_date7,&
this.ln_date8,&
this.ln_date14,&
this.ln_date13,&
this.ln_date12,&
this.ln_date11,&
this.ln_date10,&
this.ln_date9,&
this.ln_date16,&
this.ln_date17,&
this.ln_date18,&
this.ln_date19,&
this.ln_date20,&
this.ln_date21,&
this.ln_date22,&
this.ln_date23,&
this.ln_date24,&
this.ln_date25,&
this.ln_date26,&
this.ln_date27,&
this.ln_date28,&
this.ln_date29,&
this.ln_date30,&
this.ln_date31,&
this.ln_date32,&
this.ln_date33,&
this.ln_date34,&
this.ln_date35,&
this.ln_date36,&
this.ln_date37,&
this.ln_date38,&
this.ln_date39,&
this.ln_date40,&
this.ln_date41,&
this.ln_date15,&
this.ln_date42}
end on

on w_plant_monitor.destroy
destroy(this.ddlb_)
destroy(this.uo_time_grid2)
destroy(this.st_message)
destroy(this.st_machine)
destroy(this.ddlb_display)
destroy(this.st_1)
destroy(this.hsb_date)
destroy(this.ddlb_flash)
destroy(this.vsb_machine)
destroy(this.st_3)
destroy(this.sle_days_to_display)
destroy(this.r_new_shift)
destroy(this.sle_1)
destroy(this.st_39)
destroy(this.st_25)
destroy(this.st_order)
destroy(this.sle_check)
destroy(this.st_check)
destroy(this.dw_earliest_releases)
destroy(this.sle_order)
destroy(this.dw_comm_mat_set)
destroy(this.p_1)
destroy(this.dw_customer_in_order)
destroy(this.dw_groups_in_location)
destroy(this.dw_machine_in_group)
destroy(this.ddlb_machine_type)
destroy(this.dw_sorted_jobs)
destroy(this.dw_mps_item_by_parent_id)
destroy(this.dw_mps_item_by_id)
destroy(this.dw_check_machine)
destroy(this.dw_work_order_detail)
destroy(this.dw_jobs_for_machine)
destroy(this.dw_schedule)
destroy(this.dw_mps_in_work_order)
destroy(this.dw_jobs)
destroy(this.dw_jobs_in_time_order)
destroy(this.dw_machine_list)
destroy(this.dw_workorder)
destroy(this.sle_drag)
destroy(this.mle_message)
destroy(this.st_time)
destroy(this.uo_time_grid1)
destroy(this.ddlb_type_value)
destroy(this.gb_selection)
destroy(this.r_shift_block)
destroy(this.ln_1)
destroy(this.ln_time)
destroy(this.ln_3)
destroy(this.oval_2)
destroy(this.oval_3)
destroy(this.oval_4)
destroy(this.oval_5)
destroy(this.oval_6)
destroy(this.oval_7)
destroy(this.oval_8)
destroy(this.oval_9)
destroy(this.oval_10)
destroy(this.oval_11)
destroy(this.oval_12)
destroy(this.oval_1)
destroy(this.ln_date1)
destroy(this.ln_date2)
destroy(this.ln_date3)
destroy(this.ln_date4)
destroy(this.ln_date5)
destroy(this.ln_date6)
destroy(this.ln_date7)
destroy(this.ln_date8)
destroy(this.ln_date14)
destroy(this.ln_date13)
destroy(this.ln_date12)
destroy(this.ln_date11)
destroy(this.ln_date10)
destroy(this.ln_date9)
destroy(this.ln_date16)
destroy(this.ln_date17)
destroy(this.ln_date18)
destroy(this.ln_date19)
destroy(this.ln_date20)
destroy(this.ln_date21)
destroy(this.ln_date22)
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
destroy(this.ln_date33)
destroy(this.ln_date34)
destroy(this.ln_date35)
destroy(this.ln_date36)
destroy(this.ln_date37)
destroy(this.ln_date38)
destroy(this.ln_date39)
destroy(this.ln_date40)
destroy(this.ln_date41)
destroy(this.ln_date15)
destroy(this.ln_date42)
end on

type ddlb_ from dropdownlistbox within w_plant_monitor
int X=457
int Y=32
int Width=407
int Height=224
int TabOrder=120
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Days to display",&
"48 hours"}
end type

on modified;if this.text = '48 hours' then
	ib_display_by_date			= FALSE
	uo_time_grid1.visible		= TRUE
	uo_time_grid2.visible		= TRUE
	uo_time_grid1.bringtotop	= FALSE
	uo_time_grid2.bringtotop	= FALSE
	ii_factor						= 3
	sle_days_to_display.visible	= FALSE
else
	ib_display_by_date		= TRUE
	uo_time_grid1.visible	= FALSE
	uo_time_grid2.visible	= FALSE
	ii_factor					= 1
	sle_days_to_display.visible	= TRUE
	sle_days_to_display.text		= '14'	
end if

redraw()
end on

on constructor;this.text	= 'Days to display'
end on

type uo_time_grid2 from u_time_grid within w_plant_monitor
int X=1509
int Y=164
int Width=1074
int Height=92
int TabOrder=60
boolean Visible=false
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_time_grid2.destroy
call u_time_grid::destroy
end on

type st_message from statictext within w_plant_monitor
int X=18
int Y=416
int Width=494
int Height=96
boolean Visible=false
boolean Enabled=false
boolean Border=true
string Text="none"
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

type st_machine from statictext within w_plant_monitor
int Y=256
int Width=475
int Height=96
boolean Enabled=false
boolean Border=true
Alignment Alignment=Center!
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

type ddlb_display from dropdownlistbox within w_plant_monitor
event we_nchittest pbm_nchittest
int X=1915
int Y=32
int Width=329
int Height=224
int TabOrder=110
string Text="Part#"
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Part#",&
"Job#"}
end type

event we_nchittest;//wf_bubble_help( this.x, this.y, gb_selection.height, 'Select which to show on jobs' )
end event

on selectionchanged;/*
Description	:	To display job# / part# on the job user object.
Author		:	Jim Wu
Start Date	:	02/07/96
Modification:
*/

/* Declaration */
Integer	li_Total, &
			li_Ptr

/* Initialization */

/* Main Process */
li_Total	= Upperbound(JobList)

For li_Ptr	= 1 to li_Total
	If isvalid( JobList[li_Ptr] ) then
		If this.Text	= "Job#" then
			JobList[li_Ptr].st_job.text	= "    " + JobList[li_Ptr].i_s_Job
		Else
			JobList[li_Ptr].st_job.text	= &
				"    " + wf_first_job_part(JobList[li_Ptr].i_s_Job)
		End If
	End if
Next
	 
end on

type st_1 from statictext within w_plant_monitor
int X=1742
int Y=36
int Width=165
int Height=64
boolean Enabled=false
string Text="Display"
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

type hsb_date from hscrollbar within w_plant_monitor
int Y=1376
int Width=2907
int Height=64
boolean Enabled=false
boolean StdHeight=false
end type

on moved;wf_set_x_position(this.Position * (-1))

vsb_machine.bringtotop	= TRUE
end on

on pageright;If this.Position	< this.MaxPosition then
	this.Position	+= iDistanceX	
	wf_x_move(iDistanceX, -1)
End If


vsb_machine.bringtotop	= TRUE
end on

on lineright;If this.Position	< this.MaxPosition then
	this.Position	+= iDistanceX
	wf_x_move(iDistanceX	, -1)
End If
vsb_machine.bringtotop	= TRUE
end on

on pageleft;If this.Position > 0 then
	this.Position	-=	iDistanceX
	wf_x_move(iDistanceX, 1)
End If

vsb_machine.bringtotop	= TRUE
end on

on lineleft;If this.Position > 0 then
	this.Position	-=	iDistanceX
	wf_x_move( iDistanceX, 1)
End If

vsb_machine.bringtotop	= TRUE
end on

event rbuttondown;MessageBox(monsys.msg_title, "This is the horizontal bar.")
end event

type ddlb_flash from dropdownlistbox within w_plant_monitor
event we_nchittest pbm_nchittest
int X=1225
int Y=32
int Width=494
int Height=220
int TabOrder=100
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Material Shortage",&
"Sales Order",&
"Late Jobs"}
end type

event we_nchittest;//wf_bubble_help( this.x, this.y, gb_selection.height, 'Select jobs to be flashed on screen' )
end event

event selectionchanged;Long iCount

m_plant_monitor.mf_unflash()

//For iCount = 1 to iLastInIndex 
//		JobList[JobIndex[iCount].Job_index].st_job.BackColor = JobIndex[iCount].Job_color
//Next

redraw()
st_order.visible	= FALSE
sle_order.visible	= FALSE

Choose Case this.text
	case 'Late Jobs'
		dw_earliest_releases.Retrieve()
	case 'Sales Order'
		st_order.visible	= TRUE
		sle_order.visible	= TRUE
End choose


end event

type vsb_machine from vscrollbar within w_plant_monitor
int X=2816
int Y=352
int Width=91
int Height=1024
boolean Enabled=false
boolean StdWidth=false
end type

on pageup;If this.Position > 0 then
	this.Position	-=	iDistanceY
	wf_y_move(iDistanceY, 1)
End If

hsb_date.bringtotop	= TRUE
vsb_machine.bringtotop   = TRUE
end on

on moved;wf_set_y_position(this.Position * (-1))
hsb_date.bringtotop	= TRUE
vsb_machine.bringtotop   = TRUE
end on

on linedown;If this.Position	< this.MaxPosition then
	this.Position	+= iDistanceY
	wf_y_move(iDistanceY, -1)
End If
hsb_date.bringtotop	= TRUE
vsb_machine.bringtotop   = TRUE
end on

on lineup;If this.Position > 0 then
	this.Position	-=	iDistanceY
	wf_y_move(iDistanceY, 1)
End If
hsb_date.bringtotop	= TRUE
vsb_machine.bringtotop   = TRUE
end on

on pagedown;If this.Position	< this.MaxPosition then
	this.Position	+= iDistanceY
	wf_y_move(iDistanceY, -1)
End If

hsb_date.bringtotop = TRUE
vsb_machine.bringtotop   = TRUE
end on

type st_3 from statictext within w_plant_monitor
int X=1019
int Y=36
int Width=201
int Height=64
boolean Enabled=false
string Text="Selection"
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

type sle_days_to_display from singlelineedit within w_plant_monitor
event we_nchittest pbm_nchittest
int X=891
int Y=44
int Width=91
int Height=64
int TabOrder=10
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event we_nchittest;//wf_bubble_help( this.x, this.y, gb_selection.height, 'How many days to display' )
end event

event modified;i_i_TotalDays = Integer( this.text )
hsb_date.MaxPosition	= iDistanceX * Integer(this.text)
redraw()
end event

type r_new_shift from u_shifts within w_plant_monitor
int X=3017
int Y=2048
int Width=201
boolean Visible=false
end type

type sle_1 from singlelineedit within w_plant_monitor
int X=457
int Y=112
int Width=238
int Height=80
int TabOrder=40
boolean Visible=false
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

type st_39 from statictext within w_plant_monitor
int X=2286
int Y=36
int Width=128
int Height=64
boolean Enabled=false
string Text="Trash"
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

type st_25 from statictext within w_plant_monitor
int X=713
int Y=112
int Width=91
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Msg"
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

type st_order from statictext within w_plant_monitor
int X=1024
int Y=112
int Width=128
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Order"
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

type sle_check from singlelineedit within w_plant_monitor
int X=457
int Y=80
int Width=238
int Height=32
int TabOrder=280
boolean Visible=false
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-6
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_check from statictext within w_plant_monitor
int X=695
int Y=76
int Width=402
int Height=56
boolean Visible=false
boolean Enabled=false
string Text="Checking:"
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

type dw_earliest_releases from datawindow within w_plant_monitor
int X=37
int Y=2704
int Width=329
int Height=352
int TabOrder=140
boolean Visible=false
string DataObject="dw_list_of_earliest_order_releases"
boolean LiveScroll=true
end type

type sle_order from singlelineedit within w_plant_monitor
int X=1225
int Y=120
int Width=494
int Height=68
int TabOrder=190
boolean Visible=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;String 	szCurrentPart

String szOrder

szOrder	= this.text

iOrderDetailCount = 0

Declare OrderCur Cursor for 
SELECT DISTINCT PART FROM master_prod_sched  
Where origin = :szOrder
Using sqlca;

Open OrderCur;

Fetch OrderCur into :szCurrentPart;

Do while sqlca.sqlcode = 0
	iOrderDetailCount ++
	szOrderDetail[iOrderDetailCount]	= szCurrentPart
	Fetch OrderCur into :szCurrentPart;
Loop

Close OrderCur;

	
end on

type dw_comm_mat_set from datawindow within w_plant_monitor
int X=3950
int Y=2320
int Width=311
int Height=352
int TabOrder=150
boolean Visible=false
string DataObject="dw_common_material_set_for_job"
boolean LiveScroll=true
end type

type p_1 from picture within w_plant_monitor
event we_nchittest pbm_nchittest
int X=2427
int Y=36
int Width=110
int Height=64
string PictureName="trash.bmp"
boolean FocusRectangle=false
end type

on we_nchittest;wf_bubble_help( this.x, this.y, gb_selection.height, 'Dragdrop job here for deletion' )
end on

event dragdrop;//************************************************************************
//* Declaration
//************************************************************************

String	szPartList[]//To keep a list part to be deleted

Long 		iRow			//To keep the current row
Long		iCount		//To keep the total # of elements in szPartList ARRAY

//************************************************************************
//* Main Routine
//************************************************************************

If bDragExistingShift then

	If MessageBox(monsys.msg_title, "Delete Current Shift:" + String(dShiftDate)+ &
					  " | " + String(tShiftBeginTime) + " | " + String(Truncate(nShiftHour, 2)), Exclamation!, OkCancel!, 2) = 1 then
		dw_schedule.DeleteRow(iCurrentShiftNo)
		If dw_schedule.Update() > 0 then
			Commit;
		Else
			Rollback;
		End If
		szMachine	= st_machine.text
		Draw_shifts()
	End If

Else

	If sle_1.text > "" then			//If draging a job object

		If MessageBox(monsys.msg_title, "Delete Job:" + sle_1.text, Exclamation!, OkCancel!, 2) = 1 then

			iCount = 0
	
			dw_work_order_detail.Retrieve(sle_1.text)

			For iRow = 1 to dw_work_order_detail.RowCount()
				iCount ++
				szPartList[iCount]	= dw_work_order_detail.GetItemString(iRow, "part")
			Next
	
			If wf_job_is_touched(sle_1.text) then
				//wf_save_to_history(sle_1.text)
			End If
					
			Delete From work_order  
		   Where work_order = :sle_1.text   ;

			Delete From workorder_detail  
		   Where workorder = :sle_1.text   ;

			If  SQLCA.SQLCode = -1 then
				Rollback;
			Else
				Commit;

				For iRow = 1 to iCount
					stParm.value1	= szPartList[iRow]
					stParm.value3	= "M"
//					OpenWithParm(w_calculate_assigned_qty_in_mps, stParm) 
               f_update_qty_asgnd_part ( szPartList[iRow] ) // new fn. by mams sp based 
				Next
			End If

			Recalc_machine_job_time(st_machine.text)
			Redraw()

		End If
	End If
End If

bDragExistingShift 	= FALSE
bDragShift			 	= FALSE

end event

type dw_customer_in_order from datawindow within w_plant_monitor
int X=3602
int Y=2320
int Width=334
int Height=360
int TabOrder=130
boolean Visible=false
string DataObject="dw_customer_in_sales_order"
boolean LiveScroll=true
end type

type dw_groups_in_location from datawindow within w_plant_monitor
int X=3273
int Y=2320
int Width=320
int Height=360
int TabOrder=160
boolean Visible=false
string DataObject="dw_groups_in_location"
boolean LiveScroll=true
end type

type dw_machine_in_group from datawindow within w_plant_monitor
int X=2944
int Y=2320
int Width=311
int Height=360
int TabOrder=170
boolean Visible=false
string DataObject="dw_check_machine_in_group"
boolean LiveScroll=true
end type

type ddlb_machine_type from dropdownlistbox within w_plant_monitor
int X=14
int Y=24
int Width=421
int Height=352
int TabOrder=30
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
string Item[]={"All Machines",&
"Group"}
end type

on selectionchanged;If this.text = "Group" then
	ddlb_type_value.visible = TRUE
	get_group()					//Build the group drop down list
End If

If this.text	= "All Machines" then
	bFlash = False
	ddlb_type_value.visible = FALSE
	dw_machine_list.SetFilter ( 'status = ~'R~'' )
	dw_machine_list.Filter ( )
	redraw()
End If
end on

type dw_sorted_jobs from datawindow within w_plant_monitor
int X=366
int Y=2704
int Width=274
int Height=352
int TabOrder=180
boolean Visible=false
string DataObject="dw_sorted_job_list"
boolean TitleBar=true
string Title="Order of Jobs"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_mps_item_by_parent_id from datawindow within w_plant_monitor
int X=2615
int Y=2320
int Width=311
int Height=356
int TabOrder=200
boolean Visible=false
string DataObject="dw_search_mps_item_by_parent_id"
boolean LiveScroll=true
end type

type dw_mps_item_by_id from datawindow within w_plant_monitor
int X=2322
int Y=2320
int Width=283
int Height=360
int TabOrder=210
boolean Visible=false
string DataObject="dw_search_mps_item_by_id"
boolean LiveScroll=true
end type

type dw_check_machine from datawindow within w_plant_monitor
int X=2048
int Y=2320
int Width=293
int Height=360
int TabOrder=220
boolean Visible=false
string DataObject="dw_check_machine_for_part"
boolean LiveScroll=true
end type

type dw_work_order_detail from datawindow within w_plant_monitor
int X=1481
int Y=2320
int Width=270
int Height=360
int TabOrder=250
boolean Visible=false
string DataObject="dw_consolidated_workorder"
boolean LiveScroll=true
end type

type dw_jobs_for_machine from datawindow within w_plant_monitor
int X=1207
int Y=2320
int Width=283
int Height=360
int TabOrder=260
boolean Visible=false
string DataObject="dw_list_of_jobs_for_machine"
boolean LiveScroll=true
end type

type dw_schedule from datawindow within w_plant_monitor
int X=914
int Y=2320
int Width=283
int Height=360
int TabOrder=310
boolean Visible=false
string DataObject="dw_shop_floor_calendar_machine"
boolean LiveScroll=true
end type

type dw_mps_in_work_order from datawindow within w_plant_monitor
int X=640
int Y=2320
int Width=261
int Height=360
int TabOrder=240
boolean Visible=false
string DataObject="dw_mps_items_in_work_order"
boolean LiveScroll=true
end type

type dw_jobs from datawindow within w_plant_monitor
int X=37
int Y=2320
int Width=325
int Height=356
int TabOrder=290
boolean Visible=false
string DataObject="dw_list_of_jobs"
boolean LiveScroll=true
end type

type dw_jobs_in_time_order from datawindow within w_plant_monitor
int X=1755
int Y=2320
int Width=293
int Height=360
int TabOrder=230
boolean Visible=false
string DataObject="dw_work_order_in_begin_date_time_order"
boolean LiveScroll=true
end type

type dw_machine_list from datawindow within w_plant_monitor
int X=4279
int Y=2320
int Width=658
int Height=256
int TabOrder=80
boolean Visible=false
string DataObject="d_machine_status_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_workorder from datawindow within w_plant_monitor
int X=366
int Y=2320
int Width=288
int Height=360
int TabOrder=300
boolean Visible=false
string DataObject="dw_workorder_header_info"
boolean LiveScroll=true
end type

type sle_drag from singlelineedit within w_plant_monitor
int X=4315
int Y=1136
int Width=238
int Height=64
int TabOrder=90
boolean Visible=false
boolean Enabled=false
BorderStyle BorderStyle=StyleRaised!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_message from multilineedit within w_plant_monitor
int X=823
int Y=112
int Width=823
int Height=64
int TabOrder=270
boolean Visible=false
boolean Border=false
boolean AutoVScroll=true
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time from statictext within w_plant_monitor
int X=494
int Y=264
int Width=201
int Height=56
boolean Enabled=false
string Text="now"
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

type uo_time_grid1 from u_time_grid within w_plant_monitor
int X=466
int Y=164
int Width=1070
int Height=92
int TabOrder=50
boolean Visible=false
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_time_grid1.destroy
call u_time_grid::destroy
end on

type ddlb_type_value from dropdownlistbox within w_plant_monitor
int X=18
int Y=108
int Width=421
int Height=768
int TabOrder=70
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
end type

on selectionchanged;If bFlash Then
   bFlash = False
End If

dw_machine_list.SetFilter ( 'status = ~'R~' AND group_no = ~'' + Text + '~'' )
dw_machine_list.Filter ( )
Redraw()
end on

type gb_selection from groupbox within w_plant_monitor
int X=439
int Width=2126
int Height=124
int TabOrder=20
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

type r_shift_block from rectangle within w_plant_monitor
int X=475
int Y=256
int Width=4882
int Height=96
boolean Enabled=false
int LineThickness=4
long LineColor=77897888
long FillColor=77897888
end type

type ln_1 from line within w_plant_monitor
boolean Enabled=false
int BeginX=18
int BeginY=256
int EndX=5376
int EndY=256
int LineThickness=4
long LineColor=33554432
end type

type ln_time from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=3392
int BeginY=256
int EndX=3392
int EndY=1728
LineStyle LineStyle=dashdotdot!
int LineThickness=4
long LineColor=255
end type

type ln_3 from line within w_plant_monitor
boolean Enabled=false
int BeginX=9
int BeginY=352
int EndX=5367
int EndY=352
int LineThickness=4
long LineColor=33554432
end type

type oval_2 from oval within w_plant_monitor
int X=5431
int Y=368
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=16777215
end type

type oval_3 from oval within w_plant_monitor
int X=5431
int Y=448
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=16711935
end type

type oval_4 from oval within w_plant_monitor
int X=5431
int Y=528
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=65280
end type

type oval_5 from oval within w_plant_monitor
int X=5431
int Y=608
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=65535
end type

type oval_6 from oval within w_plant_monitor
int X=5431
int Y=688
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=16711680
end type

type oval_7 from oval within w_plant_monitor
int X=5431
int Y=768
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=16776960
end type

type oval_8 from oval within w_plant_monitor
int X=5431
int Y=848
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=128
end type

type oval_9 from oval within w_plant_monitor
int X=5431
int Y=928
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=8388736
long FillColor=32896
end type

type oval_10 from oval within w_plant_monitor
int X=5431
int Y=1008
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=32768
long FillColor=32768
end type

type oval_11 from oval within w_plant_monitor
int X=5431
int Y=1088
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=32768
long FillColor=8388608
end type

type oval_12 from oval within w_plant_monitor
int X=5431
int Y=1168
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=32768
long FillColor=8421376
end type

type oval_1 from oval within w_plant_monitor
int X=5431
int Y=288
int Width=73
int Height=64
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=32768
long FillColor=8421504
end type

type ln_date1 from line within w_plant_monitor
boolean Enabled=false
int BeginX=494
int BeginY=256
int EndX=498
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date2 from line within w_plant_monitor
boolean Enabled=false
int BeginX=841
int BeginY=256
int EndX=841
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date3 from line within w_plant_monitor
boolean Enabled=false
int BeginX=1262
int BeginY=256
int EndX=1262
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date4 from line within w_plant_monitor
boolean Enabled=false
int BeginX=1591
int BeginY=256
int EndX=1591
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date5 from line within w_plant_monitor
boolean Enabled=false
int BeginX=1883
int BeginY=256
int EndX=1883
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date6 from line within w_plant_monitor
boolean Enabled=false
int BeginX=2176
int BeginY=256
int EndX=2176
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date7 from line within w_plant_monitor
boolean Enabled=false
int BeginX=2505
int BeginY=256
int EndX=2505
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date8 from line within w_plant_monitor
boolean Enabled=false
int BeginX=2889
int BeginY=256
int EndX=2889
int EndY=2448
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date14 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=304
int EndX=5029
int EndY=2496
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date13 from line within w_plant_monitor
boolean Enabled=false
int BeginX=4663
int BeginY=320
int EndX=4663
int EndY=2512
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date12 from line within w_plant_monitor
boolean Enabled=false
int BeginX=4334
int BeginY=320
int EndX=4334
int EndY=2512
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date11 from line within w_plant_monitor
boolean Enabled=false
int BeginX=3968
int BeginY=336
int EndX=3968
int EndY=2528
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date10 from line within w_plant_monitor
boolean Enabled=false
int BeginX=3602
int BeginY=352
int EndX=3602
int EndY=2544
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date9 from line within w_plant_monitor
boolean Enabled=false
int BeginX=3237
int BeginY=352
int EndX=3237
int EndY=2544
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=33554432
end type

type ln_date16 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=320
int EndX=5029
int EndY=2512
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date17 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=336
int EndX=5029
int EndY=2528
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date18 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=352
int EndX=5029
int EndY=2544
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date19 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=368
int EndX=5029
int EndY=2560
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date20 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=384
int EndX=5029
int EndY=2576
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date21 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=400
int EndX=5029
int EndY=2592
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date22 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=416
int EndX=5029
int EndY=2608
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date23 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=432
int EndX=5029
int EndY=2624
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date24 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=448
int EndX=5029
int EndY=2640
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date25 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=464
int EndX=5029
int EndY=2656
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date26 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=480
int EndX=5029
int EndY=2672
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date27 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=496
int EndX=5029
int EndY=2688
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date28 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=512
int EndX=5029
int EndY=2704
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date29 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=528
int EndX=5029
int EndY=2720
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date30 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=544
int EndX=5029
int EndY=2736
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date31 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=560
int EndX=5029
int EndY=2752
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date32 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=576
int EndX=5029
int EndY=2768
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date33 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=592
int EndX=5029
int EndY=2784
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date34 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=608
int EndX=5029
int EndY=2800
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date35 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=624
int EndX=5029
int EndY=2816
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date36 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=640
int EndX=5029
int EndY=2832
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date37 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=656
int EndX=5029
int EndY=2848
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date38 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=672
int EndX=5029
int EndY=2864
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date39 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=688
int EndX=5029
int EndY=2880
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date40 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=704
int EndX=5029
int EndY=2896
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date41 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=720
int EndX=5029
int EndY=2912
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date15 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=736
int EndX=5029
int EndY=2928
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type

type ln_date42 from line within w_plant_monitor
boolean Visible=false
boolean Enabled=false
int BeginX=5029
int BeginY=752
int EndX=5029
int EndY=2944
LineStyle LineStyle=dot!
int LineThickness=4
long LineColor=8388608
end type


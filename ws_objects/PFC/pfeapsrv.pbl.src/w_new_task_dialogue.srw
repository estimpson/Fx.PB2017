$PBExportHeader$w_new_task_dialogue.srw
$PBExportComments$(PFD)
forward
global type w_new_task_dialogue from w_open_job_dialogue
end type
type uo_schedule from u_cst_schedule within w_new_task_dialogue
end type
end forward

global type w_new_task_dialogue from w_open_job_dialogue
int Width=2633
uo_schedule uo_schedule
end type
global w_new_task_dialogue w_new_task_dialogue

on w_new_task_dialogue.create
int iCurrent
call super::create
this.uo_schedule=create uo_schedule
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_schedule
end on

on w_new_task_dialogue.destroy
call super::destroy
destroy(this.uo_schedule)
end on

event lv_job_names::itemchanged;call super::itemchanged;
//	Declarations.
listviewitem	ltvi_Selected

//	Get selected item.
if GetItem ( index, ltvi_Selected ) <> 1 then
	return
end if

//	Record selection.
in_cst_parm.of_SetItem ( "Job", index )

end event

type cb_cancel from w_open_job_dialogue`cb_cancel within w_new_task_dialogue
int X=2354
int Y=128
end type

type cb_ok from w_open_job_dialogue`cb_ok within w_new_task_dialogue
int X=2354
int Y=28
end type

type uo_schedule from u_cst_schedule within w_new_task_dialogue
int X=1358
int Y=364
int Width=1257
int Height=984
int TabOrder=60
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=78682240
end type

on uo_schedule.destroy
call u_cst_schedule::destroy
end on

event constructor;
//	Set default schedule.
post of_SetSchedule ( once, 1, datetime ( today ( ), now ( ) ), datetime ( today ( ), now ( ) ) )

end event

event ue_modified;
//	Record selection.
in_cst_parm.of_setitem ( "Interval", interval )
in_cst_parm.of_setitem ( "Mode", interval_type )
in_cst_parm.of_setitem ( "Begin", begindt )
in_cst_parm.of_setitem ( "End", enddt )

end event


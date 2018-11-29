$PBExportHeader$n_cst_dialogue.sru
forward
global type n_cst_dialogue from nonvisualobject
end type
end forward

global type n_cst_dialogue from nonvisualobject autoinstantiate
end type

type variables
Public:

constant integer	CANCELLED = 0
constant integer	VALID = 1
constant integer	PARMERROR = -1
constant integer	SUCCESS = 1

end variables

forward prototypes
public function integer of_getnewjobtype (string as_title, ref integer ai_type)
public function integer of_getnewjobtype (ref integer ai_type)
public function integer of_getjobopen (ref integer ai_type, ref string as_name, ref string as_description)
public function integer of_getjobopen (string as_title, ref integer ai_type, ref string as_name, ref string as_description)
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_rfilename, string as_extension, string as_filter)
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_rfilename, string as_extension)
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_rfilename)
public function integer of_getnewtaskproperties (string as_title, ref string as_name, ref string as_description, ref integer ai_job, ref integer ai_queue, ref integer ai_interval, ref integer ai_mode, ref datetime adt_begin, ref datetime adt_end)
public function integer of_getnewtaskproperties (ref string as_Name, ref string as_Description, ref integer ai_job, ref integer ai_queue, ref integer ai_interval, ref integer ai_type, ref datetime adt_begin, ref datetime adt_end)
public function integer of_EditTaskProperties (string as_title, ref string as_name, ref string as_description, ref integer ai_job, ref integer ai_queue, ref integer ai_interval, ref integer ai_mode, ref datetime adt_begin, ref datetime adt_end)
end prototypes

public function integer of_getnewjobtype (string as_title, ref integer ai_type);
//	This function opens the dialogue for new job types.

//	Declarations.
n_cst_powerobjectparm	ln_cst_NewJobParm

//	Initializations.
ln_cst_NewJobParm = create n_cst_powerobjectparm
ln_cst_NewJobParm.of_SetItem ( "Title", as_Title )

//	Open dialogue
OpenWithParm ( w_new_job_dialogue, ln_cst_NewJobParm )
ai_Type = IsNull ( ln_cst_NewJobParm.of_GetItem ( "Type" ), 0 )

//	Destructor.
destroy ln_cst_NewJobParm

//	Return results.
Return Message.DoubleParm

end function

public function integer of_getnewjobtype (ref integer ai_type);
//	This function opens the dialogue for new job types.

//	Declarations
string	ls_Null

//	Initializations
SetNull ( ls_Null )

Return of_GetNewJobType ( ls_Null, ai_Type )

end function

public function integer of_getjobopen (ref integer ai_type, ref string as_name, ref string as_description);
//	This function opens the dialogue for new job types.

//	Declarations
string	ls_Null

//	Initializations
SetNull ( ls_Null )

Return of_GetJobOpen ( ls_Null, ai_Type, as_Name, as_Description )

end function

public function integer of_getjobopen (string as_title, ref integer ai_type, ref string as_name, ref string as_description);
//	This function opens the dialogue for new job types.

//	Declarations.
n_cst_powerobjectparm	ln_cst_OpenJobParm

//	Initializations.
ln_cst_OpenJobParm = create n_cst_powerobjectparm
ln_cst_OpenJobParm.of_SetItem ( "Title", as_Title )

//	Open dialogue
OpenWithParm ( w_open_job_dialogue, ln_cst_OpenJobParm )
ai_Type = IsNull ( ln_cst_OpenJobParm.of_GetItem ( "Type" ), 0 )
as_Name = IsNull ( ln_cst_OpenJobParm.of_GetItem ( "Name" ), "" )
as_Description = IsNull ( ln_cst_OpenJobParm.of_GetItem ( "Description" ), "" )

//	Destructor.
destroy ln_cst_OpenJobParm

//	Return results.
Return Message.DoubleParm

end function

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_rfilename, string as_extension, string as_filter);
//	Declarations.
integer	li_ReturnValue

//	Open dialogue.
li_ReturnValue = GetFileSaveName ( as_Title, as_PathName, as_rFileName, as_Extension, as_Filter )

//	Reset root.
gnv_app.of_ResetRoot ( )

Return li_ReturnValue

end function

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_rfilename, string as_extension);
//	Call primary.
Return of_GetFileSaveName ( as_Title, as_PathName, as_rFileName, as_Extension, "" )
end function

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_rfilename);
//	Call primary.
Return of_GetFileSaveName ( as_Title, as_PathName, as_rFileName, "", "" )
end function

public function integer of_getnewtaskproperties (string as_title, ref string as_name, ref string as_description, ref integer ai_job, ref integer ai_queue, ref integer ai_interval, ref integer ai_mode, ref datetime adt_begin, ref datetime adt_end);
//	This function opens the dialogue for new tasks.

//	Declarations.
n_cst_powerobjectparm	ln_cst_NewTaskParm

//	Initializations.
ln_cst_NewTaskParm = create n_cst_powerobjectparm
ln_cst_NewTaskParm.of_SetItem ( "Title", as_Title )

//	Open dialogue
OpenWithParm ( w_new_task_dialogue, ln_cst_NewTaskParm )
as_Name = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Name" ), "" )
as_Description = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Description" ), "" )
ai_Job = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Job" ), 0 )
ai_Queue = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Type" ), 0 )
ai_Mode = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Mode" ), 0 )
ai_Interval = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Interval" ), 0 )
adt_Begin = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "Begin" ), DateTime ( 1899-01-01 ) )
adt_End = IsNull ( ln_cst_NewTaskParm.of_GetItem ( "End" ), DateTime ( 2299-01-01 ) )

//	Destructor.
destroy ln_cst_NewTaskParm

//	Return results.
Return Message.DoubleParm

end function

public function integer of_getnewtaskproperties (ref string as_Name, ref string as_Description, ref integer ai_job, ref integer ai_queue, ref integer ai_interval, ref integer ai_type, ref datetime adt_begin, ref datetime adt_end);
//	This function opens the dialogue for new job types.

//	Declarations
string	ls_Null

//	Initializations
SetNull ( ls_Null )

return of_GetNewTaskProperties ( ls_Null, as_Name, as_Description, ai_Job, ai_Queue, ai_Interval, ai_Type, adt_Begin, adt_End )

end function

public function integer of_EditTaskProperties (string as_title, ref string as_name, ref string as_description, ref integer ai_job, ref integer ai_queue, ref integer ai_interval, ref integer ai_mode, ref datetime adt_begin, ref datetime adt_end);
//	This function opens the dialogue for editing tasks.

//	Declarations.
n_cst_powerobjectparm	ln_cst_TaskParm

//	Initializations.
ln_cst_TaskParm = create n_cst_powerobjectparm
ln_cst_TaskParm.of_SetItem ( "Title", as_Title )

//	Open dialogue
OpenWithParm ( w_new_task_dialogue, ln_cst_TaskParm )
as_Name = IsNull ( ln_cst_TaskParm.of_GetItem ( "Name" ), "" )
as_Description = IsNull ( ln_cst_TaskParm.of_GetItem ( "Description" ), "" )
ai_Job = IsNull ( ln_cst_TaskParm.of_GetItem ( "Job" ), 0 )
ai_Queue = IsNull ( ln_cst_TaskParm.of_GetItem ( "Type" ), 0 )
ai_Mode = IsNull ( ln_cst_TaskParm.of_GetItem ( "Mode" ), 0 )
ai_Interval = IsNull ( ln_cst_TaskParm.of_GetItem ( "Interval" ), 0 )
adt_Begin = IsNull ( ln_cst_TaskParm.of_GetItem ( "Begin" ), DateTime ( 1899-01-01 ) )
adt_End = IsNull ( ln_cst_TaskParm.of_GetItem ( "End" ), DateTime ( 2299-01-01 ) )

//	Destructor.
destroy ln_cst_TaskParm

//	Return results.
Return Message.DoubleParm

end function

on n_cst_dialogue.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dialogue.destroy
TriggerEvent( this, "destructor" )
end on


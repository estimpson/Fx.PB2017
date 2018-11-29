$PBExportHeader$u_dwplanningboard.sru
forward
global type u_dwplanningboard from u_dwpbbase
end type
end forward

global type u_dwplanningboard from u_dwpbbase
int Width=3474
int Height=1668
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
boolean LiveScroll=false
end type
global u_dwplanningboard u_dwplanningboard

type variables
Public:

datastore		ids_Tasks
datastore		ids_Shifts

Private:

long		il_FirstRowOnPage=1
long		il_LastRowOnPage
long		il_SelectedRow
long		il_Id

string		is_Id
string		is_ShowPart='N'
string		is_group=''
end variables

forward prototypes
public function integer of_refresh ()
public function integer of_display ()
public function integer of_addresource (long al_row, string as_name)
public function integer of_displaypopup (string as_id, long al_row, string as_type)
public function integer of_popupmessage (string mesage)
public function integer of_createtask ()
public function integer of_destroyshift ()
public function integer of_createshift ()
public function integer of_editshift ()
public function integer of_destroytask ()
public function integer of_edittask ()
public function integer of_destroytaskqueue ()
public function integer of_destroyschedule ()
public function integer of_destroyschedules ()
public function integer of_destroytaskqueues ()
public subroutine of_retrievetasksshifts ()
public function integer of_refreshresource (long al_row, boolean ab_display)
public function integer of_recalctaskruntimes (boolean ab_recalcall)
public function integer of_recalcalldisplay ()
public function integer of_reassignmps ()
public function integer of_setupdisplay (string as_showpart)
end prototypes

public function integer of_refresh ();// ******************************************************************************************
//
// Purpose	: Destroy the old objects, reset the dw & retrieve it again
//
// Parameters	: None
//
// Created 	: 11/8/99/ Development Team
//
// ******************************************************************************************

// 	Declarations
n_cst_resource	ln_cst_EmptyResourceList [ ]
long		ll_CurrentRow
string		ls_time


//	Calculate current DateTime of Today.
if is_intervaltype = 'Hour' then 
	ls_time = trim(string(hour(now())))+':00:00'	
	idt_RetrieveBegin = datetime ( Today ( ), time(ls_time) )
else
	idt_RetrieveBegin = datetime ( Today ( ) )
end if 	

//	Set interval.
//ii_Interval = 1

//	Loop through and destory Resource List objects.
for ll_CurrentRow = il_firstrowonpage to il_lastrowonpage
	in_cst_ResourceList [ ll_CurrentRow ].of_Display ( false, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart )
	destroy in_cst_ResourceList [ ll_CurrentRow ]
next

//	Initialize Resource List.
in_cst_ResourceList = ln_cst_EmptyResourceList

//	Reset the datawindow.
Reset ( )

//	Retrieve Resource List.
if isnull(is_group,'All') <> 'All' then 
	Retrieve ( idt_RetrieveBegin, is_intervaltype, ii_Interval, is_group )
else	
	Retrieve ( idt_RetrieveBegin, is_intervaltype, ii_Interval )	
end if 	
//	Return.
Return 1
end function

public function integer of_display ();// ******************************************************************************************
// 
// Purpose	: To display the resource, it's tasks & shifts for the current set on the 
//		  screen
// 
// Parameters	: None
//
// Created	: 11/8/99 Development Team
//
// ******************************************************************************************

// Declarations
long	ll_CurrentFirstRow
long	ll_CurrentLastRow
long	ll_CurrentRow

// Initilization
ll_CurrentFirstRow = Long ( Object.DataWindow.FirstRowOnPage ) 
ll_CurrentLastRow = Long ( Object.DataWindow.LastRowOnPage ) 

SetRedraw ( False)

// Destroy the Tasks & Shifts which were created prior to the current first row
for ll_CurrentRow = il_FirstRowOnPage to ll_CurrentFirstRow - 1

	in_cst_ResourceList [ ll_CurrentRow ].of_Display ( false, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart )

next 	

// Destroy the Tasks & Shifts which were created after the current first row
for ll_CurrentRow = ll_CurrentLastRow + 1 to il_LastRowOnPage

	in_cst_ResourceList [ ll_CurrentRow ].of_Display ( false, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart )

next 	

// re-display the machine, tasks & shifts
if ll_CurrentFirstRow > il_LastRowOnPage or ll_CurrentLastRow < il_FirstRowOnPage then
	for ll_CurrentRow = ll_CurrentFirstRow to ll_CurrentLastRow
	
		in_cst_resourcelist [ ll_CurrentRow ].of_Display ( True, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart ) 
	
	next
else	
	for ll_CurrentRow = ll_CurrentFirstRow to il_FirstRowOnPage - 1
	
		in_cst_resourcelist [ ll_CurrentRow ].of_Display ( True, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart ) 
	
	next

	for ll_CurrentRow = il_LastRowOnPage + 1 to ll_CurrentLastRow
	
		in_cst_resourcelist [ ll_CurrentRow ].of_Display ( True, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart ) 
	
	next
end if

SetRedraw ( True )

// Assign the current values to the instance variables
il_FirstRowOnPage = ll_CurrentFirstRow 
il_LastRowOnPage = ll_CurrentLastRow 

// Return value
Return 1

end function

public function integer of_addresource (long al_row, string as_name);// ******************************************************************************************
//
// Purpose	: To add the resource to resource list
// 
// Parameters	:
//		al_Row	- Current Resource Row no
//		as_Name	- Current Resource Name
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

// 	Check value
if isnull ( al_Row, -1 ) <= 0 or isnull ( as_Name )  or as_Name = '' then return -1

// 	Assign values into resource list
in_cst_resourcelist [ al_Row ] = create n_cst_resource

// 	Return value 
return in_cst_resourcelist [ al_Row ].of_Create ( al_Row, as_Name, is_ShowPart )
end function

public function integer of_displaypopup (string as_id, long al_row, string as_type);// ******************************************************************************************
//
// Purpose	: To call the appropriate popup menu options
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Declarations
m_pbmenu lm_PBMenu

//	Initilization/creation
lm_PBMenu = CREATE m_pbmenu

//	Display appropriate menu based on the parameter
Choose Case as_type
	case "r" // resource
		lm_PBMenu.m_resource.PopMenu(PointerX(), PointerY() + 275)
	case "s" // shifts
		lm_PBMenu.m_shift.PopMenu(PointerX(), PointerY() + 275)
	case "t" // tasks
		lm_PBMenu.m_task.PopMenu(PointerX(), PointerY() + 275)
end choose

//	Return value
Return 1
end function

public function integer of_popupmessage (string mesage);// ******************************************************************************************
//
// Purpose	: To call the appropriate function based on the popup menu message
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Call the appropriate functions based on the message return from the popupmenu 
choose case mesage
	case 'createtask'
		of_CreateTask ( ) 	
	case 'destroytask'
		of_DestroyTask ( ) 
	case 'edittask'		
		of_EditTask ( ) 		
	case 'createshift'
		of_CreateShift ( ) 			
	case 'destroyshift'
		of_DestroyShift ( ) 		
	case 'editshift'		
		of_EditShift ( ) 		
	case 'destroytasks'
		of_DestroyTaskQueue ( ) 		
	case 'destroyshifts'		
		of_DestroySchedule ( ) 	
	case 'calcruntimes'
		of_recalctaskruntimes ( False )
	case 'calcall'
		of_recalctaskruntimes ( True )
	case 'destroyallshifts'
		of_DestroySchedules ( ) 	
	case 'destroyalltasks'
		of_DestroyTaskQueues ( ) 	
end choose

// 	return value 
return 1
end function

public function integer of_createtask ();// ******************************************************************************************
//
// Purpose	: To all the user to create new tasks (only manual work order ) 
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Call w_manual_create_wo
Open ( w_manual_wo_create )

//	Re-calc begin & ends for that resource
of_ReCalcTaskRuntimes ( False ) 

// Re-retrieve tasks & shifts
//of_RetrieveTasksShifts ( ) 

//	Check Value
//if isnull ( il_SelectedRow , 0 ) <= 0  then return -1 

//	refresh resource
//of_RefreshResource ( il_SelectedRow, True ) 
	
//	Return value
Return 1
end function

public function integer of_destroyshift ();// ******************************************************************************************
//
// Purpose	: To destroy a shift for the current resource
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Check Value
if isnull ( il_SelectedRow , 0 ) = 0  then return -1 

//	Declarations
Long	ll_Id
int	li_Choice

li_Choice = Messagebox ( 'System Message','Are you sure you want to delete this Shift ?', Question!, YesNo!,2)

if li_Choice = 1 then 

	ll_Id	= Long ( is_Id )
	
	//	Shift Deletion
	delete 
	from	Shop_Floor_Calendar
	where	ai_Id = :ll_Id ;
			
	//	check success
	if sqlca.sqlcode = -1 then
		rollback ;
		return -1		
	else	
		commit ;	
	end if 	
	//	Re-calc Task Runtimes
	of_ReCalcTaskRuntimes ( False ) 
	
	// 	Re-retrieve tasks & shifts
//	of_RetrieveTasksShifts ( ) 
	
	//	retrieve the tasks & shifts for that resource
//	of_RefreshResource ( il_SelectedRow, True ) 

end if 

//	return value
return 1
end function

public function integer of_createshift ();// ******************************************************************************************
//
// Purpose	: To all the user to create new shifts
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Open create new shift wizard window
open ( w_create_new_shift_wizard ) 

// Re-retrieve tasks & shifts
of_RetrieveTasksShifts ( ) 

//	Check Value
if isnull ( il_SelectedRow , 0 ) <= 0  then return -1 

// 	refresh resource 
of_RefreshResource ( il_selectedrow, True ) 

// 	return value
return 1
end function

public function integer of_editshift ();// ******************************************************************************************
//
// Purpose	: To allow the user to edit new shifts
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Check Value
if isnull ( il_SelectedRow , 0 ) = 0  then return -1 

//	Declarations
string	ls_machine
datetime	ldt_bdatetime

str_ShiftParm1	lstr_ShiftParm

// 	Initilization
ls_machine = in_cst_resourcelist [ il_SelectedRow ].is_name

select	begin_datetime,
	machine
into	:ldt_bdatetime,
	:ls_machine
from	shop_floor_Calendar 
where 	ai_id = :il_id;

// 	Assign values to the structure
lstr_ShiftParm.s_machine = ls_machine
lstr_ShiftParm.dt_begindatetime = ldt_bdatetime

//	Open create new shift wizard window
openwithparm ( w_create_new_shift_wizard, lstr_ShiftParm ) 

//	Recalc runtimes
of_RecalcTaskRunTimes ( False ) 

// 	Retrieve all tasks & shifts
//of_RetrieveTasksShifts ( ) 

// 	refresh resource 
//of_RefreshResource ( il_selectedrow, True ) 

// 	return value

return 1
end function

public function integer of_destroytask ();// ******************************************************************************************
//
// Purpose	: To delete a task on resource
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Check Value
if isnull ( il_SelectedRow , 0 ) = 0  or isnull( is_id, '' ) = '' then return -1 

//	Declarations
decimal	ld_QtyCompleted
string	ls_TaskId
int	li_Choice

li_Choice = Messagebox ( 'System Message','Are you sure you want to delete this Task ?', Question!, YesNo!,2)

if li_Choice = 1 then 
	//	Initialize
	ls_TaskId =  is_id // string ( al_TaskId ) 
	
	//	Get data from the table for that TaskId
	select	sum ( Qty_Completed ) 
	into	:ld_QtyCompleted
	from 	workorder_detail 
	where	workorder = :ls_TaskId ;
	
	// 	Verify data, take appropriate action
	if ld_QtyCompleted = 0 then
	
	//	detail deletion
		delete 
		from	workorder_detail 
		where	workorder = :ls_TaskId ;
		
	//	check success
		if sqlca.sqlcode = -1 then
			rollback ;
			return -1		
		else	
		//	detail deletion
			delete 
			from	work_order
			where	work_order = :ls_TaskId ;
			if sqlca.sqlcode = -1 then
				rollback ;
				return -1
			else	
				commit ;	

				//	update mps committed quantity
				of_reassignmps ( )
				
			end if 	
		end if 	
		
	//	Re-calc the begins & ends ( through the procedure for that resource ) 
		of_RecalcTaskRunTimes ( False ) 
		
	//	Re-retrieve tasks & shifts
//		of_RetrieveTasksShifts ( ) 
		
	//	retrieve the tasks & shifts for that resource
//		of_RefreshResource ( il_SelectedRow, True ) 
	else
		Messagebox ( "System Message","Unable to delete Task as work in progress or partially completed")
	end if 	
end if

//	return value
return 1
end function

public function integer of_edittask ();// ******************************************************************************************
//
// Purpose	: To allow the user to edit the selected task tasks
// 
// Parameters	: None
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Check Value
if isnull ( is_Id, '' ) = '' or isnull ( il_SelectedRow , 0 ) = 0  then return -1 

//	Call w_manual_create_wo
OpenwithParm ( w_job_properties, is_Id )

//	Re-calc begin & ends for that resource
of_ReCalcTaskRuntimes ( False ) 

// 	Retrieve all tasks & Shifts
//of_RetrieveTasksShifts ( ) 

//	refresh resource
//of_RefreshResource ( il_SelectedRow, True ) 
	
//	Return value

return 1
end function

public function integer of_destroytaskqueue ();// ******************************************************************************************
//
// Purpose	: To destroy all the tasks for the current resource
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Check Value
if isnull ( il_SelectedRow , 0 ) = 0  then return -1 

//	Declarations
decimal	ld_QtyCompleted

int	li_Choice

long	ll_Tasks
long	ll_CurrentTask
long	ll_TaskId
long	ll_Row
long	ll_TaskSeq

string	ls_TaskId

li_Choice = Messagebox ( 'System Message','Are you sure you want to delete all Tasks on this resource ?', Question!, YesNo!,2)

if li_Choice = 1 then 

	//	Initialization
	ll_Tasks	= Upperbound ( in_cst_resourcelist [ il_selectedrow ].in_cst_TaskQueue ) 
	
	//	Delete all un-processed tasks for the resource
	for ll_CurrentTask = 1 to ll_Tasks
			
		IF isvalid ( in_cst_resourcelist [ il_selectedrow ].in_cst_TaskQueue [ ll_CurrentTask ] ) then 
			
			//	Get the task id of each task 
			of_ExtractIdRow (in_cst_resourcelist [ il_selectedrow ].in_cst_TaskQueue [ ll_CurrentTask ].is_DWObjectName , ll_TaskId, ll_Row, ll_TaskSeq )
			
			ls_TaskId = String ( ll_TaskId)
			
			//	Get data from the table for that TaskId
			select	sum ( Qty_Completed ) 
			into	:ld_QtyCompleted
			from 	workorder_detail 
			where	workorder = :ls_TaskId ;
		
			// 	Verify data, take appropriate action
			if ld_QtyCompleted = 0 then
			
			//	detail deletion
				delete 
				from	workorder_detail 
				where	workorder = :ls_TaskId ;
				
			//	check success
				if sqlca.sqlcode = -1 then
					rollback ;
					return -1		
				else	
				//	detail deletion
					delete 
					from	work_order
					where	work_order = :ls_TaskId ;
					if sqlca.sqlcode = -1 then
						rollback ;
						return -1
					else	
						commit ;	
						//	update mps committed quantity
						of_reassignmps ( )
					end if 	
				end if 
		//	else
		//		Messagebox ( "System Message","Unable to delete Task as work in progress or partially completed")
			end if 	
		end if 	
	next 
	//	Recalc Task RunTimes
	of_ReCalcTaskRuntimes ( False ) 
	
	// Re-retrieve tasks & shifts
//	of_RetrieveTasksShifts ( ) 
	
	//	retrieve the tasks & shifts for that resource
//	of_RefreshResource ( il_SelectedRow, True ) 

end if

//	return value
return 1
end function

public function integer of_destroyschedule ();// ******************************************************************************************
//
// Purpose	: To destroy all the shifts for the current resource
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Check Value
if isnull ( il_SelectedRow , 0 ) = 0  then return -1 

//	Declarations
int	li_Choice

li_Choice = Messagebox ( 'System Message','Are you sure you want to delete all Shifts on this resource ?', Question!, YesNo!,2)

if li_Choice = 1 then 
	
	//	Declarations
	string	ls_ResourceName
	
	//	Initialization
	ls_ResourceName	= in_cst_resourcelist [ il_selectedrow ].is_Name
	
	//	Shift Deletion
	delete 
	from	Shop_Floor_Calendar
	where	machine = :ls_ResourceName ;
			
	//	check success
	if sqlca.sqlcode = -1 then
		rollback ;
		return -1		
	else	
		commit ;	
	end if 	
	//	Recalc Task Runtimes
	of_ReCalcTaskRunTimes ( False ) 
	
	// 	Re-retrieve tasks & shifts
//	of_RetrieveTasksShifts ( ) 
	
	//	retrieve the tasks & shifts for that resource
//	of_RefreshResource ( il_SelectedRow, True ) 
end if

//	return value
return 1

end function

public function integer of_destroyschedules ();// ******************************************************************************************
//
// Purpose	: To destroy all the shifts for all the resource
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Declarations
int	li_Choice

li_Choice = Messagebox ( 'System Message','Do you wish to Delete all the Shifts on all the Resources ?', Question!, YesNo!,2)

if li_Choice = 1 then 
	
	//	Shift Deletion
	delete 
	from	Shop_Floor_Calendar;
		
	//	check success
	if sqlca.sqlcode = -1 then
		rollback ;
		return -1		
	else	
		commit ;	
	end if 	
	
	il_SelectedRow = 0 
	
	//	Recalc Task Runtimes
	of_ReCalcTaskRuntimes ( False ) 
	
	//	Refresh all the tasks & Schedules
//	of_RetrieveTasksShifts ( ) 
end if 

//	return value
return 1
end function

public function integer of_destroytaskqueues ();// ******************************************************************************************
//
// Purpose	: To destroy all the tasks for all the resources
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Declarations
decimal	ld_QtyCompleted

long	ll_Tasks
long	ll_CurrentTask
long	ll_TaskId
long	ll_Row
long	ll_Resources
long	ll_CurrentResource
long	ll_TaskSeq

string	ls_TaskId
int	li_Choice

li_Choice = Messagebox ( 'System Message','Do you wish to Delete all the Tasks on all the Resources ?', Question!, YesNo!,2)

if li_Choice = 1 then 

	//	Initialization
	ll_Resources	= Upperbound ( in_cst_resourcelist ) 
	
	//	Process all the resources
	for ll_CurrentResource = 1 to ll_Resources
	
	//	Get the total tasks
		ll_Tasks	= Upperbound ( in_cst_resourcelist [ ll_CurrentResource ].in_cst_TaskQueue ) 
		
		//	Delete all un-processed tasks for the resource
		for ll_CurrentTask = 1 to ll_Tasks
		
			IF isvalid ( in_cst_resourcelist [ ll_CurrentResource ].in_cst_TaskQueue [ ll_CurrentTask ] ) then 
			//	Get the task id of each task 
				of_ExtractIdRow (in_cst_resourcelist [ ll_CurrentResource ].in_cst_TaskQueue [ ll_CurrentTask ].is_DWObjectName , ll_TaskId, ll_Row, ll_TaskSeq )
				
				ls_TaskId = String ( ll_TaskId)
				
				//	Get data from the table for that TaskId
				select	sum ( Qty_Completed ) 
				into	:ld_QtyCompleted
				from 	workorder_detail 
				where	workorder = :ls_TaskId ;
			
				// 	Verify data, take appropriate action
				if ld_QtyCompleted = 0 then
				
				//	detail deletion
					delete 
					from	workorder_detail 
					where	workorder = :ls_TaskId ;
					
				//	check success
					if sqlca.sqlcode = -1 then
						rollback ;
						return -1		
					else	
					//	detail deletion
						delete 
						from	work_order
						where	work_order = :ls_TaskId ;
						if sqlca.sqlcode = -1 then
							rollback ;
							return -1
						else	
							commit ;
							//	update mps committed quantity
							of_reassignmps ( )
						end if 	
					end if 	
				end if 	
			end if 	
		next 
	next
	
	il_SelectedRow = 0 
	
	//	Retrieve all the tasks & Shifts for all the resources
	of_RetrieveTasksShifts ( ) 
end if 

//	return value
return 1
end function

public subroutine of_retrievetasksshifts ();// ******************************************************************************************
// 
// Purpose	: To retrieve all the Tasks & Shifts for all the resources 
// 
// Parameters	: None
//
// Created	: 11/8/99 Development Team
//
// ******************************************************************************************

// Create a datastore to retrieve all the Shifts

if isvalid ( ids_Shifts ) then destroy ids_Shifts
ids_Shifts = create DataStore
ids_Shifts.DataObject = "d_resource_shift_list"
ids_Shifts.SetTransObject ( SQLCA )
ids_Shifts.Retrieve ( )

// Create a datastore to retrieve all the Tasks

if isvalid ( ids_Tasks ) then destroy ids_Tasks
ids_Tasks = create DataStore
ids_Tasks.DataObject = "d_resource_task_list"
ids_Tasks.SetTransObject ( SQLCA )
ids_Tasks.Retrieve ( )



end subroutine

public function integer of_refreshresource (long al_row, boolean ab_display);// ******************************************************************************************
//
// Purpose	: To destroy & create objects on the datawindow & display the same
// 
// Parameters	: al_Row	current resource row  
//
// Created	: Development Team	11/8/99
//
// ******************************************************************************************

//	Declarations
string	ls_name

if isnull ( al_row , -1 ) = -1 then return -1

ls_name = in_cst_ResourceList [ al_Row ].is_Name

// 	destroy all the tasks & shifts for the current resource
in_cst_ResourceList [ al_row ].of_Display ( false, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart )
destroy in_cst_ResourceList [ al_Row ]

in_cst_ResourceList [ al_Row ] = create n_cst_resource
in_cst_ResourceList [ al_Row ].is_name = ls_Name
in_cst_ResourceList [ al_Row ].il_RowId = al_Row

// 	create all the tasks & shifts for the current resource
if ab_Display then 
	in_cst_ResourceList [ al_row ].of_Display ( true, idt_RetrieveBegin, is_intervaltype, this, is_ShowPart )
end if 	

//	return value
return 1
end function

public function integer of_recalctaskruntimes (boolean ab_recalcall);// ******************************************************************************************
// 
// Purpose	: To re-calculate the runtimes for the resources on the current page
// 
// Parameters	: None
//
// Created	: 11/8/99 Development Team
//
// ******************************************************************************************

//	Declarations
long	ll_CurrentRow
string	ls_ResourceName
datastore lds_Recalc

//	Creation & Initilization
lds_Recalc = create DataStore
sqlca.autocommit = true

if NOT ab_RecalcAll then 
//	Check Current selected row 
	if isnull ( il_SelectedRow,0) = 0 then return -1

	ls_ResourceName = in_cst_ResourceList [ il_SelectedRow ].is_Name
	
//	Re-calc the runtimes for the current set of resources on the page
	lds_Recalc.DataObject = "d_msp_recalc_tasks"
	lds_Recalc.SetTransObject ( SQLCA )
	lds_Recalc.Retrieve ( ls_ResourceName )

else

//	Re-calc the runtimes for the current set of resources on the page
	lds_Recalc.DataObject = "d_msp_recalc_tasksall"
	lds_Recalc.SetTransObject ( SQLCA )
	lds_Recalc.Retrieve ( )

end if 

sqlca.autocommit = false

destroy lds_Recalc

//	Retrieve all the tasks & Shifts
post of_RetrieveTasksShifts ( ) 

if ab_RecalcAll then 
	//	Refresh Tasks & Shifts
	of_RecalcallDisplay ( ) 
else

//	Refresh Resource
	post of_RefreshResource ( il_SelectedRow, True ) 
	
end if 

//	Return value
return 1
end function

public function integer of_recalcalldisplay ();// 	Declarations
long		ll_CurrentRow
string	ls_time

//	Calculate current DateTime of Today.
//idt_RetrieveBegin = datetime ( Today ( ) )
if is_intervaltype = 'Hour' then 
	ls_time = trim(string(hour(now())))+':00:00'	
	idt_RetrieveBegin = datetime ( Today ( ), time(ls_time) )
else
	idt_RetrieveBegin = datetime ( Today ( ) )
end if 	

//	Set interval.
//ii_Interval = 1

//	Loop through and destory Resource List objects.
for ll_CurrentRow = il_firstrowonpage to il_lastrowonpage
	of_RefreshResource ( ll_CurrentRow, True ) 
//	in_cst_ResourceList [ ll_CurrentRow ].of_Display ( false, idt_RetrieveBegin, is_intervaltype, this )
next
/*
//	Loop through and create Resource List objects.
for ll_CurrentRow = il_firstrowonpage to il_lastrowonpage
	in_cst_ResourceList [ ll_CurrentRow ].of_Display ( true, idt_RetrieveBegin, is_intervaltype, this )
next
*/
//	Return value
return 1
end function

public function integer of_reassignmps ();//	Declarations
datastore  lds_updatemps

lds_updatemps = create datastore
		
lds_updatemps.dataobject = 'd_msp_super_cop'
lds_updatemps.settransobject ( sqlca )
lds_updatemps.retrieve (  )
destroy lds_updatemps
return 1
end function

public function integer of_setupdisplay (string as_showpart);// ******************************************************************************************
//
// Purpose	: To allow the user to either display work order no or part on the task
// 
// Parameters	: Y/N
//
// Created	: GPH	03/14/01
//
// ******************************************************************************************

is_ShowPart = as_ShowPart

//	Re-calc begin & ends for that resource
of_ReCalcalldisplay ( ) 
	
//	Return value

return 1
end function

event retrieveend;// ******************************************************************************************
//
// Purpose : To add the resource to resource list after the data has been retrieved
// 
// Arguments :	None
//
// Created :	Development Team	11/8/99
//
// ******************************************************************************************

// Declarations
long	ll_CurrentRow

// Check value
if rowcount = 0 then return -1

// Process all the resources 
for ll_CurrentRow = 1 to rowcount
	of_AddResource ( ll_CurrentRow, u_dwplanningboard.object.Resource_Name [ ll_CurrentRow ] )
next 

// Retrieve all the tasks & shifts at one time 
//of_RetrieveTasksShifts ( )

of_RecalcTaskRuntimes ( True ) 

// Display for the 1st Time
post of_Display ( ) 
end event

event constructor;// ******************************************************************************************
//
// Purpose	: Assign the dataobject to the dw & retrieve data for the same
//
// Arguments	: None
//
// Created 	: 11/8/99 Development Team 
//
// ******************************************************************************************

//is_IntervalType = Message.StringParm

n_cst_associative_array	lncst_aalist
lncst_aalist = Message.PowerObjectParm
is_Intervaltype = lncst_aalist.of_getItem ( "intervaltype" )
ii_interval = lncst_aalist.of_getItem ( "interval" )
is_group = lncst_aalist.of_getItem ( "group" )

if isnull(is_group,'All') <> 'All' then 
	dataobject = 'd_pb_resource_list_filter'
else
	dataobject = 'd_pb_resource_list'
end if 	
SetTransObject ( SQLCA )
of_Refresh ( ) 

end event

event scrollvertical;// ******************************************************************************************
//
// Purpose	:	To display the tasks & shifts on the screen
// 
// Arguments	:	None
//
// Created	:	Development Team	11/8/99
//
// ******************************************************************************************

// Call of_Display function to re-display the resources, it's tasks & shifts
post of_Display ( )
end event

event ue_resourcerclick;// ******************************************************************************************
//
// Purpose	:	To display the popup menu for the resource
// 
// Arguments	:	None
//
// Created	:	Development Team	11/8/99
//
// ******************************************************************************************

// Assign value to the instance variable with the current resource selected
is_Id = ResourceId 
il_SelectedRow = row

// Call the respective popup menu
of_DisplayPopup ( is_Id, Row, 'r' )

end event

event ue_shiftrclick;// ******************************************************************************************
//
// Purpose	:	To display the popup menu for the Shift
// 
// Arguments	:	None
//
// Created	:	Development Team	11/8/99
//
// ******************************************************************************************

// Assign value to the instance variable with the current resource selected
il_Id = ShiftId
is_Id = String ( ShiftId )
il_SelectedRow = row

// Call the respective popup menu
of_DisplayPopup ( is_Id , Row, 's' )

end event

event ue_taskrclick;// ******************************************************************************************
//
// Purpose	:	To display the popup menu for the Task
// 
// Arguments	:	None
//
// Created	:	Development Team	11/8/99
//
// ******************************************************************************************

// Assign value to the instance variable with the current resource selected
il_Id = TaskId
is_Id = String ( TaskId )
il_SelectedRow = row

// Call the respective popup menu
of_DisplayPopup ( is_Id , Row, 't' )

end event

event ue_movetask;// ******************************************************************************************
//
// Purpose	: To assign the new sequence on the tasks
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Declarations.
integer	li_Option

long	ll_MaxSeq
long	ll_CurrentSeq
long	ll_Seq
long	ll_SeqTemp

string	ls_FromResource
string 	ls_ToResource
string	ls_Part

// 	Check Resource Rows
if 	isnull(Fromresource,0) = 0 and isnull(Toresource,0) = 0 then Return 

//	Initialization
il_id		= id
is_id		= string ( id )
il_SelectedRow	= ToResource
ll_CurrentSeq	= currentsequence
ls_FromResource = object.Resource_name [ fromresource ] 
ls_ToResource	= object.Resource_name [ Toresource ] 

if ls_FromResource <> ls_ToResource then 
	select min(part)
	into	:ls_part
	from	workorder_detail
	where workorder = :is_id ;
	
	select sequence
	into	:ll_SeqTemp
	from	part_machine
	where	part = :ls_part and
			machine = :ls_ToResource ;

	if ll_SeqTemp > 1 then		
		li_option = Messagebox ('System Message','Machine '+ls_ToResource+' is a Secondary Machine, Do you wish to continue ',Exclamation!, YesNo!, 2 )
	elseif ll_SeqTemp <= 0 then
		li_option = Messagebox ('System Message','Machine '+ls_ToResource+' is not part of the flow router Do you wish to continue ',Exclamation!, YesNo!, 2 )		
	end if 
	
	if li_option = 2 then return 	
	
end if 	

// increment all the new sequence nos. for all the seq greater than newsequence
update	work_order
set	sequence = sequence + 1
where	machine_no = :ls_ToResource and
	sequence >= :NewSequence  ;

if sqlca.sqlcode = -1 then
	rollback ;
	return
end if 	

// assign the new sequence & new machine to the current sequence & old machine
update	work_order
set	machine_no = :ls_ToResource,
	sequence = :NewSequence
where	machine_no = :ls_FromResource and
	sequence = :ll_CurrentSeq  ;

//	verify update status	
if sqlca.sqlcode = -1 then
	rollback ;
	return
else
	commit ;
end if

//	recalc the to resource
il_SelectedRow = ToResource
of_ReCalcTaskRuntimes ( False ) 

//	recalc the from resource
il_SelectedRow = FromResource
of_ReCalcTaskRuntimes ( False ) 



end event

event ue_resequencetask;// ******************************************************************************************
//
// Purpose	: To assign the new sequence on the tasks
// 
// Parameters	: None
//
// Created	: Development Team	11/11/99
//
// ******************************************************************************************

//	Declarations.
long	ll_MaxSeq
long	ll_CurrentSeq
string	ls_Resource

// 	Check Resource Row 
if 	isnull(Resource,0) = 0 then Return

//	Initialization
il_Id		= id
is_Id		= String ( Id ) 
il_SelectedRow	= Resource
ll_CurrentSeq	= currentsequence
ls_Resource	= object.Resource_name [ Resource ]

// if the move is within a range of 1 in the forward direction no action, then return
if newsequence - 1 = currentsequence then return 

// increment all the new sequence nos. for all the seq greater than newsequence
update	work_order
set	sequence = sequence + 1
where	machine_no = :ls_Resource and
	sequence >= :NewSequence ;

if sqlca.sqlcode = -1 then
	rollback ;
	return
end if 	

// assign the new sequence to the current sequence
update	work_order
set	sequence = :NewSequence
where	machine_no = :ls_Resource and
	work_order = :is_id  ;

//	verify update status	
if sqlca.sqlcode = -1 then
	rollback ;
	return
else
	commit ;
end if

// 	Recalculate runtimes
il_SelectedRow = Resource
of_RecalcTaskRuntimes ( False ) 


end event

event ue_dragitemwithin;long	ll_newrow
if ypos > 465 then
	ll_newrow = row + 1
	if ll_newrow <= rowcount() then 
		scrolltorow ( ll_newrow ) 	
	end if 
/*	
elseif ypos < 22 then 
	ll_newrow = row - 1
	if ll_newrow > 0  then 
		scrolltorow ( ll_newrow ) 	
	end if 
	*/
end if    
end event


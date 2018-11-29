$PBExportHeader$n_cst_resource.sru
forward
global type n_cst_resource from nonvisualobject
end type
end forward

global type n_cst_resource from nonvisualobject
end type
global n_cst_resource n_cst_resource

type variables
Public:

boolean		ib_FirstTime=True

long		il_RowId
string		is_Name
string		is_DWObjectCreate [ ]
string		is_DWObjectDestroy [ ]

n_cst_task	in_cst_TaskQueue [ ]
n_cst_shift	in_cst_Schedule [ ]

Private:
string		is_ShowPart
end variables

forward prototypes
public function integer of_addshift (string as_intervaltype, long al_index, long al_id, datetime adt_begin, real ar_interval, string as_name)
public function integer of_addtask (datetime adt_retrievebegin, string as_intervaltype, long al_index, long al_id, datetime adt_begin, real ar_tasklength, string as_part, boolean ab_shortage, boolean ab_late, long al_taskseq)
public function integer of_create (long al_rowid, string as_name, string as_showpart)
public function integer of_display (boolean ab_mode, datetime adt_retrievebegin, string as_intervaltype, datawindow adw_planningboard, string as_ShowPart)
end prototypes

public function integer of_addshift (string as_intervaltype, long al_index, long al_id, datetime adt_begin, real ar_interval, string as_name);// ******************************************************************************************
// Purpose	: Add the shift to the shift schedule.
//
// Parameters	:
//	as_IntervalType - IntervalType (ie Minute/Hour/Days etc ).
//	al_Index	- Index of Shift in Schedule.
//	al_Id		- Shift id.
//	adt_Begin	- Shift start.
//	ar_Interval	- Shift length in seconds.
//	as_Name		- Shift name.
//	
//	Created:	11/4/99	Development Team
//
// ******************************************************************************************

//	Declarations.
long	ll_NextDWObject

//	I.	Check for invalid values.
if IsNull ( al_Id, -1 ) < 0 or IsNull ( adt_Begin ) or IsNull ( ar_Interval, -1 ) <= 0 or IsNull ( as_Name ) then
	return -1
end if

//	II.	Create shift.

//		A.	Create the shift.
in_cst_Schedule [ al_Index ] = create n_cst_shift

//		B.	Call the create function for the shift to generate the shift DW Object Syntax.
if in_cst_Schedule [ al_Index ].of_Create ( as_IntervalType, il_RowId, al_Id, adt_Begin, ar_Interval, as_Name ) = -1 then

//		C.	If creation failed, return error.
	return -1
end if

//	III.	Add shift DWObject create and drop syntax to DW Object Stacks.

//		A.	Get the index of the next DW Object.
ll_NextDWObject = UpperBound ( is_DWObjectCreate ) + 1

//		B.	Add the create and drop syntaxes.
is_DWObjectCreate [ ll_NextDWObject ] = "create " + in_cst_Schedule [ al_Index ].is_DWObjectSyntax
is_DWObjectDestroy [ ll_NextDWObject ] = "destroy " + in_cst_Schedule [ al_Index ].is_DWObjectName

//	IV.	Return.
return 1

end function

public function integer of_addtask (datetime adt_retrievebegin, string as_intervaltype, long al_index, long al_id, datetime adt_begin, real ar_tasklength, string as_part, boolean ab_shortage, boolean ab_late, long al_taskseq);// *****************************************************************************************
// Purpose : Create the Task queue & the syntax for creating the dwobject 
//
// Arguments : 
//	adt_RetrieveBegin	- The DateTime retrieved.
//	as_IntervalType - IntervalType (ie Minute/Hour/Days etc ).
//	al_Index	- Index of Shift in Schedule.
//	as_Id		- Task id.
//	adt_Begin	- Task start.
//	ar_TaskLength	- Task length in seconds.
//	as_Part		- Task part number.
//	ab_Shortage 	- Whether there are any component material shortages.
//	ab_Late	 	- Whether the task is past due or running late.
//	ab_TaskSeq	- Task Sequence
//	
// Created:	11/5/99	Development Team
//
// ******************************************************************************************

long 	ll_NextDWObject 

// Check values 
if (( isnull ( adt_Begin ) or Date ( adt_Begin ) < Today ( ) )  or ( isnull ( ar_TaskLength ) or ar_TaskLength <= 0 ) or ( isnull ( al_ID ) or al_ID = 0 ) or ( isnull ( al_Index ) or al_Index < 0 ) or ( isnull ( as_IntervalType ) or as_IntervalType = '' ) ) then return -1

// Create the Task 
in_cst_TaskQueue [ al_Index ] = create n_cst_Task

if in_cst_TaskQueue [ al_Index ].of_Create ( adt_RetrieveBegin, as_IntervalType, il_RowId, al_Id, adt_Begin, ar_TaskLength, as_Part, ab_Shortage, ab_Late, al_TaskSeq, is_ShowPart ) = -1 then 
   return -1
end if

// Add Task DWObject create and drop syntax to DW Object Stacks.

// Get the index of the next DW Object.
ll_NextDWObject = UpperBound ( is_DWObjectCreate ) + 1

// Add the create and drop syntaxes.
is_DWObjectCreate [ ll_NextDWObject ] = "create " + in_cst_TaskQueue [ al_Index ].is_DWObjectSyntax
is_DWObjectDestroy [ ll_NextDWObject ] = "destroy " + in_cst_TaskQueue [ al_Index ].is_DWObjectName

// Return.
return 1
end function

public function integer of_create (long al_rowid, string as_name, string as_showpart);// ******************************************************************************************
// Purpose	: Store the row and name of the resource.
//
// Parameters	:
//	al_RowId	- Resource id.
//	as_Name		- Resource name.
//	
//	Created:	11/4/99	Development Team
//
// ******************************************************************************************

//	I.	Check for invalid values.
if IsNull ( al_RowId, -1 ) < 1 or IsNull ( as_Name ) then
	return -1
end if

//	II.	Record Resource Attributes.
il_RowId = al_RowId
is_Name = as_Name
is_ShowPart = as_ShowPart

//	III.	Return.
return 1

end function

public function integer of_display (boolean ab_mode, datetime adt_retrievebegin, string as_intervaltype, datawindow adw_planningboard, string as_ShowPart);// ******************************************************************************************
// Purpose : To Retrieve & create the objects on the dw
//	
// Parameters : 
//	ab_Mode		- Mode False Delete Objects from the dw using objectdestroy array
//	adt_RetrieveBegin	- The DateTime retrieved.
//	as_IntervalType - IntervalType (Minute/Hour/Days etc..)
//	adw_PlanningBoard - The datawindow on which the objects are created
//
// Created : 11/5/99 by Development Team
// ******************************************************************************************

// Declarations
boolean		lb_Shortage
boolean		lb_Late

//datastore 	lds_Tasks
datastore 	lds_Shifts

datetime	ldt_Begin
datetime	ldt_Due

decimal		ld_Balance
decimal		ld_Yield

long		ll_Index
long		ll_TotalItems
long		ll_Id
long		ll_FoundRow
long		ll_TaskSeq

real		lr_TaskLength 

string		ls_Id
string		ls_Part
string		ls_Modify


is_ShowPart = as_ShowPart

// Check value
if Not ( isvalid ( adw_planningboard ) ) then return -1

// Verify Mode (ie Destroy (False) or Create (True) ) 
if Not ( ab_mode ) then 
// Get the total items in the array
	ll_TotalItems = UpperBound ( is_DWObjectDestroy ) 
// Destroy all the objects from the dw	
	for ll_Index = 1 to ll_TotalItems
		ls_Modify += is_DWObjectDestroy [ ll_Index ] + '~r~n'
	next
	adw_planningboard.Modify ( ls_Modify ) 
else
// Check whether FirstTime is true or not
	if ib_FirstTime then

// Add that to the Shifts
		ll_TotalItems = u_dwplanningboard.ids_Shifts.RowCount()
		ll_FoundRow = 0 
		ll_FoundRow = u_dwPlanningBoard.ids_Shifts.Find ( 'Resource_name = "'+is_Name+'"', 1, ll_TotalItems)
		if ll_FoundRow > 0 and ll_FoundRow <= ll_TotalItems then 
			ll_Index = 1
			do while ll_FoundRow <= ll_TotalItems and u_dwPlanningBoard.ids_Shifts.object.resource_name [ ll_FoundRow ] = is_Name
				
					ll_Id		= u_dwPlanningBoard.ids_Shifts.object.Shift_iD [ ll_FoundRow] 
					ldt_Begin	= u_dwPlanningBoard.ids_Shifts.object.Shift_Start [ ll_FoundRow ] 
					lr_TaskLength	= u_dwPlanningBoard.ids_Shifts.object.Shift_Length [ ll_FoundRow]
		
					of_AddShift ( as_IntervalType, ll_Index, ll_Id, ldt_Begin, lr_TaskLength, is_Name) 

					ll_FoundRow ++ 	
					ll_Index ++ 
					
					if ll_FoundRow > ll_TotalItems then exit
			loop
		end if 		

// Add that to the TasksQueue
		ll_TotalItems = u_dwPlanningBoard.ids_Tasks.RowCount()
		ll_FoundRow = 0 
		ll_FoundRow = u_dwPlanningBoard.ids_Tasks.Find ( 'Resource_name = "'+is_Name+'"', 1, ll_TotalItems)
		if ll_FoundRow > 0 and ll_FoundRow <= ll_TotalItems then 
			ll_Index = 1
			do while ll_FoundRow <= ll_TotalItems and u_dwPlanningBoard.ids_Tasks.object.resource_name [ ll_FoundRow ] = is_Name
				ldt_Begin	= u_dwPlanningBoard.ids_Tasks.object.Task_Start [ ll_FoundRow ] 
				lr_TaskLength	= u_dwPlanningBoard.ids_Tasks.object.Task_Duration [ ll_FoundRow ]
				ll_Id		= u_dwPlanningBoard.ids_Tasks.object.Task_Id [ ll_FoundRow ]
				ls_Part		= u_dwPlanningBoard.ids_Tasks.object.Task_Description [ ll_FoundRow ]
				ldt_Due		= u_dwPlanningBoard.ids_Tasks.object.Task_Due [ ll_FoundRow ]
				ld_Balance	= u_dwPlanningBoard.ids_Tasks.object.Task_Balance [ ll_FoundRow ]
				ld_Yield	= u_dwPlanningBoard.ids_Tasks.object.Task_Yield [ ll_FoundRow ] 
				ll_TaskSeq	= u_dwPlanningBoard.ids_Tasks.object.Task_Sequence [ ll_FoundRow ] 				
				lb_Late		= ( ldt_due < Datetime( Today ( ) ) )
				lb_Shortage	= ( ld_Yield < ld_Balance ) 		
	
				of_AddTask ( adt_RetrieveBegin, as_IntervalType, ll_Index, ll_Id, ldt_Begin, lr_TaskLength, ls_Part, lb_Shortage, lb_Late, ll_TaskSeq ) 
				ll_FoundRow ++ 	
				ll_Index ++ 
				if ll_FoundRow > ll_TotalItems then exit				
			loop
		end if 		

// Assign FirstTime boolean to false
		ib_firsttime = False	
	end if 	
// Get the total items in the array
	ll_TotalItems = UpperBound ( is_DWObjectCreate )
// Create Objects from on the dw
	for ll_Index = 1 to ll_TotalItems
		ls_Modify += is_DWObjectCreate [ ll_Index ] + '~r~n'
	next
	adw_planningboard.Modify ( ls_Modify )
end if 

// Return 
return 1

end function

on n_cst_resource.create
TriggerEvent( this, "constructor" )
end on

on n_cst_resource.destroy
TriggerEvent( this, "destructor" )
end on


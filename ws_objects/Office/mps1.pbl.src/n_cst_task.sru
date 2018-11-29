$PBExportHeader$n_cst_task.sru
forward
global type n_cst_task from nonvisualobject
end type
end forward

global type n_cst_task from nonvisualobject
end type
global n_cst_task n_cst_task

type variables
Public:

long	il_StartSeconds
long	il_TaskSeq

string	is_DWObjectSyntax
string	is_DWObjectName

datetime	idt_Begin


Private:

boolean	ib_Shortage
boolean	ib_Late

long	il_Id

real	ir_RunTime

string	is_Part
string	is_Id
string	is_Color
string	is_ShowPart
end variables

forward prototypes
public function integer of_dwobjectsyntax (datetime adt_retrievebegin, string as_intervaltype, long al_row)
public function integer of_create (datetime adt_retrievebegin, string as_intervaltype, long al_row, long al_id, datetime adt_begin, real ar_tasklength, string as_part, boolean ab_shortage, boolean ab_late, long ab_taskseq, string as_showpart)
end prototypes

public function integer of_dwobjectsyntax (datetime adt_retrievebegin, string as_intervaltype, long al_row);// ******************************************************************************************
// Purpose	: Create the Syntax for the datawindow object creation
//
// Parameters	:
//		adt_RetrieveBegin - The DateTime retrieved.
//		as_IntervalType - IntervalType (ie Minute/Hour/Days etc ) 
//		al_Row	 - Current Resource row
//	
//Created:	11/4/99	Development Team
//
// ******************************************************************************************

// Declarations
constant string	PART1 = 'text(band=foreground alignment="0" '
constant string	PART3 = 'border="6" color="0" ' 
constant string	PART5 = 'moveable=1  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" '

string	Part2
string	Part4
string 	Part6
string	ls_ShowPart

// Assign appropriate color based on the task
if ib_Late then
	is_Color = "65535"	// Late jobs
elseif ib_Shortage then
	is_Color = "255" 		// Material Short Jobs
else 
	is_Color = "65280"	// Ontime jobs
end if 	

// Assign values back color & text
part6 = 'background.color="' + is_Color + '" )' 

if is_ShowPart = 'Y' then 
	part2 = 'text="' + Trim (is_Part) + '" '		
else	
	part2 = 'text="' + is_ID + '" '	
end if 	

// Assign x value
il_StartSeconds = DaysAfter ( Date ( adt_RetrieveBegin ), Date ( idt_Begin ) ) * 24 * 60 * 60 + SecondsAfter ( Time ( adt_RetrieveBegin ), Time ( idt_Begin ) )
choose case as_IntervalType
case "Minute"
	part4 = 'x="0~t18 + XoffSet + ( ' + String ( il_StartSeconds ) + ' ) * ( IntervalWidth + 8 ) / ( Interval * 60 )" '
case "Hour"
	part4 = 'x="0~t18 + XoffSet + ( ' + String ( il_StartSeconds ) + ' ) * ( IntervalWidth + 8 ) / ( Interval * 60 * 60 )" '
case "Day"
	part4 = 'x="0~t18 + XoffSet + ( ' + String ( il_StartSeconds ) + ' ) * ( IntervalWidth + 8 ) / ( Interval * 24 * 60 * 60 )" '
case "Week"
	part4 = 'x="0~t18 + XoffSet + ( ' + String ( il_StartSeconds ) + ' ) * ( IntervalWidth + 8 ) / ( Interval * 7 * 24 * 60 * 60 )" '
end choose

// Assign y value			
part4 += 'y="0~t' + String ( 76 + (al_Row - 1) * 96 ) + ' - ( YoffSet - 1 ) * 96 " height="56" '

// Assign width value			
choose case as_IntervalType
case "Minute"
	part4 += 'width="0~t' + String ( ir_RunTime ) + '* ( IntervalWidth + 8 ) / ( Interval * 60 )"  '
case "Hour"
	part4 += 'width="0~t' + String ( ir_RunTime ) + '* ( IntervalWidth + 8 ) / ( Interval * 60 * 60 )"  '
case "Day"
	part4 += 'width="0~t' + String ( ir_RunTime ) + '* ( IntervalWidth + 8 ) / ( Interval * 24 * 60 * 60 )"  '
case "Week"
	part4 += 'width="0~t' + String ( ir_RunTime ) + '* ( IntervalWidth + 8 ) / ( Interval * 7 * 24 * 60 * 60 )"  '
end choose

// Assign value to name
part4 += 'name=t' + Trim ( String ( al_Row ) ) + '_' + Trim ( string ( il_ID ) ) + '_' + Trim ( String ( il_TaskSeq ) ) +' ' 

// Build syntax
is_DWObjectName = 't' + Trim ( String ( al_Row ) ) + '_' + Trim ( string ( il_ID )  ) + '_' + Trim ( String ( il_TaskSeq ) ) +''

is_DWObjectSyntax = PART1 + part2 + PART3 + part4 + PART5 + part6

// Return value
return 1 // Successful

end function

public function integer of_create (datetime adt_retrievebegin, string as_intervaltype, long al_row, long al_id, datetime adt_begin, real ar_tasklength, string as_part, boolean ab_shortage, boolean ab_late, long ab_taskseq, string as_showpart);// *****************************************************************************************
// Purpose : Create the Task queue & the syntax for creating the dwobject 
//
// Arguments : 
//	adt_RetrieveBegin	- Retrieve date time
//	as_IntervalType 	- IntervalType (ie Minute/Hour/Days etc ).
//	al_Row				- Current Resource Row
//	al_Id					- Task id.
//	adt_Begin			- Task start.
//	ar_TaskLength		- Task length in seconds.
//	as_Part				- Task part number.
//	ab_Shortage 		- Whether there are any component material shortages.
//	ab_Late				- Whether the task is past due or running late.
//	ab_TaskSeq		- Task Sequence
//	
// Created:	11/4/99	Development Team
//
// ******************************************************************************************

// Check values 
if (( isnull ( adt_Begin ) or Date ( adt_Begin ) < Today ( ) )  or ( isnull ( ar_TaskLength ) or ar_TaskLength <= 0 ) or ( isnull ( al_ID ) or al_ID = 0 ) or ( isnull ( al_Row ) or al_row < 0 ) or ( isnull ( as_IntervalType ) or as_IntervalType = '' ) ) then return -1

// Sets the values to the instance variables
idt_Begin	=	adt_Begin
ir_RunTime	=	ar_TaskLength
is_Part		= 	as_Part
is_ID		=	string ( al_ID )
il_ID		=	al_ID
ib_Shortage	= 	ab_Shortage
ib_Late		=	ab_Late
il_TaskSeq	=	ab_TaskSeq
is_ShowPart	= 	as_ShowPart

// Create the DWObjectSyntax & assign it to the variable & return value

return of_DWObjectSyntax ( adt_RetrieveBegin, as_IntervalType, al_Row ) 
end function

on n_cst_task.create
TriggerEvent( this, "constructor" )
end on

on n_cst_task.destroy
TriggerEvent( this, "destructor" )
end on


$PBExportHeader$n_cst_shift.sru
forward
global type n_cst_shift from nonvisualobject
end type
end forward

global type n_cst_shift from nonvisualobject
end type
global n_cst_shift n_cst_shift

type variables
Public:
string		is_DWObjectSyntax
string		is_DWObjectName

Private:
datetime	idt_Begin
string		is_Name
long		il_Id
real		ir_Interval
end variables

forward prototypes
private function integer of_dwobjectsyntax (string as_intervaltype, long al_row)
public function integer of_create (string as_intervaltype, long al_row, long al_id, datetime adt_begin, real ar_interval, string as_name)
end prototypes

private function integer of_dwobjectsyntax (string as_intervaltype, long al_row);// ******************************************************************************************
// Purpose	: Create the Syntax for the datawindow object creation
//
// Parameters	:
//	as_IntervalType - IntervalType (ie Minute/Hour/Days etc ) 
//	al_Row	 	- Current Resource row
//	
//	Created:	11/4/99	Development Team
//
// ******************************************************************************************

//	Constant declarations.
constant integer YOFFSETONROW = 56 + 76
constant integer ROWHEIGHT = 96

constant string	OBJECTPREFIX = 'text(band=foreground alignment="0" text="" border="6" color="0" '
constant string	OBJECTSUFFIX = 'moveable=0  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16776960" )'

constant string	XPOSPREFIX = 'x="0~t18 + xoffset + ( DaysAfter ( Date ( Begin ), Date ( ~'' 
constant string	XPOSMIDDLE = '~' ) ) * 24 * 60 * 60 + SecondsAfter ( Time ( Begin ), Time ( ~''
constant string	XPOSSUFFIX1 = '~' ) ) ) * ( IntervalWidth + 8 ) / ( Interval * 60 )" '
constant string	XPOSSUFFIX2 = '~' ) ) ) * ( IntervalWidth + 8 ) / ( Interval * 60 * 60 )" '
constant string	XPOSSUFFIX3 = '~' ) ) ) * ( IntervalWidth + 8 ) / ( Interval * 24 * 60 * 60 )" '
constant string	XPOSSUFFIX4 = '~' ) ) ) * ( IntervalWidth + 8 ) / ( Interval * 7 * 24 * 60 * 60 )" '

constant string	YPOSPREFIX = 'y="0~t'
constant string	YPOSSUFFIX = ' - ( yoffset - 1 ) * 96 " height="24" '

constant string	WIDTHPREFIX = 'width="0~t'
constant string	WIDTHSUFFIX1 = '* ( IntervalWidth + 8 ) / ( Interval * 60 )"  '
constant string	WIDTHSUFFIX2 = '* ( IntervalWidth + 8 ) / ( Interval * 60 * 60 )"  '
constant string	WIDTHSUFFIX3 = '* ( IntervalWidth + 8 ) / ( Interval * 24 * 60 * 60 )"  '
constant string	WIDTHSUFFIX4 = '* ( IntervalWidth + 8 ) / ( Interval * 7 * 24 * 60 * 60 )"  '

constant string	NAMEPREFIX = 'name=s'

//	Declarations.
string	ls_BeginDate
string	ls_BeginTime
string	ls_ShiftLength
string	ls_ShiftTag
string	ls_XPosExpression
string	ls_YPosExpression
string	ls_WidthExpression
string	ls_NameExpression

//	I.	Check for invalid values.
if IsNull ( al_Row, -1 ) < 0 then
	return -1
end if

//	II.	Create DW Object Syntax for Shift.

//		A.	Build x position expression:

//			1.	Calculate Begin Date and Begin Time.
ls_BeginDate = String ( idt_Begin, "[shortdate]" )
ls_BeginTime = String ( idt_Begin, "[time]" )

//			2.	Choose case on Inveterval type and construct expression.
choose case as_IntervalType
case "Minute"
	ls_XPosExpression = XPOSPREFIX + ls_BeginDate + XPOSMIDDLE + ls_BeginTime + XPOSSUFFIX1
case "Hour"
	ls_XPosExpression = XPOSPREFIX + ls_BeginDate + XPOSMIDDLE + ls_BeginTime + XPOSSUFFIX2
case "Day"
	ls_XPosExpression = XPOSPREFIX + ls_BeginDate + XPOSMIDDLE + ls_BeginTime + XPOSSUFFIX3
case "Week"
	ls_XPosExpression = XPOSPREFIX + ls_BeginDate + XPOSMIDDLE + ls_BeginTime + XPOSSUFFIX4
case else
	Return -1
end choose

//		B.	Build y position expression:
ls_YPosExpression = YPOSPREFIX + String ( YOFFSETONROW + ( al_Row - 1 ) * ROWHEIGHT ) + YPOSSUFFIX

//		C.	Build width expression:

//			1.	Choose case on Inveterval type and construct expression.
choose case as_IntervalType
case "Minute"
	ls_WidthExpression = WIDTHPREFIX + String ( Long ( ir_Interval ) ) + WIDTHSUFFIX1
case "Hour"
	ls_WidthExpression = WIDTHPREFIX + String ( Long ( ir_Interval ) ) + WIDTHSUFFIX2
case "Day"
	ls_WidthExpression = WIDTHPREFIX + String ( Long ( ir_Interval ) ) + WIDTHSUFFIX3
case "Week"
	ls_WidthExpression = WIDTHPREFIX + String ( Long ( ir_Interval ) ) + WIDTHSUFFIX4
case else
	Return -1
end choose

//		D.	Build name expression:
ls_NameExpression = NAMEPREFIX + String ( al_Row ) + '_' + String ( il_Id ) + '_'+ String ( il_Id ) + ' '

//		E.	Assemble DW Object Syntax.
is_DWObjectSyntax = OBJECTPREFIX + ls_XPosExpression + ls_YPosExpression + ls_WidthExpression + ls_NameExpression + OBJECTSUFFIX

//		F.	Assign DW Object Name.
is_DWObjectName = 's' + String ( al_Row ) + '_' + String ( il_Id ) + '_'+ String ( il_Id ) + ''

//	III.	Return.
return 1

end function

public function integer of_create (string as_intervaltype, long al_row, long al_id, datetime adt_begin, real ar_interval, string as_name);// ******************************************************************************************
// Purpose	: Create the Syntax for the datawindow object creation
//
// Parameters	:
//	as_IntervalType - IntervalType (ie Minute/Hour/Days etc ).
//	al_Row	 	- Current resource row.
//	al_Id		- Shift id.
//	adt_Begin	- Shift start.
//	ar_Interval	- Shift length in seconds.
//	as_Name		- Shift name.
//	
//	Created:		11/4/99	Development Team
//
// ******************************************************************************************

//	I.	Check for invalid values.
if IsNull ( al_Id, -1 ) < 0 or IsNull ( adt_Begin ) or IsNull ( ar_Interval, -1 ) <= 0 or IsNull ( as_Name ) then
	return -1
end if

//	II.	Record Shift Attributes.
il_Id = al_Id
idt_Begin = adt_Begin
ir_Interval = ar_Interval * 3600
is_Name = as_Name

//	III.	Build the DW Object Syntax for the shift and return.
return of_DWObjectSyntax ( as_IntervalType, al_Row )

end function

on n_cst_shift.create
TriggerEvent( this, "constructor" )
end on

on n_cst_shift.destroy
TriggerEvent( this, "destructor" )
end on


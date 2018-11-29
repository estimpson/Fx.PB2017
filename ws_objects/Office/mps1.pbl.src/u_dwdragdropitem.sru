$PBExportHeader$u_dwdragdropitem.sru
forward
global type u_dwdragdropitem from datawindow
end type
end forward

global type u_dwdragdropitem from datawindow
int Width=1408
int Height=1168
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event ue_dragitembegin ( integer xpos,  integer ypos,  long row,  string dwoname )
event ue_dragitemwithin ( integer xpos,  integer ypos,  long row,  string dwoname )
event ue_dragitemend ( integer xpos,  integer ypos,  integer row,  string dwoname )
event mousemove pbm_dwnmousemove
event lbuttonup pbm_dwnlbuttonup
end type
global u_dwdragdropitem u_dwdragdropitem

type variables
Private:

boolean	ib_DragMode = false 

string	is_DragItemName

end variables

event mousemove;//	I.	If Drag Mode is on then generate event ue_DragItemWithin ( )
if ib_DragMode then
	event ue_dragitemwithin ( xpos, ypos, row, is_DragItemName )
end if
end event

event lbuttonup;
//	I.	If Drag Mode is on then generate event ue_DragItemEnd ( )
if ib_DragMode then
	ib_DragMode = false
	event ue_DragItemEnd ( xpos, ypos, row, is_DragItemName )
end if
end event

event clicked;int	li_option

//	Declarations
string	ls_ObjectAtPointer
string	ls_ObjectAtPointerName

//	I.	If clicked dwo is a column and object at pointer is a moveable item, then generate event ue_DragItemBegin ( ).

//		A.	Get name of object at pointer.

//			1.	Get object at pointer and strip tab and row.
ls_ObjectAtPointer = GetObjectAtPointer ( )
ls_ObjectAtPointerName = LeftA ( ls_ObjectAtPointer, PosA ( ls_ObjectAtPointer, "~t" ) - 1 )

//			2.	If ( ( datawindow is grid and row is 0 ) or dwo.Type is column ) and object at pointer is moveable, then generate event ue_DragItemBegin ( ).

if ( dwo.Type = "column" or row = 0 ) and Describe ( ls_ObjectAtPointerName + ".Moveable" ) = "1" then
	ib_DragMode = true
	is_DragItemName = ls_ObjectAtPointerName
	event ue_DragItemBegin ( xpos, ypos, row, is_DragItemName )
end if



end event


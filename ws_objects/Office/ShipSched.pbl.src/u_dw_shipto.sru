$PBExportHeader$u_dw_shipto.sru
forward
global type u_dw_shipto from u_dw
end type
end forward

global type u_dw_shipto from u_dw
int Width=800
int Height=1416
string DataObject="d_shipto"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean HSplitScroll=true
event ue_rowchanged(integer currentrow)
end type
global u_dw_shipto u_dw_shipto

type variables

Private:
boolean	ib_Retrieving

integer	ii_CurrentRow = 1

string	is_HorizontalScrollPosition
string	is_VerticalScrollPosition
end variables

event ue_rowchanged;
//	Record new current row.
ii_CurrentRow = currentrow
end event

event constructor;call super::constructor;
//	Set Transaction Object and Retrieve.
SetTransObject(SQLCA)

//	Turn on Row Selection service.
of_SetRowSelect(true)

//	Turn off PFC right button popup menu so that our own can be used.
ib_RMBMenu = false
end event

event rowfocuschanging;call super::rowfocuschanging;
//	Record newrow and post user event row changed.
if not ib_Retrieving then
	ii_CurrentRow = newrow
	post event ue_RowChanged(newrow)

//	Otherwise, records are being retrieved.
else
	
	//	Set back to old current row.
	if ii_CurrentRow = newrow then
		post event ue_RowChanged(newrow)
	end if
	post SetRow(ii_CurrentRow)
end if
end event

event retrievestart;call super::retrievestart;
//	Signal retrieving on.
ib_Retrieving = true

//	Turn off redraw to prevent flickering.
SetRedraw(false)

//	Record starting horizontal and vertical scroll positions.
is_HorizontalScrollPosition = object.datawindow.horizontalscrollposition
is_VerticalScrollPosition = object.datawindow.verticalscrollposition

//	Remove data to force current row to go to zero.
Reset()
end event

event retrieveend;call super::retrieveend;
//	Signal retrieving off.
ib_Retrieving = false
	
//	Scroll datawindow back to horizontal and vertical positions.
object.datawindow.horizontalscrollposition = is_HorizontalScrollPosition
object.datawindow.verticalscrollposition = is_VerticalScrollPosition

//	Turn on redraw to reflect changes.
post SetRedraw(true)
end event


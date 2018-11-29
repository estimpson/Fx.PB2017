$PBExportHeader$u_dw_shipschedule.sru
forward
global type u_dw_shipschedule from u_dw
end type
end forward

global type u_dw_shipschedule from u_dw
integer width = 2514
integer height = 944
string dataobject = "d_shipschedule"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
event ue_rowchanged(integer currentrow)
event pfc_event(string eventname,  n_cst_associative_array eventmessage)
end type
global u_dw_shipschedule u_dw_shipschedule

type variables

Private:
boolean	ib_Retrieving

integer	ii_CurrentRow = 1

long	il_SelectedShipper = -1

string	is_HorizontalScrollPosition, is_VerticalScrollPosition
string	is_Destination = "", is_ShipType = "N", is_Plant = ""

end variables

event ue_rowchanged;
//	Record new current row.
ii_CurrentRow = currentrow

end event

event pfc_event;
//	Process destination changes.
choose case EventName
	case "Destination"
		is_Destination = EventMessage.of_GetItem("Destination")
		of_Retrieve()
	case "ShipperModified"
		//the destination doesn´t change when you create a shipper
//		of_Refresh(TRUE)
		of_Retrieve()
		//FALTA PCV
		//messagebox("ShipperModified",string(EventMessage.of_GetItem("Destination")))

		//when you modify the shipper, is_Destination doesn´t change
//		string ls_pp
//		ls_pp=EventMessage.of_GetItem("Destination")
//		messagebox("ShipperModified",ls_pp)
end choose

end event

event dragwithin;call super::dragwithin;
//	Select current row.
if row > 0 and isvalid(inv_rowselect) then
	if GetSelectedRow(0) <> row then inv_RowSelect.of_RowSelect(row)
end if

end event

event constructor;call super::constructor;
//	Set Transaction Object and Retrieve.
SetTransObject(SQLCA)

//	Turn on Row Selection service.
of_SetRowSelect(true)

//	Turn off PFC right button popup menu so that our own can be used.
ib_RMBMenu = false

//	Request notification of Destination change.
gnv_App.inv_StateMsgRouter.of_RequestNotification(this, "Destination")
gnv_App.inv_StateMsgRouter.of_RequestNotification(this, "ShipperModified")
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

event pfc_retrieve;call super::pfc_retrieve;
//	Retrieve the list of shippers.
return Retrieve(is_ShipType, is_Destination, is_Plant)

end event

event rowfocuschanged;call super::rowfocuschanged;
//	Notify of change in shipper.
n_cst_associative_array	lnv_Message
if currentrow > 0 then
	il_SelectedShipper = object.shipper_id[currentrow]
	lnv_Message.of_SetItem("Shipper", il_SelectedShipper)
	gnv_App.inv_StateMsgRouter.of_Broadcast(lnv_Message)
end if

end event

event dragdrop;call super::dragdrop;

//	Read the drag message.
n_cst_associative_array	lnv_DragMessage
lnv_DragMessage = IsNull(Message.inv_Parm.of_GetItem("DragMessage"), lnv_DragMessage)

//	Add to the message the dropped shipper.
lnv_DragMessage.of_SetItem("Shipper", il_SelectedShipper)

//	Linkage.
n_cst_associative_array	lnv_LinkMessage

//	Broadcast change in customer and order header.
lnv_LinkMessage.of_SetItem("ShipperModified", il_SelectedShipper)
gnv_App.inv_StateMsgRouter.of_Broadcast(lnv_LinkMessage)

end event

event doubleclicked;call super::doubleclicked;
n_cst_associative_array	lnv_Message

//	Add to the message the dropped shipper.
lnv_Message.of_SetItem("shipper id", il_SelectedShipper)  //PCV old

//	Process the request.
if il_SelectedShipper <> 0 then
	//	Linkage.
	n_cst_associative_array	lnv_LinkMessage
	
	//	Broadcast change in customer and order header.
	lnv_LinkMessage.of_SetItem("ShipperModified", il_SelectedShipper)
	gnv_App.inv_StateMsgRouter.of_Broadcast(lnv_LinkMessage)

end if


end event

on u_dw_shipschedule.create
call super::create
end on

on u_dw_shipschedule.destroy
call super::destroy
end on


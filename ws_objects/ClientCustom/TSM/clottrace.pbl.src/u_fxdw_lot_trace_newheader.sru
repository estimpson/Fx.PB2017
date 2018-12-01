$PBExportHeader$u_fxdw_lot_trace_newheader.sru
forward
global type u_fxdw_lot_trace_newheader from u_fxdw
end type
end forward

global type u_fxdw_lot_trace_newheader from u_fxdw
integer width = 2889
integer height = 1020
string dataobject = "d_lot_trace_newheader"
boolean vscrollbar = false
end type
global u_fxdw_lot_trace_newheader u_fxdw_lot_trace_newheader

on u_fxdw_lot_trace_newheader.create
call super::create
end on

on u_fxdw_lot_trace_newheader.destroy
call super::destroy
end on

event constructor;call super::constructor;
//of_SetTransObject (sqlca)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_lot_trace_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		
		string	description, serialList
		description = Object.Description[1]
		serialList = Object.SerialList[1]
		
		myController.NewLotTrace(description, serialList)
	case "p_cancel"
		
		myController.CancelNewLotTrace()
end choose

end event

event pfc_retrieve;call super::pfc_retrieve;
Reset()
return InsertRow(0)

end event


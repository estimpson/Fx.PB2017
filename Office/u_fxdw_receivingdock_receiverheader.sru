HA$PBExportHeader$u_fxdw_receivingdock_receiverheader.sru
forward
global type u_fxdw_receivingdock_receiverheader from u_fxdw
end type
end forward

global type u_fxdw_receivingdock_receiverheader from u_fxdw
integer width = 3808
integer height = 524
string dataobject = "d_receivingdock_getreceiverheader"
boolean vscrollbar = false
end type
global u_fxdw_receivingdock_receiverheader u_fxdw_receivingdock_receiverheader

type variables

private:

//	Model data.
string _receiverNumber

//	Controller reference.
n_cst_receivingdock_controller _myController

end variables

forward prototypes
public function integer setreceivernumber (string receivernumber)
end prototypes

public function integer setreceivernumber (string receivernumber);
_receiverNumber = receiverNumber
return Refresh()

end function

on u_fxdw_receivingdock_receiverheader.create
call super::create
end on

on u_fxdw_receivingdock_receiverheader.destroy
call super::destroy
end on

event clicked;call super::clicked;
if	not IsValid(_myController) then return FAILURE

choose case lower(dwo.name)
	case "p_hide"
		
		//	Get the controller for this control's window.
		_myController.ToggleShowInstructions()
		return
end choose

end event

event constructor;call super::constructor;
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_receiverNumber)

end event


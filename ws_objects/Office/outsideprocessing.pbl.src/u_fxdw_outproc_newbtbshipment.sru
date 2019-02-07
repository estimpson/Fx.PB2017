$PBExportHeader$u_fxdw_outproc_newbtbshipment.sru
forward
global type u_fxdw_outproc_newbtbshipment from u_fxdw
end type
end forward

global type u_fxdw_outproc_newbtbshipment from u_fxdw
integer width = 1938
integer height = 1612
string dataobject = "d_outproc_maint_newbtbshipment"
end type
global u_fxdw_outproc_newbtbshipment u_fxdw_outproc_newbtbshipment

type variables

long _opDefRowID

end variables

forward prototypes
public function integer setopdefrowid (long opdefrowid)
end prototypes

public function integer setopdefrowid (long opdefrowid);
_opDefRowID = opDefRowID
return Refresh()

end function

on u_fxdw_outproc_newbtbshipment.create
call super::create
end on

on u_fxdw_outproc_newbtbshipment.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_opDefRowID)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_outproc_maint_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		
		string	confirmedSID, notes
		decimal quantity
		confirmedSID = Object.ConfirmedSID[1]
		quantity = Object.Quantity[1]
		notes = Object.Notes[1]
		
		myController.NewBTBShipment(confirmedSID, quantity, notes)
		
	case "p_cancel"
		Reset()
		
		myController.CancelNewBTBShipment()
end choose

end event


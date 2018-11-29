$PBExportHeader$u_fxdw_packaging_bulktracking_adjustst.sru
forward
global type u_fxdw_packaging_bulktracking_adjustst from u_fxdw
end type
end forward

global type u_fxdw_packaging_bulktracking_adjustst from u_fxdw
integer width = 1376
integer height = 1196
string dataobject = "d_packaging_bulktracking_adjuststqtyedit"
boolean vscrollbar = false
boolean livescroll = false
end type
global u_fxdw_packaging_bulktracking_adjustst u_fxdw_packaging_bulktracking_adjustst

type variables

//	Model data.
string _packageCode
string _destinationCode

end variables

forward prototypes
public function integer setpackagecodeshiptocode (string packagecode, string destinationcode)
end prototypes

public function integer setpackagecodeshiptocode (string packagecode, string destinationcode);
_packageCode = packageCode
_destinationCode = destinationCode
return Refresh()

end function

on u_fxdw_packaging_bulktracking_adjustst.create
call super::create
end on

on u_fxdw_packaging_bulktracking_adjustst.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_packageCode, _destinationCode)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_packaging_bulk_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		
		int netQuantityAdjustment
		netQuantityAdjustment = Object.NetQtyAdjustment[1]
		
		myController.AdjustShipToQuantity(_packageCode, _destinationCode, netQuantityAdjustment)
		
	case "p_cancel"
		
		myController.CancelAdjustQuantity()
end choose

end event


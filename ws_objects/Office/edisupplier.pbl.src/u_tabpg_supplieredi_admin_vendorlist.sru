$PBExportHeader$u_tabpg_supplieredi_admin_vendorlist.sru
forward
global type u_tabpg_supplieredi_admin_vendorlist from u_tabpg_dw
end type
end forward

global type u_tabpg_supplieredi_admin_vendorlist from u_tabpg_dw
string text = "Supplier List"
end type
global u_tabpg_supplieredi_admin_vendorlist u_tabpg_supplieredi_admin_vendorlist

type variables

Private:
n_supplieredi_admin_controller _myController

end variables

on u_tabpg_supplieredi_admin_vendorlist.create
call super::create
end on

on u_tabpg_supplieredi_admin_vendorlist.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_supplieredi_admin_vendorlist
string text = "Suppliers"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_supplieredi_admin_vendorlist
string dataobject = "d_supplieredi_admin_vendorlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//datawindowchild dddw
//
//if	GetChild("Status", dddw) = SUCCESS then
//	dddw.SetTransObject(SQLCA)
//	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
//		dddw.InsertRow(0)
//	end if
//end if

return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activeRow <= 0 then return

string vendorCode
vendorCode = object.vendorcode[activerow]
_myController.SetActiveVendor(vendorCode)

end event


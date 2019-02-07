HA$PBExportHeader$u_fxdw_inventory_control_quickfindselect.sru
forward
global type u_fxdw_inventory_control_quickfindselect from u_fxdw
end type
end forward

global type u_fxdw_inventory_control_quickfindselect from u_fxdw
integer width = 809
integer height = 784
string dataobject = "d_inventory_control_quickfindselection"
boolean vscrollbar = false
end type
global u_fxdw_inventory_control_quickfindselect u_fxdw_inventory_control_quickfindselect

type variables

private:
// Controller reference.
n_inventory_control_controller _myController

end variables

on u_fxdw_inventory_control_quickfindselect.create
call super::create
end on

on u_fxdw_inventory_control_quickfindselect.destroy
call super::destroy
end on

event itemchanged;call super::itemchanged;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

if	not IsValid(_myController) or IsNull(_myController) then return

if	lower(dwo.Name) <> lower("QuickFindSelection") then return NO_ACTION
choose case lower(data)
	case lower("Serial")
		_myController.SerialFilter()
		
	case lower("Part")
		_myController.PartFilter()
		
	case lower("Location")
		_myController.LocationFilter()
		
	case lower("Pallet")
		_myController.PalletFilter()
		
	case lower("All")
		_myController.NoFilter()
end choose

end event

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event


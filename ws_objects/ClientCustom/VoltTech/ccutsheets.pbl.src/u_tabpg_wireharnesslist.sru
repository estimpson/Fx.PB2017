$PBExportHeader$u_tabpg_wireharnesslist.sru
forward
global type u_tabpg_wireharnesslist from u_tabpg_dw
end type
end forward

global type u_tabpg_wireharnesslist from u_tabpg_dw
integer width = 1977
end type
global u_tabpg_wireharnesslist u_tabpg_wireharnesslist

type variables

private:

//	Controller reference.
n_cutsheet_controller _myController

end variables
on u_tabpg_wireharnesslist.create
call super::create
end on

on u_tabpg_wireharnesslist.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_wireharnesslist
string text = "Wire Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_wireharnesslist
string dataobject = "d_cutsheet_wireharnesslist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activeRow <= 0 or activeRow > RowCount() then return
string wireHarness
wireHarness = Object.PartCode[activeRow]
_myController.SetWireHarness(wireHarness)

end event


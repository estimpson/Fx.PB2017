$PBExportHeader$u_tabpg_whassembly_parentlocations.sru
forward
global type u_tabpg_whassembly_parentlocations from u_tabpg_dw
end type
end forward

global type u_tabpg_whassembly_parentlocations from u_tabpg_dw
integer width = 1977
end type
global u_tabpg_whassembly_parentlocations u_tabpg_whassembly_parentlocations

type variables

Private:
n_whassembly_kanbanracks_controller _myController

end variables

on u_tabpg_whassembly_parentlocations.create
call super::create
end on

on u_tabpg_whassembly_parentlocations.destroy
call super::destroy
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y + gb_1.Height)
//inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
//inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_whassembly_parentlocations
string text = "Kanban Parent Locations"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_whassembly_parentlocations
string dataobject = "d_custom_mes_assemblyparentlocations"
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
if	activerow < 1 or activerow > RowCount() or not IsValid(_myController) then
	return
end if

string parentLocation
parentLocation = object.code[activerow]
_myController.post SetParentLocation(parentLocation)

end event


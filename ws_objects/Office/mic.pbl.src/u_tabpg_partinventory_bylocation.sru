$PBExportHeader$u_tabpg_partinventory_bylocation.sru
forward
global type u_tabpg_partinventory_bylocation from u_tabpg_dw
end type
end forward

global type u_tabpg_partinventory_bylocation from u_tabpg_dw
integer width = 1977
string text = "Part Inventory"
end type
global u_tabpg_partinventory_bylocation u_tabpg_partinventory_bylocation

type variables

string Part

end variables

on u_tabpg_partinventory_bylocation.create
call super::create
end on

on u_tabpg_partinventory_bylocation.destroy
call super::destroy
end on

event constructor;
super::event constructor()

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
masterDWO[1] = dw_1.object.location

//	Setup notifications.
windowHandle = Handle(GetParent())

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partinventory_bylocation
string text = "Inventory"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partinventory_bylocation
string dataobject = "d_dbo_inventorycontrol_partinvent"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
if	Retrieve(Part) = 0 then
	insertRow(0)
end if
return RowCount()


end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event


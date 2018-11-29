$PBExportHeader$u_tabpg_customerservice_billtos.sru
forward
global type u_tabpg_customerservice_billtos from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_billtos from u_tabpg_dw
integer width = 1833
string text = "Customers"
end type
global u_tabpg_customerservice_billtos u_tabpg_customerservice_billtos

on u_tabpg_customerservice_billtos.create
call super::create
end on

on u_tabpg_customerservice_billtos.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
masterDWO[1] = dw_1.object.billtocode

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_billtos
integer y = 8
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_billtos
integer y = 88
string dataobject = "d_customerservice_billtos"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event


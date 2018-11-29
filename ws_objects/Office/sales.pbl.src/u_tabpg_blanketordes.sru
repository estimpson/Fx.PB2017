$PBExportHeader$u_tabpg_blanketordes.sru
forward
global type u_tabpg_blanketordes from u_tabpg_dw
end type
end forward

global type u_tabpg_blanketordes from u_tabpg_dw
string text = "Blanket Orders"
end type
global u_tabpg_blanketordes u_tabpg_blanketordes

on u_tabpg_blanketordes.create
call super::create
end on

on u_tabpg_blanketordes.destroy
call super::destroy
end on

event constructor;call super::constructor;
masterDWO[1] = dw_1.object.salesorderno

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_blanketordes
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_blanketordes
string dataobject = "d_blanketorder_inquiry"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event


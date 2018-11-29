$PBExportHeader$u_tabpg_backflushingprinciples.sru
forward
global type u_tabpg_backflushingprinciples from u_tabpg_dw
end type
end forward

global type u_tabpg_backflushingprinciples from u_tabpg_dw
integer width = 1977
string text = "Backflushing Principles"
end type
global u_tabpg_backflushingprinciples u_tabpg_backflushingprinciples

on u_tabpg_backflushingprinciples.create
call super::create
end on

on u_tabpg_backflushingprinciples.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_backflushingprinciples
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_backflushingprinciples
string dataobject = "d_dbo_mes_setupbackflushingprinciples"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
SetTransObject(SQLCA)
of_SetUpdateable(true)

end event


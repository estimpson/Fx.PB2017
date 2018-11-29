$PBExportHeader$u_tabpg_customerservice_poolpoints.sru
forward
global type u_tabpg_customerservice_poolpoints from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_poolpoints from u_tabpg_dw
integer width = 1977
string text = "Pool Points"
end type
global u_tabpg_customerservice_poolpoints u_tabpg_customerservice_poolpoints

on u_tabpg_customerservice_poolpoints.create
call super::create
end on

on u_tabpg_customerservice_poolpoints.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_poolpoints
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_poolpoints
end type


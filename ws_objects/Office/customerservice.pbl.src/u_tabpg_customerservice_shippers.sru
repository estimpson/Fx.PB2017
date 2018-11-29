$PBExportHeader$u_tabpg_customerservice_shippers.sru
forward
global type u_tabpg_customerservice_shippers from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_shippers from u_tabpg_dw
string text = "Shippers"
end type
global u_tabpg_customerservice_shippers u_tabpg_customerservice_shippers

on u_tabpg_customerservice_shippers.create
call super::create
end on

on u_tabpg_customerservice_shippers.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_shippers
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_shippers
end type


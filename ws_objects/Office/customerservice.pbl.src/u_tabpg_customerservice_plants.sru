$PBExportHeader$u_tabpg_customerservice_plants.sru
forward
global type u_tabpg_customerservice_plants from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_plants from u_tabpg_dw
integer width = 1977
string text = "Plants"
end type
global u_tabpg_customerservice_plants u_tabpg_customerservice_plants

on u_tabpg_customerservice_plants.create
call super::create
end on

on u_tabpg_customerservice_plants.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_plants
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_plants
end type


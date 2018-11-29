$PBExportHeader$u_tabpg_customerservice_returndetails.sru
forward
global type u_tabpg_customerservice_returndetails from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_returndetails from u_tabpg_dw
string text = "Return Details"
end type
global u_tabpg_customerservice_returndetails u_tabpg_customerservice_returndetails

on u_tabpg_customerservice_returndetails.create
call super::create
end on

on u_tabpg_customerservice_returndetails.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_returndetails
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_returndetails
end type


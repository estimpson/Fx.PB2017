$PBExportHeader$u_tabpg_customerservice_salesorders.sru
forward
global type u_tabpg_customerservice_salesorders from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_salesorders from u_tabpg_dw
string text = "Sales Orders"
end type
global u_tabpg_customerservice_salesorders u_tabpg_customerservice_salesorders

on u_tabpg_customerservice_salesorders.create
call super::create
end on

on u_tabpg_customerservice_salesorders.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_salesorders
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_salesorders
end type


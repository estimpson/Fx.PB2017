$PBExportHeader$u_tabpg_customerservice_salesorderdetail.sru
forward
global type u_tabpg_customerservice_salesorderdetail from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_salesorderdetail from u_tabpg_dw
string text = "Sales Details"
end type
global u_tabpg_customerservice_salesorderdetail u_tabpg_customerservice_salesorderdetail

on u_tabpg_customerservice_salesorderdetail.create
call super::create
end on

on u_tabpg_customerservice_salesorderdetail.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_salesorderdetail
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_salesorderdetail
end type


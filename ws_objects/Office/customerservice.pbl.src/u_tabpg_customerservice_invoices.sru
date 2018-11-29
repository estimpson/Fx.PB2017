$PBExportHeader$u_tabpg_customerservice_invoices.sru
forward
global type u_tabpg_customerservice_invoices from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_invoices from u_tabpg_dw
string text = "Invoices"
end type
global u_tabpg_customerservice_invoices u_tabpg_customerservice_invoices

on u_tabpg_customerservice_invoices.create
call super::create
end on

on u_tabpg_customerservice_invoices.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_invoices
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_invoices
end type


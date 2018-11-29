$PBExportHeader$u_tabpg_customerservice_invoicedetails.sru
forward
global type u_tabpg_customerservice_invoicedetails from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_invoicedetails from u_tabpg_dw
string text = "Invoice Details"
end type
global u_tabpg_customerservice_invoicedetails u_tabpg_customerservice_invoicedetails

on u_tabpg_customerservice_invoicedetails.create
call super::create
end on

on u_tabpg_customerservice_invoicedetails.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_invoicedetails
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_invoicedetails
end type


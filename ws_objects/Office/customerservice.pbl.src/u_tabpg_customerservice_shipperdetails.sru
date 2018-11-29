$PBExportHeader$u_tabpg_customerservice_shipperdetails.sru
forward
global type u_tabpg_customerservice_shipperdetails from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_shipperdetails from u_tabpg_dw
string text = "Shipper Details"
end type
global u_tabpg_customerservice_shipperdetails u_tabpg_customerservice_shipperdetails

on u_tabpg_customerservice_shipperdetails.create
call super::create
end on

on u_tabpg_customerservice_shipperdetails.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_shipperdetails
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_shipperdetails
end type


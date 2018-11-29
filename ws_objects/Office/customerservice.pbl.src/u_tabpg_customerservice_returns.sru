$PBExportHeader$u_tabpg_customerservice_returns.sru
forward
global type u_tabpg_customerservice_returns from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_returns from u_tabpg_dw
string text = "Returns"
end type
global u_tabpg_customerservice_returns u_tabpg_customerservice_returns

on u_tabpg_customerservice_returns.create
call super::create
end on

on u_tabpg_customerservice_returns.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_returns
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_returns
end type


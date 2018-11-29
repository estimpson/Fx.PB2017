$PBExportHeader$u_tabpg_salesheaders.sru
forward
global type u_tabpg_salesheaders from u_tabpg_dw
end type
end forward

global type u_tabpg_salesheaders from u_tabpg_dw
end type
global u_tabpg_salesheaders u_tabpg_salesheaders

on u_tabpg_salesheaders.create
call super::create
end on

on u_tabpg_salesheaders.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_salesheaders
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_salesheaders
end type


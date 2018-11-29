$PBExportHeader$u_tabpg_quickpoheader.sru
forward
global type u_tabpg_quickpoheader from u_tabpg_dw
end type
end forward

global type u_tabpg_quickpoheader from u_tabpg_dw
end type
global u_tabpg_quickpoheader u_tabpg_quickpoheader

on u_tabpg_quickpoheader.create
call super::create
end on

on u_tabpg_quickpoheader.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_quickpoheader
string text = "PO Header"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_quickpoheader
string dataobject = "d_quickpoheader"
end type


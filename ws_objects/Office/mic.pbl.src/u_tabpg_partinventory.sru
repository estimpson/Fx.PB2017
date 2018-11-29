$PBExportHeader$u_tabpg_partinventory.sru
forward
global type u_tabpg_partinventory from u_tabpg_dwchild
end type
end forward

global type u_tabpg_partinventory from u_tabpg_dwchild
string text = "Inventory Information"
end type
global u_tabpg_partinventory u_tabpg_partinventory

on u_tabpg_partinventory.create
call super::create
end on

on u_tabpg_partinventory.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dwchild`gb_1 within u_tabpg_partinventory
string text = "Inventory Information"
end type

type dw_1 from u_tabpg_dwchild`dw_1 within u_tabpg_partinventory
integer y = 336
string dataobject = "d_partinventory"
end type

type dw_parent from u_tabpg_dwchild`dw_parent within u_tabpg_partinventory
string dataobject = "d_parts"
end type

type gb_parent from u_tabpg_dwchild`gb_parent within u_tabpg_partinventory
end type


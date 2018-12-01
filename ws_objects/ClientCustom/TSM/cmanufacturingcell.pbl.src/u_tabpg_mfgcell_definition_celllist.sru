$PBExportHeader$u_tabpg_mfgcell_definition_celllist.sru
forward
global type u_tabpg_mfgcell_definition_celllist from u_tabpg_dw
end type
end forward

global type u_tabpg_mfgcell_definition_celllist from u_tabpg_dw
end type
global u_tabpg_mfgcell_definition_celllist u_tabpg_mfgcell_definition_celllist

on u_tabpg_mfgcell_definition_celllist.create
call super::create
end on

on u_tabpg_mfgcell_definition_celllist.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mfgcell_definition_celllist
string text = "Manufacturing Cells"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mfgcell_definition_celllist
string dataobject = "d_manufacturingcelldefinitions"
end type


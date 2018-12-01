$PBExportHeader$w_mfgcell_definition.srw
forward
global type w_mfgcell_definition from w_sheet_panel_4t
end type
end forward

global type w_mfgcell_definition from w_sheet_panel_4t
string title = "Manufacturing Cell Definition"
end type
global w_mfgcell_definition w_mfgcell_definition

on w_mfgcell_definition.create
int iCurrent
call super::create
end on

on w_mfgcell_definition.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_1 from w_sheet_panel_4t`uo_1 within w_mfgcell_definition
end type


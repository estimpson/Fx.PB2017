$PBExportHeader$w_downtimetracking.srw
forward
global type w_downtimetracking from w_sheet_panel_4t
end type
end forward

global type w_downtimetracking from w_sheet_panel_4t
integer x = 214
integer y = 221
string title = "Downtime Tracking"
end type
global w_downtimetracking w_downtimetracking

on w_downtimetracking.create
int iCurrent
call super::create
end on

on w_downtimetracking.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uo_1 from w_sheet_panel_4t`uo_1 within w_downtimetracking
end type


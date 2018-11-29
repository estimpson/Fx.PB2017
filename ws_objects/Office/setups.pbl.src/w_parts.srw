$PBExportHeader$w_parts.srw
forward
global type w_parts from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_parts within tab_1
end type
type tabpage_1 from u_tabpg_parts within tab_1
end type
type tabpage_2 from u_tabpg_partinventory within tab_1
end type
type tabpage_2 from u_tabpg_partinventory within tab_1
end type
end forward

global type w_parts from w_sheet_tab_4t
string title = "Part Setups"
end type
global w_parts w_parts

on w_parts.create
int iCurrent
call super::create
end on

on w_parts.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_tab_4t`tab_1 within w_parts
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from u_tabpg_parts within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from u_tabpg_partinventory within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type


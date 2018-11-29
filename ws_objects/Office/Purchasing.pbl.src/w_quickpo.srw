$PBExportHeader$w_quickpo.srw
forward
global type w_quickpo from w_sheet_headerdetail_4t
end type
type tabpage_1 from u_tabpg_quickpoheader within tab_1
end type
type tabpage_1 from u_tabpg_quickpoheader within tab_1
end type
end forward

global type w_quickpo from w_sheet_headerdetail_4t
integer x = 214
integer y = 221
string title = "Quick PO"
end type
global w_quickpo w_quickpo

on w_quickpo.create
int iCurrent
call super::create
end on

on w_quickpo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_quickpo
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_quickpo
end type

type st_1 from w_sheet_headerdetail_4t`st_1 within w_quickpo
end type

type tabpage_1 from u_tabpg_quickpoheader within tab_1
integer x = 18
integer y = 48
integer width = 2263
integer height = 1116
end type


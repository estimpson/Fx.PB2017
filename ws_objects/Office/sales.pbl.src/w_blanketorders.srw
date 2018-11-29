$PBExportHeader$w_blanketorders.srw
forward
global type w_blanketorders from w_sheet_headerdetail_4t
end type
type tabpage_1 from u_tabpg_blanketordes within tab_1
end type
type tabpage_1 from u_tabpg_blanketordes within tab_1
end type
type tabpage_2 from u_tabpg_blanketorderreleases within tab_2
end type
type tabpage_2 from u_tabpg_blanketorderreleases within tab_2
end type
end forward

global type w_blanketorders from w_sheet_headerdetail_4t
integer x = 214
integer y = 221
string title = "Blanket Orders"
end type
global w_blanketorders w_blanketorders

on w_blanketorders.create
int iCurrent
call super::create
end on

on w_blanketorders.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_blanketorders
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

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_blanketorders
tabpage_2 tabpage_2
end type

on tab_2.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type st_1 from w_sheet_headerdetail_4t`st_1 within w_blanketorders
end type

type tabpage_1 from u_tabpg_blanketordes within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from u_tabpg_blanketorderreleases within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type


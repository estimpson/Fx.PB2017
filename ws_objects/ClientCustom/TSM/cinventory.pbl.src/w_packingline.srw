$PBExportHeader$w_packingline.srw
forward
global type w_packingline from w_sheet_headerdetail_4t
end type
type tabpage_1 from u_tabpg_finishedpartlist within tab_1
end type
type tabpage_1 from u_tabpg_finishedpartlist within tab_1
end type
type tabpage_2 from cu_tabpg_jobdetails within tab_2
end type
type tabpage_2 from cu_tabpg_jobdetails within tab_2
end type
type tabpage_3 from cu_tabpg_jobobjects within tab_2
end type
type tabpage_3 from cu_tabpg_jobobjects within tab_2
end type
type tabpage_4 from cu_tabpg_jobbom within tab_2
end type
type tabpage_4 from cu_tabpg_jobbom within tab_2
end type
end forward

global type w_packingline from w_sheet_headerdetail_4t
string title = "Packing Line"
string menuname = "m_packingline"
boolean controlmenu = true
end type
global w_packingline w_packingline

on w_packingline.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_packingline" then this.MenuID = create m_packingline
end on

on w_packingline.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_packingline
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

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_packingline
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_2.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type st_1 from w_sheet_headerdetail_4t`st_1 within w_packingline
end type

type tabpage_1 from u_tabpg_finishedpartlist within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from cu_tabpg_jobdetails within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type

type tabpage_3 from cu_tabpg_jobobjects within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type

type tabpage_4 from cu_tabpg_jobbom within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type


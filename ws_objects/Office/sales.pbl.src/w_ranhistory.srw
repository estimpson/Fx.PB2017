$PBExportHeader$w_ranhistory.srw
forward
global type w_ranhistory from w_sheet_headerdetail_4t
end type
type tabpage_1 from u_tabpg_blanketordes within tab_1
end type
type tabpage_1 from u_tabpg_blanketordes within tab_1
end type
type tabpage_2 from u_tabpg_nal within tab_2
end type
type tabpage_2 from u_tabpg_nal within tab_2
end type
end forward

global type w_ranhistory from w_sheet_headerdetail_4t
string title = "Blanket Orders"
string menuname = "m_sheet_4t_updateable"
end type
global w_ranhistory w_ranhistory

on w_ranhistory.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
end on

on w_ranhistory.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetUpdateable(true)

//	Hide "New" from file menu.
m_sheet_4t_updateable sheetMenuThis
sheetMenuThis = this.menuid
sheetMenuThis.m_file.m_new.enabled = false
sheetMenuThis.m_file.m_new.toolbaritemvisible = false
sheetMenuThis.m_file.m_new.visible = false

end event

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_ranhistory
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

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_ranhistory
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

type st_1 from w_sheet_headerdetail_4t`st_1 within w_ranhistory
end type

type tabpage_1 from u_tabpg_blanketordes within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from u_tabpg_nal within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type


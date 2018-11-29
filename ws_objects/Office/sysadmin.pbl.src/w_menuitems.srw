$PBExportHeader$w_menuitems.srw
forward
global type w_menuitems from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_menuitems within tab_1
end type
type tabpage_1 from u_tabpg_menuitems within tab_1
end type
end forward

global type w_menuitems from w_sheet_tab_4t
integer width = 2523
integer height = 1740
string title = "Menu Items"
string menuname = "m_sheet_4t_updateable"
end type
global w_menuitems w_menuitems

on w_menuitems.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
end on

on w_menuitems.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
//	Enable update service.
of_SetUpdateable(true)

end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_menuitems
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

type tabpage_1 from u_tabpg_menuitems within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type


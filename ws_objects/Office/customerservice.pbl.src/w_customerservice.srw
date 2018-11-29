$PBExportHeader$w_customerservice.srw
$PBExportComments$mcs
forward
global type w_customerservice from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_customerservice_billtosetups within tab_1
end type
type tabpage_1 from u_tabpg_customerservice_billtosetups within tab_1
end type
type tabpage_2 from u_tabpg_customerservice_blanketorder_adm within tab_1
end type
type tabpage_2 from u_tabpg_customerservice_blanketorder_adm within tab_1
end type
type tabpage_3 from u_tabpg_customerservice_normalorder_adm within tab_1
end type
type tabpage_3 from u_tabpg_customerservice_normalorder_adm within tab_1
end type
end forward

global type w_customerservice from w_sheet_tab_4t
string title = "Customer Service"
string menuname = "m_sheet_4t_updateablenew"
end type
global w_customerservice w_customerservice

on w_customerservice.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateablenew" then this.MenuID = create m_sheet_4t_updateablenew
end on

on w_customerservice.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetUpdateable(true)

end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_customerservice
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
this.Control[iCurrent+3]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from u_tabpg_customerservice_billtosetups within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from u_tabpg_customerservice_blanketorder_adm within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_3 from u_tabpg_customerservice_normalorder_adm within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type


$PBExportHeader$w_locationinquiry.srw
forward
global type w_locationinquiry from w_sheet_tab_4t
end type
type tabpage_locations from u_tabpg_locationinquiry within tab_1
end type
type tabpage_locations from u_tabpg_locationinquiry within tab_1
end type
end forward

global type w_locationinquiry from w_sheet_tab_4t
string title = "Location Inquiry"
string menuname = "m_sheet_4t_updateablenew"
end type
global w_locationinquiry w_locationinquiry

on w_locationinquiry.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateablenew" then this.MenuID = create m_sheet_4t_updateablenew
end on

on w_locationinquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetUpdateable(true)

end event

event activate;call super::activate;
tab_1.tabpage_locations.Refreshing = true
tab_1.tabpage_locations.Refresh()

end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_locationinquiry
tabpage_locations tabpage_locations
end type

on tab_1.create
this.tabpage_locations=create tabpage_locations
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_locations
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_locations)
end on

type tabpage_locations from u_tabpg_locationinquiry within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type


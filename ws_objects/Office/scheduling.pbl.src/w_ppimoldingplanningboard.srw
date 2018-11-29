$PBExportHeader$w_ppimoldingplanningboard.srw
forward
global type w_ppimoldingplanningboard from w_sheet_headerdetail_4t
end type
type tabpage_headers from u_tabpg_ppimoldingschedulemachineheader within tab_1
end type
type tabpage_headers from u_tabpg_ppimoldingschedulemachineheader within tab_1
end type
type tabpage_details from u_tabpg_ppimoldingschedulemachinejobs within tab_2
end type
type tabpage_details from u_tabpg_ppimoldingschedulemachinejobs within tab_2
end type
end forward

global type w_ppimoldingplanningboard from w_sheet_headerdetail_4t
integer x = 214
integer y = 221
string title = "Molding Planning Board"
string menuname = "m_sheet_4t_updateable"
end type
global w_ppimoldingplanningboard w_ppimoldingplanningboard

on w_ppimoldingplanningboard.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateable" then this.MenuID = create m_sheet_4t_updateable
end on

on w_ppimoldingplanningboard.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_refresh;call super::pfc_refresh;
tab_1.tabpage_headers.Refresh()

end event

event pfc_save;call super::pfc_save;
post event pfc_refresh()
return tab_2.tabpage_details.dynamic Save()

end event

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_ppimoldingplanningboard
tabpage_headers tabpage_headers
end type

on tab_1.create
this.tabpage_headers=create tabpage_headers
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_headers
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_headers)
end on

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_ppimoldingplanningboard
tabpage_details tabpage_details
end type

on tab_2.create
this.tabpage_details=create tabpage_details
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_details
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_details)
end on

type st_1 from w_sheet_headerdetail_4t`st_1 within w_ppimoldingplanningboard
end type

type tabpage_headers from u_tabpg_ppimoldingschedulemachineheader within tab_1
integer x = 18
integer y = 100
integer width = 2263
integer height = 1064
end type

type tabpage_details from u_tabpg_ppimoldingschedulemachinejobs within tab_2
integer x = 18
integer y = 100
integer width = 2263
integer height = 636
end type


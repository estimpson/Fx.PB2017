$PBExportHeader$w_blanketpricechanges.srw
forward
global type w_blanketpricechanges from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_blanketpricechanges within tab_1
end type
type tabpage_1 from u_tabpg_blanketpricechanges within tab_1
end type
end forward

global type w_blanketpricechanges from w_sheet_tab_4t
string title = "Blanket Price Changes"
end type
global w_blanketpricechanges w_blanketpricechanges

on w_blanketpricechanges.create
int iCurrent
call super::create
end on

on w_blanketpricechanges.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(tab_1.x + tab_1.width, tab_1.y + tab_1.height)
inv_Resize.of_Register(tab_1, 0, 0, 100, 100)

end event

event pfc_refresh;call super::pfc_refresh;tab_1.tabpage_1.dw_1.event pfc_retrieve()
end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_blanketpricechanges
integer x = 0
integer height = 1276
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

type tabpage_1 from u_tabpg_blanketpricechanges within tab_1
integer x = 18
integer y = 100
integer width = 2263
integer height = 1160
end type


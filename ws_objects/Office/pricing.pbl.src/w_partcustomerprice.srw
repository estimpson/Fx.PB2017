$PBExportHeader$w_partcustomerprice.srw
forward
global type w_partcustomerprice from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_pricecustomer within tab_1
end type
type tabpage_1 from u_tabpg_pricecustomer within tab_1
end type
type tabpage_2 from u_tabpg_pricecustomerimport within tab_1
end type
type tabpage_2 from u_tabpg_pricecustomerimport within tab_1
end type
end forward

global type w_partcustomerprice from w_sheet_tab_4t
integer width = 2633
integer height = 1608
string title = "Part Customer Price"
end type
global w_partcustomerprice w_partcustomerprice

on w_partcustomerprice.create
int iCurrent
call super::create
end on

on w_partcustomerprice.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_SetOrigSize(tab_1.x + tab_1.width, tab_1.y + tab_1.height)
inv_Resize.of_Register(tab_1, 0, 0, 100, 100)

end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_partcustomerprice
integer width = 2103
integer height = 1244
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

type tabpage_1 from u_tabpg_pricecustomer within tab_1
integer x = 18
integer y = 100
integer width = 2066
integer height = 1128
end type

type tabpage_2 from u_tabpg_pricecustomerimport within tab_1
integer x = 18
integer y = 100
integer width = 2066
integer height = 1128
end type


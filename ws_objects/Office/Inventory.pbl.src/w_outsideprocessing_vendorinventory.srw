$PBExportHeader$w_outsideprocessing_vendorinventory.srw
forward
global type w_outsideprocessing_vendorinventory from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_outsideprocessin_vendorinventory within tab_1
end type
type tabpage_1 from u_tabpg_outsideprocessin_vendorinventory within tab_1
end type
end forward

global type w_outsideprocessing_vendorinventory from w_sheet_tab_4t
integer x = 214
integer y = 221
string title = "OP: Vendor Inventory"
end type
global w_outsideprocessing_vendorinventory w_outsideprocessing_vendorinventory

type variables

end variables

on w_outsideprocessing_vendorinventory.create
int iCurrent
call super::create
end on

on w_outsideprocessing_vendorinventory.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_tab_4t`tab_1 within w_outsideprocessing_vendorinventory
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

type tabpage_1 from u_tabpg_outsideprocessin_vendorinventory within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type


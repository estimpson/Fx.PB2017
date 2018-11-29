$PBExportHeader$w_inventoryinquiry.srw
forward
global type w_inventoryinquiry from w_sheet_tab_4t
end type
type tabpage_inventory from u_tabpg_inventoryinquiry within tab_1
end type
type tabpage_inventory from u_tabpg_inventoryinquiry within tab_1
end type
end forward

global type w_inventoryinquiry from w_sheet_tab_4t
integer x = 214
integer y = 221
string title = "Inventory Inquiry"
string menuname = "m_sheet_grid"
event pfc_cancelretrieval ( )
end type
global w_inventoryinquiry w_inventoryinquiry

event pfc_cancelretrieval;tab_1.tabpage_inventory.event retrievecancel()

end event

on w_inventoryinquiry.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_grid" then this.MenuID = create m_sheet_grid
end on

on w_inventoryinquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetUpdateable(true)

end event

type tab_1 from w_sheet_tab_4t`tab_1 within w_inventoryinquiry
tabpage_inventory tabpage_inventory
end type

on tab_1.create
this.tabpage_inventory=create tabpage_inventory
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_inventory
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_inventory)
end on

type tabpage_inventory from u_tabpg_inventoryinquiry within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

event retrievestart;call super::retrievestart;
m_sheet_grid.m_view.m_cancel.enabled = true

end event

event retrieveend;call super::retrieveend;
m_sheet_grid.m_view.m_cancel.enabled = false

end event


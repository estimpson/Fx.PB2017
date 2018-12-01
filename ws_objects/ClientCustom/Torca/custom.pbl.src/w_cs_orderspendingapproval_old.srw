$PBExportHeader$w_cs_orderspendingapproval_old.srw
forward
global type w_cs_orderspendingapproval_old from w_sheet_tab_4t
end type
type tabpage_1 from u_tabpg_cs_orderspendingapproval within tab_1
end type
type tabpage_1 from u_tabpg_cs_orderspendingapproval within tab_1
end type
end forward

global type w_cs_orderspendingapproval_old from w_sheet_tab_4t
string title = "Order Approval"
end type
global w_cs_orderspendingapproval_old w_cs_orderspendingapproval_old

on w_cs_orderspendingapproval_old.create
int iCurrent
call super::create
end on

on w_cs_orderspendingapproval_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type tab_1 from w_sheet_tab_4t`tab_1 within w_cs_orderspendingapproval_old
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

type tabpage_1 from u_tabpg_cs_orderspendingapproval within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type


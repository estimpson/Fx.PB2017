$PBExportHeader$w_receivingdock.srw
forward
global type w_receivingdock from w_sheet_headerdetail_4t
end type
type tabpage_headers from u_tabpg_receiverheaders within tab_1
end type
type tabpage_headers from u_tabpg_receiverheaders within tab_1
end type
type tabpage_1 from u_tabpg_receiverlines within tab_2
end type
type tabpage_1 from u_tabpg_receiverlines within tab_2
end type
type tabpage_2 from u_tabpg_receiverobjects within tab_2
end type
type tabpage_2 from u_tabpg_receiverobjects within tab_2
end type
end forward

global type w_receivingdock from w_sheet_headerdetail_4t
string title = "Receiving Dock"
string menuname = "m_receiving"
end type
global w_receivingdock w_receivingdock

forward prototypes
public function long getactivereceiverid ()
end prototypes

public function long getactivereceiverid ();
return tab_1.tabpage_headers._receiverID


end function

on w_receivingdock.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_receiving" then this.MenuID = create m_receiving
end on

on w_receivingdock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_save;call super::pfc_save;
tab_2.tabpage_2.Save()
return tab_1.tabpage_headers.Save()


end event

event pfc_new;call super::pfc_new;
///Refactor to ancestor?
if	IsValid(idw_active) then
	idw_active.ScrollToRow(idw_active.event pfc_addrow())
end if

end event

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_receivingdock
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

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_receivingdock
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_2.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type st_1 from w_sheet_headerdetail_4t`st_1 within w_receivingdock
end type

type tabpage_headers from u_tabpg_receiverheaders within tab_1
integer x = 18
integer y = 112
integer height = 1052
end type

type tabpage_1 from u_tabpg_receiverlines within tab_2
integer x = 18
integer y = 112
integer height = 624
end type

type tabpage_2 from u_tabpg_receiverobjects within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type


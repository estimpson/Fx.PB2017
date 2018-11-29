$PBExportHeader$w_custsrv_customermaintenance_1.srw
$PBExportComments$mcs
forward
global type w_custsrv_customermaintenance_1 from w_sheet_headerdetail_editpanel_4t
end type
type tabpage_1 from u_tabpg_customerservice_billtos within tab_1
end type
type tabpage_1 from u_tabpg_customerservice_billtos within tab_1
end type
type tabpage_2 from u_tabpg_customerservice_shiptos within tab_2
end type
type tabpage_2 from u_tabpg_customerservice_shiptos within tab_2
end type
end forward

global type w_custsrv_customermaintenance_1 from w_sheet_headerdetail_editpanel_4t
string title = "Customer Maintenance"
string menuname = "m_sheet_4t_updateablenew"
end type
global w_custsrv_customermaintenance_1 w_custsrv_customermaintenance_1

type variables

private:
u_fxdw_custsrv_billtoedit dw_billtoedit
u_fxdw_custsrv_shiptoedit dw_shiptoedit

end variables

on w_custsrv_customermaintenance_1.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateablenew" then this.MenuID = create m_sheet_4t_updateablenew
end on

on w_custsrv_customermaintenance_1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetUpdateable(true)

//	Move bill to and ship to edit screens to the panel.
OpenUserObject(dw_billtoedit, "u_fxdw_custsrv_billtoedit")
OpenUserObject(dw_shiptoedit, "u_fxdw_custsrv_shiptoedit")
uo_editpanel.AddPanelControl(dw_billtoedit)
uo_editpanel.AddPanelControl(dw_shiptoedit)

end event

event pfc_postupdate;call super::pfc_postupdate;
if	SQLCA.SQLCode = 0 then
	commit using SQLCA;
	return SUCCESS
end if
rollback using SQLCA;
return FAILURE

end event

type tab_1 from w_sheet_headerdetail_editpanel_4t`tab_1 within w_custsrv_customermaintenance_1
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

event tab_1::getfocus;call super::getfocus;
uo_editpanel.ShowControl(dw_billtoedit)

end event

type tab_2 from w_sheet_headerdetail_editpanel_4t`tab_2 within w_custsrv_customermaintenance_1
tabpage_2 tabpage_2
end type

on tab_2.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_2.destroy
call super::destroy
destroy(this.tabpage_2)
end on

event tab_2::getfocus;call super::getfocus;
uo_editpanel.ShowControl(dw_shiptoedit)

end event

type st_1 from w_sheet_headerdetail_editpanel_4t`st_1 within w_custsrv_customermaintenance_1
end type

type st_2 from w_sheet_headerdetail_editpanel_4t`st_2 within w_custsrv_customermaintenance_1
end type

type uo_editpanel from w_sheet_headerdetail_editpanel_4t`uo_editpanel within w_custsrv_customermaintenance_1
end type

type tabpage_1 from u_tabpg_customerservice_billtos within tab_1
integer x = 18
integer y = 112
integer width = 2263
integer height = 1052
end type

type tabpage_2 from u_tabpg_customerservice_shiptos within tab_2
integer x = 18
integer y = 112
integer width = 2263
integer height = 624
end type


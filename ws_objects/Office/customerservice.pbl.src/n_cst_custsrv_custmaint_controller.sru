$PBExportHeader$n_cst_custsrv_custmaint_controller.sru
forward
global type n_cst_custsrv_custmaint_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_custsrv_custmaint_controller from n_cst_virtual_controller
event billtoshavefocus ( )
event shiptoshavefocus ( )
end type
global n_cst_custsrv_custmaint_controller n_cst_custsrv_custmaint_controller

type variables

private w_custsrv_customermaintenance CustMaintWindow
private u_panel_leftright CustMaintEditPane
private u_panel_headerdetail CustMaintHeaderDetail
private u_tabpg_custsrv_custmaint_billtos CustMaintBillTos
private u_tabpg_custsrv_custmaint_shiptos CustMaintShipTos
private u_fxdw_custsrv_billtoedit CustMaintBillToEdit
private u_fxdw_custsrv_shiptoedit CustMaintShipToEdit

end variables

forward prototypes
public function integer showheaderdetail ()
public function integer refresh ()
public function integer registerwindow (ref w_custsrv_customermaintenance acustmaintwindow)
public function integer setbilltocode (string billtocode)
public function integer setshiptocode (string shiptocode)
end prototypes

event billtoshavefocus();
CustMaintEditPane.uo_2.ShowControl(CustMaintBillToEdit)

end event

event shiptoshavefocus();
CustMaintEditPane.uo_2.ShowControl(CustMaintShipToEdit)

end event

public function integer showheaderdetail ();
if	not IsValid(CustMaintWindow) or not IsValid(CustMaintWindow) then
	return FAILURE
end if

//CustMaintWindow.uo_1.ShowControl(CustMaintEditPane)
CustMaintEditPane.BringToTop = true
CustMaintHeaderDetail.BringToTop = true
CustMaintBillTos.BringToTop = true
CustMaintShipTos.BringToTop = true
CustMaintBillToEdit.BringToTop = true
CustMaintShipToEdit.BringToTop = true

return SUCCESS

end function

public function integer refresh ();
CustMaintBillTos.Refreshing = true
CustMaintBillTos.Refresh()
return SUCCESS

end function

public function integer registerwindow (ref w_custsrv_customermaintenance acustmaintwindow);
if	not IsValid(aCustMaintWindow) or IsNull(aCustMaintWindow) then
	return FAILURE
end if

CustMaintWindow = aCustMaintWindow

//	Create the header, detail, and new header controls.
CustMaintWindow.OpenUserObject(CustMaintEditPane, "u_panel_leftright")
CustMaintWindow.uo_1.AddPanelControl(CustMaintEditPane)
CustMaintWindow.uo_1.ShowControl(CustMaintEditPane)

CustMaintWindow.OpenUserObject(CustMaintHeaderDetail, "u_panel_headerdetail")
CustMaintEditPane.uo_1.AddPanelControl(CustMaintHeaderDetail)
CustMaintEditPane.uo_1.ShowControl(CustMaintHeaderDetail)

CustMaintWindow.OpenUserObject(CustMaintBillTos, "u_tabpg_custsrv_custmaint_billtos")
CustMaintHeaderDetail.uo_1.AddPanelControl(CustMaintBillTos)
CustMaintHeaderDetail.uo_1.ShowControl(CustMaintBillTos)
CustMaintBillTos.Controller = this

CustMaintWindow.OpenUserObject(CustMaintShipTos, "u_tabpg_custsrv_custmaint_shiptos")
CustMaintHeaderDetail.uo_2.AddPanelControl(CustMaintShipTos)
CustMaintHeaderDetail.uo_2.ShowControl(CustMaintShipTos)
CustMaintShipTos.Controller = this

CustMaintWindow.OpenUserObject(CustMaintBillToEdit, "u_fxdw_custsrv_billtoedit")
CustMaintEditPane.uo_2.AddPanelControl(CustMaintBillToEdit)
CustMaintEditPane.uo_2.ShowControl(CustMaintBillToEdit)
CustMaintBillToEdit.Controller = this

CustMaintWindow.OpenUserObject(CustMaintShipToEdit, "u_fxdw_custsrv_shiptoedit")
CustMaintEditPane.uo_2.AddPanelControl(CustMaintShipToEdit)
CustMaintShipToEdit.Controller = this

return SUCCESS

end function

public function integer setbilltocode (string billtocode);
if	billToCode = CustMaintShipTos.BillToCode then
	CustMaintShipTos.Refreshing = true
end if
CustMaintShipTos.BillToCode = billToCode
CustMaintShipTos.Refresh()

CustMaintBillToEdit.BillToCode = billToCode
CustMaintBillToEdit.Refresh()

return SUCCESS

end function

public function integer setshiptocode (string shiptocode);
CustMaintShipToEdit.ShipToCode = shipToCode
CustMaintShipToEdit.Refresh()

return SUCCESS

end function

on n_cst_custsrv_custmaint_controller.create
call super::create
end on

on n_cst_custsrv_custmaint_controller.destroy
call super::destroy
end on


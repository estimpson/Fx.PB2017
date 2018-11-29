$PBExportHeader$n_cst_inventory_cyclecount_controller.sru
forward
global type n_cst_inventory_cyclecount_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_inventory_cyclecount_controller from n_cst_virtual_controller
end type
global n_cst_inventory_cyclecount_controller n_cst_inventory_cyclecount_controller

type variables

private w_inventory_cyclecount CycleCountWindow
private u_tabpg_inventory_cyclecount CycleCountHeaderDetail
private u_tabpg_inventory_cyclecount_headers CycleCountHeaders
private u_tabpg_inventory_cyclecount_details CycleCountDetails
private u_tabpg_inventory_cyclecount_newheader CycleCountNewHeader
private u_tabpg_inventory_cyclecount_recover CycleCountRecover
private w_inventory_cyclecount_recoverserial_pu CycleCountRecoverSerialPopup

end variables

forward prototypes
public function integer registerwindow (ref w_inventory_cyclecount acyclecountwindow)
public function integer showheaderdetail ()
public function integer shownewheader ()
public function integer cancelnewheader ()
public function integer endnewheader ()
public function integer refresh ()
public function integer showdetails (string cyclecountnumber)
public function integer showrecoverserial ()
public function integer showrecoverserialpopup ()
public function integer hiderecoverserialpopup ()
public function integer hidedetails ()
public function integer detailsenabled (boolean enabled)
end prototypes

public function integer registerwindow (ref w_inventory_cyclecount acyclecountwindow);
if	not IsValid(aCycleCountWindow) or IsNull(aCycleCountWindow) then
	return FAILURE
end if

CycleCountWindow = aCycleCountWindow

//	Create the header, detail, and new header controls.
CycleCountWindow.OpenUserObject(CycleCountHeaderDetail, "u_tabpg_inventory_cyclecount")
CycleCountWindow.uo_1.AddPanelControl(CycleCountHeaderDetail)
CycleCountHeaderDetail.Controller = this

CycleCountWindow.OpenUserObject(CycleCountNewHeader, "u_tabpg_inventory_cyclecount_newheader")
CycleCountWindow.uo_1.AddPanelControl(CycleCountNewHeader)
CycleCountNewHeader.Controller = this

CycleCountWindow.OpenUserObject(CycleCountHeaders, "u_tabpg_inventory_cyclecount_headers")
CycleCountHeaderDetail.uo_1.AddPanelControl(CycleCountHeaders)
CycleCountHeaderDetail.uo_1.post ShowControl(CycleCountHeaders)
CycleCountHeaders.Controller = this

CycleCountWindow.OpenUserObject(CycleCountDetails, "u_tabpg_inventory_cyclecount_details")
CycleCountHeaderDetail.uo_2.AddPanelControl(CycleCountDetails)
CycleCountHeaderDetail.uo_2.post ShowControl(CycleCountDetails)
CycleCountDetails.Controller = this

return SUCCESS

end function

public function integer showheaderdetail ();
if	not IsValid(CycleCountWindow) or not IsValid(CycleCountHeaderDetail) then
	return FAILURE
end if

CycleCountWindow.uo_1.ShowControl(CycleCountHeaderDetail)
CycleCountHeaders.BringToTop = true
CycleCountDetails.BringToTop = true
return SUCCESS

end function

public function integer shownewheader ();
if	not IsValid(CycleCountWindow) or not IsValid(CycleCountNewHeader) then
	return FAILURE
end if

CycleCountWindow.uo_1.ShowControl(CycleCountNewHeader)
return SUCCESS

end function

public function integer cancelnewheader ();
return ShowHeaderDetail()

end function

public function integer endnewheader ();
ShowHeaderDetail()
return CycleCountHeaders.Refresh()


end function

public function integer refresh ();
CycleCountHeaders.Refreshing = true
CycleCountHeaders.Refresh()
return SUCCESS

end function

public function integer showdetails (string cyclecountnumber);
if	cycleCountNumber = CycleCountDetails.CycleCountNumber then
	CycleCountDetails.Refreshing = true
end if
CycleCountDetails.CycleCountNumber = CycleCountNumber
return CycleCountDetails.Refresh()

end function

public function integer showrecoverserial ();
if	not IsValid(CycleCountRecoverSerialPopup) then
	return FAILURE
end if

CycleCountRecoverSerialPopup.OpenUserObject(CycleCountRecover, "u_tabpg_inventory_cyclecount_recover")
CycleCountRecoverSerialPopup.uo_1.AddPanelControl(CycleCountRecover)
n_cst_inventory_cyclecount_controller uThis
uThis = this
CycleCountRecover.Controller = uThis
CycleCountRecover.CycleCountNumber = CycleCountDetails.CycleCountNumber
CycleCountRecoverSerialPopup.uo_1.ShowControl(CycleCountRecover)

return SUCCESS

end function

public function integer showrecoverserialpopup ();
if	not IsValid(CycleCountWindow) then
	return FAILURE
end if

n_cst_inventory_cyclecount_controller uThis
uThis = this
OpenWithParm(CycleCountRecoverSerialPopup, uThis, "w_inventory_cyclecount_recoverserial_pu", CycleCountWindow)
return SUCCESS

end function

public function integer hiderecoverserialpopup ();
if	not IsValid(CycleCountRecoverSerialPopup) then
	return FAILURE
end if

Close(CycleCountRecoverSerialPopup)
Refresh()
return SUCCESS

end function

public function integer hidedetails ();
CycleCountDetails.Refreshing = false
CycleCountDetails.CycleCountNumber = ""
return CycleCountDetails.Refresh()

end function

public function integer detailsenabled (boolean enabled);
if	not IsValid(CycleCountDetails) or IsNull(CycleCountDetails) then
	return FAILURE
end if

CycleCountDetails.SetEnabled(Enabled)
return SUCCESS

end function

on n_cst_inventory_cyclecount_controller.create
call super::create
end on

on n_cst_inventory_cyclecount_controller.destroy
call super::destroy
end on


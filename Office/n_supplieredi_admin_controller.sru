HA$PBExportHeader$n_supplieredi_admin_controller.sru
forward
global type n_supplieredi_admin_controller from n_cst_virtual_controller
end type
end forward

global type n_supplieredi_admin_controller from n_cst_virtual_controller
end type
global n_supplieredi_admin_controller n_supplieredi_admin_controller

type variables

private:

//	Model data.
string _vendorCode

//	View references.
u_panel_leftright _vendorListDetailsSplitter
u_tabpg_supplieredi_admin_vendorlist _vendorListView
u_fxdw_supplieredi_admin_vendorsetup _vendorSetupView
u_tabpg_supplieredi_admin_vendorpolist _vendorPOListView
u_tabpg_supplieredi_admin_vendorlist _vendorPartListView
u_tab_4t _vendorDetailsView

w_supplieredi_admin _parentSheet

//	Data context.
n_supplieredi_admin_trans _supplierEDIAdminTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer createlayout ()
public function integer showcontrols ()
public function integer refresh ()
public function integer setactivevendor (string vendorcode)
public function integer savevendoredistatus (string vendorcode, long newstatus)
public function integer clearvendor (string vendorcode)
public function integer setblanketporeleaseplanstatus (long ponumber, long newstatus)
public function integer sendtestreleaseplan (long ponumber)
end prototypes

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

_parentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

//	Link up frame controller for control of scanning.
GetFrameController()

return SUCCESS

end function

public function integer createlayout ();
//	Vendor List - Vendor Details Split View
_parentSheet.OpenUserObject(_vendorListDetailsSplitter, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_vendorListDetailsSplitter)
_vendorListDetailsSplitter.uo_2.AddPanelControlGroup("ActiveVendor", n_panelcontrolgroup.VERTICAL)

//	Vendor List View
_parentSheet.OpenUserObject(_vendorListView, "u_tabpg_supplieredi_admin_vendorlist")
_vendorListDetailsSplitter.uo_1.AddPanelControl(_vendorListView)

//	Vendor Setup View
_parentSheet.OpenUserObject(_vendorSetupView, "u_fxdw_supplieredi_admin_vendorsetup")
_vendorListDetailsSplitter.uo_2.AddPanelControlToGroup("ActiveVendor", _vendorSetupView, _vendorSetupView.Width, _vendorSetupView.Height)

//	Vendor Details Tab View
_parentSheet.OpenUserObject(_vendorDetailsView, "u_tab_4t")
_vendorListDetailsSplitter.uo_2.AddPanelControlToGroup("ActiveVendor", _vendorDetailsView, _vendorDetailsView.Width, -1)
_vendorDetailsView.OpenTab(_vendorPOListView, "u_tabpg_supplieredi_admin_vendorpolist", 1)
//_vendorDetailsView.OpenTab(_vendorPartListView, "u_tabpg_supplieredi_admin_vendorlist", 2)
_vendorDetailsView.SelectTab(1)

 //	Show controls
post ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_vendorListDetailsSplitter)
_vendorListDetailsSplitter.uo_1.ShowControl(_vendorListView)
_vendorListDetailsSplitter.uo_2.ShowControlGroup("ActiveVendor")

return SUCCESS

end function

public function integer refresh ();
_vendorListView.Refresh()

return SUCCESS


end function

public function integer setactivevendor (string vendorcode);
_vendorCode = vendorCode
_vendorSetupView.SetVendorCode(_vendorCode)
_vendorPOListView.SetVendorCode(_vendorCode)
return SUCCESS

end function

public function integer savevendoredistatus (string vendorcode, long newstatus);
if	not IsValid(_supplierEDIAdminTrans) then return FAILURE

if	_supplierEDIAdminTrans.SetVendorStatus (_vendorCode, newStatus) <> SUCCESS then
	return FAILURE
end if

_supplierEDIAdminTrans.CommitTrans()
return SUCCESS

end function

public function integer clearvendor (string vendorcode);
if	not IsValid(_supplierEDIAdminTrans) then return FAILURE

if	_supplierEDIAdminTrans.ClearVendor (_vendorCode) <> SUCCESS then
	return FAILURE
end if

_supplierEDIAdminTrans.CommitTrans()
return SUCCESS

end function

public function integer setblanketporeleaseplanstatus (long ponumber, long newstatus);
if	not IsValid(_supplierEDIAdminTrans) then return FAILURE

if	_supplierEDIAdminTrans.SetBlanketPOReleasePlanStatus(poNumber, newStatus) <> SUCCESS then
	return FAILURE
end if

_supplierEDIAdminTrans.CommitTrans()
return SUCCESS

end function

public function integer sendtestreleaseplan (long ponumber);
if	not IsValid(_supplierEDIAdminTrans) then return FAILURE

string fileList
if	_supplierEDIAdminTrans.SendReleasePlanTest(_vendorCode, poNumber, fileList) = SUCCESS then

	MsgBox("EDI sent successfully: " + fileList)
	return SUCCESS
end if

return FAILURE

end function

on n_supplieredi_admin_controller.create
call super::create
end on

on n_supplieredi_admin_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_supplierEDIAdminTrans = create n_supplieredi_admin_trans

end event

event destructor;call super::destructor;
destroy _supplierEDIAdminTrans

end event


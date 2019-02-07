HA$PBExportHeader$n_packaging_bulk_controller.sru
forward
global type n_packaging_bulk_controller from n_cst_virtual_controller
end type
end forward

global type n_packaging_bulk_controller from n_cst_virtual_controller
end type
global n_packaging_bulk_controller n_packaging_bulk_controller

type variables

private:

//	View references.
u_panel_headerdetail _headerDetailView
u_tabpg_packaging_bulk_master _masterView
u_tab_packaging_bulk_packagedetails _packagingDetailTabView
u_tabpg_packaging_bulk_shiptos _shipTosView
u_tabpg_packaging_bulk_history _historyView
u_tabpg_packaging_bulk_shipto _shiptoViews[]
u_fxdw_packaging_bulktracking_enableedit _enableEditView
u_fxdw_packaging_bulktracking_receive _receiveEditView
u_fxdw_packaging_bulktracking_ship _shipEditView
u_fxdw_packaging_bulktracking_adjustqty _adjustQuantityEditView
u_fxdw_packaging_bulktracking_adjustst _adjustQuantityShipToEditView

w_packaging_bulk _parentSheet

//	Model data.
string _packageCode
string _destinationCode

//	Data context.
n_packaging_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setpackagecode (string packagecode)
public function integer cancelenabletracking ()
public function integer showenabletracking ()
public function integer disabletracking ()
public function integer showreceive ()
public function integer canceladjustquantity ()
public function integer cancelreceive ()
public function integer closeeditviews ()
public function integer enableshipto (string packagecode, string destinationcode)
public function integer disableshipto (string packagecode, string destinationcode)
public function integer setdestinationcode (string destinationcode)
public function integer showship ()
public function integer showadjustshipto ()
public function integer receive (string packagecode, string destinationcode, string manifestnumber, long receivequantity, datetime receiptdt)
public function integer ship (string packagecode, string destinationcode, string manifestnumber, long shipquantity, datetime shipmentdt)
public function integer adjustshiptoquantity (string packagecode, string destinationcode, long netqtyadjustment)
public function integer showadjustinhouse ()
public function integer adjustinhousequantity (string packagecode, long netqtyadjustment)
public function integer enabletracking (string packagecode, long startinginhousequantity, datetime startingaccumdt)
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

public function integer showcontrols ();

//	Show controls.
_parentSheet.uo_1.ShowControl(_headerDetailView)
_headerDetailView.uo_1.ShowControl(_masterView)
_headerDetailView.uo_2.ShowControl(_packagingDetailTabView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_headerDetailView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailView)

//	Master view.
_parentSheet.OpenUserObject(_masterView, "u_tabpg_packaging_bulk_master")
_headerDetailView.uo_1.AddPanelControl(_masterView)
MasterListControl = _masterView

//	Purchase part tab view.
_parentSheet.OpenUserObject(_packagingDetailTabView, "u_tab_packaging_bulk_packagedetails")
	//	Ship tos view.
	_packagingDetailTabView.OpenTab(_shipTosView, "u_tabpg_packaging_bulk_shiptos", 1)
	_shipTosView.Text = "Ship Tos"
	
	//	History view.
	_packagingDetailTabView.OpenTab(_historyView, "u_tabpg_packaging_bulk_history", 2)
	_historyView.Text = "History"
	
_packagingDetailTabView.SelectTab(2)
_headerDetailView.uo_2.AddPanelControl(_packagingDetailTabView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _masterView.Refresh()

end function

public function integer setpackagecode (string packagecode);
_packageCode = packageCode
_shipTosView.SetPackageCode(_packageCode)
_historyView.SetPackageCode(_packageCode)

//	Close any tab pages past the second and reopen one for each active destination.
_packagingDetailTabView.SelectTab(2)
string destinationCodes[]

int	i, tabCount
tabCount = UpperBound(_shiptoViews)
for	i = 1 to tabCount
	_packagingDetailTabView.CloseTab(_shiptoViews[i])
next
u_tabpg_4t emptyList[]
_shiptoViews = emptyList

n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.GetActiveShipTos(packageCode, destinationCodes) = SUCCESS then
	tabCount = UpperBound(destinationCodes)
	for	i = 1 to tabCount
		_packagingDetailTabView.OpenTab(_shiptoViews[i], "u_tabpg_packaging_bulk_shipto", i+2)
		_shiptoViews[i].SetPackageCodeShipTo(_packageCode, destinationCodes[i])
	next
end if

destroy Trans_Packaging

string nullString; SetNull(nullString)
return SetDestinationCode(nullString)

end function

public function integer cancelenabletracking ();
if	IsValid(_enableEditView) then
	_parentSheet.CloseUserObject(_enableEditView)
end if

ShowControls()
return Refresh()


end function

public function integer showenabletracking ();
CloseEditViews()

//	Enable Edit view.
_parentSheet.OpenUserObject(_enableEditView, "u_fxdw_packaging_bulktracking_enableedit")
_enableEditView.SetPackageCode(_packageCode)
_parentSheet.uo_1.AddPanelControl(_enableEditView)
_parentSheet.uo_1.ShowControl(_enableEditView)

return SUCCESS

end function

public function integer disabletracking ();
if	IsValid(_enableEditView) then
	_parentSheet.CloseUserObject(_enableEditView)
end if

//	Enable Edit view.
_parentSheet.OpenUserObject(_enableEditView, "u_fxdw_packaging_bulktracking_enableedit")
_enableEditView.SetPackageCode(_packageCode)
_parentSheet.uo_1.AddPanelControl(_enableEditView)
_parentSheet.uo_1.ShowControl(_enableEditView)

return SUCCESS

end function

public function integer showreceive ();
CloseEditViews()

//	Enable Edit view.
_parentSheet.OpenUserObject(_receiveEditView, "u_fxdw_packaging_bulktracking_receive")
_receiveEditView.SetPackageCodeDestinationCode(_packageCode, _destinationCode)
_parentSheet.uo_1.AddPanelControl(_receiveEditView)
_parentSheet.uo_1.ShowControl(_receiveEditView)

return SUCCESS

end function

public function integer canceladjustquantity ();
if	IsValid(_adjustQuantityEditView) then
	_parentSheet.CloseUserObject(_adjustQuantityEditView)
end if

ShowControls()
return Refresh()


end function

public function integer cancelreceive ();
if	IsValid(_receiveEditView) then
	_parentSheet.CloseUserObject(_receiveEditView)
end if

ShowControls()
return Refresh()


end function

public function integer closeeditviews ();
if	IsValid(_enableEditView) then
	_parentSheet.CloseUserObject(_enableEditView)
end if
if	IsValid(_receiveEditView) then
	_parentSheet.CloseUserObject(_receiveEditView)
end if
if	IsValid(_shipEditView) then
	_parentSheet.CloseUserObject(_shipEditView)
end if
if	IsValid(_adjustQuantityEditView) then
	_parentSheet.CloseUserObject(_adjustQuantityEditView)
end if
if	IsValid(_adjustQuantityShipToEditView) then
	_parentSheet.CloseUserObject(_adjustQuantityShipToEditView)
end if

return SUCCESS

end function

public function integer enableshipto (string packagecode, string destinationcode);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.EnableShipTo(packageCode, destinationCode) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()


end function

public function integer disableshipto (string packagecode, string destinationcode);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.DisableShipTo(packageCode, destinationCode) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()


end function

public function integer setdestinationcode (string destinationcode);
_destinationCode = destinationCode

return SUCCESS

end function

public function integer showship ();
CloseEditViews()

//	Enable Edit view.
_parentSheet.OpenUserObject(_shipEditView, "u_fxdw_packaging_bulktracking_ship")
_shipEditView.SetPackageCodeDestinationCode(_packageCode, _destinationCode)
_parentSheet.uo_1.AddPanelControl(_shipEditView)
_parentSheet.uo_1.ShowControl(_shipEditView)

return SUCCESS

end function

public function integer showadjustshipto ();
CloseEditViews()

//	Enable Edit view.
_parentSheet.OpenUserObject(_adjustQuantityShipToEditView, "u_fxdw_packaging_bulktracking_adjustst")
_adjustQuantityShipToEditView.SetPackageCodeShipToCode(_packageCode, _destinationCode)
_parentSheet.uo_1.AddPanelControl(_adjustQuantityShipToEditView)
_parentSheet.uo_1.ShowControl(_adjustQuantityShipToEditView)

return SUCCESS

end function

public function integer receive (string packagecode, string destinationcode, string manifestnumber, long receivequantity, datetime receiptdt);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.Receive(packageCode, destinationCode, manifestNumber, receiveQuantity, receiptDT) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()

end function

public function integer ship (string packagecode, string destinationcode, string manifestnumber, long shipquantity, datetime shipmentdt);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.Ship(packageCode, destinationCode, manifestNumber, shipQuantity, shipmentDT) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()

end function

public function integer adjustshiptoquantity (string packagecode, string destinationcode, long netqtyadjustment);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.AdjustShipToQuantity(packageCode, destinationCode, netQtyAdjustment) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()


end function

public function integer showadjustinhouse ();
CloseEditViews()

//	Enable Edit view.
_parentSheet.OpenUserObject(_adjustQuantityEditView, "u_fxdw_packaging_bulktracking_adjustqty")
_adjustQuantityEditView.SetPackageCode(_packageCode)
_parentSheet.uo_1.AddPanelControl(_adjustQuantityEditView)
_parentSheet.uo_1.ShowControl(_adjustQuantityEditView)

return SUCCESS

end function

public function integer adjustinhousequantity (string packagecode, long netqtyadjustment);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.AdjustInHouseQuantity(packageCode, netQtyAdjustment) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()


end function

public function integer enabletracking (string packagecode, long startinginhousequantity, datetime startingaccumdt);
//	Begin departure.
n_packaging_trans Trans_Packaging
Trans_Packaging = create n_packaging_trans
if	Trans_Packaging.EnableBulkTracking(packageCode, startingInHouseQuantity, startingInHouseQuantity, 0, startingAccumDT) = SUCCESS then
	Trans_Packaging.CommitTrans()
end if
destroy Trans_Packaging

CloseEditViews()

ShowControls()
return Refresh()


end function

on n_packaging_bulk_controller.create
call super::create
end on

on n_packaging_bulk_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_packaging_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


$PBExportHeader$n_cst_shipping_controller.sru
forward
global type n_cst_shipping_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_shipping_controller from n_cst_virtual_controller
end type
global n_cst_shipping_controller n_cst_shipping_controller

type variables

private:

//	Model data.
string _shipperNumber

//	View references.
u_panel_headerdetail _headerDetailPanel
u_panel_headerdetail _shipperHeaderDetailPanel
u_tabpg_shipping_openshipperlist _openShipperListView
u_tabpg_shipping_activeedishipperlist _activeEDIShipperListView

u_panel_leftright _departingShippersSplitView
u_fxdw_shipping_departingshippers _departingShippersView

u_panel_headerdetail _departedShippersSplitView
u_tabpg_shipping_activeedishipperlist _departedShippersView

u_fxdw_shipping_beginshipoutedit _editShippingDataView
u_fxdw_shipping_overridescanning _overrideScanningView
u_tabpg_shipping_showlistedshippers _listedShippersView
u_tabpg_shipping_requiresrelabel _shipperDetailRequiresRelabelView

w_shippingdock _parentSheet

//	View mode.
boolean _beginningShipout = false
boolean _beginningScanningOverride = false
boolean _activeDepartures = false
boolean _activeDeparted = false

//	Refresh urgency.
constant int MAXSECONDSBETWEENOPENSHIPPERLISTREFRESH = 30
constant int MAXSECONDSBETWEENDEPARTURESHIPPERLISTREFRESH = 5
constant int MAXSECONDSBETWEENDEPARTEDSHIPPERLISTREFRESH = 30

dec{6} _openShipperListRefreshUrgency = 0
dec{6} _departureShipperListRefreshUrgency = 0
dec{6} _departedShipperListRefreshUrgency = 0

end variables

forward prototypes
public function integer showheaderdetail ()
public function integer createlayout ()
public function integer showbeginshipout (string shipperlist)
public function integer cancelbeginshipout ()
public function integer beginshipout (string shipperlist, string operatorcode, string trucknumber, string pronumber)
public function integer windowtimerticked ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer refresh ()
public function integer refreshdepartingshippers ()
public function integer canceldeparture (string shipperlist)
public function integer completeshipout (string shipperlist, string pronumber)
public function integer edittruckpronumbers (string trucknumber)
public function integer canceloverridescanning ()
public function integer overridescanning (string shipperlist, string operator)
public function integer showbeginoverridescanning (string shipperlist)
public function integer printlabel (long serialnumber, string labelformat)
public function integer setshippernumber (string shippernumber, boolean requiresrelabel)
public function integer refreshdepartedshippers ()
public function integer handleasnexception (long shipperid, string exceptionhandler)
public function integer reprintpackingslips (string shipperlist)
public function integer printpacklist (long shipperid, string packlistformat)
public function integer printpackingslips (string shipperlist)
end prototypes

public function integer showheaderdetail ();
return NO_ACTION

end function

public function integer createlayout ();
//	Create editable control(s) for each panel (example, override).
_parentSheet.OpenUserObject(_departingShippersSplitView, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_departingShippersSplitView)

//	Create header detail for shipper.
_parentSheet.OpenUserObject(_shipperHeaderDetailPanel, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_shipperHeaderDetailPanel) // For full screen mode.
_departingShippersSplitView.uo_1.AddPanelControl(_shipperHeaderDetailPanel) // For partial screen mode when there is a departing truck.

//	Create controls for handling departed shippers.
_parentSheet.OpenUserObject(_departedShippersSplitView, "u_panel_headerdetail")
_shipperHeaderDetailPanel.uo_1.AddPanelControl(_departedShippersSplitView)

//	Create editable control(s) for each panel (example, override).
_parentSheet.OpenUserObject(_openShipperListView, "u_tabpg_shipping_openshipperlist")
_openShipperListView.Controller = this
_shipperHeaderDetailPanel.uo_1.AddPanelControl(_openShipperListView)
_departedShippersSplitView.uo_1.AddPanelControl(_openShipperListView)
MasterListControl = _openShipperListView
MainControl = _openShipperListView

//	Create relabel details view.
_parentSheet.OpenUserObject(_shipperDetailRequiresRelabelView, "u_tabpg_shipping_requiresrelabel")
_shipperDetailRequiresRelabelView.Controller = this
_shipperHeaderDetailPanel.uo_2.AddPanelControl(_shipperDetailRequiresRelabelView)

//	Create editable control(s) for each panel (example, override).
_parentSheet.OpenUserObject(_departingShippersView, "u_fxdw_shipping_departingshippers")
_departingShippersView.Controller = this
_departingShippersSplitView.uo_2.AddPanelControl(_departingShippersView)

//	Create controls for handling departed shippers.
_parentSheet.OpenUserObject(_departedShippersSplitView, "u_panel_headerdetail")
_shipperHeaderDetailPanel.uo_1.AddPanelControl(_departedShippersSplitView)

_parentSheet.OpenUserObject(_departedShippersView, "u_tabpg_shipping_activeedishipperlist")
_departedShippersView.Controller = this
_departedShippersSplitView.uo_2.AddPanelControl(_departedShippersView)

//	Create editable control(s) for each panel (example, override).
_parentSheet.OpenUserObject(_headerDetailPanel, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailPanel)

//	Create editable control(s) for each panel (example, override).
_parentSheet.OpenUserObject(_editShippingDataView, "u_fxdw_shipping_beginshipoutedit")
_editShippingDataView.Controller = this
_headerDetailPanel.uo_1.AddPanelControl(_editShippingDataView)

//	Create editable control(s) for each panel (example, override).
_parentSheet.OpenUserObject(_listedShippersView, "u_tabpg_shipping_showlistedshippers")
_listedShippersView.Controller = this
_headerDetailPanel.uo_2.AddPanelControl(_listedShippersView)

_shipperHeaderDetailPanel.uo_1.ShowControl(_openShipperListView)
_shipperHeaderDetailPanel.uo_2.ShowControl(_shipperDetailRequiresRelabelView)

return SUCCESS

end function

public function integer showbeginshipout (string shipperlist);
if	not IsValid(_headerDetailPanel) or not IsValid(_editShippingDataView) or not IsValid(_listedShippersView) then
	return FAILURE
end if

//	Show begin shipout views.
_editShippingDataView.SetShipperList(shipperList)
_headerDetailPanel.uo_1.ShowControl(_editShippingDataView)
_listedShippersView.SetShipperList(shipperList)
_headerDetailPanel.uo_2.ShowControl(_listedShippersView)
_parentSheet.uo_1.ShowControl(_headerDetailPanel)
_beginningShipout = true

return SUCCESS

end function

public function integer cancelbeginshipout ();
if	not IsValid(_headerDetailPanel) or not IsValid(_openShipperListView) then
	return FAILURE
end if

//	Show open shipper list view.
_beginningShipout = false

if	_activeDepartures then
	_parentSheet.uo_1.ShowControl(_departingShippersSplitView)
	_departingShippersSplitView.uo_1.ShowControl(_openShipperListView)
	_departingShippersSplitView.uo_2.ShowControl(_departingShippersView)
else
	_parentSheet.uo_1.ShowControl(_openShipperListView)
end if

Refresh()

return SUCCESS

end function

public function integer beginshipout (string shipperlist, string operatorcode, string trucknumber, string pronumber);
if	not IsValid(_headerDetailPanel) or not IsValid(_openShipperListView) then
	return FAILURE
end if

//	Begin departure.
n_cst_trans_shipping Trans_Shipping
Trans_Shipping = create n_cst_trans_shipping
if	Trans_Shipping.BeginShipperListDeparture(operatorCode, shipperList, truckNumber, proNumber) = SUCCESS then
	Trans_Shipping.CommitTrans()
end if
destroy Trans_Shipping

//	Show open shipper list view.
_beginningShipout = false

if	_activeDepartures then
	_parentSheet.uo_1.ShowControl(_departingShippersSplitView)
	_departingShippersSplitView.uo_1.ShowControl(_openShipperListView)
	_departingShippersSplitView.uo_2.ShowControl(_departingShippersView)
else
	_parentSheet.uo_1.ShowControl(_openShipperListView)
end if

Refresh()

return SUCCESS

end function

public function integer windowtimerticked ();
_departedShipperListRefreshUrgency += 1.0 / MAXSECONDSBETWEENDEPARTEDSHIPPERLISTREFRESH
if	_departedShipperListRefreshUrgency >= 1 then
	RefreshDepartedShippers()
end if

if	_activeDepartures then
	_departureShipperListRefreshUrgency += 1.0 / MAXSECONDSBETWEENDEPARTURESHIPPERLISTREFRESH
	if	_departureShipperListRefreshUrgency >= 1 then
		RefreshDepartingShippers()
	end if
end if

_openShipperListRefreshUrgency += 1.0 / MAXSECONDSBETWEENOPENSHIPPERLISTREFRESH
if	_openShipperListRefreshUrgency >= 1 then
	_openShipperListRefreshUrgency = 0
	Refresh()
end if
_parentSheet.ShowRefreshUrgency(_openShipperListRefreshUrgency)

return SUCCESS


end function

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

_parentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

return SUCCESS

end function

public function integer refresh ();
if	_beginningShipout then return NO_ACTION

_openShipperListRefreshUrgency = 0
RefreshDepartingShippers()
RefreshDepartedShippers()
return super::Refresh()

end function

public function integer refreshdepartingshippers ();
_departureShipperListRefreshUrgency = 0
if	not IsValid(_departingShippersSplitView) or not IsValid(_openShipperListView) or not IsValid(_departingShippersView) then
	return FAILURE
end if

long departingShipperCount
departingShipperCount = _departingShippersView.Refresh()

if	departingShipperCount > 0 and not _activeDepartures then
	_parentSheet.uo_1.ShowControl(_departingShippersSplitView)
	_departingShippersSplitView.uo_1.ShowControl(_shipperHeaderDetailPanel)
	_departingShippersSplitView.uo_2.ShowControl(_departingShippersView)
	_activeDepartures = true
elseif departingShipperCount = 0 then
	_parentSheet.uo_1.ShowControl(_shipperHeaderDetailPanel)
	_activeDepartures = false
end if

return SUCCESS

end function

public function integer canceldeparture (string shipperlist);
//	Perform cancelation of departure for listed shippers.
n_cst_trans_shipping Trans_Shipping

Trans_Shipping = create n_cst_trans_shipping

if	Trans_Shipping.CancelShipperListDeparture(shipperList) = SUCCESS then
	Trans_Shipping.CommitTrans()
end if

destroy Trans_Shipping

return RefreshDepartingShippers()

end function

public function integer completeshipout (string shipperlist, string pronumber);
//	Perform completion of departure for listed shippers.
n_cst_trans_shipping Trans_Shipping

Trans_Shipping = create n_cst_trans_shipping

if	Trans_Shipping.CompleteShipperListDeparture(shipperList, proNumber) = SUCCESS then
	Trans_Shipping.CommitTrans()
else
	Trans_Shipping.RollbackTrans()
	destroy Trans_Shipping
	
	return FAILURE
end if

long shipperIDs[]

if	Trans_Shipping.GetASNsRequiredForShipperList(shipperList, ref shipperIDs) = SUCCESS then
	Trans_Shipping.CommitTrans()
	
	int i
	for	i = 1 to UpperBound(shipperIDs)
	
		//	Generate ASN.
		w_asn_file_generator_v2 asnWindow[]
		OpenSheetWithParm (asnWindow[i], shipperIDs[i], "w_asn_file_generator_v2", gnv_App.of_GetFrame(), 3, Original!)
		
	next
else
	Trans_Shipping.RollbackTrans()
	destroy Trans_Shipping
	
	return FAILURE	
end if

destroy Trans_Shipping

return RefreshDepartingShippers()

end function

public function integer edittruckpronumbers (string trucknumber);
return OpenWithParm(w_shippingdock_edittruckpronumbers, truckNumber)

end function

public function integer canceloverridescanning ();
if	not IsValid(_headerDetailPanel) or not IsValid(_openShipperListView) then
	return FAILURE
end if

//	Show open shipper list view.
_beginningScanningOverride = false

if	_activeDepartures then
	_parentSheet.uo_1.ShowControl(_departingShippersSplitView)
	_departingShippersSplitView.uo_1.ShowControl(_openShipperListView)
	_departingShippersSplitView.uo_2.ShowControl(_departingShippersView)
else
	_parentSheet.uo_1.ShowControl(_openShipperListView)
end if

_parentSheet.CloseUserObject(_overrideScanningView)
Refresh()

return SUCCESS

end function

public function integer overridescanning (string shipperlist, string operator);
//	Perform overrice of scanning for listed shippers.
n_cst_trans_shipping Trans_Shipping

Trans_Shipping = create n_cst_trans_shipping

if	Trans_Shipping.OverrideScanning(operator, shipperList) = SUCCESS then
	Trans_Shipping.CommitTrans()
end if

destroy Trans_Shipping

//	Show open shipper list view.
_beginningScanningOverride = false

if	_activeDepartures then
	_parentSheet.uo_1.ShowControl(_departingShippersSplitView)
	_departingShippersSplitView.uo_1.ShowControl(_openShipperListView)
	_departingShippersSplitView.uo_2.ShowControl(_departingShippersView)
else
	_parentSheet.uo_1.ShowControl(_openShipperListView)
end if

_parentSheet.CloseUserObject(_overrideScanningView)
Refresh()

return SUCCESS

end function

public function integer showbeginoverridescanning (string shipperlist);
if	not IsValid(_headerDetailPanel) or not IsValid(_editShippingDataView) or not IsValid(_listedShippersView) then
	return FAILURE
end if

//	Show begin shipout views.
_parentSheet.OpenUserObject(_overrideScanningView, "u_fxdw_shipping_overridescanning")
_overrideScanningView.Controller = this
_parentSheet.uo_1.AddPanelControl(_overrideScanningView)

_overrideScanningView.SetShipperList(shipperList)
_parentSheet.uo_1.ShowControl(_overrideScanningView)
_beginningScanningOverride = true

return SUCCESS

end function

public function integer printlabel (long serialnumber, string labelformat);
//Print Labels
if	labelFormat > "" then
	n_cst_associative_array	printerParm
	printerParm.of_SetItem ( "Arg1", serialNumber)
	printerParm.of_SetItem ( "Report", "Label" )
	printerParm.of_SetItem ( "Name", labelFormat )
	return Print(printerParm)
end if

return NO_ACTION

end function

public function integer setshippernumber (string shippernumber, boolean requiresrelabel);
if	requiresRelabel then
	return _shipperDetailRequiresRelabelView.SetShipperNumber(shipperNumber)
end if

return _shipperDetailRequiresRelabelView.Reset()

end function

public function integer refreshdepartedshippers ();
_departedShipperListRefreshUrgency = 0
if	not IsValid(_departedShippersSplitView) or not IsValid(_openShipperListView) or not IsValid(_departedShippersView) then
	return FAILURE
end if

long departedShipperCount
departedShipperCount = _departedShippersView.Refresh()

if	departedShipperCount > 0 and not _activeDeparted then
	_shipperHeaderDetailPanel.uo_1.ShowControl(_departedShippersSplitView)
	_departedShippersSplitView.uo_1.ShowControl(_openShipperListView)
	_departedShippersSplitView.uo_2.ShowControl(_departedShippersView)
	_activeDeparted = true
elseif departedShipperCount = 0 then
	_shipperHeaderDetailPanel.uo_1.ShowControl(_openShipperListView)
	_activeDeparted = false
end if

return SUCCESS

end function

public function integer handleasnexception (long shipperid, string exceptionhandler);
gnv_App.inv_Global.of_SetItem("ShipperID", shipperID)
gnv_App.inv_Global.of_SetItem("ExceptionHandler", exceptionHandler)

OpenSheet(w_shippingdock_asnexceptionhandler, gnv_app.of_GetFrame(), 1, Original!)

return SUCCESS

end function

public function integer reprintpackingslips (string shipperlist);
//	Reprint packing slips as necessary.
n_cst_trans_shipping Trans_Shipping

Trans_Shipping = create n_cst_trans_shipping

string shipperNumbers[], packListFormats[]
long shipperIDs[]

if	Trans_Shipping.GetShippersRequiringReprint(shipperList, shipperNumbers, shipperIDs, packListFormats) = SUCCESS then
	Trans_Shipping.CommitTrans()
end if

destroy Trans_Shipping

int i
for	i = 1 to UpperBound(shipperIDs)
	PrintPackList(shipperIDs[i], packListFormats[i])
next

return Refresh()

end function

public function integer printpacklist (long shipperid, string packlistformat);
//	Print packing list.
long printReturn
if	packListFormat > "" then
	n_cst_associative_array	printerParm
	printerParm.of_SetItem ( "Arg1", shipperID)
	printerParm.of_SetItem ( "Report", packListFormat)
	printReturn = Print(printerParm)
end if

if	printReturn = 1 then
	n_cst_trans_shipping Trans_Shipping
	
	Trans_Shipping = create n_cst_trans_shipping
	
	if	Trans_Shipping.MarkPacklistPrinted(shipperID) = SUCCESS then
		Trans_Shipping.CommitTrans()
	end if
	
	destroy Trans_Shipping
end if

return printReturn

end function

public function integer printpackingslips (string shipperlist);
//	Reprint packing slips as necessary.
n_cst_trans_shipping Trans_Shipping

Trans_Shipping = create n_cst_trans_shipping

string shipperNumbers[], packListFormats[]
long shipperIDs[]

if	Trans_Shipping.GetShippersPackingSlips(shipperList, shipperNumbers, shipperIDs, packListFormats) = SUCCESS then
	Trans_Shipping.CommitTrans()
end if

destroy Trans_Shipping

int i
for	i = 1 to UpperBound(shipperIDs)
	PrintPackList(shipperIDs[i], packListFormats[i])
next

return Refresh()

end function

on n_cst_shipping_controller.create
call super::create
end on

on n_cst_shipping_controller.destroy
call super::destroy
end on


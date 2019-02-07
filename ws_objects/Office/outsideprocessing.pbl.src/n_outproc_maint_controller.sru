$PBExportHeader$n_outproc_maint_controller.sru
forward
global type n_outproc_maint_controller from n_cst_virtual_controller
end type
end forward

global type n_outproc_maint_controller from n_cst_virtual_controller
end type
global n_outproc_maint_controller n_outproc_maint_controller

type variables

private:

//	View references.
u_panel_headerdetail _headerDetailView
u_tabpg_outproc_maint_headers _headersView
u_tab_4t _detailTabView
u_tabpg_outproc_maint_validation _validationView
u_tabpg_outproc_maint_inventory _inventoryView
u_tabpg_outproc_maint_inventory_btb _inventoryBTBView
u_fxdw_outproc_newbtbshipment _newBTBShipmentView
u_fxdw_outproc_newblanketpo _newBlanketPOView

w_outproc_maint _parentSheet

//	Model data.
n_outproc_definition _opDefinition

//	Data context.
n_outproc_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer func2 (long somevalue)
public function integer shownewpart ()
public function integer createnewpart ()
public function integer addsupplier ()
public function integer removesupplier ()
public function integer addpo ()
public function integer closepo ()
public function integer setdefaultpo ()
public function integer closepart (long opdefrowid)
public function integer setactiveopdefinition (n_outproc_definition opdefinition)
public function integer showinventoryview ()
public function integer showinventorybtbview ()
public function integer hideinventorybtbview ()
public function integer hideinventoryview ()
public function integer adjustsupplierqty (string partcode, decimal adjustedqty)
public function integer shownewbtbshipment ()
public function integer cancelnewbtbshipment ()
public function integer shownewblanketpo ()
public function integer showsetupbtb ()
public function integer showcloseblanketpo (long ponumber)
public function integer setactiveblanketpo (long ponumber)
public function integer showclearbtb ()
public function integer cancelnewblanketpo ()
public function integer newbtbshipment (string confirmedsid, decimal quantity, string notes)
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
 _headerDetailView.uo_1.ShowControl(_headersView)
_headerDetailView.uo_2.ShowControl(_detailTabView)

return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_headerDetailView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailView)

//	Headers view.
_parentSheet.OpenUserObject(_headersView, "u_tabpg_outproc_maint_headers")
_headerDetailView.uo_1.AddPanelControl(_headersView)
MasterListControl = _headersView

//	Details tab view.
_parentSheet.OpenUserObject(_detailTabView, "u_tab_4t")
	//	Top-down view.
	_detailTabView.OpenTab(_validationView, "u_tabpg_outproc_maint_validation", 1)
	//_detailTabView.SetTransObject(_trans)
_headerDetailView.uo_2.AddPanelControl(_detailTabView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _headersView.Refresh()

end function

public function integer func2 (long somevalue);
if	not IsValid(_trans) then return FAILURE

//if	_trans.func2(someValue) <> SUCCESS then
//	return FAILURE
//end if
//
_trans.CommitTrans()

return Refresh()

end function

public function integer shownewpart ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer createnewpart ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer addsupplier ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer removesupplier ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer addpo ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer closepo ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer setdefaultpo ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer closepart (long opdefrowid);
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if
//
//_trans.CommitTrans()

return Refresh()

end function

public function integer setactiveopdefinition (n_outproc_definition opdefinition);
_opDefinition = opDefinition
_validationView.SetOPDefRowID(_opDefinition.OPDefRowID)

if	IsNull(_opDefinition.OPDefRowID) then
	
	if	IsValid(_inventoryView) then
		HideInventoryView()
	end if
	
	if	IsValid(_inventoryBTBView) then
		HideInventoryBTBView()
	end if
	return SUCCESS
end if

if	_opDefinition.IsOutputDropShip = 1 then
	HideInventoryView()
	ShowInventoryBTBView()
	_inventoryBTBView.SetOPDefRowID(_opDefinition.OPDefRowID)
else
	HideInventoryBTBView()
	ShowInventoryView()
	_inventoryView.SetOPDefRowID(_opDefinition.OPDefRowID)
end if

return NO_ACTION

end function

public function integer showinventoryview ();
//	Inventory view.
if	IsValid(_inventoryView) then
	return NO_ACTION
end if

return _detailTabView.OpenTab(_inventoryView, "u_tabpg_outproc_maint_inventory", 2)

end function

public function integer showinventorybtbview ();
//	Inventory view.
if	IsValid(_inventoryBTBView) then
	return NO_ACTION
end if

return _detailTabView.OpenTab(_inventoryBTBView, "u_tabpg_outproc_maint_inventory_btb", 2)

end function

public function integer hideinventorybtbview ();
//	Inventory view.
if	not IsValid(_inventoryBTBView) then return NO_ACTION

return _detailTabView.CloseTab(_inventoryBTBView)

end function

public function integer hideinventoryview ();
//	Inventory view.
if	not IsValid(_inventoryView) then return NO_ACTION

return _detailTabView.CloseTab(_inventoryView)

end function

public function integer adjustsupplierqty (string partcode, decimal adjustedqty);
if	not IsValid(_trans) then return FAILURE
if	not IsValid(_opDefinition) then return FAILURE

if	_trans.adjustvendorinventory(_opDefinition.OPDefRowID, partCode, adjustedQty) <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return SUCCESS

end function

public function integer shownewbtbshipment ();
if	IsValid(_newBTBShipmentView) then return NO_ACTION

//	New BTB Shipment View
_parentSheet.OpenUserObject(_newBTBShipmentView, "u_fxdw_outproc_newbtbshipment")
_headerDetailView.uo_2.AddPanelControl(_newBTBShipmentView)
_newBTBShipmentView.SetOPDefRowID(_opDefinition.OPDefRowID)
_headerDetailView.uo_2.ShowControl(_newBTBShipmentView)

return Refresh()

end function

public function integer cancelnewbtbshipment ();
if	not IsValid(_newBTBShipmentView) then return NO_ACTION
if	not IsValid(_detailTabView) then return FAILURE

//	Close BTB Shipment View
_parentSheet.CloseUserObject(_newBTBShipmentView)

//	Show details tab controls.
_headerDetailView.uo_2.ShowControl(_detailTabView)

return Refresh()

end function

public function integer shownewblanketpo ();
if	IsValid(_newBlanketPOView) then return NO_ACTION
 
//	New Blanket PO View
_parentSheet.OpenUserObject(_newBlanketPOView, "u_fxdw_outproc_newblanketpo")
_headerDetailView.uo_2.AddPanelControl(_newBlanketPOView)
_newBlanketPOView.SetOPDefRowID(_opDefinition.OPDefRowID)
_headerDetailView.uo_2.ShowControl(_newBlanketPOView)

return Refresh()

end function

public function integer showsetupbtb ();
if	IsValid(_newBTBShipmentView) then return NO_ACTION

//	New BTB Shipment View
_parentSheet.OpenUserObject(_newBTBShipmentView, "u_fxdw_outproc_newbtbshipment")
_headerDetailView.uo_2.AddPanelControl(_newBTBShipmentView)
_newBTBShipmentView.SetOPDefRowID(_opDefinition.OPDefRowID)
_headerDetailView.uo_2.ShowControl(_newBTBShipmentView)

return Refresh()

end function

public function integer showcloseblanketpo (long ponumber);
if	IsValid(_newBTBShipmentView) then return NO_ACTION

//	New BTB Shipment View
_parentSheet.OpenUserObject(_newBTBShipmentView, "u_fxdw_outproc_newbtbshipment")
_headerDetailView.uo_2.AddPanelControl(_newBTBShipmentView)
_newBTBShipmentView.SetOPDefRowID(_opDefinition.OPDefRowID)
_headerDetailView.uo_2.ShowControl(_newBTBShipmentView)

return Refresh()

end function

public function integer setactiveblanketpo (long ponumber);
if	IsValid(_newBTBShipmentView) then return NO_ACTION

//	New BTB Shipment View
_parentSheet.OpenUserObject(_newBTBShipmentView, "u_fxdw_outproc_newbtbshipment")
_headerDetailView.uo_2.AddPanelControl(_newBTBShipmentView)
_newBTBShipmentView.SetOPDefRowID(_opDefinition.OPDefRowID)
_headerDetailView.uo_2.ShowControl(_newBTBShipmentView)

return Refresh()

end function

public function integer showclearbtb ();
if	IsValid(_newBTBShipmentView) then return NO_ACTION

//	New BTB Shipment View
_parentSheet.OpenUserObject(_newBTBShipmentView, "u_fxdw_outproc_newbtbshipment")
_headerDetailView.uo_2.AddPanelControl(_newBTBShipmentView)
_newBTBShipmentView.SetOPDefRowID(_opDefinition.OPDefRowID)
_headerDetailView.uo_2.ShowControl(_newBTBShipmentView)

return Refresh()

end function

public function integer cancelnewblanketpo ();
if	not IsValid(_newBlanketPOView) then return NO_ACTION
if	not IsValid(_detailTabView) then return FAILURE

//	Close BTB Shipment View
_parentSheet.CloseUserObject(_newBlanketPOView)

//	Show details tab controls.
_headerDetailView.uo_2.ShowControl(_detailTabView)

return Refresh()

end function

public function integer newbtbshipment (string confirmedsid, decimal quantity, string notes);
if	not IsValid(_newBTBShipmentView) then return NO_ACTION
if	not IsValid(_detailTabView) then return FAILURE
if	not IsValid(_trans) then return FAILURE

string newReceiverNumber
if	_trans.NewBackToBackShipment(_opDefinition.OPDefRowID, confirmedSID, quantity, notes, newReceiverNumber) <> SUCCESS then
	return FAILURE
else
	msgbox("New receiver " + newReceiverNumber + " created successfully.")
end if

_trans.CommitTrans()

//	Close BTB Shipment View
_parentSheet.CloseUserObject(_newBTBShipmentView)

//	Show details tab controls.
_headerDetailView.uo_2.ShowControl(_detailTabView)

return Refresh()

end function

on n_outproc_maint_controller.create
call super::create
end on

on n_outproc_maint_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_outproc_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


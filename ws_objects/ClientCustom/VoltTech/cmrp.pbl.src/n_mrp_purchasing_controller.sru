$PBExportHeader$n_mrp_purchasing_controller.sru
forward
global type n_mrp_purchasing_controller from n_cst_virtual_controller
end type
end forward

global type n_mrp_purchasing_controller from n_cst_virtual_controller
end type
global n_mrp_purchasing_controller n_mrp_purchasing_controller

type variables

private:

//	View references.
u_panel_headerdetail _headerDetailView
u_panel_leftright _leftRightPOReleasesView
u_tabpg_mrp_purchasing_contracts _contractsView
u_tabpg_mrp_po_currentrelease _currentReleaseView
u_tabpg_mrp_po_newfirmrelease _newFirmReleaseView

w_mrp_purchasing _parentSheet

//	Model data.
long _poNumber

//	Data context.
n_mrp_trans _trans

end variables
forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setponumber (long ponumber)
public function integer updatepo (long ponumber)
public function integer generateposchedule ()
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
_headerDetailView.uo_1.ShowControl(_contractsView)
_headerDetailView.uo_2.ShowControl(_leftRightPOReleasesView)
_leftRightPOReleasesView.uo_1.ShowControl(_currentReleaseView)
_leftRightPOReleasesView.uo_2.ShowControl(_newFirmReleaseView)

return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_headerDetailView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailView)

//	Contracts view.
_parentSheet.OpenUserObject(_contractsView, "u_tabpg_mrp_purchasing_contracts")
_headerDetailView.uo_1.AddPanelControl(_contractsView)
MasterListControl = _contractsView

//	PO split view.
_parentSheet.OpenUserObject(_leftRightPOReleasesView, "u_panel_leftright")
_headerDetailView.uo_2.AddPanelControl(_leftRightPOReleasesView)

//	PO new release.
_parentSheet.OpenUserObject(_currentReleaseView, "u_tabpg_mrp_po_currentrelease")
_leftRightPOReleasesView.uo_1.AddPanelControl(_currentReleaseView)

//	PO new release.
_parentSheet.OpenUserObject(_newFirmReleaseView, "u_tabpg_mrp_po_newfirmrelease")
_leftRightPOReleasesView.uo_2.AddPanelControl(_newFirmReleaseView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _contractsView.Refresh()

end function

public function integer setponumber (long ponumber);
_poNumber = poNumber
_currentReleaseView.SetPONumber(_poNumber)
_newFirmReleaseView.SetPONumber(_poNumber)

return SUCCESS

end function

public function integer updatepo (long ponumber);
if	not IsValid(_trans) then return FAILURE

if	_trans.ReplaceFirmPOSchedule(poNumber) <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return Refresh()

end function

public function integer generateposchedule ();
if	not IsValid(_trans) then return FAILURE

if	_trans.CalculatePlanningPurchaseOrders() <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return Refresh()

end function

on n_mrp_purchasing_controller.create
call super::create
end on

on n_mrp_purchasing_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_mrp_trans

end event

event destructor;call super::destructor;
destroy _trans

end event

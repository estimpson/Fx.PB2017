$PBExportHeader$n_cntmgr_master_controller.sru
forward
global type n_cntmgr_master_controller from n_cst_virtual_controller
end type
end forward

global type n_cntmgr_master_controller from n_cst_virtual_controller
integer _displaymode = 0
end type
global n_cntmgr_master_controller n_cntmgr_master_controller

type variables

private:

//	View references.
u_panel_headerdetail _cntMasterDetailView
u_tabpg_cntmgr_master_cntlist _cntlistView
u_tabpg_cntmgr_master_manifest _cntManifestView
u_fxdw_container_edittrackinginfo _departureView

w_cntmgr_master _parentSheet

//	Model data.
string _deliveryNumber
long _stagingShipper

//	Data context.
n_cntmgr_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer func1 ()
public function integer func2 ()
public function integer createcontainershipper (string deliverynumber)
public function integer startcontainerstagingscanning ()
public function integer setdeliverynumber (string deliverynumber)
public function integer stopcontainerstagingscanning ()
public function integer handlescan (string scanvalue)
public function integer handleserial (long serial)
public function integer printmanifest ()
public function integer beginshipout ()
public function integer endshipout ()
public function integer completeshipout (string aetcnumber, string pronumber, string trucknumber, string sealnumber)
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
_parentSheet.uo_1.ShowControl(_cntMasterDetailView)
_cntMasterDetailView.uo_1.ShowControl(_cntlistView)
_cntMasterDetailView.uo_2.ShowControl(_cntManifestView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_cntMasterDetailView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_cntMasterDetailView)

//	Container list view.
_parentSheet.OpenUserObject(_cntlistView, "u_tabpg_cntmgr_master_cntlist")
_cntMasterDetailView.uo_1.AddPanelControl(_cntlistView)
MasterListControl = _cntlistView

//	Container manifest view.
_parentSheet.OpenUserObject(_cntManifestView, "u_tabpg_cntmgr_master_manifest")
_cntMasterDetailView.uo_2.AddPanelControl(_cntManifestView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _cntlistView.Refresh()

end function

public function integer func1 ();
if	not IsValid(_trans) then return FAILURE

if	_trans.func1() <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return Refresh()

end function

public function integer func2 ();
if	not IsValid(_trans) then return FAILURE

if	_trans.func2() <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return Refresh()

end function

public function integer createcontainershipper (string deliverynumber);
if	not IsValid(_trans) then return FAILURE

long newShipperID

if	_trans.CreateContainerShipper(deliveryNumber, newShipperID) <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

MsgBox("Container shipper " + string (newShipperID) + " created succesfully.")
_stagingShipper = newShipperID

return Refresh()

end function

public function integer startcontainerstagingscanning ();
if	not IsValid(_parentSheet) or not IsValid(_cntManifestView) or not IsValid(_trans) then
	return FAILURE
end if

if	IsNull(_stagingShipper, -1) <= 0 then
	if	MsgBox("A shipper must be created first.  Do you want to create one now?", Question!, YesNo!, 2) = 1 then
		long newShipperID
		if	_trans.CreateContainerShipper(_deliveryNumber, newShipperID) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
		_stagingShipper = newShipperID
	end if
end if
	
BeginScanning()
_displayMode = BitwiseOr(_displayMode, MODE_SCANNING)
_cntManifestView.SetScanning(true)

return SUCCESS

end function

public function integer setdeliverynumber (string deliverynumber);
_deliveryNumber = deliveryNumber
if	_trans.GetDeliveryShipperNumber(_deliveryNumber, _stagingShipper) <> SUCCESS then
	_trans.RollbackTrans()
	return _cntManifestView.SetShipperID(0)
end if

return _cntManifestView.SetShipperID(_stagingShipper)


end function

public function integer stopcontainerstagingscanning ();
if	not IsValid(_parentSheet) or not IsValid(_cntManifestView) then
	return FAILURE
end if

EndScanning()
_displayMode = BitwiseAnd(_displayMode, BitWiseNot(MODE_SCANNING))
_cntManifestView.SetScanning(false)

return SUCCESS

end function

public function integer handlescan (string scanvalue);
//	Determine the type of data being scanned.
char category
int subCategory
string value

if	match(scanValue, "^[A-Z]") then
	subcategory = 0
	category = mid(scanValue, 1, 1)
	value = mid(scanValue, 2, len(scanValue) - 1)
elseif	match(scanValue, "^[0-9][A-Z]") then
	subcategory = long(left(scanValue, 1))
	category = mid(scanValue, 2, 1)
	value = mid(scanValue, 3, len(scanValue) - 2)
elseif	match(scanValue, "^[0-9][0-9][A-Z]") then
	subcategory = long(left(scanValue, 2))
	category = mid(scanValue, 3, 1)
	value = mid(scanValue, 4, len(scanValue) - 3)
elseif	match(scanValue, "^[0-9][0-9][0-9][A-Z]") then
	subcategory = long(left(scanValue, 3))
	category = mid(scanValue, 4, 1)
	value = mid(scanValue, 5, len(scanValue) - 4)
end if

//	Handle serials.
if	category = 'S' then
	if	IsNumber(value) then
		return HandleSerial(Long(value))
	end if
end if

MessageBox(gnv_App.iapp_Object.DisplayName, "Scan data: " + scanValue + " not recognized.")
return SUCCESS

end function

public function integer handleserial (long serial);
if	not IsValid(_trans) then
	return FAILURE
end if

boolean isStaged
long stagedShipper
if	_trans.SerialIsStaged(serial, isStaged, stagedShipper) = SUCCESS then
	
	if	isStaged then
		if	stagedShipper <> _stagingShipper then
			MsgBox("This object (" + String(serial) + ") is already staged to shipper " + String(stagedShipper) + " and must be unstaged before it can be staged to shipper " + String(_stagingShipper) + ".")
			_trans.RollbackTrans()
			return FAILURE
		else
			if	MsgBox("This object (" + String(serial) + ") is already staged to this shipper " + String(stagedShipper) + ".  Do you want to unstage it?", Question!, YesNo!, 2) = 1 then
				if	_trans.UnstageSerial(serial, _deliveryNumber) = SUCCESS then
					_trans.CommitTrans()
				else
					_trans.RollbackTrans()
				end if
			end if
		end if
	else
		if	_trans.StageSerial(serial, _deliveryNumber) = SUCCESS then
			_trans.CommitTrans()
		else
			_trans.RollbackTrans()
		end if
	end if
else
	return FAILURE
end if

return _cntManifestView.SetShipperID(_stagingShipper)

end function

public function integer printmanifest ();
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", _stagingShipper)
printerParm.of_SetItem ( "Report", "Container Manifest" )

if	Print(printerParm) = SUCCESS then
	if	_trans.SetContainerManifestPrinted(_stagingShipper) = SUCCESS then
		_trans.CommitTrans()
		return Refresh()
	end if
	_trans.RollbackTrans()
end if

return FAILURE

end function

public function integer beginshipout ();
//	End scanning.
if	_displayMode = MODE_SCANNING then
	StopContainerStagingScanning()
end if

//	Create a departure view.
_parentSheet.OpenUserObject(_departureView, "u_fxdw_container_edittrackinginfo")
_cntMasterDetailView.uo_2.AddPanelControl(_departureView)
_cntMasterDetailView.uo_2.ShowControl(_departureView)

return _departureView.Refresh()

end function

public function integer endshipout ();
//	Create a departure view.
_parentSheet.CloseUserObject(_departureView)
_cntMasterDetailView.uo_2.ShowControl(_cntManifestView)

return Refresh()

end function

public function integer completeshipout (string aetcnumber, string pronumber, string trucknumber, string sealnumber);
if	not IsValid(_trans) then
	return FAILURE
end if

//	Try performing shipout.
if	_trans.Shipout(_deliveryNumber, aetcNumber, proNumber, truckNumber, sealNumber) = SUCCESS then
	_trans.CommitTrans()
	MsgBox("Shipout completed successfully for shipper " + String(_stagingShipper) + ".")
	EndShipout()
else
	_trans.RollbackTrans()
	return FAILURE
end if

return Refresh()

end function

on n_cntmgr_master_controller.create
call super::create
end on

on n_cntmgr_master_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_cntmgr_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


HA$PBExportHeader$n_cst_receivingdock_controller.sru
forward
global type n_cst_receivingdock_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_receivingdock_controller from n_cst_virtual_controller
integer _displaymode = 1
end type
global n_cst_receivingdock_controller n_cst_receivingdock_controller

type variables

private:
constant integer MODE_SHOWLINES = 1
constant integer MODE_SHOWOBJECTS = 2

//	Model data.
string _receiverNumber, _receiverLineList
string _activePutAwayLocation

//	View references.
u_panel_headerdetail _headerDetailPanel
u_tabpg_receivingdock_headers _receiverHeadersView
u_tabpg_receivingdock_lines _receiverLinesView
u_tabpg_receivingdock_objects _receiverObjectsView

w_receivingdockv2 _parentSheet

//	Data context.
n_cst_inventorytrans _inventoryTrans
n_cst_receivingdocktrans _receivingDockTrans

end variables
forward prototypes
public function integer createlayout ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer newreceiver ()
public function integer showreceiver (string receivernumber)
public function integer hidereceiver ()
public function integer showreceiverobjects (string receiverlinelist)
public function integer doneshowreceiverobjects ()
public function integer startreceiptscanning ()
public function integer setactivelocation (string putawaylocation)
public function integer stopreceiptscanning ()
public function integer putawayserial (long serial)
public function integer endscanning ()
public function integer getframecontroller ()
public function integer labelbox (long boxserialnumber)
public function integer receivereceiverobject (long receiverobjectid)
public function integer undoreceivereceiverobject (long receiverobjectid)
public function integer deletereceiverline (long receiverlineid)
public function integer putawayreceiver (long receiverid)
public function integer createreceiverlines (long receiverid)
public function integer handlescan (string scanvalue)
end prototypes

public function integer createlayout ();
//	Header detail:
_parentSheet.OpenUserObject(_headerDetailPanel, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailPanel)

//	Receiver list:
_parentSheet.OpenUserObject(_receiverHeadersView, "u_tabpg_receivingdock_headers")
_receiverHeadersView.Controller = this
_headerDetailPanel.uo_1.AddPanelControl(_receiverHeadersView)
MasterListControl = _receiverHeadersView
MainControl = _receiverHeadersView

//	Receiver lines list:
_parentSheet.OpenUserObject(_receiverLinesView, "u_tabpg_receivingdock_lines")
_receiverLinesView.Controller = this
_headerDetailPanel.uo_2.AddPanelControl(_receiverLinesView)

//	Receiver objects list:
_parentSheet.OpenUserObject(_receiverObjectsView, "u_tabpg_receivingdock_objects")
_receiverObjectsView.Controller = this
_headerDetailPanel.uo_2.AddPanelControl(_receiverObjectsView)

//	Show controls.
_parentSheet.uo_1.ShowControl(_headerDetailPanel)
_headerDetailPanel.uo_1.ShowControl(_receiverHeadersView)
_headerDetailPanel.uo_2.ShowControl(_receiverLinesView)

return SUCCESS

end function

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

public function integer newreceiver ();
if	IsValid(_receiverHeadersView) then
	return _receiverHeadersView.NewReceiver()
end if

return FAILURE

end function

public function integer showreceiver (string receivernumber);
//	Show this receiver in the detail.
if	IsNull(_receiverNumber, "") <> IsNull(receiverNumber, "") then
	_receiverNumber = receiverNumber
	_headerDetailPanel.uo_2.ShowControl(_receiverLinesView)
	_receiverLinesView.SetReceiverNumber(receiverNumber)
else
	if	_displayMode = MODE_SHOWLINES then
		_headerDetailPanel.uo_2.ShowControl(_receiverLinesView)
		_receiverLinesView.Refresh()
	elseif	_displayMode = MODE_SHOWOBJECTS then
		_headerDetailPanel.uo_2.ShowControl(_receiverObjectsView)
		_receiverObjectsView.Refresh()
	end if
end if

return SUCCESS

end function

public function integer hidereceiver ();
//	Don't show any receiver.
SetNull(_receiverNumber)
return _receiverLinesView.Reset()

end function

public function integer showreceiverobjects (string receiverlinelist);
//	Show this receiver in the detail.
_receiverLineList = receiverLineList
_headerDetailPanel.uo_2.ShowControl(_receiverObjectsView)
_displayMode = MODE_SHOWOBJECTS

return _receiverObjectsView.SetReceiverLineList(_receiverNumber, _receiverLineList)

end function

public function integer doneshowreceiverobjects ();
_displayMode = MODE_SHOWLINES

//	Restore the receiver lines view.
EndScanning()
return ShowReceiver(_receiverNumber)

end function

public function integer startreceiptscanning ();
if	not IsValid(_parentSheet) or not IsValid(_receiverObjectsView) then
	return FAILURE
end if

_parentSheet.HidePutAwayLocation()
_receiverObjectsView.cb_scan.Text = "Stop Scan"

BeginScanning()
_displayMode = BitwiseOr(_displayMode, MODE_SCANNING)

return SUCCESS

end function

public function integer setactivelocation (string putawaylocation);
if	not IsValid(_parentSheet) then
	return FAILURE
end if

if	_inventoryTrans.ValidateLocation(putAwayLocation) = SUCCESS then
	_activePutAwayLocation = putAwayLocation
	return _parentSheet.ShowPutAwayLocation(_activePutAwayLocation)
end if

return FAILURE

end function

public function integer stopreceiptscanning ();
if	not IsValid(_parentSheet) or not IsValid(_receiverObjectsView) then
	return FAILURE
end if

_parentSheet.HidePutAwayLocation()
_receiverObjectsView.cb_scan.Text = "Scan"

EndScanning()
_displayMode = BitwiseAnd(_displayMode, BitWiseNot(MODE_SCANNING))

return SUCCESS

end function

public function integer putawayserial (long serial);
if	not IsValid(_receivingDockTrans) then
	return FAILURE
end if

if	_receivingDockTrans.PutAwaySerial(_receiverNumber, serial, _activePutAwayLocation) = SUCCESS then
	_receivingDockTrans.CommitTrans()  ;
else
	return FAILURE
end if

return SUCCESS

end function

public function integer endscanning ();
if	not IsValid(_frameController) or not IsValid(_parentSheet) then
	return FAILURE
end if

return _frameController.StopScanning()

end function

public function integer getframecontroller ();
//	Get the controller for this control's window.
w_master myFrameWindow
myFrameWindow = gnv_App.of_GetFrame()
if	not IsValid(myFrameWindow) or IsNull(myFrameWindow) then return FAILURE

_frameController = myFrameWindow.Container.of_GetItem("Controller")

return SUCCESS

end function

public function integer labelbox (long boxserialnumber);
string boxLabelFormat
n_cst_associative_array	printerParm
if	_inventoryTrans.GetBoxLabelParms_forObject(boxSerialNumber, boxLabelFormat) = SUCCESS then
	if boxLabelFormat > "" then
		printerParm.of_SetItem ( "Arg1", boxSerialNumber)
		printerParm.of_SetItem ( "Report", "Label" )
		printerParm.of_SetItem ( "Name", boxLabelFormat )
		Print(printerParm)
	end if
end if

return SUCCESS

end function

public function integer receivereceiverobject (long receiverobjectid);
boolean newLabel
long	serial

_receivingDockTrans.GetReceiverObjectSerial(receiverObjectID, serial)

newLabel = IsNull(serial)

long procResult
if	_receivingDockTrans.receiveObject_againstReceiverObject(receiverObjectID, procResult, true) = SUCCESS then
	//	Print label.
	if	newLabel then
		_receivingDockTrans.GetReceiverObjectSerial(receiverObjectID, serial)
		LabelBox(serial)
	end if
end if

return SUCCESS

end function

public function integer undoreceivereceiverobject (long receiverobjectid);
long procResult
return _receivingDockTrans.undoReceiveObject_againstReceiverObject(receiverObjectID, procResult, true)

end function

public function integer deletereceiverline (long receiverlineid);
long result
return _receivingDockTrans.DeleteReceiverLine(receiverLineID, result)

end function

public function integer putawayreceiver (long receiverid);
long result
return _receivingDockTrans.PutAwayReceiver(receiverID, result)


end function

public function integer createreceiverlines (long receiverid);
long result
return _receivingDockTrans.CreateReceiverLines(receiverID, result)

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

//	Handle serials and locations.
if	category = 'L' then
	return SetActiveLocation(value)
end if
if	category = 'S' then
	if	IsNumber(value) then
		return PutAwaySerial(Long(value))
	end if
end if

MessageBox(gnv_App.iapp_Object.DisplayName, "Scan data: " + scanValue + " not recognized.")
return SUCCESS

end function

on n_cst_receivingdock_controller.create
call super::create
end on

on n_cst_receivingdock_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_inventoryTrans = create n_cst_inventorytrans
_receivingDockTrans = create n_cst_receivingdocktrans


end event

event destructor;call super::destructor;
destroy _inventoryTrans
destroy _receivingDockTrans

end event


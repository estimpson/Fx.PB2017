$PBExportHeader$n_pottingroom_controller.sru
forward
global type n_pottingroom_controller from n_wireharness_basecontroller
end type
end forward

global type n_pottingroom_controller from n_wireharness_basecontroller
end type
global n_pottingroom_controller n_pottingroom_controller

type variables

private:
//constant integer MODE_SHOWLINES = 1
//constant integer MODE_SHOWOBJECTS = 2
constant int NONE = 0, OPERATOR = 1, MATERIALHANDLER = 2

//	Model data.
string	_activePartCode = ""
string _lastPartCode = ""
boolean _isJobSetupComplete
int	_activeOperatorInput = NONE
string _pottingRoomMachineCode, _operatorPottingRoom, _operatorPottingMaterialHandler
long _pottingMaterialSerial, _hardenerSerial
string _kanbanNumber
string _defectReason
long _harnessSerial
string _workOrderNumber
long _jobID
double _workOrderDetailLineNo

//	View references.
u_panel_leftright _workInstructionsPanel
u_panel_leftright _sideBySideSplitView
u_panel_headerdetail _pottingLoadingSplitView
u_fxdw_pottingroom_jobsetup _jobSetupView
u_tabpg_pottingroom_loadedkanbans _loadedKanbansView
u_tabpg_pottingroom_inprocessharnesses _inprocessHarnessesView
u_panel_headerdetail _pottingUnLoadingSplitView
u_tabpg_pottingroom_kanbanobjects _kanbanObjectsView
u_tabpg_pottingroom_scrapobjects _scrapObjectsView
u_tabpg_browser _workInstructionsBrowserView

w_prepottingassembly _parentSheet

//	Data context.
n_pottingroom_trans _pottingRoomTrans

end variables

forward prototypes
public function integer showcontrols ()
public function integer createlayout ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer refresh ()
public function integer handlescan (string scanvalue)
public function integer setoperator (string code)
public function integer handlekanban (string kanbanbinnumber)
public function integer handleserial (long serial)
public function integer handledefectcode (string reason)
public function integer setmachine (string code)
public function integer browsernavigate (string url)
public function integer handlepartchange ()
end prototypes

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_workInstructionsPanel)
_workInstructionsPanel.uo_1.ShowControl(_workInstructionsBrowserView)
_workInstructionsPanel.uo_2.ShowControl(_sideBySideSplitView)

_sideBySideSplitView.uo_1.ShowControl(_pottingLoadingSplitView)
_pottingUnLoadingSplitView.uo_1.ShowControl(_kanbanObjectsView)
_pottingUnLoadingSplitView.uo_2.ShowControl(_scrapObjectsView)
_sideBySideSplitView.uo_2.ShowControlGroup("ActiveJob")
_pottingLoadingSplitView.uo_1.ShowControl(_loadedKanbansView)
_pottingLoadingSplitView.uo_2.ShowControl(_inprocessHarnessesView)

_parentSheet.SetRedraw(true)

return SUCCESS

end function

public function integer createlayout ();
_parentSheet.SetRedraw(false)

//	Work instructions panel:
_parentSheet.OpenUserObject(_workInstructionsPanel, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_workInstructionsPanel)

//	Work instructions.
_parentSheet.OpenUserObject(_workInstructionsBrowserView, "u_tabpg_browser")
_workInstructionsPanel.uo_1.AddPanelControl(_workInstructionsBrowserView)

//	Side by side split view:
_parentSheet.OpenUserObject(_sideBySideSplitView, "u_panel_leftright")
_workInstructionsPanel.uo_2.AddPanelControl(_sideBySideSplitView)
_sideBySideSplitView.uo_2.AddPanelControlGroup("ActiveJob", n_panelcontrolgroup.VERTICAL)

//	Split view for loaded kanbans and WIP harnesses.
_parentSheet.OpenUserObject(_pottingLoadingSplitView, "u_panel_headerdetail")
_sideBySideSplitView.uo_1.AddPanelControl(_pottingLoadingSplitView)

//	Loaded kanban view.
_parentSheet.OpenUserObject(_loadedKanbansView, "u_tabpg_pottingroom_loadedkanbans")
_pottingLoadingSplitView.uo_1.AddPanelControl(_loadedKanbansView)

//	WIP harnesses.
_parentSheet.OpenUserObject(_inprocessHarnessesView, "u_tabpg_pottingroom_inprocessharnesses")
_pottingLoadingSplitView.uo_2.AddPanelControl(_inprocessHarnessesView)

//	Job setup view.
_parentSheet.OpenUserObject(_jobSetupView, "u_fxdw_pottingroom_jobsetup")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _jobSetupView, _jobSetupView.Width, _jobSetupView.Height)

//	Unloading split view.
_parentSheet.OpenUserObject(_pottingUnLoadingSplitView, "u_panel_headerdetail")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _pottingUnLoadingSplitView, _pottingUnLoadingSplitView.Width, -1)

//	Kanban harnesses view.
_parentSheet.OpenUserObject(_kanbanObjectsView, "u_tabpg_pottingroom_kanbanobjects")
_pottingUnLoadingSplitView.uo_1.AddPanelControl(_kanbanObjectsView)

//	Scrap harnesses view
_parentSheet.OpenUserObject(_scrapObjectsView, "u_tabpg_pottingroom_scrapobjects")
_pottingUnLoadingSplitView.uo_2.AddPanelControl(_scrapObjectsView)
 
//	Show controls
ShowControls()

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

public function integer refresh ();
if	not IsValid(_jobSetupView) or not IsValid(_loadedKanbansView) then
	return FAILURE
end if

//	Refresh job setup.
if	_operatorPottingRoom > "" then
	_activeOperatorInput = NONE
else
	_activeOperatorInput = OPERATOR
end if
_jobSetupView.SetActiveOperatorInput (_activeOperatorInput)
_jobSetupView.GetJobSetupDetails(_pottingMaterialSerial, _hardenerSerial)
_loadedKanbansView.SetPottingRoomMachine(_pottingRoomMachineCode)
_inprocessHarnessesView.SetPottingRoomMachine(_pottingRoomMachineCode)
_kanbanObjectsView.Refresh()
_scrapObjectsView.SetPottingRoomMachine(_pottingRoomMachineCode)

return SUCCESS

end function

public function integer handlescan (string scanvalue);
//	Determine the type of data being scanned.
char scannerPosition
char category
int subCategory
string value

if	not match(scanValue, "^[=]") then
	return MsgBox("Scanner not properly configured.  Scan the single scanner configuration barcode.")
end if
if	match(scanValue, "^[=][A-Z]") then
	scannerPosition = mid(scanValue, 1, 1)
	subcategory = 0
	category = mid(scanValue, 2, 1)
	value = mid(scanValue, 3, len(scanValue) - 2)
elseif	match(scanValue, "^[=][0-9][A-Z]") then
	scannerPosition = mid(scanValue, 1, 1)
	subcategory = long(mid(scanValue, 2, 1))
	category = mid(scanValue, 3, 1)
	value = mid(scanValue, 4, len(scanValue) - 3)
elseif	match(scanValue, "^[=][0-9][0-9][A-Z]") then
	scannerPosition = mid(scanValue, 1, 1)
	subcategory = long(mid(scanValue, 2, 2))
	category = mid(scanValue, 4, 1)
	value = mid(scanValue, 5, len(scanValue) - 4)
elseif	match(scanValue, "^[=][0-9][0-9][0-9][A-Z]") then
	scannerPosition = mid(scanValue, 1, 1)
	subcategory = long(mid(scanValue, 3, 2))
	category = mid(scanValue, 5, 1)
	value = mid(scanValue, 6, len(scanValue) - 5)
end if

//	Handle Operator.
if	category = "H" and subcategory = 1 then
	return SetOperator(value)
end if
//	Handle Kanbans.
if	category = 'K' and subcategory = 15 then
	return HandleKanban(value)
end if
//	Handle Defect Codes.
if	category = 'Y' and subcategory = 1 then
	if	mid(value, 1, 7) = "DEFECT-" then
		return HandleDefectCode(mid(value, 8, len(value) - 7))
	end if
end if
//	Handle Machine Scan
if	(category = 'L' and subcategory = 1) or (category = 'S' and subcategory = 11) then
	return SetMachine(value)
end if
//	Handle Piece Labels
if	category = 'S' and subcategory = 1 then
	return HandleSerial(long(value))
end if

MessageBox(gnv_App.iapp_Object.DisplayName, "Scan data: " + scanValue + " not recognized.")
return SUCCESS

end function

public function integer setoperator (string code);
if	not IsValid(_jobSetupView) then
	return FAILURE
end if

if	_activeOperatorInput = OPERATOR then
	if	_jobSetupView.SetPottingRoomOperator(code) = SUCCESS then
		_operatorPottingRoom = code
		if	_operatorPottingMaterialHandler > "" then
			_activeOperatorInput = NONE
		else
			_activeOperatorInput = MATERIALHANDLER
		end if
		
		return _jobSetupView.SetActiveOperatorInput (_activeOperatorInput)
	end if
	MsgBox("Invalid operator for potting room: " + code)
	return FAILURE
end if

if	_activeOperatorInput = MATERIALHANDLER then
	if	_jobSetupView.SetPottingRoomMaterialHandler(code) = SUCCESS then
		_operatorPottingMaterialHandler = code
		if	_operatorPottingRoom > "" then
			_activeOperatorInput = NONE
		else
			_activeOperatorInput = OPERATOR
		end if
		
		return _jobSetupView.SetActiveOperatorInput (_activeOperatorInput)
	end if
	MsgBox("Invalid operator for potting material handler: " + code)
	return FAILURE
end if

MsgBox("Click the potting room operator or material handler before scanning operator badge.")
return FAILURE

end function

public function integer handlekanban (string kanbanbinnumber);
if	not IsValid(_pottingRoomTrans) then
	return FAILURE
end if

if	not IsNull(_pottingRoomMachineCode, "") > "" then
	MsgBox("You must scan a valid machine before you can scan a Kanban Bin.")
	return FAILURE
end if

if	not IsNull(_operatorPottingRoom, "") > "" or not IsNull(_operatorPottingMaterialHandler, "") > "" then
	MsgBox("You must scan an operator and material handler before you can scan a Kanban Bin.")
	return FAILURE
end if

//	Determine whether this is an appropriate Kanban for loading or unloading or neither.
boolean isLoadable, hasInputContents, isUnloadable, isEmptyOrSameOperator
string outputPartCode, outputWorkOrderNumber
double outputWorkOrderDetailLineNo
long outputJobId

if	_pottingRoomTrans.CheckKanban(_pottingRoomMachineCode, kanbanBinNumber, _operatorPottingRoom, isLoadable, hasInputContents, isUnloadable, isEmptyOrSameOperator, outputPartCode, outputWorkOrderNumber, outputWorkOrderDetailLineNo, outputJobId) <> SUCCESS then
	return FAILURE
end if

if	isLoadable and hasInputContents then
	if	_pottingRoomTrans.LoadKanbanToPottingRoom(kanbanBinNumber, _operatorPottingRoom, _operatorPottingMaterialHandler, _pottingRoomMachineCode) = SUCCESS then
		_pottingRoomTrans.CommitTrans()
		return Refresh()
	end if
	return FAILURE
end if
if	isUnloadable and isEmptyOrSameOperator then
	_kanbanNumber = kanbanBinNumber
	_workOrderNumber = outputWorkOrderNumber
	_workOrderDetailLineNo = outputWorkOrderDetailLineNo
	_jobId = outputJobId
	_jobSetupView.SetKanbanNumber(_kanbanNumber)
	_kanbanObjectsView.SetKanbanNumber(_kanbanNumber)
	
	_activePartCode = outputPartCode
	return Refresh()
end if
if	isUnloadable then
	MsgBox("Kanban number " + kanbanBinNumber + " is not empty and contains inventory from another operator.  Use an empty bin.")
	return FAILURE
end if
if	isLoadable then
	MsgBox("Kanban number " + kanbanBinNumber + " is empty and cannot be loaded.")
	return FAILURE
end if

MsgBox("Kanban number " + kanbanBinNumber + " is not useable on this machine.")
return FAILURE

end function

public function integer handleserial (long serial);
if	not IsValid(_pottingRoomTrans) then
	return FAILURE
end if

if	not IsNull(_pottingRoomMachineCode, "") > "" then
	MsgBox("You must scan a valid machine before you can scan a serial.")
	return FAILURE
end if

if	not IsNull(_operatorPottingRoom, "") > "" then
	MsgBox("You must complete the job setup before you scan a serial.  Missing operator.")
	return FAILURE
end if

if	not IsNull(_operatorPottingMaterialHandler, "") > "" then
	MsgBox("You must complete the job setup before you scan a serial.  Missing material handler.")
	return FAILURE
end if

//	Determine whether this is an appropriate Kanban for loading or unloading or neither.
boolean isResin, isHardener, isHarness, isCompletableHarness
string partCode

if	_pottingRoomTrans.CheckObject(_pottingRoomMachineCode, serial, partCode, isResin, isHardener, isHarness, isCompletableHarness) <> SUCCESS then
	return FAILURE
end if

if	isResin then
	if	not IsNull(_kanbanNumber, "") > "" and not IsNull(_defectReason, "") > "" then
		MsgBox("You must scan a kanban bin before you can scan potting resin for allocation.")
	end if

	//	Allocate resin.
	if	_pottingRoomTrans.AllocateSerialToJobID(_operatorPottingRoom, serial, _jobID) <> SUCCESS then
			return _pottingRoomTrans.RollbackTrans()
	end if
	_pottingRoomTrans.CommitTrans()
	return Refresh()
end if
if	isHardener then
	if	not IsNull(_kanbanNumber, "") > "" and not IsNull(_defectReason, "") > "" then
		MsgBox("You must scan a kanban bin before you can scan hardener for allocation.")
	end if

	//	Allocate resin.
	if	_pottingRoomTrans.AllocateSerialToJobID(_operatorPottingRoom, serial, _jobID) <> SUCCESS then
			return _pottingRoomTrans.RollbackTrans()
	end if
	_pottingRoomTrans.CommitTrans()
	return Refresh()
end if
if	isHarness and isCompletableHarness then
	if	not IsNull(_kanbanNumber, "") > "" and not IsNull(_defectReason, "") > "" then
		MsgBox("You must scan a kanban bin before you can scan a wire harness to complete it.")
	end if
	
	//	Complete or defect harness.
	if	not IsNull(_defectReason, "") > "" then
		//	Complete the harness to the bin.
		if	_pottingRoomTrans.CompleteHarness(_operatorPottingRoom, _operatorPottingMaterialHandler, _pottingRoomMachineCode, serial, _kanbanNumber) <> SUCCESS then
			return _pottingRoomTrans.RollbackTrans()
		end if
		_pottingRoomTrans.CommitTrans()
	else
		//	Defect the harness.
		if	_pottingRoomTrans.DefectHarness(_operatorPottingRoom, _operatorPottingMaterialHandler, _pottingRoomMachineCode, serial, _defectReason) <> SUCCESS then
			return _pottingRoomTrans.RollbackTrans()
		end if
		_pottingRoomTrans.CommitTrans()
		SetNull(_defectReason)
		if	IsValid(_scrapObjectsView) then
			_scrapObjectsView.ClearNewDefectReason()
		end if
	end if
	return Refresh()
end if
if	isHarness then
	MsgBox("Wire harness " + string(serial) + " cannot be completed in potting until it has been completed in pre-potting assembly.")
	return FAILURE
end if

MsgBox("Object " + string(serial) + " is not a useable component or recognized wire harness.")
return FAILURE

end function

public function integer handledefectcode (string reason);
if	not IsValid(_scrapObjectsView) then
	return FAILURE
end if

if	not IsNull(_pottingRoomMachineCode, "") > "" then
	MsgBox("You must scan a valid machine before you can scan a Kanban Bin.")
	return FAILURE
end if

if	not IsNull(_operatorPottingRoom, "") > "" then
	MsgBox("You must complete the job setup before you scan a defect code.  Missing operator.")
	return FAILURE
end if

if	not IsNull(_operatorPottingMaterialHandler, "") > "" then
	MsgBox("You must complete the job setup before you scan a defect code.  Missing material handler.")
	return FAILURE
end if

if	not IsNull(_kanbanNumber, "") > "" then
	MsgBox("You must complete the job setup before you scan a defect code.  Missing kanban bin.")
	return FAILURE
end if

if	not IsNull(_pottingMaterialSerial, 0) > 0 then
	MsgBox("You must complete the job setup before you scan a defect code.  Missing potting material.")
	return FAILURE
end if

if	not IsNull(_hardenerSerial, 0) > 0 then
	MsgBox("You must complete the job setup before you scan a defect code.  Missing hardener.")
	return FAILURE
end if

_defectReason = reason
_scrapObjectsView.SetNewDefectReason(_defectReason)

return SUCCESS

end function

public function integer setmachine (string code);
if	not IsValid(_jobSetupView) then
	return FAILURE
end if

if	_jobSetupView.SetPottingRoomMachine(code) = SUCCESS then
	_pottingRoommachineCode = code
	return Refresh()
end if

MsgBox("Invalid potting room machine: " + code)
return FAILURE

end function

public function integer browsernavigate (string url);
if	not IsValid(_workInstructionsBrowserView) then
	return FAILURE
end if

//	Navigate the browser.
_workInstructionsBrowserView.uo_browser.Navigate(url)
return SUCCESS

end function

public function integer handlepartchange ();
if	not IsValid(_pottingRoomTrans) then
	return FAILURE
end if

//	Get the URL.
string	newPartMfgURL
if	_pottingRoomTrans.GetPartMFGUrl(_operatorPottingRoom, _activePartCode, newPartMfgURL) <> SUCCESS then
	_pottingRoomTrans.RollbackTrans()
else
	_pottingRoomTrans.CommitTrans()
	BrowserNavigate(newPartMfgURL)
end if

//	Go to URL.
return SUCCESS

end function

on n_pottingroom_controller.create
call super::create
end on

on n_pottingroom_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_pottingRoomTrans = create n_pottingroom_trans

end event

event destructor;call super::destructor;
destroy _pottingRoomTrans

end event


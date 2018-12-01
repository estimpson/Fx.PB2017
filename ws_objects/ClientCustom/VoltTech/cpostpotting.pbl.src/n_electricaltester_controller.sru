$PBExportHeader$n_electricaltester_controller.sru
forward
global type n_electricaltester_controller from n_wireharness_basecontroller
end type
end forward

global type n_electricaltester_controller from n_wireharness_basecontroller
end type
global n_electricaltester_controller n_electricaltester_controller

type prototypes
Subroutine TurnRedOn() Library "C:\Fx\ElectricTest-COM.DLL"
Subroutine TurnGreenOn() Library "C:\Fx\ElectricTest-COM.DLL"

end prototypes

type variables

private:

//	Model data.
string	_activePartCode = ""
string _lastPartCode = ""
boolean _isJobSetupComplete
string _electricalTesterMachine
string _operatorElectricalTester
long _boxSerial
string _partNumber
string _defectReason
long _harnessSerial
string _workOrderNumber
long _jobID
double _workOrderDetailLineNo

//	View references.
u_panel_leftright _workInstructionsPanel
u_panel_leftright _sideBySideSplitView
u_panel_headerdetail _loadingSplitView
u_fxdw_electricaltester_jobsetup _jobSetupView
u_tabpg_electricaltester_loadedkanbans _loadedKanbansView
u_tabpg_electester_inprocessharnesses _inprocessHarnessesView
u_panel_headerdetail _unLoadingSplitView
u_tabpg_electricaltester_finishedgoods _finishedGoodsView
u_tabpg_electricaltester_scrapobjects _scrapObjectsView
u_tabpg_browser _workInstructionsBrowserView

w_electricaltester _parentSheet

//	Data context.
n_electricaltester_trans _electricalTesterTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer createlayout ()
public function integer showcontrols ()
public function integer refresh ()
public function integer handlescan (string scanvalue)
public function integer setoperator (string code)
public function integer handlekanban (string kanbanbinnumber)
public function integer handleserial (long serial)
public function integer handledefectcode (string reason)
public function integer setmachine (string code)
public function integer comgoodpiece ()
public function integer combadpiece ()
public function integer handlepartchange ()
public function integer browsernavigate (string url)
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
_parentSheet.OpenUserObject(_loadingSplitView, "u_panel_headerdetail")
_sideBySideSplitView.uo_1.AddPanelControl(_loadingSplitView)

//	Loaded kanban view.
_parentSheet.OpenUserObject(_loadedKanbansView, "u_tabpg_electricaltester_loadedkanbans")
_loadingSplitView.uo_1.AddPanelControl(_loadedKanbansView)

//	WIP harnesses.
_parentSheet.OpenUserObject(_inprocessHarnessesView, "u_tabpg_electester_inprocessharnesses")
_loadingSplitView.uo_2.AddPanelControl(_inprocessHarnessesView)

//	Job setup view.
_parentSheet.OpenUserObject(_jobSetupView, "u_fxdw_electricaltester_jobsetup")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _jobSetupView, _jobSetupView.Width, _jobSetupView.Height)

//	Unloading split view.
_parentSheet.OpenUserObject(_unLoadingSplitView, "u_panel_headerdetail")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _unLoadingSplitView, _unLoadingSplitView.Width, -1)

//	Kanban harnesses view.
_parentSheet.OpenUserObject(_finishedGoodsView, "u_tabpg_electricaltester_finishedgoods")
_unLoadingSplitView.uo_1.AddPanelControl(_finishedGoodsView)

//	Scrap harnesses view
_parentSheet.OpenUserObject(_scrapObjectsView, "u_tabpg_electricaltester_scrapobjects")
_unLoadingSplitView.uo_2.AddPanelControl(_scrapObjectsView)
 
//	Show controls
ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_workInstructionsPanel)
_workInstructionsPanel.uo_1.ShowControl(_workInstructionsBrowserView)
_workInstructionsPanel.uo_2.ShowControl(_sideBySideSplitView)
_sideBySideSplitView.uo_1.ShowControl(_loadingSplitView)
_unLoadingSplitView.uo_1.ShowControl(_finishedGoodsView)
_unLoadingSplitView.uo_2.ShowControl(_scrapObjectsView)

_sideBySideSplitView.uo_2.ShowControlGroup("ActiveJob")

_loadingSplitView.uo_1.ShowControl(_loadedKanbansView)
_loadingSplitView.uo_2.ShowControl(_inprocessHarnessesView)

_parentSheet.SetRedraw(true)

return SUCCESS

end function

public function integer refresh ();
if	not IsValid(_jobSetupView) or not IsValid(_loadedKanbansView) then
	return FAILURE
end if

//	Check for part change.
if	_activePartCode <> _lastPartCode then
	_lastPartCode = _activePartCode
	HandlePartChange()
end if

//	Refresh job setup.
_jobSetupView.SetBoxSerial(_boxSerial)
_loadedKanbansView.SetElectricalTesterMachine(_electricalTesterMachine)
_inprocessHarnessesView.SetElectricalTesterMachine(_electricalTesterMachine)
_finishedGoodsView.SetBoxSerial(_boxSerial)
_scrapObjectsView.SetElectricalTesterMachine(_electricalTesterMachine)

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
if	category = 'S' then
	return HandleSerial(long(value))
end if

MessageBox(gnv_App.iapp_Object.DisplayName, "Scan data: " + scanValue + " not recognized.")
return SUCCESS

end function

public function integer setoperator (string code);
if	not IsValid(_jobSetupView) then
	return FAILURE
end if

if	_jobSetupView.SetOperator(code) = SUCCESS then
	_operatorElectricalTester = code
	
	return SUCCESS
end if
MsgBox("Invalid operator for electrical tester: " + code)
return FAILURE

end function

public function integer handlekanban (string kanbanbinnumber);
if	not IsValid(_electricalTesterTrans) then
	return FAILURE
end if

if	not IsNull(_operatorElectricalTester, "") > "" then
	MsgBox("You must scan an operator before you can scan a Kanban Bin.")
	return FAILURE
end if

//	Determine whether this is an appropriate Kanban for loading or unloading or neither.
boolean isLoadable, hasInputContents, isUnloadable, isEmptyOrSameOperator
string outputWorkOrderNumber
double outputWorkOrderDetailLineNo
long outputJobId

if	_electricalTesterTrans.CheckKanban(_electricalTesterMachine, kanbanBinNumber, _operatorElectricalTester, isLoadable, hasInputContents, isUnloadable, isEmptyOrSameOperator, outputWorkOrderNumber, outputWorkOrderDetailLineNo, outputJobId) <> SUCCESS then
	return FAILURE
end if

if	isLoadable and hasInputContents then
	if	_electricalTesterTrans.LoadKanbanToElectricalTester(kanbanBinNumber, _operatorElectricalTester, _electricalTesterMachine) = SUCCESS then
		_electricalTesterTrans.CommitTrans()
		
		_workOrderNumber = outputWorkOrderNumber
		_workOrderDetailLineNo = outputWorkOrderDetailLineNo
		_jobId = outputJobId
	//	_kanbanObjectsView.SetKanbanNumber(_kanbanNumber)
		return Refresh()
	end if
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
if	not IsValid(_electricalTesterTrans) then
	return FAILURE
end if

if	not IsNull(_electricalTesterMachine, "") > "" then
	MsgBox("You must scan a valid machine before you can scan a wire harness.")
	return FAILURE
end if

if	not IsNull(_operatorElectricalTester, "") > "" then
	MsgBox("You must scan an operator before you can scan a wire harness.")
	return FAILURE
end if

//	Determine whether this is an appropriate Kanban for loading or unloading or neither.
boolean isHarness, isCompletableHarness, isBox, isFullBox, isCompletedBox
string partCode

if	_electricalTesterTrans.CheckObject(_electricalTesterMachine, serial, partCode, isHarness, isCompletableHarness, isBox, isFullBox, isCompletedBox) <> SUCCESS then
	return FAILURE
end if

if	isBox then
	if	isCompletedBox then
		MsgBox("Box " + string(serial) + " has already been completed.  You must scan a new box.")
		return FAILURE
	end if
	if	IsNull(_boxSerial, -1) > 0 then
		if	_boxSerial <> serial then
			MsgBox("You must complete box " + string(_boxSerial) + " before you can scan a new box.")
			return FAILURE
		end if
		if	isFullBox then
			if	_electricalTesterTrans.CloseBox(_operatorElectricalTester, _electricalTesterMachine, _boxSerial) <> SUCCESS then
				_electricalTesterTrans.RollbackTrans()
				return FAILURE
			end if
			_electricalTesterTrans.CommitTrans()
			MsgBox("Box " + string(_boxSerial) + " completed.")
			_boxSerial = 0
			return Refresh()
		else
			if	MsgBox("Box " + string(_boxSerial) + " is not full.  Are you sure you want to close it partially full?", Question!, YesNo!, 2) = 1 then
				if	_electricalTesterTrans.CloseBox(_operatorElectricalTester, _electricalTesterMachine, _boxSerial) <> SUCCESS then
					_electricalTesterTrans.RollbackTrans()
					return FAILURE
				end if
				_electricalTesterTrans.CommitTrans()
				MsgBox("Box " + string(_boxSerial) + " partially completed.")
				_boxSerial = 0
				return Refresh()
			end if
			return Refresh()
		end if
		
		_activePartCode = partCode
		return Refresh()
	end if
	if	_electricalTesterTrans.BeginBox(_operatorElectricalTester, _electricalTesterMachine, serial) <> SUCCESS then
		_electricalTesterTrans.RollbackTrans()
		return FAILURE
	end if
	_electricalTesterTrans.CommitTrans()
	_boxSerial = serial
	_activePartCode = partCode

	return Refresh()
end if
if	isHarness and isCompletableHarness then
	if	not IsNull(_boxSerial, -1) > 0 and not IsNull(_defectReason, "") > "" then
		MsgBox("You must scan a box before you can scan a wire harness to complete it.")
	end if
	
	//	Complete or defect harness.
	if	not IsNull(_defectReason, "") > "" then
		//	Complete the harness to the bin.
		if	_electricalTesterTrans.CompleteHarness(_operatorElectricalTester,  _electricalTesterMachine, serial, _boxSerial) <> SUCCESS then
			_electricalTesterTrans.RollbackTrans()
			return FAILURE
		end if
		_electricalTesterTrans.CommitTrans()
		COMGoodPiece()
		return Refresh()
	else
		//	Defect the harness.
		if	_electricalTesterTrans.DefectHarness(_operatorElectricalTester,  _electricalTesterMachine, serial, _defectReason) <> SUCCESS then
			_electricalTesterTrans.RollbackTrans()
			return FAILURE
		end if
		_electricalTesterTrans.CommitTrans()
		COMBadPiece()
		SetNull(_defectReason)
		if	IsValid(_scrapObjectsView) then
			_scrapObjectsView.ClearNewDefectReason()
		end if
	end if
	return Refresh()
end if
if	isHarness then
	MsgBox("Wire harness " + string(serial) + " cannot be completed in electrical tester until it has been completed in leak tester.")
	return FAILURE
end if

MsgBox("Object " + string(serial) + " is not a useable component or recognized wire harness.")
return FAILURE

end function

public function integer handledefectcode (string reason);
if	not IsValid(_scrapObjectsView) then
	return FAILURE
end if

if	not IsNull(_electricalTesterMachine, "") > "" then
	MsgBox("You must scan a valid machine before you can scan a wire harness.")
	return FAILURE
end if

if	not IsNull(_operatorElectricalTester, "") > "" then
	MsgBox("You must complete the job setup before you scan a defect code.  Missing operator.")
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

if	_jobSetupView.SetElectricalTesterMachine(code) = SUCCESS then
	_electricalTesterMachine = code
	return Refresh()
end if

MsgBox("Invalid electrical tester machine: " + code)
return FAILURE

end function

public function integer comgoodpiece ();
OLEObject electricTest
int returnCode

electricTest = create OLEObject

returnCode = electricTest.ConnectToNewObject("ElectricTest_COM.ElectricTest")

if	returnCode <> 0 then
	destroy electricTest
	msgbox("Failure to communicate!")
	return FAILURE
end if

electricTest.TurnGreenOn()
destroy electricTest

gnv_App.of_GetFrame().SetMicroHelp("Good")
return SUCCESS

end function

public function integer combadpiece ();
OLEObject electricTest
int returnCode

electricTest = create OLEObject

returnCode = electricTest.ConnectToNewObject("ElectricTest_COM.ElectricTest")

if	returnCode <> 0 then
	destroy electricTest
	msgbox("Failure to communicate!")
	return FAILURE
end if

electricTest.TurnRedOn()
destroy electricTest
gnv_App.of_GetFrame().SetMicroHelp("Bad")
return SUCCESS

end function

public function integer handlepartchange ();
if	not IsValid(_electricalTesterTrans) then
	return FAILURE
end if

//	Get the URL.
string	newPartMfgURL
if	_electricalTesterTrans.GetPartMFGUrl(_operatorElectricalTester, _activePartCode, newPartMfgURL) <> SUCCESS then
	BrowserNavigate("www.google.com")
	_electricalTesterTrans.RollbackTrans()
else
	_electricalTesterTrans.CommitTrans()
	BrowserNavigate(newPartMfgURL)
end if

//	Go to URL.
return SUCCESS

end function

public function integer browsernavigate (string url);
if	not IsValid(_workInstructionsBrowserView) then
	return FAILURE
end if

//	Navigate the browser.
_workInstructionsBrowserView.uo_browser.Navigate(url)
return SUCCESS

end function

on n_electricaltester_controller.create
call super::create
end on

on n_electricaltester_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_electricalTesterTrans = create n_electricaltester_trans

end event

event destructor;call super::destructor;
destroy _electricalTesterTrans

end event


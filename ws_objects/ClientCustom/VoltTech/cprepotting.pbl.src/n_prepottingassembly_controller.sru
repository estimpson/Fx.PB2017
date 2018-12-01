$PBExportHeader$n_prepottingassembly_controller.sru
forward
global type n_prepottingassembly_controller from n_wireharness_basecontroller
end type
end forward

global type n_prepottingassembly_controller from n_wireharness_basecontroller
end type
global n_prepottingassembly_controller n_prepottingassembly_controller

type variables

private:
//constant integer MODE_SHOWLINES = 1
//constant integer MODE_SHOWOBJECTS = 2

//	Model data.
boolean IsLeftJobSetupComplete, IsRightJobSetupComplete
boolean IsLeftJobRunning, IsRightJobRunning
boolean _isShowingWorkInstructionsLeft, _isShowingWorkInstructionsRight
string operatorLeft, operatorRight
string _kanbanNumberLeft, _kanbanNumberRight
string _productionPartLeft, _productionPartRight
string _lastPartCodeLeft = "", _lastPartCodeRight = ""
string _workOrderNumberLeft, _workOrderNumberRight
long assemblyBoardLeft, assemblyBoardRight
long kanbanLeft, kanbanRight
long _jobIDLeft, _jobIDRight
double _workOrderDetailLineNoLeft, _workOrderDetailLineNoRight

//	View references.
u_panel_leftright _sideBySideSplitView
u_panel _jobDetailsLeft, _jobDetailsRight
u_fxdw_prepottingassembly_jobsetup _jobSetupViewLeft, _jobSetupViewRight
u_fxdw_prepottingassembly_todayprodsum _productionSummaryLeft, _productionSummaryRight
u_fxdw_prepottingassembly_kanbaninfo _kanbanInfoLeft, _kanbanInfoRight
u_tabpg_prepottingassembly_kanbanobjects _kanbanObjectsLeft, _kanbanObjectsRight
u_tabpg_prepottingassembly_jobscrapentry _jobScrapEntryLeft, _jobScrapEntryRight
u_tabpg_browser _workInstructionsBrowserLeft, _workInstructionsBrowserRight

w_prepottingassembly _parentSheet

//	Data context.
n_prepottingassembly_trans _PrePottingAssemblyTrans

end variables

forward prototypes
public function integer createlayout ()
public function integer refresh ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer handlescan (string scanvalue)
public function integer setassemblyboard (character leftright, long assemblyboardserial)
public function integer checkjobsetupstatus (character leftright)
public function integer setoperator (character leftright, string operatorcode)
public function integer setkanbannumber (character leftright, string kanbannumber)
public function integer completeharness (character leftright, long harnessserial)
public function integer showscrapentry (character leftright)
public function integer saveandclosescrapentry (character leftright)
public function integer showkanbaninfo (character leftright)
public function integer donescrapentry (character leftright)
public function integer showcontrols ()
public function integer scrapcomponent (character leftright, string componentpart)
public function integer showhideworkinstructions (character leftright)
public function integer browsernavigate (character leftright, string url)
end prototypes

public function integer createlayout ();
_parentSheet.SetRedraw(false)

//	Side by side split view:
_parentSheet.OpenUserObject(_sideBySideSplitView, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_sideBySideSplitView)
_sideBySideSplitView.uo_1.AddPanelControlGroup("ActiveJob", n_panelcontrolgroup.VERTICAL)
_sideBySideSplitView.uo_2.AddPanelControlGroup("ActiveJob", n_panelcontrolgroup.VERTICAL)
_sideBySideSplitView.uo_1.AddPanelControlGroup("WorkInstructions", n_panelcontrolgroup.VERTICAL)
_sideBySideSplitView.uo_2.AddPanelControlGroup("WorkInstructions", n_panelcontrolgroup.VERTICAL)
_sideBySideSplitView.st_1.Tag = "I"

//	Create job setup views.
_parentSheet.OpenUserObject(_jobSetupViewLeft, "u_fxdw_prepottingassembly_jobsetup")
_sideBySideSplitView.uo_1.AddPanelControlToGroup("ActiveJob", _jobSetupViewLeft, _jobSetupViewLeft.Width, _jobSetupViewLeft.Height)

_parentSheet.OpenUserObject(_jobSetupViewRight, "u_fxdw_prepottingassembly_jobsetup")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _jobSetupViewRight, _jobSetupViewRight.Width, _jobSetupViewRight.Height)

//	Production summary views.
_parentSheet.OpenUserObject(_productionSummaryLeft, "u_fxdw_prepottingassembly_todayprodsum")
_sideBySideSplitView.uo_1.AddPanelControlToGroup("ActiveJob", _productionSummaryLeft, _productionSummaryLeft.Width, _productionSummaryLeft.Height)

_parentSheet.OpenUserObject(_productionSummaryRight, "u_fxdw_prepottingassembly_todayprodsum")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _productionSummaryRight, _productionSummaryRight.Width, _productionSummaryRight.Height)

//	Create kanban info views.
_parentSheet.OpenUserObject(_kanbanInfoLeft, "u_fxdw_prepottingassembly_kanbaninfo")
_sideBySideSplitView.uo_1.AddPanelControlToGroup("ActiveJob", _kanbanInfoLeft, _kanbanInfoLeft.Width, _kanbanInfoLeft.Height)

_parentSheet.OpenUserObject(_kanbanInfoRight, "u_fxdw_prepottingassembly_kanbaninfo")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _kanbanInfoRight, _kanbanInfoRight.Width, _kanbanInfoRight.Height)

//	Create job details view.
_parentSheet.OpenUserObject(_jobDetailsLeft, "u_panel")
_sideBySideSplitView.uo_1.AddPanelControlToGroup("ActiveJob", _jobDetailsLeft, _jobDetailsLeft.Width, -1)

_parentSheet.OpenUserObject(_jobDetailsRight, "u_panel")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("ActiveJob", _jobDetailsRight, _jobDetailsRight.Width, -1)

//	Create kanban object views.
_parentSheet.OpenUserObject(_kanbanObjectsLeft, "u_tabpg_prepottingassembly_kanbanobjects")
_kanbanObjectsLeft.LeftRight = "<"
_jobDetailsLeft.AddPanelControl(_kanbanObjectsLeft)

_parentSheet.OpenUserObject(_kanbanObjectsRight, "u_tabpg_prepottingassembly_kanbanobjects")
_kanbanObjectsRight.LeftRight = ">"
_jobDetailsRight.AddPanelControl(_kanbanObjectsRight)

//	Create job scrap entry views.
_parentSheet.OpenUserObject(_jobScrapEntryLeft, "u_tabpg_prepottingassembly_jobscrapentry")
_jobScrapEntryLeft.LeftRight = "<"
_jobDetailsLeft.AddPanelControl(_jobScrapEntryLeft)

_parentSheet.OpenUserObject(_jobScrapEntryRight, "u_tabpg_prepottingassembly_jobscrapentry")
_jobScrapEntryRight.LeftRight = ">"
_jobDetailsRight.AddPanelControl(_jobScrapEntryRight)

//	Create work instruction views.
_parentSheet.OpenUserObject(_workInstructionsBrowserLeft, "u_tabpg_browser")
_sideBySideSplitView.uo_1.AddPanelControlToGroup("WorkInstructions", _workInstructionsBrowserLeft, _workInstructionsBrowserLeft.Width, -1)

_parentSheet.OpenUserObject(_workInstructionsBrowserRight, "u_tabpg_browser")
_sideBySideSplitView.uo_2.AddPanelControlToGroup("WorkInstructions", _workInstructionsBrowserRight, _workInstructionsBrowserRight.Width, -1)

//	Show controls
ShowControls()

return NO_ACTION

end function

public function integer refresh ();
if	not IsValid(_jobSetupViewLeft) or not IsValid(_jobSetupViewRight) then
	return FAILURE
end if

_jobSetupViewLeft.SetOperator(operatorLeft)
_jobSetupViewLeft.SetAssemblyBoard(assemblyBoardLeft)
_productionSummaryLeft.Refresh()
_kanbanInfoLeft.SetKanbanNumber(_kanbanNumberLeft)
_kanbanObjectsLeft.SetKanbanNumber(_kanbanNumberLeft)
_jobDetailsLeft.ShowControl(_kanbanObjectsLeft)

_jobSetupViewRight.SetOperator(operatorRight)
_jobSetupViewRight.SetAssemblyBoard(assemblyBoardRight)
_productionSummaryRight.Refresh()
_kanbanInfoRight.SetKanbanNumber(_kanbanNumberRight)
_kanbanObjectsRight.SetKanbanNumber(_kanbanNumberRight)
_jobDetailsRight.ShowControl(_kanbanObjectsRight)

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

public function integer handlescan (string scanvalue);
//	Determine the type of data being scanned.
char leftRight
char category
int subCategory
string value

if	not match(scanValue, "^[<>;:]") then
	return MsgBox("Scanner not properly configured.  Scan the left or right configuration barcode.")
end if
if	match(scanValue, "^[<>;:][A-Z]") then
	leftRight = mid(scanValue, 1, 1)
	subcategory = 0
	category = mid(scanValue, 2, 1)
	value = mid(scanValue, 3, len(scanValue) - 2)
elseif	match(scanValue, "^[<>;:][0-9][A-Z]") then
	leftRight = mid(scanValue, 1, 1)
	subcategory = long(mid(scanValue, 2, 1))
	category = mid(scanValue, 3, 1)
	value = mid(scanValue, 4, len(scanValue) - 3)
elseif	match(scanValue, "^[<>;:][0-9][0-9][A-Z]") then
	leftRight = mid(scanValue, 1, 1)
	subcategory = long(mid(scanValue, 2, 2))
	category = mid(scanValue, 4, 1)
	value = mid(scanValue, 5, len(scanValue) - 4)
elseif	match(scanValue, "^[<>;:][0-9][0-9][0-9][A-Z]") then
	leftRight = mid(scanValue, 1, 1)
	subcategory = long(mid(scanValue, 3, 2))
	category = mid(scanValue, 5, 1)
	value = mid(scanValue, 6, len(scanValue) - 5)
end if

//	Translate for Spanish keyboard.
if	leftRight = ";" then
	leftRight = "<"
elseif	leftRight = ":" then
	leftRight = ">"
end if

//	Handle Operator.
if	category = "H" and subcategory = 1 then
	return SetOperator(leftRight, value)
end if
//	Handle Kanbans.
if	category = 'K' and subcategory = 15 then
	if	leftRight = "<" or leftRight = ";" then
		if	not IsLeftJobSetupComplete then
			return MsgBox("Job setup not complete.  Please scan operator and assembly board first.")
		end if
	end if
	if	leftRight = ">" or leftRight = ":" then
		if	not IsRightJobSetupComplete then
			return MsgBox("Job setup not complete.  Please scan operator and assembly board first.")
		end if
	end if
	return SetKanbanNumber(leftRight, value)
end if
//	Handle Component Scrap.
if	category = 'P' then
	return ScrapComponent(leftRight, value)
end if
//	Handle Assembly Boards.
if	category = 'S' and subcategory = 11 then
	return SetAssemblyBoard(leftRight, long(value))
end if
//	Handle Piece Labels
if	category = 'S' and subcategory = 1 then
	return CompleteHarness(leftRight, long(value))
end if
//	Handle Defect Codes.
if	category = 'Y' and subcategory = 2 then
	return ShowHideWorkInstructions(leftRight)
end if

MessageBox(gnv_App.iapp_Object.DisplayName, "Scan data: " + scanValue + " not recognized.")
return SUCCESS

end function

public function integer setassemblyboard (character leftright, long assemblyboardserial);
if	leftRight = "<" or leftRight = ";" then
	if	IsLeftJobRunning then
		// ClearKanban (leftRight)
	end if
	
	AssemblyBoardLeft = assemblyBoardSerial
	_jobSetupViewLeft.SetAssemblyBoard(AssemblyBoardLeft)
	if	AssemblyBoardLeft > 0 then
		_productionPartLeft = _jobSetupViewLeft.GetProductionPart()
		if	_PrePottingAssemblyTrans.GetJobInformation(_productionPartLeft, _workOrderNumberLeft, _workOrderDetailLineNoLeft, _jobIDLeft) = SUCCESS then
			_productionSummaryLeft.SetProductionPart(_productionPartLeft)
			_jobScrapEntryLeft.SetProductionPart(_productionPartLeft)
			
			return CheckJobSetupStatus(leftRight)
		end if
		
		MsgBox("Job not found for part " + IsNull(_productionPartLeft, "N/A"))
		return FAILURE
	end if
	
	SetNull(_productionPartLeft)
	SetNull(_workOrderNumberLeft)
	SetNull(_workOrderDetailLineNoLeft)
	SetNull(_jobIDLeft)
	return SUCCESS
elseif leftRight = ">" or leftRight = ":" then
	if	IsRightJobRunning then
		// ClearKanban (leftRight)
	end if
	
	AssemblyBoardRight = assemblyBoardSerial
	if	AssemblyBoardRight > 0 then
		_jobSetupViewRight.SetAssemblyBoard(AssemblyBoardRight)
		_productionPartRight = _jobSetupViewRight.GetProductionPart()
		if	_PrePottingAssemblyTrans.GetJobInformation(_productionPartRight, _workOrderNumberRight, _workOrderDetailLineNoRight, _jobIDRight) = SUCCESS then
			_productionSummaryRight.SetProductionPart(_productionPartRight)
			_jobScrapEntryRight.SetProductionPart(_productionPartRight)
			
			return CheckJobSetupStatus(leftRight)
		end if
		
		MsgBox("Job not found for part " + IsNull(_productionPartRight, "N/A"))
		return FAILURE
	end if
	
	SetNull(_productionPartRight)
	SetNull(_workOrderNumberRight)
	SetNull(_workOrderDetailLineNoRight)
	SetNull(_jobIDRight)
	return SUCCESS
else
	MsgBox("Error handling assembly board scan.")
	return FAILURE
end if

end function

public function integer checkjobsetupstatus (character leftright);
if	leftRight = "<" or leftRight = ";" then
	IsLeftJobSetupComplete = (AssemblyBoardLeft > 0 and OperatorLeft > "")
	return SUCCESS
elseif	leftRight = ">" or leftRight = ":" then
	IsRightJobSetupComplete = (AssemblyBoardRight > 0 and OperatorRight > "")
	return SUCCESS
else
	MsgBox("Failure checking job setup status.")
	return FAILURE
end if

end function

public function integer setoperator (character leftright, string operatorcode);
if	leftRight = "<" or leftRight = ";" then
	OperatorLeft = operatorCode
	_jobSetupViewLeft.SetOperator(OperatorLeft)
	_productionSummaryLeft.SetOperatorCode(OperatorLeft)

	return CheckJobSetupStatus(leftRight)
elseif leftRight = ">" or leftRight = ":" then
	OperatorRight = operatorCode
	_jobSetupViewRight.SetOperator(OperatorRight)
	_productionSummaryRight.SetOperatorCode(OperatorRight)
	
	return CheckJobSetupStatus(leftRight)
else
	MsgBox("Error handling assembly board scan.")
	return FAILURE
end if

end function

public function integer setkanbannumber (character leftright, string kanbannumber);
if	leftRight = "<" or leftRight = ";" then
	if	IsLeftJobRunning then
		// ClearKanban (leftRight)
	end if
	
	_kanbanNumberLeft = kanbanNumber
	_kanbanInfoLeft.SetKanbanNumber(_kanbanNumberLeft)
	_kanbanObjectsLeft.SetKanbanNumber(_kanbanNumberLeft)
	
	return CheckJobSetupStatus(leftRight)
elseif leftRight = ">" or leftRight = ":" then
	if	IsRightJobRunning then
		// ClearKanban (leftRight)
	end if
	
	_kanbanNumberRight = kanbanNumber
	_kanbanInfoRight.SetKanbanNumber(_kanbanNumberRight)
	_kanbanObjectsRight.SetKanbanNumber(_kanbanNumberRight)
	
	return CheckJobSetupStatus(leftRight)
else
	MsgBox("Error handling kanban number scan.")
	return FAILURE
end if

end function

public function integer completeharness (character leftright, long harnessserial);
if	not IsValid(_PrePottingAssemblyTrans) then
	return FAILURE
end if

if	leftRight = "<" or leftRight = ";" then
	if	_PrePottingAssemblyTrans.CompleteHarnessToKanbanBin(operatorLeft, assemblyBoardLeft, harnessSerial, _kanbanNumberLeft) = SUCCESS then
		_PrePottingAssemblyTrans.CommitTrans()
	end if
	
	return Refresh()
elseif leftRight = ">" or leftRight = ":" then
	if	_PrePottingAssemblyTrans.CompleteHarnessToKanbanBin(operatorRight, assemblyBoardRight, harnessSerial, _kanbanNumberRight) = SUCCESS then
		_PrePottingAssemblyTrans.CommitTrans()
	end if
	
	return Refresh()
else
	MsgBox("Error completing harness.")
	return FAILURE
end if

end function

public function integer showscrapentry (character leftright);
if	((leftRight = "<" or leftRight = ";") and (not IsValid(_jobDetailsLeft) or not IsValid(_jobDetailsRight))) or ((leftRight = ">" or leftRight = ":") and (not IsValid(_jobScrapEntryLeft) or not IsValid (_jobScrapEntryRight))) then
	return FAILURE
end if
if	leftRight = "<" or leftRight = ";" then
	_jobDetailsLeft.ShowControl(_jobScrapEntryLeft)
	return _jobScrapEntryLeft.Refresh()
elseif	leftRight = ">" or leftRight = ":" then
	_jobDetailsRight.ShowControl(_jobScrapEntryRight)
	return _jobScrapEntryRight.Refresh()
end if

return FAILURE

end function

public function integer saveandclosescrapentry (character leftright);
//if	SaveScrapEntry(leftRight) = SUCCESS then
//	return ShowKanbanInfo(leftRight)
//end if
	
return FAILURE

end function

public function integer showkanbaninfo (character leftright);
if	((leftRight = "<" or leftRight = ";") and (not IsValid(_jobDetailsLeft) or not IsValid(_jobDetailsRight))) or ((leftRight = ">"  or leftRight = ":") and (not IsValid(_kanbanObjectsLeft) or not IsValid (_kanbanObjectsRight))) then
	return FAILURE
end if
if	leftRight = "<" or leftRight = ";" then
	return _jobDetailsLeft.ShowControl(_kanbanObjectsLeft)
elseif	leftRight = ">" or leftRight = ":" then
	return _jobDetailsRight.ShowControl(_kanbanObjectsRight)
end if

return FAILURE

end function

public function integer donescrapentry (character leftright);
if	leftRight = "<" or leftRight = ";" then
	return ShowKanbanInfo(leftRight)
elseif	leftRight = ">" or leftRight = ":" then
	return ShowKanbanInfo(leftRight)
end if

return FAILURE

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_sideBySideSplitView)
_sideBySideSplitView.SetSplitter(50)
_sideBySideSplitView.DisableSplitter()
_sideBySideSplitView.uo_1.ShowControlGroup("ActiveJob")
_sideBySideSplitView.uo_2.ShowControlGroup("ActiveJob")
_kanbanObjectsLeft.SetKanbanNumber(_kanbanNumberLeft)
_kanbanObjectsRight.SetKanbanNumber(_kanbanNumberRight)
_jobDetailsLeft.ShowControl(_kanbanObjectsLeft)
_jobDetailsRight.ShowControl(_kanbanObjectsRight)

_parentSheet.SetRedraw(true)

return SUCCESS

end function

public function integer scrapcomponent (character leftright, string componentpart);
if	not IsValid(_PrePottingAssemblyTrans) or not IsNull(componentPart, "") > "" then
	return FAILURE
end if

if	leftRight = "<" or leftRight = ";" then
	if	_PrePottingAssemblyTrans.NewScrapEntry(operatorLeft, _workOrderNumberLeft, _workOrderDetailLineNoLeft, componentPart, 1, 'Scrap') = SUCCESS then
		_PrePottingAssemblyTrans.CommitTrans()
		return Refresh()
	end if
	return FAILURE
end if

if	leftRight = ">" or leftRight = ":" then
	if	_PrePottingAssemblyTrans.NewScrapEntry(operatorRight, _workOrderNumberRight, _workOrderDetailLineNoRight, componentPart, 1, 'Scrap') = SUCCESS then
		_PrePottingAssemblyTrans.CommitTrans()
		return Refresh()
	end if
	return FAILURE
end if

return FAILURE

end function

public function integer showhideworkinstructions (character leftright);
if	not IsValid(_prePottingAssemblyTrans) then
	return FAILURE
end if

string	newPartMfgURL

if	leftRight = "<" or leftRight = ";" then
	_isShowingWorkInstructionsLeft = not _isShowingWorkInstructionsLeft
	
	if	_isShowingWorkInstructionsLeft then
		_sideBySideSplitView.uo_1.ShowControlGroup("WorkInstructions")

		if	_productionPartLeft <> _lastPartCodeLeft then
			_lastPartCodeLeft = _productionPartLeft
			
			//	Get the URL.
			if	_prePottingAssemblyTrans.GetPartMFGUrl(operatorLeft, _productionPartLeft, newPartMfgURL) <> SUCCESS then
				_prePottingAssemblyTrans.RollbackTrans()
			else
				_prePottingAssemblyTrans.CommitTrans()
				BrowserNavigate(leftRight, newPartMfgURL)
			end if
		end if
	else
		_sideBySideSplitView.uo_1.ShowControlGroup("ActiveJob")
	end if

elseif leftRight = ">" or leftRight = ":" then
	_isShowingWorkInstructionsRight = not _isShowingWorkInstructionsRight
	
	if	_isShowingWorkInstructionsRight then
		_sideBySideSplitView.uo_2.ShowControlGroup("WorkInstructions")
	
		if	_productionPartRight <> _lastPartCodeRight then
			_lastPartCodeRight = _productionPartRight
	
			//	Get the URL.
			if	_prePottingAssemblyTrans.GetPartMFGUrl(operatorRight, _productionPartRight, newPartMfgURL) <> SUCCESS then
				_prePottingAssemblyTrans.RollbackTrans()
			else
				_prePottingAssemblyTrans.CommitTrans()
				BrowserNavigate(leftRight, newPartMfgURL)
			end if
		end if
	else
		_sideBySideSplitView.uo_2.ShowControlGroup("ActiveJob")
	end if
end if

return NO_ACTION

end function

public function integer browsernavigate (character leftright, string url);
if	leftRight = "<" or leftRight = ";" then
	if	not IsValid(_workInstructionsBrowserLeft) then
		return FAILURE
	end if
	
	//	Navigate the browser.
	_workInstructionsBrowserLeft.uo_browser.Navigate(url)
elseif	leftright =  ">" or leftRight = ":" then
	if	not IsValid(_workInstructionsBrowserRight) then
		return FAILURE
	end if
	
	//	Navigate the browser.
	_workInstructionsBrowserRight.uo_browser.Navigate(url)
end if

return SUCCESS

end function

on n_prepottingassembly_controller.create
call super::create
end on

on n_prepottingassembly_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_PrePottingAssemblyTrans = create n_prepottingassembly_trans


end event

event destructor;call super::destructor;
destroy _PrePottingAssemblyTrans

end event


$PBExportHeader$n_oee_shifthistory_controller.sru
forward
global type n_oee_shifthistory_controller from n_cst_virtual_controller
end type
end forward

global type n_oee_shifthistory_controller from n_cst_virtual_controller
end type
global n_oee_shifthistory_controller n_oee_shifthistory_controller

type variables

private:
//	Model data.
date _shiftDate
int _shift

//	View references.
u_panel_headerdetail _oeeHeaderDetailPanel
u_tabpg_oee_shifthistory_shiftlist _shiftListView
u_panel_leftright _oeeShiftHistorySplitView
u_tabpg_oee_shifthistory_shiftinfo _shiftInfoView
u_tabpg_oee_shifthistory_shiftreport _shiftReportView

w_oee_shifthistory _parentSheet

//	View mode.
boolean _editingShiftInfo

//	Data context.
n_oee_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setshift (date shiftdate, integer shift, boolean hasproduction, boolean isshiftclosed)
public function integer showeditshiftinfo ()
public function integer hideeditshiftinfo ()
public function integer saveshiftinfo (decimal shifthours, string shiftnotes)
public function string getuser ()
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
_parentSheet.uo_1.ShowControl(_oeeShiftHistorySplitView)
_oeeShiftHistorySplitView.uo_1.ShowControl(_oeeHeaderDetailPanel)
_oeeShiftHistorySplitView.uo_2.ShowControl(_shiftInfoView)
_oeeHeaderDetailPanel.uo_1.ShowControl(_shiftListView)
_oeeHeaderDetailPanel.uo_2.ShowControl(_shiftReportView)

return SUCCESS

end function

public function integer createlayout ();
//	Split panel for editing shift info.
_parentSheet.OpenUserObject(_oeeShiftHistorySplitView, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_oeeShiftHistorySplitView)

//	Split panel for showing OEE header/detail.
_parentSheet.OpenUserObject(_oeeHeaderDetailPanel, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_oeeHeaderDetailPanel)
_oeeShiftHistorySplitView.uo_1.AddPanelControl(_oeeHeaderDetailPanel)

//	Shift list.
_parentSheet.OpenUserObject(_shiftlistView, "u_tabpg_oee_shifthistory_shiftlist")
_oeeHeaderDetailPanel.uo_1.AddPanelControl(_shiftlistView)
MasterListControl = _shiftlistView

//	Shift edit tab.
_parentSheet.OpenUserObject(_shiftInfoView, "u_tabpg_oee_shifthistory_shiftinfo")
_oeeShiftHistorySplitView.uo_2.AddPanelControl(_shiftInfoView)

//	Shift report tab.
_parentSheet.OpenUserObject(_shiftReportView, "u_tabpg_oee_shifthistory_shiftreport")
_oeeHeaderDetailPanel.uo_2.AddPanelControl(_shiftReportView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _shiftlistView.Refresh()

end function

public function integer setshift (date shiftdate, integer shift, boolean hasproduction, boolean isshiftclosed);
_shiftDate = shiftDate
_shift = shift

if	hasProduction and not isShiftClosed then
	ShowEditShiftInfo()
else
	HideEditShiftInfo()
end if

_shiftReportView.SetShift(_shiftDate, _shift)

return SUCCESS

end function

public function integer showeditshiftinfo ();
_parentSheet.uo_1.ShowControl(_oeeShiftHistorySplitView)
_oeeShiftHistorySplitView.uo_1.ShowControl(_oeeHeaderDetailPanel)
_shiftInfoView.SetShift(_shiftDate, _shift)
_editingShiftInfo = true

return SUCCESS

end function

public function integer hideeditshiftinfo ();
_parentSheet.uo_1.ShowControl(_oeeHeaderDetailPanel)
_shiftInfoView.Reset()

_editingShiftInfo = false

return SUCCESS

end function

public function integer saveshiftinfo (decimal shifthours, string shiftnotes);
if	not IsValid(_trans) then return FAILURE

if	_trans.SetShiftInfo(datetime(_shiftDate), _shift, shiftHours, shiftNotes) = SUCCESS then
	_trans.CommitTrans()
else
	_trans.RollbackTrans()
	return FAILURE
end if

return Refresh()

end function

public function string getuser ();
return _trans.GetUser()

end function

on n_oee_shifthistory_controller.create
call super::create
end on

on n_oee_shifthistory_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_oee_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


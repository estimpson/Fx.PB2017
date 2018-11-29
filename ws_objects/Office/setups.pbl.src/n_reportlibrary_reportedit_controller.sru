$PBExportHeader$n_reportlibrary_reportedit_controller.sru
forward
global type n_reportlibrary_reportedit_controller from n_cst_virtual_controller
end type
end forward

global type n_reportlibrary_reportedit_controller from n_cst_virtual_controller
end type
global n_reportlibrary_reportedit_controller n_reportlibrary_reportedit_controller

type variables

private:

//	State data:
boolean _isNewReport = false

//	Model data:
string _report

//	View references.
u_panel_headerdetail HeaderDetailPanel
u_tabpg_reportlibrary_reportedit_reports _reportsView
u_fxdw_reportlibrary_reportedit _reportEditView

w_reportlibrary_reportedit _parentSheet

//	Data context.
n_reportlibrary_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setactivereport (string reportname)
public function integer newreport ()
public function integer copyreport (string reportname)
public function integer renamereport (string reportname)
public function integer cancelreportchanges ()
public function integer getobjectname (string libraryname)
public function integer getlabelpath ()
public function integer getlibrarypath ()
public function integer savechanges ()
public function integer deletereport (string reportlist)
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
_parentSheet.uo_1.ShowControl(_reportsView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Create the layout panels (example, override).
_parentSheet.OpenUserObject(HeaderDetailPanel, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(HeaderDetailPanel)
_parentSheet.uo_1.ShowControl(HeaderDetailPanel)

//	Header - Details split view.
_parentSheet.OpenUserObject(_reportsView, "u_tabpg_reportlibrary_reportedit_reports")
HeaderDetailPanel.uo_1.AddPanelControl(_reportsView)
HeaderDetailPanel.uo_1.ShowControl(_reportsView)
MasterListControl = _reportsView

_parentSheet.OpenUserObject(_reportEditView, "u_fxdw_reportlibrary_reportedit")
HeaderDetailPanel.uo_2.AddPanelControl(_reportEditView)
HeaderDetailPanel.uo_2.ShowControl(_reportEditView)

return SUCCESS

end function

public function integer refresh ();
if	_reportEditView.HasChanges() then
	if	_isNewReport then
		if	MsgBox("Save changes to new report before refreshing?", Question!, OkCancel!, 1) = 2 then return NO_ACTION

		//	Do save.
		return SaveChanges()
	else
		if	MsgBox("Save changes to report [" + _report + "] before refreshing?", Question!, OkCancel!, 1) = 2 then return NO_ACTION

		//	Do save.
		return SaveChanges()
	end if
end if

_isNewReport = false
_reportsView.Refreshing = true
return _reportsView.Refresh()

end function

public function integer setactivereport (string reportname);
if	_isNewReport then
	if	MsgBox("Unsaved new report.  Do you want to save it now?", Question!, OkCancel!, 1) = 2 then return NO_ACTION
	
	if	SaveChanges() = SUCCESS then
		_report = ReportName
		return _reportEditView.SetActiveReport(_report)
	end if
end if

if	_reportEditView.HasChanges() then
	if	_report = reportName then return NO_ACTION
	
	if	MsgBox("Save changes to report [" + _report + "] before changing to report [" + reportName + "]?", Question!, OkCancel!, 1) = 2 then return NO_ACTION

	if	SaveChanges() = SUCCESS then
		_report = ReportName
		return _reportEditView.SetActiveReport(_report)
	end if
end if

_report = ReportName
return _reportEditView.SetActiveReport(_report)

end function

public function integer newreport ();
if	_reportEditView.HasChanges() then
	if	_isNewReport then
		if	MsgBox("Save changes to new report before creating a new report?", Question!, OkCancel!, 1) = 2 then return NO_ACTION

		//	Do save.
		SaveChanges()
	else
		if	MsgBox("Save changes to report [" + _report + "] before creating a new report?", Question!, OkCancel!, 1) = 2 then return NO_ACTION

		//	Do save.
		SaveChanges()
	end if
end if

_reportsView.ShowNewReport()
_report = ""
_isNewReport = true
return _reportEditView.NewReport()

end function

public function integer copyreport (string reportname);
if	_isNewReport then
	if	MsgBox("A new report must be saved before it can be copied.  Do you want to save it now?", Question!, OkCancel!, 1) = 2 then return NO_ACTION
	
	if	SaveChanges() = SUCCESS then
		_reportsView.ShowNewReport()
		_report = ""
		_isNewReport = true
		return _reportEditview.CopyReport()
	end if
end if

if	_reportEditView.HasChanges() then
	if	MsgBox("Save changes to report [" + _report + "] before creating a new copy?", Question!, OkCancel!, 1) = 2 then return NO_ACTION

	if	SaveChanges() = SUCCESS then
		_reportsView.ShowNewReport()
		_report = ""
		_isNewReport = true
		return _reportEditview.CopyReport()
	end if
end if

_reportsView.ShowNewReport()
_report = ""
_isNewReport = true
return _reportEditview.CopyReport()

end function

public function integer renamereport (string reportname);
return _reportEditView.RenameReport()


end function

public function integer cancelreportchanges ();

if	_isNewReport then
	if	MsgBox("Cancel new report?", Question!, OkCancel!, 2) = 2 then return NO_ACTION
	_isNewReport = false
	return _reportsView.Refresh()
end if

if	MsgBox("Cancel changes to report [" + _report + "]?", Question!, OkCancel!, 2) = 2 then return NO_ACTION
return _reportEditView.SetActiveReport(_report)

end function

public function integer getobjectname (string libraryname);
message.inv_Parm.of_SetItem("LibraryPath", libraryName)
message.inv_Parm.of_SetItem("ObjectType", "dat")

Open(w_select_pbobject)
long returnValue
returnValue = Message.DoubleParm
if	returnValue = CONTINUE_ACTION then
	string objectName
	objectName = message.inv_Parm.of_GetItem("PBObject", "")
	
	return _reportEditView.SetObjectName(objectName)
end if

return NO_ACTION

end function

public function integer getlabelpath ();
string filePath, fileName
integer li_rtn

string	lastKnownPath = "C:\Users\estimpson.FORE-THOUGHT\Pictures\Fore-Thought"
if	GetFileOpenName("Select Label File", filePath, fileName, "", "Label Files (*.btw),*.btw", "", 2^1 + 2^6 + 2^8 + 2^14) = 1 then
	
	_reportEditView.SetLabelPath(filePath)
	return SUCCESS
end if

return FAILURE


end function

public function integer getlibrarypath ();
string filePath, fileName
integer li_rtn

string	lastKnownPath = "C:\Users\estimpson.FORE-THOUGHT\Pictures\Fore-Thought"
if	GetFileOpenName("Select PowerBuilder Library File", filePath, fileName, "", "PowerBuilder Library Files (*.pbl;*.pbd),*.pbl;*.pbd", "", 2^1 + 2^6 + 2^8 + 2^14) = 1 then
	
	_reportEditView.SetLibraryPath(filePath)
	return SUCCESS
end if

return FAILURE

end function

public function integer savechanges ();
if	_reportEditView.Update() = SUCCESS then
	_trans.CommitTrans()
	MsgBox("Save successful!")
	return Refresh()
end if

_trans.RollbackTrans()
MsgBox("Save failed!", stopsign!)
return FAILURE

end function

public function integer deletereport (string reportlist);
if	not IsValid(_trans) then return FAILURE

if	MsgBox("Confirm deletion of the following report(s): " + reportList, Question!, OkCancel!, 2) = 2 then return NO_ACTION

if	_trans.DeleteReportList(reportList) = SUCCESS then
	_trans.CommitTrans()
	return Refresh()
end if

return FAILURE

end function

on n_reportlibrary_reportedit_controller.create
call super::create
end on

on n_reportlibrary_reportedit_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_reportlibrary_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


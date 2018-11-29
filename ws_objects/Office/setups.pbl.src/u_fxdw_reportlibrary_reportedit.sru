$PBExportHeader$u_fxdw_reportlibrary_reportedit.sru
forward
global type u_fxdw_reportlibrary_reportedit from u_fxdw
end type
end forward

global type u_fxdw_reportlibrary_reportedit from u_fxdw
integer width = 3182
integer height = 976
string dataobject = "d_reportlibrary_reportedit"
end type
global u_fxdw_reportlibrary_reportedit u_fxdw_reportlibrary_reportedit

type variables

Private:
//	Controller reference.
n_reportlibrary_reportedit_controller _myController

//	Model data:
string _report

end variables

forward prototypes
public function integer setactivereport (string reportname)
public function boolean haschanges ()
public function integer setlibrarypath (string librarypath)
public function integer setlabelpath (string labelpath)
public function integer setobjectname (string objectname)
public function integer newreport ()
public function integer renamereport ()
public function integer copyreport ()
end prototypes

public function integer setactivereport (string reportname);
_report = reportName
Object.ReportName.TabSequence = 0
return Refresh()

end function

public function boolean haschanges ();
if	RowCount() <= 0 then
	return false
end if

dwitemstatus currentRowStatus
currentRowStatus = GetItemStatus(1, 0, Primary!)
choose case currentRowStatus
	case New!, NotModified!
		return false
	case NewModified!, DataModified!
		return true
end choose
		
return false

end function

public function integer setlibrarypath (string librarypath);
if	RowCount() <= 0 then return FAILURE

Object.LibraryName[1] = libraryPath
return SUCCESS

end function

public function integer setlabelpath (string labelpath);
if	RowCount() <= 0 then return FAILURE

Object.LabelPath[1] = labelPath
return SUCCESS

end function

public function integer setobjectname (string objectname);
if	RowCount() <= 0 then return FAILURE

Object.ObjectName[1] = objectName
return SUCCESS

end function

public function integer newreport ();
Reset()
Object.ReportName.TabSequence = 1
return InsertRow(0)

end function

public function integer renamereport ();
Object.ReportName.TabSequence = 1
return SetColumn("ReportName")

end function

public function integer copyreport ();
if	RowCount() <= 0 then
	return FAILURE
end if

dwitemstatus currentRowStatus
currentRowStatus = GetItemStatus(1, 0, Primary!)
choose case currentRowStatus
	case New!
		MsgBox("Unsaved changes!", stopsign!)
		return FAILURE
	case NewModified!
		MsgBox("Unsaved changes!", stopsign!)
		return FAILURE
	case NotModified!
		SetItemStatus(1, 0, Primary!, New!)
		Object.ReportName[1]=""
		SetItemStatus(1, 0, Primary!, NotModified!)
	case DataModified!
		MsgBox("Unsaved changes!", stopsign!)
		return FAILURE
end choose
		
Object.ReportName.TabSequence = 1
return SetColumn("ReportName")

end function

on u_fxdw_reportlibrary_reportedit.create
call super::create
end on

on u_fxdw_reportlibrary_reportedit.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_report)

end event

event clicked;call super::clicked;
if	IsNull(_myController) or not IsValid(_myController) then return FAILURE
if	RowCount() <= 0 then return FAILURE

choose case lower(dwo.name)
	case "b_new"
		_myController.NewReport()
	case "b_delete"
		_myController.DeleteReport(_report)
	case "b_rename"
		_myController.RenameReport(_report)
	case "b_copy"
		_myController.CopyReport(_report)
	case "b_chooseobject"
		_myController.GetObjectName(Object.LibraryName[1])
	case "b_chooselibrary"
		_myController.GetLibraryPath()
	case "b_chooselabelpath"
		_myController.GetLabelPath()
	case "p_ok"
		_myController.SaveChanges()
	case "p_cancel"
		_myController.CancelReportChanges()
end choose

end event


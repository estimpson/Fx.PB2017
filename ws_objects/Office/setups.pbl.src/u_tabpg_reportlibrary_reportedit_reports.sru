$PBExportHeader$u_tabpg_reportlibrary_reportedit_reports.sru
forward
global type u_tabpg_reportlibrary_reportedit_reports from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_reportlibrary_reportedit_reports
end type
type cb_copy from commandbutton within u_tabpg_reportlibrary_reportedit_reports
end type
type cb_rename from commandbutton within u_tabpg_reportlibrary_reportedit_reports
end type
type cb_delete from commandbutton within u_tabpg_reportlibrary_reportedit_reports
end type
end forward

global type u_tabpg_reportlibrary_reportedit_reports from u_tabpg_dw
integer width = 2309
cb_new cb_new
cb_copy cb_copy
cb_rename cb_rename
cb_delete cb_delete
end type
global u_tabpg_reportlibrary_reportedit_reports u_tabpg_reportlibrary_reportedit_reports

type variables

Private:
//	Controller reference.
n_reportlibrary_reportedit_controller _myController

end variables

forward prototypes
public function integer deletereports ()
public function integer renamereport ()
public function integer newreport ()
public function integer copyreport ()
public function integer shownewreport ()
end prototypes

public function integer deletereports ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		string reportName, reportList
		reportName = dw_1.Object.ReportName[i]
		
		reportList += reportName + ","
	end if
next
return _myController.DeleteReport(reportList)

end function

public function integer renamereport ();
if	not IsValid(_myController) then return FAILURE
if	dw_1.GetRow() <= 0 then return FAILURE
if	dw_1.RowCount() <= 0 then return FAILURE

string reportName
reportName = dw_1.Object.ReportName[dw_1.GetRow()]

SetPointer(HourGlass!)
_myController.RenameReport(reportName)
SetPointer(Arrow!)

return SUCCESS

end function

public function integer newreport ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
_myController.NewReport()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer copyreport ();
if	not IsValid(_myController) then return FAILURE
if	dw_1.GetRow() <= 0 then return FAILURE
if	dw_1.RowCount() <= 0 then return FAILURE

string reportName
reportName = dw_1.Object.ReportName[dw_1.GetRow()]

SetPointer(HourGlass!)
_myController.CopyReport(reportName)
SetPointer(Arrow!)

return SUCCESS

end function

public function integer shownewreport ();
dw_1.InsertRow(1)
dw_1.SetRow(1)
dw_1.ScrollToRow(1)

return SUCCESS
end function

on u_tabpg_reportlibrary_reportedit_reports.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_copy=create cb_copy
this.cb_rename=create cb_rename
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_copy
this.Control[iCurrent+3]=this.cb_rename
this.Control[iCurrent+4]=this.cb_delete
end on

on u_tabpg_reportlibrary_reportedit_reports.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_copy)
destroy(this.cb_rename)
destroy(this.cb_delete)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_copy, 100, 0, 0, 0)
inv_Resize.of_Register(cb_rename, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_reportlibrary_reportedit_reports
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_reportlibrary_reportedit_reports
string dataobject = "d_reportlibrary_reportlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
//	Get the controller for this control's window.
if	not IsValid(_myController) or IsNull(_myController) then return

string reportName
if	activeRow <= 0 or activeRow > RowCount() then
	reportName = ""
	_myController.SetActiveReport(reportName)
	return
end if
reportName = Object.ReportName[activeRow]
_myController.SetActiveReport(reportName)

end event

event dw_1::selectionchanged;call super::selectionchanged;
cb_new.Enabled = SingleSelected
cb_copy.Enabled = SingleSelected
cb_rename.Enabled = SingleSelected
cb_delete.Enabled = not NoneSelected

end event

type cb_new from commandbutton within u_tabpg_reportlibrary_reportedit_reports
integer x = 1806
integer y = 8
integer width = 489
integer height = 116
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "New Report"
end type

event clicked;
NewReport()

end event

type cb_copy from commandbutton within u_tabpg_reportlibrary_reportedit_reports
integer x = 1806
integer y = 264
integer width = 489
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Copy Report"
end type

event clicked;
CopyReport()

end event

type cb_rename from commandbutton within u_tabpg_reportlibrary_reportedit_reports
integer x = 1806
integer y = 136
integer width = 489
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rename Report"
end type

event clicked;
RenameReport()

end event

type cb_delete from commandbutton within u_tabpg_reportlibrary_reportedit_reports
integer x = 1806
integer y = 392
integer width = 489
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete Report(s)"
end type

event clicked;
DeleteReports()

end event


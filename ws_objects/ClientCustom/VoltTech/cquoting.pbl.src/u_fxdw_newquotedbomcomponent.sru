$PBExportHeader$u_fxdw_newquotedbomcomponent.sru
forward
global type u_fxdw_newquotedbomcomponent from u_fxdw
end type
end forward

global type u_fxdw_newquotedbomcomponent from u_fxdw
string tag = "NewBOMComponent"
integer width = 4608
integer height = 1572
string dataobject = "d_qtbom_newparteditx3"
boolean hscrollbar = true
end type
global u_fxdw_newquotedbomcomponent u_fxdw_newquotedbomcomponent

type variables

//	Controller reference.
private n_quoting_newbom_controller _myController

string PartCode

end variables
on u_fxdw_newquotedbomcomponent.create
call super::create
end on

on u_fxdw_newquotedbomcomponent.destroy
call super::destroy
end on

event pfc_retrieve;call super::pfc_retrieve;
if	Retrieve(PartCode) <= 0 then
	return FAILURE
end if

datawindowchild dddw
string	partClass
if	GetChild("PartType", dddw) = SUCCESS then
	partClass = Object.PartClass[1]
	dddw.SetTransObject(SQLCA)
	if	dddw.Retrieve(partClass) <= 0 then
		dddw.InsertRow(0)
	end if
end if

return RowCount()

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_quoting_controller parentController
parentController = myParentWindow.Container.of_GetItem("Controller")
_myController = parentController.GetNewBOMController()

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

if	not IsValid(_myController) or IsNull(_myController) then return

choose case dwo.Name
	case "p_documents", "p_editattachments"
//		_myController.EditAttachments(PartCode)
	case "p_editcrossreferences", "crossreferences"
//		_myController.EditCrossReferences(PartCode)
	case "p_editrelatedparts", "relatedparts"
//		_myController.EditRelatedParts(PartCode)
	case "p_relatedparts"
//		_myController.ShowRelatedPartContextMenu(PartCode)
	case "p_editcustomfields", "customfields"
//		_myController.EditPartCustom(PartCode)
	case "imagefilename", "p_choosedefaultpicture"
		string imageFileName
		imageFileName = object.ImageFileName[row]
//		_myController.BrowserNavigate(imageFileName)
	case "drawingfilename", "p_choosedefaultdrawing"
		string drawingFileName
		drawingFileName = object.DrawingFileName[row]
//		_myController.BrowserNavigate(drawingFileName)
end choose

end event

event updateend;call super::updateend;
//	Commit changes.
commit using SQLCA  ;

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.Refresh()

end event

event itemchanged;call super::itemchanged;
if	row < 0 then
	return
end if

choose case lower(dwo.Name)
	case lower("PartClass")
		datawindowchild dddw
		string	partClass
		if	GetChild("PartType", dddw) = SUCCESS then
			partClass = data
			dddw.SetTransObject(SQLCA)
			if	dddw.Retrieve(partClass) <= 0 then
				dddw.InsertRow(0)
			end if
		end if
		string nullString
		SetNull(nullString)
		object.PartType[row] = nullString
end choose
end event


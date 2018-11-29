$PBExportHeader$u_fxdw_partmaster_partedit.sru
forward
global type u_fxdw_partmaster_partedit from u_fxdw
end type
end forward

global type u_fxdw_partmaster_partedit from u_fxdw
integer width = 4608
integer height = 1572
string dataobject = "d_partmaster_parteditx3"
boolean hscrollbar = true
end type
global u_fxdw_partmaster_partedit u_fxdw_partmaster_partedit

type variables

string PartCode

end variables

on u_fxdw_partmaster_partedit.create
call super::create
end on

on u_fxdw_partmaster_partedit.destroy
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

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_deletepart"
		myController.DeletePart(PartCode)
	case "p_renamepart"
		myController.RenamePart(PartCode)
	case "p_template"
		string xx
		xx = String(Object.Datawindow.Data.XML)
		clipboard(xx)
		MessageBox("fyi", String(Object.Datawindow.Data.XML))
	case "p_newpart"
		myController.NewPart()
	case "p_copypart"
		myController.CopyPart(PartCode)
	case "p_documents", "p_editattachments"
		myController.EditAttachments(PartCode)
	case "p_editcrossreferences", "crossreferences"
		myController.EditCrossReferences(PartCode)
	case "p_editrelatedparts", "relatedparts"
		myController.EditRelatedParts(PartCode)
	case "p_relatedparts"
		myController.ShowRelatedPartContextMenu(PartCode)
	case "p_editcustomfields", "customfields"
		myController.EditPartCustom(PartCode)
	case "imagefilename", "p_choosedefaultpicture"
		string imageFileName
		imageFileName = object.ImageFileName[row]
		myController.BrowserNavigate(imageFileName)
	case "drawingfilename", "p_choosedefaultdrawing"
		string drawingFileName
		drawingFileName = object.DrawingFileName[row]
		myController.BrowserNavigate(drawingFileName)
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


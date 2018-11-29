$PBExportHeader$u_fxdw_partmaster_attachmentcategoryedit.sru
forward
global type u_fxdw_partmaster_attachmentcategoryedit from u_fxdw
end type
end forward

global type u_fxdw_partmaster_attachmentcategoryedit from u_fxdw
integer width = 1778
integer height = 688
string dataobject = "d_partmaster_attachmentcategoryedit"
boolean hscrollbar = true
end type
global u_fxdw_partmaster_attachmentcategoryedit u_fxdw_partmaster_attachmentcategoryedit

type variables

string _categoryName
end variables

forward prototypes
public function integer setcategory (string categoryname)
end prototypes

public function integer setcategory (string categoryname);
_categoryName = categoryName
return Refresh()

end function

on u_fxdw_partmaster_attachmentcategoryedit.create
call super::create
end on

on u_fxdw_partmaster_attachmentcategoryedit.destroy
call super::destroy
end on

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
	case "p_ok"
		//	Save category.
		AcceptText()
		Update()
		myController.EndEditAttachmentCategory(SUCCESS, _categoryName)
	case "p_cancel"
		Reset()
		myController.EndEditAttachmentCategory(NO_ACTION, _categoryName)
end choose

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_categoryName)

end event

event updateend;call super::updateend;
commit using SQLCA ;

end event

event retrieveend;call super::retrieveend;
if	rowcount < 1 then
	MessageBox("fyi", "Building new category failed.")
end if

//	Set the status of the CategoryColumn to modified if the row is new.
if	Object.IsNew[1] then
	SetItemStatus(1, "CategoryName", Primary!, DataModified!)
end if
end event


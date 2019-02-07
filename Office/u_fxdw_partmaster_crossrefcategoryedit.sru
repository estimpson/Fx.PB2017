HA$PBExportHeader$u_fxdw_partmaster_crossrefcategoryedit.sru
forward
global type u_fxdw_partmaster_crossrefcategoryedit from u_fxdw
end type
end forward

global type u_fxdw_partmaster_crossrefcategoryedit from u_fxdw
integer width = 1778
integer height = 488
string dataobject = "d_partmaster_crossreferencecategoryedit"
boolean hscrollbar = true
end type
global u_fxdw_partmaster_crossrefcategoryedit u_fxdw_partmaster_crossrefcategoryedit

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

on u_fxdw_partmaster_crossrefcategoryedit.create
call super::create
end on

on u_fxdw_partmaster_crossrefcategoryedit.destroy
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

string categoryDescription
choose case dwo.Name
	case "p_ok"
		//	Save category.
		AcceptText()
		Update()
		categoryDescription = Object.CategoryDescription[1]
		myController.EndEditCrossReferenceCategory(SUCCESS, _categoryName, categoryDescription)
	case "p_cancel"
		Reset()
		SetNull(categoryDescription)
		myController.EndEditCrossReferenceCategory(NO_ACTION, _categoryName, categoryDescription)
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


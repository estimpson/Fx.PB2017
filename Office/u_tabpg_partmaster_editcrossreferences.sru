HA$PBExportHeader$u_tabpg_partmaster_editcrossreferences.sru
forward
global type u_tabpg_partmaster_editcrossreferences from u_tabpg_dw
end type
type cb_save from commandbutton within u_tabpg_partmaster_editcrossreferences
end type
type cb_close from commandbutton within u_tabpg_partmaster_editcrossreferences
end type
end forward

global type u_tabpg_partmaster_editcrossreferences from u_tabpg_dw
integer width = 2304
cb_save cb_save
cb_close cb_close
end type
global u_tabpg_partmaster_editcrossreferences u_tabpg_partmaster_editcrossreferences

type variables

private string _partCode
private long _categoryEditRow

end variables

forward prototypes
public function integer setpart (string partcode)
public function integer refocuscategory ()
public function integer save ()
public subroutine close ()
public function integer setcategory (string categoryname, string categorydescription)
end prototypes

public function integer setpart (string partcode);
//	Set part and refresh.
_partCode = partCode
return Refresh()

end function

public function integer refocuscategory ();
if	_categoryEditRow < 1 or _categoryEditRow > dw_1.RowCount() then
	MessageBox("FYI", "Error refocusing category after category edit.")
end if

dw_1.SetRow(_categoryEditRow)
dw_1.Object.CategoryName[_categoryEditRow] = ""
dw_1.SetColumn("CategoryName")
_categoryEditRow = -1

return SUCCESS

end function

public function integer save ();
//	End edits.
dw_1.AcceptText()

//	Simply update.
dw_1.Update()

return SUCCESS

end function

public subroutine close ();
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

dw_1.Reset()
myController.EndEditCrossReferences()

end subroutine

public function integer setcategory (string categoryname, string categorydescription);
if	_categoryEditRow < 1 or _categoryEditRow > dw_1.RowCount() then
	MessageBox("FYI", "Error setting category after category edit.")
end if

//	Copy values for the category.
dw_1.Object.CategoryName[_categoryEditRow] = categoryName
dw_1.Object.CategoryDescription[_categoryEditRow] = categoryDescription

_categoryEditRow = -1

return SUCCESS

end function

on u_tabpg_partmaster_editcrossreferences.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_close
end on

on u_tabpg_partmaster_editcrossreferences.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_close)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_close, 100, 100, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_editcrossreferences
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_editcrossreferences
string dataobject = "d_partmaster_partcrossreflist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::itemchanged;call super::itemchanged;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case Upper(dwo.Name)
	case upper("CategoryName")
		if	IsNull(data, "") = "" then
			MessageBox(gnv_App.iapp_Object.DisplayName, "Enter a new category name.")
			return 2
		end if
		
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Do you want to create a category named " + data + "?", Question!, YesNo!, 1) = 2 then
			return 2
		end if
			
		//	Display attachment category maintenance.
		_categoryEditRow = row
		myController.EditCrossReferenceCategory(data)
		return
end choose

end event

event dw_1::clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_partmaster_partedit_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

SetRedraw(false)
choose case upper(dwo.Name)
	case Upper("c_newcrossreference")
		long newRow
		newRow = dw_1.InsertRow(0)
		dw_1.ScrollToRow(newRow)
		dw_1.SetRow(newRow)
		
	case Upper("c_deletecrossreference")
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure you want to remove the selected cross reference?", Question!, YesNo!, 2) = 2 then
			SetRedraw(true)
			return
		end if
		dw_1.Object.CrossReference[row] = ""
		
end choose
SetRedraw(true)

end event

event dw_1::updateend;call super::updateend;
//	Close transaction.
commit using SQLCA  ;

end event

type cb_save from commandbutton within u_tabpg_partmaster_editcrossreferences
integer x = 1806
integer y = 16
integer width = 443
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;
//	Save
if	Save() = SUCCESS then
	
	//	and New...
	Refresh()
end if

end event

type cb_close from commandbutton within u_tabpg_partmaster_editcrossreferences
integer x = 1806
integer y = 972
integer width = 443
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;
//	Close
Close()

end event


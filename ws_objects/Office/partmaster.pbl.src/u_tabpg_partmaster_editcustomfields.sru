$PBExportHeader$u_tabpg_partmaster_editcustomfields.sru
forward
global type u_tabpg_partmaster_editcustomfields from u_tabpg_dw
end type
type cb_save from commandbutton within u_tabpg_partmaster_editcustomfields
end type
type cb_close from commandbutton within u_tabpg_partmaster_editcustomfields
end type
end forward

global type u_tabpg_partmaster_editcustomfields from u_tabpg_dw
integer width = 2304
cb_save cb_save
cb_close cb_close
end type
global u_tabpg_partmaster_editcustomfields u_tabpg_partmaster_editcustomfields

type variables

private string _partCode
end variables

forward prototypes
public function integer setpart (string partcode)
public function integer save ()
public subroutine close ()
end prototypes

public function integer setpart (string partcode);
//	Set part and refresh.
_partCode = partCode
return Refresh()

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
myController.EndEditCustomFields()

end subroutine

on u_tabpg_partmaster_editcustomfields.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_close
end on

on u_tabpg_partmaster_editcustomfields.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_close)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_close, 100, 100, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_editcustomfields
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_editcustomfields
string dataobject = "d_partmaster_partcustomfieldlist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

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
	case Upper("c_delete")
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure you want to remove the selected value(s)?", Question!, YesNo!, 2) = 2 then
			SetRedraw(true)
			return
		end if
		dw_1.Object.StringValue[row] = ""
	
	case Upper("c_choosevalues"), Upper("StringValue")
		long allowMultipleValues
		allowMultipleValues = dw_1.Object.AllowMultipleValues[row]
		if	allowMultipleValues = 0 then return
		
		string customFieldName
		customFieldName = dw_1.Object.CustomFieldName[row]
		myController.EditCustomFieldMultiValue(_partCode, customFieldName)
end choose
SetRedraw(true)

end event

event dw_1::updateend;call super::updateend;
//	Close transaction.
commit using SQLCA  ;

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 or activerow > RowCount() then return

//	Change the drop down for this field's value.
datawindowchild dwcValues
if	GetChild("StringValue", dwcValues) = 1 then
	dwcValues.SetTransObject(SQLCA)
	string customFieldName
	customFieldName = Object.CustomFieldName[activeRow]
	dwcValues.Retrieve(customFieldName)
end if

end event

type cb_save from commandbutton within u_tabpg_partmaster_editcustomfields
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

type cb_close from commandbutton within u_tabpg_partmaster_editcustomfields
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


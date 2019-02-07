HA$PBExportHeader$u_tabpg_partmaster_editcustomfieldmvalue.sru
forward
global type u_tabpg_partmaster_editcustomfieldmvalue from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_partmaster_editcustomfieldmvalue
end type
type cb_close from commandbutton within u_tabpg_partmaster_editcustomfieldmvalue
end type
type cb_save from commandbutton within u_tabpg_partmaster_editcustomfieldmvalue
end type
end forward

global type u_tabpg_partmaster_editcustomfieldmvalue from u_tabpg_dw
integer width = 2304
cb_new cb_new
cb_close cb_close
cb_save cb_save
end type
global u_tabpg_partmaster_editcustomfieldmvalue u_tabpg_partmaster_editcustomfieldmvalue

type variables

private string _partCode
private string _customFieldName

end variables

forward prototypes
public function integer save ()
public subroutine close ()
public function integer newvalue ()
public function integer setpartcustomfieldname (string partcode, string customfieldname)
end prototypes

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
myController.EndEditCustomFieldMultiValue(SUCCESS)

end subroutine

public function integer newvalue ();
long newRow
newRow = dw_1.InsertRow(0)
dw_1.ScrollToRow(newRow)
dw_1.SetRow(newRow)
dw_1.Object.PartCode[newRow] = _partCode
dw_1.Object.CustomFieldName[newRow] = _customFieldName

return newRow

end function

public function integer setpartcustomfieldname (string partcode, string customfieldname);
//	Set part and refresh.
_partCode = partCode
_customFieldName = customFieldName
return Refresh()

end function

on u_tabpg_partmaster_editcustomfieldmvalue.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_close=create cb_close
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
end on

on u_tabpg_partmaster_editcustomfieldmvalue.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_close)
destroy(this.cb_save)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_close, 100, 100, 0, 0)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partmaster_editcustomfieldmvalue
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partmaster_editcustomfieldmvalue
string dataobject = "d_partmaster_partcustomfieldvaluelist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode, _customFieldName)

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
	case Upper("c_new")
		NewValue()
		
end choose
SetRedraw(true)

end event

event dw_1::updateend;call super::updateend;
//	Close transaction.
commit using SQLCA  ;

end event

type cb_new from commandbutton within u_tabpg_partmaster_editcustomfieldmvalue
integer x = 1806
integer y = 24
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
string text = "New"
end type

event clicked;
NewValue()

end event

type cb_close from commandbutton within u_tabpg_partmaster_editcustomfieldmvalue
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

type cb_save from commandbutton within u_tabpg_partmaster_editcustomfieldmvalue
integer x = 1806
integer y = 156
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
string text = "Save"
end type

event clicked;
//	Save
if	Save() = SUCCESS then
	
	//	and New...
	Refresh()
end if

end event


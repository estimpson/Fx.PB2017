$PBExportHeader$u_tabpg_shipping_qab_qabcategories.sru
forward
global type u_tabpg_shipping_qab_qabcategories from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_shipping_qab_qabcategories
end type
type cb_2 from commandbutton within u_tabpg_shipping_qab_qabcategories
end type
type cb_3 from commandbutton within u_tabpg_shipping_qab_qabcategories
end type
end forward

global type u_tabpg_shipping_qab_qabcategories from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global u_tabpg_shipping_qab_qabcategories u_tabpg_shipping_qab_qabcategories

type variables

Private:
//	Controller reference.
n_shipping_qab_controller _myController

end variables

forward prototypes
public function integer save ()
end prototypes

public function integer save ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
dw_1.AcceptText()
_myController.SaveCategories()
SetPointer(Arrow!)

return SUCCESS

end function

on u_tabpg_shipping_qab_qabcategories.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on u_tabpg_shipping_qab_qabcategories.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 100, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_qab_qabcategories
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_qab_qabcategories
integer y = 76
string dataobject = "d_custom_shipping_qab_categories"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_1 from commandbutton within u_tabpg_shipping_qab_qabcategories
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 40
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
dw_1.InsertRow(0)

end event

type cb_2 from commandbutton within u_tabpg_shipping_qab_qabcategories
integer x = 1806
integer y = 136
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete"
end type

event clicked;
dw_1.DeleteRow(dw_1.GetRow())

end event

type cb_3 from commandbutton within u_tabpg_shipping_qab_qabcategories
integer x = 1806
integer y = 972
integer width = 407
integer height = 112
integer taborder = 60
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
Save()

end event


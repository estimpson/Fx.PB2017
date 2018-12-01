$PBExportHeader$u_tabpg_shipping_qab_partqabs.sru
forward
global type u_tabpg_shipping_qab_partqabs from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_shipping_qab_partqabs
end type
end forward

global type u_tabpg_shipping_qab_partqabs from u_tabpg_dw
integer width = 2309
cb_1 cb_1
end type
global u_tabpg_shipping_qab_partqabs u_tabpg_shipping_qab_partqabs

type variables

Private:
//	Controller reference.
n_shipping_qab_controller _myController

end variables

forward prototypes
public function integer func2 ()
public function integer save ()
end prototypes

public function integer func2 ();
if	not IsValid(_myController) then return FAILURE

dw_1.AcceptText()
int selectedRows[]
selectedRows = dw_1.object.isselected.primary

int i
for i = 1 to UpperBound(selectedRows)
	if	selectedRows[i] = 1 then
		long	someValue
		someValue = dw_1.Object.SomeValue[i]
		
		_myController.Func2(someValue)
	end if
next

return SUCCESS
end function

public function integer save ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
dw_1.AcceptText()
_myController.SavePartQABs()
SetPointer(Arrow!)

return SUCCESS

end function

on u_tabpg_shipping_qab_partqabs.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on u_tabpg_shipping_qab_partqabs.destroy
call super::destroy
destroy(this.cb_1)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_qab_partqabs
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_qab_partqabs
string dataobject = "d_custom_shipping_qab_partqabs"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_1 from commandbutton within u_tabpg_shipping_qab_partqabs
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
string text = "Save"
end type

event clicked;Save()

end event


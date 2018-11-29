$PBExportHeader$u_tabpg_shipping_requiresrelabel.sru
forward
global type u_tabpg_shipping_requiresrelabel from u_tabpg_dw
end type
type cb_relabel from commandbutton within u_tabpg_shipping_requiresrelabel
end type
end forward

global type u_tabpg_shipping_requiresrelabel from u_tabpg_dw
integer width = 2629
cb_relabel cb_relabel
end type
global u_tabpg_shipping_requiresrelabel u_tabpg_shipping_requiresrelabel

type variables

private:
string _shipperNumber
n_cst_shipping_controller _myController

end variables

forward prototypes
public function integer setshippernumber (string shippernumber)
public function integer reset ()
end prototypes

public function integer setshippernumber (string shippernumber);
_shipperNumber = shipperNumber
return Refresh()

end function

public function integer reset ();
SetNull (_shipperNumber)
return dw_1.Reset()

end function

on u_tabpg_shipping_requiresrelabel.create
int iCurrent
call super::create
this.cb_relabel=create cb_relabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_relabel
end on

on u_tabpg_shipping_requiresrelabel.destroy
call super::destroy
destroy(this.cb_relabel)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_relabel.X + (cb_relabel.X - gb_1.X - gb_1.Width) + cb_relabel.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_requiresrelabel
string text = "Objects to Relabel"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_requiresrelabel
string dataobject = "d_shipping_requiredrelabelobjectlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_shipperNumber)

end event

type cb_relabel from commandbutton within u_tabpg_shipping_requiresrelabel
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Relabel"
end type

event clicked;
if	not IsValid(_myController) then return

int i
for i = 1 to dw_1.RowCount()
	long serialNumber
	string labelFormat
	serialNumber = dw_1.object.Serial[i]
	labelFormat = dw_1.object.LabelFormat[i]
	
	_myController.PrintLabel(serialNumber, labelFormat)
next

end event


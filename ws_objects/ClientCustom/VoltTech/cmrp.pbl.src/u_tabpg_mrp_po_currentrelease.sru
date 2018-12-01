$PBExportHeader$u_tabpg_mrp_po_currentrelease.sru
forward
global type u_tabpg_mrp_po_currentrelease from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_mrp_po_currentrelease
end type
type cb_2 from commandbutton within u_tabpg_mrp_po_currentrelease
end type
end forward

global type u_tabpg_mrp_po_currentrelease from u_tabpg_dw
integer width = 3858
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_mrp_po_currentrelease u_tabpg_mrp_po_currentrelease

type variables

Private:
//	Controller reference.
n_mrp_purchasing_controller _myController

//	Model.
long _poNumber

end variables
forward prototypes
public function integer setponumber (long ponumber)
public function integer updatepo ()
end prototypes

public function integer setponumber (long ponumber);
_poNumber = poNumber
return Refresh()

end function

public function integer updatepo ();
if	not IsValid(_myController) then return FAILURE

_myController.UpdatePO(_poNumber)

return SUCCESS
end function

on u_tabpg_mrp_po_currentrelease.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_mrp_po_currentrelease.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mrp_po_currentrelease
string text = "Current Releases"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mrp_po_currentrelease
string dataobject = "d_mrp_po_currentrelease"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_poNumber)

end event

type cb_1 from commandbutton within u_tabpg_mrp_po_currentrelease
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
string text = "Update PO"
end type

event clicked;UpdatePO()

end event

type cb_2 from commandbutton within u_tabpg_mrp_po_currentrelease
boolean visible = false
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
string text = "func2"
end type


$PBExportHeader$u_tabpg_emp_editpos_poheaders.sru
forward
global type u_tabpg_emp_editpos_poheaders from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_emp_editpos_poheaders
end type
end forward

global type u_tabpg_emp_editpos_poheaders from u_tabpg_dw
integer width = 2309
cb_1 cb_1
end type
global u_tabpg_emp_editpos_poheaders u_tabpg_emp_editpos_poheaders

type variables

Private:
//	Controller reference.
n_emp_editpos_controller _myController

end variables

on u_tabpg_emp_editpos_poheaders.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on u_tabpg_emp_editpos_poheaders.destroy
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_emp_editpos_poheaders
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_emp_editpos_poheaders
string dataobject = "d_emp_poheaders"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) then return

string poNumber
if	activeRow < 1 or activeRow > rowcount() then
	SetNull(poNumber)
	_myController.SetActivePONumber (poNumber)
	return
end if

poNumber = object.PONumber[activeRow]
_myController.SetActivePONumber (poNumber)

end event

type cb_1 from commandbutton within u_tabpg_emp_editpos_poheaders
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

event clicked;
if	dw_1.Update() = SUCCESS then
	commit using SQLCA  ;
else
	rollback using SQLCA  ;
end if

end event


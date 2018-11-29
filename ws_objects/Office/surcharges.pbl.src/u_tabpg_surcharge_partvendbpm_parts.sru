$PBExportHeader$u_tabpg_surcharge_partvendbpm_parts.sru
forward
global type u_tabpg_surcharge_partvendbpm_parts from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_surcharge_partvendbpm_parts
end type
type cb_2 from commandbutton within u_tabpg_surcharge_partvendbpm_parts
end type
end forward

global type u_tabpg_surcharge_partvendbpm_parts from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_surcharge_partvendbpm_parts u_tabpg_surcharge_partvendbpm_parts

type variables

Private:
//	Controller reference.
n_surcharge_partvendbpm_controller _myController

end variables

on u_tabpg_surcharge_partvendbpm_parts.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_surcharge_partvendbpm_parts.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_partvendbpm_parts
string text = "Purchased Parts"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_partvendbpm_parts
string dataobject = "d_surcharge_purchasedpartlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
string activePart
if	activerow <= 0 then
	activePart = ''
else
	activePart = dw_1.object.Code[activerow]
end if
_myController.SetActivePart(activePart)

end event

type cb_1 from commandbutton within u_tabpg_surcharge_partvendbpm_parts
boolean visible = false
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
string text = "func1"
end type

type cb_2 from commandbutton within u_tabpg_surcharge_partvendbpm_parts
boolean visible = false
integer x = 1801
integer y = 156
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


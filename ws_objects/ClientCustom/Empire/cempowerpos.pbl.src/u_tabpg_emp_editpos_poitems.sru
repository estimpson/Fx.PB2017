$PBExportHeader$u_tabpg_emp_editpos_poitems.sru
forward
global type u_tabpg_emp_editpos_poitems from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_emp_editpos_poitems
end type
end forward

global type u_tabpg_emp_editpos_poitems from u_tabpg_dw
integer width = 2309
cb_1 cb_1
end type
global u_tabpg_emp_editpos_poitems u_tabpg_emp_editpos_poitems

type variables

Private:
//	Controller reference.
n_emp_editpos_controller _myController

//	Model data.
string _PONumber

end variables
forward prototypes
public function integer setponumber (string ponumber)
end prototypes

public function integer setponumber (string ponumber);
_PONumber = poNumber
return dw_1.Refresh()

end function

on u_tabpg_emp_editpos_poitems.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on u_tabpg_emp_editpos_poitems.destroy
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_emp_editpos_poitems
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_emp_editpos_poitems
string dataobject = "d_emp_poitems"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_PONumber)

end event

type cb_1 from commandbutton within u_tabpg_emp_editpos_poitems
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


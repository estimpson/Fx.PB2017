$PBExportHeader$u_tabpg_setup_employees.sru
forward
global type u_tabpg_setup_employees from u_tabpg_dw
end type
type cb_relabel from commandbutton within u_tabpg_setup_employees
end type
end forward

global type u_tabpg_setup_employees from u_tabpg_dw
integer width = 2386
cb_relabel cb_relabel
end type
global u_tabpg_setup_employees u_tabpg_setup_employees

type variables

private:
n_setup_employees_controller _myController

end variables

on u_tabpg_setup_employees.create
int iCurrent
call super::create
this.cb_relabel=create cb_relabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_relabel
end on

on u_tabpg_setup_employees.destroy
call super::destroy
destroy(this.cb_relabel)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_relabel.X + (cb_relabel.X - gb_1.X - gb_1.Width) + cb_relabel.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_setup_employees
string text = "Employees"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_setup_employees
string dataobject = "d_setup_employeelist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_relabel from commandbutton within u_tabpg_setup_employees
integer x = 1810
integer y = 24
integer width = 471
integer height = 112
integer taborder = 100
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

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		_myController.PrintEmployeeLabel(dw_1.object.RowID[row])
	end if
next

_myController.Refresh()

end event


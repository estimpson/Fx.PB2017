HA$PBExportHeader$u_tabpg_wireharnesses_list.sru
forward
global type u_tabpg_wireharnesses_list from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_wireharnesses_list
end type
type cb_relabel from commandbutton within u_tabpg_wireharnesses_list
end type
end forward

global type u_tabpg_wireharnesses_list from u_tabpg_dw
integer width = 2382
cb_new cb_new
cb_relabel cb_relabel
end type
global u_tabpg_wireharnesses_list u_tabpg_wireharnesses_list

type variables

private:

n_wireharnessinquiry_controller _myController

end variables

on u_tabpg_wireharnesses_list.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_relabel=create cb_relabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_relabel
end on

on u_tabpg_wireharnesses_list.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_relabel)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_wireharnesses_list
string text = "Wire Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_wireharnesses_list
string dataobject = "d_wireharnesslist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
datawindowchild dddw

if	GetChild("Status", dddw) = SUCCESS then
	dddw.SetTransObject(SQLCA)
	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
		dddw.InsertRow(0)
	end if
end if

return Retrieve('')

end event

type cb_new from commandbutton within u_tabpg_wireharnesses_list
integer x = 1810
integer y = 12
integer width = 471
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowNewHarnesses()

end event

type cb_relabel from commandbutton within u_tabpg_wireharnesses_list
integer x = 1810
integer y = 144
integer width = 471
integer height = 112
integer taborder = 80
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
		_myController.PrintHarnessLabel(dw_1.object.SerialNumber[row])
	end if
next

_myController.Refresh()

end event


$PBExportHeader$u_tabpg_quotebom_setup.sru
forward
global type u_tabpg_quotebom_setup from u_tabpg_dw
end type
type cb_new from commandbutton within u_tabpg_quotebom_setup
end type
end forward

global type u_tabpg_quotebom_setup from u_tabpg_dw
integer width = 2427
cb_new cb_new
end type
global u_tabpg_quotebom_setup u_tabpg_quotebom_setup

type variables

private:

n_quoting_controller _myController
string _quoteNumber

end variables

forward prototypes
public function integer showallhotspots (boolean flag)
public function integer showcolumncomment ()
public function integer setquotenumber (string quotenumber)
end prototypes

public function integer showallhotspots (boolean flag);
if	not IsValid(dw_1.ColumnComments) then return FAILURE

return dw_1.ColumnComments.ShowAllHotspots(flag)

end function

public function integer showcolumncomment ();
if	not IsValid(dw_1.ColumnComments) then return FAILURE

return dw_1.ColumnComments.ShowComment()

end function

public function integer setquotenumber (string quotenumber);
_quoteNumber = quoteNumber
return Refresh()

end function

on u_tabpg_quotebom_setup.create
int iCurrent
call super::create
this.cb_new=create cb_new
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
end on

on u_tabpg_quotebom_setup.destroy
call super::destroy
destroy(this.cb_new)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_new.X + (cb_new.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_quotebom_setup
string text = "Quote BOM"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_quotebom_setup
string dataobject = "d_qt_quotebom_setup"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_quoteNumber)

end event

type cb_new from commandbutton within u_tabpg_quotebom_setup
integer x = 1810
integer y = 12
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
string text = "New"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowNewQuotedBOMComponent()

end event


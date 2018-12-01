$PBExportHeader$u_tabpg_prepottingassembly_kanbanobjects.sru
forward
global type u_tabpg_prepottingassembly_kanbanobjects from u_tabpg_dw
end type
type cb_scrap from commandbutton within u_tabpg_prepottingassembly_kanbanobjects
end type
end forward

global type u_tabpg_prepottingassembly_kanbanobjects from u_tabpg_dw
integer width = 2309
cb_scrap cb_scrap
end type
global u_tabpg_prepottingassembly_kanbanobjects u_tabpg_prepottingassembly_kanbanobjects

type variables

public:
char LeftRight

private:

string	_kanbanNumber
n_prepottingassembly_controller _myController

end variables

forward prototypes
public function integer setkanbannumber (string kanbannumber)
end prototypes

public function integer setkanbannumber (string kanbannumber);
_kanbanNumber = kanbanNumber
return Refresh()

end function

on u_tabpg_prepottingassembly_kanbanobjects.create
int iCurrent
call super::create
this.cb_scrap=create cb_scrap
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_scrap
end on

on u_tabpg_prepottingassembly_kanbanobjects.destroy
call super::destroy
destroy(this.cb_scrap)
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_scrap.X + (cb_scrap.X - gb_1.X - gb_1.Width) + cb_scrap.Width, gb_1.Y + gb_1.Height)
//inv_Resize.of_Register(cb_scrap, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_prepottingassembly_kanbanobjects
string text = "Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_prepottingassembly_kanbanobjects
string dataobject = "d_prepottingassembly_kanbanobjectlist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_kanbanNumber)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

type cb_scrap from commandbutton within u_tabpg_prepottingassembly_kanbanobjects
boolean visible = false
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
string text = "View Scrap"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowScrapEntry(LeftRight)

end event


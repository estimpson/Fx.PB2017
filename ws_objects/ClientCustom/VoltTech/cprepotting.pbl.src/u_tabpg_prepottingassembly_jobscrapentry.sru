$PBExportHeader$u_tabpg_prepottingassembly_jobscrapentry.sru
forward
global type u_tabpg_prepottingassembly_jobscrapentry from u_tabpg_dw
end type
type cb_save from commandbutton within u_tabpg_prepottingassembly_jobscrapentry
end type
type cb_saveandclose from commandbutton within u_tabpg_prepottingassembly_jobscrapentry
end type
type cb_done from commandbutton within u_tabpg_prepottingassembly_jobscrapentry
end type
end forward

global type u_tabpg_prepottingassembly_jobscrapentry from u_tabpg_dw
integer width = 2510
cb_save cb_save
cb_saveandclose cb_saveandclose
cb_done cb_done
end type
global u_tabpg_prepottingassembly_jobscrapentry u_tabpg_prepottingassembly_jobscrapentry

type variables

public:
char LeftRight

private:

string	_productionPart
n_prepottingassembly_controller _myController

end variables

forward prototypes
public function integer setproductionpart (string productionpart)
end prototypes

public function integer setproductionpart (string productionpart);
_productionPart = productionPart
return Refresh()

end function

on u_tabpg_prepottingassembly_jobscrapentry.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_saveandclose=create cb_saveandclose
this.cb_done=create cb_done
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_saveandclose
this.Control[iCurrent+3]=this.cb_done
end on

on u_tabpg_prepottingassembly_jobscrapentry.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_saveandclose)
destroy(this.cb_done)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_saveandclose, 100, 0, 0, 0)
inv_Resize.of_Register(cb_done, 100, 100, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_prepottingassembly_jobscrapentry
string text = "Harness Components"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_prepottingassembly_jobscrapentry
string dataobject = "d_prepottingassembly_jobscrapentry"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_productionPart)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

type cb_save from commandbutton within u_tabpg_prepottingassembly_jobscrapentry
integer x = 1810
integer y = 12
integer width = 471
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;
if	not IsValid(_myController) then return

//_myController.SaveScrapEntry(leftRight)

end event

type cb_saveandclose from commandbutton within u_tabpg_prepottingassembly_jobscrapentry
integer x = 1810
integer y = 144
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
string text = "Save and Close"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.SaveAndCloseScrapEntry(leftRight)

end event

type cb_done from commandbutton within u_tabpg_prepottingassembly_jobscrapentry
integer x = 1810
integer y = 972
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
string text = "Done"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.DoneScrapEntry(leftRight)

end event


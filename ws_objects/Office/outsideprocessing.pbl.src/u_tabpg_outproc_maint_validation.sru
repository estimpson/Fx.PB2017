$PBExportHeader$u_tabpg_outproc_maint_validation.sru
forward
global type u_tabpg_outproc_maint_validation from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_outproc_maint_validation
end type
type cb_2 from commandbutton within u_tabpg_outproc_maint_validation
end type
type cb_4 from commandbutton within u_tabpg_outproc_maint_validation
end type
type cb_5 from commandbutton within u_tabpg_outproc_maint_validation
end type
type cb_3 from commandbutton within u_tabpg_outproc_maint_validation
end type
end forward

global type u_tabpg_outproc_maint_validation from u_tabpg_dw
integer width = 2491
string text = "Definition Validation"
cb_1 cb_1
cb_2 cb_2
cb_4 cb_4
cb_5 cb_5
cb_3 cb_3
end type
global u_tabpg_outproc_maint_validation u_tabpg_outproc_maint_validation

type variables

Private:
//	Controller reference.
n_outproc_maint_controller _myController

//	Model data.
long _opDefRowID

end variables

forward prototypes
public function integer setopdefrowid (long opdefrowid)
end prototypes

public function integer setopdefrowid (long opdefrowid);
_opDefRowID = opDefRowID
return Refresh()

end function

on u_tabpg_outproc_maint_validation.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.cb_3
end on

on u_tabpg_outproc_maint_validation.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_3)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 0, 0, 0)
inv_Resize.of_Register(cb_4, 100, 0, 0, 0)
inv_Resize.of_Register(cb_5, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_outproc_maint_validation
boolean visible = false
string text = "Definition"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_outproc_maint_validation
integer x = 0
integer y = 0
integer width = 1792
integer height = 1092
string dataobject = "d_outproc_maint_validation"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve(_opDefRowID)

end event

type cb_1 from commandbutton within u_tabpg_outproc_maint_validation
boolean visible = false
integer x = 1824
integer y = 8
integer width = 640
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "New Blanket PO..."
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowNewBlanketPO()

end event

type cb_2 from commandbutton within u_tabpg_outproc_maint_validation
boolean visible = false
integer x = 1824
integer y = 136
integer width = 640
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Close Blanket PO..."
end type

event clicked;
if	not IsValid(_myController) then return
if	dw_1.RowCount()<=0 then return

long blanketPONumber
blanketPONumber = dw_1.object.ActiveBlanketPONumber[1]

_myController.ShowCloseBlanketPO(blanketPONumber)

end event

type cb_4 from commandbutton within u_tabpg_outproc_maint_validation
boolean visible = false
integer x = 1824
integer y = 500
integer width = 640
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Setup Back to Back..."
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowSetupBTB()

end event

type cb_5 from commandbutton within u_tabpg_outproc_maint_validation
boolean visible = false
integer x = 1824
integer y = 628
integer width = 640
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Clear Back to Back..."
end type

event clicked;
if	not IsValid(_myController) then return

_myController.ShowClearBTB()

end event

type cb_3 from commandbutton within u_tabpg_outproc_maint_validation
boolean visible = false
integer x = 1824
integer y = 264
integer width = 640
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Set Active Blanket PO"
end type

event clicked;
if	not IsValid(_myController) then return
if	dw_1.RowCount()<=0 then return

long blanketPONumber
blanketPONumber = dw_1.object.ActiveBlanketPONumber[1]

_myController.SetActiveBlanketPO(blanketPONumber)

end event


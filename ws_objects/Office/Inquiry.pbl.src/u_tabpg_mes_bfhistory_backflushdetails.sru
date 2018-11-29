$PBExportHeader$u_tabpg_mes_bfhistory_backflushdetails.sru
forward
global type u_tabpg_mes_bfhistory_backflushdetails from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_mes_bfhistory_backflushdetails
end type
type cb_2 from commandbutton within u_tabpg_mes_bfhistory_backflushdetails
end type
type cb_openledger from commandbutton within u_tabpg_mes_bfhistory_backflushdetails
end type
end forward

global type u_tabpg_mes_bfhistory_backflushdetails from u_tabpg_dw
integer width = 2414
string text = "BF Details"
cb_1 cb_1
cb_2 cb_2
cb_openledger cb_openledger
end type
global u_tabpg_mes_bfhistory_backflushdetails u_tabpg_mes_bfhistory_backflushdetails

type variables

Private:

//	Controller reference.
n_mes_bfhistory_controller _myController

//	Model data.
string _backflushNumber

end variables

forward prototypes
public function integer setbackflushnumber (string backflushnumber)
end prototypes

public function integer setbackflushnumber (string backflushnumber);
_backflushNumber = backflushNumber
return Refresh()

end function

on u_tabpg_mes_bfhistory_backflushdetails.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_openledger=create cb_openledger
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_openledger
end on

on u_tabpg_mes_bfhistory_backflushdetails.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_openledger)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_openledger.X + (cb_openledger.X - gb_1.X - gb_1.Width) + cb_openledger.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_openledger, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mes_bfhistory_backflushdetails
end type

event gb_1::constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mes_bfhistory_backflushdetails
string dataobject = "d_mes_bfhistory_getbackflushdetails"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activeRow <= 0 then return

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//datawindowchild dddw
//
//if	GetChild("Status", dddw) = SUCCESS then
//	dddw.SetTransObject(SQLCA)
//	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
//		dddw.InsertRow(0)
//	end if
//end if

return Retrieve(_backflushNumber)

end event

event dw_1::doubleclicked;call super::doubleclicked;
if	row <= 0 or not IsValid (_myController) then return

string	componentPart
componentPart = object.PartConsumed[row]
_myController.ShowComponentLedgerReport(componentPart)

end event

type cb_1 from commandbutton within u_tabpg_mes_bfhistory_backflushdetails
boolean visible = false
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

type cb_2 from commandbutton within u_tabpg_mes_bfhistory_backflushdetails
boolean visible = false
integer x = 1806
integer y = 136
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
end type

type cb_openledger from commandbutton within u_tabpg_mes_bfhistory_backflushdetails
integer x = 1806
integer y = 8
integer width = 462
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ledger..."
boolean default = true
end type

event clicked;
if	dw_1.getrow() <= 0 or not IsValid (_myController) then return

string	componentPart
componentPart = dw_1.object.PartConsumed[dw_1.getrow()]
_myController.ShowComponentLedgerReport(componentPart)

end event


$PBExportHeader$u_tabpg_mes_bfhistory_recentwohistory.sru
forward
global type u_tabpg_mes_bfhistory_recentwohistory from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_mes_bfhistory_recentwohistory
end type
type cb_2 from commandbutton within u_tabpg_mes_bfhistory_recentwohistory
end type
end forward

global type u_tabpg_mes_bfhistory_recentwohistory from u_tabpg_dw
integer width = 2414
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_mes_bfhistory_recentwohistory u_tabpg_mes_bfhistory_recentwohistory

type variables

Private:

//	Controller reference.
n_mes_bfhistory_controller _myController

//	Model data.
datetime _recentDate
string _workOrderNumber

end variables

forward prototypes
public function integer setrecentdate (datetime recentdate)
public function integer setworkordernumber (string workordernumber)
end prototypes

public function integer setrecentdate (datetime recentdate);
_recentDate = recentDate
return Refresh()

end function

public function integer setworkordernumber (string workordernumber);
_workOrderNumber = workOrderNumber
return Refresh()

end function

on u_tabpg_mes_bfhistory_recentwohistory.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_mes_bfhistory_recentwohistory.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
//inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
//inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_mes_bfhistory_recentwohistory
end type

event gb_1::constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_mes_bfhistory_recentwohistory
string dataobject = "d_mes_bfhistory_recentworkorderhistory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activeRow <= 0 then return

string backflushNumber
backflushNumber = object.BackflushNumber [activerow]

_myController.SetBackflushNumber(backflushNumber)

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

return Retrieve(_recentDate, _workOrderNumber)

end event

type cb_1 from commandbutton within u_tabpg_mes_bfhistory_recentwohistory
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

type cb_2 from commandbutton within u_tabpg_mes_bfhistory_recentwohistory
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


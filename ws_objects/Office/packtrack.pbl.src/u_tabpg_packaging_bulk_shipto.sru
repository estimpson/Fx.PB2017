$PBExportHeader$u_tabpg_packaging_bulk_shipto.sru
forward
global type u_tabpg_packaging_bulk_shipto from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_packaging_bulk_shipto
end type
type cb_2 from commandbutton within u_tabpg_packaging_bulk_shipto
end type
type cb_3 from commandbutton within u_tabpg_packaging_bulk_shipto
end type
end forward

global type u_tabpg_packaging_bulk_shipto from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global u_tabpg_packaging_bulk_shipto u_tabpg_packaging_bulk_shipto

type variables

Private:
//	Controller reference.
n_packaging_bulk_controller _myController

//	Model data.
string _packageCode
string _destinationCode

end variables

forward prototypes
public function integer ship ()
public function integer receive ()
public function integer adjust ()
public function string getshipto ()
public function integer setpackagecodeshipto (string packagecode, string destinationcode)
end prototypes

public function integer ship ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
_myController.ShowShip()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer receive ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
_myController.ShowReceive()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer adjust ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
_myController.ShowAdjustShipTo()
SetPointer(Arrow!)

return SUCCESS

end function

public function string getshipto ();
return _destinationCode

end function

public function integer setpackagecodeshipto (string packagecode, string destinationcode);
_packageCode = packageCode
_destinationCode = destinationCode
Text = "Destination: " + _destinationCode
return Refresh()

end function

on u_tabpg_packaging_bulk_shipto.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on u_tabpg_packaging_bulk_shipto.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)
inv_Resize.of_Register(cb_3, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_packaging_bulk_shipto
string text = "History"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_packaging_bulk_shipto
string dataobject = "d_packaging_bulktracking_shiptohistory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve(_packageCode, _destinationCode)

end event

type cb_1 from commandbutton within u_tabpg_packaging_bulk_shipto
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
string text = "Ship..."
end type

event clicked;
Ship()

end event

type cb_2 from commandbutton within u_tabpg_packaging_bulk_shipto
integer x = 1806
integer y = 136
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
string text = "Receive..."
end type

event clicked;
Receive()

end event

type cb_3 from commandbutton within u_tabpg_packaging_bulk_shipto
integer x = 1806
integer y = 264
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adjust..."
end type

event clicked;
Adjust()

end event


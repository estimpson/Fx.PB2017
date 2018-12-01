$PBExportHeader$u_tabpg_cntmgr_master_cntlist.sru
forward
global type u_tabpg_cntmgr_master_cntlist from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_cntmgr_master_cntlist
end type
type cb_2 from commandbutton within u_tabpg_cntmgr_master_cntlist
end type
type cb_3 from commandbutton within u_tabpg_cntmgr_master_cntlist
end type
end forward

global type u_tabpg_cntmgr_master_cntlist from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global u_tabpg_cntmgr_master_cntlist u_tabpg_cntmgr_master_cntlist

type variables

Private:
//	Controller reference.
n_cntmgr_master_controller _myController

end variables

forward prototypes
public function integer createcontainershipper ()
public function integer printmanifest ()
public function integer beginshipout ()
end prototypes

public function integer createcontainershipper ();
if	not IsValid(_myController) then return FAILURE

if	dw_1.GetRow() <= 0 or dw_1.RowCount() <= 0 then return NO_ACTION

string deliveryNumber
deliveryNumber = dw_1.object.DeliveryNumber[dw_1.GetRow()]

SetPointer(HourGlass!)
_myController.CreateContainerShipper(deliveryNumber)
SetPointer(Arrow!)

return SUCCESS

end function

public function integer printmanifest ();
if	not IsValid(_myController) then return FAILURE

SetPointer(HourGlass!)
_myController.PrintManifest()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer beginshipout ();
return _myController.BeginShipout()

end function

on u_tabpg_cntmgr_master_cntlist.create
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

on u_tabpg_cntmgr_master_cntlist.destroy
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_cntmgr_master_cntlist
string text = "Container List"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_cntmgr_master_cntlist
string dataobject = "d_cntmgr_containerlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::selectionchanged;call super::selectionchanged;
cb_1.Enabled = SingleSelected
cb_2.Enabled = SingleSelected
cb_3.Enabled = SingleSelected

end event

event dw_1::activerowchanged;call super::activerowchanged;
string deliveryNumber
if	activeRow <= 0 then
	cb_1.Enabled = false
	SetNull(deliveryNumber)
	_myController.SetDeliveryNumber(deliveryNumber)
	return
end if

long shipperID
shipperID = dw_1.object.ShipperID[activeRow]

long printed
printed = dw_1.object.Printed[activeRow]

datetime actualDepartureDT
actualDepartureDT = dw_1.object.ActualDepartureDT[activeRow]

cb_1.Enabled = (cb_1.Enabled and IsNull(shipperID))
cb_2.Enabled = (cb_2.Enabled and not IsNull(shipperID))
cb_3.Enabled = (cb_3.Enabled and not IsNull(shipperID) and printed = 1 and IsNull(actualDepartureDT))

deliveryNumber = dw_1.object.DeliveryNumber[activeRow]
_myController.SetDeliveryNumber(deliveryNumber)

end event

type cb_1 from commandbutton within u_tabpg_cntmgr_master_cntlist
integer x = 1806
integer y = 8
integer width = 466
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Create Shipper"
end type

event clicked;CreateContainerShipper()

end event

type cb_2 from commandbutton within u_tabpg_cntmgr_master_cntlist
integer x = 1806
integer y = 136
integer width = 466
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print Manifest..."
end type

event clicked;PrintManifest()

end event

type cb_3 from commandbutton within u_tabpg_cntmgr_master_cntlist
integer x = 1806
integer y = 264
integer width = 466
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ship out..."
end type

event clicked;
BeginShipout()

end event


$PBExportHeader$u_tabpg_shippingdock_asnexcepth_inst.sru
forward
global type u_tabpg_shippingdock_asnexcepth_inst from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_shippingdock_asnexcepth_inst
end type
type cb_2 from commandbutton within u_tabpg_shippingdock_asnexcepth_inst
end type
end forward

global type u_tabpg_shippingdock_asnexcepth_inst from u_tabpg_dw
integer width = 2309
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_shippingdock_asnexcepth_inst u_tabpg_shippingdock_asnexcepth_inst

type variables

Private:
//	Model data
long _shipperID

//	Local objects.
datastore _instructionsDS

//	Controller reference.
n_shippingdock_asnexcepth_controller _myController

end variables

forward prototypes
public function integer setdatawindowsyntax (string dwsyntax, long shipperid)
end prototypes

public function integer setdatawindowsyntax (string dwsyntax, long shipperid);
_shipperID = shipperID
if	not (dwSyntax > "") then return FAILURE
if	not (_instructionsDS.Create(dwSyntax) = 1) then return FAILURE

dw_1.Create(dwSyntax)
_instructionsDS.ShareData(dw_1)

return Refresh()

end function

on u_tabpg_shippingdock_asnexcepth_inst.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_shippingdock_asnexcepth_inst.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

_instructionsDS = create datastore

end event

event destructor;call super::destructor;
destroy _instructionsDS

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shippingdock_asnexcepth_inst
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shippingdock_asnexcepth_inst
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
_instructionsDS.SetTransObject(SQLCA)
//dw_1.SetTransObject(SQLCA)
if	_instructionsDS.Retrieve(_shipperID)  <= 0 then
	_instructionsDS.Retrieve(string(_shipperID))
//	dw_1.Retrieve(string(_shipperID))
else
//	dw_1.Retrieve(_shipperID)
end if

dw_1.Show()
return RowCount()

end event

type cb_1 from commandbutton within u_tabpg_shippingdock_asnexcepth_inst
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
string text = "func1"
end type

type cb_2 from commandbutton within u_tabpg_shippingdock_asnexcepth_inst
boolean visible = false
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
string text = "func2"
end type


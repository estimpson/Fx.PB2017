HA$PBExportHeader$w_shippingdock_edittruckpronumbers.srw
forward
global type w_shippingdock_edittruckpronumbers from w_response
end type
type cb_cancel from commandbutton within w_shippingdock_edittruckpronumbers
end type
type cb_ok from commandbutton within w_shippingdock_edittruckpronumbers
end type
type dw_1 from u_fxdw within w_shippingdock_edittruckpronumbers
end type
type gb_1 from groupbox within w_shippingdock_edittruckpronumbers
end type
end forward

global type w_shippingdock_edittruckpronumbers from w_response
integer width = 3136
integer height = 1276
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
gb_1 gb_1
end type
global w_shippingdock_edittruckpronumbers w_shippingdock_edittruckpronumbers

type variables

private:
string _truckNumber

end variables

forward prototypes
public function integer settrucknumber (string trucknumber)
end prototypes

public function integer settrucknumber (string trucknumber);
_truckNumber = truckNumber
return dw_1.Refresh()

end function

on w_shippingdock_edittruckpronumbers.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_shippingdock_edittruckpronumbers.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event pfc_preopen;call super::pfc_preopen;
SetTruckNumber(message.StringParm)

end event

type cb_cancel from commandbutton within w_shippingdock_edittruckpronumbers
integer x = 1591
integer y = 1016
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
dw_1.AcceptText()
dw_1.Update()
Close(parent)

end event

type cb_ok from commandbutton within w_shippingdock_edittruckpronumbers
integer x = 1056
integer y = 1016
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event clicked;
dw_1.AcceptText()
dw_1.Update()
commit using SQLCA  ;

Close(parent)

end event

type dw_1 from u_fxdw within w_shippingdock_edittruckpronumbers
integer x = 37
integer y = 116
integer width = 3058
integer height = 868
integer taborder = 10
string dataobject = "d_shipping_departingshippers_bytruck"
end type

event constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_truckNumber)

end event

type gb_1 from groupbox within w_shippingdock_edittruckpronumbers
integer x = 23
integer y = 8
integer width = 3081
integer height = 984
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Edit PRO Numbers"
end type


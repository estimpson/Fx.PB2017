$PBExportHeader$w_changepovendor.srw
forward
global type w_changepovendor from w_response
end type
type dw_1 from u_dw within w_changepovendor
end type
type cb_cancel from commandbutton within w_changepovendor
end type
type cb_ok from commandbutton within w_changepovendor
end type
end forward

global type w_changepovendor from w_response
integer width = 2194
integer height = 968
string title = "Choose New Vendor"
boolean center = true
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_changepovendor w_changepovendor

type variables

long PurchaseOrderNumber
end variables

on w_changepovendor.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_changepovendor.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event pfc_preopen;call super::pfc_preopen;
PurchaseOrderNumber = IsNull(message.inv_Parm.of_GetItem("PurchaseOrderNumber"), -1)
dw_1.event pfc_Retrieve()

end event

type dw_1 from u_dw within w_changepovendor
integer x = 27
integer y = 56
integer width = 1646
integer height = 520
integer taborder = 30
string dataobject = "d_changepovendor"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve (PurchaseOrderNumber)

end event

event activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	cb_ok.enabled = false
end if

string	newVendor
dw_1.AcceptText()
newVendor = dw_1.object.newvendor[1]

cb_ok.enabled = (newVendor > '')

end event

event itemchanged;call super::itemchanged;
string	newVendor
choose case lower(dwo.Name)
	case lower("NewVendor")
		newVendor = data
	case else
		newVendor = dw_1.object.NewVendor[1]
end choose

cb_ok.enabled = (newVendor > '')

end event

type cb_cancel from commandbutton within w_changepovendor
integer x = 1701
integer y = 184
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
CloseWithReturn(parent, NO_ACTION)

end event

type cb_ok from commandbutton within w_changepovendor
integer x = 1701
integer y = 44
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event clicked;
string	newVendor
dw_1.AcceptText()
newVendor = dw_1.object.newvendor[1]
message.inv_Parm.of_SetItem("NewVendor", newVendor)
CloseWithReturn(parent, CONTINUE_ACTION)

end event


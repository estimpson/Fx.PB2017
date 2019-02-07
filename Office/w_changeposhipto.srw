HA$PBExportHeader$w_changeposhipto.srw
forward
global type w_changeposhipto from w_response
end type
type dw_1 from u_dw within w_changeposhipto
end type
type cb_cancel from commandbutton within w_changeposhipto
end type
type cb_ok from commandbutton within w_changeposhipto
end type
end forward

global type w_changeposhipto from w_response
integer width = 2194
integer height = 968
string title = "Choose New Ship To"
boolean center = true
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_changeposhipto w_changeposhipto

type variables

long PurchaseOrderNumber
end variables

on w_changeposhipto.create
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

on w_changeposhipto.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event pfc_preopen;call super::pfc_preopen;
PurchaseOrderNumber = IsNull(message.inv_Parm.of_GetItem("PurchaseOrderNumber"), -1)
dw_1.event pfc_Retrieve()

end event

type dw_1 from u_dw within w_changeposhipto
integer x = 27
integer y = 56
integer width = 1646
integer height = 520
integer taborder = 30
string dataobject = "d_changeposhipto"
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

dw_1.AcceptText()

long dropShip
dropShip = dw_1.object.dropship[1]

string	newShipTo
if	dropShip = 1 then
	newShipTo = dw_1.object.NewShipToDestination[1]
else
	newShipTo = dw_1.object.NewShipToLocation[1]
end if

cb_ok.enabled = (newShipTo > "")

end event

event itemchanged;call super::itemchanged;
long dropShip
dropShip = dw_1.object.dropship[1]

string	newShipTo
choose case Lower(dwo.Name)
	case Lower("NewShipToDestination"), Lower("NewShipToLocation")
		newShipTo = data
	case else
		if	dropShip = 1 then
			newShipTo = dw_1.object.NewShipToDestination[1]
		else
			newShipTo = dw_1.object.NewShipToLocation[1]
		end if
end choose

cb_ok.enabled = (newShipTo > "")

end event

type cb_cancel from commandbutton within w_changeposhipto
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

type cb_ok from commandbutton within w_changeposhipto
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
dw_1.AcceptText()

long dropShip
dropShip = dw_1.object.dropship[1]

string	newShipTo
if	dropShip = 1 then
	newShipTo = dw_1.object.NewShipToDestination[1]
else
	newShipTo = dw_1.object.NewShipToLocation[1]
end if

message.inv_Parm.of_SetItem("NewShipTo", newShipTo)
CloseWithReturn(parent, CONTINUE_ACTION)

end event


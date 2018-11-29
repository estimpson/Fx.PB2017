$PBExportHeader$w_verifyshipout.srw
forward
global type w_verifyshipout from w_response
end type
type cb_ok from commandbutton within w_verifyshipout
end type
type cb_cancel from commandbutton within w_verifyshipout
end type
type st_message from statictext within w_verifyshipout
end type
end forward

global type w_verifyshipout from w_response
integer width = 1385
integer height = 616
string title = "Verify Drop Shipment"
long backcolor = 77971394
cb_ok cb_ok
cb_cancel cb_cancel
st_message st_message
end type
global w_verifyshipout w_verifyshipout

type variables

Private:

long ShipperID
long InvoiceNumber

string User

n_cst_dropship_trans DropShipTrans

end variables

forward prototypes
public function integer of_readysave ()
public function integer of_shipout ()
end prototypes

public function integer of_readysave ();
//	Declarations.
integer	li_ReturnValue = FAILURE

if IsNull (User, "" ) = "" then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "You must first enter a valid operator login!", StopSign! )
	return li_ReturnValue
end if

//	Return success.
li_ReturnValue = SUCCESS
return li_ReturnValue

end function

public function integer of_shipout ();
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Get price.
li_ReturnValue = DropShipTrans.DropShip(User, ShipperID, InvoiceNumber)
choose case li_ReturnValue
	case 0
		sqlca.of_Commit()
		li_ReturnValue = SUCCESS
		MessageBox(gnv_App.iapp_Object.DisplayName, "Invoice Number " + String(InvoiceNumber) + " created.")
		message.inv_Parm.of_SetItem("invoice_number", InvoiceNumber)
	case else
		sqlca.of_Rollback()
		li_ReturnValue = FAILURE
		MessageBox(gnv_App.iapp_Object.DisplayName, "Unknown problem.", StopSign!)
end choose

//	Return.
return	li_ReturnValue

end function

on w_verifyshipout.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_message=create st_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.st_message
end on

on w_verifyshipout.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_message)
end on

event pfc_preopen;call super::pfc_preopen;
//	Get parm values.
ShipperID = message.inv_Parm.of_GetItem ("shipperid")

//	Set screen title.
st_message.Text += String (ShipperID)

//	Get necessary notifications.
gnv_App.inv_StateMSGRouter.Register("User", this, true)

DropShipTrans = create n_cst_dropship_trans

end event

event pfd_event;call super::pfd_event;
choose case EventName
	case "User"
		User = eventmessage.of_GetItem("User")
end choose

end event

event close;call super::close;
destroy DropShipTrans

end event

type cb_ok from commandbutton within w_verifyshipout
integer x = 773
integer y = 420
integer width = 219
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ok"
boolean default = true
end type

event clicked;
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Check data.
if of_ReadySave () = FAILURE then return

//	Prompt.
li_ReturnValue = MessageBox ( gnv_App.iapp_Object.DisplayName, "Shipper #:  " + String ( ShipperID, "0" ) + " will be shipped out.", Question!, OkCancel!, 1 )
if li_ReturnValue = 1 then
	
	//	Create PO line item.
	if of_Shipout ( ) = SUCCESS then
		CloseWithReturn ( parent, SUCCESS )
	end if
end if

end event

type cb_cancel from commandbutton within w_verifyshipout
integer x = 1051
integer y = 420
integer width = 224
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
//	Close parent.
Close ( parent )

end event

type st_message from statictext within w_verifyshipout
integer x = 46
integer y = 72
integer width = 1298
integer height = 132
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Press Ok to proceed with shipout on shipper #:  "
boolean focusrectangle = false
end type


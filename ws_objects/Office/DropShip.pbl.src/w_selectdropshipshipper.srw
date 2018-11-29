$PBExportHeader$w_selectdropshipshipper.srw
forward
global type w_selectdropshipshipper from w_response
end type
type dw_shipper from u_dw within w_selectdropshipshipper
end type
type dw_shipperdetail from u_dw within w_selectdropshipshipper
end type
type cb_new from commandbutton within w_selectdropshipshipper
end type
type dw_shipperquantity from u_dw within w_selectdropshipshipper
end type
type cb_ok from commandbutton within w_selectdropshipshipper
end type
type cb_cancel from commandbutton within w_selectdropshipshipper
end type
type gb_1 from groupbox within w_selectdropshipshipper
end type
type st_1 from u_st_splitbar within w_selectdropshipshipper
end type
type st_2 from u_st_splitbar within w_selectdropshipshipper
end type
end forward

global type w_selectdropshipshipper from w_response
integer width = 2565
integer height = 1272
string title = "Select Drop Shipment PO"
long backcolor = 78748035
dw_shipper dw_shipper
dw_shipperdetail dw_shipperdetail
cb_new cb_new
dw_shipperquantity dw_shipperquantity
cb_ok cb_ok
cb_cancel cb_cancel
gb_1 gb_1
st_1 st_1
st_2 st_2
end type
global w_selectdropshipshipper w_selectdropshipshipper

type variables

Private:
datetime	idt_ShipperDT

decimal	idec_Quantity [ ]

long	il_PONumber
long	il_PORowID [ ]
long	il_ShipperID

string	is_Part [ ]
string	is_Operator
string	is_SuccessMessage

n_cst_dropship_trans DropShipTrans

end variables

forward prototypes
public function integer of_createshipper ()
public function integer of_addtoshipper ()
public function integer of_readysave ()
end prototypes

public function integer of_createshipper ();
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Get price.
li_ReturnValue = DropShipTrans.CreateDropShipShipper ( is_Operator, il_PONumber, idt_ShipperDT, il_ShipperID )
choose case li_ReturnValue
	case 0
		sqlca.of_Commit ( )
		li_ReturnValue = SUCCESS
		is_SuccessMessage = "Shipper Number " + String ( il_ShipperID ) + " created."
	case -10
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid Operator.", StopSign! )
	case -20
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid PO Number.", StopSign! )
	case else
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem.", StopSign! )
end choose

//	Return.
return	li_ReturnValue

end function

public function integer of_addtoshipper ();
//	Declarations.
integer	li_Row
integer	li_Rows
integer	li_ReturnValue = FAILURE

//	Create line items.
li_Rows = dw_shipperquantity.RowCount ( )
for li_Row = 1 to li_Rows
	li_ReturnValue = DropShipTrans.CreateDropShipShipperLineItem ( is_Operator, il_ShipperID, idec_Quantity [ li_Row ], il_PONumber, il_PORowID [ li_Row ] )
	choose case li_ReturnValue
		case 0
			sqlca.of_Commit ( )
			li_ReturnValue = SUCCESS
			is_SuccessMessage += String ( idec_Quantity [ li_Row ], "0.00####" ) + String ( dw_shipperquantity.object.unit [ li_Row ] ) + " of " + is_Part [ li_Row ] + " added to Shipper ID " + String ( il_ShipperID ) + ".~r~n"
		case -10
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid PO." )
	
		case -10
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid shipper." )
		case -11
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Shipper is not a drop ship." )
		case -12
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Shipper doesn't have the same delivery destination as the PO." )
		case -20
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Quantity must be greater than zero." )
		case -30
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "PO not found." )
		case -31
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "PO line item not found." )
		case -32
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "PO line item incompatable with Shipper." )
		case else
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem." )
	end choose
next

//	Process finished w/ no errors.
sqlca.of_Commit ( )
li_ReturnValue = SUCCESS
message.inv_Parm.of_SetItem ( "shipper_id", il_ShipperID )
message.inv_Parm.of_SetItem ( "message", is_SuccessMessage )

//	Return.
return	li_ReturnValue

end function

public function integer of_readysave ();
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Accept edits and validate.
dw_shipperquantity.AcceptText ( )

if IsNull ( is_Operator, "" ) = "" then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "You must first enter a valid operator login!", StopSign! )
	dw_shipperquantity.SetFocus ( )
	dw_shipperquantity.SetColumn ( 6 )
	return li_ReturnValue
end if

idt_ShipperDT = dw_shipperquantity.object.shipdate [ 1 ]
if IsNull ( idt_ShipperDT ) then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "You must first choose a valid shipper date!", StopSign! )
	dw_shipperquantity.SetFocus ( )
	dw_shipperquantity.SetColumn ( 4 )
	return li_ReturnValue
end if

if IsNull ( idec_Quantity [ 1 ], 0 ) <= 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "You must first enter a valid quantity!", StopSign! )
	dw_shipperquantity.SetFocus ( )
	dw_shipperquantity.SetColumn ( 2 )
	return li_ReturnValue
end if

//	Return success.
li_ReturnValue = SUCCESS
return li_ReturnValue

end function

on w_selectdropshipshipper.create
int iCurrent
call super::create
this.dw_shipper=create dw_shipper
this.dw_shipperdetail=create dw_shipperdetail
this.cb_new=create cb_new
this.dw_shipperquantity=create dw_shipperquantity
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipper
this.Control[iCurrent+2]=this.dw_shipperdetail
this.Control[iCurrent+3]=this.cb_new
this.Control[iCurrent+4]=this.dw_shipperquantity
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
end on

on w_selectdropshipshipper.destroy
call super::destroy
destroy(this.dw_shipper)
destroy(this.dw_shipperdetail)
destroy(this.cb_new)
destroy(this.dw_shipperquantity)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event pfc_preopen;call super::pfc_preopen;
//	Get parm values.
il_PONumber = message.inv_Parm.of_GetItem ( "ponumber" )
il_PORowID = message.inv_Parm.of_GetItem ( "rowids" )
is_Part = message.inv_Parm.of_GetItem ( "parts" )

//	Retrieve info for new invoice line item and existing invoices.
dw_shipper.Retrieve ( il_PONumber, il_PORowID )
dw_shipperquantity.Retrieve ( il_PONumber, il_PORowID )

DropShipTrans = create n_cst_dropship_trans

end event

event close;call super::close;
destroy DropShipTrans

end event

type dw_shipper from u_dw within w_selectdropshipshipper
integer x = 23
integer y = 552
integer width = 992
integer height = 504
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_podetaildropshipshipperlist"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )

end event

event rowfocuschanged;call super::rowfocuschanged;
//	Clear current PO.
il_ShipperID = 0

//	Retrieve PO's for vendor.
if currentrow > 0 then
	il_ShipperID = object.id [ currentrow ]
	dw_shipperdetail.Retrieve ( il_ShipperID )
end if

end event

type dw_shipperdetail from u_dw within w_selectdropshipshipper
integer x = 1038
integer y = 556
integer width = 1499
integer height = 500
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dropshipshipperdetail"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )

end event

type cb_new from commandbutton within w_selectdropshipshipper
integer x = 32
integer y = 1084
integer width = 475
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Create New Shpper"
end type

event clicked;
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Check data.
if of_ReadySave ( ) = FAILURE then return

//	Prompt.
li_ReturnValue = MessageBox ( gnv_App.iapp_Object.DisplayName, "A new Drop Ship Shipper will be created for the line items above.", Question!, OkCancel!, 1 )
if li_ReturnValue = 1 then
	
	//	Create PO.
	if of_CreateShipper ( ) = SUCCESS then
		if of_AddToShipper ( ) = SUCCESS then
			CloseWithReturn ( parent, SUCCESS )
		end if
	end if
end if

end event

type dw_shipperquantity from u_dw within w_selectdropshipshipper
integer x = 37
integer y = 72
integer width = 2491
integer height = 448
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shipperquantitiesdates"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
//	Set services.
of_SetTransObject ( sqlca )
of_SetUpdateable ( false )
of_SetDropDownCalendar ( true )

//	Register date control to calendar.
iuo_calendar.of_Register ( iuo_calendar.NONE )

end event

event itemchanged;call super::itemchanged;
//	Declarations.
string	ls_Operator

//	Retrieve unpaid receipts on vendor change.
choose case dwo.Name
	case "password"
		ls_Operator = data
		sqlca.uo_get_operator ( ls_Operator )
		if ls_Operator > "" then
			object.operator [ 1 ] = ls_Operator
		else
			object.operator [ 1 ] = "Invalid"
			return 1
		end if
		is_Operator = ls_Operator
	case "quantity"
		idec_Quantity [ row ] = Dec ( data )
end choose

end event

event doubleclicked;call super::doubleclicked;
//	Show calendar.
event pfc_DDCalendar ( )

end event

event itemerror;call super::itemerror;
//	Give appropriate error message.
choose case dwo.Name
	case "password"
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Operator login is mandatory!" )
		return 1
end choose
return 0

end event

event retrieveend;call super::retrieveend;
//	Record current quantity and date.
if rowcount > 0 then
	idec_Quantity = object.quantity.primary
	idt_ShipperDT = object.shipdate [ rowcount ]
	is_Part = object.part.primary
	il_PORowID = object.row_id.primary
end if

end event

type cb_ok from commandbutton within w_selectdropshipshipper
integer x = 2053
integer y = 1084
integer width = 224
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Check data.
if of_ReadySave ( ) = FAILURE then return

//	Prompt.
li_ReturnValue = MessageBox ( gnv_App.iapp_Object.DisplayName, "The line items above will be added to Shipper ID " + String ( il_ShipperID ) + ".", Question!, OkCancel!, 1 )
if li_ReturnValue = 1 then
	
	//	Create PO line item.
	if of_AddToShipper ( ) = SUCCESS then
		CloseWithReturn ( parent, SUCCESS )
	end if
end if

end event

type cb_cancel from commandbutton within w_selectdropshipshipper
integer x = 2313
integer y = 1084
integer width = 224
integer height = 84
integer taborder = 60
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

type gb_1 from groupbox within w_selectdropshipshipper
integer x = 23
integer y = 4
integer width = 2514
integer height = 524
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "PO Line Items"
end type

type st_1 from u_st_splitbar within w_selectdropshipshipper
integer x = 23
integer y = 528
integer width = 2514
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type

type st_2 from u_st_splitbar within w_selectdropshipshipper
integer x = 1015
integer y = 548
integer width = 18
integer height = 508
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type


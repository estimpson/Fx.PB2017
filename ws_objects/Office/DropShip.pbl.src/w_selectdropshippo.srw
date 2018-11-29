$PBExportHeader$w_selectdropshippo.srw
forward
global type w_selectdropshippo from w_response
end type
type dw_vendor from u_dw within w_selectdropshippo
end type
type dw_po from u_dw within w_selectdropshippo
end type
type cb_new from commandbutton within w_selectdropshippo
end type
type dw_poquantityprice from u_dw within w_selectdropshippo
end type
type cb_ok from commandbutton within w_selectdropshippo
end type
type cb_cancel from commandbutton within w_selectdropshippo
end type
type gb_1 from groupbox within w_selectdropshippo
end type
type st_1 from u_st_splitbar within w_selectdropshippo
end type
type st_2 from u_st_splitbar within w_selectdropshippo
end type
end forward

global type w_selectdropshippo from w_response
integer width = 2565
integer height = 1272
string title = "Select Drop Shipment PO"
long backcolor = 79216776
dw_vendor dw_vendor
dw_po dw_po
cb_new cb_new
dw_poquantityprice dw_poquantityprice
cb_ok cb_ok
cb_cancel cb_cancel
gb_1 gb_1
st_1 st_1
st_2 st_2
end type
global w_selectdropshippo w_selectdropshippo

type variables

Private:
decimal	idec_Quantity [ ]
decimal	idec_Price [ ]

long	il_PONumber
long	il_OrderDetailID [ ]

string	is_Part [ ]
string	is_Vendor
string	is_Destination
string	is_SuccessMessage

n_cst_dropship_trans DropShipTrans

end variables

forward prototypes
public function integer of_createpo ()
public function integer of_addtopo ()
public function integer of_setvendor (string as_vendor)
public function integer of_getprice (integer ai_row)
end prototypes

public function integer of_createpo ();
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Get price.
li_ReturnValue = DropShipTrans.CreateDropShipPO(is_Vendor, is_Destination, il_PONumber)
choose case li_ReturnValue
	case 0
		sqlca.of_Commit ( )
		li_ReturnValue = SUCCESS
		is_SuccessMessage = "PO Number " + String ( il_PONumber ) + " created.~r~n"
	case -10
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid Vendor.", StopSign! )
	case -20
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid Destination.", StopSign! )
	case else
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem.", StopSign! )
end choose

//	Return.
return	li_ReturnValue

end function

public function integer of_addtopo ();
//	Declarations.
integer	li_Row
integer	li_Rows
integer	li_ReturnValue = FAILURE

//	Create line items.
li_Rows = dw_poquantityprice.RowCount ( )
for li_Row = 1 to li_Rows
	li_ReturnValue = DropShipTrans.CreateDropShipPOLineItem(il_PONumber, idec_Quantity [ li_Row ], idec_Price [ li_Row ], il_OrderDetailID [ li_Row ])
	choose case li_ReturnValue
		case 0
			is_SuccessMessage += String ( idec_Quantity [ li_Row ], "0.00####" ) + String ( dw_poquantityprice.object.vendorunit [ li_Row ] ) + " of " + is_Part [ li_Row ] + " added to PO number " + String ( il_PONumber ) + ".~r~n"
		case -10
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid PO." )
		case -11
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "PO is not a drop ship." )
		case -20
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Quantity must be greater than zero." )
		case -30
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Order detail ID not found." )
		case -31
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Order detail line item incompatable with PO." )
		case else
			sqlca.of_Rollback ( )
			li_ReturnValue = FAILURE
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem." )
	end choose
next

//	Process finished w/ no errors.
sqlca.of_Commit ( )
li_ReturnValue = SUCCESS
message.inv_Parm.of_SetItem ( "po_number", il_PONumber )
message.inv_Parm.of_SetItem ( "message", is_SuccessMessage )

//	Return.
return	li_ReturnValue

end function

public function integer of_setvendor (string as_vendor);
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Setup datawindows.
if dw_poquantityprice.Retrieve ( il_OrderDetailID, as_Vendor ) > 0 then
	is_Vendor = as_Vendor
	idec_Quantity = dw_poquantityprice.object.vendorquantity.primary
	dw_poquantityprice.object.poquantity.primary = idec_Quantity
	li_ReturnValue = SUCCESS
end if

//	Return.
return	li_ReturnValue

end function

public function integer of_getprice (integer ai_row);
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Get price.
idec_Price [ ai_Row ] = 0
if DropShipTrans.GetPartVendorPriceBreak ( is_Part [ ai_Row ], is_Vendor, idec_Quantity [ ai_Row ], idec_Price [ ai_Row ] ) = 0 then
	li_ReturnValue = SUCCESS
end if

//	Return.
return	li_ReturnValue

end function

on w_selectdropshippo.create
int iCurrent
call super::create
this.dw_vendor=create dw_vendor
this.dw_po=create dw_po
this.cb_new=create cb_new
this.dw_poquantityprice=create dw_poquantityprice
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_vendor
this.Control[iCurrent+2]=this.dw_po
this.Control[iCurrent+3]=this.cb_new
this.Control[iCurrent+4]=this.dw_poquantityprice
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
end on

on w_selectdropshippo.destroy
call super::destroy
destroy(this.dw_vendor)
destroy(this.dw_po)
destroy(this.cb_new)
destroy(this.dw_poquantityprice)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event pfc_preopen;call super::pfc_preopen;
//	Get parm values.
il_OrderDetailID = message.inv_Parm.of_GetItem ( "ids" )

//	Get list of vendors that can supply the passed part.
if not dw_vendor.Retrieve ( il_OrderDetailID ) > 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "The parts you have selected are not available from the same vendor or were ordered by different ship to's.  Try dragging them individually.", StopSign! )
	Hide ( )
	post Close ( this )
end if

DropShipTrans = create n_cst_dropship_trans

end event

event close;call super::close;
destroy DropShipTrans

end event

type dw_vendor from u_dw within w_selectdropshippo
integer x = 23
integer y = 552
integer width = 992
integer height = 504
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_partvendorlist"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )

end event

event rowfocuschanged;call super::rowfocuschanged;
//	Local declarations.
integer	li_Row
integer	li_Rows

//	Clear current PO.
il_PONumber = 0

//	Retrieve PO's for vendor.
if currentrow > 0 then
	if of_SetVendor ( object.vendor [ currentrow ] ) = SUCCESS then
		dw_po.Retrieve ( is_Vendor, is_Destination )
		li_Rows = dw_poquantityprice.RowCount ( )
		for li_Row = 1 to li_Rows
			if of_GetPrice ( li_Row ) = SUCCESS then
				dw_poquantityprice.object.poprice [ li_Row ] = idec_Price [ li_Row ]
			end if
		next
	end if
end if

end event

type dw_po from u_dw within w_selectdropshippo
integer x = 1038
integer y = 552
integer width = 1499
integer height = 504
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_vendordropshippolist"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )

end event

event rowfocuschanged;call super::rowfocuschanged;
//	Set the current PO number.
if currentrow > 0 then
	il_PONumber = object.po_number [ currentrow ]
else
	il_PONumber = 0
end if

end event

event clicked;call super::clicked;
//	Set the current PO number.
if row > 0 then
	il_PONumber = object.po_number [ row ]
else
	il_PONumber = 0
end if

end event

type cb_new from commandbutton within w_selectdropshippo
integer x = 32
integer y = 1084
integer width = 384
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Create New PO"
end type

event clicked;
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Prompt.
dw_poquantityprice.AcceptText ( )
li_ReturnValue = MessageBox ( gnv_App.iapp_Object.DisplayName, "A new Drop Ship PO will be created for the line items above.", Question!, OkCancel!, 1 )
if li_ReturnValue = 1 then
	
	//	Create PO.
	if of_CreatePO ( ) = SUCCESS then
		if of_AddToPO ( ) = SUCCESS then
			CloseWithReturn ( parent, SUCCESS )
		end if
	end if
end if

end event

type dw_poquantityprice from u_dw within w_selectdropshippo
integer x = 37
integer y = 72
integer width = 2491
integer height = 448
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_poquantitiesprices"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
//	Set services.
of_SetTransObject ( sqlca )
of_SetUpdateable ( false )

end event

event itemchanged;call super::itemchanged;
//	Record changed value.
choose case dwo.name
	case "poquantity"
		is_Part [ row ] = object.part_number [ row ]
		idec_Quantity [ row ] = Dec ( data )
		if of_GetPrice ( row ) = SUCCESS then
			dw_poquantityprice.object.poprice [ row ] = idec_Price [ row ]
		end if
	case "poprice"
		idec_Price [ row ] = Dec ( data )
end choose

end event

event retrieveend;call super::retrieveend;
//	Record destination.
if rowcount > 0 then
	is_Destination = object.destination [ 1 ]
	is_Part = object.part_number.primary
	il_OrderDetailID = object.id.primary
end if

end event

type cb_ok from commandbutton within w_selectdropshippo
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

//	Prompt.
dw_poquantityprice.AcceptText ( )
li_ReturnValue = MessageBox ( gnv_App.iapp_Object.DisplayName, "The line items above will be added to PO number " + String ( il_PONumber ) + ".", Question!, OkCancel!, 1 )
if li_ReturnValue = 1 then
	
	//	Create PO line item.
	if of_AddToPO ( ) = SUCCESS then
		CloseWithReturn ( parent, SUCCESS )
	end if
end if

end event

type cb_cancel from commandbutton within w_selectdropshippo
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

type gb_1 from groupbox within w_selectdropshippo
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

type st_1 from u_st_splitbar within w_selectdropshippo
integer x = 23
integer y = 528
integer width = 2514
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type

type st_2 from u_st_splitbar within w_selectdropshippo
integer x = 1015
integer y = 548
integer width = 18
integer height = 508
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type


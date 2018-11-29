$PBExportHeader$w_dropship_main.srw
forward
global type w_dropship_main from w_sheet_4t
end type
type gb_4 from u_gb_dropship within w_dropship_main
end type
type gb_3 from u_gb_dropship within w_dropship_main
end type
type gb_2 from u_gb_dropship within w_dropship_main
end type
type gb_1 from u_gb_dropship within w_dropship_main
end type
type dw_orderdetail from u_dw within w_dropship_main
end type
type dw_podetail from u_dw within w_dropship_main
end type
type dw_shipperdetail from u_dw within w_dropship_main
end type
type dw_shipper from u_dw within w_dropship_main
end type
type st_hsplit1 from u_st_splitbar within w_dropship_main
end type
type st_vsplit1 from u_st_splitbar within w_dropship_main
end type
end forward

global type w_dropship_main from w_sheet_4t
integer width = 2523
integer height = 1680
string title = "Drop Shipment Processor"
string menuname = "m_dropship"
long backcolor = 79216776
event pfc_printsalesorder ( )
event pfc_printpurchaseorder ( )
event pfc_printpackinglist ( )
event pfc_printinvoice ( )
event ue_shipout ( )
event ue_reconcile ( )
event pfc_printcustoms ( )
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_orderdetail dw_orderdetail
dw_podetail dw_podetail
dw_shipperdetail dw_shipperdetail
dw_shipper dw_shipper
st_hsplit1 st_hsplit1
st_vsplit1 st_vsplit1
end type
global w_dropship_main w_dropship_main

type prototypes
function long SetCapture ( long hwnd ) library "user32"
end prototypes

type variables

string User

n_cst_dropship_trans DropShipTrans

end variables

forward prototypes
public function integer of_refresh ()
public function integer of_destroydropshippolineitem (long al_ponumber, long al_rowid)
public function integer of_printsalesorder ()
public function integer of_printpurchaseorder ()
public function integer of_printinvoice ()
public function integer of_printpackinglist ()
public function integer of_dragging (boolean ab_Dragging, integer ai_Source)
public function integer of_printpurchaseorder (long al_ponumber)
public function integer of_printcustoms (long al_ShipperID)
public function integer of_printinvoice (long al_invoicenumber)
public function integer of_printpackinglist (long al_shipperid)
public function integer of_printcustoms ()
public function integer of_destroydropshipshipperlineitem (long al_shipperid, string as_partnumber)
public function integer of_shipout ()
public function integer of_dropshipreconcile ()
public function integer of_oestopo ()
public function integer of_SelectPO (long al_ponumber)
public function integer of_oestoshipper ()
public function integer of_oestopo (ref long al_ponumber, boolean ab_print, ref string as_Message)
public function integer of_postoshipper (string as_Message)
end prototypes

event pfc_printsalesorder;
//	Print sales order.
of_PrintSalesOrder ( )

end event

event pfc_printpurchaseorder;
//	Print purchase order.
of_PrintPurchaseOrder ( )

end event

event pfc_printpackinglist;
//	Print packing list.
of_PrintPackingList ( )

end event

event pfc_printinvoice;
//	Print invoice.
of_PrintInvoice ( )

end event

event ue_shipout;
//	Process shipout.
of_ShipOut ( )

end event

event ue_reconcile;
//	Process invoice.
of_DropShipReconcile ( )

end event

event pfc_printcustoms;
//	Print invoice.
of_PrintCustoms ( )

end event

public function integer of_refresh ();
//	Declarations.
integer li_ReturnValue = FAILURE

//	Retrieve all orders, po's and shippers.
li_ReturnValue = dw_orderdetail.Retrieve ( )
if li_ReturnValue = FAILURE then return li_ReturnValue
dw_orderdetail.SelectRow ( dw_orderdetail.GetRow ( ), true )

li_ReturnValue = dw_podetail.Retrieve ( )
if li_ReturnValue = FAILURE then return li_ReturnValue
dw_podetail.SelectRow ( dw_podetail.GetRow ( ), true )

dw_shipper.Reset ( )
dw_shipperdetail.Reset ( )
li_ReturnValue = dw_shipper.Retrieve ( )
if li_ReturnValue = FAILURE then return li_ReturnValue
dw_shipper.SelectRow ( dw_shipper.GetRow ( ), true )

//	Return.
li_ReturnValue = SUCCESS
sqlca.of_Commit ( )
return li_ReturnValue

end function

public function integer of_destroydropshippolineitem (long al_ponumber, long al_rowid);
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Get price.
li_ReturnValue = DropShipTrans.DestroyDropShipPOLineItem ( al_PONumber, al_RowID )
choose case li_ReturnValue
	case 0
		sqlca.of_Commit ( )
		li_ReturnValue = SUCCESS
	case -10
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid PO." )
	case -11
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "PO is not a drop ship." )
	case -12
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid row id." )
	case else
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem." )
end choose

//	Return.
return	li_ReturnValue

end function

public function integer of_printsalesorder ();
//	Declare local variables
integer	li_ReturnValue = FAILURE

long	ll_Row
long	ll_SelectedRows
long	ll_OrderNO [ ]

string	ls_OrderType [ ]

n_cst_associative_array	lncst_Parm

//	Get selections.
ll_OrderNO = dw_orderdetail.object.order_no.Selected
ls_OrderType = dw_orderdetail.object.order_type.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_OrderNO )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select orders for printing." )
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Set appropriate report.
	choose case ls_OrderType [ ll_Row ]
		case 'N'
			lncst_Parm.of_SetItem ( "Report", "Sales Order - Normal" )
		case 'B'
			lncst_Parm.of_SetItem ( "Report", "Sales Order - Blanket" )
		case else
			MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid order selected for printing.", StopSign! )
			return li_ReturnValue
	end choose
	
	//	Set the appropriate retrieval argument for the report.
	lncst_Parm.of_SetItem ( "Arg1", ll_OrderNO [ ll_Row ] )
	
	//	Print report.
	li_ReturnValue = Print(lncst_Parm)
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_printpurchaseorder ();
//	Declare local variables
integer	li_ReturnValue = FAILURE

long	ll_Row
long	ll_SelectedRows
long	ll_PONumber [ ]

//	Get selections.
ll_PONumber = dw_podetail.object.po_number.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_PONumber )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select orders for printing." )
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Print report.
	li_ReturnValue = of_PrintPurchaseOrder ( ll_PONumber [ ll_Row ] )
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_printinvoice ();
//	Declare local variables
integer	li_ReturnValue = FAILURE

long	ll_Row
long	ll_SelectedRows
long	ll_Invoice [ ]

//	Get selections.
ll_Invoice = dw_shipper.object.invoice_number.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_Invoice )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select invoice for printing." )
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Print report.
	li_ReturnValue = of_PrintInvoice ( ll_Invoice [ ll_Row ] )
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_printpackinglist ();
//	Declare local variables
integer	li_ReturnValue = FAILURE

long	ll_Row
long	ll_SelectedRows
long	ll_Shipper [ ]

//	Get selections.
ll_Shipper = dw_shipper.object.id.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_Shipper )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select shipper for printing." )
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Print report.
	li_ReturnValue = of_PrintPackingList ( ll_Shipper [ ll_Row ] )
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_dragging (boolean ab_Dragging, integer ai_Source);
//	Tell all group boxes about drag.
gb_1.of_Dragging ( ab_Dragging, ai_Source )
gb_2.of_Dragging ( ab_Dragging, ai_Source )
gb_3.of_Dragging ( ab_Dragging, ai_Source )
gb_4.of_Dragging ( ab_Dragging, ai_Source )

//	Return.
return SUCCESS

end function

public function integer of_printpurchaseorder (long al_ponumber);
//	Declare local variables
integer	li_ReturnValue = FAILURE

n_cst_associative_array	lncst_Parm

//	Set appropriate report.
lncst_Parm.of_SetItem ( "Report", "Normal PO" )

//	Set the appropriate retrieval argument for the report.
lncst_Parm.of_SetItem ( "Arg1", al_PONumber )

//	Print report.
li_ReturnValue = Print(lncst_Parm)

//	Update printed flag.
if li_ReturnValue = SUCCESS then sqlca.UpdatePrinted("po", al_PONumber)

//	Return.
return li_ReturnValue

end function

public function integer of_printcustoms (long al_ShipperID);
//	Declare local variables
integer	li_ReturnValue = FAILURE

n_cst_associative_array	lncst_Parm

//	Set appropriate report.
lncst_Parm.of_SetItem ( "Report", "Canadian Custom" )

//	Set the appropriate retrieval argument for the report.
lncst_Parm.of_SetItem ( "Arg1", al_ShipperID )

//	Print report.
li_ReturnValue = Print(lncst_Parm)

//	Return.
return li_ReturnValue

end function

public function integer of_printinvoice (long al_invoicenumber);
//	Declare local variables
integer	li_ReturnValue = FAILURE

n_cst_associative_array	lncst_Parm

//	Set appropriate report.
lncst_Parm.of_SetItem ( "Report", "Invoice" )

//	Set the appropriate retrieval argument for the report.
lncst_Parm.of_SetItem ( "Arg1", al_InvoiceNumber )

//	Print report.
li_ReturnValue = Print(lncst_Parm)

//	Update printed flag.
if li_ReturnValue = SUCCESS then sqlca.UpdatePrinted("invoice", al_InvoiceNumber)

//	Return.
return li_ReturnValue

end function

public function integer of_printpackinglist (long al_shipperid);
//	Declare local variables
integer	li_ReturnValue = FAILURE

n_cst_associative_array	lncst_Parm

//	Set appropriate report.
lncst_Parm.of_SetItem ( "Report", "Packing List" )

//	Set the appropriate retrieval argument for the report.
lncst_Parm.of_SetItem ( "Arg1", al_ShipperID )

//	Print report.
li_ReturnValue = Print(lncst_Parm)

//	Update printed flag.
if li_ReturnValue = SUCCESS then sqlca.UpdatePrinted("packlist", al_ShipperID)

//	Return.
return li_ReturnValue

end function

public function integer of_printcustoms ();
//	Declare local variables
integer	li_ReturnValue = FAILURE

long	ll_Row
long	ll_SelectedRows
long	ll_Shipper [ ]

//	Get selections.
ll_Shipper = dw_shipper.object.id.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_Shipper )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select shipper for printing." )
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Print report.
	li_ReturnValue = of_PrintCustoms ( ll_Shipper [ ll_Row ] )
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_destroydropshipshipperlineitem (long al_shipperid, string as_partnumber);
//	Declarations.
integer	li_ReturnValue = FAILURE

//	Get price.
li_ReturnValue = DropShipTrans.DestroyDropShipShipperLineItem(al_ShipperID, as_PartNumber)
choose case li_ReturnValue
	case 0
		sqlca.of_Commit ( )
		li_ReturnValue = SUCCESS
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
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid line item." )
	case else
		sqlca.of_Rollback ( )
		li_ReturnValue = FAILURE
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem." )
end choose

//	Return.
return	li_ReturnValue

end function

public function integer of_shipout ();
//	Declare local variables
integer	li_ReturnValue = FAILURE
integer	li_Print

long	ll_Row
long	ll_SelectedRows
long	ll_ShipperID [ ]
long	ll_InvoiceNumber [ ]

//	Get selections.
ll_ShipperID = dw_shipper.object.id.Selected
ll_InvoiceNumber = dw_shipper.object.invoice_number.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_ShipperID )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select shipper for shipping." )
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Verify this shipper hasn't already been shipped.
	if IsNull ( ll_InvoiceNumber [ ll_Row ], 0 ) > 0 then
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid shipper selected for delivery.  Shipper ID " + String ( ll_ShipperID [ ll_Row ] ) + " already delivered.", StopSign! )
		return li_ReturnValue
	else
		message.inv_Parm.of_SetItem ( "shipperid", ll_ShipperID [ ll_Row ] )
		Open ( w_verifyshipout )
		if message.DoubleParm = 1 then
			ll_InvoiceNumber [ ll_Row ] = IsNull ( message.inv_Parm.of_GetItem ( "invoice_number" ), -1 )
			li_Print = MessageBox ( gnv_App.iapp_Object.DisplayName, "Invoice number " + String ( ll_InvoiceNumber [ ll_Row ] )+ " created successfully, do you wish to print the invoice?", Question!, YesNo!, 1 )
			if li_Print = 1 then
				li_ReturnValue = of_PrintInvoice ( ll_InvoiceNumber [ ll_Row ] )
			end if
		end if
	end if
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_dropshipreconcile ();
//	Declare local variables
integer	li_ReturnValue = FAILURE

long	ll_Row
long	ll_SelectedRows
long	ll_InvoiceNumber [ ]
long	ll_ShipperID [ ]

//	Get selections.
ll_InvoiceNumber = dw_shipper.object.invoice_number.Selected
ll_ShipperID = dw_shipper.object.id.Selected

//	Check that selection was made.
ll_SelectedRows = UpperBound ( ll_InvoiceNumber )
if ll_SelectedRows = 0 then
	MessageBox ( gnv_App.iapp_Object.DisplayName, "Select invoices to be reconciled." )
	return li_ReturnValue
end if

//	Make sure.
if MessageBox ( gnv_App.iapp_Object.DisplayName, "Once invoices are reconciled they can only be viewed from the invoicing screen.", Information!, OkCancel!, 2 ) = 2 then
	return li_ReturnValue
end if

//	Loop through selected rows, printing report for each.
for ll_Row = 1 to ll_SelectedRows
	
	//	Verify this shipper hasn't already been shipped.
	if IsNull ( ll_InvoiceNumber [ ll_Row ], 0 ) > 0 then
		li_ReturnValue = DropShipTrans.DropShipReconcile(ll_InvoiceNumber[ll_Row])
		choose case li_ReturnValue
			case 0
			case -1
				sqlca.of_Rollback ( )
				MessageBox ( gnv_App.iapp_Object.DisplayName, "Invoice Number " + String ( ll_InvoiceNumber [ ll_Row ] ) + " doesn't exist!", StopSign! )
				li_ReturnValue = FAILURE
			case -2
				sqlca.of_Rollback ( )
				MessageBox ( gnv_App.iapp_Object.DisplayName, "Invoice Number " + String ( ll_InvoiceNumber [ ll_Row ] ) + " is not a valid drop ship invoice!", StopSign! )
				li_ReturnValue = FAILURE
			case else
				sqlca.of_Rollback ( )
				MessageBox ( gnv_App.iapp_Object.DisplayName, "Unknown problem!", StopSign! )
				li_ReturnValue = FAILURE
		end choose
	else
		MessageBox ( gnv_App.iapp_Object.DisplayName, "Invalid shipper selected for reconciliation.  Shipper ID " + String ( ll_ShipperID [ ll_Row ] ) + " must be shipped first.", StopSign! )
		return li_ReturnValue
	end if
next
post of_Refresh ( )

//	Return.
return li_ReturnValue

end function

public function integer of_oestopo ();
//	Declarations.
integer	li_ReturnValue = FAILURE

long	ll_PONumber

string	ls_Dummy

//	Process each selected row.
li_ReturnValue = of_OEsToPO ( ll_PONumber, true, ls_Dummy )

//	Return.
return li_ReturnValue

end function

public function integer of_SelectPO (long al_ponumber);
//	Declarations.
integer	li_ReturnValue = FAILURE
long	ll_Rows
long	ll_Row
	
//	Clear row selection.
dw_podetail.SelectRow ( 0, false )

//	Loop through all rows.
ll_Rows = dw_podetail.RowCount ( )
for ll_Row = 1 to ll_Rows
	
	//	If PO Number matches row's PO Number then select row.
	if al_PONumber = dw_podetail.object.po_number [ ll_Row ] then
		li_ReturnValue = dw_podetail.SelectRow ( ll_Row, true )
	end if
next

//	Return.
return li_ReturnValue

end function

public function integer of_oestoshipper ();
//	Declarations.
integer	li_ReturnValue = FAILURE
integer	li_Print

long	ll_PONumber

string	ls_Message

//	Process each selected row.
li_ReturnValue = of_OEsToPO ( ll_PONumber, false, ls_Message )

//	If this was successful, select all items belonging to any of the PO's and make shippers.
if li_ReturnValue = SUCCESS then
	of_Refresh ( )
	of_SelectPO ( ll_PONumber )
	li_ReturnValue = of_POsToShipper ( ls_Message )
	if li_ReturnValue = SUCCESS then
		li_Print = MessageBox ( gnv_App.iapp_Object.DisplayName, "PO number " + String ( ll_PONumber )+ " created successfully, do you wish to print the PO?", Question!, YesNo!, 1 )
		if li_Print = 1 then
			of_PrintPurchaseOrder ( ll_PONumber )
		end if
	end if
end if

//	Return.
return li_ReturnValue

end function

public function integer of_oestopo (ref long al_ponumber, boolean ab_print, ref string as_Message);
//	Declarations.
decimal	ldec_Quantity [ ]

integer	li_Print
integer	li_ReturnValue = FAILURE
integer	li_POs = 0

long	ll_SalesOrder [ ]
long	ll_OrderDetailID [ ]
long	ll_PONumber

string	ls_Unit [ ]
string	ls_Part [ ]

//	Get selected orders.
ls_Part = dw_orderdetail.object.part_number.selected
ldec_Quantity = dw_orderdetail.object.balance.selected
ls_Unit = dw_orderdetail.object.unit.selected
ll_SalesOrder = dw_orderdetail.object.order_no.selected
ll_OrderDetailID = dw_orderdetail.object.id.selected

//	Build parm for window.
message.inv_Parm.of_SetItem ( "parts", ls_Part )
message.inv_Parm.of_SetItem ( "quantities", ldec_Quantity )
message.inv_Parm.of_SetItem ( "units", ls_Unit )
message.inv_Parm.of_SetItem ( "salesorders", ll_SalesOrder )
message.inv_Parm.of_SetItem ( "ids", ll_OrderDetailID )

//	Open window to create PO.
Open ( w_selectdropshippo )
li_ReturnValue = message.DoubleParm
if li_ReturnValue = 1 then
	al_PONumber = IsNull ( message.inv_Parm.of_GetItem ( "po_number" ), -1 )
	as_Message = IsNull ( message.inv_Parm.of_GetItem ( "message" ), "" )
	if ab_Print then
		li_Print = MessageBox ( gnv_App.iapp_Object.DisplayName, as_Message + "PO number " + String ( al_PONumber )+ " created successfully, do you wish to print the PO?", Question!, YesNo!, 1 )
		if li_Print = 1 then
			of_PrintPurchaseOrder ( al_PONumber )
		end if
	end if
end if

//	Return results.
return li_ReturnValue

end function

public function integer of_postoshipper (string as_Message);
//	Declarations.
integer	li_ReturnValue = FAILURE
integer	li_Count
integer	li_Print

long	ll_Shipper
long	ll_PONumber [ ]
long	ll_RowID [ ]

string	ls_Part [ ]

//	Get selected orders.
ll_PONumber = dw_podetail.object.po_number.selected
ll_RowID = dw_podetail.object.row_id.selected
ls_Part = dw_podetail.object.part_number.selected

//	Build parm for window.
message.inv_Parm.of_SetItem ( "ponumber", ll_PONumber [ 1 ] )
message.inv_Parm.of_SetItem ( "rowids", ll_RowID )
message.inv_Parm.of_SetItem ( "parts", ls_Part )

//	Open window to create Shipper.
Open ( w_selectdropshipshipper )
li_ReturnValue = message.DoubleParm
if li_ReturnValue = 1 then
	ll_Shipper = IsNull ( message.inv_Parm.of_GetItem ( "shipper_id" ), -1 )
	as_Message += IsNull ( message.inv_Parm.of_GetItem ( "message" ), "" )
	li_Print = MessageBox ( gnv_App.iapp_Object.DisplayName, as_Message + "Shipper ID " + String ( ll_Shipper )+ " created successfully, do you wish to print the packing list?", Question!, YesNo!, 1 )
	if li_Print = 1 then
		of_PrintPackingList ( ll_Shipper )
	end if
end if

//	Return.
return li_ReturnValue

end function

on w_dropship_main.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_dropship" then this.MenuID = create m_dropship
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_orderdetail=create dw_orderdetail
this.dw_podetail=create dw_podetail
this.dw_shipperdetail=create dw_shipperdetail
this.dw_shipper=create dw_shipper
this.st_hsplit1=create st_hsplit1
this.st_vsplit1=create st_vsplit1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_orderdetail
this.Control[iCurrent+6]=this.dw_podetail
this.Control[iCurrent+7]=this.dw_shipperdetail
this.Control[iCurrent+8]=this.dw_shipper
this.Control[iCurrent+9]=this.st_hsplit1
this.Control[iCurrent+10]=this.st_vsplit1
end on

on w_dropship_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_orderdetail)
destroy(this.dw_podetail)
destroy(this.dw_shipperdetail)
destroy(this.dw_shipper)
destroy(this.st_hsplit1)
destroy(this.st_vsplit1)
end on

event pfc_preopen;call super::pfc_preopen;
//	Initialize.
of_SetResize ( true )
inv_Resize.of_Register ( dw_orderdetail, 0, 0, 50, 50 )
inv_Resize.of_Register ( dw_podetail, 50, 0, 50, 50 )
inv_Resize.of_Register ( dw_shipper, 0, 50, 50, 50 )
inv_Resize.of_Register ( dw_shipperdetail, 50, 50, 50, 50 )
inv_Resize.of_Register ( gb_1, 0, 0, 50, 50 )
inv_Resize.of_Register ( gb_2, 50, 0, 50, 50 )
inv_Resize.of_Register ( gb_3, 0, 50, 50, 50 )
inv_Resize.of_Register ( gb_4, 50, 50, 50, 50 )
inv_Resize.of_Register ( st_vsplit1, 50, 0, 0, 100 )
inv_Resize.of_Register ( st_hsplit1, 0, 50, 100, 0 )

//	Setup splitters.
st_vsplit1.of_Register ( dw_orderdetail, st_vsplit1.LEFT )
st_vsplit1.of_Register ( dw_shipper, st_vsplit1.LEFT )
st_vsplit1.of_Register ( dw_podetail, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( dw_shipperdetail, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( gb_1, st_vsplit1.LEFT )
st_vsplit1.of_Register ( gb_3, st_vsplit1.LEFT )
st_vsplit1.of_Register ( gb_2, st_vsplit1.RIGHT )
st_vsplit1.of_Register ( gb_4, st_vsplit1.RIGHT )

st_hsplit1.of_Register ( dw_orderdetail, st_hsplit1.ABOVE )
st_hsplit1.of_Register ( dw_podetail, st_hsplit1.ABOVE )
st_hsplit1.of_Register ( dw_shipper, st_hsplit1.BELOW )
st_hsplit1.of_Register ( dw_shipperdetail, st_hsplit1.BELOW )
st_hsplit1.of_Register ( gb_1, st_hsplit1.ABOVE )
st_hsplit1.of_Register ( gb_2, st_hsplit1.ABOVE )
st_hsplit1.of_Register ( gb_3, st_hsplit1.BELOW )
st_hsplit1.of_Register ( gb_4, st_hsplit1.BELOW )

//	Get necessary notifications.
window thisWindow; thisWindow = this
gnv_App.inv_StateMSGRouter.of_RequestNotification(thisWindow, "User")

DropShipTrans = create n_cst_dropship_trans

end event

event pfc_postopen;call super::pfc_postopen;
//	Refresh screen.
of_Refresh ( )

end event

event pfc_refresh;call super::pfc_refresh;
//	Refresh screen.
of_Refresh ( )

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

type gb_4 from u_gb_dropship within w_dropship_main
integer x = 1239
integer y = 664
integer width = 1189
integer height = 640
integer taborder = 40
string text = "Shipper / Invoice Detail"
end type

event constructor;call super::constructor;
//	Setup messages.
ii_GB = SHIPPERDETAIL
is_DefaultText = "Shipper / Invoice Detail"
is_Message = { "Drop to create Drop Ship", "Drop to schedule PO for shipment", "", "Drag to Sales Order or PO to delete shipper detail" }

end event

type gb_3 from u_gb_dropship within w_dropship_main
integer x = 23
integer y = 664
integer width = 1189
integer height = 640
integer taborder = 30
string text = "Shipper / Invoice Header"
end type

event constructor;call super::constructor;
//	Setup messages.
ii_GB = SHIPPER
is_DefaultText = "Shipper / Invoice Header"
is_Message = { "Drop to create Drop Ship", "Drop to schedule PO for shipment", "Drag to Sales Order or PO to delete shipper", "" }

end event

type gb_2 from u_gb_dropship within w_dropship_main
integer x = 1239
integer y = 8
integer width = 1189
integer height = 640
integer taborder = 20
string text = "PO Detail"
end type

event constructor;call super::constructor;
//	Setup messages.
ii_GB = PO
is_DefaultText = "PO Detail"
is_Message = { "Drop to create Make and Hold PO", "Drag to PO or Shipper", "Drop to delete Shipper", "Drop to delete Shipper Line Item" }

end event

type gb_1 from u_gb_dropship within w_dropship_main
integer x = 23
integer y = 8
integer width = 1189
integer height = 640
integer taborder = 10
string text = "Order Detail"
end type

event constructor;call super::constructor;
//	Setup messages.
ii_GB = ORDER
is_DefaultText = "Order Detail"
is_Message = { "Drag to PO or Shipper", "Drop to delete PO", "Drop to delete Shipper and PO", "Drop to delete Shipper and PO Line Item" }

end event

type dw_orderdetail from u_dw within w_dropship_main
string tag = "orders"
integer x = 37
integer y = 72
integer width = 1161
integer height = 564
integer taborder = 0
string dragicon = "Application!"
boolean bringtotop = true
string dataobject = "d_dropshiporderdetail"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )
of_SetSort ( true )
ib_RMBMenu = false

//	Setup row selection
inv_RowSelect.of_SetStyle ( inv_RowSelect.EXTENDED )

//	Set column sorting option.
inv_Sort.of_SetColumnHeader ( true )

end event

event clicked;call super::clicked;
//	Actions taken if row clicked.
if row > 0 then
	
	Drag ( Begin! )
	SetCapture ( Handle ( this ) )
	of_Dragging ( true, gb_1.ii_GB )
end if

end event

event rowfocuschanged;call super::rowfocuschanged;
//	Declarations.
long	ll_PORow

//	Scroll to and highlight the first PO assigned to current WO.
if currentrow > 0 then
	ll_PORow = dw_podetail.Find ( "sales_order = " + String ( object.order_no [ currentrow ] ) + " and dropship_oe_row_id = " + String ( object.row_id [ currentrow ] ), 1, dw_podetail.RowCount ( ) )
	if ll_PORow > 0 then
		dw_podetail.post ScrollToRow ( ll_PORow )
		dw_podetail.post SetRow ( ll_PORow )
	else
		dw_podetail.post SelectRow ( 0, false )
	end if
end if

end event

event lbuttonup;call super::lbuttonup;
//	No longer dragging.
of_Dragging ( false, gb_1.ii_GB )

end event

event dragdrop;call super::dragdrop;
//	Declarations.
integer	li_Count

decimal	ll_CommittedQty [ ]

long	ll_PONumber [ ]
long	ll_RowID [ ]

string	ls_Part [ ]

//	If source is orders, then open window to create PO.
choose case source.tag
	case "podetail"
		ll_PONumber = dw_podetail.object.po_number.selected
		ll_RowID = dw_podetail.object.row_id.selected
		ls_Part = dw_podetail.object.part_number.selected
		ll_CommittedQty = dw_podetail.object.committed_qty.selected

		for li_Count = 1 to UpperBound ( ls_Part )
			if ll_CommittedQty [ li_Count ] > 0 then
				MessageBox ( gnv_App.iapp_Object.DisplayName, "This item has already been scheduled to ship.  The ship schedule for this item must be cancelled before cancelling this item.", StopSign! )
			elseif MessageBox ( gnv_App.iapp_Object.DisplayName, "Are you sure you want to delete " + ls_Part [ li_Count ] + " from PO Number " + String ( ll_PONumber [ li_Count ] ) + "?", Question!, YesNo!, 2 ) = 1 then
				of_DestroyDropShipPOLineItem ( ll_PONumber [ li_Count ], ll_RowID [ li_Count ] )
			end if
		next
		post of_Refresh ( )
	case else
end choose

end event

type dw_podetail from u_dw within w_dropship_main
string tag = "podetail"
integer x = 1253
integer y = 72
integer width = 1161
integer height = 564
integer taborder = 0
string dragicon = "Application!"
boolean bringtotop = true
string dataobject = "d_dropshippodetail"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )
of_SetSort ( true )
ib_RMBMenu = false

//	Setup row selection
inv_RowSelect.of_SetStyle ( inv_RowSelect.EXTENDED )

//	Set column sorting option.
inv_Sort.of_SetColumnHeader ( true )

end event

event clicked;call super::clicked;
//	Actions taken if row clicked.
if row > 0 then
	
	Drag ( Begin! )
	SetCapture ( Handle ( this ) )
	of_Dragging ( true, gb_2.ii_GB )
end if

end event

event lbuttonup;call super::lbuttonup;
//	No longer dragging.
of_Dragging ( false, gb_1.ii_GB )

end event

event dragdrop;call super::dragdrop;
//	Declarations.
decimal	ldec_Quantity [ ]

integer	li_Count
integer	li_Print

long	ll_SalesOrder [ ]
long	ll_OrderDetailID [ ]
long	ll_PONumber
long	ll_ShipperID [ ]

string	ls_Part [ ]
string	ls_Unit [ ]

//	If source is orders, then open window to create PO.
choose case source.tag
	case "orders"
		of_OEsToPO ( )
		of_Refresh ( )
	case "shipperdetail"
		ll_ShipperID = dw_shipperdetail.object.shipper.selected
		ls_Part = dw_shipperdetail.object.part.selected
		
		for li_Count = 1 to UpperBound ( ls_Part )
			if MessageBox ( gnv_App.iapp_Object.DisplayName, "Are you sure you want to delete " + ls_Part [ li_Count ] + " from Shipper " + String ( ll_ShipperID [ li_Count ] ) + "?", Question!, YesNo!, 2 ) = 1 then
				of_DestroyDropShipShipperLineItem ( ll_ShipperID [ li_Count ], ls_Part [ li_Count ] )
			end if
		next
		post of_Refresh ( )
	case else
end choose

end event

type dw_shipperdetail from u_dw within w_dropship_main
string tag = "shipperdetail"
integer x = 1253
integer y = 728
integer width = 1161
integer height = 564
integer taborder = 0
string dragicon = "Application!"
boolean bringtotop = true
string dataobject = "d_dropshipshipperdetail"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;
//	Actions taken if row clicked.
if row > 0 then
	
	Drag ( Begin! )
	SetCapture ( Handle ( this ) )
	of_Dragging ( true, gb_4.ii_GB )
end if

end event

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )
of_SetSort ( true )
ib_RMBMenu = false

//	Setup row selection
inv_RowSelect.of_SetStyle ( inv_RowSelect.EXTENDED )

//	Set column sorting option.
inv_Sort.of_SetColumnHeader ( true )

end event

event lbuttonup;call super::lbuttonup;
//	No longer dragging.
of_Dragging ( false, gb_1.ii_GB )

end event

event dragdrop;call super::dragdrop;
//	If source is orders, then open window to create PO.
choose case source.tag
	case "orders"
		of_OEsToShipper ( )
		post of_Refresh ( )
	case "podetail"
		of_POsToShipper ( "" )
		post of_Refresh ( )
end choose

end event

type dw_shipper from u_dw within w_dropship_main
string tag = "shipperhead"
integer x = 32
integer y = 728
integer width = 1161
integer height = 564
integer taborder = 0
string dragicon = "Application!"
boolean bringtotop = true
string dataobject = "d_dropshipshipper"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
//	Setup services.
of_SetTransObject ( sqlca )
of_SetRowSelect ( true )
of_SetSort ( true )
ib_RMBMenu = false

//	Setup row selection
inv_RowSelect.of_SetStyle ( inv_RowSelect.EXTENDED )

//	Set column sorting option.
inv_Sort.of_SetColumnHeader ( true )

end event

event rowfocuschanged;call super::rowfocuschanged;
//	Retrieve detail.
if currentrow > 0 then
	dw_shipperdetail.post Retrieve ( object.id [ currentrow ] )
end if

end event

event lbuttonup;call super::lbuttonup;
//	No longer dragging.
of_Dragging ( false, gb_1.ii_GB )

end event

event clicked;call super::clicked;
//	Actions taken if row clicked.
if row > 0 then
	
//	Drag ( Begin! )
//	SetCapture ( Handle ( this ) )
//	of_Dragging ( true, gb_3.ii_GB )
	dw_shipperdetail.Reset ( )
	dw_shipperdetail.post Retrieve ( object.id [ row ] )
end if

end event

event dragdrop;call super::dragdrop;
//	If source is orders, then open window to create PO.
choose case source.tag
	case "orders"
		of_OEsToShipper ( )
		post of_Refresh ( )
	case "podetail"
		of_POsToShipper ( "" )
		post of_Refresh ( )
end choose

end event

type st_hsplit1 from u_st_splitbar within w_dropship_main
integer y = 648
integer width = 2487
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type

type st_vsplit1 from u_st_splitbar within w_dropship_main
integer x = 1216
integer width = 18
integer height = 1340
fontcharset fontcharset = ansi!
end type


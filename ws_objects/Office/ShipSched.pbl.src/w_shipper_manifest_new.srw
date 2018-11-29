$PBExportHeader$w_shipper_manifest_new.srw
forward
global type w_shipper_manifest_new from w_shipper_header_info
end type
type dw_shipper_list from u_dw within w_shipper_manifest_new
end type
type gb_line_items from groupbox within w_shipper_manifest_new
end type
type gb_shipper_list from groupbox within w_shipper_manifest_new
end type
type dw_shipper_detail from datawindow within w_shipper_manifest_new
end type
type st_d_shipper_detail_new from structure within w_shipper_manifest_new
end type
type st_d_shipper_header_info_new from structure within w_shipper_manifest_new
end type
end forward

type st_d_shipper_detail_new from structure
	string		part
	datetime	due_datetime
	decimal {0}	suggested
	string		um
	decimal {0}	quantity
	decimal {0}	standard_pack
	long		order_no
	string		customer_part
	long		suffix
	long		shipper
	string		note
end type

type st_d_shipper_header_info_new from structure
	long		id
	datetime		date_stamp
	string		shipping_dock
	string		aetc_number
	string		freight_type
	string		plant
	string		status
	string		ship_via
	string		destination
	string		trans_mode
	long		IsExpedite
	string		ExpediteCode
	decimal { 6 }		freight
	string		notes
	string		model_year
	string		customer
	string		invoiced
	string		shiptype
	string		invoice_printed
	decimal { 6 }		tax_rate
	string		picklist_printed
	string		printed
	string		terms
	string		location
	string		currency_unit
	string		cs_status
end type

global type w_shipper_manifest_new from w_shipper_header_info
integer x = 5
integer y = 4
integer width = 3392
integer height = 2076
dw_shipper_list dw_shipper_list
gb_line_items gb_line_items
gb_shipper_list gb_shipper_list
dw_shipper_detail dw_shipper_detail
end type
global w_shipper_manifest_new w_shipper_manifest_new

type variables
Private:
boolean	ib_Saved

character	ic_ShipType

CONSTANT INTEGER	ERRCREATESHIPPER = -1
CONSTANT INTEGER	ERRUPDATESHIPPER = -2
CONSTANT INTEGER	ERRCREATESHIPPERDETAIL = -3
CONSTANT INTEGER	ERRUPDATESHIPPERDETAIL = -4
CONSTANT INTEGER	ERRNOHEADER = -5
CONSTANT INTEGER	ERRNODETAIL = -6

datetime	idt_DueDT

long	il_orderno[1]

string	is_ShipTo
string	is_ShipperNote


DataStore	ids_st_parm
end variables

forward prototypes
private function integer wf_update ()
public function integer wf_modifiedcount()
private function integer wf_saveerror(integer ai_error)
public function bel_shipperheader buildshipperheader () throws exception
end prototypes

private function integer wf_update ();
//	Declarations.
long	ll_ShipperID
long	ll_LineItems = 0
long	ll_LineCount = 0

st_d_shipper_detail_new	lst_LineItem[]

bll_gss GSS

//	Accept all edits.
dw_shipper.AcceptText()
dw_shipper_detail.AcceptText()

//	Remove any rows that have quantities <= zero.
dw_shipper_detail.SetFilter("quantity > 0")
dw_shipper_detail.Filter()

//	Check for row in shipper table.
if dw_shipper.RowCount() <> 1 then
	return wf_SaveError(ERRNOHEADER)
end if
if dw_shipper_detail.RowCount() <= 0 then
	return wf_SaveError(ERRNODETAIL)
end if

//	Create new shipper if new required.
bel_ShipperHeader shipperHeader
try
	//	Build shipperHeader record from data...
	shipperHeader = BuildShipperHeader()
catch (Exception ex)
	MsgBox(ex.Text)
end try
	
ll_ShipperID = shipperHeader.ID
if ll_ShipperID = 0 then
	choose case GSS.NewShipperHeader(shipperHeader)
		case SUCCESS
		case else
			return wf_SaveError(ERRCREATESHIPPER)
	end choose
else
	if dw_shipper.Update() <> 1 then
		return wf_SaveError(ERRUPDATESHIPPER)
	end if
end if

//MsgBox("Shipper created: " + String (shipperHeader.ID))

//	Loop through newline items.
lst_LineItem = dw_shipper_detail.object.data
ll_LineItems = UpperBound(lst_LineItem)
for ll_LineCount = 1 to ll_LineItems
	if lst_LineItem[ll_LineCount].quantity > 0 then
		//	Create new shipper detail if line item is distinct.
		if not GSS.FindShipperDetail(shipperHeader.ID, lst_LineItem[ll_LineCount].part, lst_LineItem[ll_LineCount].suffix) = 0 then
			choose case GSS.CreateShipperDetail(shipperHeader.ID, lst_LineItem[ll_LineCount].order_no, lst_LineItem[ll_LineCount].part, lst_LineItem[ll_LineCount].suffix, lst_LineItem[ll_LineCount].note)
				case 0
				case else
					return wf_SaveError(ERRCREATESHIPPERDETAIL)
			end choose
		end if
		//	Combine line item requirement with shipper detail.
		if GSS.UpdateShipperRequirements(shipperHeader.ID, lst_LineItem[ll_LineCount].part, lst_LineItem[ll_LineCount].suffix, lst_LineItem[ll_LineCount].quantity) < 0 then
			return wf_SaveError(ERRUPDATESHIPPERDETAIL)
		end if
	end if
next

//	Set saved flag.
sqlca.of_Commit()
dw_shipper.ResetUpdate()
ib_Saved = true
return SUCCESS

end function

public function integer wf_modifiedcount();
//	If save was successful, return 0, otherwise return 1.
if ib_Saved then
	return 0
else
	return 1
end if
end function

private function integer wf_saveerror(integer ai_error);
//	Reset filter on line items and rollback transaction.
dw_shipper_detail.SetFilter("")
dw_shipper_detail.Filter()
dw_shipper_detail.Sort()
sqlca.of_Rollback()

//	Return.
return ai_Error

end function

public function bel_shipperheader buildshipperheader () throws exception;
Exception ex

//	Validate datawindow row.
if	dw_shipper.RowCount() < 1 then
	ex = create Exception
	ex.Text = "Shipper header row not found!"
	throw ex
end if
if	dw_shipper.RowCount() > 1 then
	ex = create Exception
	ex.Text = "Multiple shipper header rows found!"
	throw ex
end if

st_d_shipper_header_info_new shipperHeaderInfo
shipperHeaderInfo = dw_shipper.object.data[1]

bel_ShipperHeader shipperHeader
shipperHeader = create bel_ShipperHeader
shipperHeader.SetID(shipperHeaderInfo.id)
shipperHeader.FreightType = shipperHeaderInfo.freight_type
shipperHeader.ShipFrom = shipperHeaderInfo.plant
shipperHeader.ShipTo = shipperHeaderInfo.destination
shipperHeader.BillTo = shipperHeaderInfo.customer
shipperHeader.Status = 'O'
SetNull(shipperHeader.ShipType)
SetNull(shipperHeader.BillOfLadingNumber)
shipperHeader.Carrier = shipperHeaderInfo.ship_via
shipperHeader.Transport = shipperHeaderInfo.trans_mode
shipperHeader.ExpediteCode = shipperHeaderInfo.ExpediteCode
shipperHeader.Terms = shipperHeaderInfo.terms
shipperHeader.Currency = shipperHeaderInfo.currency_unit
shipperHeader.CustomerStatus = shipperHeaderInfo.cs_status
shipperHeader.FreeOnBoard = shipperHeaderInfo.location
shipperHeader.DepartureDockCode = shipperHeaderInfo.shipping_dock
SetNull(shipperHeader.ArrivalDockCode)
shipperHeader.ExpediteAuthorization = shipperHeaderInfo.aetc_number
shipperHeader.Notes = shipperHeaderInfo.notes
shipperHeader.FreightAmount = shipperHeaderInfo.freight
shipperHeader.TaxRate = shipperHeaderInfo.tax_rate
shipperHeader.GrossWeight = 0
shipperHeader.NetWeight = 0
shipperHeader.TareWeight = 0
shipperHeader.Boxes = 0
shipperHeader.Pallets = 0
shipperHeader.ScheduledDepartureDT = shipperHeaderInfo.date_stamp
SetNull(shipperHeader.ShippedDT)
shipperHeader.PicklistPrinted = false
shipperHeader.PacklistPrinted = false
SetNull(shipperHeader.InvoiceNumber)
shipperHeader.Invoiced = false
shipperHeader.InvoicePrinted = false
shipperHeader.Posted = false

return shipperHeader

end function

on w_shipper_manifest_new.create
int iCurrent
call super::create
this.dw_shipper_list=create dw_shipper_list
this.gb_line_items=create gb_line_items
this.gb_shipper_list=create gb_shipper_list
this.dw_shipper_detail=create dw_shipper_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipper_list
this.Control[iCurrent+2]=this.gb_line_items
this.Control[iCurrent+3]=this.gb_shipper_list
this.Control[iCurrent+4]=this.dw_shipper_detail
end on

on w_shipper_manifest_new.destroy
call super::destroy
destroy(this.dw_shipper_list)
destroy(this.gb_line_items)
destroy(this.gb_shipper_list)
destroy(this.dw_shipper_detail)
end on

event pfc_preopen;
//	Declarations.
long	ll_ExcludeShipper
long	ll_SelectShipper
long	ll_Row

n_cst_associative_array	ln_cst_Parm

//	Initializations.
ln_cst_Parm = Message.PowerObjectParm
ids_st_parm = IsNull(ln_cst_Parm.of_GetItem("shipper detail"), ids_st_parm)
is_ShipperNote = IsNull(ln_cst_Parm.of_GetItem("shipper note"), is_ShipperNote)
ll_SelectShipper = IsNull(ln_cst_Parm.of_GetItem("shipper id"), 0)
ic_ShipType = IsNull(ln_cst_Parm.of_GetItem("shiptype"), ic_ShipType)
is_ShipTo = IsNull(ln_cst_Parm.of_GetItem("shipto"), is_ShipTo)
idt_DueDT = IsNull(ln_cst_Parm.of_GetItem("DueDT"), datetime(today(),now()))

//	Setup display.
if IsValid(ids_st_parm) then
	
	//	Show line items.
	if ids_st_parm.RowsCopy(1, ids_st_parm.RowCount(), Primary!, dw_shipper_detail, 1, Primary!) <> 1 then
		MessageBox(monsys.msg_Title, "Application Error:  Unable to copy shipper detail rows.", StopSign!)
		post CloseWithReturn(this, -1)
		return
	end if
	
	dw_shipper_detail.Sort()
	if dw_shipper_detail.RowCount() > 0 then
		
		//	Get order number of demand and shipper to exclude.
		il_OrderNo[1] = dw_shipper_detail.object.order_no[1]
		ll_ExcludeShipper = dw_shipper_detail.object.shipper[1]
		
		//	Show shipper list.
		dw_shipper_list.Retrieve(ic_ShipType, il_OrderNo, is_ShipTo, idt_DueDT)
		
		//	Filter shipper list for excluded shipper.
		dw_shipper_list.SetFilter("id <> " + String(ll_ExcludeShipper))
		dw_shipper_list.Filter()
		
		//	Set the note on the first shipper.
		if is_ShipperNote > "" then dw_shipper_list.object.notes[1] = is_ShipperNote
		
		//	Find the shipper to find.
		ll_Row = dw_shipper_list.Find("id = " + String(ll_SelectShipper), 1, dw_shipper_list.RowCount())
		if ll_Row > 0 then
			dw_shipper_list.post function SetRow(ll_Row)
		end if
	end if
end if

//	turn off updateable service
of_SetUpdateable(false)

end event

type cb_cancel from w_shipper_header_info`cb_cancel within w_shipper_manifest_new
integer x = 3045
integer y = 148
integer width = 306
integer taborder = 50
end type

type cb_ok from w_shipper_header_info`cb_ok within w_shipper_manifest_new
integer x = 3045
integer y = 28
integer width = 306
integer taborder = 40
end type

type cb_1 from w_shipper_header_info`cb_1 within w_shipper_manifest_new
boolean visible = false
end type

type dw_shipper from w_shipper_header_info`dw_shipper within w_shipper_manifest_new
integer x = 0
integer y = 548
integer width = 3013
integer height = 688
integer taborder = 20
string dataobject = "d_shipper_header_info_new"
end type

event dw_shipper::retrieveend;call super::retrieveend;
//	In single plant mode set plant and prevent over-write.
if IsNull(Message.inv_Parm.of_GetItem("Plant"), "") > "" then
	object.plant[1] = Message.inv_Parm.of_GetItem("Plant")
	SetTabOrder('plant', 0) 
end if	

end event

event dw_shipper::itemchanged;call super::itemchanged;//string lst_name
//long ll_row, ll_freight,ll_freight_region
//
//DataStore lds_default_freight
//lds_default_freight  = Create DataStore
//lds_default_freight.DataObject = 'd_get_default_freight_charge'
//lds_default_freight.SetTranSobject(sqlca)
//
//DataStore lds_order_freight
//lds_order_freight  = Create DataStore
//lds_order_freight.DataObject = 'd_order_freight'
//lds_order_freight.SetTranSobject(sqlca)
//
//DataStore lds_freight_region
//lds_freight_region  = Create DataStore
//lds_freight_region.DataObject = 'd_get_freight_region'
//lds_freight_region.SetTranSobject(sqlca)
//
//ll_row = lds_freight_region.retrieve(dw_shipper.object.destination[1])
//if ll_row > 0 then
//	ll_freight_region = lds_freight_region.object.freightRegion[1]
//end if
//
//
//lst_name = dwo.name 
//
//if lst_name = 'ship_via' then
//	ll_row = lds_order_freight.retrieve(il_orderno[1])
//	if ll_row > 0 then
//		ll_freight = lds_order_freight.object.freight[ll_row]
//	else
//		ll_freight = 0
//	end if
//	if isnull(ll_freight) or ll_freight = 0 then
//		ll_row = lds_default_freight.retrieve(data,this.object.trans_mode[row],ll_freight_region) 
//		if ll_row > 0 then
//			ll_freight = lds_default_freight.object.DefaultFreightCharge[ll_row]
//			this.setItem(1, "freight", ll_freight)
//		else
//			ll_freight = 0
//			this.setItem(1, "freight", ll_freight)
//		end if
//	end if
//end if
//	
//if lst_name = 'trans_mode' then
//	ll_row = lds_order_freight.retrieve(il_orderno[1])
//	if ll_row > 0 then
//		ll_freight = lds_order_freight.object.freight[ll_row]
//	else
//		ll_freight = 0
//	end if
//	if isnull(ll_freight) or ll_freight = 0 then
//		ll_row = lds_default_freight.retrieve(this.object.ship_via[row],data,ll_freight_region) 
//		if ll_row > 0 then
//			ll_freight = lds_default_freight.object.DefaultFreightCharge[ll_row]
//			this.setItem(1, "freight", ll_freight)
//		else
//			ll_freight = 0
//			this.setItem(1, "freight", ll_freight)
//		end if
//	end if
//end if	
end event

type dw_shipper_list from u_dw within w_shipper_manifest_new
integer x = 41
integer y = 104
integer width = 2958
integer height = 432
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_shippers_with_same_destination"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;
//	Set Transaction Object and Retrieve.
SetTransObject(SQLCA)
of_SetUpdateable(false)

//	Turn on Row Selection service.
of_SetRowSelect(true)

//	Turn off PFC right button popup menu so that our own can be used.
ib_RMBMenu = false

end event

event rowfocuschanged;call super::rowfocuschanged;string ls_terms
dw_shipper.SetRedraw(false)
// MOD:200659141211
		// Get the shipper term from the orde
			select	terms
			into :ls_terms
			from	CSOrderHeaders
			where	OrderNo = :il_OrderNo[1]using SQLCA  ;
// 
if currentrow > 0 then
	if currentrow = 1 then
		dw_shipper.DataObject = "d_shipper_header_info_new"
		dw_shipper.SetTransObject(SQLCA)
		dw_shipper.Retrieve(ic_ShipType, il_OrderNo[1], is_ShipTo, idt_DueDT)
		if is_ShipperNote > "" then dw_shipper.object.notes[1] = is_ShipperNote
	else
		dw_shipper.DataObject = "d_shipper_header_info_combine"
		dw_shipper.SetTransObject(SQLCA)
		dw_shipper.Retrieve(object.id[currentrow])
	end if
end if
dw_shipper.setitem(1,"terms", ls_terms)
dw_shipper.SetRedraw(true)

end event

type gb_line_items from groupbox within w_shipper_manifest_new
integer x = 27
integer y = 1260
integer width = 2981
integer height = 708
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
string text = "Line Items"
end type

type gb_shipper_list from groupbox within w_shipper_manifest_new
integer x = 27
integer y = 4
integer width = 2981
integer height = 540
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Shippers for destination:"
end type

type dw_shipper_detail from datawindow within w_shipper_manifest_new
integer x = 41
integer y = 1360
integer width = 2958
integer height = 600
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_line_item_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type


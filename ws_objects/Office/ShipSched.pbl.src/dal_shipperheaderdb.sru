$PBExportHeader$dal_shipperheaderdb.sru
forward
global type dal_shipperheaderdb from dal_businessbasedb
end type
end forward

global type dal_shipperheaderdb from dal_businessbasedb
end type
global dal_shipperheaderdb dal_shipperheaderdb

type variables

Public:
boolean Invoiced
boolean Posted
boolean InvoicePrinted
boolean PicklistPrinted
boolean PacklistPrinted

long BillOfLadingNumber
long InvoiceNumber

datetime RequiredDepartureDT
datetime ShippedDT

string FreightType	//refactor to bel_FreightType
string ShipFrom		//refactor to bel_Plant
string ShipTo		//refactor to bel_ShipTo
string BillTo		//refactor to bel_BillTo
string Status		//refactor to bitfield Status[Shipper]
string ShipType		//refactor to bitfield Type[Shipper]
string Carrier		//refactor to bel_Carrier
string Transport	//refactor to bel_Transport
string Terms		//refactor to bel_Terms
string Currency		//refactor to bel_Currency
string CustomerStatus	//refactor to bitfield Status[Customer]
string FreeOnBoard
string TruckNumber
string SealNumber
string TrackingNumber	//aka ProNumber
string DepartureDockCode
string ArrivalDockCode
string ExpediteAuthorization
string Notes

decimal{6} FreightAmount
decimal{6} TaxRate
decimal{6} GrossWeight
decimal{6} NetWeight
decimal{6} TareWeight

int Boxes
int Pallets

end variables

forward prototypes
public function integer newshipper (ref bel_shipperheader _shipperheader)
end prototypes

public function integer newshipper (ref bel_shipperheader _shipperheader);
//	Get a new shipper number.
update	parameters
set	shipper = shipper + 1 using SQLTrans  ;

if	SQLTrans.SQLCode <> 0 then
	rollback using SQLTrans  ;
	MsgBox("Failure setting next shipper number:  " + SQLTrans.SQLErrText)
end if

select	shipper - 1
into	:_shipperHeader.ID
from	parameters using SQLTrans  ;

if	SQLTrans.SQLCode <> 0 then
	rollback using SQLTrans  ;
	MsgBox("Failure getting next shipper number:  " + SQLTrans.SQLErrText)
end if

//	Insert shipper header.
string	packlistPrintedFlag = 'N', invoicedFlag = 'N', invoicePrintedFlag = 'N', picklistPrintedFlag = 'N', postedFlag = 'N', dropshipReconciledFlag = 'N'
if _shipperHeader.PacklistPrinted then packlistPrintedFlag = 'Y'
if _shipperHeader.Invoiced then invoicedFlag = 'Y'
if _shipperHeader.InvoicePrinted then invoicePrintedFlag = 'Y'
if _shipperHeader.PicklistPrinted then picklistPrintedFlag = 'Y'
if _shipperHeader.Posted then postedFlag = 'Y'
if IsNull(_shipperHeader.DropShipReconciled) then SetNull(dropshipReconciledFlag)
if _shipperHeader.DropShipReconciled then dropshipReconciledFlag = 'Y'

insert	shipper
(	id, destination, shipping_dock,
	ship_via, status, date_shipped,
	aetc_number, freight_type, printed,
	bill_of_lading_number, customer, location,
	staged_objs, plant, type,
	invoiced, invoice_number, freight,
	tax_percentage, gross_weight, net_weight,
	tare_weight, trans_mode, pro_number,
	notes, time_shipped, truck_number,
	invoice_printed, seal_number, terms,
	tax_rate, staged_pallets, picklist_printed,
	posted, currency_unit, cs_status,
	date_stamp, scheduled_ship_time, dropship_reconciled,
	operator, ExpediteCode)
values
(	:_shipperHeader.ID, :_shipperHeader.ShipTo, :_shipperHeader.ArrivalDockCode,
	:_shipperHeader.Carrier, :_shipperHeader.Status, :_shipperHeader.ShippedDT,
	:_shipperHeader.ExpediteAuthorization, :_shipperHeader.FreightType, :packlistPrintedFlag,
	:_shipperHeader.BillOfLadingNumber, :_shipperHeader.BillTo, :_shipperHeader.FreeOnBoard,
	:_shipperHeader.Boxes, :_shipperHeader.ShipFrom, :_shipperHeader.ShipType,
	:invoicedFlag, :_shipperHeader.InvoiceNumber, :_shipperHeader.FreightAmount,
	:_shipperHeader.TaxRate, :_shipperHeader.GrossWeight, :_shipperHeader.NetWeight,
	:_shipperHeader.TareWeight, :_shipperHeader.Transport, :_shipperHeader.TrackingNumber,
	:_shipperHeader.Notes, :_shipperHeader.ShippedDT, :_shipperHeader.TruckNumber,
	:invoicePrintedFlag, :_shipperHeader.SealNumber, :_shipperHeader.Terms,
	:_shipperHeader.TaxRate, :_shipperHeader.Pallets, :picklistPrintedFlag,
	:postedFlag, :_shipperHeader.Currency, :_shipperHeader.CustomerStatus,
	:_shipperHeader.ScheduledDepartureDT, :_shipperHeader.ScheduledDepartureDT, :dropshipReconciledFlag,
	:_shipperHeader.operator, :_shipperHeader.ExpediteCode) using SQLTrans  ;

if	SQLTrans.SQLCode <> 0 then
	rollback using SQLTrans  ;
	MsgBox("Failure inserting shipper:  " + SQLTrans.SQLErrText)
end if

return	SUCCESS

end function

on dal_shipperheaderdb.create
call super::create
end on

on dal_shipperheaderdb.destroy
call super::destroy
end on


$PBExportHeader$bel_shipperheader.sru
forward
global type bel_shipperheader from bel_businessbase
end type
end forward

global type bel_shipperheader from bel_businessbase
end type
global bel_shipperheader bel_shipperheader

type variables

Public:
boolean Invoiced
boolean Posted
boolean InvoicePrinted
boolean PicklistPrinted
boolean PacklistPrinted
boolean DropShipReconciled	//refactor to bel_ShipperHeaderDropShip

long BillOfLadingNumber
long InvoiceNumber

datetime ScheduledDepartureDT
datetime ShippedDT	//refactor to bel_ShipperHeader_History

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
string Operator		//refactor to bel_ShipperHeader_History
string FreeOnBoard
string TruckNumber
string SealNumber
string TrackingNumber	//aka ProNumber
string DepartureDockCode
string ArrivalDockCode
string ExpediteAuthorization
string Notes
string ExpediteCode

decimal{6} FreightAmount
decimal{6} TaxRate
decimal{6} GrossWeight
decimal{6} NetWeight
decimal{6} TareWeight

int Boxes
int Pallets

end variables

on bel_shipperheader.create
call super::create
end on

on bel_shipperheader.destroy
call super::destroy
end on


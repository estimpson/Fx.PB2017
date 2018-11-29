$PBExportHeader$bel_shipperlineitem.sru
forward
global type bel_shipperlineitem from bel_businessbase
end type
end forward

global type bel_shipperlineitem from bel_businessbase
end type
global bel_shipperlineitem bel_shipperlineitem

type variables

Public:
boolean Taxable
boolean StageByWeight

bel_ShipperHeader ShipperHeader
long OrderNo		//refactor to bel_OrderHeader.OrderNo
long Suffix		//refactor to bel_OrderLineItem.Suffix

string LineItemType	//refactro to bitfield Type[ShipperLineItem]
string Part		//refactor to bel_Part
string AccountCode	//refactor to bel_AccountCode
string BoxPackageType	//refactor to bel_PackageType
string Operator		//refactor to bel_ShipperLineItem_History
string CustomerPO	//refactor to bel_OrderHeader.CustomerPO
string ReleaseNo	//refactor to bel_OrderLineItem.ReleaseNo
string Salesman
string UnitMeasure
string PriceType
string CustomerPart	//refactor to bel_OrderLineItem.CustomerPart
string LineItemDescription
string Notes

datetime ReleaseDT
datetime ShippedDT	//refactor to bel_ShipperLineItem_History

decimal{6} RequiredQty
decimal{6} PackedQty
decimal{6} ReleaseQty
decimal{6} AccumShipped
decimal{6} UnitPrice
decimal{6} GrossWeight
decimal{6} TareWeight
decimal{6} NetWeight
decimal{6} PacklineQty
decimal{6} PackedStdQty
decimal{6} UnitStdPrice

int Boxes
int WeekNumber

//	RMA's
Long OriginalShipper
long OriginalSuffix

//	Drop Shipments
long DropShipPO
long DropShipPOLineItemID
long DropShipOELineItemID
long DropShipSerial

end variables

on bel_shipperlineitem.create
call super::create
end on

on bel_shipperlineitem.destroy
call super::destroy
end on


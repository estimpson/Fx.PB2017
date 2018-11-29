$PBExportHeader$dal_shipperlineitemdb.sru
forward
global type dal_shipperlineitemdb from dal_businessbasedb
end type
end forward

global type dal_shipperlineitemdb from dal_businessbasedb
end type
global dal_shipperlineitemdb dal_shipperlineitemdb

type variables

end variables

forward prototypes
public function integer newshipperlineitem (ref bel_shipperlineitem _shipperlineitem)
end prototypes

public function integer newshipperlineitem (ref bel_shipperlineitem _shipperlineitem);
//	Insert shipper line item.
string	taxableFlag = 'N', stageByWeightFlag = 'N'
if _shipperLineItem.Taxable then taxableFlag = 'Y'
if _shipperLineItem.StageByWeight then stageByWeightFlag = 'Y'

string	shipperLineItemPartWithSuffix
if	IsNull(_shipperLineItem.Suffix) then
	shipperLineItemPartWithSuffix = _shipperLineItem.Part
else
	shipperLineItemPartWithSuffix = _shipperLineItem.Part + '-' + String (_shipperLineItem.Suffix)
end if

insert	shipper_detail
(	shipper, part, qty_required,
	qty_packed, qty_original, accum_shipped,
	order_no, customer_po, release_no,
	release_date, price, account_code,
	salesman, tare_weight, gross_weight,
	net_weight, date_shipped, packaging_job,
	note, operator, boxes_staged,
	pack_line_qty, alternative_qty, alternative_unit,
	week_no, taxable, price_type,
	customer_part, suffix, part_name,
	part_original, stage_using_weight, alternate_price,
	old_suffix, old_shipper, dropship_po,
	dropship_po_row_id, dropship_oe_row_id, dropship_po_serial,
	dropship_invoice_serial)
values
(	:_shipperLineItem.ShipperHeader.ID, :shipperLineItemPartWithSuffix, :_shipperLineItem.RequiredQty,
	:_shipperLineItem.PackedQty, :_shipperLineItem.ReleaseQty, :_shipperLineItem.AccumShipped,
	:_shipperLineItem.OrderNo, :_shipperLineItem.CustomerPO, :_shipperLineItem.ReleaseNo,
	:_shipperLineItem.ReleaseDT, :_shipperLineItem.UnitPrice, :_shipperLineItem.AccountCode,
	:_shipperLineItem.Salesman, :_shipperLineItem.TareWeight, :_shipperLineItem.GrossWeight,
	:_shipperLineItem.NetWeight, :_shipperLineItem.ShippedDT, :_shipperLineItem.BoxPackageType,
	:_shipperLineItem.Notes, :_shipperLineItem.Operator, :_shipperLineItem.Boxes,
	:_shipperLineItem.PacklineQty, :_shipperLineItem.PackedStdQty, :_shipperLineItem.UnitMeasure,
	:_shipperLineItem.WeekNumber, :taxableFlag, :_shipperLineItem.PriceType,
	:_shipperLineItem.CustomerPart, :_shipperLineItem.Suffix, :_shipperLineItem.LineItemDescription,
	:_shipperLineItem.Part, :stageByWeightFlag, :_shipperLineItem.UnitStdPrice,
	:_shipperLineItem.OriginalSuffix, :_shipperLineItem.OriginalShipper, :_shipperLineItem.DropShipPO,
	:_shipperLineItem.DropShipPOLineItemID, :_shipperLineItem.DropShipOELineItemID, :_shipperLineItem.DropShipSerial,
	:_shipperLineItem.DropShipSerial) using SQLTrans  ;

if	SQLTrans.SQLCode <> 0 then
	rollback using SQLTrans  ;
	MsgBox("Failure inserting shipper:  " + SQLTrans.SQLErrText)
end if

return	SUCCESS

end function

on dal_shipperlineitemdb.create
call super::create
end on

on dal_shipperlineitemdb.destroy
call super::destroy
end on


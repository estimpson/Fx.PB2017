$PBExportHeader$n_cst_dropship_trans.sru
forward
global type n_cst_dropship_trans from n_cst_fxtrans
end type
end forward

global type n_cst_dropship_trans from n_cst_fxtrans
end type

forward prototypes
public function integer createdropshipshipper (string _operator, long _ponumber, datetime _shipdt, ref long _shipperid)
public function integer destroydropshipshipperlineitem (long _shipperid, string _partnumber)
public function integer createdropshipshipperlineitem (string _operator, long _shipperid, decimal _quantity, long _ponumber, long _porowid)
public function integer destroydropshippolineitem (long _ponumber, long _porowid)
public function integer dropshipreconcile (long _invoicenumber)
public function integer createdropshippo (string _vendor, string _shipto, ref long _ponumber)
public function integer createdropshippolineitem (long _ponumber, decimal _quantity, decimal _price, long _orderdetailid)
public function integer getpartvendorpricebreak (string _part, string _vendor, decimal _quantity, ref decimal _price)
public function integer dropship (string _operator, long _shipperid, ref long _invoicenumber)
end prototypes

public function integer createdropshipshipper (string _operator, long _ponumber, datetime _shipdt, ref long _shipperid);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare CreateDropShipShipper dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@ShipperID integer, "+&
	"		@Result integer "+&
	" "+&
	" 	EXECUTE msp_CreateDropShipShipper "+&
	"		@Operator = ?, "+&
	"		@PONumber = ?, "+&
	"		@ShipperDT = ?, "+&
	"		@ShipperID = @ShipperID output, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@ShipperID, "+&
	"		@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute CreateDropShipShipper procedure.
execute dynamic CreateDropShipShipper using :_operator, :_poNumber, :_shipDT  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipShipper while performing CreateDropShipShipper." + SQLErrText)
	return returnValue
end if

fetch	CreateDropShipShipper
into	:_shipperID,
	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipShipper while performing CreateDropShipShipper." + SQLErrText)
	return returnValue
end if

close	CreateDropShipShipper  ;

//	Return.
return returnValue

end function

public function integer destroydropshipshipperlineitem (long _shipperid, string _partnumber);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare DestroyDropShipShipperLineItem dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@Result integer "+&
	" "+&
	" 	EXECUTE msp_DestroyDropShipShipperLineItem "+&
	"		@ShipperID = ?, "+&
	"		@PartNumber = ?, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute DestroyDropShipShipperLineItem procedure.
execute dynamic DestroyDropShipShipperLineItem using :_shipperid, :_partNumber  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DestroyDropShipShipperLineItem while performing DestroyDropShipShipperLineItem." + SQLErrText)
	return returnValue
end if

fetch	DestroyDropShipShipperLineItem
into	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DestroyDropShipShipperLineItem while performing DestroyDropShipShipperLineItem." + SQLErrText)
	return returnValue
end if

close	DestroyDropShipShipperLineItem  ;

//	Return.
return returnValue

end function

public function integer createdropshipshipperlineitem (string _operator, long _shipperid, decimal _quantity, long _ponumber, long _porowid);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare CreateDropShipShipperLineItem dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@Result integer "+&
	" "+&
	" 	EXECUTE msp_CreateDropShipShipperLineItem "+&
	"		@Operator = ?, "+&
	"		@ShipperID = ?, "+&
	"		@Quantity = ?, "+&
	"		@PONumber = ?, "+&
	"		@PORowID = ?, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute CreateDropShipShipperLineItem procedure.
execute dynamic CreateDropShipShipperLineItem using :_operator, :_shipperID, :_quantity, :_poNumber, :_poRowID  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipShipperLineItem while performing CreateDropShipShipperLineItem." + SQLErrText)
	return returnValue
end if

fetch	CreateDropShipShipperLineItem
into	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipShipperLineItem while performing CreateDropShipShipperLineItem." + SQLErrText)
	return returnValue
end if

close	CreateDropShipShipperLineItem  ;

//	Return.
return returnValue

end function

public function integer destroydropshippolineitem (long _ponumber, long _porowid);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare DestroyDropShipPOLineItem dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@Result integer "+&
	" "+&
	" 	EXECUTE msp_DestroyDropShipPOLineItem "+&
	"		@PONumber = ?, "+&
	"		@RowID = ?, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute DestroyDropShipPOLineItem procedure.
execute dynamic DestroyDropShipPOLineItem using :_poNumber, :_poRowID  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DestroyDropShipPOLineItem while performing DestroyDropShipPOLineItem." + SQLErrText)
	return returnValue
end if

fetch	DestroyDropShipPOLineItem
into	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DestroyDropShipPOLineItem while performing DestroyDropShipPOLineItem." + SQLErrText)
	return returnValue
end if

close	DestroyDropShipPOLineItem  ;

//	Return.
return returnValue

end function

public function integer dropshipreconcile (long _invoicenumber);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare DropShipReconcile dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@Result integer "+&
	" "+&
	" 	EXECUTE mspapi_DropShipReconcile "+&
	"		@InvoiceNumber = ?, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute DropShipReconcile procedure.
execute dynamic DropShipReconcile using :_invoiceNumber  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DropShipReconcile while performing DropShipReconcile." + SQLErrText)
	return returnValue
end if

fetch	DropShipReconcile
into	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DropShipReconcile while performing DropShipReconcile." + SQLErrText)
	return returnValue
end if

close	DropShipReconcile  ;

//	Return.
return returnValue

end function

public function integer createdropshippo (string _vendor, string _shipto, ref long _ponumber);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare CreateDropShipPO dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@PONumber integer, "+&
	"		@Result integer "+&
	" "+&
	" 	EXECUTE msp_CreateDropShipPO "+&
	"		@Vendor = ?, "+&
	"		@ShipTo = ?, "+&
	"		@PONumber = @PONumber output, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@PONumber, "+&
	"		@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute CreateDropShipPO procedure.
execute dynamic CreateDropShipPO using :_vendor, :_shipTo  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipPO while performing CreateDropShipPO." + SQLErrText)
	return returnValue
end if

fetch	CreateDropShipPO
into	:_poNumber,
	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipPOwhile performing CreateDropShipPO." + SQLErrText)
	return returnValue
end if

close	CreateDropShipPO  ;

//	Return.
return returnValue

end function

public function integer createdropshippolineitem (long _ponumber, decimal _quantity, decimal _price, long _orderdetailid);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare CreateDropShipPOLineItem dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@Result integer "+&
	" "+&
	" 	EXECUTE msp_CreateDropShipPOLineItem "+&
	"		@PONumber = ?, "+&
	"		@Quantity = ?, "+&
	"		@Price = ?, "+&
	"		@OrderDetailID = ?, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute CreateDropShipPO procedure.
execute dynamic CreateDropShipPOLineItem using :_ponumber, :_quantity, :_price, :_orderDetailID  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipPOLineItem while performing CreateDropShipPOLineItem." + SQLErrText)
	return returnValue
end if

fetch	CreateDropShipPOLineItem
into	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_CreateDropShipPOLineItem performing CreateDropShipPOLineItem." + SQLErrText)
	return returnValue
end if

close	CreateDropShipPOLineItem  ;

//	Return.
return returnValue

end function

public function integer getpartvendorpricebreak (string _part, string _vendor, decimal _quantity, ref decimal _price);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

//	Get part vendor price break.
select	min(alternate_price)
into	:_price
from	part_vendor_price_matrix
where	part = :_part and
	vendor = :_vendor and
	break_qty <= :_quantity using TransObject  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute query while performing GetPartVendorPriceBreak." + SQLErrText)
	return returnValue
end if

//	Return.
return returnValue

end function

public function integer dropship (string _operator, long _shipperid, ref long _invoicenumber);
//	Check connection.
if	not IsValid (TransObject) then
	TransObject = SQLCA
end if

//	Declarations.
integer	returnValue = -1

string	executeStatement
string	SQLErrText

declare DropShip dynamic procedure for sqlsa  ;

//	Initializations.
executeStatement =&
	"BEGIN "+&
	"	DECLARE	@Result integer, "+&
	"		@InvoiceNumber integer "+&
	" "+&
	" 	EXECUTE mspapi_DropShip "+&
	"		@Operator = ?, "+&
	"		@ShipperID = ?, "+&
	"		@InvoiceNumber = @InvoiceNumber output, "+&
	"		@Result = @Result output "+&
	" "+&
	"	SELECT	@InvoiceNumber, "+&
	"		@Result "+&
	"END "

prepare SQLSA from :executeStatement using TransObject  ;

//	Execute DropShip procedure.
execute dynamic DropShip using :_operator, :_shipperID  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DropShip while performing DropShip." + SQLErrText)
	return returnValue
end if

fetch	DropShip
into	:_invoicenumber,
	:returnValue  ;

if TransObject.SQLCode <> 0 then
	returnValue = TransObject.SQLCode
	SQLErrText = TransObject.SQLErrText
	rollback using TransObject  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "Unable to execute msp_DropShip while performing DropShip." + SQLErrText)
	return returnValue
end if

close	DropShip  ;

//	Return.
return returnValue

end function

on n_cst_dropship_trans.create
call super::create
end on

on n_cst_dropship_trans.destroy
call super::destroy
end on


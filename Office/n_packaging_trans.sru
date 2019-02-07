HA$PBExportHeader$n_packaging_trans.sru
forward
global type n_packaging_trans from n_cst_fxtrans
end type
end forward

global type n_packaging_trans from n_cst_fxtrans
end type
global n_packaging_trans n_packaging_trans

forward prototypes
public function integer enablebulktracking (string packagecode, long totalquantity, long inhousequantity, long outsidequantity, datetime accumdt)
public function integer adjustquantities (string packagecode, long inhousequantityadjustment, long outsidequantityadjustment)
public function integer enableshipto (string packagecode, string destinationcode)
public function integer disableshipto (string packagecode, string destinationcode)
public function integer getactiveshiptos (string packagecode, ref string destinationcodes[])
public function integer receive (string packagecode, string destinationcode, string manifestnumber, long receivequantity, datetime receiptdt)
public function integer ship (string packagecode, string destinationcode, string manifestnumber, long shipquantity, datetime shipmentdt)
public function integer adjustshiptoquantity (string packagecode, string destinationcode, long netqtyadjustment)
public function integer adjustinhousequantity (string packagecode, long netqtyadjustment)
end prototypes

public function integer enablebulktracking (string packagecode, long totalquantity, long inhousequantity, long outsidequantity, datetime accumdt);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_Enable procedure for dbo.usp_Packaging_BulkTracking_Enable
	@User = :user
,	@PackageCode = :packageCode
,	@TotalQuantity = :totalQuantity
,	@InHouseQuantity = :inHouseQuantity
,	@OutsideQuantity = :outsideQuantity
,	@AccumDT = :accumDT
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_Enable  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to enable bulk tracking:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_Enable
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to enable bulk tracking:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_Enable   ;

//	Return.
return SUCCESS

end function

public function integer adjustquantities (string packagecode, long inhousequantityadjustment, long outsidequantityadjustment);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_AdjustQuantities procedure for dbo.usp_Packaging_BulkTracking_AdjustQuantity
	@User = :user
,	@PackageCode = :packageCode
,	@NetInHouseQuantityAdjustment = :inHouseQuantityAdjustment
,	@NetOutsideQuantityAdjustment = :outsideQuantityAdjustment
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_AdjustQuantities  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to adjust quantities:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_AdjustQuantities
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to adjust quantities:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_AdjustQuantities   ;

//	Return.
return SUCCESS

end function

public function integer enableshipto (string packagecode, string destinationcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_EnableShipTo procedure for dbo.usp_Packaging_BulkTracking_EnableShipTo
	@User = :user
,	@PackageCode = :packageCode
,	@DestinationCode = :DestinationCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_EnableShipTo  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to enable bulk tracking for destination:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_EnableShipTo
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to enable bulk tracking for destination:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_EnableShipTo   ;

//	Return.
return SUCCESS

end function

public function integer disableshipto (string packagecode, string destinationcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_DisableShipTo procedure for dbo.usp_Packaging_BulkTracking_DisableShipTo
	@User = :user
,	@PackageCode = :packageCode
,	@DestinationCode = :DestinationCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_DisableShipTo  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to disable bulk tracking for destination:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_DisableShipTo
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to disable bulk tracking for destination:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_DisableShipTo   ;

//	Return.
return SUCCESS

end function

public function integer getactiveshiptos (string packagecode, ref string destinationcodes[]);declare activeShipTos cursor for
select
	pbtst.DestinationCode
from
	dbo.Packaging_BulkTracking_ShipTos pbtst
where
	pbtst.PackageCode = :packageCode
order by
	pbtst.DestinationCode  ;

open activeShipTos  ;

int	Values = 0

do while 1 = 1
	string destinationCode
	fetch
		activeShipTos
	into
		:destinationCode  	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	destinationCodes[Values] = destinationCode
loop

close activeShipTos  ;

commit  ;

return SUCCESS

end function

public function integer receive (string packagecode, string destinationcode, string manifestnumber, long receivequantity, datetime receiptdt);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_ReceiveQuantity procedure for dbo.usp_Packaging_BulkTracking_ReceiveQuantity
	@User = :user
,	@PackageCode = :packageCode
,	@Destination = :destinationCode
,	@ManifestNumber = :manifestNumber
,	@ReceiveQuantity = :receiveQuantity
,	@ReceiptDT = :receiptDT
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_ReceiveQuantity  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to receive packaging:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_ReceiveQuantity
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to receive packaging:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_ReceiveQuantity   ;

//	Return.
return SUCCESS

end function

public function integer ship (string packagecode, string destinationcode, string manifestnumber, long shipquantity, datetime shipmentdt);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_ShipQuantity procedure for dbo.usp_Packaging_BulkTracking_ShipQuantity
	@User = :user
,	@PackageCode = :packageCode
,	@Destination = :destinationCode
,	@ManifestNumber = :manifestNumber
,	@ShipQuantity = :shipQuantity
,	@ShipmentDT = :shipmentDT
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_ShipQuantity  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to ship packaging:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_ShipQuantity
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to ship packaging:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_ShipQuantity   ;

//	Return.
return SUCCESS

end function

public function integer adjustshiptoquantity (string packagecode, string destinationcode, long netqtyadjustment);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_AdjustQuantities procedure for dbo.usp_Packaging_BulkTracking_AdjustQuantity
	@User = :user
,	@PackageCode = :packageCode
,	@DestinationCode = :destinationCode
,	@NetOutsideQuantityAdjustment = :netQtyAdjustment
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_AdjustQuantities  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to adjust quantities:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_AdjustQuantities
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to adjust quantities:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_AdjustQuantities   ;

//	Return.
return SUCCESS

end function

public function integer adjustinhousequantity (string packagecode, long netqtyadjustment);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare BulkTracking_AdjustQuantities procedure for dbo.usp_Packaging_BulkTracking_AdjustQuantity
	@User = :user
,	@PackageCode = :packageCode
,	@NetInHouseQuantityAdjustment = :netQtyAdjustment
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BulkTracking_AdjustQuantities  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to adjust quantities:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BulkTracking_AdjustQuantities
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to adjust quantities:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BulkTracking_AdjustQuantities   ;

//	Return.
return SUCCESS

end function

on n_packaging_trans.create
call super::create
end on

on n_packaging_trans.destroy
call super::destroy
end on


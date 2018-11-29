$PBExportHeader$n_cst_trans_shipping.sru
forward
global type n_cst_trans_shipping from n_cst_fxtrans
end type
end forward

global type n_cst_trans_shipping from n_cst_fxtrans
end type
global n_cst_trans_shipping n_cst_trans_shipping

forward prototypes
public function integer verifyshipperlistfordeparture (string shippernumberlist)
public function integer beginshipperlistdeparture (string operatorcode, string shippernumberlist, string trucknumber, string pronumber)
public function integer cancelshipperlistdeparture (string shippernumberlist)
public function integer getasnsrequiredforshipperlist (string shipperlist, ref long shipperids[])
public function integer completeshipperlistdeparture (string shippernumberlist, string pronumber)
public function integer overridescanning (string operatorcode, string shippernumberlist)
public function integer getlegedidocumentsrequiredforshipperlist (string shipperlist, ref long shipperids[], ref integer documenttypes[])
public function integer getedidocumentsrequiredforshipperlist (string shipperlist, ref long shipperids[], ref integer documenttypes[], ref string functionnames[])
public function integer verifyshipperlistforprinting (string shippernumberlist)
public function integer getshippersrequiringreprint (string shipperlist, ref string shippernumbers[], ref long shipperids[], ref string packlistformats[])
public function integer markpacklistprinted (long shipperid)
public function integer getshipperspackingslips (string shipperlist, ref string shippernumbers[], ref long shipperids[], ref string packlistformats[])
end prototypes

public function integer verifyshipperlistfordeparture (string shippernumberlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to verify shipper list for departure.
declare VerifyShipperListForDeparture procedure for dbo.usp_Shipping_VerifyShipperListForDeparture
	@User = :User
,	@ShipperNumberList = :shipperNumberList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute VerifyShipperListForDeparture  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to verify shipper list for departure:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	VerifyShipperListForDeparture
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to verify shipper list for departure:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close VerifyShipperListForDeparture   ;

//	Return.
return SUCCESS

end function

public function integer beginshipperlistdeparture (string operatorcode, string shippernumberlist, string trucknumber, string pronumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to begin departure for shipper list.
declare BeginShipperListDeparture procedure for dbo.usp_Shipping_BeginShipperListDeparture
	@User = :operatorCode
,	@ShipperNumberList = :shipperNumberList
,	@TruckNumber = :truckNumber
,	@PRONumber = :proNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BeginShipperListDeparture  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to begin departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BeginShipperListDeparture
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to begin departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BeginShipperListDeparture   ;

//	Return.
return SUCCESS

end function

public function integer cancelshipperlistdeparture (string shippernumberlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to cancel departure for shipper list.
declare CancelShipperListDeparture procedure for dbo.usp_Shipping_CancelShipperListDeparture
	@User = :User
,	@ShipperNumberList = :shipperNumberList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CancelShipperListDeparture  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to cancel departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CancelShipperListDeparture
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to cancel departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CancelShipperListDeparture   ;

//	Return.
return SUCCESS

end function

public function integer getasnsrequiredforshipperlist (string shipperlist, ref long shipperids[]);declare ASNsRequired cursor for
select
	sas.LegacyShipperID
from
	dbo.Shipping_ASNShippers sas
where
	sas.IsASNSent = 0
	and sas.ShipperNumber in
		(	select
				ltrim(fsstr.Value)
			from
				dbo.fn_SplitStringToRows(:shipperList, ',') fsstr
		)  ;

open ASNsRequired  ;

int	Values = 0

do while 1 = 1
	long shipperID
	
	fetch
		ASNsRequired
	into
		:shipperID
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	shipperIDs[Values] = shipperID
loop

close ASNsRequired  ;

return SUCCESS

end function

public function integer completeshipperlistdeparture (string shippernumberlist, string pronumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Set the pro-number prior to shipout.
update
	sD
set
	pro_number = :proNumber
from
	dbo.shipper sD
where
	'L' + convert(varchar(49), sD.id) in
		(	select
				ltrim(fsstr.Value)
			from
				dbo.fn_SplitStringToRows(:shipperNumberList, ',') fsstr
		)  ;

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on updating PRO Number, unable to complete departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Attempt to complete departure for shipper list.
declare CompleteShipperListDeparture procedure for dbo.usp_Shipping_CompleteShipperListDeparture
	@User = :User
,	@ShipperNumberList = :shipperNumberList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CompleteShipperListDeparture  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to complete departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CompleteShipperListDeparture
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to complete departure for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CompleteShipperListDeparture   ;

//	Return.
return SUCCESS

end function

public function integer overridescanning (string operatorcode, string shippernumberlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to cancel departure for shipper list.
declare OverrideShipperListScanning procedure for dbo.usp_Shipping_OverrideShipperListScanning
	@User = :operatorCode
,	@ShipperNumberList = :shipperNumberList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute OverrideShipperListScanning  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to override scanning for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	OverrideShipperListScanning
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to override scanning for shipper list:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close OverrideShipperListScanning   ;

//	Return.
return SUCCESS

end function

public function integer getlegedidocumentsrequiredforshipperlist (string shipperlist, ref long shipperids[], ref integer documenttypes[]);declare LegacyEDIDocuments cursor for
select
	sed.LegacyShipperID
,	sed.DocumentType
from
	Shipping_EDIDocuments sed
where
	sed.ShipperNumber in
		(	select
				ltrim(fsstr.Value)
			from
				dbo.fn_SplitStringToRows(:shipperList, ',') fsstr
		) 
	and sed.FileGenerationDT is null
	and sed.LegacyGenerator = 1  ;

open LegacyEDIDocuments  ;

int	Values = 0

do while 1 = 1
	long shipperID
	int documentType
	
	fetch
		LegacyEDIDocuments
	into
		:shipperID
	,	:documentType
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	shipperIDs[Values] = shipperID
	documentTypes[Values] = documentType
loop

close LegacyEDIDocuments  ;

return SUCCESS

end function

public function integer getedidocumentsrequiredforshipperlist (string shipperlist, ref long shipperids[], ref integer documenttypes[], ref string functionnames[]);declare EDIDocuments cursor for
select
	sed.LegacyShipperID
,	sed.DocumentType
,	sed.FunctionName
from
	Shipping_EDIDocuments sed
where
	sed.ShipperNumber in
		(	select
				ltrim(fsstr.Value)
			from
				dbo.fn_SplitStringToRows(:shipperList, ',') fsstr
		) 
	and sed.FileGenerationDT is null
	and sed.LegacyGenerator = 0  ;

open EDIDocuments  ;

int	Values = 0

do while 1 = 1
	long shipperID
	int documentType
	string functionName
	
	fetch
		EDIDocuments
	into
		:shipperID
	,	:documentType
	,	:functionName
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	shipperIDs[Values] = shipperID
	documentTypes[Values] = documentType
	functionNames[Values] = functionName
loop

close EDIDocuments  ;

return SUCCESS

end function

public function integer verifyshipperlistforprinting (string shippernumberlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to verify shipper list for printing.
declare VerifyShipperListForPrinting procedure for dbo.usp_Shipping_VerifyShipperListForPrinting
	@User = :User
,	@ShipperNumberList = :shipperNumberList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute VerifyShipperListForPrinting  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to verify shipper list for printing:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	VerifyShipperListForPrinting
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to verify shipper list for printing:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close VerifyShipperListForPrinting   ;

//	Return.
return SUCCESS

end function

public function integer getshippersrequiringreprint (string shipperlist, ref string shippernumbers[], ref long shipperids[], ref string packlistformats[]);declare ReprintRequired cursor for
select
	sdsl.ShipperNumber
,	sdsl.LegacyShipperID
,	sdsl.PacklistFormat
from
	dbo.Shipping_DepartingShipperList sdsl
where
	sdsl.ShipperNumber in
		(	select
				ltrim(fsstr.Value)
			from
				dbo.fn_SplitStringToRows(:shipperList, ',') fsstr
		)
	and sdsl.RequiresReprint = 1  ;

open ReprintRequired  ;

int	Values = 0

do while 1 = 1
	string shipperNumber
	long shipperID
	string packListFormat
	
	fetch
		ReprintRequired
	into
		:shipperNumber
	,	:shipperID
	,	:packListFormat
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	shipperNumbers[Values] = shipperNumber
	shipperIDs[Values] = shipperID
	packListFormats[Values] = packListFormat
loop

close ReprintRequired  ;

return SUCCESS

end function

public function integer markpacklistprinted (long shipperid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult
string	sqlError

//	Attempt to verify shipper list for departure.
update
	s
set
	printed = 'Y'
from
	dbo.shipper s
where
	s.id = :shipperID  ;

sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on update, unable to set shipper packing list to printed:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer getshipperspackingslips (string shipperlist, ref string shippernumbers[], ref long shipperids[], ref string packlistformats[]);declare ReprintRequired cursor for
select
	sosl.ShipperNumber
,	sosl.LegacyShipperID
,	sosl.PacklistFormat
from
	dbo.Shipping_OpenShipperList sosl
where
	sosl.ShipperNumber in
		(	select
				ltrim(fsstr.Value)
			from
				dbo.fn_SplitStringToRows(:shipperList, ',') fsstr
		)  ;

open ReprintRequired  ;

int	Values = 0

do while 1 = 1
	string shipperNumber
	long shipperID
	string packListFormat
	
	fetch
		ReprintRequired
	into
		:shipperNumber
	,	:shipperID
	,	:packListFormat
	;
	
	if	SQLCA.SQLCode <> 0 then
		exit
	end if
	
	Values++
	shipperNumbers[Values] = shipperNumber
	shipperIDs[Values] = shipperID
	packListFormats[Values] = packListFormat
loop

close ReprintRequired  ;

return SUCCESS

end function

on n_cst_trans_shipping.create
call super::create
end on

on n_cst_trans_shipping.destroy
call super::destroy
end on


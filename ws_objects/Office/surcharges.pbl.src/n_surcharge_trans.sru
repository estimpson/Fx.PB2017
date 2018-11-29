$PBExportHeader$n_surcharge_trans.sru
forward
global type n_surcharge_trans from n_cst_fxtrans
end type
end forward

global type n_surcharge_trans from n_cst_fxtrans
end type
global n_surcharge_trans n_surcharge_trans

forward prototypes
public function integer activatepublisherclasscode (string publisherlist, string classcode, string unit)
public function integer deactivatepublisherclasscode (string publisherlist, string classcode)
public function integer setrate (long rateheaderid, string classcode, decimal rate)
public function integer newrateheader (string publisherlist, string effectivitytype, integer month, integer year, datetime begindt, datetime enddt, string name)
public function integer updaterateheader (long rateheaderid, string effectivitytype, integer month, integer year, datetime begindt, datetime enddt, string name)
public function integer newpartvendorblanketpricesurcharge (string part, string vendor, string publisher, string surchargeclasscode, integer activationtype, integer applicationtype, decimal applicationrate)
public function integer updatepartvendorblanketpricesurcharge (long surchargeid, string publisher, string surchargeclasscode, integer activationtype, integer applicationtype, decimal applicationrate)
public function integer updatepartvendorblanketprice (string part, string vendor, string vendorpart, decimal baseblanketprice, decimal standardpack)
public function integer deletepartvendorblanketprice (string part, string vendor)
public function integer deletepartvendorblanketpricesurcharge (long surchargeid)
public function integer getblanketprice (string part, string vendor, ref decimal blanketprice)
end prototypes

public function integer activatepublisherclasscode (string publisherlist, string classcode, string unit);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to activate publisher class code.
declare ActivatePublisherClassCode procedure for dbo.usp_Surcharge_ActivatePublisherClassCode
	@User = :user
,	@PublisherList = :publisherList
,	@ClassCode = :classCode
,	@Unit = :unit
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ActivatePublisherClassCode  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to activate class codes:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ActivatePublisherClassCode
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to activate class codes:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ActivatePublisherClassCode   ;

//	Return.
return SUCCESS

end function

public function integer deactivatepublisherclasscode (string publisherlist, string classcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to deactivate publisher class code.
declare DeactivatePublisherClassCode procedure for dbo.usp_Surcharge_DeactivatePublisherClassCode
	@User = :user
,	@PublisherList = :publisherList
,	@ClassCode = :classCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeactivatePublisherClassCode  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to deactivate class codes:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeactivatePublisherClassCode
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to deactivate class codes:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeactivatePublisherClassCode   ;

//	Return.
return SUCCESS

end function

public function integer setrate (long rateheaderid, string classcode, decimal rate);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to activate publisher class code.
declare SetRate procedure for dbo.usp_Surcharge_SetRate
	@User = :user
,	@RateHeaderID = :rateHeaderID
,	@ClassCode = :classCode
,	@Rate = :rate
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetRate  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to set rate:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetRate
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to set rate:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetRate   ;

//	Return.
return SUCCESS

end function

public function integer newrateheader (string publisherlist, string effectivitytype, integer month, integer year, datetime begindt, datetime enddt, string name);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to activate publisher class code.
declare NewRateHeader procedure for dbo.usp_Surcharge_NewRateHeader
	@User = :user
,	@PublisherList = :publisherList
,	@EffectivityType = :effectivityType
,	@Month = :month
,	@Year = :year
,	@BeginDT = :beginDT
,	@EndDT = :endDT
,	@Name = :name
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewRateHeader  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to create rate header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewRateHeader
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to create rate header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewRateHeader   ;

//	Return.
return SUCCESS

end function

public function integer updaterateheader (long rateheaderid, string effectivitytype, integer month, integer year, datetime begindt, datetime enddt, string name);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to activate publisher class code.
declare UpdateRateHeader procedure for dbo.usp_Surcharge_UpdateRateHeader
	@User = :user
,	@RateHeaderID = :rateHeaderID
,	@EffectivityType = :effectivityType
,	@Month = :month
,	@Year = :year
,	@BeginDT = :beginDT
,	@EndDT = :endDT
,	@Name = :name
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute UpdateRateHeader  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to update rate header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	UpdateRateHeader
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to update rate header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close UpdateRateHeader   ;

//	Return.
return SUCCESS

end function

public function integer newpartvendorblanketpricesurcharge (string part, string vendor, string publisher, string surchargeclasscode, integer activationtype, integer applicationtype, decimal applicationrate);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create surcharge.
declare NewPartVendorBlanketPriceSurcharge procedure for dbo.usp_Surcharge_NewPartVendorBlanketPriceSurcharge
	@User = :user
,	@Part = :part
,	@Vendor = :vendor
,	@Publisher = :publisher
,	@SurchargeClassCode = :surchargeClassCode
,	@ActivationType = :activationType
,	@ApplicationType = :applicationType
,	@ApplicationRate = :applicationRate
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewPartVendorBlanketPriceSurcharge  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to create surcharge:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewPartVendorBlanketPriceSurcharge
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to create rate header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewPartVendorBlanketPriceSurcharge   ;

//	Return.
return SUCCESS

end function

public function integer updatepartvendorblanketpricesurcharge (long surchargeid, string publisher, string surchargeclasscode, integer activationtype, integer applicationtype, decimal applicationrate);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to udpate surcharge.
declare UpdatePartVendorBlanketPriceSurcharge procedure for dbo.usp_Surcharge_UpdatePartVendorBlanketPriceSurcharge
	@User = :user
,	@SurchargeID = :surchargeID
,	@Publisher = :publisher
,	@SurchargeClassCode = :surchargeClassCode
,	@ActivationType = :activationType
,	@ApplicationType = :applicationType
,	@ApplicationRate = :applicationRate
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute UpdatePartVendorBlanketPriceSurcharge  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to update surcharge:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	UpdatePartVendorBlanketPriceSurcharge
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to update rate header:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close UpdatePartVendorBlanketPriceSurcharge   ;

//	Return.
return SUCCESS

end function

public function integer updatepartvendorblanketprice (string part, string vendor, string vendorpart, decimal baseblanketprice, decimal standardpack);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to update blanket price.
declare UpdatePartVendorBlanketPrice procedure for dbo.usp_Surcharge_UpdatePartVendorBlanketPrice
	@User = :user
,	@Part = :part
,	@Vendor = :vendor
,	@VendorPart = :vendorPart
,	@BaseBlanketPrice = :baseBlanketPrice
,	@StandardPack = :standardPack
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute UpdatePartVendorBlanketPrice  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to update blanket price:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	UpdatePartVendorBlanketPrice
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to update blanket price:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close UpdatePartVendorBlanketPrice   ;

//	Return.
return SUCCESS

end function

public function integer deletepartvendorblanketprice (string part, string vendor);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to delete blanket price.
declare DeletePartVendorBlanketPrice procedure for dbo.usp_Surcharge_DeletePartVendorBlanketPrice
	@User = :user
,	@Part = :part
,	@Vendor = :vendor
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeletePartVendorBlanketPrice  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to delete blanket price:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeletePartVendorBlanketPrice
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to delete blanket price:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeletePartVendorBlanketPrice   ;

//	Return.
return SUCCESS

end function

public function integer deletepartvendorblanketpricesurcharge (long surchargeid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to delete surcharge.
declare DeletePartVendorBlanketPriceSurcharge procedure for dbo.usp_Surcharge_DeletePartVendorBlanketPriceSurcharge
	@User = :user
,	@SurchargeID = :surchargeID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeletePartVendorBlanketPriceSurcharge  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to delete surcharge:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeletePartVendorBlanketPriceSurcharge
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to delete surcharge:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeletePartVendorBlanketPriceSurcharge   ;

//	Return.
return SUCCESS

end function

public function integer getblanketprice (string part, string vendor, ref decimal blanketprice);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to get the blanket price for a part.
declare GetBlanketPrice procedure for dbo.usp_Surcharge_GetBlanketPrice
	@Part = :part
,	@Vendor = :vendor
,	@BlanketPrice = :blanketPrice output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute GetBlanketPrice  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to get blanket price:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	GetBlanketPrice
into
	:blanketPrice
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to get blanket price:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close GetBlanketPrice   ;

//	Return.
return SUCCESS

end function

on n_surcharge_trans.create
call super::create
end on

on n_surcharge_trans.destroy
call super::destroy
end on


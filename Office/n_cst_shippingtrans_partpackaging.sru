HA$PBExportHeader$n_cst_shippingtrans_partpackaging.sru
forward
global type n_cst_shippingtrans_partpackaging from n_cst_fxtrans
end type
end forward

global type n_cst_shippingtrans_partpackaging from n_cst_fxtrans
end type
global n_cst_shippingtrans_partpackaging n_cst_shippingtrans_partpackaging

type variables

public constant long OBJECTSTATUS_IGNORE = -2
public constant long OBJECTSTATUS_LOST = -1
public constant long OBJECTSTATUS_UNKNOWN = 0
public constant long OBJECTSTATUS_FOUND = 1
public constant long OBJECTSTATUS_FOUNDADJ = 2
public constant long OBJECTSTATUS_FOUNDREL = 3
public constant long OBJECTSTATUS_FOUNDADJREL = 4
public constant long OBJECTSTATUS_RECOVER = 5

end variables

forward prototypes
public function integer enablepack (long shipperid, string shipperpart, string packagingcode)
public function integer disablepack (long shipperid, string shipperpart, string packagingcode)
public function integer setdefaultpack (long shipperid, string shipperpart, string packagingcode)
public function integer enablepackwithwarning (long shipperid, string shipperpart, string packagingcode)
public function integer verifypack (long shipperid, string shipperpart, string packagingcode, ref string defaultpackagingcode, ref integer packdisabled, ref integer packenabled, ref integer packwarn)
end prototypes

public function integer enablepack (long shipperid, string shipperpart, string packagingcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare EnablePack procedure for dbo.usp_Shipping_PartPackaging_EnablePack
	@ShipperID = :shipperID
,	@ShipperPart = :shipperPart
,	@PackagingCode = :packagingCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute EnablePack  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to enable package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	EnablePack
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to enable package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close EnablePack   ;

//	Return.
return SUCCESS

end function

public function integer disablepack (long shipperid, string shipperpart, string packagingcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare DisablePack procedure for dbo.usp_Shipping_PartPackaging_DisablePack
	@ShipperID = :shipperID
,	@ShipperPart = :shipperPart
,	@PackagingCode = :packagingCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DisablePack  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to disable package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DisablePack
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to disable package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DisablePack   ;

//	Return.
return SUCCESS

end function

public function integer setdefaultpack (long shipperid, string shipperpart, string packagingcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare SetDefaultPack procedure for dbo.usp_Shipping_PartPackaging_SetDefaultPack
	@ShipperID = :shipperID
,	@ShipperPart = :shipperPart
,	@PackagingCode = :packagingCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetDefaultPack  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set default package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetDefaultPack
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set default package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetDefaultPack   ;

//	Return.
return SUCCESS

end function

public function integer enablepackwithwarning (long shipperid, string shipperpart, string packagingcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare EnablePackWithWarning procedure for dbo.usp_Shipping_PartPackaging_EnablePackWithWarning
	@ShipperID = :shipperID
,	@ShipperPart = :shipperPart
,	@PackagingCode = :packagingCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute EnablePackWithWarning  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to enable package type with warning:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	EnablePackWithWarning
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to enable package type with warning:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close EnablePackWithWarning   ;

//	Return.
return SUCCESS

end function

public function integer verifypack (long shipperid, string shipperpart, string packagingcode, ref string defaultpackagingcode, ref integer packdisabled, ref integer packenabled, ref integer packwarn);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to add object to cycle count.
declare VerifyPack procedure for dbo.usp_Shipping_PartPackaging_VerifyPack
	@ShipperID = :shipperID
,	@ShipperPart = :shipperPart
,	@PackagingCode = :packagingCode
,	@DefaultPackagingCode = :defaultPackagingCode out
,	@PackDisabled = :packDisabled out
,	@PackEnabled = :packEnabled out
,	@PackWarn = :packWarn out
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute VerifyPack  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to verify package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	VerifyPack
into
	:defaultPackagingCode
,	:packDisabled
,	:packEnabled
,	:packWarn
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to verify package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close VerifyPack   ;

//	Return.
return SUCCESS

end function

on n_cst_shippingtrans_partpackaging.create
call super::create
end on

on n_cst_shippingtrans_partpackaging.destroy
call super::destroy
end on


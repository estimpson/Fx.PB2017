$PBExportHeader$n_cst_purchasingtrans.sru
forward
global type n_cst_purchasingtrans from n_cst_fxtrans
end type
end forward

global type n_cst_purchasingtrans from n_cst_fxtrans
end type
global n_cst_purchasingtrans n_cst_purchasingtrans

forward prototypes
public function integer changepovendor (long _purchaseordernumber, string _newvendorcode)
public function integer changeposhipto (long _purchaseordernumber, string _newshiptodestination)
end prototypes

public function integer changepovendor (long _purchaseordernumber, string _newvendorcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to change po vendor.
declare ChangePOVendor procedure for dbo.usp_Purchasing_ChangePOVendor
	@PONumber = :_purchaseOrderNumber
,	@NewVendorCode = :_newVendorCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ChangePOVendor  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change po vendor:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ChangePOVendor
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change po vendor:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ChangePOVendor  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer changeposhipto (long _purchaseordernumber, string _newshiptodestination);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to change po ship to.
declare ChangePOShipTo procedure for dbo.usp_Purchasing_ChangePOShipTo
	@PONumber = :_purchaseOrderNumber
,	@NewShipToDestination = :_newShipToDestination
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ChangePOShipTo  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change po ship to:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ChangePOShipTo
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change po ship to:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ChangePOShipTo  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_purchasingtrans.create
call super::create
end on

on n_cst_purchasingtrans.destroy
call super::destroy
end on


$PBExportHeader$n_purchasing_trans.sru
forward
global type n_purchasing_trans from n_cst_fxtrans
end type
end forward

global type n_purchasing_trans from n_cst_fxtrans
end type
global n_purchasing_trans n_purchasing_trans

forward prototypes
public function integer func1 ()
public function integer func2 (long someValue)
public function integer closepolist (string polist, ref long deletedreleasecount)
public function integer cleanpolist (string polist, ref long deletedreleasecount)
public function integer deletepolist (string polist, ref long deletedreleasecount, ref long deletedpocount)
public function integer getpotype (long ponumber, ref string potype)
end prototypes

public function integer func1 ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare Proc1 procedure for dbo.usp_Purchasing_Proc1
	@Operator = :user
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute Proc1  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to proc1:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	Proc1
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to proc1:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close Proc1   ;

//	Return.
return SUCCESS

end function

public function integer func2 (long someValue);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare Proc2 procedure for dbo.usp_Purchasing_Proc2
	@Operator = :user
,	@SomeValue = :someValue
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute Proc2  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to proc2:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	Proc2
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to proc2:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close Proc2   ;

//	Return.
return SUCCESS

end function

public function integer closepolist (string polist, ref long deletedreleasecount);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch close open releases.
declare ClosePOList procedure for dbo.usp_Purchasing_ClosePOList
	@User = :user
,	@POList = :poList
,	@DeletedReleaseCount = :deletedReleaseCount output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ClosePOList  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to close open releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ClosePOList
into
	:deletedReleaseCount
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to close open releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ClosePOList   ;

//	Return.
return SUCCESS

end function

public function integer cleanpolist (string polist, ref long deletedreleasecount);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch close received releases.
declare CleanPOList procedure for dbo.usp_Purchasing_CleanPOList
	@User = :user
,	@POList = :poList
,	@DeletedReleaseCount = :deletedReleaseCount output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CleanPOList  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to close received releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CleanPOList
into
	:deletedReleaseCount
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to close received releases:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CleanPOList   ;

//	Return.
return SUCCESS

end function

public function integer deletepolist (string polist, ref long deletedreleasecount, ref long deletedpocount);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch delete POs.
declare DeletePOList procedure for dbo.usp_Purchasing_DeletePOList
	@User = :user
,	@POList = :poList
,	@DeletedReleaseCount = :deletedReleaseCount output
,	@DeletedPOCount = :deletedPOCount output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeletePOList  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to delete POs:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeletePOList
into
	:deletedReleaseCount
,	:deletedPOCount
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to delete POs:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeletePOList   ;

//	Return.
return SUCCESS

end function

public function integer getpotype (long ponumber, ref string potype);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to get PO Type.
select
	ppol.type
into
	:poType
from
	dbo.Purchasing_PurchaseOrderList ppol
where
	ppol.InternalPONumber = :poNumber  ;

sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to read PO type for PO " + isnull(string(poNumber),"[NULL]") + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

on n_purchasing_trans.create
call super::create
end on

on n_purchasing_trans.destroy
call super::destroy
end on


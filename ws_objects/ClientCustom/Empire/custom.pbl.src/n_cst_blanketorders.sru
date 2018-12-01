$PBExportHeader$n_cst_blanketorders.sru
forward
global type n_cst_blanketorders from n_base
end type
end forward

global type n_cst_blanketorders from n_base autoinstantiate
end type

forward prototypes
public function integer setactiveorder (string _destination, string _customerpart, long _orderno, ref long _procresult)
public function integer copyeeareleasestoeeh (ref long _procreturn)
end prototypes

public function integer setactiveorder (string _destination, string _customerpart, long _orderno, ref long _procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to set active order.
declare	SetActiveOrder procedure for FT.ftsp_BOInquiry_SetActiveOrder
	@DestinationCode = :_destination
,	@CustomerPart = :_customerPart
,	@NewActiveOrder = :_orderNo
,	@Result = :_procResult out using SQLCA  ;

execute SetActiveOrder  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set active order:  {" + String(sqlResult) + "," + String(_procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	SetActiveOrder
into	:_procResult  ;

if	_procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set active order:  {" + String(sqlResult) + "," + String(_procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SetActiveOrder  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer copyeeareleasestoeeh (ref long _procreturn);
//	Read the parameters.
string	sqlError

//	Attempt to create delete normal order.
declare	CopyReleases procedure for dbo.ftsp_CopyEEAReleasesToEEH using SQLCA  ;

execute CopyReleases  ;
_procReturn = SQLCA.SQLCode

if	_procReturn <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to copy releases:  {" + String(_procReturn) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CopyReleases  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_blanketorders.create
call super::create
end on

on n_cst_blanketorders.destroy
call super::destroy
end on


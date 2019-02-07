$PBExportHeader$n_shipping_trans.sru
forward
global type n_shipping_trans from n_cst_fxtrans
end type
end forward

global type n_shipping_trans from n_cst_fxtrans
end type
global n_shipping_trans n_shipping_trans

forward prototypes
public function integer func1 ()
public function integer func2 ()
end prototypes

public function integer func1 ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare Proc1 procedure for dbo.usp_Shipping_Proc1
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

public function integer func2 ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare Proc2 procedure for dbo.usp_Shipping_Proc2
	@Operator = :user
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

on n_shipping_trans.create
call super::create
end on

on n_shipping_trans.destroy
call super::destroy
end on


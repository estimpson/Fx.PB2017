$PBExportHeader$n_purchmst_trans.sru
forward
global type n_purchmst_trans from n_cst_fxtrans
end type
end forward

global type n_purchmst_trans from n_cst_fxtrans
end type
global n_purchmst_trans n_purchmst_trans

forward prototypes
public function integer func1 ()
public function integer setlistedordersasdefault (string orderlist)
end prototypes

public function integer func1 ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare Proc1 procedure for dbo.usp_PurchMaster_Proc1
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

public function integer setlistedordersasdefault (string orderlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare SetListedOrdersAsDefault procedure for dbo.usp_PurchasingMaster_SetListedOrdersAsDefault
	@User = :user
,	@OrderList = :orderList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetListedOrdersAsDefault  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to set listed orders as default:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetListedOrdersAsDefault
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to set listed orders as default:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetListedOrdersAsDefault   ;

//	Return.
return SUCCESS

end function

on n_purchmst_trans.create
call super::create
end on

on n_purchmst_trans.destroy
call super::destroy
end on


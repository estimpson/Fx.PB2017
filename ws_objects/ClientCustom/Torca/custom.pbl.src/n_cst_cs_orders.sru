$PBExportHeader$n_cst_cs_orders.sru
forward
global type n_cst_cs_orders from n_cst_fxtrans
end type
end forward

global type n_cst_cs_orders from n_cst_fxtrans
end type
global n_cst_cs_orders n_cst_cs_orders

forward prototypes
public function integer approveorder (long orderno)
end prototypes

public function integer approveorder (long orderno);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to approve sales order.
declare ApproveOrder procedure for dbo.usp_CS_ApproveOrder
	@Operator = :User
,	@OrderNo = :orderNo
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ApproveOrder  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to approve sales order:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ApproveOrder
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to approve sales order:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ApproveOrder  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_cs_orders.create
call super::create
end on

on n_cst_cs_orders.destroy
call super::destroy
end on


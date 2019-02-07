HA$PBExportHeader$n_mrp_trans.sru
forward
global type n_mrp_trans from n_cst_fxtrans
end type
end forward

global type n_mrp_trans from n_cst_fxtrans
end type
global n_mrp_trans n_mrp_trans

forward prototypes
public function integer calculateplanningpurchaseorders ()
public function integer replacefirmposchedule (long ponumber)
public function integer getpoblanketpart (long ponumber, ref string blanketpart)
end prototypes

public function integer calculateplanningpurchaseorders ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to calculate planning purchase orders.
declare CalculatePlanningPurchaseOrders procedure for dbo.usp_MRP_CalculatePlanningPurchaseOrders
	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CalculatePlanningPurchaseOrders  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to calculate planning purchase orders:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CalculatePlanningPurchaseOrders
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to calculate planning purchase orders:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CalculatePlanningPurchaseOrders   ;

//	Return.
return SUCCESS

end function

public function integer replacefirmposchedule (long ponumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to replace firm PO schedule.
declare ReplaceFirmPOSchedule procedure for dbo.usp_MRP_ReplaceFirmPOSchedule
	@PONumber = :poNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ReplaceFirmPOSchedule  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to replace firm PO schedule:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ReplaceFirmPOSchedule
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to replace firm PO schedule:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ReplaceFirmPOSchedule   ;

//	Return.
return SUCCESS

end function

public function integer getpoblanketpart (long ponumber, ref string blanketpart);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult
string	sqlError

//	Attempt to replace firm PO schedule.
select
	ph.blanket_part
into
	:blanketPart
from
	dbo.po_header ph
where
	ph.po_number = :poNumber  ;

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on select, unable to get blanket part for PO:  {" + String(sqlResult) + "," + String(poNumber) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

on n_mrp_trans.create
call super::create
end on

on n_mrp_trans.destroy
call super::destroy
end on


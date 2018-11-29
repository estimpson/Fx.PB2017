$PBExportHeader$n_inventory_trans.sru
forward
global type n_inventory_trans from n_cst_fxtrans
end type
end forward

global type n_inventory_trans from n_cst_fxtrans
end type
global n_inventory_trans n_inventory_trans

forward prototypes
public function string getuser ()
public function integer transferobjects (string objectlist, integer superobjectflag, string location, long palletserial)
public function integer combineobjects (string objectlist, ref long combineserial)
public function integer breakoutobjects (string objectlist, decimal qtyperobject, string unit, long objectcount, ref long firstnewserial, ref integer originaldeleted)
public function integer breakoutobjects (long fromserial, decimal qtyperobject, string unit, string packagetype, long objectcount, ref long firstnewserial, ref integer originaldeleted)
end prototypes

public function string getuser ();
//	Return.
return User

end function

public function integer transferobjects (string objectlist, integer superobjectflag, string location, long palletserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare TransferObjects procedure for dbo.usp_InventoryControl_TransferObjects
	@Operator = :user
,	@ObjectList = :objectList
,	@SuperObjectFlag = :superObjectFlag
,	@Location = :location
,	@PalletSerial = :palletSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute TransferObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to transfer objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	TransferObjects
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to transfer objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close TransferObjects   ;

//	Return.
return SUCCESS

end function

public function integer combineobjects (string objectlist, ref long combineserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare CombineObjects procedure for dbo.usp_InventoryControl_CombineObjects
	@Operator = :user
,	@ObjectList = :objectList
,	@CombineSerial = :combineSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CombineObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to combine objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CombineObjects
into
	:combineSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to combine objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CombineObjects   ;

//	Return.
return SUCCESS

end function

public function integer breakoutobjects (string objectlist, decimal qtyperobject, string unit, long objectcount, ref long firstnewserial, ref integer originaldeleted);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare BreakoutObjects procedure for dbo.usp_InventoryControl_BreakoutObjects
	@Operator = :user
,	@ObjectList = :objectList
,	@QtyPerObject = :qtyPerObject
,	@Unit = :unit
,	@ObjectCount = :objectCount
,	@FirstNewSerial = :firstNewSerial output
,	@OriginalDeleted = :originalDeleted output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BreakoutObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to breakout objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BreakoutObjects
into
	:firstNewSerial
,	:originalDeleted
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to breakout objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BreakoutObjects   ;

//	Return.
return SUCCESS

end function

public function integer breakoutobjects (long fromserial, decimal qtyperobject, string unit, string packagetype, long objectcount, ref long firstnewserial, ref integer originaldeleted);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare BreakoutObjects procedure for dbo.usp_InventoryControl_BreakoutObjects
	@Operator = :user
,	@Serial = :fromSerial
,	@QtyPerObject = :qtyPerObject
,	@Unit = :unit
,	@PackageType = :packageType
,	@ObjectCount = :objectCount
,	@FirstNewSerial = :firstNewSerial output
,	@OriginalDeleted = :originalDeleted output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BreakoutObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to breakout objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BreakoutObjects
into
	:firstNewSerial
,	:originalDeleted
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to breakout objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BreakoutObjects   ;

//	Return.
return SUCCESS

end function

on n_inventory_trans.create
call super::create
end on

on n_inventory_trans.destroy
call super::destroy
end on


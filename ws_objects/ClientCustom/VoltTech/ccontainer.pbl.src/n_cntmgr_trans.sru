$PBExportHeader$n_cntmgr_trans.sru
forward
global type n_cntmgr_trans from n_cst_fxtrans
end type
end forward

global type n_cntmgr_trans from n_cst_fxtrans
end type
global n_cntmgr_trans n_cntmgr_trans

forward prototypes
public function integer func1 ()
public function integer func2 ()
public function integer createcontainershipper (string deliverynumber, ref long newshipperid)
public function integer serialisstaged (long serial, ref boolean isstaged, ref long stagedshipper)
public function integer stageserial (long serial, string deliverynumber)
public function integer unstageserial (long serial, string deliverynumber)
public function integer getdeliveryshippernumber (string deliverynumber, ref long shippernumber)
public function integer setcontainermanifestprinted (long shippernumber)
public function integer shipout (string deliverynumber, string aetcnumber, string pronumber, string trucknumber, string sealnumber)
end prototypes

public function integer func1 ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare Proc1 procedure for dbo.usp_CNTMGR_Proc1
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
declare Proc2 procedure for dbo.usp_CNTMGR_Proc2
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

public function integer createcontainershipper (string deliverynumber, ref long newshipperid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare CreateContainerShipper procedure for dbo.usp_Shipping_Cntmgr_CreateContainerShipper
	@User = :user
,	@DeliveryNumber = :deliveryNumber
,	@NewShipperID = :newShipperID output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CreateContainerShipper  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to create container shipper:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CreateContainerShipper
into
	:newShipperID
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to create container shipper:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close CreateContainerShipper   ;

//	Return.
return SUCCESS

end function

public function integer serialisstaged (long serial, ref boolean isstaged, ref long stagedshipper);
//	Read the parameters.
long	sqlResult
string	sqlError

int isStagedValue

select
	IsStaged = case when coalesce(o.shipper, -1) <= 0 then 0 else 1 end
,	Shipper = o.shipper
into
	:isStagedValue
,	:stagedShipper
from
	dbo.object o
where
	o.serial = :serial using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get staging information for serial " + String(serial) + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

isStaged = (isStagedValue = 1)

//	Return.
return SUCCESS

end function

public function integer stageserial (long serial, string deliverynumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare StageSerial procedure for dbo.usp_Shipping_Cntmgr_StageSerial
	@User = :user
,	@Serial = :serial
,	@DeliveryNumber = :deliveryNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute StageSerial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to stage serial to container:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	StageSerial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to stage serial to container:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close StageSerial   ;

//	Return.
return SUCCESS

end function

public function integer unstageserial (long serial, string deliverynumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare UnstageSerial procedure for dbo.usp_Shipping_Cntmgr_UnstageSerial
	@User = :user
,	@Serial = :serial
,	@DeliveryNumber = :deliveryNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute UnstageSerial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to unstage serial from container:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	UnstageSerial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to unstage serial from container:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close UnstageSerial   ;

//	Return.
return SUCCESS

end function

public function integer getdeliveryshippernumber (string deliverynumber, ref long shippernumber);
//	Read the parameters.
long	sqlResult
string	sqlError

select
	tad.ShipperID
into
	:shipperNumber
from
	dbo.Trans_ActiveDeliveries tad
where
	tad.DeliveryNumber = :deliveryNumber using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get delivery shipper number for deliver number " + deliveryNumber + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer setcontainermanifestprinted (long shippernumber);
//	Read the parameters.
long	sqlResult
string	sqlError

update
	s
set	printed = 'Y'
from
	dbo.shipper s
where
	s.id = :shipperNumber using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set packing list printed for shipper " + string (shipperNumber) + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer shipout (string deliverynumber, string aetcnumber, string pronumber, string trucknumber, string sealnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare Shipout procedure for dbo.usp_Shipping_Cntmgr_Shipout
	@User = :user
,	@DeliveryNumber = :deliveryNumber
,	@AETCNumber = :aetcNumber
,	@ProNumber = :proNumber
,	@TruckNumber = :truckNumber
,	@SealNumber = :sealNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute Shipout  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to depart container shipper:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	Shipout
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to depart container shipper:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close Shipout   ;

//	Return.
return SUCCESS

end function

on n_cntmgr_trans.create
call super::create
end on

on n_cntmgr_trans.destroy
call super::destroy
end on


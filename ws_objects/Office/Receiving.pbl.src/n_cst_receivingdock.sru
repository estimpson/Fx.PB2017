$PBExportHeader$n_cst_receivingdock.sru
forward
global type n_cst_receivingdock from n_cst_fxtrans
end type
end forward

global type n_cst_receivingdock from n_cst_fxtrans
end type
global n_cst_receivingdock n_cst_receivingdock

type variables

constant int RECEIVER_NEW = 0, RECEIVER_CONFIRMED = 1, RECEIVER_SHIPPED = 2, RECEIVER_ARRIVED = 3, RECEIVER_RECEIVED = 4, RECEIVER_PUTAWAY = 5, RECEIVER_ARCHIVED = 6

end variables

forward prototypes
public function integer getboxlabelparms_forreceiverobject (long receiverobjectid, ref long boxserialnumber, ref string boxlabelformat)
public function integer receiveobject_againstreceiverobject (long receiverobjectid, long procresult, boolean commitnow)
public function integer deletereceiverline (long receiverlineid, ref long procresult)
public function integer changepackagetype_ofreceiverline (long receiverlineid, string packagetype, ref long procresult)
public function integer createreceiverlines (long _receiverid, ref long procresult)
public function integer setremainingqty_ofreceiverlines (long receiverlineid, decimal stdpackqty, decimal remainingqty, ref long procresult)
public function integer undoreceiveobject_againstreceiverobject (long receiverobjectid, long procresult, boolean commitnow)
public function integer putawayreceiver (long _receiverid, ref long procresult)
public function integer archivereceiver (long _receiverid, ref long procresult)
end prototypes

public function integer getboxlabelparms_forreceiverobject (long receiverobjectid, ref long boxserialnumber, ref string boxlabelformat);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Read serial number and box label format.
select
	boxSerialNumber = at.serial,
	boxLabelFormat = case when p.type != 'N' then pi.label_format end
into
	:boxSerialNumber,
	:boxLabelFormat
from
	dbo.ReceiverObjects ro
	join dbo.audit_trail at on
		ro.Serial = at.serial
		and at.type in ('R', 'U')
		and at.date_stamp =
				(	select
						max(date_stamp)
					from
						audit_trail
					where
						serial = ro.serial
						and
							type in ('R', 'U')
				)
	join dbo.part p on at.part = p.part
	join dbo.part_inventory pi on at.part = pi.part
where
	ro.ReceiverObjectID = :receiverObjectID  ;

if	SQLCA.SQLCode <> 0 then
	sqlResult = SQLCA.SQLCode
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer receiveobject_againstreceiverobject (long receiverobjectid, long procresult, boolean commitnow);
///refactor to bll
//	Read the parameters.
long	sqlResult
string	sqlError

datetime tranDT; SetNull(tranDT)
declare	ReceiveObject_againstReceiverObject procedure for dbo.usp_ReceivingDock_ReceiveObject_againstReceiverObject
	@User = :User,
	@ReceiverObjectID = :receiverObjectID,
	@TranDT = :tranDT output,
	@Result =:procResult output using SQLCA  ;

execute ReceiveObject_againstReceiverObject  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to receive box:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch	ReceiveObject_againstReceiverObject
into	:tranDT,
	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to receive box:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ReceiveObject_againstReceiverObject  ;
if	commitNow then SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer deletereceiverline (long receiverlineid, ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare	DeleteReceiverLine procedure for dbo.usp_ReceivingDock_DeleteReceiverLine
	@ReceiverLineID = :receiverLineID,
	@Result =:procResult output using SQLCA  ;

execute DeleteReceiverLine  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to delete receiver line:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	DeleteReceiverLine
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to delete receiver line:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close DeleteReceiverLine  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer changepackagetype_ofreceiverline (long receiverlineid, string packagetype, ref long procresult);
///refactor to bll
long	sqlResult
string	sqlError

declare	ChangePackageType_ofReceiverLine procedure for dbo.usp_ReceivingDock_ChangePackageType_ofReceiverLine
	@ReceiverLineID = :receiverLineID,
	@PackageType = :packageType,
	@Result =:procResult output using SQLCA  ;

execute ChangePackageType_ofReceiverLine  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change receiver line package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch	ChangePackageType_ofReceiverLine
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change receiver line package type:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

close ChangePackageType_ofReceiverLine  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer createreceiverlines (long _receiverid, ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare	CreateReceiverLines procedure for dbo.usp_ReceivingDock_CreateReceiverLines_fromReceiverHeader
	@ReceiverID = :_receiverID,
	@Result =:procResult output using SQLCA  ;

execute CreateReceiverLines  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create receiver lines:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	CreateReceiverLines
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create receiver lines:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CreateReceiverLines  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer setremainingqty_ofreceiverlines (long receiverlineid, decimal stdpackqty, decimal remainingqty, ref long procresult);
///refactor to bll
long	sqlResult
string	sqlError

declare	SetRemainingQty_ofReceiverLines procedure for dbo.usp_ReceivingDock_SetRemainingQty_ofReceiverLines
	@ReceiverLineID = :receiverLineID,
	@StdPackQty = :stdPackQty,
	@RemainingQty = :remainingQty,
	@Result =:procResult output using SQLCA  ;

execute SetRemainingQty_ofReceiverLines  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set receiver line remaining qty:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch	SetRemainingQty_ofReceiverLines
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set receiver line remaining qty:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

close SetRemainingQty_ofReceiverLines  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer undoreceiveobject_againstreceiverobject (long receiverobjectid, long procresult, boolean commitnow);
///refactor to bll
//	Read the parameters.
long	sqlResult
string	sqlError

datetime tranDT; SetNull(tranDT)
declare	UndoReceiveObject_againstReceiverObject procedure for dbo.usp_ReceivingDock_UndoReceiveObject_againstReceiverObject
	@User = :User,
	@ReceiverObjectID = :receiverObjectID,
	@TranDT = :tranDT output,
	@Result =:procResult output using SQLCA  ;

execute UndoReceiveObject_againstReceiverObject  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to undo receipt of box:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch	UndoReceiveObject_againstReceiverObject
into	:tranDT,
	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to undo receipt of box:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close UndoReceiveObject_againstReceiverObject  ;
if	commitNow then SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer putawayreceiver (long _receiverid, ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare	PutAwayReceiver procedure for dbo.usp_ReceivingDock_PutAwayReceiver
	@ReceiverID = :_receiverID,
	@Result =:procResult output using SQLCA  ;

execute PutAwayReceiver  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to put away receiver:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	PutAwayReceiver
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to put away receiver:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close PutAwayReceiver  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

public function integer archivereceiver (long _receiverid, ref long procresult);
//	Read the parameters.
long	sqlResult
string	sqlError

//	Attempt to create delete normal order.
declare	ArchiveReceiver procedure for dbo.usp_ReceivingDock_ArchiveReceiver
	@ReceiverID = :_receiverID,
	@Result =:procResult output using SQLCA  ;

execute ArchiveReceiver  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to archive receiver:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch	ArchiveReceiver
into	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to archive receiver:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ArchiveReceiver  ;
SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_receivingdock.create
call super::create
end on

on n_cst_receivingdock.destroy
call super::destroy
end on


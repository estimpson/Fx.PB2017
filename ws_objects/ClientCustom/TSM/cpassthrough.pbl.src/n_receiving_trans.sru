$PBExportHeader$n_receiving_trans.sru
forward
global type n_receiving_trans from n_cst_fxtrans
end type
end forward

global type n_receiving_trans from n_cst_fxtrans
end type
global n_receiving_trans n_receiving_trans

forward prototypes
public function integer newpreobjects (long wodid, integer boxes, ref long firstnewserial)
public function integer closepreobject (long preobjectserial)
public function integer openpreobject (long preobjectserial)
end prototypes

public function integer newpreobjects (long wodid, integer boxes, ref long firstnewserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch NewPreObjects.
declare NewPreObjects procedure for custom.usp_Receiving_PassThrough_NewPreObjects
	@User = :user
,	@WODID = :wodid
,	@Boxes = :boxes
,	@FirstNewSerial = :firstNewSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewPreObjects  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to create new pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewPreObjects
into
	:firstNewSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to create new pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewPreObjects   ;

//	Return.
return SUCCESS

end function

public function integer closepreobject (long preobjectserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to close pre-object.
declare ClosePreObject procedure for custom.usp_Receiving_PassThrough_ClosePreObject
	@User = :User
,	@PreObjectSerial = :preObjectSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ClosePreObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to close pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ClosePreObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to close pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ClosePreObject  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer openpreobject (long preobjectserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to open pre-object.
declare OpenPreObject procedure for custom.usp_Receiving_PassThrough_OpenPreObject
	@User = :User
,	@PreObjectSerial = :preObjectSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute OpenPreObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to open pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	OpenPreObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to open pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close OpenPreObject  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

on n_receiving_trans.create
call super::create
end on

on n_receiving_trans.destroy
call super::destroy
end on


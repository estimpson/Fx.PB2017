$PBExportHeader$n_cst_mes_inventorytrans.sru
forward
global type n_cst_mes_inventorytrans from n_cst_fxtrans
end type
end forward

global type n_cst_mes_inventorytrans from n_cst_fxtrans
end type
global n_cst_mes_inventorytrans n_cst_mes_inventorytrans

forward prototypes
public function integer correctpreobject (long jobid, decimal qtybox, string packagecode, string lotnumber, ref long correctionserial)
public function integer newpreobjects (long jobid, decimal qtytolabel, decimal standardpack, string packagecode, string lotnumber, ref long firstnewserial, ref integer boxes)
public function integer setsubstitutematerial (long jobbomid, string substitutepartcode, decimal substitutionrate)
public function integer cancelpreobject (ref long preobjectserial)
public function integer closepreobject (ref long preobjectserial)
public function integer openpreobject (ref long preobjectserial)
public function integer schedulemanualjob (ref string manualworkordernumber, string partcode, string billtocode, string machinecode, decimal buildqty, datetime duedt)
public function integer resetjobbom (long jobid)
public function integer closejob (long jobid)
public function integer newplanning ()
public function integer movejob (long jobid, string newmachinecode)
public function integer createpallets (long jobid, string palletpackagetype, integer palletcount, ref long firstpalletserial)
public function integer schedulemanualjob (ref string manualworkordernumber, string partcode, long salesorderno, string machinecode, decimal buildqty, datetime duedt)
public function integer schedulemanualjob (ref long newWODID, string partcode, long salesorderno, string machinecode, decimal buildqty, datetime duedt)
public function integer schedulemanualjob (ref long newWODID, string partcode, string billToCode, string machinecode, decimal buildqty, datetime duedt)
end prototypes

public function integer correctpreobject (long jobid, decimal qtybox, string packagecode, string lotnumber, ref long correctionserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to correct pre-object.
declare CorrectPreObject procedure for dbo.usp_MES_CorrectPreObject
	@Operator = :User
,	@WODID = :jobID
,	@QtyBox = :qtyBox
,	@PackageCode = :packageCode
,	@LotNumber = :lotNumber
,	@CorrectionSerial = :correctionSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CorrectPreObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to correct pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CorrectPreObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to correct pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CorrectPreObject  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer newpreobjects (long jobid, decimal qtytolabel, decimal standardpack, string packagecode, string lotnumber, ref long firstnewserial, ref integer boxes);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create pre-object.
declare NewPreObject procedure for dbo.usp_MES_NewPreObject
	@Operator = :User
,	@WODID = :jobID
,	@QtyToLabel = :qtyToLabel
,	@QtyBox = :standardPack
,	@PackageCode = :packageCode
,	@LotNumber = :lotNumber
,	@FirstNewSerial = :firstNewSerial output
,	@Boxes = :boxes output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewPreObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewPreObject
into
	:firstNewSerial
,	:boxes
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close NewPreObject  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer setsubstitutematerial (long jobbomid, string substitutepartcode, decimal substitutionrate);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create/edit/remove material substitution.
declare SetSubstituteMaterial procedure for dbo.usp_MES_SetSubstituteMaterial
	@Operator = :User
,	@PrimaryBOMID = :jobBOMID
,	@SubstitutePart = :substitutePartCode
,	@SubstitutionRate = :substitutionRate
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetSubstituteMaterial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set substitute material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetSubstituteMaterial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set substitute material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SetSubstituteMaterial  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer cancelpreobject (ref long preobjectserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to cancel pre-object.
declare CancelPreObject procedure for dbo.usp_MES_CancelPreObject
	@Operator = :User
,	@PreObjectSerial = :preObjectSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CancelPreObject  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to cancel pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CancelPreObject
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to cancel pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CancelPreObject  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer closepreobject (ref long preobjectserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to close pre-object.
declare ClosePreObject procedure for dbo.usp_MES_ClosePreObject
	@Operator = :User
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

public function integer openpreobject (ref long preobjectserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to open pre-object.
declare OpenPreObject procedure for dbo.usp_MES_OpenPreObject
	@Operator = :User
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

public function integer schedulemanualjob (ref string manualworkordernumber, string partcode, string billtocode, string machinecode, decimal buildqty, datetime duedt);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to schedule manual job.
declare ScheduleManualJob procedure for dbo.usp_MES_ScheduleManualJob
	@Operator = :User
,	@ManualWorkOrderNumber = :manualWorkOrderNumber output
,	@PartCode = :partCode
,	@MachineCode = :machineCode
,	@BillToCode = :billToCode
,	@BuildQty = :buildQty
,	@DueDT = :dueDT
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ScheduleManualJob  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to schedule manual job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ScheduleManualJob
into
	:manualWorkOrderNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to cancel pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ScheduleManualJob  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer resetjobbom (long jobid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to reset job BOM.
declare ResetJobBOM procedure for dbo.usp_MES_ResetJobBOM
	@JobID = :jobID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ResetJobBOM  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to reset job BOM:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ResetJobBOM
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to reset job BOM:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ResetJobBOM  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer closejob (long jobid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to close job.
declare CloseJob procedure for dbo.usp_MES_CloseJob
	@JobID = :jobID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CloseJob  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to close job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CloseJob
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to close job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CloseJob  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer newplanning ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

datetime horizonEndDT
horizonEndDT = datetime(relativedate(today(), 42))

//	Attempt to schedule planning jobs.
declare SchedulePlanningJobs procedure for dbo.usp_MES_SchedulePlanningJobs
	@HorizonEndDT = :horizonEndDT
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SchedulePlanningJobs  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to schedule planning jobs:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SchedulePlanningJobs
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to schedule planning jobs:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SchedulePlanningJobs  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer movejob (long jobid, string newmachinecode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to move job.
declare MoveJob procedure for dbo.usp_MES_MoveJob
	@JobID = :jobID
,	@NewMachineCode = :newMachineCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute MoveJob  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to move job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	MoveJob
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to move job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close MoveJob  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer createpallets (long jobid, string palletpackagetype, integer palletcount, ref long firstpalletserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create pallets.
declare CreatePallets procedure for dbo.usp_MES_CreatePallets
	@User = :User
,	@JobID = :jobID
,	@PalletPackageType = :palletPackageType
,	@PalletCount = :palletCount
,	@FirstPalletSerial = :firstPalletSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CreatePallets  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create pallets:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CreatePallets
into
	:firstPalletSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create pallets:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CreatePallets  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer schedulemanualjob (ref string manualworkordernumber, string partcode, long salesorderno, string machinecode, decimal buildqty, datetime duedt);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to schedule manual job.
declare ScheduleManualJob procedure for dbo.usp_MES_ScheduleManualJob
	@Operator = :User
,	@ManualWorkOrderNumber = :manualWorkOrderNumber output
,	@PartCode = :partCode
,	@MachineCode = :machineCode
,	@SalesOrderNo = :salesOrderNo
,	@BuildQty = :buildQty
,	@DueDT = :dueDT
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ScheduleManualJob  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to schedule manual job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ScheduleManualJob
into
	:manualWorkOrderNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to cancel pre-objects:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ScheduleManualJob  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer schedulemanualjob (ref long newWODID, string partcode, long salesorderno, string machinecode, decimal buildqty, datetime duedt);

string newWorkOrderNumber

long returnValue
returnValue = ScheduleManualJob (newWorkOrderNumber, partCode, salesorderno, machineCode, buildQty, dueDT)

if	returnValue = SUCCESS then
	select
		mjl.WODID
	into
		:newWODID
	from
		dbo.MES_JobList mjl
	where
		mjl.WorkOrderNumber = :newWorkOrderNumber  ;
end if

return returnValue

end function

public function integer schedulemanualjob (ref long newWODID, string partcode, string billToCode, string machinecode, decimal buildqty, datetime duedt);

string newWorkOrderNumber

long returnValue
returnValue = ScheduleManualJob (newWorkOrderNumber, partCode, billToCode, machineCode, buildQty, dueDT)

if	returnValue = SUCCESS then
	select
		mjl.WODID
	into
		:newWODID
	from
		dbo.MES_JobList mjl
	where
		mjl.WorkOrderNumber = :newWorkOrderNumber  ;
end if

return returnValue

end function

on n_cst_mes_inventorytrans.create
call super::create
end on

on n_cst_mes_inventorytrans.destroy
call super::destroy
end on


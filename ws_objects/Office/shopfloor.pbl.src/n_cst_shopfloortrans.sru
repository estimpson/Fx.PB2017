$PBExportHeader$n_cst_shopfloortrans.sru
forward
global type n_cst_shopfloortrans from n_cst_fxtrans
end type
end forward

global type n_cst_shopfloortrans from n_cst_fxtrans
end type

forward prototypes
public function integer machinewochange (long _workorder, ref integer _action)
public function integer combinejobcomplete (long _looseserial, string _part, long _workorder, string _packagetype, double _qty, string _unit, string _userstatus, string _machine, string _nextlocation, long _issuewo, long _salesorder, string _destination, string _customer, ref long _serial, ref long _actiontaken)
public function integer createsubstitutematerial (long _primaryrowid, string _substitutepart, decimal _substitutionrate)
public function integer removematerial (long _removalrowid)
public function integer restorematerial (long _restorerowid)
public function integer setmanualmaterial (long _manualrowid)
public function integer startjobsetup (string _workordernumber, long _workorderdetailsequence)
public function integer setjobtool (string _toolsetter, string _workordernumber, long _workorderdetailsequence, string _toolcode, string _toolingnote)
public function long serialfromlot (string _lot)
public function integer allocateserial (long _serial, string _workordernumber, long _workorderdetailsequence, long _suffix, decimal _qtybreakout, ref long _breakoutserial)
public function integer endserialallocation (long _serial, string _workordernumber, long _workorderdetailsequence, long _suffix, boolean _isempty, decimal _qtyremaining, string _changereason)
public function integer production (string _workordernumber, decimal _workorderdetailline, string _packagetype, decimal _qtyproduced, ref long _newserial)
end prototypes

public function integer machinewochange (long _workorder, ref integer _action);
//	Read the parameters.
long	sqlResult, procResult
string	sqlError

//	Attempt to create delete normal order.
declare MachineWOChange procedure for dbo.usp_ShopFloor_MachineWOChange
	@WorkOrder = :_workOrder
,	@Action = :_action output
,	@Result =:procResult output using TransObject  ;

execute MachineWOChange  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change to work orderr:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the order number created and/or the result of the stored procedure.
fetch
	MachineWOChange
into
	:_action
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change to work order:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close MachineWOChange  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer combinejobcomplete (long _looseserial, string _part, long _workorder, string _packagetype, double _qty, string _unit, string _userstatus, string _machine, string _nextlocation, long _issuewo, long _salesorder, string _destination, string _customer, ref long _serial, ref long _actiontaken);
return 0
end function

public function integer createsubstitutematerial (long _primaryrowid, string _substitutepart, decimal _substitutionrate);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create a substitute material.
declare CreateSubstituteMaterial procedure for dbo.usp_ShopFloor_CreateSubstituteMaterial
	@Operator = :User
,	@PrimaryRowID = :_primaryRowID
,	@SubstitutePart = :_substitutePart
,	@SubstitutionRate = :_substitutionRate
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute CreateSubstituteMaterial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create a substitute material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	CreateSubstituteMaterial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, create a substitute material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CreateSubstituteMaterial  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer removematerial (long _removalrowid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to remove a material.
declare RemoveMaterial procedure for dbo.usp_ShopFloor_RemoveMaterial
	@Operator = :User
,	@RemovalRowID = :_removalRowID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RemoveMaterial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to remove a material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RemoveMaterial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to remove a material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close RemoveMaterial  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer restorematerial (long _restorerowid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to restore a material.
declare RestoreMaterial procedure for dbo.usp_ShopFloor_RestoreMaterial
	@Operator = :User
,	@RestoreRowID = :_restoreRowID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute RestoreMaterial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to restore a material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	RestoreMaterial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to restore a material:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close RestoreMaterial  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer setmanualmaterial (long _manualrowid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to set material to manual issue.
declare SetManualMaterial procedure for dbo.usp_ShopFloor_SetManualMaterial
	@Operator = :User
,	@ManualRowID = :_manualRowID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetManualMaterial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set material to manual issue:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetManualMaterial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set material to manual issue:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SetManualMaterial  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer startjobsetup (string _workordernumber, long _workorderdetailsequence);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to remove a material.
declare StartJobSetup procedure for dbo.usp_ShopFloor_StartJobSetup
	@Operator = :User
,	@WorkOrderNumber = :_workOrderNumber
,	@WorkOrderDetailSequence = :_workOrderDetailSequence
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute StartJobSetup  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to start job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	StartJobSetup
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to start job:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close StartJobSetup  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer setjobtool (string _toolsetter, string _workordernumber, long _workorderdetailsequence, string _toolcode, string _toolingnote);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to remove a material.
declare SetJobTool procedure for dbo.usp_ShopFloor_SetJobTool
	@Operator = :_toolSetter
,	@WorkOrderNumber = :_workOrderNumber
,	@WorkOrderDetailSequence = :_workOrderDetailSequence
,	@ToolCode = :_toolCode
,	@ToolingNote = :_toolingNote
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetJobTool  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set tool:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetJobTool
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set tool:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SetJobTool  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function long serialfromlot (string _lot);
long serial

select
	min(serial)
into
	:serial
from
	object
where
	:_lot like '%' + lot
	and
		lot > ''
group by
	lot
having
	count(1) = 1
using SQLCA  ;

return serial

end function

public function integer allocateserial (long _serial, string _workordernumber, long _workorderdetailsequence, long _suffix, decimal _qtybreakout, ref long _breakoutserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to allocate serial.
declare AllocateSerial procedure for dbo.usp_ShopFloor_AllocateSerial
	@Operator = :User
,	@Serial = :_serial
,	@WorkOrderNumber = :_workOrderNumber
,	@WorkOrderDetailSequence = :_workOrderDetailSequence
,	@Suffix = :_suffix
,	@QtyBreakout = :_qtyBreakout
,	@BreakoutSerial = :_breakoutSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AllocateSerial  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to allocate serial:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AllocateSerial
into
	:_breakoutSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, allocate serial:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close AllocateSerial  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer endserialallocation (long _serial, string _workordernumber, long _workorderdetailsequence, long _suffix, boolean _isempty, decimal _qtyremaining, string _changereason);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to end serial allocation.
int isEmpty; if _isEmpty then isEmpty = 1 else isEmpty = 0

declare EndSerialAllocation procedure for dbo.usp_ShopFloor_EndSerialAllocation
	@Operator = :User
,	@Serial = :_serial
,	@WorkOrderNumber = :_workOrderNumber
,	@WorkOrderDetailSequence = :_workOrderDetailSequence
,	@Suffix = :_suffix
,	@IsEmpty = :isEmpty
,	@QtyRemaining = :_qtyRemaining
,	@ChangeReason = :_changeReason
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute EndSerialAllocation  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to end serial allocation:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	EndSerialAllocation
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to end serial allocaiton:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close EndSerialAllocation  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer production (string _workordernumber, decimal _workorderdetailline, string _packagetype, decimal _qtyproduced, ref long _newserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to report production.
declare Production procedure for dbo.usp_ShopFloor_Production
	@Operator = :User
,	@WorkOrderNumber = :_workOrderNumber
,	@WorkOrderDetailLine = :_workOrderDetailLine
,	@PackageType = :_packageType
,	@QtyProduced = :_qtyProduced
,	@NewSerial = :_newSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute Production  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to report production:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	Production
into
	:_newSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to report production:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close Production  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_shopfloortrans.create
call super::create
end on

on n_cst_shopfloortrans.destroy
call super::destroy
end on


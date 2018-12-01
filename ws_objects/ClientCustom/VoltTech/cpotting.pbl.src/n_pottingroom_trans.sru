$PBExportHeader$n_pottingroom_trans.sru
forward
global type n_pottingroom_trans from n_wireharness_base_trans
end type
end forward

global type n_pottingroom_trans from n_wireharness_base_trans
end type
global n_pottingroom_trans n_pottingroom_trans

forward prototypes
public function integer loadkanbantopottingroom (string kanbannumber, string pottingroomoperator, string pottingroommaterialhandler, string pottingmachinecode)
public function integer checkobject (string pottingroommachinecode, long serial, ref string partcode, ref boolean isresin, ref boolean ishardener, ref boolean isharness, ref boolean iscompletableharness)
public function integer allocateserialtojobid (string machineoperator, long serial, long jobid)
public function integer completeharness (string machineoperator, string materialhandler, string machinecode, long harnessserial, string kanbanbinnumber)
public function integer defectharness (string machineoperator, string materialhandler, string machinecode, long harnessserial, string defectreason)
public function integer checkkanban (string machinecode, string kanbanbinnumber, string operatorcode, ref boolean isloadable, ref boolean hasinputcontents, ref boolean isunloadable, ref boolean isemptyorsameoperator, ref string outputpartcode, ref string outputworkordernumber, ref double outputworkorderdetailline, ref long outputjobid)
end prototypes

public function integer loadkanbantopottingroom (string kanbannumber, string pottingroomoperator, string pottingroommaterialhandler, string pottingmachinecode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare LoadKanban procedure for custom.usp_MES_LoadKanbanToPottingRoom
		@PottingRoomOperator = :pottingRoomOperator
	,	@PottingMaterialHandler = :pottingRoomMaterialHandler
	,	@PottingMachineCode = :pottingMachineCode
	,	@KanbanBinNumber = :kanbanNumber
	,	@TranDT = :tranDT output
	,	@Result =:procResult output using TransObject  ;

execute LoadKanban  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to load kanban to potting room:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	LoadKanban
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to load kanban to potting room:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close LoadKanban  ;

//	Return.
return SUCCESS

end function

public function integer checkobject (string pottingroommachinecode, long serial, ref string partcode, ref boolean isresin, ref boolean ishardener, ref boolean isharness, ref boolean iscompletableharness);
//	Read the parameters.
long	sqlResult
string	sqlError

int isResinValue, isHardenerValue, isHarnessValue, isCompletableHarnessValue

select
	pmroi.PartCode
,	pmroi.IsResin
,	pmroi.IsHardener
,	pmroi.IsHarness
,	pmroi.IsCompletableHarness
into
	:partCode
,	:isResinValue
,	:isHardenerValue
,	:isHarnessValue
,	:isCompletableHarnessValue
from
	custom.MES_PottingRoomObjectInquiry pmroi
where
	pmroi.Serial = :serial
	and pmroi.PottingRoomMachineCode = :pottingRoomMachineCode using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get information for object " + string(serial) + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

isResin = (isResinValue = 1)
isHardener = (isHardenerValue = 1)
isharness = (isHarnessValue = 1)
isCompletableHarness = (isCompletableHarnessValue = 1)

//	Return.
return SUCCESS

end function

public function integer allocateserialtojobid (string machineoperator, long serial, long jobid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare AllocateSerial procedure for dbo.usp_MES_AllocateSerial_toJobID
	@Operator = :machineOperator
,	@Serial = :serial
,	@JobID = :jobID
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute AllocateSerial  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to allocate serial " + string(IsNull(serial, -1)) + " to job " + string(IsNull(jobID, -1)) + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	AllocateSerial
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to allocate serial " + string(IsNull(serial, -1)) + " to job " + string(IsNull(jobID, -1)) + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close AllocateSerial  ;

//	Return.
return SUCCESS

end function

public function integer completeharness (string machineoperator, string materialhandler, string machinecode, long harnessserial, string kanbanbinnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare CompleteHarness procedure for custom.usp_MES_PottingRoomCompleteHarness
	@PottingRoomOperator = :machineOperator
,	@PottingRoomMaterialHandler = :materialHandler
,	@PottingRoomMachineCode = :machineCode
,	@HarnessSerial = :harnessSerial
,	@KanbanBinNumber = :kanbanBinNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute CompleteHarness  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to JC harness:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	CompleteHarness
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to JC harness:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CompleteHarness  ;

//	Return.
return SUCCESS

end function

public function integer defectharness (string machineoperator, string materialhandler, string machinecode, long harnessserial, string defectreason);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare DefectHarness procedure for custom.usp_MES_PottingRoomDefectHarness
	@PottingRoomOperator = :machineOperator
,	@PottingRoomMaterialHandler = :materialHandler
,	@PottingRoomMachineCode = :machineCode
,	@HarnessSerial = :harnessSerial
,	@DefectReason = :defectReason
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute DefectHarness  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to defect harness:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	DefectHarness
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to defect harness:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close DefectHarness  ;

//	Return.
return SUCCESS

end function

public function integer checkkanban (string machinecode, string kanbanbinnumber, string operatorcode, ref boolean isloadable, ref boolean hasinputcontents, ref boolean isunloadable, ref boolean isemptyorsameoperator, ref string outputpartcode, ref string outputworkordernumber, ref double outputworkorderdetailline, ref long outputjobid);
//	Read the parameters.
long	sqlResult
string	sqlError

int isLoadableValue, hasInputContentsValue, isUnloadableValue, isEmptyOrSameOperatorValue

select
	IsLoadable = case when mprk.InputPartCode is not null then 1 else 0 end
,	HasInputContents = coalesce(mprk.HasInputContents, 0)
,	IsUnloadable = case when mprk.OutputPartCode is not null then 1 else 0 end
,	IsEmptyOrSameOperator =
		case
			when mprk.HasOutputContents = 0 or mprk.OutputContentOperator = :operatorCode then 1
			else 0
		end
,	mprk.OutputPartCode
,	mprk.OutputWorkOrderNumber
,	mprk.OutputWorkOrderDetailLine
,	mprk.OutputJobID
into
	:isLoadableValue
,	:hasInputContentsValue
,	:isUnloadableValue
,	:isEmptyOrSameOperatorValue
,	:outputPartCode
,	:outputWorkOrderNumber
,	:outputWorkOrderDetailLine
,	:outputJobID
from
	custom.MES_PottingRoomKanbans mprk
where
	mprk.PottingRoomMachineCode = :machineCode
	and mprk.KanbanNumber = :kanbanBinNumber using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get kanban loading information for " + kanbanBinNumber + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

isLoadable = (isLoadableValue = 1)
hasInputContents = (hasInputContentsValue = 1)
isUnloadable = (isUnloadableValue = 1)
isEmptyOrSameOperator = (isEmptyOrSameOperatorValue = 1)

//	Return.
return SUCCESS

end function

on n_pottingroom_trans.create
call super::create
end on

on n_pottingroom_trans.destroy
call super::destroy
end on


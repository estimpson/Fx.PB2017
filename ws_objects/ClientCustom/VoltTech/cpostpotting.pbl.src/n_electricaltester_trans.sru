$PBExportHeader$n_electricaltester_trans.sru
forward
global type n_electricaltester_trans from n_wireharness_base_trans
end type
end forward

global type n_electricaltester_trans from n_wireharness_base_trans
end type
global n_electricaltester_trans n_electricaltester_trans

forward prototypes
public function integer loadkanbantoelectricaltester (string kanbannumber, string operator, string electricaltestmachinecode)
public function integer checkkanban (string machinecode, string kanbanbinnumber, string operatorcode, ref boolean isloadable, ref boolean hasinputcontents, ref boolean isunloadable, ref boolean isemptyorsameoperator, ref string outputworkordernumber, ref double outputworkorderdetailline, ref long outputjobid)
public function integer allocateserialtojobid (string machineoperator, long serial, long jobid)
public function integer defectharness (string machineoperator, string machinecode, long harnessserial, string defectreason)
public function integer completeharness (string machineoperator, string machinecode, long harnessserial, long boxserial)
public function integer beginbox (string electricaltesteroperartor, string electricaltestermachine, long boxserial)
public function integer closebox (string electricaltesteroperartor, string electricaltestermachine, long boxserial)
public function integer checkobject (string machinecode, long serial, ref string partcode, ref boolean isharness, ref boolean iscompletableharness, ref boolean isbox, ref boolean isfullbox, ref boolean iscompletedbox)
end prototypes

public function integer loadkanbantoelectricaltester (string kanbannumber, string operator, string electricaltestmachinecode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare LoadKanban procedure for custom.usp_MES_LoadKanbanToElectricalTester
		@ElectricalTesterOperator = :operator
	,	@ElectricalTesterMachineCode = :electricalTestMachineCode
	,	@KanbanBinNumber = :kanbanNumber
	,	@TranDT = :tranDT output
	,	@Result =:procResult output using TransObject  ;

execute LoadKanban  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to load kanban to electrical tester:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
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
	MessageBox(monsys.msg_Title, "Failed on result, unable to load kanban to electrical tester:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close LoadKanban  ;

//	Return.
return SUCCESS

end function

public function integer checkkanban (string machinecode, string kanbanbinnumber, string operatorcode, ref boolean isloadable, ref boolean hasinputcontents, ref boolean isunloadable, ref boolean isemptyorsameoperator, ref string outputworkordernumber, ref double outputworkorderdetailline, ref long outputjobid);
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
,	mprk.OutputWorkOrderNumber
,	mprk.OutputWorkOrderDetailLine
,	mprk.OutputJobID
into
	:isLoadableValue
,	:hasInputContentsValue
,	:isUnloadableValue
,	:isEmptyOrSameOperatorValue
,	:OutputWorkOrderNumber
,	:OutputWorkOrderDetailLine
,	:OutputJobID
from
	custom.MES_ElectricalTesterKanbans mprk
where
	mprk.ElectricalTesterMachineCode = :machineCode
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

public function integer defectharness (string machineoperator, string machinecode, long harnessserial, string defectreason);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare DefectHarness procedure for custom.usp_MES_ElectricalTesterDefectHarness
	@ElectricalTesterOperator = :machineOperator
,	@ElectricalTesterMachineCode = :machineCode
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

public function integer completeharness (string machineoperator, string machinecode, long harnessserial, long boxserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare CompleteHarness procedure for custom.usp_MES_ElectricalTesterCompleteHarness
	@ElectricalTesterOperator = :machineOperator
,	@ElectricalTesterMachineCode = :machineCode
,	@HarnessSerial = :harnessSerial
,	@BoxSerial = :boxSerial
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

public function integer beginbox (string electricaltesteroperartor, string electricaltestermachine, long boxserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare BeginBox procedure for custom.usp_MES_ElectricalTesterBeginBox
	@ElectricalTesterOperator = :electricalTesterOperartor
,	@ElectricalTesterMachineCode = :electricalTesterMachine
,	@BoxSerial = :boxSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute BeginBox  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to begin box " + string(IsNull(boxSerial, -1)) + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	BeginBox
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to begin box " + string(IsNull(boxSerial, -1)) + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close BeginBox  ;

//	Return.
return SUCCESS

end function

public function integer closebox (string electricaltesteroperartor, string electricaltestermachine, long boxserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare CloseBox procedure for custom.usp_MES_ElectricalTesterCloseBox
	@ElectricalTesterOperator = :electricalTesterOperartor
,	@ElectricalTesterMachineCode = :electricalTesterMachine
,	@BoxSerial = :boxSerial
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute CloseBox  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to begin box " + string(IsNull(boxSerial, -1)) + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	CloseBox
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to begin box " + string(IsNull(boxSerial, -1)) + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close CloseBox  ;

//	Return.
return SUCCESS

end function

public function integer checkobject (string machinecode, long serial, ref string partcode, ref boolean isharness, ref boolean iscompletableharness, ref boolean isbox, ref boolean isfullbox, ref boolean iscompletedbox);
//	Read the parameters.
long	sqlResult
string	sqlError

int isHarnessValue, isCompletableHarnessValue, isBoxValue, isFullBoxValue, isCompletedBoxValue

select
	metoi.PartCode
,	metoi.IsHarness
,	metoi.IsCompletableHarness
,	metoi.IsBox
,	metoi.IsFullBox
,	metoi.IsCompletedBox
into
	:partCode
,	:isHarnessValue
,	:isCompletableHarnessValue
,	:isBoxValue
,	:isFullBoxValue
,	:isCompletedBoxValue
from
	custom.MES_ElectricalTesterObjectInquiry metoi
where
	metoi.Serial = :serial
	and metoi.ElectricalTesterMachineCode = :machineCode using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get information for object " + string(serial) + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

isHarness = (isHarnessValue = 1)
isCompletableHarness = (isCompletableHarnessValue = 1)
isBox = (isBoxValue = 1)
isFullBox = (isFullBoxValue = 1)
isCompletedBox = (isCompletedBoxValue = 1)

//	Return.
return SUCCESS

end function

on n_electricaltester_trans.create
call super::create
end on

on n_electricaltester_trans.destroy
call super::destroy
end on


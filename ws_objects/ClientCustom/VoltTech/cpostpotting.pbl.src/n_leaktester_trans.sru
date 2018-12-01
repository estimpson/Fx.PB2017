$PBExportHeader$n_leaktester_trans.sru
forward
global type n_leaktester_trans from n_wireharness_base_trans
end type
end forward

global type n_leaktester_trans from n_wireharness_base_trans
end type
global n_leaktester_trans n_leaktester_trans

forward prototypes
public function integer loadkanbantoleaktester (string kanbannumber, string operator, string leaktestmachinecode)
public function integer allocateserialtojobid (string machineoperator, long serial, long jobid)
public function integer completeharness (string machineoperator, string machinecode, long harnessserial, string kanbanbinnumber)
public function integer defectharness (string machineoperator, string machinecode, long harnessserial, string defectreason)
public function integer checkobject (string machinecode, long serial, ref string partcode, ref boolean isharness, ref boolean iscompletableharness)
public function integer checkmachine (string machinecode, ref boolean isleaktester, ref boolean iselectricaltester)
public function integer checkkanban (string machinecode, string kanbanbinnumber, string operatorcode, ref boolean isloadable, ref boolean hasinputcontents, ref boolean isunloadable, ref boolean isemptyorsameoperator, string outputpartcode, ref string outputworkordernumber, ref double outputworkorderdetailline, ref long outputjobid)
public function integer completeharness (string machineoperator, string machinecode, long harnessserial, string kanbanbinnumber, string electricaltestermachinecode)
end prototypes

public function integer loadkanbantoleaktester (string kanbannumber, string operator, string leaktestmachinecode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare LoadKanban procedure for custom.usp_MES_LoadKanbanToLeakTester
		@LeakTesterOperator = :operator
	,	@LeakTesterMachineCode = :leakTestMachineCode
	,	@KanbanBinNumber = :kanbanNumber
	,	@TranDT = :tranDT output
	,	@Result =:procResult output using TransObject  ;

execute LoadKanban  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to load kanban to leak tester:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
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
	MessageBox(monsys.msg_Title, "Failed on result, unable to load kanban to leak tester:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close LoadKanban  ;

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

public function integer completeharness (string machineoperator, string machinecode, long harnessserial, string kanbanbinnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare CompleteHarness procedure for custom.usp_MES_LeakTesterCompleteHarness
	@LeakTesterOperator = :machineOperator
,	@LeakTesterMachineCode = :machineCode
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

public function integer defectharness (string machineoperator, string machinecode, long harnessserial, string defectreason);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare DefectHarness procedure for custom.usp_MES_LeakTesterDefectHarness
	@LeakTesterOperator = :machineOperator
,	@LeakTesterMachineCode = :machineCode
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

public function integer checkobject (string machinecode, long serial, ref string partcode, ref boolean isharness, ref boolean iscompletableharness);
//	Read the parameters.
long	sqlResult
string	sqlError

int isResinValue, isHardenerValue, isHarnessValue, isCompletableHarnessValue

select
	mltoi.PartCode
,	mltoi.IsHarness
,	mltoi.IsCompletableHarness
into
	:partCode
,	:isHarnessValue
,	:isCompletableHarnessValue
from
	custom.MES_LeakTesterObjectInquiry mltoi
where
	mltoi.Serial = :serial
	and mltoi.LeakTesterMachineCode = :machineCode using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get information for object " + string(serial) + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

isHarness = (isHarnessValue = 1)
isCompletableHarness = (isCompletableHarnessValue = 1)

//	Return.
return SUCCESS

end function

public function integer checkmachine (string machinecode, ref boolean isleaktester, ref boolean iselectricaltester);
//	Read the parameters.
long	sqlResult
string	sqlError

int isLeakTesterValue, isElectricalTesterValue

select
	IsLeakTester = case when mltm.LeakTesterMachineCode > "" then 1 else 0 end
,	IsElectricalTester = case when metm.ElectricalTesterMachineCode > "" then 1 else 0 end
into
	:isLeakTesterValue
,	:isElectricalTesterValue
from
	( select dummy = 1 ) d
	left join custom.MES_LeakTesterMachines mltm
		on mltm.LeakTesterMachineCode = :machineCode
		or mltm.MachineID = case when :machineCode not like '%[^0-9]%' then convert(int, :machineCode) else -1 end
	left join custom.MES_ElectricalTesterMachines metm
		on metm.ElectricalTesterMachineCode = :machineCode
		or metm.MachineID = case when :machineCode not like '%[^0-9]%' then convert(int, :machineCode) else -1 end
using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get information for machine code " + machineCode + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

isLeakTester = (isLeakTesterValue = 1)
isElectricalTester = (isElectricalTesterValue = 1)

//	Return.
return SUCCESS

end function

public function integer checkkanban (string machinecode, string kanbanbinnumber, string operatorcode, ref boolean isloadable, ref boolean hasinputcontents, ref boolean isunloadable, ref boolean isemptyorsameoperator, string outputpartcode, ref string outputworkordernumber, ref double outputworkorderdetailline, ref long outputjobid);
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
,	:OutputPartCode
,	:OutputWorkOrderNumber
,	:OutputWorkOrderDetailLine
,	:OutputJobID
from
	custom.MES_LeakTesterKanbans mprk
where
	mprk.LeakTesterMachineCode = :machineCode
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

public function integer completeharness (string machineoperator, string machinecode, long harnessserial, string kanbanbinnumber, string electricaltestermachinecode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare CompleteHarness procedure for custom.usp_MES_LeakTesterCompleteHarness
	@LeakTesterOperator = :machineOperator
,	@LeakTesterMachineCode = :machineCode
,	@HarnessSerial = :harnessSerial
,	@KanbanBinNumber = :kanbanBinNumber
,	@ElectricalTesterMachineCode = :electricalTesterMachineCode
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

on n_leaktester_trans.create
call super::create
end on

on n_leaktester_trans.destroy
call super::destroy
end on


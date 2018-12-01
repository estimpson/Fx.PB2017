$PBExportHeader$n_prepottingassembly_trans.sru
forward
global type n_prepottingassembly_trans from n_wireharness_base_trans
end type
end forward

global type n_prepottingassembly_trans from n_wireharness_base_trans
end type
global n_prepottingassembly_trans n_prepottingassembly_trans

type variables

end variables

forward prototypes
public function integer getjobinformation (string productionpart, ref string workordernumber, ref double workorderdetaillineno, ref long jobid)
public function integer newscrapentry (string machineoperator, string workordernumber, double workorderdetailline, string componentpart, decimal scrapquantity, string defectcode)
public function integer completeharnesstokanbanbin (string machineoperator, long assemblyboard, long preobjectserial, string kanbanbinnumber)
end prototypes

public function integer getjobinformation (string productionpart, ref string workordernumber, ref double workorderdetaillineno, ref long jobid);
//	Read the parameters.
long	sqlResult
string	sqlError

select
	mjl.WorkOrderNumber
,	mjl.WorkOrderDetailLine
,	mjl.WODID
into
	:workorderNumber
,	:workorderDetailLineNo
,	:jobID
from
	dbo.MES_JobList mjl
where
	mjl.PartCode = :productionPart
	and mjl.WODID =
		(	select
				min(mjlFirst.WODID)
			from
				dbo.MES_JobList mjlFirst
			where
				mjlFirst.PartCode = :productionPart
		) using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get job information for part " + productionPart + ":  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer newscrapentry (string machineoperator, string workordernumber, double workorderdetailline, string componentpart, decimal scrapquantity, string defectcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare	NewScrapEntry procedure for dbo.usp_MES_NewScrapEntry
		@User = :machineOperator
	,	@WorkOrderNumber = :workOrderNumber
	,	@WorkOrderDetailLine = :workOrderDetailLine
	,	@ComponentPart = :componentPart
	,	@ScrapQty = :scrapQuantity
	,	@DefectCode = :defectCode
	,	@TranDT = :tranDT output
	,	@Result =:procResult output using TransObject  ;

execute NewScrapEntry  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to write new scrap entry:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	NewScrapEntry
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to write new scrap entry:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close NewScrapEntry  ;

//	Return.
return SUCCESS

end function

public function integer completeharnesstokanbanbin (string machineoperator, long assemblyboard, long preobjectserial, string kanbanbinnumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare CompleteHarness procedure for custom.usp_MES_PrePottingCompleteHarness
	@PrePottingOperator = :machineOperator
,	@PrePottingAssemblyBoard = :assemblyBoard
,	@HarnessSerial = :preObjectSerial
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

on n_prepottingassembly_trans.create
call super::create
end on

on n_prepottingassembly_trans.destroy
call super::destroy
end on


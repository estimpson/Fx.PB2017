$PBExportHeader$n_tr_scheduling.sru
forward
global type n_tr_scheduling from n_tr
end type
end forward

global type n_tr_scheduling from n_tr
integer ii_sqlconnector = 2
end type
global n_tr_scheduling n_tr_scheduling

forward prototypes
public function integer schedulenextbuild (ref string workordernumber, string user, string machinecode, string toolcode, string processcode, decimal nextbuildqty, datetime duedt, string toppart, integer salesorderno, string shiptocode, string billtocode, ref integer procresult, boolean commitnow)
end prototypes

public function integer schedulenextbuild (ref string workordernumber, string user, string machinecode, string toolcode, string processcode, decimal nextbuildqty, datetime duedt, string toppart, integer salesorderno, string shiptocode, string billtocode, ref integer procresult, boolean commitnow);
long	sqlResult
string	sqlError

datetime tranDT; SetNull(tranDT)
declare ScheduleNextBuild procedure for dbo.usp_Scheduling_ScheduleNextBuild
	@WorkOrderNumber = :workOrderNumber output
,	@User = :user
,	@MachineCode = :machineCode
,	@ToolCode = :toolCode
,	@ProcessCode = :processCode
,	@NextBuildQty = :nextBuildQty
,	@DueDT = :dueDT
,	@TopPart = :topPart
,	@SalesOrderNo = :salesOrderNo
,	@ShipToCode = :shipToCode
,	@BillToCode = :billToCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute
	ScheduleNextBuild  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to schedule next build:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	ScheduleNextBuild
into
	:workOrderNumber
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	SQLCA.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to schedule next build:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close ScheduleNextBuild  ;
if	commitNow then SQLCA.of_Commit()

//	Return.
return SUCCESS

end function

on n_tr_scheduling.create
call super::create
end on

on n_tr_scheduling.destroy
call super::destroy
end on


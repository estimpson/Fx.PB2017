HA$PBExportHeader$n_cst_kanbancardstrans.sru
forward
global type n_cst_kanbancardstrans from n_cst_fxtrans
end type
end forward

global type n_cst_kanbancardstrans from n_cst_fxtrans
end type
global n_cst_kanbancardstrans n_cst_kanbancardstrans

forward prototypes
public function integer newmfgkanbancards (string toppart, string firstpart, string lastpart, integer newcardcount, ref long firstnewkanbanserial)
public function integer newrplkanbancards (string componentpart, decimal kanbanqty, integer newcardcount, ref long firstnewkanbanserial)
public function integer scrapobjectlist (string objectlist)
public function integer moveobjectlisttokanban (string objectlist, string movetokanbannumber)
public function integer deletekanbanlist (string kanbannumberlist)
public function integer deletekanban (string kanbannumber)
end prototypes

public function integer newmfgkanbancards (string toppart, string firstpart, string lastpart, integer newcardcount, ref long firstnewkanbanserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create mfg. kanban cards.
declare NewMfgKanbanCards procedure for dbo.usp_MES_NewMfgKanbanCards
	@User = :User
,	@TopPart = :topPart
,	@FirstPart = :firstPart
,	@LastPart = :lastPart
,	@NumberOfCards = :newCardCount
,	@FirstObjectSerial = :firstNewKanbanSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewMfgKanbanCards  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new mfg. kanban card(s):  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewMfgKanbanCards
into
	:firstNewKanbanSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new mfg. kanban card(s):  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewMfgKanbanCards   ;

//	Return.
return SUCCESS

end function

public function integer newrplkanbancards (string componentpart, decimal kanbanqty, integer newcardcount, ref long firstnewkanbanserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create rpl. kanban cards.
declare NewReplenishmentKanbanCards procedure for dbo.usp_MES_NewReplenishmentKanbanCards
	@User = :User
,	@PartCode = :componentPart
,	@KanbanQty = :kanbanQty
,	@NumberOfCards = :newCardCount
,	@FirstObjectSerial = :firstNewKanbanSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewReplenishmentKanbanCards  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new replenishment kanban card(s):  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	NewReplenishmentKanbanCards
into
	:firstNewKanbanSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new replenishment kanban card(s):  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close NewReplenishmentKanbanCards   ;

//	Return.
return SUCCESS

end function

public function integer scrapobjectlist (string objectlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create rpl. kanban cards.
declare ScrapObjectList procedure for dbo.usp_MES_Kanbans_ScrapObjectList
	@User = :User
,	@ObjectList = :objectList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ScrapObjectList  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to scrap Kanban Bin contents:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ScrapObjectList
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to scrap Kanban Bin contents:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ScrapObjectList   ;

//	Return.
return SUCCESS

end function

public function integer moveobjectlisttokanban (string objectlist, string movetokanbannumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create rpl. kanban cards.
declare MoveObjectListToKanban procedure for dbo.usp_MES_Kanbans_MoveObjectListToKanban
	@User = :User
,	@ObjectList = :objectList
,	@MoveToKanbanNumber = :moveToKanbanNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute MoveObjectListToKanban  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to move objects to Kanban Bin:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	MoveObjectListToKanban
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to move objects to Kanban Bin:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close MoveObjectListToKanban   ;

//	Return.
return SUCCESS

end function

public function integer deletekanbanlist (string kanbannumberlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create rpl. kanban cards.
declare DeleteKanbanList procedure for dbo.usp_MES_Kanbans_DeleteKanbanList
	@User = :User
,	@KanbanNumberList = :kanbanNumberList
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeleteKanbanList  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to delete Kanban Bins:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeleteKanbanList
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to delete Kanban Bins:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeleteKanbanList   ;

//	Return.
return SUCCESS

end function

public function integer deletekanban (string kanbannumber);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create rpl. kanban cards.
declare DeleteKanban procedure for dbo.usp_MES_Kanbans_DeleteKanban
	@User = :User
,	@KanbanNumber = :kanbanNumber
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DeleteKanban  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to delete Kanban Bin:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DeleteKanban
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to delete Kanban Bin:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DeleteKanban   ;

//	Return.
return SUCCESS

end function

on n_cst_kanbancardstrans.create
call super::create
end on

on n_cst_kanbancardstrans.destroy
call super::destroy
end on


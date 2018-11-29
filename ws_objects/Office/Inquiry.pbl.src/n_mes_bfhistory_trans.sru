$PBExportHeader$n_mes_bfhistory_trans.sru
forward
global type n_mes_bfhistory_trans from n_cst_fxtrans
end type
end forward

global type n_mes_bfhistory_trans from n_cst_fxtrans
end type
global n_mes_bfhistory_trans n_mes_bfhistory_trans

forward prototypes
public function integer settempwip (string childpart)
public function integer setwip (string childpart)
public function integer cleartempwip (string childpart)
end prototypes

public function integer settempwip (string childpart);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to set temp WIP.
declare SetTempWIP procedure for dbo.usp_MES_BFHist_SetPartTempWIP
	@PartCode = :childPart
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetTempWIP  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set temp WIP:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetTempWIP
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set temp WIP:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetTempWIP   ;

//	Return.
return SUCCESS

end function

public function integer setwip (string childpart);
return NO_ACTION

end function

public function integer cleartempwip (string childpart);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to clear temp WIP.
declare ClearTempWIP procedure for dbo.usp_MES_BFHist_ClearPartTempWIP
	@PartCode = :childPart
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ClearTempWIP  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to clear temp WIP:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ClearTempWIP
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to clear temp WIP:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ClearTempWIP   ;

//	Return.
return SUCCESS

end function

on n_mes_bfhistory_trans.create
call super::create
end on

on n_mes_bfhistory_trans.destroy
call super::destroy
end on


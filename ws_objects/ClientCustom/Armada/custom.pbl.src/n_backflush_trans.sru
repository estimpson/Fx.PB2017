$PBExportHeader$n_backflush_trans.sru
forward
global type n_backflush_trans from n_cst_fxtrans
end type
end forward

global type n_backflush_trans from n_cst_fxtrans
end type
global n_backflush_trans n_backflush_trans

forward prototypes
public function integer backflush ()
public function integer backflushwithoverride ()
end prototypes

public function integer backflush ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch backflush.
declare BatchBackflush procedure for dbo.usp_MES_BatchBackflush
	@Operator = :user
,	@Override = 'N'
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BatchBackflush  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to batch backflush:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BatchBackflush
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to batch backflush:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BatchBackflush   ;

//	Return.
return SUCCESS

end function

public function integer backflushwithoverride ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch backflush.
declare BatchBackflush procedure for dbo.usp_MES_BatchBackflush
	@Operator = :user
,	@Override = 'Y'
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute BatchBackflush  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to batch backflush:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	BatchBackflush
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to batch backflush:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close BatchBackflush   ;

//	Return.
return SUCCESS

end function

on n_backflush_trans.create
call super::create
end on

on n_backflush_trans.destroy
call super::destroy
end on


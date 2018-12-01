$PBExportHeader$n_oee_trans.sru
forward
global type n_oee_trans from n_cst_fxtrans
end type
end forward

global type n_oee_trans from n_cst_fxtrans
end type
global n_oee_trans n_oee_trans

forward prototypes
public function string getuser ()
public function integer getshiftinfo (datetime shiftdate, integer shift, ref string supervisoruser, ref string supervisorname, ref decimal shifthours, ref string shiftnotes)
public function integer setshiftinfo (datetime shiftdate, integer shift, decimal shifthours, string shiftnotes)
end prototypes

public function string getuser ();
//	Return.
return User

end function

public function integer getshiftinfo (datetime shiftdate, integer shift, ref string supervisoruser, ref string supervisorname, ref decimal shifthours, ref string shiftnotes);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare GetShiftInfo procedure for custom.usp_OEE_GetShiftInfo
	@ShiftDate = :shiftDate
,	@Shift = :shift
,	@SupervisorUser = :supervisorUser output
,	@SupervisorName = :supervisorName output
,	@ShiftHours = :shiftHours output
,	@ShiftNotes = :shiftNotes output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute GetShiftInfo  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to get shift info:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	GetShiftInfo
into
	:supervisorUser
,	:supervisorName
,	:shiftHours
,	:shiftNotes
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to get shift info:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close GetShiftInfo   ;

//	Return.
return SUCCESS

end function

public function integer setshiftinfo (datetime shiftdate, integer shift, decimal shifthours, string shiftnotes);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func2.
declare SetShiftInfo procedure for custom.usp_OEE_SetShiftInfo
	@ShiftDate = :shiftDate
,	@Shift = :shift
,	@SupervisorUser = :User
,	@ShiftHours = :shiftHours
,	@ShiftNotes = :shiftNotes
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetShiftInfo  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to set shift info:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Set the result of the stored procedure.
fetch
	SetShiftInfo
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to set shift info:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetShiftInfo   ;

//	Return.
return SUCCESS

end function

on n_oee_trans.create
call super::create
end on

on n_oee_trans.destroy
call super::destroy
end on


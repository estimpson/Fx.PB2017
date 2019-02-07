HA$PBExportHeader$n_wireharnessinquiry_trans.sru
forward
global type n_wireharnessinquiry_trans from n_cst_fxtrans
end type
end forward

global type n_wireharnessinquiry_trans from n_cst_fxtrans
end type
global n_wireharnessinquiry_trans n_wireharnessinquiry_trans

forward prototypes
public function integer newharnesses (string wireharnesspartcode, string initialpartcode, long numberoflabels, ref long firstharnessserial)
end prototypes

public function integer newharnesses (string wireharnesspartcode, string initialpartcode, long numberoflabels, ref long firstharnessserial);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare NewHarnesses procedure for custom.usp_MES_WireHarnesses_NewHarnesses
	@User = :User
,	@WireHarnessPartCode = :wireHarnessPartCode
,	@InitialPartCode = :initialPartCode
,	@NumberOfLabels = :numberOfLabels
,	@FirstHarnessSerial = :firstHarnessSerial output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute NewHarnesses  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new harnesses:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	NewHarnesses
into
	:firstHarnessSerial
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new harnesses:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close NewHarnesses  ;

//	Return.
return SUCCESS

end function

on n_wireharnessinquiry_trans.create
call super::create
end on

on n_wireharnessinquiry_trans.destroy
call super::destroy
end on


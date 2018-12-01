$PBExportHeader$n_wireharness_base_trans.sru
forward
global type n_wireharness_base_trans from n_cst_fxtrans
end type
end forward

global type n_wireharness_base_trans from n_cst_fxtrans
end type
global n_wireharness_base_trans n_wireharness_base_trans

forward prototypes
public function integer getpartmfgurl (string machineoperator, string partcode, ref string mfgurl)
end prototypes

public function integer getpartmfgurl (string machineoperator, string partcode, ref string mfgurl);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare GetPartMfgUrll_toJobID procedure for custom.usp_MES_GetPartMfgUrl
	@Operator = :machineOperator
,	@PartCode = :partCode
,	@mfgURL = :mfgURL output
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute GetPartMfgUrll_toJobID  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to get part manufacturing instructions for part " + partCode + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	GetPartMfgUrll_toJobID
into
	:mfgURL
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to get part manufacturing instructions for part " + partCode + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close GetPartMfgUrll_toJobID  ;

//	Return.
return SUCCESS

end function

on n_wireharness_base_trans.create
call super::create
end on

on n_wireharness_base_trans.destroy
call super::destroy
end on


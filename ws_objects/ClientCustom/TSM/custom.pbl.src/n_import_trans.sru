$PBExportHeader$n_import_trans.sru
forward
global type n_import_trans from n_cst_fxtrans
end type
end forward

global type n_import_trans from n_cst_fxtrans
end type
global n_import_trans n_import_trans

forward prototypes
public function integer saveimportedcosts ()
end prototypes

public function integer saveimportedcosts ();
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to batch func1.
declare SaveImportedCosts procedure for custom.usp_PartCostImport_SaveImportedCosts
	@Operator = :user
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SaveImportedCosts  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to save imported costs:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SaveImportedCosts
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to save imported costs:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SaveImportedCosts   ;

//	Return.
return SUCCESS

end function

on n_import_trans.create
call super::create
end on

on n_import_trans.destroy
call super::destroy
end on


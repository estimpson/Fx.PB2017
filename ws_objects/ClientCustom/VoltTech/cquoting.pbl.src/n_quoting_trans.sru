$PBExportHeader$n_quoting_trans.sru
forward
global type n_quoting_trans from n_cst_fxtrans
end type
end forward

global type n_quoting_trans from n_cst_fxtrans
end type
global n_quoting_trans n_quoting_trans

forward prototypes
public function integer newquoteheader (st_newquote newquotevalues)
end prototypes

public function integer newquoteheader (st_newquote newquotevalues);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare NewQuoteHeader procedure for custom.usp_QT_NewQuoteHeader
	@User = :User
,	@QuoteNumber = :newQuoteValues.QuoteNumber
,	@QuoteType = :newQuoteValues.QuoteType
,	@ParentQuoteID = :newQuoteValues.ParentQuoteID
,	@QuoteYear = :newQuoteValues.QuoteYear
,	@QuoteYearOrdinal = :newQuoteValues.QuoteYearOrdinal
,	@ECNOrdinal = :newQuoteValues.ECNOrdinal
,	@RevisionOrdinal = :newQuoteValues.RevisionOrdinal
,	@QuoteDate = :newQuoteValues.QuoteDate
,	@Customer = :newQuoteValues.Customer
,	@PartDescription = :newQuoteValues.PartDescription
,	@Program = :newQuoteValues.Program
,	@EAU = :newQuoteValues.EAU
,	@SOP = :newQuoteValues.SOP
,	@EOP = :newQuoteValues.EOP
,	@OEM = :newQuoteValues.OEM
,	@ModelYear = :newQuoteValues.ModelYear
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute NewQuoteHeader  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create new quote " + newQuoteValues.QuoteNumber + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	NewQuoteHeader
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create new quote " + newQuoteValues.QuoteNumber + ":  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close NewQuoteHeader  ;

//	Return.
return SUCCESS

end function

on n_quoting_trans.create
call super::create
end on

on n_quoting_trans.destroy
call super::destroy
end on


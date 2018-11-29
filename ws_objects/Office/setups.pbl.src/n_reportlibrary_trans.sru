$PBExportHeader$n_reportlibrary_trans.sru
forward
global type n_reportlibrary_trans from n_cst_fxtrans
end type
end forward

global type n_reportlibrary_trans from n_cst_fxtrans
end type
global n_reportlibrary_trans n_reportlibrary_trans

forward prototypes
public function integer deletereportlist (string reportlist)
end prototypes

public function integer deletereportlist (string reportlist);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult
string	sqlError

//	Attempt to report list.
delete
	rl
from
	dbo.ReportLibrary rl
where
	rl.ReportName in
		(	select
				fsstr.Value
			from
				dbo.fn_SplitStringToRows(:reportList, ',') fsstr
		) using TransObject  ;

sqlResult = TransObject.SQLCode
if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on execute, unable to delete report list:  {" + String(sqlResult) + "} " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

on n_reportlibrary_trans.create
call super::create
end on

on n_reportlibrary_trans.destroy
call super::destroy
end on


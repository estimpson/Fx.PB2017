$PBExportHeader$n_columncomments_trans.sru
forward
global type n_columncomments_trans from n_cst_fxtrans
end type
end forward

global type n_columncomments_trans from n_cst_fxtrans
end type
global n_columncomments_trans n_columncomments_trans

forward prototypes
public function integer newcomment (string tableschema, string tablenamedotcolumnname, string datarowguid, string comment)
public function integer deletecomment (long commentrowid)
public function integer editcomment (long commentrowid, string comment)
end prototypes

public function integer newcomment (string tableschema, string tablenamedotcolumnname, string datarowguid, string comment);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare NewFxComment procedure for Fx.usp_ColumnComments_NewFxComment
	@User = :User
,	@SchemaName = :tableSchema
,	@TableNameDotColumnName = :tableNameDotColumnName
,	@DataRowGUID = :dataRowGUID
,	@Comment = :comment
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute NewFxComment  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to create column comment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	NewFxComment
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to create column comment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close NewFxComment  ;

//	Return.
return SUCCESS

end function

public function integer deletecomment (long commentrowid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare DeleteComment procedure for Fx.usp_ColumnComments_DeleteComment
	@User = :User
,	@CommentID = :commentRowID
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute DeleteComment  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to delete column comment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	DeleteComment
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to delete column comment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close DeleteComment  ;

//	Return.
return SUCCESS

end function

public function integer editcomment (long commentrowid, string comment);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

declare EditComment procedure for Fx.usp_ColumnComments_EditComment
	@User = :User
,	@CommentID = :commentRowID
,	@Comment = :comment
,	@TranDT = :tranDT output
,	@Result =:procResult output using SQLCA  ;

execute EditComment  ;
sqlResult = SQLCA.SQLCode

if	sqlResult <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to edit column comment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

fetch
	EditComment
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or SQLCA.SQLCode <> 0 then
	sqlError = SQLCA.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to edit column comment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close EditComment  ;

//	Return.
return SUCCESS

end function

on n_columncomments_trans.create
call super::create
end on

on n_columncomments_trans.destroy
call super::destroy
end on


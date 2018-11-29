$PBExportHeader$n_cst_partmastertrans_attachments.sru
forward
global type n_cst_partmastertrans_attachments from n_cst_fxtrans
end type
end forward

global type n_cst_partmastertrans_attachments from n_cst_fxtrans
end type
global n_cst_partmastertrans_attachments n_cst_partmastertrans_attachments

forward prototypes
public function integer getuploadpath (ref string uploadpath)
public function integer attachdocument (string partcode, string filename, string filepath, string filedescription, string categoryname, ref string attachmentname)
public function integer changeattachmentproperties (string partcode, long rowid, string categoryname, string filedescription)
public function integer discardattachment (string partcode, long rowid)
end prototypes

public function integer getuploadpath (ref string uploadpath);
select
	dbo.udf_PartMaster_AttachmentUploadFolder()
into
	:uploadPath
from
	(select dummy = 1) d  using TransObject  ;
	
if	TransObject.SQLCode <> 0 then
	string sqlError
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to get upload folder:  " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer attachdocument (string partcode, string filename, string filepath, string filedescription, string categoryname, ref string attachmentname);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to attach document.
declare AttachDocument procedure for dbo.usp_PartMaster_AttachDocument
	@PartCode =:partCode
,	@FileName = :fileName
,	@FilePath = :filePath
,	@FileDescription = :fileDescription
,	@CategoryName = :categoryName
,	@AttachmentName = :attachmentName out
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute AttachDocument  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to attach document:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	AttachDocument
into
	:attachmentName
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to attach document:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AttachDocument   ;

//	Return.
return SUCCESS

end function

public function integer changeattachmentproperties (string partcode, long rowid, string categoryname, string filedescription);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to change attachment properties.
declare ChangeAttachmentProperties procedure for dbo.usp_PartMaster_ChangeAttachedDocumentProperties
	@PartCode =:partCode
,	@RowID = :rowID
,	@CategoryName = :categoryName
,	@FileDescription = :fileDescription
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ChangeAttachmentProperties  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change attachment properties:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ChangeAttachmentProperties
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change attachment properties:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ChangeAttachmentProperties   ;

//	Return.
return SUCCESS

end function

public function integer discardattachment (string partcode, long rowid);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to discard attachment.
declare DiscartAttachedDocument procedure for dbo.usp_PartMaster_DiscardAttachedDocument
	@PartCode =:partCode
,	@RowID = :rowID
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute DiscartAttachedDocument  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to discard attachment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	DiscartAttachedDocument
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to discard attachment:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close DiscartAttachedDocument   ;

//	Return.
return SUCCESS

end function

on n_cst_partmastertrans_attachments.create
call super::create
end on

on n_cst_partmastertrans_attachments.destroy
call super::destroy
end on


HA$PBExportHeader$n_setup_defectcodes_trans.sru
forward
global type n_setup_defectcodes_trans from n_cst_fxtrans
end type
end forward

global type n_setup_defectcodes_trans from n_cst_fxtrans
end type
global n_setup_defectcodes_trans n_setup_defectcodes_trans

forward prototypes
public function integer getcatdetails_fordefectcodeattachmentcat (string name, ref string categorydescription, ref string defaultextensions)
public function integer getuploadpath (ref string uploadpath)
public function integer attachdocument (string defectcode, string filename, string filepath, string filedescription, string categoryname, ref string attachmentname)
end prototypes

public function integer getcatdetails_fordefectcodeattachmentcat (string name, ref string categorydescription, ref string defaultextensions);
select
	dcac.CategoryDescription
,	dcac.DefaultExtensions
into
	:categoryDescription
,	:defaultExtensions
from
	FxIntranet.dbo.DefectCode_AttachmentCategories dcac
where
	dcac.CategoryName = :name using TransObject  ;

return SUCCESS

end function

public function integer getuploadpath (ref string uploadpath);
select
	dbo.udf_Setup_DefectCodes_AttachmentUploadFolder()
into
	:uploadPath
from
	(select dummy = 1) d  using TransObject  ;
	
if	TransObject.SQLCode <> 0 then
	string sqlError
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MsgBox("Failed on result, unable to get upload folder:  " + sqlError)
	return FAILURE
end if

//	Return.
return SUCCESS

end function

public function integer attachdocument (string defectcode, string filename, string filepath, string filedescription, string categoryname, ref string attachmentname);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to attach document.
declare AttachDocument procedure for dbo.usp_Setup_DefectCode_AttachDocument
	@DefectCode =:defectCode
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
	MsgBox("Failed on execute, unable to attach document:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
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
	MsgBox("Failed on result, unable to attach document:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close AttachDocument   ;

//	Return.
return SUCCESS

end function

on n_setup_defectcodes_trans.create
call super::create
end on

on n_setup_defectcodes_trans.destroy
call super::destroy
end on


HA$PBExportHeader$n_supplieredi_admin_trans.sru
forward
global type n_supplieredi_admin_trans from n_cst_fxtrans
end type
end forward

global type n_supplieredi_admin_trans from n_cst_fxtrans
end type
global n_supplieredi_admin_trans n_supplieredi_admin_trans

forward prototypes
public function integer clearvendor (string vendorcode)
public function integer setvendorstatus (string vendorcode, long edistatus)
public function integer setblanketporeleaseplanstatus (long ponumber, long newstatus)
public function integer sendreleaseplantest (string vendorcode, long ponumber, ref string newfile)
end prototypes

public function integer clearvendor (string vendorcode);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create new shipper.
declare ClearVendor procedure for EDISupplier.usp_VendorSettings_Clear
	@VendorCode = :vendorCode
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute ClearVendor  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to clear vendor:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	ClearVendor
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to clear vendor:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close ClearVendor   ;

//	Return.
return SUCCESS

end function

public function integer setvendorstatus (string vendorcode, long edistatus);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create new shipper.
declare SetVendorStatus procedure for EDISupplier.usp_VendorSettings_SetStatus
	@VendorCode = :vendorCode
,	@EDIStatus = :ediStatus
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetVendorStatus  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to set vendor status:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetVendorStatus
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to set vendor status:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetVendorStatus   ;

//	Return.
return SUCCESS

end function

public function integer setblanketporeleaseplanstatus (long ponumber, long newstatus);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create new shipper.
declare SetStatus_BlanketPOReleasePlan procedure for EDISupplier.usp_SetStatus_BlanketPOReleasePlan
	@PONumber = :poNumber
,	@Status = :newStatus
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SetStatus_BlanketPOReleasePlan  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to change blanket purchase order release plan status:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SetStatus_BlanketPOReleasePlan
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to change blanket purchase order release plan status:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SetStatus_BlanketPOReleasePlan   ;

//	Return.
return SUCCESS

end function

public function integer sendreleaseplantest (string vendorcode, long ponumber, ref string newfile);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to create new shipper.
long firstNewReleasePlan, files
long generateMode = 1, actionMode = 5

EnableANSIWarnings()

declare GenerateXML procedure for EDISupplier.usp_GenerateReleasePlanXML
	@GenerateMode = :generateMode
,	@VendorFilter = :vendorCode
,	@PONumberFilter = :poNumber
,	@ActionMode = :actionMode
,	@FirstNewReleasePlan = :firstNewReleasePlan output
,	@Files = :files output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute GenerateXML  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	DisableANSIWarnings()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to generate release plan XML file:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	GenerateXML
into
	:firstNewReleasePlan
,	:files
,	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to generate release plan XML file:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close GenerateXML   ;

DisableANSIWarnings()

//	Get the path of the created file.
string currentFilePath, fileName

select
	OutboundFolderPath = redOutboundFolder.file_stream.GetFileNamespacePath()
,	OutboundFileName = rpgl.OriginalFileName
into
	:currentFilePath
,	:fileName
from
	EDISupplier.ReleasePlanGenerationLog rpgl
	join FxEDI.dbo.RawEDIData redOutboundFiles
		on redOutboundFiles.stream_id = rpgl.FileStreamID
	join FxEDI.dbo.RawEDIData redOutboundFolder
		on redOutboundFiles.parent_path_locator = redOutboundFolder.path_locator
		and redOutboundFiles.is_directory = 0
where
	rpgl.RowID = :firstNewReleasePlan using TransObject  ;

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to generate release plan XML file:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

CommitTrans()

TransObject.AutoCommit = true
EnableAnsiWarnings()
EnableCmdLine()

//	Send the file.
declare SendXMLFile procedure for EDISupplier.usp_SendSupplierReleasePlans
	@SendFileFromFolder = :currentFilePath
,	@SendFileNamePattern = :fileName
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SendXMLFile  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	DisableCmdLine()
	TransObject.AutoCommit = false
	MessageBox(monsys.msg_Title, "Failed on execute, unable to send release plan XML file:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SendXMLFile
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	RollbackTrans()
	MessageBox(monsys.msg_Title, "Failed on result, unable to send release plan XML file:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure.
close SendXMLFile   ;

DisableCmdLine()
DisableANSIWarnings()
TransObject.AutoCommit = false
CommitTrans()

//	Return.
return SUCCESS

end function

on n_supplieredi_admin_trans.create
call super::create
end on

on n_supplieredi_admin_trans.destroy
call super::destroy
end on


$PBExportHeader$n_cst_notification.sru
forward
global type n_cst_notification from n_cst_fxtrans
end type
end forward

global type n_cst_notification from n_cst_fxtrans
end type
global n_cst_notification n_cst_notification

forward prototypes
public function integer savevendoremail (string vendorcode, string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom)
public function integer savepoemail (long ponumber, string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom)
public function integer sendemail (string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom)
public function integer posendemail (long ponumber, string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom)
end prototypes

public function integer savevendoremail (string vendorcode, string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to change po vendor.
declare SaveVendorEmailProfile procedure for dbo.usp_Notification_SaveVendorEmailProfile
	@VendorCode = :vendorCode
,	@EmailTo = :emailTo
,	@EmailCC = :emailCC
,	@EmailReplyTo = :emailReplyTo
,	@EmailSubject = :emailSubject
,	@EmailBody = :emailBody
,	@EmailAttachmentNames = :emailAttachmentNames
,	@EmailFrom = :emailFrom
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SaveVendorEmailProfile  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to save vendor email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SaveVendorEmailProfile
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to save vendor email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SaveVendorEmailProfile  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer savepoemail (long ponumber, string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, procResult
string	sqlError

//	Attempt to change po vendor.
declare SavePOEmailProfile procedure for dbo.usp_Notification_SavePOEmailProfile
	@PONumber = :PONumber
,	@EmailTo = :emailTo
,	@EmailCC = :emailCC
,	@EmailReplyTo = :emailReplyTo
,	@EmailSubject = :emailSubject
,	@EmailBody = :emailBody
,	@EmailAttachmentNames = :emailAttachmentNames
,	@EmailFrom = :emailFrom
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SavePOEmailProfile  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to save PO email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SavePOEmailProfile
into
	:tranDT
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to save PO email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SavePOEmailProfile  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer sendemail (string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, mailItemID, procResult
string	sqlError

//	Attempt to change po vendor.
declare SendEmail procedure for dbo.usp_Notification_SendEmail
	@EmailTo = :emailTo
,	@EmailCC = :emailCC
,	@EmailReplyTo = :emailReplyTo
,	@EmailSubject = :emailSubject
,	@EmailBody = :emailBody
,	@EmailAttachmentNames = :emailAttachmentNames
,	@EmailFrom = :emailFrom
,	@MailItemID = :mailItemID output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SendEmail  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to send email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SendEmail
into
	:tranDT
,	:mailItemID
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to send email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SendEmail  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

public function integer posendemail (long ponumber, string emailto, string emailcc, string emailreplyto, string emailsubject, string emailbody, string emailattachmentnames, string emailfrom);
//	Read the parameters.
datetime tranDT ; setNull (tranDT)
long	sqlResult, mailItemID, procResult
string	sqlError

//	Attempt to change po vendor.
declare SendEmail procedure for dbo.usp_Notification_POSendEmail
	@PONumber = :poNumber
,	@EmailTo = :emailTo
,	@EmailCC = :emailCC
,	@EmailReplyTo = :emailReplyTo
,	@EmailSubject = :emailSubject
,	@EmailBody = :emailBody
,	@EmailAttachmentNames = :emailAttachmentNames
,	@EmailFrom = :emailFrom
,	@MailItemID = :mailItemID output
,	@TranDT = :tranDT output
,	@Result =:procResult output using TransObject  ;

execute SendEmail  ;
sqlResult = TransObject.SQLCode

if	sqlResult <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on execute, unable to send email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Get the result of the stored procedure.
fetch
	SendEmail
into
	:tranDT
,	:mailItemID
,	:procResult  ;

if	procResult <> 0 or TransObject.SQLCode <> 0 then
	sqlError = TransObject.SQLErrText
	TransObject.of_Rollback()
	MessageBox(monsys.msg_Title, "Failed on result, unable to send email:  {" + String(sqlResult) + "," + String(procResult) + "} " + sqlError)
	return FAILURE
end if

//	Close procedure and commit.
close SendEmail  ;
TransObject.of_Commit()

//	Return.
return SUCCESS

end function

on n_cst_notification.create
call super::create
end on

on n_cst_notification.destroy
call super::destroy
end on


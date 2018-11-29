$PBExportHeader$w_sendporeleases.srw
forward
global type w_sendporeleases from w_sheet_4t
end type
type dw_report from datawindow within w_sendporeleases
end type
type dw_emailheader from u_dw within w_sendporeleases
end type
end forward

global type w_sendporeleases from w_sheet_4t
integer width = 3333
integer height = 2348
string title = "Send PO Releases"
string menuname = "m_sendporeleases"
boolean controlmenu = true
boolean minbox = true
event notify_email ( )
dw_report dw_report
dw_emailheader dw_emailheader
end type
global w_sendporeleases w_sendporeleases

type variables

long PONumber
string AttachmentName
n_cst_associative_array ReportParms

end variables

event notify_email();
if	dw_emailheader.RowCount() <= 0 then
	return
end if
dw_emailheader.AcceptText()

string vendorCode
string emailTo, emailCC, emailReplyTo, emailSubject, emailBody, emailAttachmentNames, emailFrom
int poDefinedEmailTo, poDefinedEmailCC, poDefinedEmailReplyTo, poDefinedEmailSubject, poDefinedEmailBody, poDefinedEmailAttachmentNames, poDefinedEmailFrom
int vendorDefinedEmailTo, vendorDefinedEmailCC, vendorDefinedEmailReplyTo, vendorDefinedEmailSubject, vendorDefinedEmailBody, vendorDefinedEmailAttachmentNames, vendorDefinedEmailFrom

vendorCode = dw_emailheader.object.VendorCode[1]
emailTo = dw_emailheader.object.EmailTo[1]
emailCC = dw_emailheader.object.EmailCC[1]
emailReplyTo = dw_emailheader.object.EmailReplyTo[1]
emailSubject = dw_emailheader.object.EmailSubject[1]
emailBody = dw_emailheader.object.EmailBody[1]
emailAttachmentNames = dw_emailheader.object.EmailAttachmentNames[1]
emailFrom = dw_emailheader.object.EmailFrom[1]

poDefinedEmailTo = dw_emailheader.object.PODefinedEmailTo[1]
poDefinedEmailCC = dw_emailheader.object.PODefinedEmailCC[1]
poDefinedEmailReplyTo = dw_emailheader.object.PODefinedEmailReplyTo[1]
poDefinedEmailSubject = dw_emailheader.object.PODefinedEmailSubject[1]
poDefinedEmailBody = dw_emailheader.object.PODefinedEmailBody[1]
poDefinedEmailAttachmentNames = dw_emailheader.object.PODefinedEmailAttachmentNames[1]
poDefinedEmailFrom = dw_emailheader.object.PODefinedEmailFrom[1]

vendorDefinedEmailTo = dw_emailheader.object.VendorDefinedEmailTo[1]
vendorDefinedEmailCC = dw_emailheader.object.VendorDefinedEmailCC[1]
vendorDefinedEmailReplyTo = dw_emailheader.object.VendorDefinedEmailReplyTo[1]
vendorDefinedEmailSubject = dw_emailheader.object.VendorDefinedEmailSubject[1]
vendorDefinedEmailBody = dw_emailheader.object.VendorDefinedEmailBody[1]
vendorDefinedEmailAttachmentNames = dw_emailheader.object.VendorDefinedEmailAttachmentNames[1]
vendorDefinedEmailFrom = dw_emailheader.object.VendorDefinedEmailFrom[1]

//	Send email.
n_cst_notification Notification
Notification = create n_cst_notification
Notification.POSendEmail(PONumber, emailTo, emailCC, emailReplyTo, emailSubject, emailBody, emailAttachmentNames, emailFrom)
close(this)
end event

on w_sendporeleases.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sendporeleases" then this.MenuID = create m_sendporeleases
this.dw_report=create dw_report
this.dw_emailheader=create dw_emailheader
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.dw_emailheader
end on

on w_sendporeleases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_report)
destroy(this.dw_emailheader)
end on

event pfc_preopen;call super::pfc_preopen;
//	Get the PO Number.
ReportParms = message.PowerObjectParm
PONumber = isnull(reportParms.of_GetItem ("Arg1"), -1)

//	Build PO PDF.
dw_emailheader.event pfc_retrieve()

end event

type dw_report from datawindow within w_sendporeleases
integer x = 14
integer y = 1612
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;
Hide()
end event

type dw_emailheader from u_dw within w_sendporeleases
integer width = 3273
integer height = 1584
integer taborder = 10
string dataobject = "d_sendporeleases_emailprofile"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
//	Retrieve
of_SetTransObject (sqlca)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(PONumber)

end event

event buttonclicked;call super::buttonclicked;
AcceptText()
string vendorCode
string emailTo, emailCC, emailReplyTo, emailSubject, emailBody, emailAttachmentNames, emailFrom
int poDefinedEmailTo, poDefinedEmailCC, poDefinedEmailReplyTo, poDefinedEmailSubject, poDefinedEmailBody, poDefinedEmailAttachmentNames, poDefinedEmailFrom
int vendorDefinedEmailTo, vendorDefinedEmailCC, vendorDefinedEmailReplyTo, vendorDefinedEmailSubject, vendorDefinedEmailBody, vendorDefinedEmailAttachmentNames, vendorDefinedEmailFrom

vendorCode = dw_emailheader.object.VendorCode[1]
emailTo = dw_emailheader.object.EmailTo[1]
emailCC = dw_emailheader.object.EmailCC[1]
emailReplyTo = dw_emailheader.object.EmailReplyTo[1]
emailSubject = dw_emailheader.object.EmailSubject[1]
emailBody = dw_emailheader.object.EmailBody[1]
emailAttachmentNames = dw_emailheader.object.EmailAttachmentNames[1]
emailFrom = dw_emailheader.object.EmailFrom[1]

poDefinedEmailTo = dw_emailheader.object.PODefinedEmailTo[1]
poDefinedEmailCC = dw_emailheader.object.PODefinedEmailCC[1]
poDefinedEmailReplyTo = dw_emailheader.object.PODefinedEmailReplyTo[1]
poDefinedEmailSubject = dw_emailheader.object.PODefinedEmailSubject[1]
poDefinedEmailBody = dw_emailheader.object.PODefinedEmailBody[1]
poDefinedEmailAttachmentNames = dw_emailheader.object.PODefinedEmailAttachmentNames[1]
poDefinedEmailFrom = dw_emailheader.object.PODefinedEmailFrom[1]

vendorDefinedEmailTo = dw_emailheader.object.VendorDefinedEmailTo[1]
vendorDefinedEmailCC = dw_emailheader.object.VendorDefinedEmailCC[1]
vendorDefinedEmailReplyTo = dw_emailheader.object.VendorDefinedEmailReplyTo[1]
vendorDefinedEmailSubject = dw_emailheader.object.VendorDefinedEmailSubject[1]
vendorDefinedEmailBody = dw_emailheader.object.VendorDefinedEmailBody[1]
vendorDefinedEmailAttachmentNames = dw_emailheader.object.VendorDefinedEmailAttachmentNames[1]
vendorDefinedEmailFrom = dw_emailheader.object.VendorDefinedEmailFrom[1]

n_cst_notification Notification
Notification = create n_cst_notification
string emailToD, emailCCD, emailReplyToD, emailSubjectD, emailBodyD, emailAttachmentNamesD, emailFromD

choose case dwo.Name
	case "b_savepo"
		if	poDefinedEmailTo = 1 then
			emailToD = emailTo
		else
			SetNull(emailToD)
		end if
		if	poDefinedEmailCC = 1 then
			emailCCD = emailCC
		else
			SetNull(emailCCD)
		end if
		if	poDefinedEmailReplyTo = 1 then
			emailReplyToD = emailReplyTo
		else
			SetNull(emailReplyToD)
		end if
		if	poDefinedEmailSubject = 1 then
			emailSubjectD = emailSubject
		else
			SetNull(emailSubjectD)
		end if
		if	poDefinedEmailBody = 1 then
			emailBodyD = emailBody
		else
			SetNull(emailBodyD)
		end if
		if	poDefinedEmailAttachmentNames = 1 then
			emailAttachmentNamesD = emailAttachmentNames
		else
			SetNull(emailAttachmentNamesD)
		end if
		if	poDefinedEmailFrom = 1 then
			emailFromD = emailFrom
		else
			SetNull(emailFromD)
		end if
		Notification.SavePOEmail(PONumber, emailToD, emailCCD, emailReplyToD, emailSubjectD, emailBodyD, emailAttachmentNamesD, emailFromD)
	case "b_savevendor"
		if	vendorDefinedEmailTo = 1 then
			emailToD = emailTo
		else
			SetNull(emailToD)
		end if
		if	vendorDefinedEmailCC = 1 then
			emailCCD = emailCC
		else
			SetNull(emailCCD)
		end if
		if	vendorDefinedEmailReplyTo = 1 then
			emailReplyToD = emailReplyTo
		else
			SetNull(emailReplyToD)
		end if
		if	vendorDefinedEmailSubject = 1 then
			emailSubjectD = emailSubject
		else
			SetNull(emailSubjectD)
		end if
		if	vendorDefinedEmailBody = 1 then
			emailBodyD = emailBody
		else
			SetNull(emailBodyD)
		end if
		if	vendorDefinedEmailAttachmentNames = 1 then
			emailAttachmentNamesD = emailAttachmentNames
		else
			SetNull(emailAttachmentNamesD)
		end if
		if	vendorDefinedEmailFrom = 1 then
			emailFromD = emailFrom
		else
			SetNull(emailFromD)
		end if
		Notification.SaveVendorEmail(vendorCode, emailToD, emailCCD, emailReplyToD, emailSubjectD, emailBodyD, emailAttachmentNamesD, emailFromD)
end choose

end event

event retrieveend;call super::retrieveend;
if	rowcount = 1 then
	AttachmentName = object.emailAttachmentNames[1]
	
	//	Get the releases form.
	n_cst_report Report; Report = create n_cst_report
	datastore reportDS; reportDS = create datastore
	Report.GetReportDS(reportParms, reportDS)
	
	//	Save the data.
	dw_report.Create(reportDS.object.DataWindow.Syntax)
	reportDS.ShareData(dw_report)
	dw_report.SaveAs(AttachmentName, pdf!, true)
end if

end event


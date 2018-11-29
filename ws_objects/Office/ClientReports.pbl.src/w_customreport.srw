$PBExportHeader$w_customreport.srw
forward
global type w_customreport from w_sheet_4t
end type
type dw_report from u_dw within w_customreport
end type
end forward

global type w_customreport from w_sheet_4t
integer x = 214
integer y = 221
integer width = 2551
integer height = 1604
string menuname = "m_customreport"
event print ( )
event printpreview ( )
event refresh ( )
event saverows ( )
dw_report dw_report
end type
global w_customreport w_customreport

event print();
OpenWithParm(w_customreport_printsetup, dw_report)


end event

event printpreview();
//	Check if report has preview option.
if	Upper(dw_report.object.Datawindow.Nested) = "YES" then return

//	Reverse preview.
if	Upper(dw_report.object.Datawindow.Print.Preview) = "NO" then
	m_customreport.m_file.m_printpreview.toolbaritemdown = true
	dw_report.object.Datawindow.Print.Preview = "YES"
else
	m_customreport.m_file.m_printpreview.toolbaritemdown = false
	dw_report.object.Datawindow.Print.Preview = "NO"
end if

end event

event refresh();
dw_report.event pfc_retrieve()

end event

event saverows();
dw_report.SaveAs("", Excel8!, true)


end event

on w_customreport.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_customreport" then this.MenuID = create m_customreport
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
end on

on w_customreport.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_report)
end on

event pfc_preopen;call super::pfc_preopen;
//	If there is a string parm, set the data object.
if	gnv_App.inv_Global.of_GetItem("parameters") > "" then
	dw_report.dataobject = gnv_App.inv_Global.of_GetItem("parameters")
end if

//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize(dw_report.X + dw_report.Width, dw_report.Y + dw_report.Height)
inv_Resize.of_Register(dw_report, 0, 0, 100, 100)

end event

event pfc_postopen;call super::pfc_postopen;
//	Check if report has preview option.
if	dw_report.dataobject = "" then return

if	Upper(dw_report.Describe("Datawindow.Nested")) = "YES" then
	m_customreport.m_file.m_printpreview.enabled = false
	m_customreport.m_file.m_printpreview.toolbaritemdown = true
end if


end event

type dw_report from u_dw within w_customreport
integer width = 2395
integer height = 1316
integer taborder = 10
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;
post SetTransObject(SQLCA)

end event

event updateend;call super::updateend;
//	Autocommit any changes in reports that save data.
if	not SQLCA.AutoCommit then
	commit using SQLCA  ;
end if

end event


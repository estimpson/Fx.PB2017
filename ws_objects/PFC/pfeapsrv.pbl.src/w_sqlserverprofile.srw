$PBExportHeader$w_sqlserverprofile.srw
forward
global type w_sqlserverprofile from w_response
end type
type dw_1 from datawindow within w_sqlserverprofile
end type
type cb_1 from commandbutton within w_sqlserverprofile
end type
type cb_2 from commandbutton within w_sqlserverprofile
end type
end forward

global type w_sqlserverprofile from w_response
integer width = 1335
integer height = 772
string title = "Add / Edit SQL Server Profile"
long backcolor = 78748035
event ue_save ( )
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_sqlserverprofile w_sqlserverprofile

type variables
string	OriginalProfile
string	is_AppProfile
end variables

event ue_save();//	Declarations
n_cst_registry	inv_Reg
string		ls_Profile
string		ls_ServerName
string		ls_Database
string		ls_LogId
string		ls_LogPassword
ulong		lul_IntegratedSecurity
ulong		lul_AutoCommit

dw_1.AcceptText ( )

//	Find the specified profile.
n_ds dsProfiles
dsProfiles = create n_ds
dsProfiles.DataObject = "d_conn_profiles"
//dsProfiles.ImportFile(XML!, "ConnProfiles.xml")
dsProfiles.ImportFile("ConnProfiles.txt")
dsProfiles.SetFilter("profilename=~"" + OriginalProfile + "~"")
dsProfiles.Filter()
if	dsProfiles.RowCount() < 1 then
	dsProfiles.InsertRow(0)
end if
dsProfiles.Object.ProfileName[1] = dw_1.Object.Profile[1]
dsProfiles.Object.ServerName[1] =  dw_1.Object.ServerName[1]
dsProfiles.Object.Database[1] =  dw_1.Object.Database[1]
dsProfiles.Object.LogId[1] =  dw_1.Object.LogId[1]
dsProfiles.Object.Password[1] =  dw_1.Object.LogPassword[1]
dsProfiles.Object.IntegratedSecurity[1] =  dw_1.Object.IntegratedSecurity[1]
dsProfiles.Object.AutoCommit[1] =  dw_1.Object.AutoCommit[1]
dsProfiles.SetFilter("")
dsProfiles.Filter()
dsProfiles.Sort()
//dsProfiles.SaveAs("ConnProfiles.xml", XML!, false)
dsProfiles.SaveAs("ConnProfiles.txt", Text!, false)
destroy dsProfiles

end event

event open;call super::open;
//	Turn on the base service and center the window
of_SetBase(true)
inv_base.of_Center()

//	Store the app profile
n_cst_associative_array	args
args = Message.PowerObjectParm
string sqlProfile
sqlProfile = args.of_GetItem ( "SQLProfile" )
OriginalProfile = sqlProfile

//	If a profile was sent, display it
if sqlProfile > '' then
	//	Find the specified profile.
	n_ds dsProfiles
	dsProfiles = create n_ds
	dsProfiles.DataObject = "d_conn_profiles"
	//dsProfiles.ImportFile(XML!, "ConnProfiles.xml")
	dsProfiles.ImportFile("ConnProfiles.txt")
	dsProfiles.SetFilter("profilename=~"" + sqlProfile + "~"")
	dsProfiles.Filter()
	if	dsProfiles.RowCount() > 0 then
		dw_1.SetItem ( 1, "Profile", dsProfiles.object.ProfileName[1] )
		dw_1.SetItem ( 1, "ServerName", dsProfiles.object.ServerName[1] )
		dw_1.SetItem ( 1, "Database", dsProfiles.object.Database[1] )
		dw_1.SetItem ( 1, "LogId", dsProfiles.object.LogID[1] )
		dw_1.SetItem ( 1, "LogPassword", dsProfiles.object.Password[1] )
		dw_1.SetItem ( 1, "IntegratedSecurity", dsProfiles.object.IntegratedSecurity[1] )
		dw_1.SetItem ( 1, "AutoCommit", dsProfiles.object.AutoCommit[1] )
	end if
	destroy dsProfiles
end if



end event

on w_sqlserverprofile.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_sqlserverprofile.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_1 from datawindow within w_sqlserverprofile
integer x = 18
integer y = 16
integer width = 1298
integer height = 496
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sqlserverprofile"
boolean border = false
end type

type cb_1 from commandbutton within w_sqlserverprofile
integer x = 256
integer y = 544
integer width = 329
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
boolean default = true
end type

event clicked;Parent.Event ue_Save ( )
CloseWithReturn ( Parent, 1 )
end event

type cb_2 from commandbutton within w_sqlserverprofile
integer x = 677
integer y = 544
integer width = 329
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn ( Parent, -1 )
end event


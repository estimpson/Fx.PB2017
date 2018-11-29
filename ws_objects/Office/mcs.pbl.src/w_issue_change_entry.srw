$PBExportHeader$w_issue_change_entry.srw
forward
global type w_issue_change_entry from Window
end type
type cb_2 from commandbutton within w_issue_change_entry
end type
type cb_1 from commandbutton within w_issue_change_entry
end type
type dw_1 from datawindow within w_issue_change_entry
end type
end forward

global type w_issue_change_entry from Window
int X=823
int Y=360
int Width=2555
int Height=828
boolean TitleBar=true
string Title="Issue Changed"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_issue_change_entry w_issue_change_entry

event open;st_generic_structure	lstr_parm

lstr_parm = Message.PowerObjectParm

if lstr_parm.value2 = '' then
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "issue_number", Long ( lstr_parm.value1 ) )
	dw_1.SetItem ( 1, "status_new", lstr_parm.value3 )
else
	dw_1.Retrieve ( Long ( lstr_parm.value1 ), DateTime ( lstr_parm.value2 ) )
end if
end event

on w_issue_change_entry.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_issue_change_entry.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_issue_change_entry
int X=347
int Y=592
int Width=311
int Height=128
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, -1 )
end event

type cb_1 from commandbutton within w_issue_change_entry
int X=18
int Y=592
int Width=311
int Height=128
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.AcceptText ( )

if isnull(dw_1.GetItemString ( 1, "origin" ),'') = '' then
	MessageBox ( "Issue Change", "You must specify the person changing the issue.", Information! )
	return
elseif isnull(dw_1.GetItemString ( 1, "notes" ), '' ) = '' then
	MessageBox ( "Issue Change", "You must enter a description of change.", Information! )
	return
end if

dw_1.SetItem ( 1, "date_stamp", Now ( ) )
dw_1.SetItem ( 1, "status_old", '' )

if dw_1.Update ( ) = 1 then
	CloseWithReturn ( Parent, 0 )
else
	rollback;
	MessageBox ( "Issue Change", "Unable to save due to a database error.", Information! )
end if


end event

type dw_1 from datawindow within w_issue_change_entry
int X=18
int Y=16
int Width=2523
int Height=560
int TabOrder=10
string DataObject="d_issue_change_entry"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject ( sqlca )
end event


$PBExportHeader$w_contact_call_log_entry.srw
forward
global type w_contact_call_log_entry from Window
end type
type cb_2 from commandbutton within w_contact_call_log_entry
end type
type cb_1 from commandbutton within w_contact_call_log_entry
end type
type dw_1 from datawindow within w_contact_call_log_entry
end type
end forward

global type w_contact_call_log_entry from Window
int X=823
int Y=364
int Width=2583
int Height=1156
boolean TitleBar=true
string Title="Contact Call Entry"
long BackColor=77633680
boolean ControlMenu=true
WindowType WindowType=response!
event ue_save ( )
event ue_new_issue ( )
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_contact_call_log_entry w_contact_call_log_entry

type variables
string	is_customer
end variables

on w_contact_call_log_entry.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_contact_call_log_entry.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;st_generic_structure	lstr_parm
string	ls_parent
datawindowchild ldwc_dddw

lstr_parm = Message.PowerObjectParm

if isnull(lstr_parm.value2,'') > '' then
	dw_1.Retrieve ( lstr_parm.value1, DateTime ( Date ( LeftA ( lstr_parm.value2, 10 ) ), Time ( RightA ( lstr_parm.value2, 8 ) ) ) )
else
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "contact", lstr_parm.value1 )
	dw_1.SetItem ( 1, "start_date", DateTime ( Date ( String ( Today ( ), "mm/dd/yyyy" ) ), Time ( String ( Now ( ), "hh:mm:ss" ) ) ) )
end if

if isnull(lstr_parm.value4,'') > '' then
	ls_parent = lstr_parm.value4
else
	ls_parent = lstr_parm.value3
end if

dw_1.getchild ( "contact", ldwc_dddw )
if ldwc_dddw.Retrieve ( ls_parent ) < 1 then
	ldwc_dddw.InsertRow ( 1 )
end if

is_customer = lstr_parm.value3
end event

event resize;//dw_1.height = height - cb_1.height - 15
//dw_1.width = width - 50
//cb_1.y = dw_1.height + 10
//cb_2.y = dw_1.height + 10
//cb_3.y = dw_1.height + 10
end event

type cb_2 from commandbutton within w_contact_call_log_entry
int X=384
int Y=912
int Width=329
int Height=112
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

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_contact_call_log_entry
int X=18
int Y=912
int Width=329
int Height=112
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

event clicked;dw_1.SetItem ( 1, "stop_date", Now ( ) )

if dw_1.Update ( ) = 1 then
	commit;
	CloseWithReturn ( Parent, 1 )
else
	rollback;
end if
end event

type dw_1 from datawindow within w_contact_call_log_entry
int X=18
int Y=16
int Width=2505
int Height=880
int TabOrder=10
string DataObject="d_contact_call_log"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;datawindowchild	ldwc_dddw

getchild ( "contact", ldwc_dddw )

ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

SetTransObject ( sqlca )


end event


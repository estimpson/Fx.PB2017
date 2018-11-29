$PBExportHeader$w_finish.srw
forward
global type w_finish from Window
end type
type st_1 from statictext within w_finish
end type
type cb_cancel from commandbutton within w_finish
end type
type cb_ok from commandbutton within w_finish
end type
type cbx_label from checkbox within w_finish
end type
type cbx_form from checkbox within w_finish
end type
type st_title from statictext within w_finish
end type
end forward

global type w_finish from Window
int X=832
int Y=360
int Width=1184
int Height=1180
boolean TitleBar=true
string Title="Finished!"
long BackColor=79741120
WindowType WindowType=response!
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
cbx_label cbx_label
cbx_form cbx_form
st_title st_title
end type
global w_finish w_finish

on w_finish.create
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_label=create cbx_label
this.cbx_form=create cbx_form
this.st_title=create st_title
this.Control[]={this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.cbx_label,&
this.cbx_form,&
this.st_title}
end on

on w_finish.destroy
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_label)
destroy(this.cbx_form)
destroy(this.st_title)
end on

event open;integer  l_i_forms, &
			l_i_labels

select count(*)
into 	 :l_i_forms
from 	 report_library
where type = 'C' or type = 'D';

if l_i_forms > 0 then
	cbx_form.enabled = true
else
	cbx_form.enabled = false
end if

select count(*)
into 	 :l_i_forms
from 	 report_library
where type = 'W' ;

if l_i_forms > 0 then
	cbx_label.enabled = true
else
	cbx_label.enabled = false
end if
end event

type st_1 from statictext within w_finish
int X=41
int Y=816
int Width=338
int Height=76
boolean Enabled=false
string Text="Remove old:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_finish
int X=827
int Y=948
int Width=279
int Height=108
int TabOrder=2
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event

type cb_ok from commandbutton within w_finish
int X=535
int Y=948
int Width=247
int Height=108
int TabOrder=1
boolean Enabled=false
string Text="&OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer l_i_count

string  l_s_syntax

If cbx_form.checked then
	
	select count(*)
	into   :l_i_count
	from  report_library
	where type <> 'W' ;
	
	if sqlca.sqlcode = 0 then
	
		l_s_syntax = 'drop table forms'
		
		SQLCA.autocommit = True
		execute immediate :l_s_syntax ;
		SQLCA.autocommit = False
		
	end if
	
end if

If cbx_label.checked then
	
	select count(*)
	into   :l_i_count
	from  report_library
	where type = 'W' ;
	
	if sqlca.sqlcode = 0 then
		
		l_s_syntax = 'drop table label_library'

		SQLCA.autocommit = True	
		execute immediate :l_s_syntax ;
		SQLCA.autocommit = False
	
	end if
	
end if

Close ( Parent )
end event

type cbx_label from checkbox within w_finish
int X=165
int Y=976
int Width=256
int Height=76
string Text="Labels"
boolean LeftText=true
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF Checked or cbx_form.Checked THEN
	cb_ok.Enabled = TRUE
ELSE
	cb_ok.Enabled = FALSE
END IF
end event

type cbx_form from checkbox within w_finish
int X=169
int Y=888
int Width=251
int Height=76
string Text="Forms"
boolean LeftText=true
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF Checked or cbx_label.Checked THEN
	cb_ok.Enabled = TRUE
ELSE
	cb_ok.Enabled = FALSE
END IF
end event

type st_title from statictext within w_finish
int X=23
int Y=20
int Width=1129
int Height=788
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;Text = "In order to make use of the Extended Forms And Labels Architecture, you must remove your old forms and labels tables.  If you do not wish to remove them at this time, Monitor will continue using the old tables and you will not have the added functionality of the Extended Forms And Labels Architecture. Note that you can upgrade your forms or your labels independently by selecting only one of the checkboxes."
end event


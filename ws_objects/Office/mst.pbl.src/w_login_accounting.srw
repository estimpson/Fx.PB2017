$PBExportHeader$w_login_accounting.srw
forward
global type w_login_accounting from Window
end type
type cb_2 from commandbutton within w_login_accounting
end type
type cb_1 from commandbutton within w_login_accounting
end type
type st_2 from statictext within w_login_accounting
end type
type st_1 from statictext within w_login_accounting
end type
type sle_2 from singlelineedit within w_login_accounting
end type
type sle_1 from singlelineedit within w_login_accounting
end type
end forward

global type w_login_accounting from Window
int X=833
int Y=357
int Width=1317
int Height=545
boolean TitleBar=true
string Title="DB Login"
long BackColor=12632256
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
sle_2 sle_2
sle_1 sle_1
end type
global w_login_accounting w_login_accounting

type variables
st_generic_structure	ist_Parm
end variables

on w_login_accounting.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.sle_2,&
this.sle_1}
end on

on w_login_accounting.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.sle_1)
end on

type cb_2 from commandbutton within w_login_accounting
int X=650
int Y=333
int Width=270
int Height=109
int TabOrder=40
string Text="Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type cb_1 from commandbutton within w_login_accounting
int X=339
int Y=333
int Width=270
int Height=109
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, ist_Parm )
end on

type st_2 from statictext within w_login_accounting
int X=83
int Y=209
int Width=430
int Height=73
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Password "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_login_accounting
int X=83
int Y=73
int Width=430
int Height=73
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="User ID "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_login_accounting
int X=595
int Y=209
int Width=627
int Height=73
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;ist_Parm.value2 = This.Text
end on

type sle_1 from singlelineedit within w_login_accounting
int X=595
int Y=73
int Width=627
int Height=73
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;ist_Parm.value1 = This.Text
end on


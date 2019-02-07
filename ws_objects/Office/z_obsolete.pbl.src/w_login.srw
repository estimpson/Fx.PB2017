$PBExportHeader$w_login.srw
forward
global type w_login from Window
end type
type cb_2 from commandbutton within w_login
end type
type cb_1 from commandbutton within w_login
end type
type sle_2 from singlelineedit within w_login
end type
type st_2 from statictext within w_login
end type
type sle_1 from singlelineedit within w_login
end type
type st_1 from statictext within w_login
end type
end forward

global type w_login from Window
int X=526
int Y=552
int Width=1394
int Height=568
boolean TitleBar=true
string Title="Enter Operator Password"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
sle_2 sle_2
st_2 st_2
sle_1 sle_1
st_1 st_1
end type
global w_login w_login

on w_login.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.st_2=create st_2
this.sle_1=create sle_1
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_2,&
this.st_2,&
this.sle_1,&
this.st_1}
end on

on w_login.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.st_1)
end on

type cb_2 from commandbutton within w_login
int X=731
int Y=288
int Width=549
int Height=160
int TabOrder=30
string Text="&Cancel"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( w_login, sle_1.Text )
end on

type cb_1 from commandbutton within w_login
int X=73
int Y=288
int Width=549
int Height=160
int TabOrder=20
string Text="&Ok"
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( w_login, sle_1.Text )
end on

type sle_2 from singlelineedit within w_login
int X=768
int Y=32
int Width=549
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;SELECT employee.operator_code  
  INTO :sle_1.Text
  FROM employee  
 WHERE employee.password = :sle_2.Text   ;


end on

type st_2 from statictext within w_login
int X=183
int Y=32
int Width=549
int Height=96
boolean Enabled=false
string Text="Password:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-16
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_login
int X=768
int Y=160
int Width=549
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_login
int Y=160
int Width=731
int Height=96
boolean Enabled=false
string Text="Operator Code:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-16
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


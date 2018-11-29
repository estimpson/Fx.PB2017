$PBExportHeader$w_operator_entry.srw
forward
global type w_operator_entry from Window
end type
type sle_code from singlelineedit within w_operator_entry
end type
type sle_password from singlelineedit within w_operator_entry
end type
type st_2 from statictext within w_operator_entry
end type
type st_1 from statictext within w_operator_entry
end type
type cb_2 from commandbutton within w_operator_entry
end type
type cb_1 from commandbutton within w_operator_entry
end type
end forward

global type w_operator_entry from Window
int X=777
int Y=600
int Width=1056
int Height=520
boolean TitleBar=true
string Title="Enter Operator"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
sle_code sle_code
sle_password sle_password
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_operator_entry w_operator_entry

on w_operator_entry.create
this.sle_code=create sle_code
this.sle_password=create sle_password
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.sle_code,&
this.sle_password,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_operator_entry.destroy
destroy(this.sle_code)
destroy(this.sle_password)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type sle_code from singlelineedit within w_operator_entry
int X=640
int Y=140
int Width=293
int Height=96
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_password from singlelineedit within w_operator_entry
int X=640
int Y=16
int Width=293
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string	l_s_operator

if text < " " then return

SELECT employee.operator_code  
  INTO :l_s_operator  
  FROM employee  
 WHERE employee.password = :text   ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( "Error", "Invalid Operator Password! Please Try Again.", StopSign! )
	Text = ""
	SetFocus ( )
	Return
End if

sle_code.Text = l_s_operator
end event

type st_2 from statictext within w_operator_entry
int X=32
int Y=36
int Width=475
int Height=64
boolean Enabled=false
string Text="Operator Password:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_operator_entry
int X=123
int Y=144
int Width=375
int Height=64
boolean Enabled=false
string Text="Operator Code:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_operator_entry
int X=535
int Y=284
int Width=256
int Height=112
int TabOrder=30
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, '' )
end event

type cb_1 from commandbutton within w_operator_entry
int X=201
int Y=284
int Width=256
int Height=112
int TabOrder=20
string Text="&Ok"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, sle_code.text )
end event


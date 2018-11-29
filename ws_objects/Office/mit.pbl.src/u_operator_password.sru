$PBExportHeader$u_operator_password.sru
forward
global type u_operator_password from UserObject
end type
type sle_operator_code from singlelineedit within u_operator_password
end type
type sle_operator_password from singlelineedit within u_operator_password
end type
type cb_3 from commandbutton within u_operator_password
end type
type cb_2 from commandbutton within u_operator_password
end type
type st_1 from statictext within u_operator_password
end type
type cb_1 from commandbutton within u_operator_password
end type
end forward

global type u_operator_password from UserObject
int Width=1042
int Height=448
long BackColor=12632256
long PictureMaskColor=25166016
long TabBackColor=67108864
sle_operator_code sle_operator_code
sle_operator_password sle_operator_password
cb_3 cb_3
cb_2 cb_2
st_1 st_1
cb_1 cb_1
end type
global u_operator_password u_operator_password

type variables
String	szOperatorCode
Window	iw_Parent
end variables

forward prototypes
public subroutine uof_attrib (boolean bmode)
end prototypes

public subroutine uof_attrib (boolean bmode);If bMode Then
	This.Show ( )
Else
	This.Hide ( )
End if
end subroutine

on constructor;iw_Parent	= Parent
iw_Parent.PostEvent ( "ue_enable_chars_for_password" )

end on

on u_operator_password.create
this.sle_operator_code=create sle_operator_code
this.sle_operator_password=create sle_operator_password
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.sle_operator_code,&
this.sle_operator_password,&
this.cb_3,&
this.cb_2,&
this.st_1,&
this.cb_1}
end on

on u_operator_password.destroy
destroy(this.sle_operator_code)
destroy(this.sle_operator_password)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type sle_operator_code from singlelineedit within u_operator_password
int X=475
int Y=128
int Width=421
int Height=96
int TabOrder=50
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_operator_password from singlelineedit within u_operator_password
int X=146
int Y=128
int Width=274
int Height=96
int TabOrder=40
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within u_operator_password
int X=530
int Y=288
int Width=293
int Height=128
int TabOrder=20
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iw_Parent.TriggerEvent ( "ue_close_password" )
end on

type cb_2 from commandbutton within u_operator_password
int X=201
int Y=288
int Width=293
int Height=128
int TabOrder=10
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String	szOperatorPassword

szOperatorPassword = sle_operator_password.Text

SELECT employee.operator_code  
  INTO :szOperatorCode
  FROM employee
 WHERE employee.password = :szOperatorPassword   ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( "Error", "Invalid Operator Password!", StopSign! )
Else
	sle_operator_code.Text = szOperatorCode
	iw_Parent.TriggerEvent ( "undo" )
End if
end on

type st_1 from statictext within u_operator_password
int X=18
int Y=16
int Width=1006
int Height=80
boolean Enabled=false
string Text="Please Enter Operator Password:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
long BorderColor=128
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within u_operator_password
int Width=1042
int Height=448
int TabOrder=30
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


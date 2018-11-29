$PBExportHeader$w_std_operator_password.srw
forward
global type w_std_operator_password from Window
end type
type cb_3 from commandbutton within w_std_operator_password
end type
type cb_2 from commandbutton within w_std_operator_password
end type
type sle_2 from singlelineedit within w_std_operator_password
end type
type sle_1 from singlelineedit within w_std_operator_password
end type
type st_2 from statictext within w_std_operator_password
end type
type st_1 from statictext within w_std_operator_password
end type
type cb_1 from commandbutton within w_std_operator_password
end type
end forward

global type w_std_operator_password from Window
int X=673
int Y=265
int Width=1217
int Height=613
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_3 cb_3
cb_2 cb_2
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_1 st_1
cb_1 cb_1
end type
global w_std_operator_password w_std_operator_password

on open;w_std_operator_password.SetFocus ( )
sle_1.SetFocus ( )
end on

on activate;sle_1.SetFocus ( )
end on

on w_std_operator_password.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={ this.cb_3,&
this.cb_2,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.cb_1}
end on

on w_std_operator_password.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_std_operator_password
int X=622
int Y=353
int Width=293
int Height=129
int TabOrder=30
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( w_std_operator_password, '' )
end on

type cb_2 from commandbutton within w_std_operator_password
int X=257
int Y=353
int Width=293
int Height=129
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//  Declare Variables
String szOperator
Int    iCount

//  Initialize Variables
szOperator = ''

//  Check for validity
SELECT employee.operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE employee.password = :sle_1.Text   ;

If szOperator = '' Then
	MessageBox ( "Error", "Invalid Password!", StopSign! )
	Return
End if

//  Show operator code and stall so user can see
sle_2.Text = szOperator

For iCount = 1 to 30000
Next

//  Return operator code
CloseWithReturn ( parent, szOperator )

end on

type sle_2 from singlelineedit within w_std_operator_password
int X=659
int Y=193
int Width=513
int Height=97
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_std_operator_password
int X=659
int Y=65
int Width=293
int Height=97
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;String szOperator

//  Check for validity

SELECT employee.operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE employee.password = :sle_1.Text   ;

sle_2.text	= szOperator


end on

type st_2 from statictext within w_std_operator_password
int X=37
int Y=193
int Width=586
int Height=65
boolean Enabled=false
string Text="Operator Code:"
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

type st_1 from statictext within w_std_operator_password
int X=37
int Y=65
int Width=586
int Height=65
boolean Enabled=false
string Text="Operator Password:"
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

type cb_1 from commandbutton within w_std_operator_password
int Width=1207
int Height=529
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


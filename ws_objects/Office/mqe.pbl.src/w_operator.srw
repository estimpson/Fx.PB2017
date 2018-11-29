$PBExportHeader$w_operator.srw
forward
global type w_operator from Window
end type
type cb_2 from commandbutton within w_operator
end type
type cb_1 from commandbutton within w_operator
end type
type sle_1 from singlelineedit within w_operator
end type
end forward

global type w_operator from Window
int X=997
int Y=696
int Width=923
int Height=528
boolean TitleBar=true
string Title="Enter Operator"
long BackColor=79741120
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
end type
global w_operator w_operator

on deactivate;szReturnedString = ''
Close ( this )
end on

on w_operator.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_1}
end on

on w_operator.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
end on

type cb_2 from commandbutton within w_operator
int X=498
int Y=224
int Width=283
int Height=92
int TabOrder=30
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;szReturnedString = ''
Close ( Parent )
end on

type cb_1 from commandbutton within w_operator
int X=91
int Y=224
int Width=283
int Height=92
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String szOperator

  SELECT employee.operator_code  
    INTO :szOperator  
    FROM employee  
   WHERE employee.password = :sle_1.Text   ;

If SQLCA.SQLCode <> 0 Then
	szReturnedString = ''
Else
	szReturnedString = szOperator
End if

bFinish = True
Close ( Parent )
end on

type sle_1 from singlelineedit within w_operator
int X=73
int Y=64
int Width=731
int Height=128
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


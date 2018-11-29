$PBExportHeader$w_delete_item.srw
forward
global type w_delete_item from Window
end type
type cb_2 from commandbutton within w_delete_item
end type
type cb_1 from commandbutton within w_delete_item
end type
type mle_1 from multilineedit within w_delete_item
end type
type sle_1 from singlelineedit within w_delete_item
end type
end forward

global type w_delete_item from Window
int X=672
int Y=264
int Width=919
int Height=592
boolean TitleBar=true
string Title="Delete"
long BackColor=79741120
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
sle_1 sle_1
end type
global w_delete_item w_delete_item

type variables
Int iRtnCode

String szOperator
end variables

on open;mle_1.SetFocus ( )
end on

on w_delete_item.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.mle_1,&
this.sle_1}
end on

on w_delete_item.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.sle_1)
end on

type cb_2 from commandbutton within w_delete_item
int X=475
int Y=324
int Width=233
int Height=96
int TabOrder=40
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, -1 )
end on

type cb_1 from commandbutton within w_delete_item
int X=169
int Y=320
int Width=233
int Height=96
int TabOrder=30
string Text="&Ok"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;SELECT employee.operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE employee.password = :mle_1.Text   ;

If SQLCA.SQLCode <> 0 Then
	CloseWithReturn ( Parent, -1 )
Else
	CloseWithReturn ( Parent, 0 )
End if
end on

type mle_1 from multilineedit within w_delete_item
int X=41
int Y=32
int Width=805
int Height=128
int TabOrder=10
Alignment Alignment=Center!
boolean Border=false
string Text="Please Enter Operator Password To Delete Item"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_delete_item
int X=183
int Y=192
int Width=512
int Height=96
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


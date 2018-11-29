$PBExportHeader$w_generic_operator_entry.srw
forward
global type w_generic_operator_entry from Window
end type
type cb_2 from commandbutton within w_generic_operator_entry
end type
type cb_1 from commandbutton within w_generic_operator_entry
end type
type st_1 from statictext within w_generic_operator_entry
end type
type sle_1 from singlelineedit within w_generic_operator_entry
end type
end forward

global type w_generic_operator_entry from Window
int X=1056
int Y=484
int Width=681
int Height=360
boolean TitleBar=true
string Title="Enter Operator Password"
long BackColor=76585128
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_1 sle_1
end type
global w_generic_operator_entry w_generic_operator_entry

type variables
Boolean		i_b_ok

end variables

on w_generic_operator_entry.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_1}
end on

on w_generic_operator_entry.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

type cb_2 from commandbutton within w_generic_operator_entry
int X=347
int Y=144
int Width=274
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

event clicked;CloseWithReturn ( Parent, "" )
end event

type cb_1 from commandbutton within w_generic_operator_entry
int X=37
int Y=144
int Width=274
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

event clicked;IF i_b_ok THEN
	CloseWithReturn ( Parent, st_1.Text )
ELSE
	MessageBox ( "Enter Operator Password", "Invalid operator password!", StopSign! )
END IF

end event

type st_1 from statictext within w_generic_operator_entry
int X=329
int Y=16
int Width=311
int Height=96
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_generic_operator_entry
int X=18
int Y=16
int Width=293
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;SELECT	employee.operator_code 
INTO 		:st_1.Text  
FROM 		employee  
WHERE 	employee.password = :sle_1.Text   ;

i_b_ok = ( sqlca.sqlcode = 0 )

end event


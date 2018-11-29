$PBExportHeader$uo_operator.sru
forward
global type uo_operator from UserObject
end type
type dw_operator from datawindow within uo_operator
end type
type cb_3 from commandbutton within uo_operator
end type
type cb_2 from commandbutton within uo_operator
end type
type st_1 from statictext within uo_operator
end type
type cb_1 from commandbutton within uo_operator
end type
end forward

global type uo_operator from UserObject
int Width=1042
int Height=448
long BackColor=12632256
long PictureMaskColor=25166016
long TabBackColor=67108864
dw_operator dw_operator
cb_3 cb_3
cb_2 cb_2
st_1 st_1
cb_1 cb_1
end type
global uo_operator uo_operator

type variables
String	szOperatorCode
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

on constructor;dw_operator.Reset ( )
dw_operator.InsertRow ( 1 )
dw_operator.SetFocus ( )
end on

on uo_operator.create
this.dw_operator=create dw_operator
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.dw_operator,&
this.cb_3,&
this.cb_2,&
this.st_1,&
this.cb_1}
end on

on uo_operator.destroy
destroy(this.dw_operator)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type dw_operator from datawindow within uo_operator
int X=238
int Y=112
int Width=658
int Height=144
int TabOrder=40
string DataObject="d_external_operator"
boolean Border=false
boolean LiveScroll=true
end type

on editchanged;If KeyDown ( keyEnter! ) Or KeyDown ( keyTab! ) Then

	String	szOperatorPassword
	String	szOperatorCode
	String	szColumn

	szColumn = dw_operator.GetColumnName ( )
	
	If szcolumn = "operator_password" Then
	
		szOperatorPassword = dw_operator.GetText ( )
	
		SELECT employee.operator_code
		  INTO :szOperatorCode  
		  FROM employee
		 WHERE employee.password = :szOperatorPassword   ;
		
		If SQLCA.SQLCode = 0 Then
			dw_operator.SetItem ( 1, "operator_code", szOperatorCode )
		Else
			MessageBox ( "Error", "Invalid Operator Password!", StopSign! )
		End if
	
	End if

End if
end on

type cb_3 from commandbutton within uo_operator
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

on clicked;uof_attrib ( False )
end on

type cb_2 from commandbutton within uo_operator
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

szOperatorPassword = dw_operator.GetItemString ( 1, "operator_password" )

SELECT employee.operator_code  
  INTO :szOperatorCode
  FROM employee
 WHERE employee.password = :szOperatorPassword   ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( "Error", "Invalid Operator Password!", StopSign! )
Else
	uof_attrib ( False )
	wTrans[iLastTransInstance].TriggerEvent ( "undo" )
End if
end on

type st_1 from statictext within uo_operator
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

type cb_1 from commandbutton within uo_operator
int Width=1042
int Height=448
int TabOrder=30
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


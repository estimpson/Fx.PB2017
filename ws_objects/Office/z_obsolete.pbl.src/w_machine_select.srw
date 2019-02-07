$PBExportHeader$w_machine_select.srw
$PBExportComments$Machine selection popup
forward
global type w_machine_select from Window
end type
type st_2 from statictext within w_machine_select
end type
type cb_1 from commandbutton within w_machine_select
end type
type st_1 from statictext within w_machine_select
end type
type dw_machine_select from datawindow within w_machine_select
end type
end forward

global type w_machine_select from Window
int X=23
int Y=16
int Width=3200
int Height=1948
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
st_2 st_2
cb_1 cb_1
st_1 st_1
dw_machine_select dw_machine_select
end type
global w_machine_select w_machine_select

type variables
String szMachineNumber
Long nRowNumber

end variables

on open;String szStatus

szStatus = 'R'
szMachineNumber = Message.StringParm

If szMachineNumber <> "" Then
	OpenWithParm ( w_machine, szMachineNumber )
	Close ( This )
	Return
End if

dw_machine_select.settransobject ( sqlca )
dw_machine_select.retrieve ( szStatus )


end on

on w_machine_select.create
this.st_2=create st_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_machine_select=create dw_machine_select
this.Control[]={this.st_2,&
this.cb_1,&
this.st_1,&
this.dw_machine_select}
end on

on w_machine_select.destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_machine_select)
end on

type st_2 from statictext within w_machine_select
int X=731
int Y=1696
int Width=1390
int Height=160
boolean Enabled=false
string Text="Touch Here to Stop"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_machine_select
int X=18
int Y=1664
int Width=2853
int Height=256
int TabOrder=20
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type st_1 from statictext within w_machine_select
int X=18
int Y=12
int Width=2853
int Height=132
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Touch a Machine"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_machine_select from datawindow within w_machine_select
int X=18
int Y=156
int Width=2853
int Height=1492
int TabOrder=10
string DataObject="dw_shop_machine_select"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

on constructor;///////////////////////////////////////////////////////////////////////
////
////  setting datawindow size to parrent window's client size
////
//
//dw_Machine_Select.Width = Parent.WorkSpaceWidth ( ) 
//dw_Machine_Select.Height = Parent.WorkSpaceHeight ( )
//
//
end on

on clicked;Long		ll_Row

ll_Row = This.GetClickedRow ( )

If ll_Row < 1 Then Return

SelectRow ( This, 0, False )
SelectRow ( This, ll_Row, True )

szMachineNumber = This.GetItemstring ( ll_Row, "machine_no" )

OpenWithParm ( w_machine, szMachineNumber )


end on


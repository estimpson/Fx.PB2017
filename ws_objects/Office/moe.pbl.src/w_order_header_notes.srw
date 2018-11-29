$PBExportHeader$w_order_header_notes.srw
forward
global type w_order_header_notes from Window
end type
type cb_2 from commandbutton within w_order_header_notes
end type
type cb_1 from commandbutton within w_order_header_notes
end type
type dw_1 from datawindow within w_order_header_notes
end type
end forward

global type w_order_header_notes from Window
int X=673
int Y=265
int Width=1509
int Height=469
boolean TitleBar=true
string Title="Header Notes"
long BackColor=12632256
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_order_header_notes w_order_header_notes

on open;Long lOrder 

lOrder = Message.DoubleParm

If lOrder > 0 Then
	dw_1.SetTransObject ( sqlca )
	dw_1.Retrieve ( lOrder )
End if
end on

on w_order_header_notes.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_order_header_notes.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_order_header_notes
int X=37
int Y=257
int Width=695
int Height=65
int TabOrder=30
string Text="Enter"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_1.Update ( ) = -1 Then
	MessageBox ( "Error", "Update to notes failed!~r" + SQLCA.SQLErrText, StopSign! )
	RollBack ;
	Return
End if

Commit ;

Close ( parent )
end on

type cb_1 from commandbutton within w_order_header_notes
int X=732
int Y=257
int Width=695
int Height=65
int TabOrder=20
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type dw_1 from datawindow within w_order_header_notes
int X=37
int Y=33
int Width=1390
int Height=193
int TabOrder=10
string DataObject="d_order_header_notes"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type


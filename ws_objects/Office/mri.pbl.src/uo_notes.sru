$PBExportHeader$uo_notes.sru
forward
global type uo_notes from UserObject
end type
type dw_notes from datawindow within uo_notes
end type
type cb_2 from commandbutton within uo_notes
end type
type cb_1 from commandbutton within uo_notes
end type
type cb_back from commandbutton within uo_notes
end type
end forward

global type uo_notes from UserObject
int Width=1025
int Height=545
long BackColor=12632256
dw_notes dw_notes
cb_2 cb_2
cb_1 cb_1
cb_back cb_back
end type
global uo_notes uo_notes

forward prototypes
public subroutine uof_setup (boolean lb_Mode)
end prototypes

public subroutine uof_setup (boolean lb_Mode);If lb_Mode Then
	dw_notes.Reset ( )
	dw_notes.InsertRow ( 1 )
	uo_notes.Show ( )
Else
	uo_notes.Hide ( )
End if
end subroutine

on uo_notes.create
this.dw_notes=create dw_notes
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_back=create cb_back
this.Control[]={ this.dw_notes,&
this.cb_2,&
this.cb_1,&
this.cb_back}
end on

on uo_notes.destroy
destroy(this.dw_notes)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_back)
end on

type dw_notes from datawindow within uo_notes
int X=19
int Y=17
int Width=988
int Height=369
int TabOrder=20
string DataObject="d_notes"
boolean Border=false
boolean LiveScroll=true
end type

type cb_2 from commandbutton within uo_notes
int X=513
int Y=417
int Width=476
int Height=113
int TabOrder=40
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_notes.Reset ( )
uof_setup ( False )
end on

type cb_1 from commandbutton within uo_notes
int X=19
int Y=417
int Width=476
int Height=113
int TabOrder=30
string Text="&Ok"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uof_setup ( True )
end on

type cb_back from commandbutton within uo_notes
int Width=1025
int Height=545
int TabOrder=10
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


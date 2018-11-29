$PBExportHeader$u_note.sru
$PBExportComments$Generic user object for Note.
forward
global type u_note from UserObject
end type
type cb_2 from commandbutton within u_note
end type
type cb_save from commandbutton within u_note
end type
type mle_note from multilineedit within u_note
end type
type st_1 from statictext within u_note
end type
end forward

global type u_note from UserObject
int Width=1582
int Height=881
boolean Border=true
long BackColor=12632256
cb_2 cb_2
cb_save cb_save
mle_note mle_note
st_1 st_1
end type
global u_note u_note

type variables
Window iw_HostWindow
end variables

forward prototypes
public subroutine uf_assign_parent (window aw_HostWindow)
end prototypes

public subroutine uf_assign_parent (window aw_HostWindow);iw_HostWindow	= aw_HostWindow
end subroutine

on u_note.create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.mle_note=create mle_note
this.st_1=create st_1
this.Control[]={ this.cb_2,&
this.cb_save,&
this.mle_note,&
this.st_1}
end on

on u_note.destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.mle_note)
destroy(this.st_1)
end on

type cb_2 from commandbutton within u_note
int X=1171
int Y=689
int Width=247
int Height=109
int TabOrder=30
string Text="E&xit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.PostEvent("ue_close_uo_note")
end on

type cb_save from commandbutton within u_note
int X=878
int Y=689
int Width=247
int Height=109
int TabOrder=20
string Text="&Save"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.PostEvent("ue_save_note")
end on

type mle_note from multilineedit within u_note
int X=19
int Y=97
int Width=1500
int Height=545
int TabOrder=10
Alignment Alignment=Center!
boolean VScrollBar=true
long BackColor=16776960
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_note
int X=622
int Y=17
int Width=247
int Height=73
boolean Enabled=false
string Text="Note"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


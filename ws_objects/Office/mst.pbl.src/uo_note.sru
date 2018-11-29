$PBExportHeader$uo_note.sru
$PBExportComments$generic note user's object
forward
global type uo_note from UserObject
end type
type sle_1 from singlelineedit within uo_note
end type
type cb_exit from commandbutton within uo_note
end type
type cb_save from commandbutton within uo_note
end type
type mle_note from multilineedit within uo_note
end type
end forward

global type uo_note from UserObject
int Width=1194
int Height=797
boolean Border=true
long BackColor=12632256
sle_1 sle_1
cb_exit cb_exit
cb_save cb_save
mle_note mle_note
end type
global uo_note uo_note

type variables
Window wHostWindow
end variables

forward prototypes
public subroutine uf_setup (ref window wWin, string szNote)
end prototypes

public subroutine uf_setup (ref window wWin, string szNote);wHostWindow		= wWin
mle_note.text	= szNote

end subroutine

on uo_note.create
this.sle_1=create sle_1
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.mle_note=create mle_note
this.Control[]={ this.sle_1,&
this.cb_exit,&
this.cb_save,&
this.mle_note}
end on

on uo_note.destroy
destroy(this.sle_1)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.mle_note)
end on

type sle_1 from singlelineedit within uo_note
int Width=1189
int Height=81
int TabOrder=10
boolean Enabled=false
boolean AutoHScroll=false
string Text="              Note"
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Terminal"
FontCharSet FontCharSet=Oem!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type cb_exit from commandbutton within uo_note
int X=860
int Y=657
int Width=257
int Height=109
int TabOrder=40
string Text="E&xit"
int TextSize=-10
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

on clicked;wHostWindow.TriggerEvent("close_uo_note")
end on

type cb_save from commandbutton within uo_note
int X=531
int Y=657
int Width=257
int Height=109
int TabOrder=30
string Text="&Save"
int TextSize=-10
int Weight=700
string FaceName="System"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wHostWindow.TriggerEvent("save_note")
end on

type mle_note from multilineedit within uo_note
int Y=81
int Width=1189
int Height=545
int TabOrder=20
boolean VScrollBar=true
int Limit=254
long TextColor=33554432
long BackColor=16776960
int TextSize=-10
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type


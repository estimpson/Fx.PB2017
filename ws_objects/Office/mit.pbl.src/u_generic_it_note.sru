$PBExportHeader$u_generic_it_note.sru
forward
global type u_generic_it_note from UserObject
end type
type cb_2 from commandbutton within u_generic_it_note
end type
type cb_save from commandbutton within u_generic_it_note
end type
type mle_note from multilineedit within u_generic_it_note
end type
type st_1 from statictext within u_generic_it_note
end type
type cb_background from commandbutton within u_generic_it_note
end type
end forward

global type u_generic_it_note from UserObject
int Width=1582
int Height=880
long BackColor=77897888
long PictureMaskColor=25166016
long TabBackColor=67108864
cb_2 cb_2
cb_save cb_save
mle_note mle_note
st_1 st_1
cb_background cb_background
end type
global u_generic_it_note u_generic_it_note

type variables
Window iw_HostWindow
end variables

forward prototypes
public subroutine uf_assign_parent (window aw_HostWindow)
end prototypes

public subroutine uf_assign_parent (window aw_HostWindow);iw_HostWindow	= aw_HostWindow
end subroutine

on constructor;iw_HostWindow	= Parent
IF Not IsNull ( Message.StringParm ) THEN
	mle_note.Text = Message.StringParm
ELSE
	mle_note.Text = ''
END IF

mle_note.SetFocus ( )
end on

on u_generic_it_note.create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.mle_note=create mle_note
this.st_1=create st_1
this.cb_background=create cb_background
this.Control[]={this.cb_2,&
this.cb_save,&
this.mle_note,&
this.st_1,&
this.cb_background}
end on

on u_generic_it_note.destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.mle_note)
destroy(this.st_1)
destroy(this.cb_background)
end on

type cb_2 from commandbutton within u_generic_it_note
int X=823
int Y=688
int Width=247
int Height=108
int TabOrder=40
string Text="E&xit"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iw_HostWindow.PostEvent("ue_close_uo_note")
end on

type cb_save from commandbutton within u_generic_it_note
int X=549
int Y=688
int Width=247
int Height=108
int TabOrder=30
string Text="&Save"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iw_HostWindow.PostEvent("ue_save_note")
end on

type mle_note from multilineedit within u_generic_it_note
int X=37
int Y=96
int Width=1499
int Height=544
int TabOrder=20
boolean VScrollBar=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_generic_it_note
int X=658
int Y=16
int Width=247
int Height=72
boolean Enabled=false
string Text="Note"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_background from commandbutton within u_generic_it_note
int Width=1573
int Height=864
int TabOrder=10
boolean Enabled=false
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


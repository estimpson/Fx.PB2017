$PBExportHeader$u_generic_note.sru
forward
global type u_generic_note from UserObject
end type
type cb_2 from commandbutton within u_generic_note
end type
type cb_save from commandbutton within u_generic_note
end type
type mle_note from multilineedit within u_generic_note
end type
type st_1 from statictext within u_generic_note
end type
end forward

global type u_generic_note from UserObject
int Width=1582
int Height=832
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
cb_2 cb_2
cb_save cb_save
mle_note mle_note
st_1 st_1
end type
global u_generic_note u_generic_note

type variables
Window iw_HostWindow
end variables

forward prototypes
public subroutine uf_assign_parent (window aw_HostWindow)
end prototypes

public subroutine uf_assign_parent (window aw_HostWindow);iw_HostWindow	= aw_HostWindow
end subroutine

event constructor;string ls_datatype

Long   ll_width, &
		 ll_pos1, &
		 ll_pos2

iw_HostWindow	= Parent

// changes to allow user to enter the notes for limited value as in db.  - mb 06/24/99
ls_datatype = message.stringparm

// get the width of the column and set the limit to that
if PosA ( ls_datatype, 'char' , 1 ) > 0 then
	ll_pos1 = PosA ( ls_datatype, "(", 1 )
	ll_pos2 = PosA ( ls_Datatype, ")" , 1 )
	ll_width = Long ( MidA ( ls_datatype,  ll_pos1 + 1,  ll_pos2 - ( ll_pos1 + 1 ) ) )
	mle_note.limit  = ll_width
end if

mle_note.setfocus()
end event

on u_generic_note.create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.mle_note=create mle_note
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_save,&
this.mle_note,&
this.st_1}
end on

on u_generic_note.destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.mle_note)
destroy(this.st_1)
end on

type cb_2 from commandbutton within u_generic_note
int X=1170
int Y=688
int Width=247
int Height=100
int TabOrder=30
string Text="E&xit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iw_HostWindow.PostEvent("ue_close_uo_note")
end on

type cb_save from commandbutton within u_generic_note
int X=878
int Y=688
int Width=247
int Height=100
int TabOrder=20
string Text="&Save"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iw_HostWindow.PostEvent("ue_save_note")
end on

type mle_note from multilineedit within u_generic_note
int X=14
int Y=96
int Width=1499
int Height=544
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_generic_note
int X=622
int Y=16
int Width=247
int Height=72
boolean Enabled=false
string Text="Note"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


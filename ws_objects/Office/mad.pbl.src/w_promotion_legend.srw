$PBExportHeader$w_promotion_legend.srw
forward
global type w_promotion_legend from Window
end type
type st_4 from statictext within w_promotion_legend
end type
type sle_4 from singlelineedit within w_promotion_legend
end type
type cb_1 from commandbutton within w_promotion_legend
end type
type st_3 from statictext within w_promotion_legend
end type
type st_2 from statictext within w_promotion_legend
end type
type st_1 from statictext within w_promotion_legend
end type
type sle_3 from singlelineedit within w_promotion_legend
end type
type sle_2 from singlelineedit within w_promotion_legend
end type
type sle_1 from singlelineedit within w_promotion_legend
end type
type ln_1 from line within w_promotion_legend
end type
type ln_2 from line within w_promotion_legend
end type
end forward

global type w_promotion_legend from Window
int X=1006
int Y=580
int Width=914
int Height=812
boolean TitleBar=true
string Title="Promotion Legend"
long BackColor=79741120
boolean ControlMenu=true
boolean Resizable=true
st_4 st_4
sle_4 sle_4
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
ln_1 ln_1
ln_2 ln_2
end type
global w_promotion_legend w_promotion_legend

on w_promotion_legend.create
this.st_4=create st_4
this.sle_4=create sle_4
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.st_4,&
this.sle_4,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.ln_1,&
this.ln_2}
end on

on w_promotion_legend.destroy
destroy(this.st_4)
destroy(this.sle_4)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type st_4 from statictext within w_promotion_legend
int X=165
int Y=424
int Width=421
int Height=52
boolean Enabled=false
string Text="= No Promotion"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within w_promotion_legend
int X=55
int Y=424
int Width=87
int Height=76
int TabOrder=30
boolean Enabled=false
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_promotion_legend
int X=512
int Y=596
int Width=343
int Height=92
int TabOrder=50
string Text="E&xit"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( w_promotion_legend )
end on

type st_3 from statictext within w_promotion_legend
int X=160
int Y=304
int Width=421
int Height=52
boolean Enabled=false
string Text="= Active Promotion"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_promotion_legend
int X=160
int Y=176
int Width=686
int Height=52
boolean Enabled=false
string Text="= Promotion Expires Tomorrow"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_promotion_legend
int X=160
int Y=48
int Width=594
int Height=52
boolean Enabled=false
string Text="= Promotion Expires Today"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_promotion_legend
int X=55
int Y=296
int Width=87
int Height=76
int TabOrder=40
boolean Enabled=false
boolean AutoHScroll=false
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_promotion_legend
int X=55
int Y=168
int Width=87
int Height=76
int TabOrder=20
boolean Enabled=false
boolean AutoHScroll=false
long BackColor=65535
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_promotion_legend
int X=55
int Y=40
int Width=87
int Height=76
int TabOrder=10
boolean Enabled=false
boolean AutoHScroll=false
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_1 from line within w_promotion_legend
boolean Enabled=false
int BeginX=18
int BeginY=556
int EndX=859
int EndY=556
int LineThickness=4
end type

type ln_2 from line within w_promotion_legend
boolean Enabled=false
int BeginX=18
int BeginY=560
int EndX=859
int EndY=560
int LineThickness=4
long LineColor=16777215
end type


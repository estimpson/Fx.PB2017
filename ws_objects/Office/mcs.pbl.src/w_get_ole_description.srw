$PBExportHeader$w_get_ole_description.srw
forward
global type w_get_ole_description from Window
end type
type cb_1 from commandbutton within w_get_ole_description
end type
type cb_2 from commandbutton within w_get_ole_description
end type
type mle_1 from multilineedit within w_get_ole_description
end type
end forward

global type w_get_ole_description from Window
int X=823
int Y=360
int Width=1125
int Height=624
boolean TitleBar=true
string Title="Enter a description for this document:"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
cb_2 cb_2
mle_1 mle_1
end type
global w_get_ole_description w_get_ole_description

on w_get_ole_description.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.mle_1=create mle_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.mle_1}
end on

on w_get_ole_description.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.mle_1)
end on

type cb_1 from commandbutton within w_get_ole_description
int X=329
int Y=384
int Width=279
int Height=108
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

event clicked;CloseWithReturn ( Parent, '' )
end event

type cb_2 from commandbutton within w_get_ole_description
int X=18
int Y=384
int Width=279
int Height=108
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

event clicked;CloseWithReturn ( Parent, mle_1.text )
end event

type mle_1 from multilineedit within w_get_ole_description
int X=18
int Y=16
int Width=1042
int Height=336
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AutoVScroll=true
int Limit=255
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


$PBExportHeader$w_bom_display_date.srw
forward
global type w_bom_display_date from Window
end type
type cb_2 from commandbutton within w_bom_display_date
end type
type st_1 from statictext within w_bom_display_date
end type
type cb_1 from commandbutton within w_bom_display_date
end type
type em_1 from editmask within w_bom_display_date
end type
end forward

global type w_bom_display_date from Window
int X=1074
int Y=484
int Width=809
int Height=608
boolean TitleBar=true
string Title="Router Maintenance"
long BackColor=79741120
WindowType WindowType=response!
cb_2 cb_2
st_1 st_1
cb_1 cb_1
em_1 em_1
end type
global w_bom_display_date w_bom_display_date

on w_bom_display_date.create
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.em_1=create em_1
this.Control[]={this.cb_2,&
this.st_1,&
this.cb_1,&
this.em_1}
end on

on w_bom_display_date.destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.em_1)
end on

event open;String l_s_temp
l_s_temp = Message.StringParm
em_1.Text = l_s_temp
end event

type cb_2 from commandbutton within w_bom_display_date
int X=384
int Y=320
int Width=192
int Height=88
int TabOrder=3
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, "" )
end event

type st_1 from statictext within w_bom_display_date
int X=137
int Y=64
int Width=421
int Height=80
boolean Enabled=false
string Text="Enter Date:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_bom_display_date
int X=137
int Y=320
int Width=192
int Height=88
int TabOrder=20
string Text="&Ok"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, em_1.Text )
end event

type em_1 from editmask within w_bom_display_date
int X=137
int Y=176
int Width=439
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateTimeMask!
boolean Spin=true
string DisplayData=""
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


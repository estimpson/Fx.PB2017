$PBExportHeader$w_message.srw
forward
global type w_message from Window
end type
type st_1 from statictext within w_message
end type
end forward

global type w_message from Window
int X=745
int Y=732
int Width=1431
int Height=460
boolean Enabled=false
boolean TitleBar=true
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
end type
global w_message w_message

on open;st_1.Text = Message.StringParm
end on

on w_message.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_message.destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_message
int X=23
int Y=44
int Width=1353
int Height=272
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


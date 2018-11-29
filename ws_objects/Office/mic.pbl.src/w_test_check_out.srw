$PBExportHeader$w_test_check_out.srw
forward
global type w_test_check_out from Window
end type
type st_1 from statictext within w_test_check_out
end type
end forward

global type w_test_check_out from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
end type
global w_test_check_out w_test_check_out

on w_test_check_out.create
this.st_1=create st_1
this.Control[]={ this.st_1}
end on

on w_test_check_out.destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_test_check_out
int X=257
int Y=97
int Width=247
int Height=73
boolean Enabled=false
string Text="asdfasdf"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


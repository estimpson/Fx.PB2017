$PBExportHeader$w_ini_path.srw
forward
global type w_ini_path from Window
end type
type st_path from statictext within w_ini_path
end type
type lb_1 from listbox within w_ini_path
end type
end forward

global type w_ini_path from Window
int X=673
int Y=265
int Width=1582
int Height=989
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_path st_path
lb_1 lb_1
end type
global w_ini_path w_ini_path

on w_ini_path.create
this.st_path=create st_path
this.lb_1=create lb_1
this.Control[]={ this.st_path,&
this.lb_1}
end on

on w_ini_path.destroy
destroy(this.st_path)
destroy(this.lb_1)
end on

type st_path from statictext within w_ini_path
int X=1098
int Y=81
int Width=247
int Height=73
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_1 from listbox within w_ini_path
int X=330
int Y=145
int Width=494
int Height=361
int TabOrder=1
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


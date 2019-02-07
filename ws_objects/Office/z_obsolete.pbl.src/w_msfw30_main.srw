$PBExportHeader$w_msfw30_main.srw
forward
global type w_msfw30_main from Window
end type
type st_5 from statictext within w_msfw30_main
end type
type st_4 from statictext within w_msfw30_main
end type
type st_3 from statictext within w_msfw30_main
end type
type st_2 from statictext within w_msfw30_main
end type
type st_1 from statictext within w_msfw30_main
end type
type cb_1 from commandbutton within w_msfw30_main
end type
type cb_2 from commandbutton within w_msfw30_main
end type
end forward

global type w_msfw30_main from Window
int X=41
int Y=24
int Width=2953
int Height=1924
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_msfw30_main w_msfw30_main

type variables
String is_Machine
end variables

on w_msfw30_main.create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.Control[]={this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.cb_2}
end on

on w_msfw30_main.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type st_5 from statictext within w_msfw30_main
int X=238
int Y=1696
int Width=2377
int Height=160
boolean Enabled=false
string Text="Touch Here to Stop"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=77897888
int TextSize=-26
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_msfw30_main
int X=73
int Y=1120
int Width=2706
int Height=160
boolean Enabled=false
string Text="Touch Screen to Start"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=32768
long BackColor=77897888
int TextSize=-26
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_msfw30_main
int X=265
int Y=840
int Width=2523
int Height=160
boolean Enabled=false
string Text="Manufacturing Cell Production Control "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-26
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_msfw30_main
int X=183
int Y=192
int Width=2377
int Height=256
boolean Enabled=false
string Text="The Monitor"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-26
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_msfw30_main
int X=256
int Y=512
int Width=2377
int Height=160
boolean Enabled=false
string Text="Shop Floor Execution "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-26
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_msfw30_main
int Y=1664
int Width=2926
int Height=256
int TabOrder=20
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_2 from commandbutton within w_msfw30_main
int Width=2926
int Height=1664
int TabOrder=10
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Open ( w_machine_select )

end on


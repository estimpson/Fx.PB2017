$PBExportHeader$w_labor_maintenance.srw
forward
global type w_labor_maintenance from Window
end type
type cb_4 from commandbutton within w_labor_maintenance
end type
type st_2 from statictext within w_labor_maintenance
end type
type st_1 from statictext within w_labor_maintenance
end type
type cb_1 from commandbutton within w_labor_maintenance
end type
type dw_2 from datawindow within w_labor_maintenance
end type
type dw_1 from datawindow within w_labor_maintenance
end type
end forward

global type w_labor_maintenance from Window
int X=0
int Y=0
int Width=3634
int Height=2380
boolean TitleBar=true
string Title="Labor Maintenance"
long BackColor=77897888
WindowState WindowState=maximized!
cb_4 cb_4
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_labor_maintenance w_labor_maintenance

type variables
string		i_s_workorder
st_laborhrs                    stlbrhrs
end variables

event open;//i_s_workorder = Message.StringParm
stlbrhrs = Message.Powerobjectparm
i_s_workorder = stlbrhrs.workorder
dw_1.Retrieve ( i_s_workorder )
dw_2.Retrieve ( i_s_workorder )
end event

on w_labor_maintenance.create
this.cb_4=create cb_4
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_labor_maintenance.destroy
destroy(this.cb_4)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type cb_4 from commandbutton within w_labor_maintenance
int X=658
int Y=1600
int Width=475
int Height=192
int TabOrder=30
string Text="Exit"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type st_2 from statictext within w_labor_maintenance
int X=37
int Y=640
int Width=2871
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Labor History For Workorder"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_labor_maintenance
int X=37
int Y=16
int Width=2871
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Operators Currently Logged Into Workorder"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_labor_maintenance
int X=37
int Y=1600
int Width=475
int Height=192
int TabOrder=40
string Text="Log In / Out"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//OpenWithParm ( w_workorder_touch_loginout, i_s_workorder )
OpenWithParm ( w_workorder_touch_loginout, stlbrhrs )
if Message.DoubleParm = 1 then
	dw_1.Retrieve ( i_s_workorder )
	dw_2.Retrieve ( i_s_workorder )
end if
end event

type dw_2 from datawindow within w_labor_maintenance
int X=37
int Y=720
int Width=3163
int Height=864
int TabOrder=20
string DataObject="d_workorder_logged_history"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on constructor;SetTransObject ( sqlca )
end on

type dw_1 from datawindow within w_labor_maintenance
int X=37
int Y=96
int Width=2871
int Height=512
int TabOrder=10
string DataObject="d_workorder_logged_in"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

on constructor;SetTransObject ( sqlca )
end on


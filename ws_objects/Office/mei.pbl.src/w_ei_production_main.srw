$PBExportHeader$w_ei_production_main.srw
$PBExportComments$updated on 5/20
forward
global type w_ei_production_main from Window
end type
type rb_9 from radiobutton within w_ei_production_main
end type
type rb_8 from radiobutton within w_ei_production_main
end type
type rb_7 from radiobutton within w_ei_production_main
end type
type rb_6 from radiobutton within w_ei_production_main
end type
type rb_5 from radiobutton within w_ei_production_main
end type
type rb_4 from radiobutton within w_ei_production_main
end type
type rb_3 from radiobutton within w_ei_production_main
end type
type rb_2 from radiobutton within w_ei_production_main
end type
type rb_1 from radiobutton within w_ei_production_main
end type
type cb_1 from commandbutton within w_ei_production_main
end type
type gb_1 from groupbox within w_ei_production_main
end type
type p_1 from picture within w_ei_production_main
end type
type dw_1 from datawindow within w_ei_production_main
end type
end forward

global type w_ei_production_main from Window
int X=1
int Y=5
int Width=2885
int Height=1857
boolean TitleBar=true
string Title="Production"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_9 rb_9
rb_8 rb_8
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
gb_1 gb_1
p_1 p_1
dw_1 dw_1
end type
global w_ei_production_main w_ei_production_main

on w_ei_production_main.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_9=create rb_9
this.rb_8=create rb_8
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.p_1=create p_1
this.dw_1=create dw_1
this.Control[]={ this.rb_9,&
this.rb_8,&
this.rb_7,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.gb_1,&
this.p_1,&
this.dw_1}
end on

on w_ei_production_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_9)
destroy(this.rb_8)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.p_1)
destroy(this.dw_1)
end on

type rb_9 from radiobutton within w_ei_production_main
int X=78
int Y=1553
int Width=499
int Height=77
string Text="Statistics"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;p_1.visible = false
end event

type rb_8 from radiobutton within w_ei_production_main
int X=919
int Y=1513
int Width=426
int Height=77
string Text="Late "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_production_wo_late"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_7 from radiobutton within w_ei_production_main
int X=919
int Y=1433
int Width=426
int Height=77
string Text="Overruns"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_production_overrun"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_6 from radiobutton within w_ei_production_main
int X=919
int Y=1353
int Width=426
int Height=77
string Text="Shortages"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_5 from radiobutton within w_ei_production_main
int X=1486
int Y=1353
int Width=796
int Height=77
string Text="Today's Schedule"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_production_wo_today"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_4 from radiobutton within w_ei_production_main
int X=78
int Y=1453
int Width=522
int Height=77
string Text="Throughput"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_production_main
int X=78
int Y=1353
int Width=682
int Height=77
string Text="Today's Production"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open (w_ei_production_2)
p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_production_main
int X=1486
int Y=1513
int Width=796
int Height=77
string Text="Production MTD"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_production_day_trend"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_production_main
int X=1486
int Y=1433
int Width=796
int Height=77
string Text="Production Total by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_production_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type cb_1 from commandbutton within w_ei_production_main
int X=2369
int Y=1393
int Width=362
int Height=153
int TabOrder=20
string Text="&Exit"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type gb_1 from groupbox within w_ei_production_main
int X=42
int Y=1273
int Width=769
int Height=385
int TabOrder=30
string Text="More..."
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_ei_production_main
int X=28
int Y=25
int Width=2657
int Height=1225
string PictureName="mc.wmf"
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_production_main
int X=19
int Y=17
int Width=2670
int Height=1237
int TabOrder=10
string DataObject="dw_ei_production_part_01"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


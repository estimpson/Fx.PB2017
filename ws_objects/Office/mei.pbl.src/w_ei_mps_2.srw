$PBExportHeader$w_ei_mps_2.srw
forward
global type w_ei_mps_2 from Window
end type
type rb_4 from radiobutton within w_ei_mps_2
end type
type rb_3 from radiobutton within w_ei_mps_2
end type
type rb_2 from radiobutton within w_ei_mps_2
end type
type rb_1 from radiobutton within w_ei_mps_2
end type
type cb_1 from commandbutton within w_ei_mps_2
end type
type p_1 from picture within w_ei_mps_2
end type
type dw_2 from datawindow within w_ei_mps_2
end type
end forward

global type w_ei_mps_2 from Window
int X=37
int Y=29
int Width=2826
int Height=1857
boolean TitleBar=true
string Title="Monitor Schedule"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
p_1 p_1
dw_2 dw_2
end type
global w_ei_mps_2 w_ei_mps_2

on open;
dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )
end on

on w_ei_mps_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_2=create dw_2
this.Control[]={ this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.p_1,&
this.dw_2}
end on

on w_ei_mps_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_2)
end on

type rb_4 from radiobutton within w_ei_mps_2
int X=938
int Y=1585
int Width=892
int Height=73
string Text="Machine Load by Group"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_hard_queue_hours_group"
	dw_2.SetTransObject(sqlca)
	dw_2.Retrieve()
	p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_mps_2
int X=101
int Y=1585
int Width=769
int Height=65
string Text="Setup Time"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_mps_setup_gr_1"
	dw_2.SetTransObject(sqlca)
	dw_2.Retrieve()
	p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_mps_2
int X=938
int Y=1489
int Width=883
int Height=73
string Text="Machine Load by Hours"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;	dw_2.dataObject	= "dw_ei_hard_queue_hours"
	dw_2.SetTransObject(sqlca)
	dw_2.Retrieve()
	p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_mps_2
int X=101
int Y=1489
int Width=769
int Height=65
string Text="Labor Hours Required "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//open (w_mps_capacity)

dw_2.dataObject	= "dw_mps_daily_load_gr"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type cb_1 from commandbutton within w_ei_mps_2
int X=2039
int Y=1481
int Width=467
int Height=153
int TabOrder=20
string Text="&Exit"
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type p_1 from picture within w_ei_mps_2
int X=42
int Y=37
int Width=2711
int Height=1381
string PictureName="sch.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_2 from datawindow within w_ei_mps_2
int X=37
int Y=33
int Width=2725
int Height=1389
int TabOrder=10
string DataObject="dw_ei_hard_queue_hours"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


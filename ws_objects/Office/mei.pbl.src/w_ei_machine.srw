$PBExportHeader$w_ei_machine.srw
$PBExportComments$updated on 5/22
forward
global type w_ei_machine from Window
end type
type rb_6 from radiobutton within w_ei_machine
end type
type rb_5 from radiobutton within w_ei_machine
end type
type rb_4 from radiobutton within w_ei_machine
end type
type rb_3 from radiobutton within w_ei_machine
end type
type rb_2 from radiobutton within w_ei_machine
end type
type rb_1 from radiobutton within w_ei_machine
end type
type cb_2 from commandbutton within w_ei_machine
end type
type cb_1 from commandbutton within w_ei_machine
end type
type p_1 from picture within w_ei_machine
end type
type dw_1 from datawindow within w_ei_machine
end type
end forward

global type w_ei_machine from Window
int X=5
int Y=9
int Width=2890
int Height=1857
boolean TitleBar=true
string Title="Machines"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
p_1 p_1
dw_1 dw_1
end type
global w_ei_machine w_ei_machine

event open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )
//dw_2.settransobject ( sqlca )
//dw_2.Retrieve ( )
//
end event

on w_ei_machine.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_1=create dw_1
this.Control[]={ this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_2,&
this.cb_1,&
this.p_1,&
this.dw_1}
end on

on w_ei_machine.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_1)
end on

type rb_6 from radiobutton within w_ei_machine
int X=1537
int Y=1533
int Width=709
int Height=73
string Text="Today's Downtime"
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_today_downtime"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_5 from radiobutton within w_ei_machine
int X=791
int Y=1537
int Width=714
int Height=65
string Text="Downtime Data Source "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_machine_source_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_4 from radiobutton within w_ei_machine
int X=55
int Y=1537
int Width=709
int Height=65
string Text="Downtime by Machine"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_machine_downtime_%"
//dw_1.dataObject	= "dw_temp"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_machine
int X=1537
int Y=1441
int Width=709
int Height=65
string Text="Downtime by Day"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_machine_trend"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_machine
int X=791
int Y=1437
int Width=695
int Height=65
string Text="Downtime by Operator"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_machine_down_empl"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_machine
int X=55
int Y=1441
int Width=714
int Height=65
string Text="Downtime by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_machine_down_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type cb_2 from commandbutton within w_ei_machine
int X=2318
int Y=1421
int Width=522
int Height=113
int TabOrder=30
string Text="&More..."
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_machine_2)
end on

type cb_1 from commandbutton within w_ei_machine
int X=2318
int Y=1549
int Width=526
int Height=109
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

type p_1 from picture within w_ei_machine
int X=51
int Y=45
int Width=2780
int Height=1357
string PictureName="dn.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_machine
int X=42
int Y=37
int Width=2789
int Height=1369
int TabOrder=10
string DataObject="dw_ei_machine_trend"
boolean TitleBar=true
string Title="Down Time Trend"
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


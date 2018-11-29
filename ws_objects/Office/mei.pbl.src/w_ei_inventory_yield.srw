$PBExportHeader$w_ei_inventory_yield.srw
forward
global type w_ei_inventory_yield from Window
end type
type rb_3 from radiobutton within w_ei_inventory_yield
end type
type rb_2 from radiobutton within w_ei_inventory_yield
end type
type rb_1 from radiobutton within w_ei_inventory_yield
end type
type cb_1 from commandbutton within w_ei_inventory_yield
end type
type p_1 from picture within w_ei_inventory_yield
end type
type dw_1 from datawindow within w_ei_inventory_yield
end type
end forward

global type w_ei_inventory_yield from Window
int X=19
int Y=29
int Width=2885
int Height=1893
boolean TitleBar=true
string Title="Inventory Usage"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
p_1 p_1
dw_1 dw_1
end type
global w_ei_inventory_yield w_ei_inventory_yield

on w_ei_inventory_yield.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_1=create dw_1
this.Control[]={ this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.p_1,&
this.dw_1}
end on

on w_ei_inventory_yield.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_1)
end on

type rb_3 from radiobutton within w_ei_inventory_yield
int X=1518
int Y=1553
int Width=695
int Height=97
string Text="Obsoleted $"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_material_usage_obsolete"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_inventory_yield
int X=773
int Y=1549
int Width=695
int Height=97
string Text="Scrap $"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_material_usage_activity"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_inventory_yield
int X=42
int Y=1553
int Width=695
int Height=97
string Text="Usage by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_material_usage_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type cb_1 from commandbutton within w_ei_inventory_yield
int X=2341
int Y=1549
int Width=467
int Height=125
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

type p_1 from picture within w_ei_inventory_yield
int X=33
int Y=33
int Width=2789
int Height=1493
string PictureName="yi.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_inventory_yield
int X=33
int Y=25
int Width=2789
int Height=1501
int TabOrder=10
string DataObject="dw_ei_material_usage_month"
boolean TitleBar=true
string Title="Material Usage"
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


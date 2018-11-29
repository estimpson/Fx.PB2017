$PBExportHeader$w_ei_inventory.srw
$PBExportComments$updated on 5/22
forward
global type w_ei_inventory from Window
end type
type rb_10 from radiobutton within w_ei_inventory
end type
type rb_9 from radiobutton within w_ei_inventory
end type
type rb_8 from radiobutton within w_ei_inventory
end type
type rb_11 from radiobutton within w_ei_inventory
end type
type rb_6 from radiobutton within w_ei_inventory
end type
type rb_4 from radiobutton within w_ei_inventory
end type
type rb_3 from radiobutton within w_ei_inventory
end type
type rb_2 from radiobutton within w_ei_inventory
end type
type rb_1 from radiobutton within w_ei_inventory
end type
type cb_1 from commandbutton within w_ei_inventory
end type
type p_1 from picture within w_ei_inventory
end type
type dw_2 from datawindow within w_ei_inventory
end type
end forward

global type w_ei_inventory from Window
int X=28
int Y=5
int Width=2894
int Height=1833
boolean TitleBar=true
string Title="Inventory"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_10 rb_10
rb_9 rb_9
rb_8 rb_8
rb_11 rb_11
rb_6 rb_6
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
p_1 p_1
dw_2 dw_2
end type
global w_ei_inventory w_ei_inventory

on w_ei_inventory.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_10=create rb_10
this.rb_9=create rb_9
this.rb_8=create rb_8
this.rb_11=create rb_11
this.rb_6=create rb_6
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_2=create dw_2
this.Control[]={ this.rb_10,&
this.rb_9,&
this.rb_8,&
this.rb_11,&
this.rb_6,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.p_1,&
this.dw_2}
end on

on w_ei_inventory.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_10)
destroy(this.rb_9)
destroy(this.rb_8)
destroy(this.rb_11)
destroy(this.rb_6)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_2)
end on

type rb_10 from radiobutton within w_ei_inventory
event clicked pbm_bnclicked
int X=1921
int Y=1313
int Width=878
int Height=69
string Text="Valuation by Location"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_location_value"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_9 from radiobutton within w_ei_inventory
event clicked pbm_bnclicked
int X=1921
int Y=1389
int Width=878
int Height=77
string Text="Inventory Aging"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_age_value"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_8 from radiobutton within w_ei_inventory
event clicked pbm_bnclicked
int X=974
int Y=1313
int Width=878
int Height=69
string Text="Value by Status"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_value_status"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_11 from radiobutton within w_ei_inventory
event clicked pbm_bnclicked
int X=92
int Y=1313
int Width=654
int Height=69
string Text="Valuation by Part"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_value_part"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_6 from radiobutton within w_ei_inventory
event clicked pbm_bnclicked
int X=92
int Y=1469
int Width=654
int Height=101
string Text="Accuracy Histogram"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_measure_hist_01"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_4 from radiobutton within w_ei_inventory
int X=92
int Y=1389
int Width=654
int Height=77
string Text="Value by Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_value_type_text"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_inventory
int X=92
int Y=1569
int Width=851
int Height=77
string Text="Real Time Inventory Valuation "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_value_type_bar"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false

end event

type rb_2 from radiobutton within w_ei_inventory
int X=974
int Y=1389
int Width=897
int Height=77
string Text="Valuation over 30 Days"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_value_type_bar_30"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_inventory
int X=974
int Y=1469
int Width=897
int Height=101
string Text="Valuation by % (Pie)"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.dataObject	= "dw_ei_inventory_value_type_pie"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
p_1.visible = false
end event

type cb_1 from commandbutton within w_ei_inventory
int X=2227
int Y=1485
int Width=481
int Height=149
int TabOrder=20
string Text="Exit"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type p_1 from picture within w_ei_inventory
int X=92
int Y=37
int Width=2757
int Height=1257
string PictureName="inv.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type dw_2 from datawindow within w_ei_inventory
int X=78
int Y=29
int Width=2757
int Height=1265
int TabOrder=10
string DataObject="dw_ei_inventory_value_type_bar"
boolean TitleBar=true
string Title="Inventory Value...."
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


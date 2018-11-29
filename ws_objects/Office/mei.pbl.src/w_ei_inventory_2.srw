$PBExportHeader$w_ei_inventory_2.srw
forward
global type w_ei_inventory_2 from Window
end type
type mdi_1 from mdiclient within w_ei_inventory_2
end type
type rb_6 from radiobutton within w_ei_inventory_2
end type
type rb_4 from radiobutton within w_ei_inventory_2
end type
type rb_3 from radiobutton within w_ei_inventory_2
end type
type rb_2 from radiobutton within w_ei_inventory_2
end type
type rb_1 from radiobutton within w_ei_inventory_2
end type
type dw_1 from datawindow within w_ei_inventory_2
end type
type cb_1 from commandbutton within w_ei_inventory_2
end type
end forward

global type w_ei_inventory_2 from Window
int X=10
int Y=9
int Width=2949
int Height=1893
boolean TitleBar=true
string Title="Inventory"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
rb_6 rb_6
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
cb_1 cb_1
end type
global w_ei_inventory_2 w_ei_inventory_2

on w_ei_inventory_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.mdi_1=create mdi_1
this.rb_6=create rb_6
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={ this.mdi_1,&
this.rb_6,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.cb_1}
end on

on w_ei_inventory_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.rb_6)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type mdi_1 from mdiclient within w_ei_inventory_2
long BackColor=276856960
end type

type rb_6 from radiobutton within w_ei_inventory_2
event clicked pbm_bnclicked
int X=124
int Y=1549
int Width=654
int Height=101
string Text="Accuracy Histogram"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_inventory_measure_hist_01"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_4 from radiobutton within w_ei_inventory_2
int X=124
int Y=1421
int Width=654
int Height=101
string Text="Valuation by Part"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_inventory_value_part"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_3 from radiobutton within w_ei_inventory_2
int X=1061
int Y=1565
int Width=878
int Height=97
string Text="Value by Status"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_inventory_value_status"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_inventory_2
int X=1061
int Y=1493
int Width=878
int Height=97
string Text="Inventory Aging"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_inventory_age_value"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_1 from radiobutton within w_ei_inventory_2
int X=1061
int Y=1421
int Width=878
int Height=97
string Text="Valuation by Location"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_inventory_location_value"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type dw_1 from datawindow within w_ei_inventory_2
int X=60
int Y=25
int Width=2794
int Height=1389
int TabOrder=10
string DataObject="dw_ei_inventory_value_type_bar"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_inventory_2
int X=2222
int Y=1469
int Width=545
int Height=161
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


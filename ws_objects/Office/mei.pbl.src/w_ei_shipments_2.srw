$PBExportHeader$w_ei_shipments_2.srw
forward
global type w_ei_shipments_2 from Window
end type
type rb_9 from radiobutton within w_ei_shipments_2
end type
type rb_8 from radiobutton within w_ei_shipments_2
end type
type rb_7 from radiobutton within w_ei_shipments_2
end type
type rb_6 from radiobutton within w_ei_shipments_2
end type
type rb_5 from radiobutton within w_ei_shipments_2
end type
type rb_4 from radiobutton within w_ei_shipments_2
end type
type rb_3 from radiobutton within w_ei_shipments_2
end type
type rb_2 from radiobutton within w_ei_shipments_2
end type
type rb_1 from radiobutton within w_ei_shipments_2
end type
type cb_1 from commandbutton within w_ei_shipments_2
end type
type p_1 from picture within w_ei_shipments_2
end type
type dw_1 from datawindow within w_ei_shipments_2
end type
end forward

global type w_ei_shipments_2 from Window
int X=19
int Y=21
int Width=2935
int Height=1869
boolean TitleBar=true
string Title="Shipments"
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
p_1 p_1
dw_1 dw_1
end type
global w_ei_shipments_2 w_ei_shipments_2

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

end on

on w_ei_shipments_2.create
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
this.p_1,&
this.dw_1}
end on

on w_ei_shipments_2.destroy
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
destroy(this.p_1)
destroy(this.dw_1)
end on

type rb_9 from radiobutton within w_ei_shipments_2
int X=1527
int Y=1577
int Width=695
int Height=97
string Text="Late by Customer %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_late_customer_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_8 from radiobutton within w_ei_shipments_2
int X=869
int Y=1577
int Width=586
int Height=97
string Text="Product Line All"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_product_line_all"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_7 from radiobutton within w_ei_shipments_2
int X=174
int Y=1577
int Width=622
int Height=97
string Text="Salesperson All"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_salesman_all"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_6 from radiobutton within w_ei_shipments_2
int X=174
int Y=1389
int Width=622
int Height=97
string Text="Salesperson %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_salesman_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_5 from radiobutton within w_ei_shipments_2
int X=174
int Y=1481
int Width=622
int Height=97
string Text="Salesperson $"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_salesman_$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_4 from radiobutton within w_ei_shipments_2
int X=869
int Y=1481
int Width=586
int Height=97
string Text="Product Line $"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_product_line_$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_shipments_2
int X=869
int Y=1385
int Width=586
int Height=97
string Text="Product Line %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_product_line_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_shipments_2
int X=1527
int Y=1481
int Width=695
int Height=97
string Text="Shipments by Week"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_line"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_shipments_2
int X=1527
int Y=1385
int Width=695
int Height=97
string Text="Shipments by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_line_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type cb_1 from commandbutton within w_ei_shipments_2
int X=2410
int Y=1453
int Width=343
int Height=161
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

type p_1 from picture within w_ei_shipments_2
int X=97
int Y=37
int Width=2785
int Height=1345
string PictureName="ship1.wmf"
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_shipments_2
int X=97
int Y=37
int Width=2775
int Height=1345
int TabOrder=10
string DataObject="dw_ei_shipments_line"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type


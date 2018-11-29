$PBExportHeader$w_ei_shipments_3.srw
forward
global type w_ei_shipments_3 from Window
end type
type rb_9 from radiobutton within w_ei_shipments_3
end type
type rb_8 from radiobutton within w_ei_shipments_3
end type
type rb_7 from radiobutton within w_ei_shipments_3
end type
type rb_6 from radiobutton within w_ei_shipments_3
end type
type rb_5 from radiobutton within w_ei_shipments_3
end type
type rb_4 from radiobutton within w_ei_shipments_3
end type
type rb_3 from radiobutton within w_ei_shipments_3
end type
type rb_2 from radiobutton within w_ei_shipments_3
end type
type rb_1 from radiobutton within w_ei_shipments_3
end type
type dw_1 from datawindow within w_ei_shipments_3
end type
type cb_1 from commandbutton within w_ei_shipments_3
end type
end forward

global type w_ei_shipments_3 from Window
int X=10
int Y=21
int Width=2835
int Height=1857
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
dw_1 dw_1
cb_1 cb_1
end type
global w_ei_shipments_3 w_ei_shipments_3

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

end on

on w_ei_shipments_3.create
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
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={ this.rb_9,&
this.rb_8,&
this.rb_7,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.cb_1}
end on

on w_ei_shipments_3.destroy
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
destroy(this.dw_1)
destroy(this.cb_1)
end on

type rb_9 from radiobutton within w_ei_shipments_3
int X=1477
int Y=1529
int Width=691
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_late_customer_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_8 from radiobutton within w_ei_shipments_3
int X=819
int Y=1529
int Width=581
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_product_line_all"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_7 from radiobutton within w_ei_shipments_3
int X=124
int Y=1529
int Width=618
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_salesman_all"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_6 from radiobutton within w_ei_shipments_3
int X=124
int Y=1337
int Width=618
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_salesman_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_5 from radiobutton within w_ei_shipments_3
int X=124
int Y=1433
int Width=618
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_salesman_$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_4 from radiobutton within w_ei_shipments_3
int X=819
int Y=1433
int Width=581
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_product_line_$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_3 from radiobutton within w_ei_shipments_3
int X=819
int Y=1337
int Width=581
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_product_line_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_shipments_3
int X=1477
int Y=1433
int Width=691
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_line"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_1 from radiobutton within w_ei_shipments_3
int X=1477
int Y=1337
int Width=691
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

on clicked;dw_1.dataObject	= "dw_ei_shipments_line_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type dw_1 from datawindow within w_ei_shipments_3
int X=10
int Y=25
int Width=2716
int Height=1313
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

type cb_1 from commandbutton within w_ei_shipments_3
int X=2332
int Y=1397
int Width=426
int Height=121
int TabOrder=20
string Text="&Exit"
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on


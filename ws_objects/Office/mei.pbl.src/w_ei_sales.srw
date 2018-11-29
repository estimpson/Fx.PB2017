$PBExportHeader$w_ei_sales.srw
$PBExportComments$updated 5/23
forward
global type w_ei_sales from Window
end type
type dw_4 from datawindow within w_ei_sales
end type
type dw_2 from datawindow within w_ei_sales
end type
type rb_1 from radiobutton within w_ei_sales
end type
type cb_2 from commandbutton within w_ei_sales
end type
type cb_1 from commandbutton within w_ei_sales
end type
type dw_5 from datawindow within w_ei_sales
end type
type dw_1 from datawindow within w_ei_sales
end type
type dw_3 from datawindow within w_ei_sales
end type
end forward

global type w_ei_sales from Window
int X=19
int Y=21
int Width=2835
int Height=1785
boolean TitleBar=true
string Title="Sales Forecast"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_4 dw_4
dw_2 dw_2
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
dw_5 dw_5
dw_1 dw_1
dw_3 dw_3
end type
global w_ei_sales w_ei_sales

event open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )

dw_4.settransobject ( sqlca )
dw_4.Retrieve ( )

dw_5.settransobject ( sqlca )
dw_5.Retrieve ( )

//dw_4.settransobject ( sqlca )
//dw_4.Retrieve ( )
end event

on w_ei_sales.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.dw_4=create dw_4
this.dw_2=create dw_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_5=create dw_5
this.dw_1=create dw_1
this.dw_3=create dw_3
this.Control[]={ this.dw_4,&
this.dw_2,&
this.rb_1,&
this.cb_2,&
this.cb_1,&
this.dw_5,&
this.dw_1,&
this.dw_3}
end on

on w_ei_sales.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_5)
destroy(this.dw_1)
destroy(this.dw_3)
end on

type dw_4 from datawindow within w_ei_sales
int X=65
int Y=617
int Width=2679
int Height=301
int TabOrder=40
string DataObject="dw_ei_sales_forecast_planning"
boolean Border=false
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_ei_sales
int X=65
int Y=341
int Width=2670
int Height=277
int TabOrder=30
string DataObject="dw_ei_sales_forecast_test"
boolean Border=false
boolean LiveScroll=true
end type

type rb_1 from radiobutton within w_ei_sales
int X=142
int Y=1481
int Width=892
int Height=73
string Text="Shipment by week"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_3.dataObject	= "dw_ei_shipments_line"
dw_3.SetTransObject(sqlca)
dw_3.Retrieve()
dw_1.visible = false
dw_2.visible = false
dw_4.visible = false
dw_5.visible = false
end event

type cb_2 from commandbutton within w_ei_sales
int X=1509
int Y=1461
int Width=513
int Height=113
int TabOrder=60
string Text="More..."
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_sales_2)
end on

type cb_1 from commandbutton within w_ei_sales
int X=2058
int Y=1405
int Width=659
int Height=177
int TabOrder=50
string Text="&Exit"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_5 from datawindow within w_ei_sales
int X=65
int Y=913
int Width=2679
int Height=465
int TabOrder=32
string DataObject="dw_ei_sales_forecast_forecast"
boolean Border=false
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_ei_sales
int X=65
int Y=57
int Width=2675
int Height=285
int TabOrder=20
string DataObject="dw_ei_ship_total_ytd"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

type dw_3 from datawindow within w_ei_sales
int X=51
int Y=49
int Width=2698
int Height=1333
int TabOrder=10
string DataObject="dw_ei_shipments_line"
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


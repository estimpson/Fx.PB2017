$PBExportHeader$w_ei_cash_flow.srw
forward
global type w_ei_cash_flow from Window
end type
type rb_2 from radiobutton within w_ei_cash_flow
end type
type rb_1 from radiobutton within w_ei_cash_flow
end type
type cb_1 from commandbutton within w_ei_cash_flow
end type
type dw_2 from datawindow within w_ei_cash_flow
end type
type dw_1 from datawindow within w_ei_cash_flow
end type
end forward

global type w_ei_cash_flow from Window
int X=19
int Y=21
int Width=2903
int Height=1717
boolean TitleBar=true
string Title="Cash Flow"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_ei_cash_flow w_ei_cash_flow

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )
dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )

end on

on w_ei_cash_flow.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={ this.rb_2,&
this.rb_1,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_ei_cash_flow.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type rb_2 from radiobutton within w_ei_cash_flow
int X=508
int Y=1473
int Width=695
int Height=65
string Text="Cash Req. by Week"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_po_cash_req_line"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

dw_2.dataObject	= "dw_ei_sales_forecast_bar"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()

end on

type rb_1 from radiobutton within w_ei_cash_flow
int X=1386
int Y=1473
int Width=695
int Height=65
string Text="Cash Req. by Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_po_cash_req_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

dw_2.dataObject	= "dw_ei_sales_forecast_month"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()

end on

type cb_1 from commandbutton within w_ei_cash_flow
int X=2291
int Y=1429
int Width=513
int Height=161
int TabOrder=30
string Text="&Exit"
boolean Cancel=true
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_2 from datawindow within w_ei_cash_flow
int X=28
int Y=969
int Width=2821
int Height=433
int TabOrder=20
string DataObject="dw_ei_sales_forecast_bar"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_ei_cash_flow
int X=37
int Y=33
int Width=3530
int Height=929
int TabOrder=10
string DataObject="dw_ei_po_cash_req_line"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type


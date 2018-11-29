$PBExportHeader$w_ei_sales_2.srw
$PBExportComments$updated 5/23
forward
global type w_ei_sales_2 from Window
end type
type p_1 from picture within w_ei_sales_2
end type
type st_2 from statictext within w_ei_sales_2
end type
type st_1 from statictext within w_ei_sales_2
end type
type rb_11 from radiobutton within w_ei_sales_2
end type
type rb_10 from radiobutton within w_ei_sales_2
end type
type rb_9 from radiobutton within w_ei_sales_2
end type
type rb_8 from radiobutton within w_ei_sales_2
end type
type rb_7 from radiobutton within w_ei_sales_2
end type
type rb_6 from radiobutton within w_ei_sales_2
end type
type rb_5 from radiobutton within w_ei_sales_2
end type
type rb_4 from radiobutton within w_ei_sales_2
end type
type rb_3 from radiobutton within w_ei_sales_2
end type
type rb_2 from radiobutton within w_ei_sales_2
end type
type rb_1 from radiobutton within w_ei_sales_2
end type
type dw_1 from datawindow within w_ei_sales_2
end type
type cb_1 from commandbutton within w_ei_sales_2
end type
end forward

global type w_ei_sales_2 from Window
int X=10
int Y=5
int Width=2853
int Height=1813
boolean TitleBar=true
string Title="Sales Forecast"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
p_1 p_1
st_2 st_2
st_1 st_1
rb_11 rb_11
rb_10 rb_10
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
global w_ei_sales_2 w_ei_sales_2

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

end on

on w_ei_sales_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.p_1=create p_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_11=create rb_11
this.rb_10=create rb_10
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
this.Control[]={ this.p_1,&
this.st_2,&
this.st_1,&
this.rb_11,&
this.rb_10,&
this.rb_9,&
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

on w_ei_sales_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_11)
destroy(this.rb_10)
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

type p_1 from picture within w_ei_sales_2
int X=42
int Y=41
int Width=2753
int Height=1285
string PictureName="fo.wmf"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type st_2 from statictext within w_ei_sales_2
int X=1884
int Y=1345
int Width=375
int Height=73
boolean Enabled=false
string Text="By week No."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ei_sales_2
int X=1303
int Y=1349
int Width=403
int Height=73
boolean Enabled=false
string Text="By month No."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_11 from radiobutton within w_ei_sales_2
int X=1884
int Y=1529
int Width=325
int Height=73
string Text="Bar chart"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_sales_forecast_bar1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

type rb_10 from radiobutton within w_ei_sales_2
int X=1303
int Y=1529
int Width=357
int Height=73
string Text="Area chart"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_sales_forecast_month1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

type rb_9 from radiobutton within w_ei_sales_2
int X=46
int Y=1549
int Width=476
int Height=65
string Text="By Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_type"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
end on

type rb_8 from radiobutton within w_ei_sales_2
int X=577
int Y=1489
int Width=485
int Height=65
string Text="Model Year %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_sales_forecast_model_year%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

type rb_7 from radiobutton within w_ei_sales_2
int X=46
int Y=1485
int Width=503
int Height=65
string Text="By Customer %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_customer_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_6 from radiobutton within w_ei_sales_2
int X=46
int Y=1413
int Width=503
int Height=65
string Text="By Salesman %"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_salesman_%"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_5 from radiobutton within w_ei_sales_2
int X=577
int Y=1349
int Width=485
int Height=65
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

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_product_line_$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_4 from radiobutton within w_ei_sales_2
int X=46
int Y=1345
int Width=531
int Height=65
string Text="By Salesman $"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_salesman_$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_3 from radiobutton within w_ei_sales_2
int X=1884
int Y=1441
int Width=385
int Height=65
string Text="Area chart"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_bar"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_sales_2
int X=1303
int Y=1441
int Width=385
int Height=61
string Text="Bar chart"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_1 from radiobutton within w_ei_sales_2
int X=577
int Y=1417
int Width=485
int Height=65
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

on clicked;dw_1.dataObject	= "dw_ei_sales_forecast_product_line"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type dw_1 from datawindow within w_ei_sales_2
int X=33
int Y=33
int Width=2766
int Height=1297
int TabOrder=10
string DataObject="dw_ei_sales_forecast_bar"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_sales_2
int X=2382
int Y=1465
int Width=403
int Height=141
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


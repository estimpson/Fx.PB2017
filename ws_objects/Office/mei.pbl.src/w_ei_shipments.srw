$PBExportHeader$w_ei_shipments.srw
forward
global type w_ei_shipments from Window
end type
type st_4 from statictext within w_ei_shipments
end type
type st_3 from statictext within w_ei_shipments
end type
type st_2 from statictext within w_ei_shipments
end type
type st_1 from statictext within w_ei_shipments
end type
type rb_8 from radiobutton within w_ei_shipments
end type
type rb_6 from radiobutton within w_ei_shipments
end type
type rb_5 from radiobutton within w_ei_shipments
end type
type rb_10 from radiobutton within w_ei_shipments
end type
type rb_7 from radiobutton within w_ei_shipments
end type
type rb_2 from radiobutton within w_ei_shipments
end type
type rb_1 from radiobutton within w_ei_shipments
end type
type rb_4 from radiobutton within w_ei_shipments
end type
type rb_3 from radiobutton within w_ei_shipments
end type
type cb_2 from commandbutton within w_ei_shipments
end type
type cb_1 from commandbutton within w_ei_shipments
end type
type p_1 from picture within w_ei_shipments
end type
type dw_1 from datawindow within w_ei_shipments
end type
end forward

global type w_ei_shipments from Window
int X=10
int Y=29
int Width=2931
int Height=1813
boolean TitleBar=true
string Title="Shipments"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
rb_8 rb_8
rb_6 rb_6
rb_5 rb_5
rb_10 rb_10
rb_7 rb_7
rb_2 rb_2
rb_1 rb_1
rb_4 rb_4
rb_3 rb_3
cb_2 cb_2
cb_1 cb_1
p_1 p_1
dw_1 dw_1
end type
global w_ei_shipments w_ei_shipments

on w_ei_shipments.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rb_8=create rb_8
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_10=create rb_10
this.rb_7=create rb_7
this.rb_2=create rb_2
this.rb_1=create rb_1
this.rb_4=create rb_4
this.rb_3=create rb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_1=create p_1
this.dw_1=create dw_1
this.Control[]={ this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.rb_8,&
this.rb_6,&
this.rb_5,&
this.rb_10,&
this.rb_7,&
this.rb_2,&
this.rb_1,&
this.rb_4,&
this.rb_3,&
this.cb_2,&
this.cb_1,&
this.p_1,&
this.dw_1}
end on

on w_ei_shipments.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_8)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_10)
destroy(this.rb_7)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.dw_1)
end on

type st_4 from statictext within w_ei_shipments
int X=1779
int Y=1261
int Width=458
int Height=73
boolean Enabled=false
string Text="Late shipments..."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_ei_shipments
int X=106
int Y=1329
int Width=526
int Height=73
boolean Enabled=false
string Text="Today's Schedule"
Alignment Alignment=Right!
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

type st_2 from statictext within w_ei_shipments
int X=1779
int Y=1469
int Width=289
int Height=73
boolean Enabled=false
string Text="By month..."
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ei_shipments
int X=1779
int Y=1329
int Width=275
int Height=65
boolean Enabled=false
string Text="By week..."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_8 from radiobutton within w_ei_shipments
int X=2131
int Y=1465
int Width=325
int Height=73
string Text="Area type"
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_late_month1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_6 from radiobutton within w_ei_shipments
int X=2131
int Y=1397
int Width=325
int Height=57
string Text="Bar type"
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_late_week1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_5 from radiobutton within w_ei_shipments
int X=1116
int Y=1289
int Width=645
int Height=77
string Text="Today's Shipments $"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_today$"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_10 from radiobutton within w_ei_shipments
int X=618
int Y=1421
int Width=316
int Height=101
string Text="By Part"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_todayPart"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_7 from radiobutton within w_ei_shipments
int X=106
int Y=1421
int Width=398
int Height=101
string Text="Scheduled "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_today"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_2 from radiobutton within w_ei_shipments
int X=1116
int Y=1497
int Width=645
int Height=77
string Text="Customer $ XTab"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_ship_customer_xtab"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_1 from radiobutton within w_ei_shipments
int X=1116
int Y=1389
int Width=540
int Height=77
string Text="Product YTD"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_ship_part_dollars"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_4 from radiobutton within w_ei_shipments
int X=2131
int Y=1529
int Width=325
int Height=77
string Text="Bar Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_late_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type rb_3 from radiobutton within w_ei_shipments
int X=2131
int Y=1329
int Width=325
int Height=65
string Text="Area Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_shipments_late_week"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
p_1.visible = false
end event

type cb_2 from commandbutton within w_ei_shipments
int X=2506
int Y=1293
int Width=362
int Height=125
int TabOrder=30
string Text="More..."
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_shipments_2)
end on

type cb_1 from commandbutton within w_ei_shipments
int X=2524
int Y=1457
int Width=334
int Height=125
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

type p_1 from picture within w_ei_shipments
int X=55
int Y=33
int Width=2803
int Height=1205
string PictureName="ship.wmf"
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_ei_shipments
int X=55
int Y=25
int Width=2807
int Height=1221
int TabOrder=10
string DataObject="dw_ei_ship_customer_xtab"
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


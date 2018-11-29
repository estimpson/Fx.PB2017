$PBExportHeader$w_ei_activity_main.srw
$PBExportComments$updated on 5/23
forward
global type w_ei_activity_main from Window
end type
type mdi_1 from mdiclient within w_ei_activity_main
end type
type st_1 from statictext within w_ei_activity_main
end type
type cb_2 from commandbutton within w_ei_activity_main
end type
type rb_3 from radiobutton within w_ei_activity_main
end type
type rb_2 from radiobutton within w_ei_activity_main
end type
type rb_1 from radiobutton within w_ei_activity_main
end type
type dw_1 from datawindow within w_ei_activity_main
end type
type cb_1 from commandbutton within w_ei_activity_main
end type
end forward

global type w_ei_activity_main from Window
int X=19
int Y=29
int Width=2903
int Height=1861
boolean TitleBar=true
string Title="Activity Analysis"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
st_1 st_1
cb_2 cb_2
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
cb_1 cb_1
end type
global w_ei_activity_main w_ei_activity_main

on w_ei_activity_main.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.mdi_1=create mdi_1
this.st_1=create st_1
this.cb_2=create cb_2
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={ this.mdi_1,&
this.st_1,&
this.cb_2,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.cb_1}
end on

on w_ei_activity_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type mdi_1 from mdiclient within w_ei_activity_main
long BackColor=276856960
end type

type st_1 from statictext within w_ei_activity_main
int X=1377
int Y=1333
int Width=1445
int Height=97
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="  Please allow  1 to 6 minutes for retreving the options."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_ei_activity_main
int X=1377
int Y=1445
int Width=705
int Height=133
int TabOrder=30
string Text="More..."
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_activity_analysis)
end on

type rb_3 from radiobutton within w_ei_activity_main
int X=202
int Y=1517
int Width=1134
int Height=97
string Text="Inventory Transactions by Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_activity_trans_type"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_2 from radiobutton within w_ei_activity_main
int X=202
int Y=1421
int Width=1134
int Height=97
string Text="Inventory Transactions per Activity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_activity_trans_activity"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_1 from radiobutton within w_ei_activity_main
int X=202
int Y=1325
int Width=1134
int Height=97
string Text="Inventory Transactions per Month"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_activity_trans_month"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type dw_1 from datawindow within w_ei_activity_main
int X=42
int Y=29
int Width=2798
int Height=1281
int TabOrder=10
string DataObject="dw_ei_material_usage_month"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_activity_main
int X=2108
int Y=1441
int Width=705
int Height=133
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


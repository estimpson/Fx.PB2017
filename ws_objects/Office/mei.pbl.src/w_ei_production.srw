$PBExportHeader$w_ei_production.srw
forward
global type w_ei_production from Window
end type
type dw_3 from datawindow within w_ei_production
end type
type dw_2 from datawindow within w_ei_production
end type
type cb_1 from commandbutton within w_ei_production
end type
type dw_1 from datawindow within w_ei_production
end type
end forward

global type w_ei_production from Window
int X=37
int Y=21
int Width=2853
int Height=1797
boolean TitleBar=true
string Title="Throughput Prevention"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_3 dw_3
dw_2 dw_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_production w_ei_production

type variables
String szPart
end variables

event open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )
dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )
dw_3.settransobject ( sqlca )
dw_3.Retrieve ( )
end event

on w_ei_production.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.dw_3,&
this.dw_2,&
this.cb_1,&
this.dw_1}
end on

on w_ei_production.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type dw_3 from datawindow within w_ei_production
int X=37
int Y=33
int Width=2684
int Height=477
int TabOrder=30
string DataObject="dw_ei_production_month"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_ei_production
int X=37
int Y=537
int Width=2689
int Height=473
int TabOrder=20
string DataObject="dw_ei_defect_month"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_production
int X=2167
int Y=1477
int Width=549
int Height=129
int TabOrder=40
string Text="Exit"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_1 from datawindow within w_ei_production
int X=42
int Y=1017
int Width=2679
int Height=449
int TabOrder=10
string DataObject="dw_ei_downtime_month"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type


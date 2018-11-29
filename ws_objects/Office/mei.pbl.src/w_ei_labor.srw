$PBExportHeader$w_ei_labor.srw
$PBExportComments$updated on 5/20
forward
global type w_ei_labor from Window
end type
type dw_3 from datawindow within w_ei_labor
end type
type cb_1 from commandbutton within w_ei_labor
end type
end forward

global type w_ei_labor from Window
int X=19
int Y=29
int Width=2835
int Height=1757
boolean TitleBar=true
string Title="Labor"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_3 dw_3
cb_1 cb_1
end type
global w_ei_labor w_ei_labor

type variables
Integer iSerial
end variables

on open;//dw_1.settransobject ( sqlca )
//dw_1.Retrieve ( )
//
//dw_2.settransobject ( sqlca )
//dw_2.Retrieve ( )
//
dw_3.settransobject ( sqlca )
dw_3.Retrieve ( )
end on

on w_ei_labor.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.dw_3=create dw_3
this.cb_1=create cb_1
this.Control[]={ this.dw_3,&
this.cb_1}
end on

on w_ei_labor.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.cb_1)
end on

type dw_3 from datawindow within w_ei_labor
int X=37
int Y=33
int Width=2734
int Height=1265
int TabOrder=10
string DataObject="dw_ei_labor_activity_hours"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_labor
int X=2099
int Y=1365
int Width=659
int Height=161
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


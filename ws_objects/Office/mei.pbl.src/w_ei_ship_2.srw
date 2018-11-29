$PBExportHeader$w_ei_ship_2.srw
forward
global type w_ei_ship_2 from Window
end type
type dw_1 from datawindow within w_ei_ship_2
end type
end forward

global type w_ei_ship_2 from Window
int X=69
int Y=89
int Width=2716
int Height=1649
boolean TitleBar=true
string Title="Untitled"
string MenuName="m_menu_frame"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_ei_ship_2 w_ei_ship_2

on w_ei_ship_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_ei_ship_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_ei_ship_2
int X=74
int Y=65
int Width=2419
int Height=1045
int TabOrder=1
string DataObject="dw_ei_ship_xt_cust"
boolean HScrollBar=true
boolean LiveScroll=true
end type


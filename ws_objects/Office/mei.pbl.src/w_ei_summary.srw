$PBExportHeader$w_ei_summary.srw
forward
global type w_ei_summary from Window
end type
type dw_2 from datawindow within w_ei_summary
end type
type cb_1 from commandbutton within w_ei_summary
end type
end forward

global type w_ei_summary from Window
int X=28
int Y=29
int Width=2867
int Height=1829
boolean TitleBar=true
string Title="Monitor Executive Summary"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_2 dw_2
cb_1 cb_1
end type
global w_ei_summary w_ei_summary

event open;dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )
end event

on w_ei_summary.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.dw_2=create dw_2
this.cb_1=create cb_1
this.Control[]={ this.dw_2,&
this.cb_1}
end on

on w_ei_summary.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_1)
end on

type dw_2 from datawindow within w_ei_summary
int X=60
int Y=33
int Width=2090
int Height=1317
int TabOrder=10
string DataObject="d_as"
boolean TitleBar=true
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_summary
int X=2853
int Y=1953
int Width=622
int Height=193
int TabOrder=20
string Text="&Exit"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on


$PBExportHeader$w_ei_activity_analysis.srw
$PBExportComments$updated on 5/23
forward
global type w_ei_activity_analysis from Window
end type
type mdi_1 from mdiclient within w_ei_activity_analysis
end type
type cb_3 from commandbutton within w_ei_activity_analysis
end type
type cb_2 from commandbutton within w_ei_activity_analysis
end type
type cb_1 from commandbutton within w_ei_activity_analysis
end type
type dw_3 from datawindow within w_ei_activity_analysis
end type
type dw_2 from datawindow within w_ei_activity_analysis
end type
end forward

global type w_ei_activity_analysis from Window
int X=28
int Y=17
int Width=3690
int Height=2405
boolean TitleBar=true
string Title="Activity Based Costing Analysis"
string MenuName="m_user_defined_menu"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
end type
global w_ei_activity_analysis w_ei_activity_analysis

on open;dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )
dw_3.settransobject ( sqlca )
dw_3.Retrieve ( )
end on

on w_ei_activity_analysis.create
if this.MenuName = "m_user_defined_menu" then this.MenuID = create m_user_defined_menu
this.mdi_1=create mdi_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={ this.mdi_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_3,&
this.dw_2}
end on

on w_ei_activity_analysis.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

type mdi_1 from mdiclient within w_ei_activity_analysis
long BackColor=276856960
end type

type cb_3 from commandbutton within w_ei_activity_analysis
int X=1847
int Y=1985
int Width=439
int Height=161
int TabOrder=50
string Text="Part"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_ei_activity_analysis
int X=2433
int Y=1985
int Width=439
int Height=161
int TabOrder=40
string Text="C.P.T."
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_activity_analysis_2)
end on

type cb_1 from commandbutton within w_ei_activity_analysis
int X=3018
int Y=1985
int Width=439
int Height=161
int TabOrder=30
string Text="&Exit"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_3 from datawindow within w_ei_activity_analysis
int X=1463
int Y=33
int Width=2085
int Height=1921
int TabOrder=20
string DataObject="dw_ei_activity_pie_2"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_ei_activity_analysis
int X=42
int Y=33
int Width=1390
int Height=1921
int TabOrder=10
string DataObject="dw_ei_activity_pie_1"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type


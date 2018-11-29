$PBExportHeader$w_ei_activity_analysis_2.srw
$PBExportComments$updated on 5/23
forward
global type w_ei_activity_analysis_2 from Window
end type
type cb_1 from commandbutton within w_ei_activity_analysis_2
end type
type dw_1 from datawindow within w_ei_activity_analysis_2
end type
end forward

global type w_ei_activity_analysis_2 from Window
int X=19
int Y=29
int Width=2885
int Height=1861
boolean TitleBar=true
string Title="Activity "
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_activity_analysis_2 w_ei_activity_analysis_2

on open;dw_1.settransobject (sqlca)
dw_1.retrieve ( )
end on

on w_ei_activity_analysis_2.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_ei_activity_analysis_2.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_ei_activity_analysis_2
int X=2341
int Y=1565
int Width=476
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

type dw_1 from datawindow within w_ei_activity_analysis_2
int X=37
int Y=69
int Width=2794
int Height=1481
int TabOrder=10
string DataObject="dw_ei_activity_cpt_calc"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


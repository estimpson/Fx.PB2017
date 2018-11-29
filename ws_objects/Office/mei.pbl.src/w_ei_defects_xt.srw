$PBExportHeader$w_ei_defects_xt.srw
forward
global type w_ei_defects_xt from Window
end type
type cb_1 from commandbutton within w_ei_defects_xt
end type
type dw_1 from datawindow within w_ei_defects_xt
end type
end forward

global type w_ei_defects_xt from Window
int X=5
int Y=9
int Width=2885
int Height=1697
boolean TitleBar=true
string Title="Defects Today"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_defects_xt w_ei_defects_xt

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )


end on

on w_ei_defects_xt.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_ei_defects_xt.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_ei_defects_xt
int X=2209
int Y=1349
int Width=586
int Height=129
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

type dw_1 from datawindow within w_ei_defects_xt
int X=55
int Y=37
int Width=2762
int Height=1285
int TabOrder=10
string DataObject="dw_ei_defect_part_xt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


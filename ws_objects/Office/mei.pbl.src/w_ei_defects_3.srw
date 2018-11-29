$PBExportHeader$w_ei_defects_3.srw
$PBExportComments$updated on 5/22
forward
global type w_ei_defects_3 from Window
end type
type cb_1 from commandbutton within w_ei_defects_3
end type
type dw_1 from datawindow within w_ei_defects_3
end type
end forward

global type w_ei_defects_3 from Window
int X=19
int Y=21
int Width=2743
int Height=1737
boolean TitleBar=true
string Title="Product Defects"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_defects_3 w_ei_defects_3

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )


end on

on w_ei_defects_3.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_ei_defects_3.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_ei_defects_3
int X=2108
int Y=1449
int Width=586
int Height=137
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

type dw_1 from datawindow within w_ei_defects_3
int X=19
int Y=9
int Width=2679
int Height=1413
int TabOrder=10
string DataObject="dw_ei_defect_part_xt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


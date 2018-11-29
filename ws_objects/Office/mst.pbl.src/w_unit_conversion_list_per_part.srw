$PBExportHeader$w_unit_conversion_list_per_part.srw
forward
global type w_unit_conversion_list_per_part from Window
end type
type lb_list from listbox within w_unit_conversion_list_per_part
end type
type dw_1 from datawindow within w_unit_conversion_list_per_part
end type
end forward

global type w_unit_conversion_list_per_part from Window
int X=673
int Y=265
int Width=1715
int Height=877
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=popup!
lb_list lb_list
dw_1 dw_1
end type
global w_unit_conversion_list_per_part w_unit_conversion_list_per_part

on open;dw1 = dw_1

dw_1.SetTransObject ( sqlca )

dw_1.Retrieve ( Message.StringParm )
end on

on w_unit_conversion_list_per_part.create
this.lb_list=create lb_list
this.dw_1=create dw_1
this.Control[]={ this.lb_list,&
this.dw_1}
end on

on w_unit_conversion_list_per_part.destroy
destroy(this.lb_list)
destroy(this.dw_1)
end on

type lb_list from listbox within w_unit_conversion_list_per_part
int X=1061
int Width=476
int Height=769
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_unit_conversion_list_per_part
int Width=1061
int Height=769
int TabOrder=10
string DataObject="d_unit_conversion_list_per_part"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type


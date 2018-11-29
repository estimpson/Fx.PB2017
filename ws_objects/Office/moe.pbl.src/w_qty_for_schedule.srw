$PBExportHeader$w_qty_for_schedule.srw
forward
global type w_qty_for_schedule from Window
end type
type em_1 from editmask within w_qty_for_schedule
end type
type cb_1 from commandbutton within w_qty_for_schedule
end type
end forward

global type w_qty_for_schedule from Window
int X=220
int Y=1145
int Width=869
int Height=525
boolean TitleBar=true
string Title="Enter Qty for Schedule"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=popup!
em_1 em_1
cb_1 cb_1
end type
global w_qty_for_schedule w_qty_for_schedule

on open;em_1.text = String(w_global_shipping_version2.nQty)
end on

on w_qty_for_schedule.create
this.em_1=create em_1
this.cb_1=create cb_1
this.Control[]={ this.em_1,&
this.cb_1}
end on

on w_qty_for_schedule.destroy
destroy(this.em_1)
destroy(this.cb_1)
end on

type em_1 from editmask within w_qty_for_schedule
int X=220
int Y=97
int Width=439
int Height=97
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.00"
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_qty_for_schedule
int X=147
int Y=257
int Width=558
int Height=109
int TabOrder=20
string Text="Start to Schedule"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;w_global_shipping_version2.nQty = dec(em_1.text)
OpenWithParm(w_check_same_destination_version2, w_global_shipping_version2.szDestination)
close(w_qty_for_schedule)
end on


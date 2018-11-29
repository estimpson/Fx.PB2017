$PBExportHeader$w_view_boxes_on_pallet.srw
$PBExportComments$Display all boxes on pallet
forward
global type w_view_boxes_on_pallet from Window
end type
type cb_1 from commandbutton within w_view_boxes_on_pallet
end type
type dw_1 from datawindow within w_view_boxes_on_pallet
end type
end forward

global type w_view_boxes_on_pallet from Window
int X=586
int Y=345
int Width=1724
int Height=1213
boolean TitleBar=true
string Title="Detail Information for Pallet"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=popup!
cb_1 cb_1
dw_1 dw_1
end type
global w_view_boxes_on_pallet w_view_boxes_on_pallet

on deactivate;close(this)
end on

on open;Integer iPalletSerial

dw_1.SetTransObject(sqlca)

iPalletSerial = Message.DoubleParm

dw_1.Title = "Detail Information on Pallet " + String(iPalletSerial)
dw_1.Retrieve(iPalletSerial)


end on

on w_view_boxes_on_pallet.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_view_boxes_on_pallet.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_view_boxes_on_pallet
int X=1281
int Y=961
int Width=247
int Height=109
int TabOrder=20
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(w_view_boxes_on_pallet)
end on

type dw_1 from datawindow within w_view_boxes_on_pallet
int X=110
int Y=129
int Width=1427
int Height=769
int TabOrder=10
string DataObject="dw_view_boxes_on_pallet"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type


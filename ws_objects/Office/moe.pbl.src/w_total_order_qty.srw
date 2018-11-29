$PBExportHeader$w_total_order_qty.srw
forward
global type w_total_order_qty from Window
end type
type cb_2 from commandbutton within w_total_order_qty
end type
type cb_1 from commandbutton within w_total_order_qty
end type
type sle_1 from singlelineedit within w_total_order_qty
end type
end forward

global type w_total_order_qty from Window
int X=673
int Y=265
int Width=851
int Height=469
boolean TitleBar=true
string Title="Total Ordered Quantity"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
end type
global w_total_order_qty w_total_order_qty

on open;Long lOrder

lOrder = Message.DoubleParm

  SELECT order_header.blanket_qty  
    INTO :sle_1.Text  
    FROM order_header  
   WHERE order_header.order_no = :lOrder   ;

end on

on w_total_order_qty.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.sle_1}
end on

on w_total_order_qty.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
end on

type cb_2 from commandbutton within w_total_order_qty
int X=403
int Y=193
int Width=366
int Height=129
int TabOrder=30
string Text="Cancel"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_total_order_qty
int X=37
int Y=193
int Width=366
int Height=129
int TabOrder=20
string Text="Enter"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_total_order_qty
int X=37
int Y=33
int Width=732
int Height=129
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


$PBExportHeader$w_ei_purchasing_1.srw
$PBExportComments$updated on 5/20
forward
global type w_ei_purchasing_1 from Window
end type
type cb_1 from commandbutton within w_ei_purchasing_1
end type
type rb_2 from radiobutton within w_ei_purchasing_1
end type
type rb_1 from radiobutton within w_ei_purchasing_1
end type
type dw_2 from datawindow within w_ei_purchasing_1
end type
type dw_1 from datawindow within w_ei_purchasing_1
end type
end forward

global type w_ei_purchasing_1 from Window
int X=28
int Y=37
int Width=2775
int Height=1845
boolean TitleBar=true
string Title="Purchasing"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_ei_purchasing_1 w_ei_purchasing_1

on w_ei_purchasing_1.create
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.rb_2,&
this.rb_1,&
this.dw_2,&
this.dw_1}
end on

on w_ei_purchasing_1.destroy
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_ei_purchasing_1
int X=2067
int Y=1453
int Width=394
int Height=193
int TabOrder=21
string Text="&Exit"
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (w_ei_purchasing_1)
end event

type rb_2 from radiobutton within w_ei_purchasing_1
int X=1774
int Y=1169
int Width=906
int Height=73
string Text="Vendor - Price Detail"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_po_vendoe_xtab"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()
end event

type rb_1 from radiobutton within w_ei_purchasing_1
int X=1761
int Y=1045
int Width=906
int Height=73
string Text="Part No.- Price Detail"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked; dw_2.dataObject	= "dw_ei_po_part_$_sum"
dw_2.SetTransObject(sqlca)
dw_2.Retrieve()
end event

type dw_2 from datawindow within w_ei_purchasing_1
int X=42
int Y=713
int Width=1646
int Height=985
int TabOrder=20
string DataObject="dw_ei_po_part_$_sum"
boolean TitleBar=true
string Title="PO Text"
BorderStyle BorderStyle=StyleLowered!
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_ei_purchasing_1
int X=46
int Y=21
int Width=2588
int Height=681
int TabOrder=10
string DataObject="dw_ei_po_vendor_xtab"
boolean TitleBar=true
string Title="Vendor Grid"
BorderStyle BorderStyle=StyleLowered!
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


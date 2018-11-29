$PBExportHeader$w_oe_release_history.srw
forward
global type w_oe_release_history from Window
end type
type cb_1 from commandbutton within w_oe_release_history
end type
type dw_1 from datawindow within w_oe_release_history
end type
end forward

global type w_oe_release_history from Window
int X=42
int Y=25
int Width=2812
int Height=1021
boolean TitleBar=true
string Title="Release Trend Graph"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
dw_1 dw_1
end type
global w_oe_release_history w_oe_release_history

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( Message.DoubleParm )
end on

on w_oe_release_history.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.dw_1}
end on

on w_oe_release_history.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_oe_release_history
int X=2414
int Y=801
int Width=321
int Height=97
int TabOrder=20
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)

m_blanket_order.wf_reset_screen()
end on

type dw_1 from datawindow within w_oe_release_history
int X=37
int Y=33
int Width=2707
int Height=737
int TabOrder=10
string DataObject="dw_oe_release_history_gr"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type


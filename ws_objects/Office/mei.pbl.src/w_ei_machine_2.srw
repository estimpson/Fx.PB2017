$PBExportHeader$w_ei_machine_2.srw
forward
global type w_ei_machine_2 from Window
end type
type rb_3 from radiobutton within w_ei_machine_2
end type
type rb_2 from radiobutton within w_ei_machine_2
end type
type rb_1 from radiobutton within w_ei_machine_2
end type
type cb_1 from commandbutton within w_ei_machine_2
end type
type dw_1 from datawindow within w_ei_machine_2
end type
end forward

global type w_ei_machine_2 from Window
int X=5
int Y=5
int Width=2913
int Height=1849
boolean TitleBar=true
string Title="Downtime Machine & Reasons"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_machine_2 w_ei_machine_2

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )
end on

on w_ei_machine_2.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.dw_1}
end on

on w_ei_machine_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type rb_3 from radiobutton within w_ei_machine_2
event clicked pbm_bnclicked
int X=1418
int Y=1521
int Width=823
int Height=85
string Text="By Machine/Reason by%"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.dataObject	= "dw_ei_machine_pie_1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

type rb_2 from radiobutton within w_ei_machine_2
int X=695
int Y=1521
int Width=700
int Height=85
string Text="By Machine/Reason"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_machine_3dbar_1"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type rb_1 from radiobutton within w_ei_machine_2
int X=28
int Y=1517
int Width=659
int Height=81
string Text="Downtime by Shifts"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.dataObject	= "dw_ei_machine_down_shift"
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end on

type cb_1 from commandbutton within w_ei_machine_2
int X=2268
int Y=1497
int Width=549
int Height=141
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

type dw_1 from datawindow within w_ei_machine_2
int X=10
int Y=5
int Width=2844
int Height=1473
int TabOrder=10
string DataObject="dw_ei_machine_3dbar_1"
boolean TitleBar=true
string Title="Dowm Time Reason"
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type


$PBExportHeader$w_ei_production_efficiency.srw
forward
global type w_ei_production_efficiency from Window
end type
type dw_2 from datawindow within w_ei_production_efficiency
end type
type cb_1 from commandbutton within w_ei_production_efficiency
end type
type dw_1 from datawindow within w_ei_production_efficiency
end type
end forward

global type w_ei_production_efficiency from Window
int X=19
int Y=9
int Width=2885
int Height=1757
boolean TitleBar=true
string Title="Defects Today"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
dw_2 dw_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ei_production_efficiency w_ei_production_efficiency

on open;dw_1.settransobject ( sqlca )
dw_1.Retrieve ( )

dw_2.settransobject ( sqlca )
dw_2.Retrieve ( )


end on

on w_ei_production_efficiency.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.dw_2,&
this.cb_1,&
this.dw_1}
end on

on w_ei_production_efficiency.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type dw_2 from datawindow within w_ei_production_efficiency
int X=37
int Y=769
int Width=2355
int Height=777
int TabOrder=20
string DataObject="dw_ei_defects_machine_today"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ei_production_efficiency
int X=2414
int Y=1373
int Width=389
int Height=161
int TabOrder=30
string Text="Exit"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_1 from datawindow within w_ei_production_efficiency
int X=37
int Y=33
int Width=2771
int Height=705
int TabOrder=10
string DataObject="dw_ei_defect_today"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type


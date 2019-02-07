$PBExportHeader$w_msc_mdi_screen.srw
forward
global type w_msc_mdi_screen from Window
end type
type mdi_1 from mdiclient within w_msc_mdi_screen
end type
end forward

global type w_msc_mdi_screen from Window
int X=0
int Y=0
int Width=3657
int Height=2400
boolean TitleBar=true
string MenuName="m_super_cop"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_msc_mdi_screen w_msc_mdi_screen

event open;wMainScreen	= w_msc_mdi_screen
This.title = monsys.title + sqlca.is_Profile
OpenSheet ( w_super_cop, wMainScreen, 3, Layered! )




end event

on w_msc_mdi_screen.create
if this.MenuName = "m_super_cop" then this.MenuID = create m_super_cop
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_msc_mdi_screen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_msc_mdi_screen
long BackColor=275605865
end type


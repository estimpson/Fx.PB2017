$PBExportHeader$w_main_ilop.srw
forward
global type w_main_ilop from Window
end type
type mdi_1 from mdiclient within w_main_ilop
end type
end forward

global type w_main_ilop from Window
int X=0
int Y=0
int Width=3657
int Height=2400
boolean TitleBar=true
string Title="Bill of Material check"
string MenuName="m_main"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_main_ilop w_main_ilop

event open;opensheet ( w_bomcheck, this , 3, Layered!)
end event

on w_main_ilop.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main_ilop.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_main_ilop
long BackColor=268435456
end type


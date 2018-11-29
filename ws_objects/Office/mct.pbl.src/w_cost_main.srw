$PBExportHeader$w_cost_main.srw
forward
global type w_cost_main from Window
end type
type mdi_1 from mdiclient within w_cost_main
end type
end forward

global type w_cost_main from Window
int X=5
int Y=4
int Width=2935
int Height=1920
boolean TitleBar=true
string MenuName="m_menu_frame"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
string Icon="Monitor.ico"
mdi_1 mdi_1
end type
global w_cost_main w_cost_main

on w_cost_main.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_cost_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;

This.Title = monsys.title + sqlca.is_Profile

OpenSheet ( w_part_inquiry_ct, gnv_App.of_GetFrame(), 3, Original! )

end event

type mdi_1 from mdiclient within w_cost_main
long BackColor=275605865
end type


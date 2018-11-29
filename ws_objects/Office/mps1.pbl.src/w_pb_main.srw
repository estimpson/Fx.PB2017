$PBExportHeader$w_pb_main.srw
forward
global type w_pb_main from Window
end type
type mdi_1 from mdiclient within w_pb_main
end type
end forward

global type w_pb_main from Window
int X=9
int Y=4
int Width=3643
int Height=2412
boolean TitleBar=true
string Title="Planning Board"
string MenuName="m_pbmenu"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_exit ( )
mdi_1 mdi_1
end type
global w_pb_main w_pb_main

event ue_exit;if isvalid ( w_planning_board ) then close ( w_planning_board ) 
Close ( this ) 
end event

on w_pb_main.create
if this.MenuName = "m_pbmenu" then this.MenuID = create m_pbmenu
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_pb_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;OpenSheet ( w_planning_board, this, 2, Original! ) 
end event

type mdi_1 from mdiclient within w_pb_main
long BackColor=276856960
end type


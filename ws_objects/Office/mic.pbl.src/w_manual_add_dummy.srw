$PBExportHeader$w_manual_add_dummy.srw
forward
global type w_manual_add_dummy from Window
end type
end forward

global type w_manual_add_dummy from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_manual_add_dummy w_manual_add_dummy

on open;Open ( w_manual_add_object )
Close ( This )

end on

on w_manual_add_dummy.create
end on

on w_manual_add_dummy.destroy
end on


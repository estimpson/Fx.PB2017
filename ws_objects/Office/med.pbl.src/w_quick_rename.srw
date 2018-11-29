$PBExportHeader$w_quick_rename.srw
forward
global type w_quick_rename from Window
end type
end forward

global type w_quick_rename from Window
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
global w_quick_rename w_quick_rename

type prototypes
FUNCTION Boolean QuickRename(string szNothing) LIBRARY "QUICKREN.DLL" alias for "QuickRename;Ansi"
end prototypes

on timer;Close(this)
end on

on open;QuickRename("")
Timer(2)
end on

on w_quick_rename.create
end on

on w_quick_rename.destroy
end on


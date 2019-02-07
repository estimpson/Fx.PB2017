$PBExportHeader$w_base.srw
forward
global type w_base from Window
end type
end forward

global type w_base from Window
int X=832
int Y=360
int Width=1998
int Height=1208
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_base w_base

type variables
Protected:
Window	i_w_mdi_frame

BOOLEAN	i_b_mdi_frame
end variables

on w_base.create
end on

on w_base.destroy
end on

event open;i_w_mdi_frame = ParentWindow ( )
IF IsValid ( i_w_mdi_frame ) THEN
	i_b_mdi_frame = TRUE
END IF
end event


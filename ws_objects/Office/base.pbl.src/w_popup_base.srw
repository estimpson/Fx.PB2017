$PBExportHeader$w_popup_base.srw
forward
global type w_popup_base from w_base
end type
end forward

global type w_popup_base from w_base
WindowType WindowType=popup!
long BackColor=1090519039
boolean MaxBox=false
boolean Resizable=false
end type
global w_popup_base w_popup_base

on w_popup_base.create
call w_base::create
end on

on w_popup_base.destroy
call w_base::destroy
end on


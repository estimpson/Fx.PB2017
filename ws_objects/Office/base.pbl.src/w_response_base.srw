$PBExportHeader$w_response_base.srw
forward
global type w_response_base from w_base
end type
end forward

global type w_response_base from w_base
WindowType WindowType=response!
long BackColor=1090519039
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_response_base w_response_base

on w_response_base.create
call w_base::create
end on

on w_response_base.destroy
call w_base::destroy
end on


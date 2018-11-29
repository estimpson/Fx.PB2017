$PBExportHeader$w_nonvisible_base.srw
forward
global type w_nonvisible_base from w_base
end type
end forward

global type w_nonvisible_base from w_base
boolean Visible=false
long BackColor=1090519039
end type
global w_nonvisible_base w_nonvisible_base

on w_nonvisible_base.create
call super::create
end on

on w_nonvisible_base.destroy
call super::destroy
end on


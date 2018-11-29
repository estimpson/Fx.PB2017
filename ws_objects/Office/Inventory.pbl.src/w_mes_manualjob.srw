$PBExportHeader$w_mes_manualjob.srw
forward
global type w_mes_manualjob from cw_mes_manualjob
end type
end forward

global type w_mes_manualjob from cw_mes_manualjob
integer width = 1161
end type
global w_mes_manualjob w_mes_manualjob

on w_mes_manualjob.create
call super::create
end on

on w_mes_manualjob.destroy
call super::destroy
end on

type cb_cancel from cw_mes_manualjob`cb_cancel within w_mes_manualjob
integer x = 631
end type

type cb_ok from cw_mes_manualjob`cb_ok within w_mes_manualjob
integer x = 142
end type

type dw_edit from cw_mes_manualjob`dw_edit within w_mes_manualjob
integer width = 1061
end type


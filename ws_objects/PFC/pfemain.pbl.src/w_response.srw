$PBExportHeader$w_response.srw
$PBExportComments$Extension Response Window class
forward
global type w_response from pfc_w_response
end type
end forward

global type w_response from pfc_w_response
end type
global w_response w_response

on w_response.create
call super::create
end on

on w_response.destroy
call super::destroy
end on

event open;call super::open;
//	enable base window service.
of_setbase ( true )

//	centering window.
inv_base.of_center ( )
end event


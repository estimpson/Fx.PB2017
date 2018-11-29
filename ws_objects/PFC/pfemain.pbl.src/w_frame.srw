$PBExportHeader$w_frame.srw
$PBExportComments$Extension Frame Window class
forward
global type w_frame from pfc_w_frame
end type
end forward

global type w_frame from pfc_w_frame
end type
global w_frame w_frame

on w_frame.create
call super::create
end on

on w_frame.destroy
call super::destroy
if isvalid(menuid) then destroy(menuid)
end on

event open;call super::open;
//	enable base window service.
of_setbase ( true )

//	centering window.
inv_base.of_center ( )
end event


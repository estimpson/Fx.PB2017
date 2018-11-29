$PBExportHeader$w_sendporeleases_auto.srw
forward
global type w_sendporeleases_auto from w_sendporeleases
end type
end forward

global type w_sendporeleases_auto from w_sendporeleases
integer x = 214
integer y = 221
string title = ""
end type
global w_sendporeleases_auto w_sendporeleases_auto

on w_sendporeleases_auto.create
call super::create
end on

on w_sendporeleases_auto.destroy
call super::destroy
end on

event pfc_preopen;call super::pfc_preopen;
//	Automatically send.
post event notify_email()

end event

type dw_report from w_sendporeleases`dw_report within w_sendporeleases_auto
end type

type dw_emailheader from w_sendporeleases`dw_emailheader within w_sendporeleases_auto
end type


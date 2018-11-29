$PBExportHeader$w_customreport_generic.srw
forward
global type w_customreport_generic from w_customreport
end type
end forward

global type w_customreport_generic from w_customreport
end type
global w_customreport_generic w_customreport_generic

on w_customreport_generic.create
call super::create
end on

on w_customreport_generic.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_report from w_customreport`dw_report within w_customreport_generic
end type

event dw_report::pfc_retrieve;call super::pfc_retrieve;
return retrieve()
end event


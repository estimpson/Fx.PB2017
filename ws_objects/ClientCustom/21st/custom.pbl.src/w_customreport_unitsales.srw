$PBExportHeader$w_customreport_unitsales.srw
forward
global type w_customreport_unitsales from w_customreport_daterange
end type
end forward

global type w_customreport_unitsales from w_customreport_daterange
integer x = 214
integer y = 221
string title = "Unit Sales"
end type
global w_customreport_unitsales w_customreport_unitsales

on w_customreport_unitsales.create
call super::create
end on

on w_customreport_unitsales.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_report from w_customreport_daterange`dw_report within w_customreport_unitsales
string dataobject = "customreport_unitsales_in_date_range"
end type

type st_1 from w_customreport_daterange`st_1 within w_customreport_unitsales
end type

type em_date1 from w_customreport_daterange`em_date1 within w_customreport_unitsales
end type

type p_calendar from w_customreport_daterange`p_calendar within w_customreport_unitsales
end type

type st_2 from w_customreport_daterange`st_2 within w_customreport_unitsales
end type

type em_date2 from w_customreport_daterange`em_date2 within w_customreport_unitsales
end type

type p_1 from w_customreport_daterange`p_1 within w_customreport_unitsales
end type

type cb_retrieve from w_customreport_daterange`cb_retrieve within w_customreport_unitsales
end type


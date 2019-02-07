HA$PBExportHeader$u_panel_leftright2.sru
forward
global type u_panel_leftright2 from u_panel_splitterbase
end type
end forward

global type u_panel_leftright2 from u_panel_splitterbase
end type
global u_panel_leftright2 u_panel_leftright2

on u_panel_leftright2.create
int iCurrent
call super::create
end on

on u_panel_leftright2.destroy
call super::destroy
end on

type uo_2 from u_panel_splitterbase`uo_2 within u_panel_leftright2
end type

type uo_1 from u_panel_splitterbase`uo_1 within u_panel_leftright2
end type

type st_1 from u_panel_splitterbase`st_1 within u_panel_leftright2
end type


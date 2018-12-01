$PBExportHeader$cu_tabpg_jobbom.sru
forward
global type cu_tabpg_jobbom from u_tabpg_jobbom
end type
end forward

global type cu_tabpg_jobbom from u_tabpg_jobbom
end type
global cu_tabpg_jobbom cu_tabpg_jobbom

on cu_tabpg_jobbom.create
call super::create
end on

on cu_tabpg_jobbom.destroy
call super::destroy
end on

type dw_1 from u_tabpg_jobbom`dw_1 within cu_tabpg_jobbom
end type

type gb_1 from u_tabpg_jobbom`gb_1 within cu_tabpg_jobbom
end type

type dw_parent from u_tabpg_jobbom`dw_parent within cu_tabpg_jobbom
end type

type gb_parent from u_tabpg_jobbom`gb_parent within cu_tabpg_jobbom
end type

type cb_substitute from u_tabpg_jobbom`cb_substitute within cu_tabpg_jobbom
end type

type cb_deletesub from u_tabpg_jobbom`cb_deletesub within cu_tabpg_jobbom
end type


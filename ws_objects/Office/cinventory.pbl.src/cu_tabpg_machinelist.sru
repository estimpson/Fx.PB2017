$PBExportHeader$cu_tabpg_machinelist.sru
forward
global type cu_tabpg_machinelist from u_tabpg_machinelist
end type
end forward

global type cu_tabpg_machinelist from u_tabpg_machinelist
end type
global cu_tabpg_machinelist cu_tabpg_machinelist

on cu_tabpg_machinelist.create
call super::create
end on

on cu_tabpg_machinelist.destroy
call super::destroy
end on

type gb_1 from u_tabpg_machinelist`gb_1 within cu_tabpg_machinelist
end type

type dw_1 from u_tabpg_machinelist`dw_1 within cu_tabpg_machinelist
end type


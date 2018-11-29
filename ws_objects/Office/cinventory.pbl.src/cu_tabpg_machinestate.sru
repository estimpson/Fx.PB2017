$PBExportHeader$cu_tabpg_machinestate.sru
forward
global type cu_tabpg_machinestate from u_tabpg_machinestate
end type
end forward

global type cu_tabpg_machinestate from u_tabpg_machinestate
end type
global cu_tabpg_machinestate cu_tabpg_machinestate

on cu_tabpg_machinestate.create
call super::create
end on

on cu_tabpg_machinestate.destroy
call super::destroy
end on

type gb_1 from u_tabpg_machinestate`gb_1 within cu_tabpg_machinestate
end type

type dw_1 from u_tabpg_machinestate`dw_1 within cu_tabpg_machinestate
end type

type dw_partsearch from u_tabpg_machinestate`dw_partsearch within cu_tabpg_machinestate
end type

type st_machines from u_tabpg_machinestate`st_machines within cu_tabpg_machinestate
end type

type cbx_showall from u_tabpg_machinestate`cbx_showall within cu_tabpg_machinestate
end type


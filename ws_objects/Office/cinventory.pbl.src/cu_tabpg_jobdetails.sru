$PBExportHeader$cu_tabpg_jobdetails.sru
forward
global type cu_tabpg_jobdetails from u_tabpg_jobdetails
end type
end forward

global type cu_tabpg_jobdetails from u_tabpg_jobdetails
end type
global cu_tabpg_jobdetails cu_tabpg_jobdetails

on cu_tabpg_jobdetails.create
call super::create
end on

on cu_tabpg_jobdetails.destroy
call super::destroy
end on

type gb_1 from u_tabpg_jobdetails`gb_1 within cu_tabpg_jobdetails
end type

type dw_1 from u_tabpg_jobdetails`dw_1 within cu_tabpg_jobdetails
end type

type cb_generate from u_tabpg_jobdetails`cb_generate within cu_tabpg_jobdetails
end type

type cbx_print from u_tabpg_jobdetails`cbx_print within cu_tabpg_jobdetails
end type


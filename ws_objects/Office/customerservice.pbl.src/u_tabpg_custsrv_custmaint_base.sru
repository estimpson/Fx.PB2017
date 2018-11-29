$PBExportHeader$u_tabpg_custsrv_custmaint_base.sru
forward
global type u_tabpg_custsrv_custmaint_base from u_tabpg_dw
end type
end forward

global type u_tabpg_custsrv_custmaint_base from u_tabpg_dw
integer width = 1977
end type
global u_tabpg_custsrv_custmaint_base u_tabpg_custsrv_custmaint_base

type variables

n_cst_custsrv_custmaint_controller Controller

end variables

on u_tabpg_custsrv_custmaint_base.create
call super::create
end on

on u_tabpg_custsrv_custmaint_base.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_custsrv_custmaint_base
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_custsrv_custmaint_base
end type


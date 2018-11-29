$PBExportHeader$u_base.sru
forward
global type u_base from pfc_u_base
end type
end forward

global type u_base from pfc_u_base
event pfd_event ( string eventname,  n_cst_associative_array eventmessage )
end type
global u_base u_base

on u_base.create
call super::create
end on

on u_base.destroy
call super::destroy
end on


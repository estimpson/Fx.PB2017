$PBExportHeader$n_base.sru
$PBExportComments$Extension NonVisual Base class
forward
global type n_base from pfc_n_base
end type
end forward

global type n_base from pfc_n_base
event pfd_event ( string eventname,  n_cst_associative_array eventmessage )
end type
global n_base n_base

type variables

constant integer 		NOT_IMPLEMENTED = -2

end variables

on n_base.create
call super::create
end on

on n_base.destroy
call super::destroy
end on


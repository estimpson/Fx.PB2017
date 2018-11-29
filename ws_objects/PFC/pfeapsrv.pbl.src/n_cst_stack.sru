$PBExportHeader$n_cst_stack.sru
$PBExportComments$Extension Stack List service
forward
global type n_cst_stack from pfc_n_cst_stack
end type
end forward

global type n_cst_stack from pfc_n_cst_stack
end type
global n_cst_stack n_cst_stack

on n_cst_stack.create
triggerevent( this, "constructor" )
end on

on n_cst_stack.destroy
triggerevent( this, "destructor" )
end on


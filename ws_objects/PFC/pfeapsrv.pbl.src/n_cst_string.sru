$PBExportHeader$n_cst_string.sru
$PBExportComments$Extension String service
forward
global type n_cst_string from pfc_n_cst_string
end type
end forward

global type n_cst_string from pfc_n_cst_string autoinstantiate
end type
global n_cst_string n_cst_string

on n_cst_string.create
triggerevent( this, "constructor" )
end on

on n_cst_string.destroy
triggerevent( this, "destructor" )
end on


$PBExportHeader$n_cst_selection.sru
$PBExportComments$Extension Selection service
forward
global type n_cst_selection from pfc_n_cst_selection
end type
end forward

global type n_cst_selection from pfc_n_cst_selection autoinstantiate
end type
global n_cst_selection n_cst_selection

on n_cst_selection.create
triggerevent( this, "constructor" )
end on

on n_cst_selection.destroy
triggerevent( this, "destructor" )
end on


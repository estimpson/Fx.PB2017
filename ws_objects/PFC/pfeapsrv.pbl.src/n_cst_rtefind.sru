$PBExportHeader$n_cst_rtefind.sru
$PBExportComments$Extension RTE Find/Replace service
forward
global type n_cst_rtefind from pfc_n_cst_rtefind
end type
end forward

global type n_cst_rtefind from pfc_n_cst_rtefind
end type
global n_cst_rtefind n_cst_rtefind

on n_cst_rtefind.create
triggerevent( this, "constructor" )
end on

on n_cst_rtefind.destroy
triggerevent( this, "destructor" )
end on


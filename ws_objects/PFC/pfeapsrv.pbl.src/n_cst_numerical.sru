$PBExportHeader$n_cst_numerical.sru
$PBExportComments$Extension Numerical service
forward
global type n_cst_numerical from pfc_n_cst_numerical
end type
end forward

global type n_cst_numerical from pfc_n_cst_numerical autoinstantiate
end type
global n_cst_numerical n_cst_numerical

on n_cst_numerical.create
triggerevent( this, "constructor" )
end on

on n_cst_numerical.destroy
triggerevent( this, "destructor" )
end on


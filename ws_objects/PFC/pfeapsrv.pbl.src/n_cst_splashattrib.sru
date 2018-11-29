$PBExportHeader$n_cst_splashattrib.sru
$PBExportComments$Extension Splash attributes
forward
global type n_cst_splashattrib from pfc_n_cst_splashattrib
end type
end forward

global type n_cst_splashattrib from pfc_n_cst_splashattrib
end type
global n_cst_splashattrib n_cst_splashattrib

on n_cst_splashattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_splashattrib.destroy
triggerevent( this, "destructor" )
end on


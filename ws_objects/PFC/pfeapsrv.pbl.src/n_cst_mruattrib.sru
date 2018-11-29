$PBExportHeader$n_cst_mruattrib.sru
$PBExportComments$Extension Most Recently Used service attributes
forward
global type n_cst_mruattrib from pfc_n_cst_mruattrib
end type
end forward

global type n_cst_mruattrib from pfc_n_cst_mruattrib
end type
global n_cst_mruattrib n_cst_mruattrib

on n_cst_mruattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_mruattrib.destroy
triggerevent( this, "destructor" )
end on


$PBExportHeader$n_cst_toolbarattrib.sru
$PBExportComments$Extension Toolbar attributes used by the Toolbar window.
forward
global type n_cst_toolbarattrib from pfc_n_cst_toolbarattrib
end type
end forward

global type n_cst_toolbarattrib from pfc_n_cst_toolbarattrib
end type
global n_cst_toolbarattrib n_cst_toolbarattrib

on n_cst_toolbarattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_toolbarattrib.destroy
triggerevent( this, "destructor" )
end on


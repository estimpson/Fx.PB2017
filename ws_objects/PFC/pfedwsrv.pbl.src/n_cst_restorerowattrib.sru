$PBExportHeader$n_cst_restorerowattrib.sru
$PBExportComments$Extension Attributes for DataWindow Undelete Window
forward
global type n_cst_restorerowattrib from pfc_n_cst_restorerowattrib
end type
end forward

global type n_cst_restorerowattrib from pfc_n_cst_restorerowattrib
end type
global n_cst_restorerowattrib n_cst_restorerowattrib

on n_cst_restorerowattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_restorerowattrib.destroy
triggerevent( this, "destructor" )
end on


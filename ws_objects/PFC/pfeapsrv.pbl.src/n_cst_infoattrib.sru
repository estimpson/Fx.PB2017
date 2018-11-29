$PBExportHeader$n_cst_infoattrib.sru
$PBExportComments$Extension Informational attributes
forward
global type n_cst_infoattrib from pfc_n_cst_infoattrib
end type
end forward

global type n_cst_infoattrib from pfc_n_cst_infoattrib
end type
global n_cst_infoattrib n_cst_infoattrib

on n_cst_infoattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_infoattrib.destroy
triggerevent( this, "destructor" )
end on


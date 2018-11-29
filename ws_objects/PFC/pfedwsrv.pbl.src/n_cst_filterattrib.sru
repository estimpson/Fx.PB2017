$PBExportHeader$n_cst_filterattrib.sru
$PBExportComments$Extension Attributes for the DataWindow Filter service
forward
global type n_cst_filterattrib from pfc_n_cst_filterattrib
end type
end forward

global type n_cst_filterattrib from pfc_n_cst_filterattrib
end type
global n_cst_filterattrib n_cst_filterattrib

on n_cst_filterattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_filterattrib.destroy
triggerevent( this, "destructor" )
end on


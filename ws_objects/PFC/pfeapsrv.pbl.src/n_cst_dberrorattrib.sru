$PBExportHeader$n_cst_dberrorattrib.sru
$PBExportComments$Extension dberror attributes
forward
global type n_cst_dberrorattrib from pfc_n_cst_dberrorattrib
end type
end forward

global type n_cst_dberrorattrib from pfc_n_cst_dberrorattrib
end type
global n_cst_dberrorattrib n_cst_dberrorattrib

on n_cst_dberrorattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_dberrorattrib.destroy
triggerevent( this, "destructor" )
end on


$PBExportHeader$n_cst_columnattrib.sru
$PBExportComments$Extension Column attributes
forward
global type n_cst_columnattrib from pfc_n_cst_columnattrib
end type
end forward

global type n_cst_columnattrib from pfc_n_cst_columnattrib
end type
global n_cst_columnattrib n_cst_columnattrib

on n_cst_columnattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_columnattrib.destroy
triggerevent( this, "destructor" )
end on


$PBExportHeader$n_cst_returnattrib.sru
$PBExportComments$Extension Simple return attributes
forward
global type n_cst_returnattrib from pfc_n_cst_returnattrib
end type
end forward

global type n_cst_returnattrib from pfc_n_cst_returnattrib
end type
global n_cst_returnattrib n_cst_returnattrib

on n_cst_returnattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_returnattrib.destroy
triggerevent( this, "destructor" )
end on


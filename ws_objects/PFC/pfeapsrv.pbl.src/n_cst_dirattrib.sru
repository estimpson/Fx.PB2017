$PBExportHeader$n_cst_dirattrib.sru
$PBExportComments$Extension DIR attribus used by the File services
forward
global type n_cst_dirattrib from pfc_n_cst_dirattrib
end type
end forward

global type n_cst_dirattrib from pfc_n_cst_dirattrib
end type
global n_cst_dirattrib n_cst_dirattrib

on n_cst_dirattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_dirattrib.destroy
triggerevent( this, "destructor" )
end on


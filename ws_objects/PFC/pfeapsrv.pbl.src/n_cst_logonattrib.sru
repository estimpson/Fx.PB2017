$PBExportHeader$n_cst_logonattrib.sru
$PBExportComments$Extension Long attributes
forward
global type n_cst_logonattrib from pfc_n_cst_logonattrib
end type
end forward

global type n_cst_logonattrib from pfc_n_cst_logonattrib autoinstantiate
end type
global n_cst_logonattrib n_cst_logonattrib

on n_cst_logonattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_logonattrib.destroy
triggerevent( this, "destructor" )
end on


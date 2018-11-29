$PBExportHeader$n_cst_errorattrib.sru
$PBExportComments$Extension Message (error) attributes
forward
global type n_cst_errorattrib from pfc_n_cst_errorattrib
end type
end forward

global type n_cst_errorattrib from pfc_n_cst_errorattrib autoinstantiate
end type
global n_cst_errorattrib n_cst_errorattrib

on n_cst_errorattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_errorattrib.destroy
triggerevent( this, "destructor" )
end on


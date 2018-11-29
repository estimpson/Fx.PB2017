$PBExportHeader$n_cst_textstyleattrib.sru
$PBExportComments$Extension Text Style attributes
forward
global type n_cst_textstyleattrib from pfc_n_cst_textstyleattrib
end type
end forward

global type n_cst_textstyleattrib from pfc_n_cst_textstyleattrib autoinstantiate
end type
global n_cst_textstyleattrib n_cst_textstyleattrib

on n_cst_textstyleattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_textstyleattrib.destroy
triggerevent( this, "destructor" )
end on


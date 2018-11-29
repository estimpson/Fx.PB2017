$PBExportHeader$n_cst_itemattrib.sru
$PBExportComments$Extension Item attributes
forward
global type n_cst_itemattrib from pfc_n_cst_itemattrib
end type
end forward

global type n_cst_itemattrib from pfc_n_cst_itemattrib
end type
global n_cst_itemattrib n_cst_itemattrib

on n_cst_itemattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_itemattrib.destroy
triggerevent( this, "destructor" )
end on


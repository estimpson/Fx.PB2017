$PBExportHeader$n_cst_linkageattrib.sru
$PBExportComments$Extension Attributes for the Linkage service
forward
global type n_cst_linkageattrib from pfc_n_cst_linkageattrib
end type
end forward

global type n_cst_linkageattrib from pfc_n_cst_linkageattrib
end type
global n_cst_linkageattrib n_cst_linkageattrib

on n_cst_linkageattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_linkageattrib.destroy
triggerevent( this, "destructor" )
end on


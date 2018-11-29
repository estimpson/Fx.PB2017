$PBExportHeader$n_cst_selectionattrib.sru
$PBExportComments$Extension Selection attributes
forward
global type n_cst_selectionattrib from pfc_n_cst_selectionattrib
end type
end forward

global type n_cst_selectionattrib from pfc_n_cst_selectionattrib autoinstantiate
end type
global n_cst_selectionattrib n_cst_selectionattrib

on n_cst_selectionattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_selectionattrib.destroy
triggerevent( this, "destructor" )
end on


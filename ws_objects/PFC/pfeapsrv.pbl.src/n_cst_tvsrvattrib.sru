$PBExportHeader$n_cst_tvsrvattrib.sru
$PBExportComments$Extension TreeView datasource service attributes
forward
global type n_cst_tvsrvattrib from pfc_n_cst_tvsrvattrib
end type
end forward

global type n_cst_tvsrvattrib from pfc_n_cst_tvsrvattrib
end type
global n_cst_tvsrvattrib n_cst_tvsrvattrib

on n_cst_tvsrvattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_tvsrvattrib.destroy
triggerevent( this, "destructor" )
end on


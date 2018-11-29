$PBExportHeader$n_cst_nodecomparebase.sru
$PBExportComments$Extension Node Compare Base class
forward
global type n_cst_nodecomparebase from pfc_n_cst_nodecomparebase
end type
end forward

global type n_cst_nodecomparebase from pfc_n_cst_nodecomparebase
end type
global n_cst_nodecomparebase n_cst_nodecomparebase

on n_cst_nodecomparebase.create
triggerevent( this, "constructor" )
end on

on n_cst_nodecomparebase.destroy
triggerevent( this, "destructor" )
end on


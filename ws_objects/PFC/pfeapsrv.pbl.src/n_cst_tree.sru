$PBExportHeader$n_cst_tree.sru
$PBExportComments$Extension Tree List service
forward
global type n_cst_tree from pfc_n_cst_tree
end type
end forward

global type n_cst_tree from pfc_n_cst_tree
end type
global n_cst_tree n_cst_tree

on n_cst_tree.create
triggerevent( this, "constructor" )
end on

on n_cst_tree.destroy
triggerevent( this, "destructor" )
end on


$PBExportHeader$n_cst_linkedlistbase.sru
$PBExportComments$Extension Linked List Base service
forward
global type n_cst_linkedlistbase from pfc_n_cst_linkedlistbase
end type
end forward

global type n_cst_linkedlistbase from pfc_n_cst_linkedlistbase
end type
global n_cst_linkedlistbase n_cst_linkedlistbase

on n_cst_linkedlistbase.create
triggerevent( this, "constructor" )
end on

on n_cst_linkedlistbase.destroy
triggerevent( this, "destructor" )
end on


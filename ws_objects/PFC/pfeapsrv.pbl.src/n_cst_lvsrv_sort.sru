$PBExportHeader$n_cst_lvsrv_sort.sru
$PBExportComments$Extension ListView Sort service
forward
global type n_cst_lvsrv_sort from pfc_n_cst_lvsrv_sort
end type
end forward

global type n_cst_lvsrv_sort from pfc_n_cst_lvsrv_sort
end type
global n_cst_lvsrv_sort n_cst_lvsrv_sort

on n_cst_lvsrv_sort.create
triggerevent( this, "constructor" )
end on

on n_cst_lvsrv_sort.destroy
triggerevent( this, "destructor" )
end on


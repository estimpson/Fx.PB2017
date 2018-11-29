$PBExportHeader$n_cst_dwsrv_find.sru
$PBExportComments$Extension DataWindow Find/Replace service
forward
global type n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
end forward

global type n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
global n_cst_dwsrv_find n_cst_dwsrv_find

on n_cst_dwsrv_find.create
triggerevent( this, "constructor" )
end on

on n_cst_dwsrv_find.destroy
triggerevent( this, "destructor" )
end on


$PBExportHeader$n_cst_lvsrv.sru
$PBExportComments$Extension ListView Base service
forward
global type n_cst_lvsrv from pfc_n_cst_lvsrv
end type
end forward

global type n_cst_lvsrv from pfc_n_cst_lvsrv
end type
global n_cst_lvsrv n_cst_lvsrv

on n_cst_lvsrv.create
triggerevent( this, "constructor" )
end on

on n_cst_lvsrv.destroy
triggerevent( this, "destructor" )
end on


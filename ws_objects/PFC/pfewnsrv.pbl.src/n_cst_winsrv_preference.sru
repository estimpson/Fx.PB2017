$PBExportHeader$n_cst_winsrv_preference.sru
$PBExportComments$Extension Window Preferences service
forward
global type n_cst_winsrv_preference from pfc_n_cst_winsrv_preference
end type
end forward

global type n_cst_winsrv_preference from pfc_n_cst_winsrv_preference
end type
global n_cst_winsrv_preference n_cst_winsrv_preference

on n_cst_winsrv_preference.create
triggerevent( this, "constructor" )
end on

on n_cst_winsrv_preference.destroy
triggerevent( this, "destructor" )
end on


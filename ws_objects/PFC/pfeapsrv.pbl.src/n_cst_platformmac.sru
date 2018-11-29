$PBExportHeader$n_cst_platformmac.sru
$PBExportComments$Extension Macintosh Cross Platform service
forward
global type n_cst_platformmac from pfc_n_cst_platformmac
end type
end forward

global type n_cst_platformmac from pfc_n_cst_platformmac
end type
global n_cst_platformmac n_cst_platformmac

on n_cst_platformmac.create
triggerevent( this, "constructor" )
end on

on n_cst_platformmac.destroy
triggerevent( this, "destructor" )
end on


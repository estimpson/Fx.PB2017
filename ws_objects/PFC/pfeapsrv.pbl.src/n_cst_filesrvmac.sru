$PBExportHeader$n_cst_filesrvmac.sru
$PBExportComments$Extension Macintosh File handler service
forward
global type n_cst_filesrvmac from pfc_n_cst_filesrvmac
end type
end forward

global type n_cst_filesrvmac from pfc_n_cst_filesrvmac
end type
global n_cst_filesrvmac n_cst_filesrvmac

on n_cst_filesrvmac.create
triggerevent( this, "constructor" )
end on

on n_cst_filesrvmac.destroy
triggerevent( this, "destructor" )
end on


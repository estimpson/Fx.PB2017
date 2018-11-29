$PBExportHeader$n_cst_resize.sru
$PBExportComments$Extension Resize service
forward
global type n_cst_resize from pfc_n_cst_resize
end type
end forward

global type n_cst_resize from pfc_n_cst_resize
end type
global n_cst_resize n_cst_resize

on n_cst_resize.create
triggerevent( this, "constructor" )
end on

on n_cst_resize.destroy
triggerevent( this, "destructor" )
end on


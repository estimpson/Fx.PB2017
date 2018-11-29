$PBExportHeader$n_cst_zoomattrib.sru
$PBExportComments$Extension Attributes for the DataWindow Zoom service
forward
global type n_cst_zoomattrib from pfc_n_cst_zoomattrib
end type
end forward

global type n_cst_zoomattrib from pfc_n_cst_zoomattrib autoinstantiate
end type
global n_cst_zoomattrib n_cst_zoomattrib

on n_cst_zoomattrib.create
triggerevent( this, "constructor" )
end on

on n_cst_zoomattrib.destroy
triggerevent( this, "destructor" )
end on


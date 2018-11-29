$PBExportHeader$n_cst_dwsrv_printpreview.sru
$PBExportComments$Extension DataWindow  PrintPreview service
forward
global type n_cst_dwsrv_printpreview from pfc_n_cst_dwsrv_printpreview
end type
end forward

global type n_cst_dwsrv_printpreview from pfc_n_cst_dwsrv_printpreview
end type
global n_cst_dwsrv_printpreview n_cst_dwsrv_printpreview

on n_cst_dwsrv_printpreview.create
triggerevent( this, "constructor" )
end on

on n_cst_dwsrv_printpreview.destroy
triggerevent( this, "destructor" )
end on


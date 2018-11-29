$PBExportHeader$n_cst_dssrv_report.sru
$PBExportComments$Extension DataStore Reporting service
forward
global type n_cst_dssrv_report from pfc_n_cst_dssrv_report
end type
end forward

global type n_cst_dssrv_report from pfc_n_cst_dssrv_report
end type
global n_cst_dssrv_report n_cst_dssrv_report

on n_cst_dssrv_report.create
triggerevent( this, "constructor" )
end on

on n_cst_dssrv_report.destroy
triggerevent( this, "destructor" )
end on


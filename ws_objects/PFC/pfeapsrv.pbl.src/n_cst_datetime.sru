$PBExportHeader$n_cst_datetime.sru
$PBExportComments$Extension Date and/or Datetime service
forward
global type n_cst_datetime from pfc_n_cst_datetime
end type
end forward

global type n_cst_datetime from pfc_n_cst_datetime autoinstantiate
end type
global n_cst_datetime n_cst_datetime

on n_cst_datetime.create
triggerevent( this, "constructor" )
end on

on n_cst_datetime.destroy
triggerevent( this, "destructor" )
end on


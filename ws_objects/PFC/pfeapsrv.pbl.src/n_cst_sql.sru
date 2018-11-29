$PBExportHeader$n_cst_sql.sru
$PBExportComments$Extension SQL Service service
forward
global type n_cst_sql from pfc_n_cst_sql
end type
end forward

global type n_cst_sql from pfc_n_cst_sql autoinstantiate
end type
global n_cst_sql n_cst_sql

on n_cst_sql.create
triggerevent( this, "constructor" )
end on

on n_cst_sql.destroy
triggerevent( this, "destructor" )
end on


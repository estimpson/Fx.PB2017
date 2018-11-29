$PBExportHeader$n_cst_platformwin16.sru
$PBExportComments$Extension Win16 Cross Platform service
forward
global type n_cst_platformwin16 from pfc_n_cst_platformwin16
end type
end forward

global type n_cst_platformwin16 from pfc_n_cst_platformwin16
end type
global n_cst_platformwin16 n_cst_platformwin16

on n_cst_platformwin16.create
triggerevent( this, "constructor" )
end on

on n_cst_platformwin16.destroy
triggerevent( this, "destructor" )
end on


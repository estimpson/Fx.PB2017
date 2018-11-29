$PBExportHeader$n_cst_menu.sru
$PBExportComments$Extension Menu service
forward
global type n_cst_menu from pfc_n_cst_menu
end type
end forward

global type n_cst_menu from pfc_n_cst_menu
end type
global n_cst_menu n_cst_menu

on n_cst_menu.create
triggerevent( this, "constructor" )
end on

on n_cst_menu.destroy
triggerevent( this, "destructor" )
end on


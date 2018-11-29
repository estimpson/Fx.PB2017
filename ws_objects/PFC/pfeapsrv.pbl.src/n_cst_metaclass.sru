$PBExportHeader$n_cst_metaclass.sru
$PBExportComments$Extension Metaclass service
forward
global type n_cst_metaclass from pfc_n_cst_metaclass
end type
end forward

global type n_cst_metaclass from pfc_n_cst_metaclass
end type
global n_cst_metaclass n_cst_metaclass

on n_cst_metaclass.create
triggerevent( this, "constructor" )
end on

on n_cst_metaclass.destroy
triggerevent( this, "destructor" )
end on


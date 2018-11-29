$PBExportHeader$n_ir.sru
$PBExportComments$Extension InternetResult class
forward
global type n_ir from pfc_n_ir
end type
end forward

global type n_ir from pfc_n_ir
end type
global n_ir n_ir

on n_ir.create
call internetresult::create
triggerevent( this, "constructor" )
end on

on n_ir.destroy
call internetresult::destroy
triggerevent( this, "destructor" )
end on


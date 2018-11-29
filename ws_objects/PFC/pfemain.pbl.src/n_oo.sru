$PBExportHeader$n_oo.sru
$PBExportComments$Extension OLEObject class
forward
global type n_oo from pfc_n_oo
end type
end forward

global type n_oo from pfc_n_oo
end type
global n_oo n_oo

on n_oo.create
call oleobject::create
triggerevent( this, "constructor" )
end on

on n_oo.destroy
call oleobject::destroy
triggerevent( this, "destructor" )
end on


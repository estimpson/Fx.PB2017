$PBExportHeader$n_cst_cache.sru
forward
global type n_cst_cache from nonvisualobject
end type
end forward

global type n_cst_cache from nonvisualobject autoinstantiate
end type

type variables
constant string	USER = "/Application/User"
constant string	OMA = "/Application/ObsoleteMaterialAnalysis"

end variables

on n_cst_cache.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_cache.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


$PBExportHeader$n_cst_anyarray.sru
forward
global type n_cst_anyarray from nonvisualobject
end type
end forward

global type n_cst_anyarray from nonvisualobject autoinstantiate
end type

type variables

Public:

any	ia_Array [ ]

end variables

on n_cst_anyarray.create
TriggerEvent( this, "constructor" )
end on

on n_cst_anyarray.destroy
TriggerEvent( this, "destructor" )
end on


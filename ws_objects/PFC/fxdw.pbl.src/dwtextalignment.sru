$PBExportHeader$dwtextalignment.sru
forward
global type dwtextalignment from nonvisualobject
end type
end forward

shared variables

end variables

global type dwtextalignment from nonvisualobject autoinstantiate
end type

type variables

Public:
constant int LEFTJUSTIFIED  = 0
constant int RIGHTJUSTIFIED  = 1
constant int CENTERJUSTIFIED  = 2

end variables

on dwtextalignment.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dwtextalignment.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


$PBExportHeader$dwborder.sru
forward
global type dwborder from nonvisualobject
end type
end forward

shared variables

end variables

global type dwborder from nonvisualobject autoinstantiate
end type

type variables

Public:
constant int NONE = 0
constant int SHADOW = 1
constant int RECTANGLE = 2
constant int RESIZE = 3
constant int LINE = 4
constant int LOWERED = 5
constant int RAISED = 6

end variables

on dwborder.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dwborder.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


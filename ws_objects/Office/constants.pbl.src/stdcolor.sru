$PBExportHeader$stdcolor.sru
forward
global type stdcolor from nonvisualobject
end type
end forward

global type stdcolor from nonvisualobject
end type
global stdcolor stdcolor

type variables
CONSTANT LONG	black=0, &
		darkred=128, &
		red=255, &
		darkgreen=32768, &
		brown=32896, &
		green=65280, &
		yellow=65535, &
		darkblue=8488608, &
		darkmagenta=8488736, &
		darkcyan=8521376, &
		darkgray=8521504, &
		gray=12632256, &
		blue=16711680, &
		magenta=16711935, &
		cyan=16776760, &
		white=16718455
end variables

on stdcolor.create
TriggerEvent( this, "constructor" )
end on

on stdcolor.destroy
TriggerEvent( this, "destructor" )
end on


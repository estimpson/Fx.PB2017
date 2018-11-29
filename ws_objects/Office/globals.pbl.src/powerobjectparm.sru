$PBExportHeader$powerobjectparm.sru
forward
global type powerobjectparm from nonvisualobject
end type
end forward

global type powerobjectparm from nonvisualobject
end type
global powerobjectparm powerobjectparm

type variables
Public:

any	value [ ]

string	title
end variables

on powerobjectparm.create
TriggerEvent( this, "constructor" )
end on

on powerobjectparm.destroy
TriggerEvent( this, "destructor" )
end on


$PBExportHeader$reg_location.sru
forward
global type reg_location from nonvisualobject
end type
end forward

global type reg_location from nonvisualobject
end type
global reg_location reg_location

type variables
CONSTANT STRING	macro830 = "HKEY_LOCAL_MACHINE\SOFTWARE\Monitor Systems, Inc.\TMFMS\EDI Translation\Outbound\830\MACRO", &
			macro856 = "HKEY_LOCAL_MACHINE\SOFTWARE\Monitor Systems, Inc.\TMFMS\EDI Translation\Outbound\856\MACRO"
end variables

on reg_location.create
TriggerEvent( this, "constructor" )
end on

on reg_location.destroy
TriggerEvent( this, "destructor" )
end on


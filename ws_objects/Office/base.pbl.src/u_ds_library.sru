$PBExportHeader$u_ds_library.sru
forward
global type u_ds_library from datastore
end type
end forward

global type u_ds_library from datastore
end type
global u_ds_library u_ds_library

type variables
Public:

STRING	LibraryObject
end variables

forward prototypes
public function integer create ()
end prototypes

public function integer create ();STRING	l_s_syntax

l_s_syntax = LibraryExport ( LibraryObject, DataObject, ExportDataWindow! )
IF NOT FileExists ( LibraryObject ) THEN
	Return -2
ELSEIF NOT DataObject > "" THEN
	Return -3
ELSEIF NOT l_s_syntax > "" THEN
	Return -4
END IF

Return Create ( l_s_syntax )
end function

on u_ds_library.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_library.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on


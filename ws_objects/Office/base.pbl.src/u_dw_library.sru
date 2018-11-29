$PBExportHeader$u_dw_library.sru
forward
global type u_dw_library from datawindow
end type
end forward

global type u_dw_library from datawindow
int Width=1125
int Height=1140
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type
global u_dw_library u_dw_library

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


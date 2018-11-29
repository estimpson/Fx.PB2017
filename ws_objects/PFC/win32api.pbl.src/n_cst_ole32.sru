$PBExportHeader$n_cst_ole32.sru
forward
global type n_cst_ole32 from nonvisualobject
end type
end forward

global type n_cst_ole32 from nonvisualobject autoinstantiate
end type

type prototypes
Subroutine CoTaskMemFree (ulong lpv) Library "OLE32.DLL"
end prototypes

on n_cst_ole32.create
TriggerEvent( this, "constructor" )
end on

on n_cst_ole32.destroy
TriggerEvent( this, "destructor" )
end on


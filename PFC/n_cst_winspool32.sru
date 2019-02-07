HA$PBExportHeader$n_cst_winspool32.sru
forward
global type n_cst_winspool32 from nonvisualobject
end type
end forward

global type n_cst_winspool32 from nonvisualobject autoinstantiate
end type

type prototypes
Function boolean SetDefaultPrinter(string pszPrinterName) Library "winspool.drv" alias for SetDefaultPrinterW

end prototypes
on n_cst_winspool32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_winspool32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


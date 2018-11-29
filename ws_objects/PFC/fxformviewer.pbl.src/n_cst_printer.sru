$PBExportHeader$n_cst_printer.sru
forward
global type n_cst_printer from n_base
end type
end forward

global type n_cst_printer from n_base
end type
global n_cst_printer n_cst_printer

type variables

end variables

forward prototypes
public function integer of_storedefault ()
public function integer of_restoredefault ()
public function integer of_setprinter (string as_PrinterName)
public function integer of_getprinters (ref string as_Printers [])
public function integer getcurrentprinter (ref string currentprinter)
end prototypes

public function integer of_storedefault ();
//	Ancestor script.
return -1

end function

public function integer of_restoredefault ();
//	Ancestor script.
return -1

end function

public function integer of_setprinter (string as_PrinterName);
//	Ancestor script.
return -1

end function

public function integer of_getprinters (ref string as_Printers []);
//	Ancestor script.
return -1

end function

public function integer getcurrentprinter (ref string currentprinter);
return FAILURE

end function

on n_cst_printer.create
call super::create
end on

on n_cst_printer.destroy
call super::destroy
end on


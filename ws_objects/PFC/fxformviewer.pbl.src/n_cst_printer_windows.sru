$PBExportHeader$n_cst_printer_windows.sru
forward
global type n_cst_printer_windows from n_cst_printer
end type
end forward

global type n_cst_printer_windows from n_cst_printer
end type
global n_cst_printer_windows n_cst_printer_windows

type variables

Private:
string	is_DefaultPrinter
string	is_DefaultDriver
string	is_DefaultPort

end variables

forward prototypes
public function integer of_storedefault ()
public function integer of_RestoreDefault ()
public function integer of_setprinter (string as_NewPrinter)
public function integer of_getprinters (ref string as_Printers [])
public function integer getcurrentprinter (ref string currentprinter)
end prototypes

public function integer of_storedefault ();
//	Store the default printer.
string	ls_Key

RegistryGet ( "HKEY_LOCAL_MACHINE\Config\0001\System\CurrentControlSet\Control\Print\Printers", "default", RegString!, is_DefaultPrinter )
ls_Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers\" + is_DefaultPrinter
RegistryGet ( ls_Key, "Printer Driver", is_DefaultDriver )
RegistryGet ( ls_Key, "Port", is_DefaultPort )

//	Return.
return SUCCESS

end function

public function integer of_RestoreDefault ();
//	Retore the default printer.
SetProfileString ( "c:\windows\win.ini", "Windows", "device", is_DefaultPrinter + "," + is_DefaultDriver + "," + is_DefaultPort )

//	Return.
return SUCCESS

end function

public function integer of_setprinter (string as_NewPrinter);
//	Set the printer.
//	Get the driver and the port for the specified printer.
string	ls_Key
string	ls_NewDriver
string	ls_NewPort

RegistrySet ( "HKEY_LOCAL_MACHINE\Config\0001\System\CurrentControlSet\Control\Print\Printers", "default", RegString!, as_NewPrinter )
ls_Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers\" + as_NewPrinter
RegistryGet ( ls_Key, "Printer Driver", ls_NewDriver )
RegistryGet ( ls_Key, "Port", ls_NewPort )
SetProfileString ( "c:\windows\win.ini", "Windows", "device", as_NewPrinter + "," + ls_NewDriver + "," + ls_NewPort )

//	Return.
return SUCCESS

end function

public function integer of_getprinters (ref string as_Printers []);
//	Get a list of local and network printers on the machine.
return RegistryKeys ( "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers\", as_Printers )

end function

public function integer getcurrentprinter (ref string currentprinter);
return RegistryGet ( "HKEY_LOCAL_MACHINE\Config\0001\System\CurrentControlSet\Control\Print\Printers", "default", RegString!, currentPrinter)

end function

on n_cst_printer_windows.create
call super::create
end on

on n_cst_printer_windows.destroy
call super::destroy
end on


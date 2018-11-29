$PBExportHeader$pfc_n_cst_platformmac.sru
$PBExportComments$PFC Macintosh Cross Platform services
forward
global type pfc_n_cst_platformmac from n_cst_platform
end type
end forward

type os_memorystatus from structure
    unsignedlong ul_length
    unsignedlong ul_memoryload
    unsignedlong ul_totalphys
    unsignedlong ul_availphys
    unsignedlong ul_totalpagefile
    unsignedlong ul_availpagefile
    unsignedlong ul_totalvirtual
    unsignedlong ul_availvirtual
end type

type os_size from structure
    long l_cx
    long l_cy
end type

global type pfc_n_cst_platformmac from n_cst_platform
end type
global pfc_n_cst_platformmac pfc_n_cst_platformmac

type prototypes
// platform calls
function long Getcomputername( ref string name) library "PFCMacPlatformSrv" alias for "Getcomputername;Ansi"
function long GetFreeMemory() library "PFCMacPlatformSrv"
function long GetPhysicalMemory() library "PFCMacPlatformSrv"
function long Getuserid(ref string name) library "PFCMacPlatformSrv" alias for "Getuserid;Ansi"
function long GetSystemDirectory(ref string name) library "PFCMacPlatformSrv" alias for "GetSystemDirectory;Ansi"
function int Playsound(string soundfile) library "PFCMacPlatformSrv" alias for "Playsound;Ansi"

end prototypes

type variables

end variables

forward prototypes
public function string of_getcomputername ()
public function long of_getfreememory ()
public function long of_getphysicalmemory ()
public function string of_getuserid ()
public function string of_getsystemdirectory ()
public function integer of_playsound (string as_file)
public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj)
end prototypes

public function string of_getcomputername ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetComputerName
//
//	Access:  public
//
//	Arguments: none
//	
//	Returns:  string - computer name
//
//	Description:  Return the the computer name
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string  ls_name
long ll_len

ls_name = space(256)

 ll_len = GetComputerName (ls_name )

return ls_name


end function

public function long of_getfreememory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFreeMemory
//
//	Access:  public
//
//	Arguments: none
//
//	Returns:  long - bytes of memory free
//	
//	Description:
//	Returns the number of bytes of memory currently available 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return (getfreememory ( ))
end function

public function long of_getphysicalmemory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetPhysicalMemory
//
//	Access:  public
//
//	Arguments: none
//
//	Returns:  long - physical memory
//	
//	Description:
//	Return the total physical memory (RAM) installed in the machine
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return (getphysicalmemory ( ))
end function

public function string of_getuserid ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetUserID
//
//	Access:  public
//
//	Arguments: none
//
//
//	Returns:  string  - user id/name
//	
//
//	Description:  Return the user id/name currently logged into a network
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string 	ls_name
long ll_len
 
 ls_name = space(256)
 
 ll_len = GetUserID ( ls_name)


return ls_name

end function

public function string of_getsystemdirectory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSystemDirectory
//
//	Access:  public
//
//	Arguments: none
//
//
//	Returns:  string 
//					system directory
//					"" if error			
//
//	Description:  Return the system directory
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_sysdir
long ll_len

ls_sysdir = space(256)

 ll_len = getsystemdirectory (  ls_sysdir)

return ls_sysdir

end function

public function integer of_playsound (string as_file);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PlaySound
//
//	Access:  public
//
//	Arguments: as_file - sound file to play
//
//
//	Returns:  integer
//
//	Description:  Play a sound file
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
 return playsound ( as_file )


end function

public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PrintDlg
//
//	Access:  public
//
//	Arguments:
//	astr_printdlg:  printdlg structure passed by ref
//	aw_obj:  window that is opening the print dialog window (no effect for mac)
//
//	Returns:  long
//	 1 = success
//	-1 = error or user cancelled from print dialog
//
//	Description:  Opens the print dialog
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

OpenWithParm (w_print, astr_printdlg)

astr_printdlg = message.powerobjectparm

// b_disablepagenums element determines if action was taken on print dialog
if astr_printdlg.b_disablepagenums then
	return 1
else
	return -1
end if
end function

on pfc_n_cst_platformmac.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_platformmac.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Set separator character for mac platform
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

is_separator = ":"
end event


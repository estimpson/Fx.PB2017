$PBExportHeader$pfc_n_cst_platform.sru
$PBExportComments$PFC Cross Platform service
forward
global type pfc_n_cst_platform from n_base
end type
end forward

global type pfc_n_cst_platform from n_base
end type
global pfc_n_cst_platform pfc_n_cst_platform

type variables
Protected:
string	is_separator
end variables

forward prototypes
public function unsignedinteger of_findwindow (string as_window_name)
public function string of_GetComputerName ()
public function long of_GetFreeMemory ()
public function long of_GetPhysicalMemory ()
public function string of_GetUserID ()
public function string of_GetWindowsDirectory ()
public function string of_GetWindowText (unsignedinteger ai_handle)
public function boolean of_IsAppRunning (string as_app_name)
public function string of_GetSystemDirectory ()
public function integer of_GetFreeResources (integer ai_type)
public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width)
public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj)
public function long of_pagesetupdlg (ref s_pagesetupattrib astr_pagesetup)
public function integer of_playsound (string as_file)
public function integer of_playsound (string as_file, boolean ab_beeponfailure)
end prototypes

public function unsignedinteger of_findwindow (string as_window_name);return 0

end function

public function string of_GetComputerName ();return ""
end function

public function long of_GetFreeMemory ();return -1

end function

public function long of_GetPhysicalMemory ();return -1
end function

public function string of_GetUserID ();return ""
end function

public function string of_GetWindowsDirectory ();return ""
end function

public function string of_GetWindowText (unsignedinteger ai_handle);return ""
end function

public function boolean of_IsAppRunning (string as_app_name);boolean lb_temp
setnull (lb_temp)
return lb_temp
end function

public function string of_GetSystemDirectory ();return ""
end function

public function integer of_GetFreeResources (integer ai_type);return -1

end function

public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width);//	Function not found in descendent

Return -1

end function

public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PrintDlg
//
//	Access:  public
//
//	Arguments:
//	astr_printdlg:  printdlg structure passed by ref
//	aw_obj:  window that is opening the print dialog window
//
//	Returns:  long
//	 1 = success
//	-1 = error or user cancelled from print dialog
//
//	Description:  Opens the print dialog
//
//	Note:  function is implemented in descendant objects
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return -1
end function

public function long of_pagesetupdlg (ref s_pagesetupattrib astr_pagesetup);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PageSetupDlg
//
//	Access:  public
//
//	Arguments:
//	astr_pagesetup:  page setup structure by ref
//
//	Returns:  long
//	 1 = success
//	 0 = User cancelled from page setup dialog
//	-1 = error
//
//	Description:  Opens the page setup dialog
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long	ll_rc

ll_rc = OpenWithParm (w_pagesetup, astr_pagesetup)
if ll_rc > 0 then
	astr_pagesetup = message.PowerObjectParm
	if not astr_pagesetup.b_actiontaken then
		ll_rc = 0
	end if
end if

return ll_rc
end function

public function integer of_playsound (string as_file);return -1
end function

public function integer of_playsound (string as_file, boolean ab_beeponfailure);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PlaySound
//
//	Access:  public
//
//	Arguments: 
//		as_file - sound file to play
//		ab_beeponfailure - Play a beep if the requested sound fails.
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
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

// Play the sound.
li_rc = of_playsound(as_file)

// Confirm that the sound was played succesfully.
If li_rc <= 0 Then
	// Play a default beep.
	beep(1)
End If

Return li_rc


end function

on pfc_n_cst_platform.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_platform.destroy
TriggerEvent( this, "destructor" )
end on


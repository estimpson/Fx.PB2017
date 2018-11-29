$PBExportHeader$pfc_n_cst_platformwin16.sru
$PBExportComments$PFC Win16 Cross Platform service
forward
global type pfc_n_cst_platformwin16 from n_cst_platform
end type
end forward

global type pfc_n_cst_platformwin16 from n_cst_platform
end type
global pfc_n_cst_platformwin16 pfc_n_cst_platformwin16

type prototypes
// Get text size
Function uint GetDC  (uint hWnd) Library "USER.EXE"
Function uint ReleaseDC (uint hWnd, uint hdcr) Library "USER.EXE"
Function ulong GetTextExtent (uint hdcr, string lpString, integer nCount) Library "GDI.EXE" alias for "GetTextExtent;Ansi"
Function uint SelectObject (uint hdc, uint hWnd) Library "GDI.EXE"

// Sound
Function boolean sndPlaySound (string SoundName, uint Flags) Library "mmsystem.dll" alias for "sndPlaySound;Ansi"
Function uint waveOutGetNumDevs () Library "mmsystem.dll"

// Get system color
Function ulong GetSysColor (int index) Library "user.exe"

// Get free memory
Function ulong GetFreeSpace(uint parm) Library "kernel.exe"

// Get free system resources
Function uint Getfreesystemresources (uint resource) Library "user.exe"

// module handle
Function uint GetModuleHandle(string ModName) Library "kernel.exe" alias for "GetModuleHandle;Ansi"
Function integer GetModuleUsage (uint Handle) Library "kernel.exe"

// window functions
Function int GetWindowText(uint handle, ref string wintext, int length) Library "user.exe" alias for "GetWindowText;Ansi"
Function uint GetWindowsDirectory (ref string dirtext, uint textlen) library "kernel.exe" alias for "GetWindowsDirectory;Ansi"
Function uint GetSystemDirectory (ref string dirtext, uint textlen) library "kernel.exe" alias for "GetSystemDirectory;Ansi"
Function uint FindWindow(string classname, string windowname) Library "USER.EXE" alias for "FindWindow;Ansi"

// user info
function uint WNetGetUser(ref string User, ref uint UserLength) library "user.exe" alias for "WNetGetUser;Ansi"
function uint MNetNetworkEnum(ref uint hnetwork) library "wfwnet.lib"
function uint MNetSetNextTarget(uint hnetwork) library "wfwnet.lib"
function uint WNetGetCaps(uint index) library "user.exe"

// Dialogs
function long PFC_PrintDlg (uint hwnd, ref s_printdlgattrib printstruct) library "pfccomm.dll" alias for "PFC_PrintDlg;Ansi"
end prototypes

type variables

end variables

forward prototypes
public function unsignedinteger of_findwindow (string as_window_name)
public function long of_GetFreeMemory ()
public function string of_getuserid ()
public function string of_GetWindowText (unsignedinteger ai_handle)
public function boolean of_IsAppRunning (string as_app_name)
public function string of_GetSystemDirectory ()
public function string of_GetWindowsDirectory ()
public function integer of_GetFreeResources (integer ai_type)
public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width)
public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj)
public function integer of_playsound (string as_file)
end prototypes

public function unsignedinteger of_findwindow (string as_window_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function: of_FindWindow
//
//	Access:  public
//
//	Arguments: as_window_name - window text (on title bar) to search for
//	
//
//	Returns:  uint  - window handle
//	
//
//	Description:  Return the handle of the window passed in by window name (Window Title)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Added setnull so all classes could be searched.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string 	ls_classname ="" 	// class name of window
									// set to null to find all classes with the window text
									// passed in
uint 		li_rc

setnull(ls_classname)
li_rc = FindWindow(ls_classname, as_window_name)

return li_rc


end function

public function long of_GetFreeMemory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFreeMemory
//
//	Access:  public
//
//	Arguments: none
//
//
//	Returns:  long - 	bytes of memory
//	
//
//	Description:  returns the number of bytes of memory currently available 
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
Return GetFreeSpace(0)
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
//	5.0   Initial version
//	5.0.03	Set the network Id to Enable UserID return on Window for Workgroups systems.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
uint 		lui_len
int 		li_rc
string 	ls_temp
uint	lui_netdriver
int	li_rc_enum, li_rc_target
boolean	lb_userfound

lui_len = 255
ls_temp = space(lui_len)

li_rc = WNetGetUser(ls_temp, lui_len)

if li_rc <> 0 THEN
	return ""
elseif ls_temp <> "" then
	return ls_temp
else
//Windows for Workgroups 
	lb_userfound = False
	//grab the first network
	lui_netdriver = 0
	li_rc_enum = MNetNetworkEnum(lui_netdriver)
	DO WHILE (li_rc_enum = 0) and NOT lb_userfound
		lui_len = 255
		ls_temp = space(lui_len)
	
		//make sure correct network is accessed in next WNetGetUser call
		li_rc_target = MNetSetNextTarget(lui_netdriver)
		li_rc = WNetGetUser(ls_temp, lui_len)
		if li_rc = 0 then
			lb_userfound = true
		end if
	
		//get the next network
		li_rc_enum = MNetNetworkEnum(lui_netdriver)
	LOOP
	
	if NOT lb_userfound then
		return ""
	else
		return ls_temp
	end if

end if

end function

public function string of_GetWindowText (unsignedinteger ai_handle);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetWindowText
//
//	Access:  public
//
//	Arguments:
//
//
//	Returns:  string
//					window text
//					"" if error
//
//	Description:  Return the window title text
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
string 	ls_win_text
int 		li_length=255

ls_win_text = space(255)

li_length = GetWindowText(ai_handle, ls_win_text, li_length)

if li_length > 0 THEN
	return ls_win_text
else
	return ""
end if
end function

public function boolean of_IsAppRunning (string as_app_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_IsAppRunning
//
//	Access:  public
//
//	Arguments: as_app_name -  Application name to check for
//
//
//	Returns:  boolean
//	
//
//	Description:  Checks if an application is running
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
long ll_handle

ll_handle = GetModuleHandle (as_app_name)

if ll_handle > 0 THEN
	if GetModuleUsage(ll_handle) > 0 THEN
		return true
	else
		return false
	end if
else
	return false
end if

end function

public function string of_GetSystemDirectory ();//////////////////////////////////////////////////////////////////////////////
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
//	Description:  Return the window's system directory
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
string ls_dir
uint li_rc

ls_dir = space(255)

li_rc = GetSystemDirectory(ls_dir, 255)

if li_rc > 0 THEN
	return ls_dir
else
	return ""
end if

end function

public function string of_GetWindowsDirectory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetWindowsDirectory
//
//	Access:  public
//
//	Arguments: none
//
//
//	Returns:  string 
//					windows directoy
//					"" if error
//
//	Description:  Return the window's directory
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
string ls_path
uint li_rc

ls_path = space(255)

li_rc = GetWindowsDirectory(ls_path, 255)

if li_rc > 0 THEN
	return ls_path
else
	return ""
end if
end function

public function integer of_GetFreeResources (integer ai_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFreeResources
//
//	Access:  public
//
//	Arguments: ai_type - 0 - System Resources
//								1 - GDI Resources
//								2 - User Resources
//
//
//	Returns:  The percentage of free space for resources
//	
//
//	Description: Returns the percentage of free space for system resources. 
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

Return GetFreeSystemResources(ai_type)

end function

public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTextSize
//
//	Access:  public
//
//	Arguments:  
//	aw_obj:   Window where temporary text will be created
//	as_Text						The text to be sized.
//	as_FontFace				The font used.
//	ai_FontSize				The point size of the font.
//	ab_Bold						True - Bold, False - Normal.
//	ab_Italic					True - Yes, False - No.
//	ab_Underline				True - Yes, False - No.
//	ai_Height					the height of the object in pixels
//	ai_Width					the width of the object in pixels
//
//
//	Returns:  Integer			1 if successful, -1 if an error occurrs
//	
//
//	Description:  Calculates the size of a text object in pixels
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

Integer		li_Size, li_Len, li_Return, &
				li_WM_GETFONT = 49 	//  hex 0x0031
StaticText	lst_Temp
ULong			lul_Size
UInt			lui_Hdc, lui_Handle, lui_hFont &

// Datawindow syntax specifies font point size is negative
li_Size = -1 * ai_FontSize

if IsNull(aw_obj) Or Not IsValid (aw_obj) then
	return -1
end if

// Create a dummy StaticText Object on the window
// containing text with the desired characteristics
li_Return = aw_obj.OpenUserObject(lst_Temp)
If li_Return = 1 Then
	lst_Temp.FaceName = as_FontFace
	lst_Temp.TextSize = li_Size
	If ab_Bold Then
		lst_Temp.Weight = 700
	Else
		lst_Temp.Weight = 400
	End If
	lst_Temp.Italic = ab_Italic
	lst_Temp.Underline = ab_Underline

	li_Len = Len(as_Text)

	// Get the handle of the StaticText Object and create a Device Context
	lui_Handle = Handle(lst_Temp)
	lui_Hdc = GetDC(lui_Handle)

	// Get the font in use on the Static Text
	lui_hFont = Send(lui_Handle, li_WM_GETFONT, 0, 0)

	// Select it into the device context
	SelectObject(lui_Hdc, lui_hFont)

	// Get the size of the text.  This function returns a double word -
	// the low order word is the width, the high order word is the height.
	lul_Size = GetTextExtent(lui_Hdc, as_Text, li_Len)
	ai_Height = IntHigh(lul_Size)
	ai_Width = IntLow(lul_Size)

	ReleaseDC(lui_Handle, lui_Hdc)

	li_Return = aw_obj.CloseUserObject(lst_Temp)
End if

Return li_Return

end function

public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PrintDlg
//
//	Access:  public
//
//	Arguments:
//	astr_printdlg:  printdlg structure passed by ref
//	aw_obj:  window that is opening the print dialog
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
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long ll_hwnd

ll_hwnd = handle (aw_obj)
if ll_hwnd = 0 then
	return -1
end if

return pfc_printdlg (ll_hwnd, astr_printdlg)



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
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
uint lui_numdevs
int li_option=0

lui_numdevs = WaveOutGetNumDevs() 
If lui_numdevs > 0 Then 
	sndPlaySound(as_file,li_option)
	return 1
Else
	return -1
End If

end function

on pfc_n_cst_platformwin16.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_platformwin16.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call n_cst_platform::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_n_cst_platformwin16
//
//	Description:  Windows 16bit platform object
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

is_separator = "\"
end event


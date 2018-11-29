$PBExportHeader$pfc_n_cst_platformsol2.sru
$PBExportComments$PFC Solaris Cross Platform service
forward
global type pfc_n_cst_platformsol2 from n_cst_platform
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

global type pfc_n_cst_platformsol2 from n_cst_platform
end type
global pfc_n_cst_platformsol2 pfc_n_cst_platformsol2

type prototypes
// Sound
Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "libkernel40.so" alias for "sndPlaySoundA;Ansi"
//Function uint waveOutGetNumDevs () Library "WINMM.DLL"

// Get free memory
Subroutine GlobalMemoryStatus (ref os_memorystatus memorystatus ) Library "libkernel40.so" alias for "GlobalMemoryStatus;Ansi"

// Get module handle
Function long GetModuleHandleA(string modname) Library "libkernel40.so" alias for "GetModuleHandleA;Ansi"

// Window functions
Function int GetWindowTextA(long handle, ref string wintext, int length) Library "libuser40.so" alias for "GetWindowTextA;Ansi"
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "libkernel40.so" alias for "GetWindowsDirectoryA;Ansi"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "libkernel40.so" alias for "GetSystemDirectoryA;Ansi"
function uint FindWindowA( ref string lpClassName, ref string lpWindowName) Library "libuser40.so" alias for "FindWindowA;Ansi"


// User/computer information
Function boolean GetUserNameA(ref string  lpBuffer, ref int nSize) library "libkernel40.so" alias for "GetUserNameA;Ansi"
function boolean GetComputerNameA(ref string  lpBuffer, ref int nSize) library "libkernel40.so" alias for "GetComputerNameA;Ansi"

// Get text size
Function uint GetDC(uint hWnd) Library "libgdi40.so"
Function uint ReleaseDC(uint hWnd, uint hdcr) Library "libgdi40.so"
Function boolean GetTextExtentPoint32A(uint hdcr, string lpString, integer nCount, ref os_size size) Library "libgdi40.so" alias for "GetTextExtentPoint32A;Ansi"
Function uint SelectObject(uint hdc, uint hWnd) Library "libgdi40.so"

// Dialogs
//function long PFC_PrintDlg (uint hwnd, ref s_printdlgattrib printstruct) library "pfccom32.dll"

end prototypes

type variables

end variables

forward prototypes
public function unsignedinteger of_FindWindow (string as_window_name)
public function string of_getcomputername ()
public function long of_GetFreeMemory ()
public function long of_GetPhysicalMemory ()
public function string of_getuserid ()
public function string of_GetWindowText (unsignedinteger ai_handle)
public function string of_GetSystemDirectory ()
public function string of_GetWindowsDirectory ()
public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width)
public function long of_printdlg (ref s_printdlgattrib astr_printdlg, window aw_obj)
public function integer of_playsound (string as_file)
end prototypes

public function unsignedinteger of_FindWindow (string as_window_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function: of_FindWindow
//
//	Access:  public
//
//	Arguments: as_window_name - window text to search for
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
uint 		li_whnd
string 	ls_classname="FNWND050"

li_whnd = FindWindowA( ls_classname, as_window_name)

return li_whnd

end function

public function string of_getcomputername ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetComputerName
//
//	Access:  public
//
//	Arguments: none
//	
//
//	Returns:  string - computer name
//	
//
//	Description:  Return the the computer name the user is using
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
string 	ls_computer_name
int 		li_size = 16 // MAX_COMPUTERNAME_LENGTH + 1

boolean	lb_rc

ls_computer_name = space(li_size)

lb_rc = GetComputerNameA( ls_computer_name, li_size)

if not lb_rc THEN
	return ""
else
	return ls_computer_name
end if

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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
os_memorystatus lstr_memory

//structure size is 8 ulong's or 8 * 4 bytes
lstr_memory.ul_length = 32

GlobalMemoryStatus(lstr_memory)

//bytes of virtual memory available
Return (lstr_memory.ul_availpagefile)
end function

public function long of_GetPhysicalMemory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetPhysicalMemory
//
//	Access:  public
//
//	Arguments: none
//
//
//	Returns:  long -  total memory
//	
//
//	Description:  Return the total physical memory (RAM) installed in the machine
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
os_memorystatus lstr_memory

//structure size is 8 ulong's or 8 * 4 bytes
lstr_memory.ul_length = 32

GlobalMemoryStatus(lstr_memory)

//bytes of virtual memory available
Return (lstr_memory.ul_totalphys)
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
integer	li_size = 255
boolean	lb_rc

ls_name = space(li_size)

lb_rc = GetUserNameA( ls_name, li_size)

if not lb_rc THEN
	return ""
else
	return ls_name
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int 		li_rc
string 	ls_wintext
int		li_size = 255

ls_wintext = space (255)

li_rc = GetWindowTextA(ai_handle, ls_wintext, li_size)

if li_rc > 0 THEN
	return ls_wintext
else
	return ""
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int 		li_size = 260 // MAX_PATH
string 	ls_dir 
int		li_rc

ls_dir = space(li_size)

li_rc = GetSystemDirectoryA(ls_dir, li_size)

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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int 		li_size = 260 // MAX_PATH
string 	ls_dir 
int		li_rc

ls_dir = space(li_size)

li_rc = GetWindowsDirectoryA(ls_dir, li_size)

if li_rc > 0 THEN
	return ls_dir
else
	return ""
end if

end function

public function integer of_gettextsize (ref window aw_obj, string as_text, string as_fontface, integer ai_fontsize, boolean ab_bold, boolean ab_italic, boolean ab_underline, ref integer ai_height, ref integer ai_width);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTextSize
//
//	Access:  public
//
//	Arguments:  
//	aw_obj:  Window where temporary text will be created
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
//	5.0.02   Initial version
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
UInt			lui_Hdc, lui_Handle, lui_hFont
os_size 		lstr_Size

// Datawindow syntax specifies font point size is negative
li_Size = -1 * ai_FontSize

if not IsValid (aw_obj) then
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

	// Get the size of the text.
	If Not GetTextExtentpoint32A(lui_Hdc, as_Text, li_Len, lstr_Size ) Then Return -1

	ai_Height = lstr_Size.l_cy
	ai_Width = lstr_Size.l_cx

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
//	aw_obj:  window that is opening the print dialog window (no effect for Solaris)
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
//uint lui_numdevs


//lui_numdevs = WaveOutGetNumDevs() 
//If lui_numdevs > 0 Then 
If	sndPlaySoundA(as_file,1) Then
	return 1
Else
	return -1
End If

end function

on pfc_n_cst_platformsol2.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_platformsol2.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call n_cst_platform::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_n_cst_platformwin32
//
//	Description:  Windows 32bit platform object
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

is_separator = "\"
end event


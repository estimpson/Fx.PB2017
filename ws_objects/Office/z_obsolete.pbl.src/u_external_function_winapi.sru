$PBExportHeader$u_external_function_winapi.sru
$PBExportComments$New! Cross Platform User Object for Windows 16 bit api
forward
global type u_external_function_winapi from u_external_function
end type
end forward

global type u_external_function_winapi from u_external_function
end type
global u_external_function_winapi u_external_function_winapi

type prototypes
//playsound
Function boolean sndPlaySound (string SoundName, uint Flags) Library "mmsystem.dll" alias for "sndPlaySound;Ansi"
Function uint waveOutGetNumDevs () Library "mmsystem.dll"

//getsyscolor
Function ulong GetSysColor (int index) Library "user.exe"

//getsystem width/height
Function int GetSystemMetrics(int index) Library "user.exe"

//getfreememory
Function ulong GetFreeSpace(uint dummy) Library "kernel.exe"

//get os mode
Function ulong GetWinFlags () Library "kernel.exe"

//Settimer KillTimer
Function boolean KillTimer (uint handle, uint id) library "user.exe"
Function uint SetTimer (uint handle, uint id, uint time, long addr) library "user.exe"

//get free system resources
Function uint Getfreesystemresources (uint resource) Library "user.exe"

//module handle
Function uint GetModuleHandle(string ModName) Library "kernel.exe" alias for "GetModuleHandle;Ansi"
Function integer GetModuleUsage (uint Handle) Library "kernel.exe"

Function boolean FlashWindow (uint handle, boolean flash) Library "user.exe"
Function uint GetWindow (uint handle,uint relationship) Library "user.exe"
Function int GetWindowText(uint handle, ref string wintext, int length) Library "user.exe" alias for "GetWindowText;Ansi"
Function boolean IsWindowvisible (uint handle) Library "user.exe"
Function uint GetWindowsDirectory (ref string dirtext, uint textlen) library "kernel.exe" alias for "GetWindowsDirectory;Ansi"
Function uint GetSystemDirectory (ref string dirtext, uint textlen) library "kernel.exe" alias for "GetSystemDirectory;Ansi"
Function uint GetDriveType (int drive) library "kernel.exe"

function ulong GetTickCount() library "USER.EXE"
function int WNetGetUser(ref string User, ref uint UserLength) library "user.exe" alias for "WNetGetUser;Ansi"
end prototypes

forward prototypes
public function int uf_playsound (string as_filename, int ai_option)
public function unsignedlong uf_getsyscolor (integer ai_index)
public function int uf_getscreenwidth ()
public function int uf_getscreenheight ()
public function string uf_getos_mode ()
public function ulong uf_getfreememory ()
public function integer uf_getmoduleusage (uint aui_modhandle)
public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size)
public function uint uf_getdrivetype (integer ai_drive)
public function uint uf_getwindowsdirectory (ref string as_dir, uint aui_size)
public function unsignedinteger uf_getfreesystemresources (integer parm)
public function integer uf_get_logon_name (ref string as_name)
public function ulong uf_get_logon_time ()
public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
public function boolean uf_flash_window (long aui_handle, boolean ab_flash)
public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function boolean uf_iswindowvisible (long aui_handle)
public function long uf_getmodulehandle (string as_modname)
end prototypes

public function int uf_playsound (string as_filename, int ai_option);//Options as defined in mmystem.h These may be or'd together.

//#define SND_SYNC            0x0000  /* play synchronously (default) */
//#define SND_ASYNC           0x0001  /* play asynchronously */
//#define SND_NODEFAULT       0x0002  /* don't use default sound */
//#define SND_MEMORY          0x0004  /* lpszSoundName points to a memory file */
//#define SND_LOOP            0x0008  /* loop the sound until next sndPlaySound */
//#define SND_NOSTOP          0x0010  /* don't stop any currently playing sound */    

uint lui_numdevs


lui_numdevs = WaveOutGetNumDevs() 
If lui_numdevs > 0 Then 
	sndPlaySound(as_filename,ai_option)
	return 1
Else
	return -1
End If
end function

public function unsignedlong uf_getsyscolor (integer ai_index);//GetsysColor in win32
Return GetSysColor (ai_index)
end function

public function int uf_getscreenwidth ();Return GetSystemMetrics(0)
end function

public function int uf_getscreenheight ();return getSystemMetrics(1)
end function

public function string uf_getos_mode ();// GetWinFlgas Returns a double word of binary  encoded values.
// If the 6th bit is turned on , then the system is 386 enhanced mode
// If the 5th bit is turned on, then the system is standard mode
// other wise its in Real Mode

string ls_temp 
ulong ll_winflags

ll_winflags = GetWinFlags ( )
If Mod(Int (ll_winflags / 32) , 2) > 0 Then
	ls_temp = "Enhanced Mode"
ElseIf Mod(Int(ll_winflags / 16) , 2) > 0 Then
	ls_temp =  "Standard Mode"
Else
	ls_temp = "Real Mode"
End If

Return ls_temp
end function

public function ulong uf_getfreememory ();//win api to get free memory
Return GetFreeSpace(0)
end function

public function integer uf_getmoduleusage (uint aui_modhandle);//use sdk getmoduleusage

Return GetModuleUsage(aui_modhandle)

end function

public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size);Return GetSystemDirectory(as_dir,aui_size)
end function

public function uint uf_getdrivetype (integer ai_drive);//drive types
Return GetDriveType(ai_drive)
end function

public function uint uf_getwindowsdirectory (ref string as_dir, uint aui_size);Return GetWindowsDirectory(as_dir,aui_size)
end function

public function unsignedinteger uf_getfreesystemresources (integer parm);//win api to get free win resources
Return GetFreeSystemResources(parm)
end function

public function integer uf_get_logon_name (ref string as_name);//use windows function wnetgetuser
uint lui_len
int li_rc
string ls_temp
lui_len =255
ls_temp = space(255)
li_rc = WNetGetUser(ls_temp,lui_len)

as_name = ls_temp
Return li_rc
end function

public function ulong uf_get_logon_time ();//user gettickcount to find total logon time
Return GetTickCount()

end function

public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id);//win api call to kill timer
Return KillTimer(aui_handle,aui_id)
end function

public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);//win api to create timer
Return(SetTimer(aui_handle,aui_id,aui_time,0))
end function

public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max);//function not found
Return GetWindowText (aui_handle,as_text,ai_max)
end function

public function boolean uf_flash_window (long aui_handle, boolean ab_flash);//function not found in descendent
Return FlashWindow(aui_handle, ab_flash)
end function

public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship);//function not found
Return GetWindow(aui_handle,aui_relationship)
end function

public function boolean uf_iswindowvisible (long aui_handle);Return IsWindowVisible(aui_handle)
end function

public function long uf_getmodulehandle (string as_modname);
//use sdk getmodule handle

Return GetModuleHandle (as_modname)
end function

on u_external_function_winapi.create
TriggerEvent( this, "constructor" )
end on

on u_external_function_winapi.destroy
TriggerEvent( this, "destructor" )
end on


$PBExportHeader$u_external_function_win32.sru
$PBExportComments$New! cross platform user object for Win32
forward
global type u_external_function_win32 from u_external_function
end type
end forward

type str_memorystatus from structure
    unsignedlong sul_dwlength
    unsignedlong sul_dwmemoryload
    unsignedlong sul_dwtotalphys
    unsignedlong sul_dwavailphys
    unsignedlong sul_dwtotalpagefile
    unsignedlong sul_dwavailpagefile
    unsignedlong sul_dwtotalvirtual
    unsignedlong sul_dwavailvirtual
end type

global type u_external_function_win32 from u_external_function
end type
global u_external_function_win32 u_external_function_win32

type prototypes
//playsound
Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "WINMM.DLL" alias for "sndPlaySoundA;Ansi"
Function uint waveOutGetNumDevs () Library "WINMM.DLL"

//getsyscolor
Function ulong GetSysColor (int index) Library "USER32.DLL"

//getsystemmetrics
Function int GetSystemMetrics (int index) Library "USER32.DLL"

//getfreememory
Subroutine GlobalMemoryStatus (ref str_memorystatus memorystatus ) Library "KERNEL32.DLL" alias for "GlobalMemoryStatus;Ansi"

//set and kill timer
Function Boolean KillTimer (long handle, uint id ) library "USER32.DLL"
Function uint SetTimer (long handle, uint id, uint time, long addr ) library "USER32.DLL"

//GetModuleHandle
Function long GetModuleHandleA(string modname) Library "KERNEL32.DLL" alias for "GetModuleHandleA;Ansi"

Function boolean FlashWindow (long handle, boolean flash) Library "USER32.DLL"
Function uint GetWindow (long handle,uint relationship) Library "USER32.DLL"
Function int GetWindowTextA(long handle, ref string wintext, int length) Library "USER32.DLL" alias for "GetWindowTextA;Ansi"
Function boolean IsWindowVisible (long handle) Library "USER32.DLL"
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetWindowsDirectoryA;Ansi"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetSystemDirectoryA;Ansi"
Function uint GetDriveTypeA (string drive) library "KERNEL32.DLL" alias for "GetDriveTypeA;Ansi"

Function boolean GetUserNameA (ref string name, ref ulong len) library "ADVAPI32.DLL" alias for "GetUserNameA;Ansi"
Function ulong GetTickCount ( ) Library "KERNEL32.DLL"
end prototypes

forward prototypes
public function integer uf_playsound (string as_filename, integer ai_option)
public function unsignedlong uf_getsyscolor (integer ai_index)
public function integer uf_getscreenwidth ()
public function integer uf_getscreenheight ()
public function long uf_getmodulehandle (string as_modname)
public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size)
public function uint uf_getdrivetype (int ai_drive)
public function unsignedinteger uf_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size)
public function unsignedlong uf_getfreememory ()
public function integer uf_get_logon_name (ref string as_name)
public function unsignedlong uf_get_logon_time ()
public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function boolean uf_flash_window (long aui_handle, boolean ab_flash)
public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function boolean uf_iswindowvisible (long aui_handle)
public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
end prototypes

public function integer uf_playsound (string as_filename, integer ai_option);//Options as defined in mmystem.h These may be or'd together.

//#define SND_SYNC            0x0000  /* play synchronously (default) */
//#define SND_ASYNC           0x0001  /* play asynchronously */
//#define SND_NODEFAULT       0x0002  /* don't use default sound */
//#define SND_MEMORY          0x0004  /* lpszSoundName points to a memory file */
//#define SND_LOOP            0x0008  /* loop the sound until next sndPlaySound */
//#define SND_NOSTOP          0x0010  /* don't stop any currently playing sound */    


uint lui_numdevs


lui_numdevs = WaveOutGetNumDevs() 
If lui_numdevs > 0 Then 
	sndPlaySoundA(as_filename,ai_option)
	return 1
Else
	return -1
End If
end function

public function unsignedlong uf_getsyscolor (integer ai_index);//GetsysColor in win32
Return GetSysColor (ai_index)
end function

public function integer uf_getscreenwidth ();Return GetSystemMetrics(0)
end function

public function integer uf_getscreenheight ();Return GetSystemMetrics(1)
end function

public function long uf_getmodulehandle (string as_modname);//use win 32 getmodulehandle function

Return GetModuleHandleA(as_modname)
end function

public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size);Return GetSystemDirectoryA(as_dir,aui_size)
end function

public function uint uf_getdrivetype (int ai_drive);//drive types
Return GetDriveTypeA(CharA(ai_drive + AscA ('A')) + ":\")
end function

public function unsignedinteger uf_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size);Return GetWindowsDirectoryA(as_dir,aui_size)
end function

public function unsignedlong uf_getfreememory ();//return # bytes free memory

str_memorystatus lstr_memory

//structure size is 8 ulong's or 8 * 4 bytes
lstr_memory.sul_dwlength = 32

GlobalMemoryStatus(lstr_memory)

//bytes of virtual memory available
Return (lstr_memory.sul_dwavailpagefile)
end function

public function integer uf_get_logon_name (ref string as_name);//user win32 getusername

string ls_temp 
ulong lul_value =255
boolean lb_rc
ls_temp = string(255)
lb_rc = GetUserNameA(ls_temp,lul_value)
If lb_rc Then
	as_name = ls_temp
	Return 1
Else 
	Return -1
End If
end function

public function unsignedlong uf_get_logon_time ();//use win32 gettickcount() for time logged in

Return GetTickCount()
end function

public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id);//win32 to kill timer
Return KillTimer(aui_handle,aui_id)
end function

public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);//win 32 call to create timer
Return SetTimer(aui_handle,aui_id,aui_time,0)

end function

public function boolean uf_flash_window (long aui_handle, boolean ab_flash);//function not found in descendent
Return FlashWindow(aui_handle, ab_flash)
end function

public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship);//function not found
Return GetWindow(aui_handle,aui_relationship)
end function

public function boolean uf_iswindowvisible (long aui_handle);Return IsWindowVisible(aui_handle)
end function

public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max);//function not found
Return GetWindowTextA (aui_handle,as_text,ai_max)
end function

on u_external_function_win32.create
TriggerEvent( this, "constructor" )
end on

on u_external_function_win32.destroy
TriggerEvent( this, "destructor" )
end on


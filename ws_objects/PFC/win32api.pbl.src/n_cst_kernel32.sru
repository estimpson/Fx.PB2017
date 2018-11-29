$PBExportHeader$n_cst_kernel32.sru
forward
global type n_cst_kernel32 from nonvisualobject
end type
end forward

type SECURITY_ATTRIBUTES from structure
	ulong		nLength
	ulong		lpSecurityDescriptor
	boolean		bInheritHandle
end type

type FILETIME from structure
	ulong		dwLowDateTime
	ulong		dwHighDateTime
end type

type SYSTEMTIME from structure
	uint		wYear
	uint		wMonth
	uint		wDayOfWeek
	uint		wDay
	uint		wHour
	uint		wMinute
	uint		wSecond
	uint		wMilliseconds
end type

type win32_find_dataa from structure
	unsignedlong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwreserved0
	unsignedlong		dwreserved1
	character		cfilename[260]
	character		calternatefilename[14]
end type

type MEMORYSTATUS from structure
	ulong		dwLength
	ulong		dwMemoryLoad
	ulong		dwTotalPhys
	ulong		dwAvailPhys
	ulong		dwTotalPageFile
	ulong		dwAvailPageFile
	ulong		dwTotalVirtual
	ulong		dwAvailVirtual
end type

type ofstruct from structure
	character		cbytes
	character		ffixeddisk
	long		nerrcode
	long		reserved1
	long		reserved2
	character		szpathname[128]
end type

type STARTUPINFOA from structure
	ulong		cb
	string		lpReserved
	string		lpDesktop
	string		lpTitle
	ulong		dwX
	ulong		dwY
	ulong		dwXSize
	ulong		dwYSize
	ulong		dwXCountChars
	ulong		dwYCountChars
	ulong		dwFillAttribute
	ulong		dwFlags
	long		wShowWindow
	long		cbReserved2
	ulong		lpReserved2
	ulong		hStdInput
	ulong		hStdOutput
	ulong		hStdError
end type

type PROCESS_INFORMATION from structure
	ulong		hProcess
	ulong		hThread
	ulong		dwProcessId
	ulong		dwThreadId
end type

type PROCESSENTRY32 from structure
	ulong		dwSize
	ulong		cntUsage
	ulong		th32ProcessID
	ulong		th32DefaultHeapID
	ulong		th32ModuleID
	ulong		cntThreads
	ulong		th32ParentProcessID
	long		pcPriClassBase
	ulong		dwFlags
	character		szExeFile[260]
end type

type tagchoosecolora from structure
	ulong		lStructSize
	ulong		hwndOwner
	ulong		hInstance
	ulong		rgbResult
	ulong		lpCustColors
	ulong		Flags
	ulong		lCustData
	ulong		lpfnHook
	ulong		lpTemplateName
end type

type SYSTEM_INFO from structure
	long		wProcessorArchitecture
	long		wReserved
	ulong		dwPageSize
	ulong		lpMinimumApplicationAddress
	ulong		lpMaximumApplicationAddress
	ulong		dwActiveProcessorMask
	ulong		dwNumberOfProcessors
	ulong		dwProcessorType
	ulong		dwAllocationGranularity
	long		wProcessorLevel
	long		wProcessorRevision
end type

type TIME_ZONE_INFORMATION from structure
	long		Bias
	character		StandardName[64]
	systemtime		StandardDate
	long		StandardBias
	character		DaylightName[64]
	systemtime		DaylightDate
	long		DaylightBias
end type

global type n_cst_kernel32 from nonvisualobject autoinstantiate
end type

type prototypes
Function boolean CreateDirectory (string lpPathName, ref SECURITY_ATTRIBUTES lpSecurityAttributes) Library "KERNEL32.DLL"  Alias for "CreateDirectoryA;Ansi"
Function ulong FindFirstFile (string lpFileName, ref WIN32_FIND_DATAA lpFindFileData) Library "KERNEL32.DLL" Alias for "FindFirstFileA;Ansi"
Function boolean GetFileTime (ulong hFile, ref FILETIME lpCreationTime, ref FILETIME lpLastAccessTime, ref FILETIME lpLastWriteTime) Library "KERNEL32.DLL" alias for "GetFileTime;Ansi"

Function ulong CreateFile (ref string lpFileName, ulong dwDesiredAccess, ulong dwShareMode, ref SECURITY_ATTRIBUTES lpSecurityAttributes, ulong dwCreationDisposition, ulong dwFlagsAndAttributes, ulong hTemplateFile) Library "KERNEL32.DLL" Alias for "CreateFileA;Ansi"
Function boolean CopyFile (ref string lpExistingFileName, ref string lpNewFileName, boolean bFailIfExists) Library "KERNEL32.DLL" Alias for "CopyFileA;Ansi"
Function boolean DeleteFile (ref string lpFileName) Library "KERNEL32.DLL" Alias for "DeleteFileA;Ansi"
Subroutine FatalExit (int ExitCode) Library "KERNEL32.DLL"
Function boolean FileTimeToSystemTime (ref FILETIME lpFileTime, ref SYSTEMTIME lpSystemTime) Library "KERNEL32.DLL" alias for "FileTimeToSystemTime;Ansi"
Function boolean FileTimeToLocalFileTime (ref FILETIME lpFileTime, ref FILETIME lpLocalFileTime) Library "KERNEL32.DLL" alias for "FileTimeToLocalFileTime;Ansi"
Function boolean FindClose (ulong hFindFile) Library "KERNEL32.DLL"
Function boolean FindNextFile (ulong hFindFile, ref WIN32_FIND_DATAA lpFindFileData) Library "KERNEL32.DLL" Alias for "FindNextFileA;Ansi"
Function boolean FreeLibrary (ref ulong hLibModule) Library "KERNEL32.DLL"
Function boolean GetComputerName (ref string  lpBuffer, ref ulong nSize) Library "KERNEL32.DLL" Alias for "GetComputerNameA;Ansi"
Function ulong GetCurrentDirectory (ulong nBufferLength, ref string lpBuffer) Library "KERNEL32.DLL" Alias for "GetCurrentDirectoryA;Ansi"
Function ulong GetCurrentThread () Library "KERNEL32.DLL"
Function boolean GetDiskFreeSpace (ref string lpRootPathName, ref ulong lpSectorsPerCluster, ref ulong lpBytesPerSector, ref ulong lpNumberOfFreeClusters, ref ulong lpTotalNumberOfClusters) Library "KERNEL32.DLL" Alias for "GetDiskFreeSpaceA;Ansi"
Function uint GetDriveType (ref string lpRootPathName) Library "KERNEL32.DLL" Alias for "GetDriveTypeA;Ansi"
Function ulong GetFileAttributes (ref string lpFileName) Library "KERNEL32.DLL" Alias for "GetFileAttributesA;Ansi"
Function ulong GetLastError () Library "KERNEL32.DLL"
Function ulong GetModuleHandle (ref string lpModuleName) Library "KERNEL32.DLL" Alias for "GetModuleHandleA;Ansi"
Function uint GetSystemDirectory (ref string lpBuffer, uint uSize) Library "KERNEL32.DLL" Alias for "GetSystemDirectoryA;Ansi"
Function boolean GetThreadPriority (ulong hThread, ref boolean pDisablePriorityBoost) Library "KERNEL32.DLL"
Function ulong GetTickCount ( ) Library "KERNEL32.DLL"
Function ulong GetVersion () Library "KERNEL32.DLL"
Function uint GetWindowsDirectory (ref string lpBuffer, uint uSize) Library "KERNEL32.DLL" Alias for "GetWindowsDirectoryA;Ansi"
Subroutine GlobalMemoryStatus (ref MEMORYSTATUS lpBuffer) Library "KERNEL32.DLL" alias for "GlobalMemoryStatus;Ansi"
Function ulong LoadLibrary (ref string lpLibFileName) Library "KERNEL32.DLL" Alias for "LoadLibraryA;Ansi"
Function ulong LocalAlloc (uint uFlags, ulong uBytes) Library "KERNEL32.DLL"
Function boolean LocalFileTimeToFileTime (ref FILETIME lpLocalFileTime, ref FILETIME lpFileTime) Library "KERNEL32.DLL" alias for "LocalFileTimeToFileTime;Ansi"
Function ulong LocalFree (ulong hMem) Library "KERNEL32.DLL"
Function boolean MoveFile (ref string lpExistingFileName, ref string lpNewFileName) Library "KERNEL32.DLL" Alias for "MoveFileA;Ansi"
Function ulong OpenFile (ref string lpFileName, ref OFSTRUCT lpReOpenBuff, uint uStyle) Library "KERNEL32.DLL" alias for "OpenFile;Ansi"
Function boolean RemoveDirectory (ref string lpPathName) Library "KERNEL32.DLL" Alias for "RemoveDirectoryA;Ansi"
Function boolean SetComputerName (ref string lpComputerName) Library "KERNEL32.DLL" Alias for "SetComputerNameA;Ansi"
Function boolean SetCurrentDirectory (ref string lpPathName) Library "KERNEL32.DLL" Alias for "SetCurrentDirectoryA;Ansi"
Function boolean SetFileAttributes (ref string lpFileName, ulong dwFileAttributes) Library "KERNEL32.DLL" Alias for "SetFileAttributesA;Ansi"
Function boolean SetFileTime (ulong hFile, ref FILETIME lpCreationTime, ref FILETIME lpLastAccessTime, ref FILETIME lpLastWriteTime)  Library "KERNEL32.DLL" alias for "SetFileTime;Ansi"
Function boolean SetThreadPriority (ulong hThread, int nPriority) Library "KERNEL32.DLL"
Subroutine Sleep (ulong dwMilliseconds) Library "KERNEL32.DLL"
Function boolean SystemTimeToFileTime (ref SYSTEMTIME lpSystemTime, ref FILETIME lpFileTime) Library "KERNEL32.DLL" alias for "SystemTimeToFileTime;Ansi"
Function ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath ) Library "KERNEL32.DLL" Alias for "GetModuleFileNameA;Ansi"
Function int MultiByteToWideChar (uint CodePage,  ulong dwFlags,  ref string lpMultiByteStr, int cbMultiByte,  ref blob lpWideCharStr, int cchWideChar) Library "KERNEL32.DLL" alias for "MultiByteToWideChar;Ansi" 
Function int WideCharToMultiByte (uint CodePage, ulong dwFlags, ref blob lpWideCharStr, int cchWideChar, ref string lpMultiByteStr, int cbMultiByte,ref string lpDefaultChar,ref boolean lpUsedDefaultChar) Library "KERNEL32.DLL" alias for "WideCharToMultiByte;Ansi" 
Function int MulDiv (int nNumber, int nNumerator,  int nDenominator) Library "KERNEL32.DLL" 
Function boolean Beep (ulong dwFreq, ulong dwDuration) Library "KERNEL32.DLL" 
Function boolean ChooseColor (ref tagCHOOSECOLORA CHOOSECOLORA) Library "COMDLG32.DLL" Alias for "ChooseColorA;Ansi"
Function ulong HeapCreate (ulong flOptions, ulong dwInitialSize,  ulong dwMaximumSize) Library "KERNEL32.DLL"
Function ulong HeapAlloc (ulong hHeap, ulong dwFlags, ulong dwBytes) Library "KERNEL32.DLL"
Function boolean HeapFree(ulong hHeap,  ulong dwFlags, ulong lpMem) Library "KERNEL32.DLL"
Function ulong GetShortPathName (string lpszLongPath, ref string lpszShortPath, ulong cchBuffer) Library "KERNEL32.DLL" Alias for "GetShortPathNameA;Ansi"

//Function boolean GetFileAttributesEx (ref string lpFileName, int fInfoLevelId,ref WIN32_FILE_ATTRIBUTE_DATA lpFileInformation) Library "KERNEL32.DLL"  Alias for "GetFileAttributesExA"
//Function boolean QueryPerformanceFrequency (REF LARGE_INTEGER lpFrequency ) Library "KERNEL32.DLL" 
//Function boolean GetDiskFreeSpaceExA(string d, ref ULARGE_INTEGER fbc, ref ULARGE_INTEGER tb, ref ULARGE_INTEGER tfb) Library "KERNEL32.DLL" 

Function ulong lstrcpy (ref string lpString1, ref string lpString2) Library "KERNEL32.DLL" alias for "lstrcpy;Ansi" 
Function boolean CreateProcess (ref string lpApplicationName, ref string lpCommandLine, ref SECURITY_ATTRIBUTES lpProcessAttributes, ref SECURITY_ATTRIBUTES  lpThreadAttributes, boolean bInheritHandles, ulong dwCreationFlags, ulong lpEnvironment, ref string lpCurrentDirectory, ref STARTUPINFOA lpStartupInfo, ref PROCESS_INFORMATION lpProcessInformation)  Library "KERNEL32.DLL"  alias for "CreateProcessA;Ansi"
Function ulong OpenProcess (ulong dwDesiredAccess, boolean bInheritHandle, ulong dwProcessId) Library "KERNEL32.DLL" 
Function ulong WaitForSingleObject (ulong hHandle, ulong dwMilliseconds) Library "KERNEL32.DLL" 
Function boolean GetExitCodeProcess (ulong hProcess, ref ulong lpExitCode) Library "KERNEL32.DLL" 
Function ulong CreateMutex (ref SECURITY_ATTRIBUTES lpMutexAttributes, boolean bInitialOwner, ref string lpName) Library "KERNEL32.DLL"  Alias for "CreateMutexA;Ansi"
Subroutine LocalLock (ulong hMem) Library "KERNEL32.DLL" 
Function boolean LocalUnlock (ulong hMem) Library "KERNEL32.DLL" 
Function ulong GetCurrentThreadId () Library "KERNEL32.DLL" 
Function boolean SetNamedPipeHandleState (ulong hNamedPipe, ref ulong lpMode, ref ulong lpMaxCollectionCount, ref ulong lpCollectDataTimeout) Library "KERNEL32.DLL" 
Function boolean GetVolumeInformation (string lpRootPathName, ref string lpVolumeNameBuffer, ulong nVolumeNameSize, ref ulong lpVolumeSerialNumber, ref ulong lpMaximumComponentLength, ref ulong lpFileSystemFlags, ref string lpFileSystemNameBuffer, ulong nFileSystemNameSize) Library "KERNEL32.DLL" Alias for "GetVolumeInformationA;Ansi"
Function ulong GetLogicalDrives () Library "KERNEL32.DLL" 
Subroutine GetSystemInfo (ref SYSTEM_INFO lpSystemInfo) Library "KERNEL32.DLL" alias for "GetSystemInfo;Ansi" 
Function ulong GetTempPath (ulong nBufferLength, ref string lpBuffer) Library "KERNEL32.DLL"  Alias for "GetTempPathA;Ansi"
Function ulong  GetTimeZoneInformation (ref TIME_ZONE_INFORMATION lpTimeZoneInformation) Library "KERNEL32.DLL" alias for "GetTimeZoneInformation;Ansi" 
Function ulong  GetPrivateProfileString (string lpAppName, string lpKeyName, string  lpDefault, ref string lpReturnedString, ulong nSize, string lpFileName) Library "KERNEL32.DLL"  Alias for "GetPrivateProfileStringA;Ansi"
Function uint GetTempFileName (ref string lpPathName, ref string lpPrefixString, uint uUnique, ref string lpTempFileName) Library "KERNEL32.DLL"  Alias for "GetTempFileNameA;Ansi"
Function long  CompareFileTime (ref FILETIME lpFileTime1,ref FILETIME lpFileTime2) Library "KERNEL32.DLL" alias for "CompareFileTime;Ansi" 

Function ulong CreateToolhelp32Snapshot (ulong dwFlags, ulong th32ProcessID) Library "KERNEL32.DLL"
Function boolean Process32First (ulong hSnapshot, ref PROCESSENTRY32 lppe) Library "KERNEL32.DLL" alias for "Process32First;Ansi"
Function boolean Process32Next (ulong hSnapshot, ref PROCESSENTRY32 lppe) Library "KERNEL32.DLL" alias for "Process32Next;Ansi"
Function boolean CloseHandle (ref ulong hObject) Library "KERNEL32.DLL"

Function ulong GetCurrentProcessId () Library "KERNEL32.DLL"
Subroutine GetSystemTime (ref SYSTEMTIME lpSystemTime) Library "KERNEL32.DLL" alias for "GetSystemTime;Ansi"
end prototypes

type variables
constant integer MAX_PATH          = 260
constant integer OFS_MAXPATHNAME = 128

//
//  Code Page Default Values.
//
constant integer CP_ACP                    = 0           // default to ANSI code page
constant integer CP_OEMCP                  = 1           // default to OEM  code page
constant integer CP_MACCP                  = 2           // default to MAC  code page
constant integer CP_THREAD_ACP            =  3           // current thread's ANSI code page
constant integer CP_SYMBOL                 = 42          // SYMBOL translations

constant integer CP_UTF7                   = 65000       // UTF-7 translation
constant integer CP_UTF8                   = 65001       // UTF-8 translation

//
//  MBCS and Unicode Translation Flags.
//
constant long MB_PRECOMPOSED            = 1  // use precomposed chars
constant long MB_COMPOSITE              = 2  // use composite chars
constant long MB_USEGLYPHCHARS          = 4  // use glyph chars, not ctrl chars
constant long MB_ERR_INVALID_CHARS      = 8  // error for invalid chars

//
//  Heap Flags
//
constant ulong HEAP_NO_SERIALIZE               = 1 //0x00000001      
constant ulong HEAP_GROWABLE                   = 2 //0x00000002      
constant ulong HEAP_GENERATE_EXCEPTIONS        = 4 //0x00000004      
constant ulong HEAP_ZERO_MEMORY                = 8 //0x00000008      
constant ulong HEAP_REALLOC_IN_PLACE_ONLY      = 16 //0x00000010      
constant ulong HEAP_TAIL_CHECKING_ENABLED      = 32 //0x00000020      
constant ulong HEAP_FREE_CHECKING_ENABLED      = 64 //0x00000040      
constant ulong HEAP_DISABLE_COALESCE_ON_FREE   = 128 //0x00000080      
constant ulong HEAP_CREATE_ALIGN_16            = 65536 //0x00010000      
constant ulong HEAP_CREATE_ENABLE_TRACING      = 131072 //0x00020000 

//
//  These are the generic rights.
//

constant ulong GENERIC_READ          = 2147483648 //           (0x80000000L)
constant ulong GENERIC_WRITE        = 1073741824 //           (0x40000000L)
constant ulong GENERIC_EXECUTE    = 536870912 //              (0x20000000L)
constant ulong GENERIC_ALL               =268435456 //       (0x10000000L)

//
//  CreateToolhelp32Snapshot dwFlags
//
constant ulong	TH32CS_SNAPHEAPLIST = 1 //0x00000001
constant ulong	TH32CS_SNAPPROCESS  = 2 //0x00000002
constant ulong	TH32CS_SNAPTHREAD   = 4 //0x00000004
constant ulong	TH32CS_SNAPMODULE   = 8 //0x00000008
constant ulong	TH32CS_SNAPALL      = TH32CS_SNAPHEAPLIST + TH32CS_SNAPPROCESS + TH32CS_SNAPTHREAD + TH32CS_SNAPMODULE
constant ulong	TH32CS_INHERIT      = 2147483648 //0x80000000

//
// dwCreationFlag values
//

CONSTANT ulong DEBUG_PROCESS               = 1 //0x00000001
CONSTANT ulong DEBUG_ONLY_THIS_PROCESS     = 2 //0x00000002

CONSTANT ulong CREATE_SUSPENDED            = 4 //0x00000004

CONSTANT ulong DETACHED_PROCESS            = 8 //0x00000008

CONSTANT ulong CREATE_NEW_CONSOLE          = 16 //0x00000010

CONSTANT ulong NORMAL_PRIORITY_CLASS       = 32 //0x00000020
CONSTANT ulong IDLE_PRIORITY_CLASS         = 64 //0x00000040
CONSTANT ulong HIGH_PRIORITY_CLASS         = 128 //0x00000080
CONSTANT ulong REALTIME_PRIORITY_CLASS     = 256 //0x00000100

CONSTANT ulong CREATE_NEW_PROCESS_GROUP    = 512 //0x00000200
CONSTANT ulong CREATE_UNICODE_ENVIRONMENT  = 1024 //0x00000400

CONSTANT ulong CREATE_SEPARATE_WOW_VDM     = 2048 //0x00000800
CONSTANT ulong CREATE_SHARED_WOW_VDM       = 4096 //0x00001000
CONSTANT ulong CREATE_FORCEDOS             = 8192 //0x00002000

CONSTANT ulong BELOW_NORMAL_PRIORITY_CLASS = 16384 //0x00004000
CONSTANT ulong ABOVE_NORMAL_PRIORITY_CLASS = 32768 //0x00008000

CONSTANT ulong CREATE_BREAKAWAY_FROM_JOB   = 16777216 //0x01000000

//	Structures instances.
Public:
SECURITY_ATTRIBUTES	istr_SecurityAttributes
FILETIME	istr_Filetime
SYSTEMTIME	istr_SystemTime
win32_find_dataa	istr_Win32FindData
MEMORYSTATUS	istr_MemoryStatus
ofstruct	istr_OfStruct
STARTUPINFOA	istr_StartupInfo
PROCESS_INFORMATION	istr_ProcessInformation
PROCESSENTRY32	istr_ProcessEntry
tagchoosecolora	istr_TagChooseColor
SYSTEM_INFO	istr_SystemInfo
TIME_ZONE_INFORMATION	istr_TimeZoneInformation

end variables

on n_cst_kernel32.create
TriggerEvent( this, "constructor" )
end on

on n_cst_kernel32.destroy
TriggerEvent( this, "destructor" )
end on


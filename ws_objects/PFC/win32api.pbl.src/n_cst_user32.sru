$PBExportHeader$n_cst_user32.sru
forward
global type n_cst_user32 from nonvisualobject
end type
type tagpoint from structure within n_cst_user32
end type
type tagscrollinfo from structure within n_cst_user32
end type
type tagrect from structure within n_cst_user32
end type
type access_mask from structure within n_cst_user32
end type
type flashwinfo from structure within n_cst_user32
end type
type menuiteminfoa from structure within n_cst_user32
end type
type trackmouseevent from structure within n_cst_user32
end type
end forward

type tagPOINT from structure
	long		x
	long		y
end type

type tagSCROLLINFO from structure
	uint		cbSize
	uint		fMask
	integer		nMin
	integer		nMax
	uint		nPage
	integer		nPos
	integer		nTrackPos
end type

type tagRECT from structure
	long		left
	long		top
	long		right
	long		bottom
end type

type ACCESS_MASK from structure
	long		SpecificRights
	character		StandardRights
	character		AccessSystemAcl
	character		Reserved[3]
	character		GenericAll
	character		GenericExecute
	character		GenericWrite
	character		GenericRead
end type

type FLASHWINFO from structure
	uint		cbSize
	ulong		hWnd
	ulong		dwFlags
	uint		uCount
	ulong		dwTimeout
end type

type MENUITEMINFOA from structure
	uint		cbSize
	uint		fMask
	uint		fType
	uint		fState
	uint		wID
	ulong		hSubMenu
	ulong		hbmpChecked
	ulong		hbmpUnchecked
	ulong		dwItemData
	ulong		dwTypeData
	uint		cch
end type

type trackmouseevent from structure
	unsignedlong		cbSize
	unsignedlong		dwFlags
	unsignedlong		hwndTrack
	unsignedlong		dwHoverTime
end type

global type n_cst_user32 from nonvisualobject autoinstantiate
end type

type prototypes
subroutine ClientToScreen (ulong hWnd, ref tagpoint lpPoint) Library "USER32.DLL" alias for "ClientToScreen;Ansi"
function ulong FindWindow ( ref string lpClassName, ref string lpWindowName) Library "USER32.DLL" Alias for "FindWindowA;Ansi"
Function boolean FlashWindow (ulong hWnd, boolean bInvert) Library "USER32.DLL"
Function ulong GetActiveWindow () Library "USER32.DLL"
Function int GetClassName (uint hWnd, ref string lpClassName, int nMaxCount) Library "USER32.DLL" Alias for "GetClassNameA;Ansi"
Function ulong GetDC (ulong hWnd) Library "USER32.DLL"
Function ulong GetDesktopWindow () Library "USER32.DLL"
Function ulong GetLastActivePopup (ulong hWnd) Library "USER32.DLL"
Function ulong GetSysColor (int nIndex) Library "USER32.DLL"
Function int GetSystemMetrics (int nIndex) Library "USER32.DLL"
Function ulong GetWindow (ulong hWnd, uint hWnd) Library "USER32.DLL"
Function int GetWindowText (ulong hWnd, ref string lpString, int nMaxCount) Library "USER32.DLL" Alias for "GetWindowTextA;Ansi"
Function boolean IsWindowVisible (ulong hWnd) Library "USER32.DLL"
Function Boolean KillTimer (ulong hWnd, uint uIDEvent) Library "USER32.DLL"
Function int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"
Function uint SetTimer (ulong hWnd, uint nIDEvent, uint uElapse, ulong lpTimerFunc) Library "USER32.DLL"  //set lpTimerFunc to null, i.e. no callback function
Function boolean ShowWindow (ulong hWnd, int nCmdShow) Library "USER32.DLL"

Function boolean SetCaretBlinkTime (uint uMSeconds) Library "USER32.DLL"
Function uint GetCaretBlinkTime () Library "USER32.DLL"
Function boolean SetCursorPos (int X, int Y) Library "USER32.DLL"
Function int ShowCursor (boolean bShow) Library "USER32.DLL"
Function uint GetDoubleClickTime () Library "USER32.DLL"
Function boolean SetDoubleClickTime (uint uMSeconds) Library "USER32.DLL"
Function boolean IsWindow (ulong hWnd) Library "USER32.DLL"
Function boolean IsMenu (ulong hMenu) Library "USER32.DLL"
Function boolean IsChild (ulong hWndParent, ulong hWnd) Library "USER32.DLL"
Function boolean MoveWindow (ulong hWnd, int X, int Y, int nWidth, int nHeight, boolean bRepaint) Library "USER32.DLL"
Function boolean SwapMouseButton (boolean fSwap) Library "USER32.DLL"
Function ulong GetMessagePos () Library "USER32.DLL"
Function long GetMessageTime () Library "USER32.DLL"
Function boolean BringWindowToTop (ulong hWnd) Library "USER32.DLL"
Function boolean IsIconic (ulong hWnd) Library "USER32.DLL"
Function boolean OpenIcon (ulong hWnd) Library "USER32.DLL"
Function ulong GetClipboardViewer () Library "USER32.DLL"
Function boolean EmptyClipboard () library 'kernel32'
Function boolean HideCaret (ulong hWnd) Library "USER32.DLL"
Function boolean ShowCaret (ulong hWnd) Library "USER32.DLL"
Function long GetWindowWord (ulong hWnd, int nIndex) Library "USER32.DLL"
Function long GetWindowLong (ulong hWnd, int nIndex) Library "USER32.DLL"  Alias for "GetWindowLongA"
Function long SetWindowLong (ulong hWnd, int nIndex, long dwNewLong) Library "USER32.DLL" Alias for "SetWindowLongA"
Function boolean IsZoomed (ulong hWnd) Library "USER32.DLL"
Function ulong GetMenu (ulong hWnd) Library "USER32.DLL"
Function ulong CreateMenu () Library "USER32.DLL"
Function boolean InsertMenu (ulong hMenu, uint uPosition, uint uFlags, ref uint uIDNewItem, ref string lpNewItem) Library "USER32.DLL" Alias for "InsertMenuA;Ansi"
Function boolean DrawMenuBar (ulong hWnd) Library "USER32.DLL"
Function boolean DestroyMenu (ulong hMenu) Library "USER32.DLL"
Function boolean RemoveMenu (ulong hMenu, uint uPosition, uint uFlags) Library "USER32.DLL"
Function boolean CloseWindow (ulong hWnd) Library "USER32.DLL"
Function boolean DeleteMenu (ulong hMenu, uint uPosition, uint uFlags) Library "USER32.DLL"
Function boolean DestroyWindow (ulong hWnd) Library "USER32.DLL"
Function boolean ExitWindowsEx (uint uFlags, ulong dwReserved) Library "USER32.DLL"
Function ulong GetCapture () Library "USER32.DLL"
Function ulong GetCursor () Library "USER32.DLL"
Function boolean GetKeyboardState (ref char lpKeyState) Library "USER32.DLL" alias for "GetKeyboardState;Ansi"
Function boolean SetKeyboardState (ref char lpKeyState) Library "USER32.DLL" alias for "SetKeyboardState;Ansi"
Function int GetKeyState (int nVirtKey) Library "USER32.DLL"
Function ulong GetParent (ulong hWnd) Library "USER32.DLL"
Function ulong GetSystemMenu (ulong hWnd, boolean bRevert) Library "USER32.DLL"
Function int MessageBox (ulong hWnd, ref string lpText, ref string lpCaption, uint uType) Library "USER32.DLL" Alias for "MessageBoxA;Ansi"
Function boolean PostMessage (ulong hWnd, uint Msg, ulong wParam, ulong lParam) Library "USER32.DLL" Alias for "PostMessageA"
Function ulong SendMessage (ulong hWnd, uint Msg, ulong wParam, ulong lParam) Library "USER32.DLL" Alias for "SendMessageA"
Function ulong SetCapture (ulong hWnd) Library "USER32.DLL"
Function boolean ReleaseCapture () Library "USER32.DLL"
Function ulong SetFocus (long hWnd) Library "USER32.DLL"
Function int SetScrollInfo (ulong hWnd, int fnBar, ref tagSCROLLINFO LPCSCROLLINFO, boolean fRedraw) Library "USER32.DLL" alias for "SetScrollInfo;Ansi"
Function boolean GetScrollInfo (ulong hWnd, int fnBar, ref tagSCROLLINFO LPCSCROLLINFO) Library "USER32.DLL" alias for "GetScrollInfo;Ansi"
Function ulong GetForegroundWindow () Library "USER32.DLL"
Function boolean SetForegroundWindow (ulong hWnd) Library "USER32.DLL"
Function boolean GetCaretPos (ref tagpoint lpPoint ) Library "USER32.DLL" alias for "GetCaretPos;Ansi"
Function boolean GetClientRect (ulong hWnd, ref tagRECT lpRect) Library "USER32.DLL" alias for "GetClientRect;Ansi"
Function boolean RegisterHotKey (ulong hWnd, int id,uint fsModifiers,uint vk)  Library "USER32.DLL"
Function boolean UnregisterHotKey (ulong hWnd, int id) Library "USER32.DLL"
Function boolean RedrawWindow (ulong hWnd, ref ulong lprcUpdate, ulong hrgnUpdate,  uint flags) Library "USER32.DLL"
Function boolean EnableMenuItem (ulong hMenu, uint uIDEnableItem, uint uEnable) Library "USER32.DLL"
Function boolean ScreenToClient (ulong hWnd, ref tagpoint lpPoint ) Library "USER32.DLL" alias for "ScreenToClient;Ansi"
Subroutine keybd_event (char bVk, char bScan, ulong dwFlags, ref ulong dwExtraInfo)  Library "USER32.DLL" alias for "keybd_event;Ansi"
Function int DrawText (ulong hDC, ref string lpString, int nCount, ref tagRECT lpRect, uint uFormat ) Library "USER32.DLL" Alias for "DrawTextA;Ansi"
Function int FillRect ( ulong hDC, ref tagRECT lprc, ulong hBrush) Library "USER32.DLL" alias for "FillRect;Ansi"
Function boolean SetSysColors (int cElements, ref int lpaElements[], ref ulong lpaRgbValues[]) Library "USER32.DLL"
Function ulong SetActiveWindow (ulong hWnd) Library "USER32.DLL"
Function ulong OpenDesktop (ref string lpszDesktop, ulong dwFlags, boolean fInherit, ref ACCESS_MASK dwDesiredAccess) Library "USER32.DLL" Alias for "OpenDesktopA;Ansi"
Function boolean SetThreadDesktop (ulong hDesktop) Library "USER32.DLL"
Function ulong GetThreadDesktop (ulong dwThreadId) Library "USER32.DLL"
Function boolean CloseDesktop (ulong hDesktop) Library "USER32.DLL"
Function boolean GetCursorPos (ref tagpoint lpPoint) Library "USER32.DLL" alias for "GetCursorPos;Ansi"
Function ulong WindowFromPoint (long ptx, long pty) Library "USER32.DLL"
Function ulong ChildWindowFromPoint (ulong hWndParent, long ptx, long pty) Library "USER32.DLL"
Function ulong SetParent (ulong hWndChild, ulong hWndNewParent) Library "USER32.DLL"
Function boolean SystemParametersInfo (uint uiAction, uint uiParam, ref ulong pvParam, uint fWinIni) Library "USER32.DLL" Alias for "SystemParametersInfoA"
Function ulong CreateWindowEx (ulong dwExStyle, ref string lpClassName, ref string lpWindowName, ulong dwStyle, int X, int Y, int nWidth, int nHeight, ulong hWndParent, ulong hMenu, ulong hInstance, ulong lpParam) Library "USER32.DLL" Alias for "CreateWindowExA;Ansi"
Function uint MapVirtualKey (uint uCode, uint uMapType ) Library "USER32.DLL" Alias for "MapVirtualKeyA"
Function int GetWindowRgn (ulong hWnd, ulong hRgn ) Library "USER32.DLL"
Function int SetWindowRgn (ulong hWnd, ulong hRgn, boolean bRedraw ) Library "USER32.DLL"
Function boolean SetWindowPos (ulong hWnd, ulong hWndInsertAfter, int X, int Y,  int cx, int cy, uint uFlags) Library "USER32.DLL"
Function boolean MessageBeep (uint uType) Library "USER32.DLL"
Function boolean AnimateWindow (ulong hWnd, ulong dwTime, ulong dwFlags) Library "USER32.DLL"
Function boolean FlashWindowEx (ref FLASHWINFO pfwi) Library "USER32.DLL" alias for "FlashWindowEx;Ansi"
Function ulong LoadCursor (ulong hInstance, ulong lpCursorName) Library "USER32.DLL" Alias for "LoadCursorA"
Function ulong SetCursor (ulong hCursor) Library "USER32.DLL"
Function boolean DestroyCursor (ulong hCursor) Library "USER32.DLL"
Function ulong GetWindowDC (ulong hWnd) Library "USER32.DLL"
Function boolean OpenClipboard (ulong hWndNewOwner) Library "USER32.DLL"
Function ulong SetClipboardData (uint uFormat, ulong hMem) Library "USER32.DLL"
Function boolean CloseClipboard () Library "USER32.DLL"
Function boolean ClipCursor (ref tagRECT lpRect) Library "USER32.DLL" alias for "ClipCursor;Ansi"
Function uint GetMenuItemID (ulong hMenu, int nPos) Library "USER32.DLL"
Function boolean GetMenuItemInfo (ulong hMenu, uint uItem, boolean fByPosition, ref MENUITEMINFOA lpmii) Library "USER32.DLL" Alias for "GetMenuItemInfoA;Ansi"
Function boolean InsertMenuItem (ulong hMenu, uint uItem, boolean fByPosition, ref MENUITEMINFOA lpmii) Library "USER32.DLL" Alias for "InsertMenuItemA;Ansi"
Function boolean SetMenu (ulong hWnd, ulong hMenu) Library "USER32.DLL" 
Function int GetMenuItemCount (ulong hMenu) Library "USER32.DLL" 
Function ulong GetSubMenu (ulong hMenu, int nPos) Library "USER32.DLL" 
Function int GetWindowTextLength (ulong hWnd) Library "USER32.DLL" Alias for "GetWindowTextLengthA"
Function Boolean InvalidateRect (ulong hWnd, tagRECT lpRect, Boolean bErase) Library "USER32.DLL" alias for "InvalidateRect;Ansi" 
Function Boolean TrackMouseEvent (ref trackmouseevent lpEventTrack) Library "USER32.DLL" alias for "TrackMouseEvent;Ansi"
Function Boolean PtInRect (ref tagRECT lprect, long x, long y) Library "USER32.DLL" alias for "PtInRect;Ansi"
Function Boolean PtInRect (ref tagRECT lprect, tagPoint pt) Library "USER32.DLL" alias for "PtInRect;Ansi"
Function ulong LoadIcon (ulong hinst, string lpIconName) Library "USER32.DLL" Alias for "LoadIconA;Ansi"
Function ulong LoadImage (ulong hinst, string lpszName, uint uType, int cxDesired, int cyDesired, uint fuLoad) Library "USER32.DLL" Alias for "LoadImageA;Ansi"
Function Boolean DestroyIcon (ulong hinst) Library "USER32.DLL"
Function ulong WaitForInputIdle (ulong hProcess, ulong dwMilliseconds) Library "USER32.DLL"

Function long GetKeyboardLayout  (long IdThread) Library "user32.dll"
Function long ActivateKeyboardLayout (long HKL, long flags) Library "user32.dll"

end prototypes

type variables
public:
/*
 * Color Types
 */
constant int CTLCOLOR_MSGBOX         = 0
constant int CTLCOLOR_EDIT           = 1
constant int CTLCOLOR_LISTBOX        = 2
constant int CTLCOLOR_BTN            = 3
constant int CTLCOLOR_DLG            = 4
constant int CTLCOLOR_SCROLLBAR      = 5
constant int CTLCOLOR_STATIC         = 6
constant int CTLCOLOR_MAX            = 7
constant int COLOR_SCROLLBAR         = 0
constant int COLOR_BACKGROUND        = 1
constant int COLOR_ACTIVECAPTION     = 2
constant int COLOR_INACTIVECAPTION   = 3
constant int COLOR_MENU              = 4
constant int COLOR_WINDOW            = 5
constant int COLOR_WINDOWFRAME       = 6
constant int COLOR_MENUTEXT          = 7
constant int COLOR_WINDOWTEXT        = 8
constant int COLOR_CAPTIONTEXT       = 9
constant int COLOR_ACTIVEBORDER      = 10
constant int COLOR_INACTIVEBORDER    = 11
constant int COLOR_APPWORKSPACE      = 12
constant int COLOR_HIGHLIGHT         = 13
constant int COLOR_HIGHLIGHTTEXT     = 14
constant int COLOR_BTNFACE           = 15
constant int COLOR_BTNSHADOW         = 16
constant int COLOR_GRAYTEXT          = 17
constant int COLOR_BTNTEXT           = 18
constant int COLOR_INACTIVECAPTIONTEXT = 19
constant int COLOR_BTNHIGHLIGHT      = 20
constant int COLOR_3DDKSHADOW        = 21
constant int COLOR_3DLIGHT           = 22
constant int COLOR_INFOTEXT          = 23
constant int COLOR_INFOBK            = 24
constant int COLOR_DESKTOP           = COLOR_BACKGROUND
constant int COLOR_3DFACE            = COLOR_BTNFACE
constant int COLOR_3DSHADOW          = COLOR_BTNSHADOW
constant int COLOR_3DHIGHLIGHT       = COLOR_BTNHIGHLIGHT
constant int COLOR_3DHILIGHT         = COLOR_BTNHIGHLIGHT
constant int COLOR_BTNHILIGHT        = COLOR_BTNHIGHLIGHT

/*
 * GetSystemMetrics() codes
 */

constant int SM_CXSCREEN             = 0
constant int SM_CYSCREEN             = 1
constant int SM_CXVSCROLL            = 2
constant int SM_CYHSCROLL            = 3
constant int SM_CYCAPTION            = 4
constant int SM_CXBORDER             = 5
constant int SM_CYBORDER             = 6
constant int SM_CXDLGFRAME           = 7
constant int SM_CYDLGFRAME           = 8
constant int SM_CYVTHUMB             = 9
constant int SM_CXHTHUMB             = 10
constant int SM_CXICON               = 11
constant int SM_CYICON               = 12
constant int SM_CXCURSOR             = 13
constant int SM_CYCURSOR             = 14
constant int SM_CYMENU               = 15
constant int SM_CXFULLSCREEN         = 16
constant int SM_CYFULLSCREEN         = 17
constant int SM_CYKANJIWINDOW        = 18
constant int SM_MOUSEPRESENT         = 19
constant int SM_CYVSCROLL            = 20
constant int SM_CXHSCROLL            = 21
constant int SM_DEBUG                = 22
constant int SM_SWAPBUTTON           = 23
constant int SM_RESERVED1            = 24
constant int SM_RESERVED2            = 25
constant int SM_RESERVED3            = 26
constant int SM_RESERVED4            = 27
constant int SM_CXMIN                = 28
constant int SM_CYMIN                = 29
constant int SM_CXSIZE               = 30
constant int SM_CYSIZE               = 31
constant int SM_CXFRAME              = 32
constant int SM_CYFRAME              = 33
constant int SM_CXMINTRACK           = 34
constant int SM_CYMINTRACK           = 35
constant int SM_CXDOUBLECLK          = 36
constant int SM_CYDOUBLECLK          = 37
constant int SM_CXICONSPACING        = 38
constant int SM_CYICONSPACING        = 39
constant int SM_MENUDROPALIGNMENT    = 40
constant int SM_PENWINDOWS           = 41
constant int SM_DBCSENABLED          = 42
constant int SM_CMOUSEBUTTONS        = 43

constant int SM_CXFIXEDFRAME           = SM_CXDLGFRAME  /* ;win40 name change */
constant int SM_CYFIXEDFRAME           = SM_CYDLGFRAME  /* ;win40 name change */
constant int SM_CXSIZEFRAME            = SM_CXFRAME     /* ;win40 name change */
constant int SM_CYSIZEFRAME            = SM_CYFRAME     /* ;win40 name change */

constant int SM_SECURE               = 44
constant int SM_CXEDGE               = 45
constant int SM_CYEDGE               = 46
constant int SM_CXMINSPACING         = 47
constant int SM_CYMINSPACING         = 48
constant int SM_CXSMICON             = 49
constant int SM_CYSMICON             = 50
constant int SM_CYSMCAPTION          = 51
constant int SM_CXSMSIZE             = 52
constant int SM_CYSMSIZE             = 53
constant int SM_CXMENUSIZE           = 54
constant int SM_CYMENUSIZE           = 55
constant int SM_ARRANGE              = 56
constant int SM_CXMINIMIZED          = 57
constant int SM_CYMINIMIZED          = 58
constant int SM_CXMAXTRACK           = 59
constant int SM_CYMAXTRACK           = 60
constant int SM_CXMAXIMIZED          = 61
constant int SM_CYMAXIMIZED          = 62
constant int SM_NETWORK              = 63
constant int SM_CLEANBOOT            = 67
constant int SM_CXDRAG               = 68
constant int SM_CYDRAG               = 69
constant int SM_SHOWSOUNDS           = 70
constant int SM_CXMENUCHECK          = 71   /* Use instead of GetMenuCheckMarkDimensions()! */
constant int SM_CYMENUCHECK          = 72
constant int SM_SLOWMACHINE          = 73
constant int SM_MIDEASTENABLED       = 74
constant int SM_CMETRICS             = 76

/*
 * GetWindow() Constants
 */
constant int GW_HWNDFIRST        = 0
constant int GW_HWNDLAST         = 1
constant int GW_HWNDNEXT         = 2
constant int GW_HWNDPREV         = 3
constant int GW_OWNER            = 4
constant int GW_CHILD            = 5
constant int GW_ENABLEDPOPUP     = 6
constant int GW_MAX              = 6

/*
 * ShowWindow() Commands
 */
constant int SW_HIDE             = 0
constant int SW_SHOWNORMAL       = 1
constant int SW_NORMAL           = 1
constant int SW_SHOWMINIMIZED    = 2
constant int SW_SHOWMAXIMIZED    = 3
constant int SW_MAXIMIZE         = 3
constant int SW_SHOWNOACTIVATE   = 4
constant int SW_SHOW             = 5
constant int SW_MINIMIZE         = 6
constant int SW_SHOWMINNOACTIVE  = 7
constant int SW_SHOWNA           = 8
constant int SW_RESTORE          = 9
constant int SW_SHOWDEFAULT      = 10
constant int SW_FORCEMINIMIZE    = 11
constant int SW_MAX              = 11

/*
 * Old ShowWindow() Commands
 */
constant int HIDE_WINDOW         = 0
constant int SHOW_OPENWINDOW     = 1
constant int SHOW_ICONWINDOW     = 2
constant int SHOW_FULLSCREEN     = 3
constant int SHOW_OPENNOACTIVATE = 4

/*
 * Identifiers for the WM_SHOWWINDOW message
 */
constant int SW_PARENTCLOSING    = 1
constant int SW_OTHERZOOM        = 2
constant int SW_PARENTOPENING    = 3
constant int SW_OTHERUNZOOM      = 4

/*
 * Window field offsets for GetWindowLong()
 */
constant int GWL_WNDPROC         = -4
constant int GWL_HINSTANCE       = -6
constant int GWL_HWNDPARENT      = -8
constant int GWL_STYLE           = -16
constant int GWL_EXSTYLE         = -20
constant int GWL_USERDATA        = -21
constant int GWL_ID              = -12

/*
 * MessageBox() Flags
 */
constant ulong MB_OK                       = 0 //0x00000000L
constant ulong MB_OKCANCEL                = 1 // 0x00000001L
constant ulong MB_ABORTRETRYIGNORE         = 2 //0x00000002L
constant ulong MB_YESNOCANCEL              = 3 //0x00000003L
constant ulong MB_YESNO                    = 4 //0x00000004L
constant ulong MB_RETRYCANCEL              = 5 //0x00000005L
constant ulong MB_ICONHAND                 = 16 //0x00000010L
constant ulong MB_ICONQUESTION             = 32 //0x00000020L
constant ulong MB_ICONEXCLAMATION          = 48 //0x00000030L
constant ulong MB_ICONASTERISK             = 64 //0x00000040L
constant ulong MB_USERICON                 = 128 //0x00000080L
constant ulong MB_ICONWARNING              = MB_ICONEXCLAMATION
constant ulong MB_ICONERROR                = MB_ICONHAND
constant ulong MB_ICONINFORMATION         =  MB_ICONASTERISK
constant ulong MB_ICONSTOP                 = MB_ICONHAND
constant ulong MB_DEFBUTTON1               = 0 //0x00000000L
constant ulong MB_DEFBUTTON2               = 256 //0x00000100L
constant ulong MB_DEFBUTTON3               = 512 //0x00000200L
constant ulong MB_DEFBUTTON4               = 768 //0x00000300L
constant ulong MB_APPLMODAL                = 0 //0x00000000L
constant ulong MB_SYSTEMMODAL              = 4096 //0x00001000L
constant ulong MB_TASKMODAL                = 8192 //0x00002000L
constant ulong MB_HELP                     = 16384 //0x00004000L - Help Button
constant ulong MB_NOFOCUS                  = 32768 //0x00008000L
constant ulong MB_SETFOREGROUND            = 65536 //0x00010000L
constant ulong MB_DEFAULT_DESKTOP_ONLY     = 131072 //0x00020000L
constant ulong MB_TOPMOST                  = 262144 //0x00040000L
constant ulong MB_RIGHT                    = 524288 //0x00080000L
constant ulong MB_RTLREADING               = 1048576 //0x00100000L
constant ulong MB_TYPEMASK                 = 15 //0x0000000FL
constant ulong MB_ICONMASK                 = 240 //0x000000F0L
constant ulong MB_DEFMASK                  = 3840 //0x00000F00L
constant ulong MB_MODEMASK                 = 12288 //0x00003000L
constant ulong MB_MISCMASK                 = 49152 //0x0000C000L

//Scroll Bar Constants
CONSTANT uint SB_HORZ = 0 
CONSTANT uint SB_VERT = 1 
CONSTANT uint SB_CTL = 2 
CONSTANT uint SB_BOTH = 3 

//Scroll Bar Commands
CONSTANT uint SB_LINEUP=0
CONSTANT uint SB_LINELEFT=0
CONSTANT uint SB_LINEDOWN =1
CONSTANT uint SB_LINERIGHT =1
CONSTANT uint SB_PAGEUP= 2
CONSTANT uint SB_PAGELEFT=2
CONSTANT uint SB_PAGEDOWN=3
CONSTANT uint SB_PAGERIGHT=3
CONSTANT uint SB_THUMBPOSITION=4
CONSTANT uint SB_THUMBTRACK=5
CONSTANT uint SB_TOP=6
CONSTANT uint SB_LEFT=6
CONSTANT uint SB_BOTTOM=7
CONSTANT uint SB_RIGHT=7
CONSTANT uint SB_ENDSCROLL=8

//Scroll bar messages
CONSTANT uint SBM_SETPOS= 224 
CONSTANT uint SBM_GETPOS = 225 
CONSTANT uint SBM_SETRANGE= 226 
CONSTANT uint SBM_SETRANGEREDRAW = 230 
CONSTANT uint SBM_GETRANGE= 227 
CONSTANT uint SBM_ENABLE_ARROWS = 228 
CONSTANT uint SBM_SETSCROLLINFO = 233 
CONSTANT uint SBM_GETSCROLLINFO= 234 
CONSTANT uint SIF_RANGE = 1 
CONSTANT uint SIF_PAGE= 2 
CONSTANT uint SIF_POS= 4 
CONSTANT uint SIF_DISABLENOSCROLL= 8 
CONSTANT uint SIF_TRACKPOS= 16 
CONSTANT uint SIF_ALL = 0

//Size of SCROLLINFO structure - convinience, not from any Windows header
CONSTANT uint SIF_SIZE = 28

/*
 * Parameter for SystemParametersInfo()
 */

CONSTANT uint SPI_GETBEEP                 = 1
CONSTANT uint SPI_SETBEEP                 = 2
CONSTANT uint SPI_GETMOUSE                = 3
CONSTANT uint SPI_SETMOUSE                = 4
CONSTANT uint SPI_GETBORDER               = 5
CONSTANT uint SPI_SETBORDER               = 6
CONSTANT uint SPI_GETKEYBOARDSPEED       = 10
CONSTANT uint SPI_SETKEYBOARDSPEED       = 11
CONSTANT uint SPI_LANGDRIVER             = 12
CONSTANT uint SPI_ICONHORIZONTALSPACING  = 13
CONSTANT uint SPI_GETSCREENSAVETIMEOUT   = 14
CONSTANT uint SPI_SETSCREENSAVETIMEOUT   = 15
CONSTANT uint SPI_GETSCREENSAVEACTIVE    = 16
CONSTANT uint SPI_SETSCREENSAVEACTIVE    = 17
CONSTANT uint SPI_GETGRIDGRANULARITY     = 18
CONSTANT uint SPI_SETGRIDGRANULARITY     = 19
CONSTANT uint SPI_SETDESKWALLPAPER       = 20
CONSTANT uint SPI_SETDESKPATTERN         = 21
CONSTANT uint SPI_GETKEYBOARDDELAY       = 22
CONSTANT uint SPI_SETKEYBOARDDELAY       = 23
CONSTANT uint SPI_ICONVERTICALSPACING    = 24
CONSTANT uint SPI_GETICONTITLEWRAP       = 25
CONSTANT uint SPI_SETICONTITLEWRAP       = 26
CONSTANT uint SPI_GETMENUDROPALIGNMENT   = 27
CONSTANT uint SPI_SETMENUDROPALIGNMENT   = 28
CONSTANT uint SPI_SETDOUBLECLKWIDTH      = 29
CONSTANT uint SPI_SETDOUBLECLKHEIGHT     = 30
CONSTANT uint SPI_GETICONTITLELOGFONT    = 31
CONSTANT uint SPI_SETDOUBLECLICKTIME     = 32
CONSTANT uint SPI_SETMOUSEBUTTONSWAP     = 33
CONSTANT uint SPI_SETICONTITLELOGFONT    = 34
CONSTANT uint SPI_GETFASTTASKSWITCH      = 35
CONSTANT uint SPI_SETFASTTASKSWITCH      = 36
CONSTANT uint SPI_SETDRAGFULLWINDOWS     = 37
CONSTANT uint SPI_GETDRAGFULLWINDOWS     = 38
CONSTANT uint SPI_GETNONCLIENTMETRICS    = 41
CONSTANT uint SPI_SETNONCLIENTMETRICS    = 42
CONSTANT uint SPI_GETMINIMIZEDMETRICS    = 43
CONSTANT uint SPI_SETMINIMIZEDMETRICS    = 44
CONSTANT uint SPI_GETICONMETRICS         = 45
CONSTANT uint SPI_SETICONMETRICS         = 46
CONSTANT uint SPI_SETWORKAREA            = 47
CONSTANT uint SPI_GETWORKAREA            = 48
CONSTANT uint SPI_SETPENWINDOWS          = 49
CONSTANT uint SPI_GETHIGHCONTRAST        = 66
CONSTANT uint SPI_SETHIGHCONTRAST        = 67
CONSTANT uint SPI_GETKEYBOARDPREF        = 68
CONSTANT uint SPI_SETKEYBOARDPREF        = 69
CONSTANT uint SPI_GETSCREENREADER        = 70
CONSTANT uint SPI_SETSCREENREADER        = 71
CONSTANT uint SPI_GETANIMATION           = 72
CONSTANT uint SPI_SETANIMATION           = 73
CONSTANT uint SPI_GETFONTSMOOTHING       = 74
CONSTANT uint SPI_SETFONTSMOOTHING       = 75
CONSTANT uint SPI_SETDRAGWIDTH           = 76
CONSTANT uint SPI_SETDRAGHEIGHT          = 77
CONSTANT uint SPI_SETHANDHELD            = 78
CONSTANT uint SPI_GETLOWPOWERTIMEOUT     = 79
CONSTANT uint SPI_GETPOWEROFFTIMEOUT     = 80
CONSTANT uint SPI_SETLOWPOWERTIMEOUT     = 81
CONSTANT uint SPI_SETPOWEROFFTIMEOUT     = 82
CONSTANT uint SPI_GETLOWPOWERACTIVE      = 83
CONSTANT uint SPI_GETPOWEROFFACTIVE      = 84
CONSTANT uint SPI_SETLOWPOWERACTIVE      = 85
CONSTANT uint SPI_SETPOWEROFFACTIVE      = 86
CONSTANT uint SPI_SETCURSORS             = 87
CONSTANT uint SPI_SETICONS               = 88
CONSTANT uint SPI_GETDEFAULTINPUTLANG    = 89
CONSTANT uint SPI_SETDEFAULTINPUTLANG    = 90
CONSTANT uint SPI_SETLANGTOGGLE          = 91
CONSTANT uint SPI_GETWINDOWSEXTENSION    = 92
CONSTANT uint SPI_SETMOUSETRAILS         = 93
CONSTANT uint SPI_GETMOUSETRAILS         = 94
CONSTANT uint SPI_SETSCREENSAVERRUNNING  = 97
CONSTANT uint SPI_SCREENSAVERRUNNING     = SPI_SETSCREENSAVERRUNNING
CONSTANT uint SPI_GETFILTERKEYS          = 50
CONSTANT uint SPI_SETFILTERKEYS          = 51
CONSTANT uint SPI_GETTOGGLEKEYS          = 52
CONSTANT uint SPI_SETTOGGLEKEYS          = 53
CONSTANT uint SPI_GETMOUSEKEYS           = 54
CONSTANT uint SPI_SETMOUSEKEYS           = 55
CONSTANT uint SPI_GETSHOWSOUNDS          = 56
CONSTANT uint SPI_SETSHOWSOUNDS          = 57
CONSTANT uint SPI_GETSTICKYKEYS          = 58
CONSTANT uint SPI_SETSTICKYKEYS          = 59
CONSTANT uint SPI_GETACCESSTIMEOUT       = 60
CONSTANT uint SPI_SETACCESSTIMEOUT       = 61
CONSTANT uint SPI_GETSERIALKEYS          = 62
CONSTANT uint SPI_SETSERIALKEYS          = 63
CONSTANT uint SPI_GETSOUNDSENTRY         = 64
CONSTANT uint SPI_SETSOUNDSENTRY         = 65
CONSTANT uint SPI_GETSNAPTODEFBUTTON     = 95
CONSTANT uint SPI_SETSNAPTODEFBUTTON     = 96
CONSTANT uint SPI_GETMOUSEHOVERWIDTH     = 98
CONSTANT uint SPI_SETMOUSEHOVERWIDTH     = 99
CONSTANT uint SPI_GETMOUSEHOVERHEIGHT   = 100
CONSTANT uint SPI_SETMOUSEHOVERHEIGHT   = 101
CONSTANT uint SPI_GETMOUSEHOVERTIME     = 102
CONSTANT uint SPI_SETMOUSEHOVERTIME     = 103
CONSTANT uint SPI_GETWHEELSCROLLLINES   = 104
CONSTANT uint SPI_SETWHEELSCROLLLINES   = 105
CONSTANT uint SPI_GETMENUSHOWDELAY      = 106
CONSTANT uint SPI_SETMENUSHOWDELAY      = 107
CONSTANT uint SPI_GETSHOWIMEUI          = 110
CONSTANT uint SPI_SETSHOWIMEUI          = 111

/*
 * Flags
 */
CONSTANT uint SPIF_UPDATEINIFILE     = 1 //0x0001
CONSTANT uint SPIF_SENDWININICHANGE = 2 //0x0002
CONSTANT uint SPIF_SENDCHANGE       = SPIF_SENDWININICHANGE

/*
 * Window style for SetWindowLong()
 */

CONSTANT ulong WS_OVERLAPPED        =          0 //&H0&
CONSTANT ulong WS_EX_DLGMODALFRAME  =          1 //&H1&
CONSTANT ulong WS_EX_NOPARENTNOTIFY =          4 //&H4&
CONSTANT ulong WS_EX_TOPMOST        =          8 //&H8&
CONSTANT ulong WS_EX_ACCEPTFILES    =         16 //&H10&
CONSTANT ulong WS_EX_TRANSPARENT    =         32 //&H20&
CONSTANT ulong WS_MAXIMIZEBOX       =      65536 //&H10000
CONSTANT ulong WS_MINIMIZEBOX       =     131072 //&H20000
CONSTANT ulong WS_THICKFRAME        =     262144 //&H40000
CONSTANT ulong WS_SYSMENU           =     524288 //&H80000
CONSTANT ulong WS_HSCROLL           =    1048576 //&H100000
CONSTANT ulong WS_VSCROLL           =    2097152 //&H200000
CONSTANT ulong WS_DLGFRAME          =    4194304 //&H400000
CONSTANT ulong WS_BORDER            =    8388608 //&H800000
CONSTANT ulong WS_MAXIMIZE          =   16777216 //&H1000000
CONSTANT ulong WS_CLIPCHILDREN      =   33554432 //&H2000000
CONSTANT ulong WS_CLIPSIBLINGS      =   67108864 //&H4000000
CONSTANT ulong WS_DISABLED          =  134217728 //&H8000000
CONSTANT ulong WS_VISIBLE           =  268435456 //&H10000000
CONSTANT ulong WS_MINIMIZE          =  536870912 //&H20000000
CONSTANT ulong WS_CHILD             = 1073741824 //&H40000000
CONSTANT ulong WS_POPUP             = 2147483648 //&H80000000

CONSTANT ulong WS_TILED             =   WS_OVERLAPPED
CONSTANT ulong WS_SIZEBOX           =   WS_THICKFRAME
CONSTANT ulong WS_ICONIC            =   WS_MINIMIZE
CONSTANT ulong WS_CAPTION           = ( WS_BORDER + WS_DLGFRAME )
CONSTANT ulong WS_CHILDWINDOW       = ( WS_CHILD + &
									 WS_CAPTION + &
													 WS_SYSMENU + &
													 WS_THICKFRAME + &
													 WS_MINIMIZEBOX + &
													 WS_MAXIMIZEBOX )
CONSTANT ulong WS_OVERLAPPEDWINDOW  = ( WS_OVERLAPPED + &
													 WS_CAPTION + &
													 WS_SYSMENU + &
													 WS_THICKFRAME + &
													 WS_MINIMIZEBOX + &
													 WS_MAXIMIZEBOX )
CONSTANT ulong WS_TILEDWINDOW			=   WS_OVERLAPPEDWINDOW
CONSTANT ulong WS_POPUPWINDOW			= ( WS_POPUP + &
													 WS_BORDER + &
													 WS_SYSMENU )
// my definitions										
CONSTANT ulong WS_MAIN_C				= ( WS_VISIBLE + &
													 WS_CLIPSIBLINGS + &
													 WS_CLIPCHILDREN + &
													 WS_CAPTION + &
													 WS_SYSMENU + &
													 WS_THICKFRAME + &
													 WS_MINIMIZEBOX )

CONSTANT ulong WS_CHILD_C				= ( WS_CHILD + &
													 WS_VISIBLE + &
													 WS_CLIPSIBLINGS + &
													 WS_CLIPCHILDREN + &
													 WS_CAPTION + &
													 WS_SYSMENU + &
													 WS_THICKFRAME + &
													 WS_MINIMIZEBOX + &
													 WS_MAXIMIZEBOX )

CONSTANT ulong WS_POPUP_C				= ( WS_POPUP + &
													 WS_VISIBLE + &
													 WS_CLIPSIBLINGS + &
													 WS_CLIPCHILDREN + &
													 WS_CAPTION + &
													 WS_SYSMENU + &
													 WS_MAXIMIZEBOX )

CONSTANT ulong WS_RESPONSE_C			= ( WS_POPUP + &
													 WS_VISIBLE + &
													 WS_CLIPSIBLINGS + &
													 WS_CLIPCHILDREN + &
													 WS_CAPTION + &
													 WS_THICKFRAME + &
													 WS_MINIMIZEBOX + &
													 WS_MAXIMIZEBOX )
//FlashWindowEx flags
CONSTANT ulong FLASHW_STOP = 0
CONSTANT ulong FLASHW_CAPTION = 1
CONSTANT ulong FLASHW_TRAY = 2
CONSTANT ulong FLASHW_ALL = 3
CONSTANT ulong FLASHW_TIMER = 4
CONSTANT ulong FLASHW_TIMERNOFG = 12

//AnimateWindow flags
CONSTANT ulong AW_SLIDE = 262144
CONSTANT ulong AW_ACTIVATE = 131072
CONSTANT ulong AW_BLEND = 524288
CONSTANT ulong AW_HIDE = 65536
CONSTANT ulong AW_CENTER = 16
CONSTANT ulong AW_HOR_POSITIVE = 1
CONSTANT ulong AW_HOR_NEGATIVE = 2
CONSTANT ulong AW_VER_POSITIVE = 4
CONSTANT ulong AW_VER_NEGATIVE = 8

/*
 * Standard Cursor IDs
 */
constant ulong IDC_ARROW           =32512
constant ulong IDC_IBEAM           =32513
constant ulong IDC_WAIT            =32514
constant ulong IDC_CROSS           =32515
constant ulong IDC_UPARROW         =32516
constant ulong IDC_SIZE            =32640  /* OBSOLETE: use IDC_SIZEALL */
constant ulong IDC_ICON            =32641  /* OBSOLETE: use IDC_ARROW */
constant ulong IDC_SIZENWSE        =32642
constant ulong IDC_SIZENESW        =32643
constant ulong IDC_SIZEWE          =32644
constant ulong IDC_SIZENS          =32645
constant ulong IDC_SIZEALL         =32646
constant ulong IDC_NO              =32648 /*not in win3.1 */

/*
 * Predefined Clipboard Formats
 */
constant uint CF_TEXT             =1
constant uint CF_BITMAP           =2
constant uint CF_METAFILEPICT     =3
constant uint CF_SYLK             =4
constant uint CF_DIF              =5
constant uint CF_TIFF             =6
constant uint CF_OEMTEXT          =7
constant uint CF_DIB              =8
constant uint CF_PALETTE          =9
constant uint CF_PENDATA          =10
constant uint CF_RIFF             =11
constant uint CF_WAVE             =12
constant uint CF_UNICODETEXT      =13
constant uint CF_ENHMETAFILE      =14
constant uint CF_HDROP            =15
constant uint CF_LOCALE           =16
constant uint CF_DIBV5            =17
constant uint CF_OWNERDISPLAY     =128 //0x0080
constant uint CF_DSPTEXT          =129 //0x0081
constant uint CF_DSPBITMAP        =130 //0x0082
constant uint CF_DSPMETAFILEPICT  =131 //0x0083
constant uint CF_DSPENHMETAFILE   =142 //0x008E

/*
 * Menu flags for Add/Check/EnableMenuItem()
 */
constant uint MF_INSERT           = 0 //0x00000000L
constant uint MF_CHANGE           = 128 //0x00000080L
constant uint MF_APPEND           = 256 //0x00000100L
constant uint MF_DELETE           = 512 //0x00000200L
constant uint MF_REMOVE           = 4096 //0x00001000L

constant uint MF_BYCOMMAND        = 0 //0x00000000L
constant uint MF_BYPOSITION       = 1024 //0x00000400L

constant uint MF_SEPARATOR        = 2048 //0x00000800L

constant uint MF_ENABLED          = 0 //0x00000000L
constant uint MF_GRAYED           = 1 //0x00000001L
constant uint MF_DISABLED         = 2 //0x00000002L

constant uint MF_UNCHECKED        = 0 //0x00000000L
constant uint MF_CHECKED          = 8 //0x00000008L
constant uint MF_USECHECKBITMAPS  = 512 //0x00000200L

constant uint MF_STRING           = 0 //0x00000000L
constant uint MF_BITMAP           = 4 //0x00000004L
constant uint MF_OWNERDRAW        = 256 //0x00000100L

constant uint MF_POPUP            = 16 //0x00000010L
constant uint MF_MENUBARBREAK     = 32 //0x00000020L
constant uint MF_MENUBREAK        = 64 //0x00000040L

constant uint MF_UNHILITE         =0 //0x00000000L
constant uint MF_HILITE           = 128 //0x00000080L
constant uint MF_DEFAULT          = 4096 //0x00001000L
constant uint MF_SYSMENU          = 8192 //0x00002000L
constant uint MF_HELP             = 16384 //0x00004000L

constant uint MF_RIGHTJUSTIFY     = 16384 //0x00004000L
constant uint MF_MOUSESELECT      = 32768 //0x00008000L
constant uint MF_END              = 128 //0x00000080L  /* Obsolete -- only used by old RES files */

constant uint MFT_STRING          = MF_STRING
constant uint MFT_BITMAP          = MF_BITMAP
constant uint MFT_MENUBARBREAK    = MF_MENUBARBREAK
constant uint MFT_MENUBREAK       = MF_MENUBREAK
constant uint MFT_OWNERDRAW       = MF_OWNERDRAW
constant uint MFT_RADIOCHECK      = 512 //0x00000200L
constant uint MFT_SEPARATOR       = MF_SEPARATOR
constant uint MFT_RIGHTORDER      = 8192 //0x00002000L
constant uint MFT_RIGHTJUSTIFY    = MF_RIGHTJUSTIFY

/* Menu flags for Add/Check/EnableMenuItem() */
constant uint MFS_GRAYED          = 3 //0x00000003L
constant uint MFS_DISABLED        = MFS_GRAYED
constant uint MFS_CHECKED         = MF_CHECKED
constant uint MFS_HILITE          = MF_HILITE
constant uint MFS_ENABLED         = MF_ENABLED
constant uint MFS_UNCHECKED       = MF_UNCHECKED
constant uint MFS_UNHILITE        = MF_UNHILITE
constant uint MFS_DEFAULT         = MF_DEFAULT

constant uint MIIM_STATE       = 1 //0x00000001
constant uint MIIM_ID          = 2 //0x00000002
constant uint MIIM_SUBMENU     = 4 //0x00000004
constant uint MIIM_CHECKMARKS  = 8 //0x00000008
constant uint MIIM_TYPE        = 16 //0x00000010
constant uint MIIM_DATA        = 32 //0x00000020
constant uint MIIM_STRING      = 64 //0x00000040
constant uint MIIM_BITMAP      = 128 //0x00000080
constant uint MIIM_FTYPE       = 256 //0x00000100

constant ulong HBMMENU_CALLBACK			= -1
constant ulong HBMMENU_SYSTEM				= 1
constant ulong HBMMENU_MBAR_RESTORE		= 2
constant ulong HBMMENU_MBAR_MINIMIZE	= 3
constant ulong HBMMENU_MBAR_CLOSE		= 5
constant ulong HBMMENU_MBAR_CLOSE_D		= 6
constant ulong HBMMENU_MBAR_MINIMIZE_D	= 7
constant ulong HBMMENU_POPUP_CLOSE		= 8
constant ulong HBMMENU_POPUP_RESTORE	= 9
constant ulong HBMMENU_POPUP_MAXIMIZE	= 10
constant ulong HBMMENU_POPUP_MINIMIZE	= 11

//exit windows flags
constant ulong EWX_LOGOFF          = 0
constant ulong EWX_SHUTDOWN        = 1 //0x00000001
constant ulong EWX_REBOOT          = 2 //0x00000002
constant ulong EWX_FORCE           = 4 //0x00000004
constant ulong EWX_POWEROFF        = 8 //0x00000008
constant ulong EWX_FORCEIFHUNG     = 16 //0x00000010

/*
 * Window Messages
 */
constant ulong WM_MOUSEMOVE                    = 512 //0x0200
constant ulong WM_LBUTTONDOWN                 = 513 // 0x0201
constant ulong WM_LBUTTONUP                    = 514 //0x0202
constant ulong WM_LBUTTONDBLCLK                = 515 //0x0203
constant ulong WM_RBUTTONDOWN                  = 516 //0x0204
constant ulong WM_RBUTTONUP                    =  517 //0x0205
constant ulong WM_RBUTTONDBLCLK                = 518 //0x0206
constant ulong WM_MOUSEHOVER                   = 673 //0x02A1
constant ulong WM_MOUSELEAVE                   = 675 //0x02A3

/*
 * Hover Flagss
 */
constant ulong TME_HOVER       = 1 // 0x00000001
constant ulong TME_LEAVE       = 2 // 0x00000002
constant ulong TME_NONCLIENT   = 16 // 0x00000010
constant ulong TME_QUERY       = 1073741824 // 0x40000000
constant ulong TME_CANCEL      = 2147483648 // 0x80000000
constant ulong HOVER_DEFAULT   = 4294967295 // 0xFFFFFFFF

/*
 * Keyboard Flags
 */
constant long KLF_REORDER = 8
constant long LANG_US_ENGLISH = 67699721
constant long LANG_EL_GREEK = 67634184

end variables

on n_cst_user32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_user32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


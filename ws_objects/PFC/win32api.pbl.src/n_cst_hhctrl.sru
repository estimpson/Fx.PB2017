$PBExportHeader$n_cst_hhctrl.sru
forward
global type n_cst_hhctrl from nonvisualobject
end type
end forward

global type n_cst_hhctrl from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong HtmlHelp (ulong hwndCaller, string pszFile,  uint uCommand, ref string dwData)  LIBRARY "hhctrl.ocx"  Alias for "HtmlHelpA;Ansi"
end prototypes

type variables
// Commands to pass to HtmlHelp()

constant uint HH_DISPLAY_TOPIC        = 0 //0x0000
constant uint HH_HELP_FINDER          = 0 //0x0000  // WinHelp equivalent
constant uint HH_DISPLAY_TOC          = 1 //0x0001  // not currently implemented
constant uint HH_DISPLAY_INDEX        = 2 //0x0002  // not currently implemented
constant uint HH_DISPLAY_SEARCH       = 3 //0x0003  // not currently implemented
constant uint HH_SET_WIN_TYPE         = 4 //0x0004
constant uint HH_GET_WIN_TYPE         = 5 //0x0005
constant uint HH_GET_WIN_HANDLE       = 6 //0x0006
constant uint HH_ENUM_INFO_TYPE       = 7 //0x0007  // Get Info type name, call repeatedly to enumerate, -1 at end
constant uint HH_SET_INFO_TYPE        = 8 //0x0008  // Add Info type to filter.
constant uint HH_SYNC                 = 9 //0x0009
constant uint HH_RESERVED1            = 10 //0x000A
constant uint HH_RESERVED2            = 11 //0x000B
constant uint HH_RESERVED3            = 12 //0x000C
constant uint HH_KEYWORD_LOOKUP       = 13 //0x000D
constant uint HH_DISPLAY_TEXT_POPUP   = 14 //0x000E  // display string resource id or text in a popup window
constant uint HH_HELP_CONTEXT         = 15 //0x000F  // display mapped numeric value in dwData
constant uint HH_TP_HELP_CONTEXTMENU  = 16 //0x0010  // text popup help, same as WinHelp HELP_CONTEXTMENU
constant uint HH_TP_HELP_WM_HELP      = 17 //0x0011  // text popup help, same as WinHelp HELP_WM_HELP
constant uint HH_CLOSE_ALL            = 18 //0x0012  // close all windows opened directly or indirectly by the caller
constant uint HH_ALINK_LOOKUP         = 19 //0x0013  // ALink version of HH_KEYWORD_LOOKUP
constant uint HH_GET_LAST_ERROR       = 20 //0x0014  // not currently implemented // See HHERROR.h
constant uint HH_ENUM_CATEGORY        = 21 //0x0015	// Get category name, call repeatedly to enumerate, -1 at end
constant uint HH_ENUM_CATEGORY_IT     = 22 //0x0016  // Get category info type members, call repeatedly to enumerate, -1 at end
constant uint HH_RESET_IT_FILTER      = 23 //0x0017  // Clear the info type filter of all info types.
constant uint HH_SET_INCLUSIVE_FILTER = 24 //0x0018  // set inclusive filtering method for untyped topics to be included in display
constant uint HH_SET_EXCLUSIVE_FILTER = 25 //0x0019  // set exclusive filtering method for untyped topics to be excluded from display
constant uint HH_INITIALIZE            = 28 //0x001C  // Initializes the help system.
constant uint HH_UNINITIALIZE          = 29 //0x001D  // Uninitializes the help system.
constant uint HH_PRETRANSLATEMESSAGE  = 253 //0x00fd  // Pumps messages. (NULL, NULL, MSG*). 
constant uint HH_SET_GLOBAL_PROPERTY  = 254 //0x00fc  // Set a global property. (NULL, NULL, HH_GPROP)

end variables

on n_cst_hhctrl.create
TriggerEvent( this, "constructor" )
end on

on n_cst_hhctrl.destroy
TriggerEvent( this, "destructor" )
end on


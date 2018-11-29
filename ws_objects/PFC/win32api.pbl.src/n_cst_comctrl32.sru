$PBExportHeader$n_cst_comctrl32.sru
forward
global type n_cst_comctrl32 from nonvisualobject
end type
end forward

type trackmouseevent from structure
	unsignedlong		cbSize
	unsignedlong		dwFlags
	unsignedlong		hwndTrack
	unsignedlong		dwHoverTime
end type

global type n_cst_comctrl32 from nonvisualobject autoinstantiate
end type

type prototypes
Function Boolean _TrackMouseEvent(ref trackmouseevent lpEventTrack) Library "COMCTL32.DLL" alias for "_TrackMouseEvent;Ansi"

end prototypes

type variables
public:
/*
 * Window Messages
 */
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

end variables

on n_cst_comctrl32.create
TriggerEvent( this, "constructor" )
end on

on n_cst_comctrl32.destroy
TriggerEvent( this, "destructor" )
end on


$PBExportHeader$n_cst_gdi32.sru
forward
global type n_cst_gdi32 from nonvisualobject
end type
type tagsize from structure within n_cst_gdi32
end type
type docinfoa from structure within n_cst_gdi32
end type
type tagpoint from structure within n_cst_gdi32
end type
end forward

type tagSIZE from structure
	long		cx
	long		cy
end type

type DOCINFOA from structure
	integer		cbSize
	string		lpszDocName
	string		lpszOutput
	string		lpszDatatype
	ulong		fwType
end type

type tagPoint from structure
	long		x
	long		y
end type

shared variables

end variables

global type n_cst_gdi32 from nonvisualobject autoinstantiate
end type

type prototypes
Function Boolean Arc (ulong hDC, integer r1, integer r2, integer r3, integer r4, integer a1, integer a2, integer a3, integer a4) Library "GDI32.DLL"
Function boolean Chord (ulong hDC, integer x1, integer y1, integer x2, integer y2, integer r1, integer r2, integer r3, integer r4) Library "GDI32.DLL"
Function boolean Ellipse (ulong hDC, integer x1, integer y1, integer x2, integer y2) Library "GDI32.DLL"
Function int EndDoc (ulong hDC) Library "GDI32.DLL"
Function int EndPage (ulong hDC) Library "GDI32.DLL"
Function ulong GetBkColor (ulong hDC) Library "GDI32.DLL"
Function ulong GetPixel (ulong hDC, integer xpos, integer ypos) Library "GDI32.DLL"
Function boolean GetTextExtentPoint32 (ulong hDC, ref string lpString, integer nCount, ref tagSIZE size) Library "GDI32.dll" Alias for "GetTextExtentPoint32A;Ansi"
Function boolean LineTo (ulong hDC, integer wx, integer wy) Library "GDI32.DLL"
Function boolean Pie (ulong hhDC, integer x1, integer y1, integer x2, integer y2, integer x3, integer y3, integer x4, integer y4) Library "GDI32.DLL"
Function boolean Rectangle (ulong hDC, integer x1, integer y1, integer x2, integer y2) Library "GDI32.DLL"
Function ulong SetPixel (ulong hDC, integer xpos, integer ypos, ulong pcol) Library "GDI32.DLL"
Function ulong SelectObject (ulong hDC, ulong hWnd) Library "GDI32.dll"
Function int StartDoc (ulong hDC, ref DOCINFOA DInfo) Library "GDI32.DLL" Alias for "StartDocA;Ansi"
Function int StartPage (ulong hDC) Library "GDI32.DLL"

Function boolean DeleteObject (ulong hDC) Library "GDI32.DLL"
Function boolean MoveToEx (ulong hDC, int x, int y, ref tagPoint lppt ) Library "GDI32.DLL" alias for "MoveToEx;Ansi"
Function ulong SetBkColor (ulong hDC, ulong crColor) Library "GDI32.DLL"
Function ulong SetTextColor (ulong hDC, ulong crColor) Library "GDI32.DLL"
Function ulong CreateSolidBrush (ulong clrRef) Library "GDI32.DLL"
Function int GetDeviceCaps (ulong hDC, int iCapability) Library "GDI32.DLL"
Function boolean TextOut (ulong hdcr, integer stx, integer sty, ref string lpString, long nCount) Library "GDI32.DLL" Alias for "TextOutA;Ansi"
Function int SetBkMode (ulong hdcr, integer mode) Library "GDI32.DLL"
Function ulong CreateFont (int nHeight, int nWidth, int nEscapement, int nOrientation, int nWeight, ulong fbItalic, ulong fbUnderline, ulong fbStrikeOut, ulong fbCharSet, ulong fbOutputPrecision, ulong fbClipPrecision, ulong fbQuality, ulong fbPitchAndFamily, ref string lpszFace) ALIAS FOR "CreateFontA;Ansi" Library "GDI32.DLL"
Function int SetMapMode (ulong hDC,  long nMode) Library "GDI32.DLL"
Function ulong CreatePen (uint nPenStyle, uint nWidth, ulong crColor) Library "GDI32.DLL"
Function int CombineRgn (ulong hrgnDest, ulong hrgnSrc1, ulong hrgnSrc2, int fnCombineMode )  Library "GDI32.DLL"
Function ulong CreateEllipticRgn (int x1, int y1, int x2, int y2 ) Library "GDI32.DLL"
Function ulong CreatePolygonRgn (ref tagPOINT lppt[], int cPoints, int fnPolyFillMode ) Library "GDI32.DLL" alias for "CreatePolygonRgn;Ansi"
Function ulong CreateRectRgn (int x1, int y1, int x2, int y2 ) Library "GDI32.DLL"
Function ulong CreateCompatibleDC (ulong hDC) Library "GDI32.DLL"
Function ulong CreateCompatibleBitmap (ulong hDC, integer nWidth, integer nHeight) Library "GDI32.DLL"
Function boolean DeleteDC (ulong hDC ) Library "GDI32.DLL"
Function boolean BitBlt (ulong hdcDest, int nXDest, int nYDest, int nWidth, int nHeight, ulong hdcSrc, int nXSrc, int nYSrc, ulong dwRop ) Library "GDI32.DLL"
Function ulong CreateRoundRectRgn (int nLeftRect,  int nTopRect,   int nRightRect,  int nBottomRect,  int nWidthEllipse,  int nHeightEllipse ) Library "GDI32.DLL"
end prototypes

type variables
/* CombineRgn() Styles */
constant int RGN_AND           =  1
constant int RGN_OR             = 2
constant int RGN_XOR           =  3
constant int RGN_DIFF           = 4
constant int RGN_COPY         =   5
constant int RGN_MIN            = RGN_AND
constant int RGN_MAX           =  RGN_COPY

/* Ternary raster operations */
constant ulong SRCCOPY             = 13369376 //(DWORD)0x00CC0020 /* dest = source                   */
constant ulong SRCPAINT            = 15597702 //(DWORD)0x00EE0086 /* dest = source OR dest           */
constant ulong SRCAND              = 8913094  //(DWORD)0x008800C6 /* dest = source AND dest          */
constant ulong SRCINVERT           = 6684742  //(DWORD)0x00660046 /* dest = source XOR dest          */
constant ulong SRCERASE            = 4457256  //(DWORD)0x00440328 /* dest = source AND (NOT dest )   */
constant ulong NOTSRCCOPY          = 3342344  //(DWORD)0x00330008 /* dest = (NOT source)             */
constant ulong NOTSRCERASE         = 1114278  //(DWORD)0x001100A6 /* dest = (NOT src) AND (NOT dest) */
constant ulong MERGECOPY           = 12583114 //(DWORD)0x00C000CA /* dest = (source AND pattern)     */
constant ulong MERGEPAINT          = 12255782 //(DWORD)0x00BB0226 /* dest = (NOT source) OR dest     */
constant ulong PATCOPY             = 15728673 //(DWORD)0x00F00021 /* dest = pattern                  */
constant ulong PATPAINT            = 16452105 //(DWORD)0x00FB0A09 /* dest = DPSnoo                   */
constant ulong PATINVERT           = 5898313  //(DWORD)0x005A0049 /* dest = pattern XOR dest         */
constant ulong DSTINVERT           = 5570569  //(DWORD)0x00550009 /* dest = (NOT dest)               */
constant ulong BLACKNESS           = 66       //(DWORD)0x00000042 /* dest = BLACK                    */
constant ulong WHITENESS           = 16711778 //(DWORD)0x00FF0062 /* dest = WHITE                    */

constant ulong LOGPIXELSY = 90

/* Structures */
public tagSIZE tagsize

end variables

on n_cst_gdi32.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gdi32.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


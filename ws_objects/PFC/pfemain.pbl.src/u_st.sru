$PBExportHeader$u_st.sru
$PBExportComments$Extension StaticText class
forward
global type u_st from pfc_u_st
end type
end forward

global type u_st from pfc_u_st
end type
global u_st u_st

forward prototypes
public function long resize ()
end prototypes

public function long resize ();
n_cst_gdi32 gdi32
n_cst_user32 user32
n_cst_kernel32 kernel32
//int fontHeight
//ulong font
//fontHeight = -kernel32.MulDiv(-this.TextSize, gdi32.GetDeviceCaps(user32.GetDC(Handle(this)), gdi32.LOGPIXELSY), 72)
//constant int FW_DONTCARE = 0
//constant int OUT_OUTLINE_PRECIS = 8
//constant int CLIP_DEFAULT_PRECIS = 0
//constant int CLEARTYPE_QUALITY = 5
//constant int VARIABLE_PITCH = 2
//font = gdi32.CreateFont(-32, 0, 0, 0, FW_DONTCARE, 0, 0, 0, 0, OUT_OUTLINE_PRECIS, CLIP_DEFAULT_PRECIS, CLEARTYPE_QUALITY, VARIABLE_PITCH, this.FaceName)
//gdi32.SelectObject(user32.GetDC(Handle(this)), font)
gdi32.GetTextExtentPoint32(user32.GetDC(Handle(this)), this.Text, LenA(this.Text), gdi32.tagsize)
this.width = PixelsToUnits(gdi32.tagsize.cx, XPixelsToUnits!)

return width

end function

on u_st.create
call super::create
end on

on u_st.destroy
call super::destroy
end on


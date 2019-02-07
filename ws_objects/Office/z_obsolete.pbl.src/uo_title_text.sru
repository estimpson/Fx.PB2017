$PBExportHeader$uo_title_text.sru
forward
global type uo_title_text from statictext
end type
end forward

global type uo_title_text from statictext
int Width=1147
int Height=612
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-48
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_resize pbm_custom01
end type
global uo_title_text uo_title_text

type variables
Window	iw_Parent
end variables

event ue_resize;Resize ( iw_Parent.Width - 7 * PixelsToUnits ( 1, XPixelsToUnits! ), &
	iw_Parent.Height - 22 * PixelsToUnits ( 1, YPixelsToUnits! ) )
end event

event constructor;iw_Parent = GetParent ( )
end event


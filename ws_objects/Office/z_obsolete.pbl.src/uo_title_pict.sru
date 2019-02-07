$PBExportHeader$uo_title_pict.sru
forward
global type uo_title_pict from picture
end type
end forward

global type uo_title_pict from picture
int Width=1934
int Height=1213
boolean FocusRectangle=false
event ue_resize pbm_custom01
end type
global uo_title_pict uo_title_pict

type variables
Window	iw_Parent

LONG	il_OrigWidth, &
	il_OrigHeight
end variables

event ue_resize;INTEGER	li_X, &
			li_Width, &
			li_Height

li_X = PixelsToUnits ( 1, XPixelsToUnits! ) + iw_Parent.Width * .2

li_Width = iw_Parent.Width - 2 * li_X
li_Height = iw_Parent.Height - Y - PixelsToUnits ( 30, YPixelsToUnits! )
IF li_Height < 0 OR li_Width < 0 THEN
	Resize ( 1, 1 )
ELSE
	IF li_Width * il_OrigHeight < li_Height * il_OrigWidth THEN
		Resize ( li_Width, ( li_Width * il_OrigHeight ) / il_OrigWidth )
		X = li_X
	ELSE
		Resize ( ( li_Height * il_OrigWidth ) / il_OrigHeight, li_Height )
		X = ( iw_Parent.Width - Width ) / 2
	END IF
END IF
end event

event constructor;iw_Parent = GetParent ( )
il_OrigHeight = Height
il_OrigWidth = Width
end event


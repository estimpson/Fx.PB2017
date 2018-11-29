$PBExportHeader$u_shifts.sru
$PBExportComments$User object for displaying shifts
forward
global type u_shifts from statictext
end type
end forward

global type u_shifts from statictext
int Width=74
int Height=65
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=65280
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_shifts u_shifts

type variables
Integer	i_i_Ptr
Long	il_OrigPos

Time	i_t_ShiftBeginTime

Decimal	i_d_ShiftHour

Date	i_dt_StartDate
end variables

on doubleclicked;szReturnedString	= String(i_i_Ptr)
Parent.PostEvent("ue_double_clicked_shift")
end on

on rbuttondown;szReturnedString	= String(i_i_Ptr)
Parent.PostEvent("ue_drag_shift")
end on


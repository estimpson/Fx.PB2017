$PBExportHeader$u_calendar_small.sru
$PBExportComments$(PFD)
forward
global type u_calendar_small from u_calendar
end type
end forward

global type u_calendar_small from u_calendar
int width=544
int height=564
end type
global u_calendar_small u_calendar_small

type variables

protected:

integer	origheight = 548
integer	origwidth = 549
end variables

on u_calendar_small.create
call super::create
end on

on u_calendar_small.destroy
call super::destroy
end on

type dw_cal from u_calendar`dw_cal within u_calendar_small
int width=549
int height=548
string dataobject="d_calendarsmall"
boolean border=false
borderstyle borderstyle=stylebox!
end type


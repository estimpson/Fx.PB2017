$PBExportHeader$uo_dw_sp.sru
$PBExportComments$Datawindow Control user object for use with stored procedures.
forward
global type uo_dw_sp from datawindow
end type
end forward

global type uo_dw_sp from datawindow
int Width=494
int Height=360
int TabOrder=1
boolean LiveScroll=true
end type
global uo_dw_sp uo_dw_sp

type variables
pointer ip_oldpointer
end variables

event retrieveend;SetPointer(ip_oldpointer)

end event

event retrievestart;ip_oldpointer = SetPointer(HourGlass!)

end event


$PBExportHeader$uo_progress_bar.sru
forward
global type uo_progress_bar from datawindow
end type
end forward

global type uo_progress_bar from datawindow
int Width=810
int Height=117
int TabOrder=1
string DataObject="d_progress_bar"
boolean Border=false
boolean LiveScroll=true
end type
global uo_progress_bar uo_progress_bar

type variables
INTEGER	i_Progress
end variables

forward prototypes
public subroutine uof_begin ()
end prototypes

public subroutine uof_begin ();//i_Progress = ( monitor.greal_TimerCurrent / monitor.greal_TimerTotal ) * 10

DO WHILE i_Progress > RowCount ( )
	InsertRow ( 0 )
LOOP
end subroutine

on constructor;This.SetTransObject ( SQLCA )
end on


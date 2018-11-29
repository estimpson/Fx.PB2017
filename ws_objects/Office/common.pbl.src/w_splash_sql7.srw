$PBExportHeader$w_splash_sql7.srw
forward
global type w_splash_sql7 from Window
end type
type uo_1 from u_splash_sql7 within w_splash_sql7
end type
end forward

global type w_splash_sql7 from Window
int X=1056
int Y=484
int Width=1550
int Height=1008
long BackColor=77897888
boolean Border=false
WindowType WindowType=popup!
uo_1 uo_1
end type
global w_splash_sql7 w_splash_sql7

type variables
boolean timer = false
end variables

forward prototypes
public subroutine wf_timer ()
end prototypes

public subroutine wf_timer ();long	ll_count

timer ( 1 )
do until timer
	yield ( )
loop
end subroutine

event open;f_center_window ( this )

end event

on w_splash_sql7.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_splash_sql7.destroy
destroy(this.uo_1)
end on

event timer;timer = true
end event

type uo_1 from u_splash_sql7 within w_splash_sql7
int X=0
int Y=0
int TabOrder=10
end type

on uo_1.destroy
call u_splash_sql7::destroy
end on


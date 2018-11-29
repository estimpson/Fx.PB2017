$PBExportHeader$u_time_line_shift.sru
forward
global type u_time_line_shift from UserObject
end type
type st_1 from statictext within u_time_line_shift
end type
type uo_1 from u_time_line within u_time_line_shift
end type
end forward

global type u_time_line_shift from UserObject
int Width=1683
int Height=117
long BackColor=12632256
st_1 st_1
uo_1 uo_1
end type
global u_time_line_shift u_time_line_shift

on u_time_line_shift.create
this.st_1=create st_1
this.uo_1=create uo_1
this.Control[]={ this.st_1,&
this.uo_1}
end on

on u_time_line_shift.destroy
destroy(this.st_1)
destroy(this.uo_1)
end on

type st_1 from statictext within u_time_line_shift
int X=243
int Y=9
int Width=385
int Height=37
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=8388608
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from u_time_line within u_time_line_shift
int X=1
int Y=1
int TabOrder=10
end type

on uo_1.destroy
call u_time_line::destroy
end on


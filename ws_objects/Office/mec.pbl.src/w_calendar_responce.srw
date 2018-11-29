$PBExportHeader$w_calendar_responce.srw
$PBExportComments$Calendar responce window - returns selected date.
forward
global type w_calendar_responce from Window
end type
type uo_1 from u_newshift_calendar within w_calendar_responce
end type
end forward

global type w_calendar_responce from Window
int X=833
int Y=361
int Width=851
int Height=941
boolean TitleBar=true
string Title="Calendar"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
uo_1 uo_1
end type
global w_calendar_responce w_calendar_responce

on w_calendar_responce.create
this.uo_1=create uo_1
this.Control[]={ this.uo_1}
end on

on w_calendar_responce.destroy
destroy(this.uo_1)
end on

type uo_1 from u_newshift_calendar within w_calendar_responce
int X=1
int Y=1
int TabOrder=1
end type

on uo_1.destroy
call u_newshift_calendar::destroy
end on

event ue_day_clicked;call super::ue_day_clicked;closewithreturn(parent,string(uo_1.id_clickeddate))
end event


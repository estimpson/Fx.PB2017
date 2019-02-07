$PBExportHeader$uo_workorder_note.sru
forward
global type uo_workorder_note from u_note
end type
end forward

global type uo_workorder_note from u_note
long BackColor=77897888
event ue_save_note pbm_custom01
event ue_close_uo_note pbm_custom02
end type
global uo_workorder_note uo_workorder_note

type variables
string		i_s_work_order
end variables

event ue_save_note;UPDATE work_order  
   SET note = :mle_note.Text  
 WHERE work_order.work_order = :i_s_work_order   ;

if sqlca.sqlcode <> 0 then
	rollback;
else
	commit;
end if
This.TriggerEvent("ue_close_uo_note")
end event

on ue_close_uo_note;call u_note::ue_close_uo_note;iw_HostWindow.PostEvent ( "ue_refresh" )
iw_HostWindow.CloseUserObject ( this )
end on

on constructor;call u_note::constructor;i_s_work_order = Message.StringParm

SELECT work_order.note  
  INTO :mle_note.Text  
  FROM work_order  
 WHERE work_order.work_order = :i_s_work_order   ;

end on

on uo_workorder_note.create
call super::create
end on

on uo_workorder_note.destroy
call super::destroy
end on

type cb_2 from u_note`cb_2 within uo_workorder_note
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type cb_save from u_note`cb_save within uo_workorder_note
int X=887
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type mle_note from u_note`mle_note within uo_workorder_note
int X=23
Alignment Alignment=Left!
long TextColor=33554432
long BackColor=16777215
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from u_note`st_1 within uo_workorder_note
int X=475
int Width=498
string Text="Work Order Note"
long TextColor=33554432
long BackColor=77897888
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type


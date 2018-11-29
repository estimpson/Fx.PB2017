$PBExportHeader$w_ai_customer_sync.srw
forward
global type w_ai_customer_sync from w_ai_piped_sync
end type
end forward

global type w_ai_customer_sync from w_ai_piped_sync
long BackColor=79741120
event ue_open2 pbm_custom02
end type
global w_ai_customer_sync w_ai_customer_sync

on w_ai_customer_sync.create
call super::create
end on

on w_ai_customer_sync.destroy
call super::destroy
end on

type cb_1 from w_ai_piped_sync`cb_1 within w_ai_customer_sync
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

on cb_1::clicked;call w_ai_piped_sync`cb_1::clicked;wf_execute_transaction ( 'ARMaster' )
end on

type cb_2 from w_ai_piped_sync`cb_2 within w_ai_customer_sync
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from w_ai_piped_sync`st_1 within w_ai_customer_sync
string Text="Customer Sync -- Errors:"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type


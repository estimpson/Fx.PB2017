$PBExportHeader$w_ai_vendor_sync.srw
forward
global type w_ai_vendor_sync from w_ai_piped_sync
end type
end forward

global type w_ai_vendor_sync from w_ai_piped_sync
boolean TitleBar=true
string Title="Vendor Sync"
long BackColor=79741120
event ue_open2 pbm_custom02
end type
global w_ai_vendor_sync w_ai_vendor_sync

on w_ai_vendor_sync.create
call super::create
end on

on w_ai_vendor_sync.destroy
call super::destroy
end on

type cb_1 from w_ai_piped_sync`cb_1 within w_ai_vendor_sync
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

on cb_1::clicked;call w_ai_piped_sync`cb_1::clicked;wf_execute_transaction ( 'APMaster' )
end on

type cb_2 from w_ai_piped_sync`cb_2 within w_ai_vendor_sync
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from w_ai_piped_sync`st_1 within w_ai_vendor_sync
string Text="Vendor Sync -- Errors:"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
end type


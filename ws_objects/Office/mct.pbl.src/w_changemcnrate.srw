$PBExportHeader$w_changemcnrate.srw
forward
global type w_changemcnrate from Window
end type
type mdi_1 from mdiclient within w_changemcnrate
end type
type dw_cmr from datawindow within w_changemcnrate
end type
end forward

global type w_changemcnrate from Window
int X=251
int Y=528
int Width=2363
int Height=1148
boolean TitleBar=true
string Title="Change Burden Rate"
string MenuName="m_submenu"
long BackColor=77897888
boolean ControlMenu=true
boolean Resizable=true
WindowType WindowType=mdihelp!
string Icon="Monitor.ico"
event ue_exit pbm_custom01
event ue_save pbm_custom02
event ue_cancel pbm_custom03
mdi_1 mdi_1
dw_cmr dw_cmr
end type
global w_changemcnrate w_changemcnrate

type variables
string sl_mcncode
dec   dl_mcnrate

end variables

event ue_exit;close(w_changemcnrate)
end event

event ue_save;if dw_cmr.update() <= 0 then
	Rollback ;
	Messagebox("System Message","Unable to save changes")
else
	Commit ;
end if 
end event

event ue_cancel;dw_cmr.retrieve()

end event

event open;dw_cmr.retrieve()
dw_cmr.setfocus()

end event

on w_changemcnrate.create
if this.MenuName = "m_submenu" then this.MenuID = create m_submenu
this.mdi_1=create mdi_1
this.dw_cmr=create dw_cmr
this.Control[]={this.mdi_1,&
this.dw_cmr}
end on

on w_changemcnrate.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.dw_cmr)
end on

event activate;m_submenu.sm_iswindow = 'w_changemcnrate'
end event

type mdi_1 from mdiclient within w_changemcnrate
long BackColor=275605865
end type

type dw_cmr from datawindow within w_changemcnrate
int X=5
int Y=156
int Width=2304
int Height=828
int TabOrder=20
string DataObject="d_machinechg"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)

end event


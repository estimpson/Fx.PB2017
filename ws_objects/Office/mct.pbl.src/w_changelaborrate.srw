$PBExportHeader$w_changelaborrate.srw
forward
global type w_changelaborrate from Window
end type
type mdi_1 from mdiclient within w_changelaborrate
end type
type dw_clr from datawindow within w_changelaborrate
end type
end forward

global type w_changelaborrate from Window
int X=137
int Y=460
int Width=2112
int Height=912
boolean TitleBar=true
string Title="Change Labor Rate"
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
dw_clr dw_clr
end type
global w_changelaborrate w_changelaborrate

type variables
string sl_lbrcode
long  dl_lbrrate


end variables

event ue_exit;close(w_changelaborrate)
end event

event ue_save;if dw_clr.update() <= 0 then
	Rollback ;
	Messagebox("System Message","Unable to save changes")
else
	Commit ;
end if 
end event

event ue_cancel;dw_clr.retrieve()
end event

on w_changelaborrate.create
if this.MenuName = "m_submenu" then this.MenuID = create m_submenu
this.mdi_1=create mdi_1
this.dw_clr=create dw_clr
this.Control[]={this.mdi_1,&
this.dw_clr}
end on

on w_changelaborrate.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.dw_clr)
end on

event open;dw_clr.retrieve()
dw_clr.setfocus()


end event

event activate;m_submenu.sm_iswindow = 'w_changelaborrate'
end event

type mdi_1 from mdiclient within w_changelaborrate
long BackColor=275605865
end type

type dw_clr from datawindow within w_changelaborrate
int Y=156
int Width=2071
int Height=604
int TabOrder=10
string DataObject="d_laborchg"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event


$PBExportHeader$w_mdi_frame_ordervalidation.srw
forward
global type w_mdi_frame_ordervalidation from Window
end type
type mdi_1 from mdiclient within w_mdi_frame_ordervalidation
end type
end forward

global type w_mdi_frame_ordervalidation from Window
int X=5
int Y=4
int Width=2926
int Height=1920
boolean TitleBar=true
string Title="Monitor Order Validation"
string MenuName="m_ancestor_ordervalidation"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_exit ( )
event ue_previousorder ( )
event ue_previousdiscrepency ( )
event ue_nextorder ( )
event ue_nextdiscrepency ( )
mdi_1 mdi_1
end type
global w_mdi_frame_ordervalidation w_mdi_frame_ordervalidation

type variables

end variables

event ue_exit;Close ( This )
end event

event ue_previousorder;w_ordervalidationsheet.TRIGGER EVENT ue_previousorder ( )
end event

event ue_previousdiscrepency;w_ordervalidationsheet.TRIGGER EVENT ue_previousdiscrepency ( )
end event

event ue_nextorder;w_ordervalidationsheet.TRIGGER EVENT ue_nextorder ( )
end event

event ue_nextdiscrepency;w_ordervalidationsheet.TRIGGER EVENT ue_nextdiscrepency ( )
end event

on w_mdi_frame_ordervalidation.create
if this.MenuName = "m_ancestor_ordervalidation" then this.MenuID = create m_ancestor_ordervalidation
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_mdi_frame_ordervalidation.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;OpenSheet ( w_ordervalidationsheet, this, 0, layered! )
end event

type mdi_1 from mdiclient within w_mdi_frame_ordervalidation
long BackColor=276587854
end type


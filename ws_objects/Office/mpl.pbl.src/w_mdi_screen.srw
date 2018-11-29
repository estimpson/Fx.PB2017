$PBExportHeader$w_mdi_screen.srw
forward
global type w_mdi_screen from Window
end type
type mdi_1 from mdiclient within w_mdi_screen
end type
end forward

global type w_mdi_screen from Window
int X=0
int Y=0
int Width=2917
int Height=1920
boolean TitleBar=true
string MenuName="m_packline"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_mdi_screen w_mdi_screen

event activate;//OpenSheet(w_smart_job_completion_version2, w_mdi_screen, 4, Original!)
end event

event open;title = monsys.title + sqlca.is_Profile
OpenSheet(w_smart_job_completion_version2, w_mdi_screen, 0, Original!)



end event

on w_mdi_screen.create
if this.MenuName = "m_packline" then this.MenuID = create m_packline
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_mdi_screen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mdi_screen
long BackColor=268435456
end type


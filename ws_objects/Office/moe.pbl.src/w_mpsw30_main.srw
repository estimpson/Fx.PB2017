$PBExportHeader$w_mpsw30_main.srw
forward
global type w_mpsw30_main from Window
end type
type mdi_1 from mdiclient within w_mpsw30_main
end type
end forward

global type w_mpsw30_main from Window
int X=673
int Y=265
int Width=1582
int Height=1061
boolean TitleBar=true
string Title="Order Entry"
string MenuName="mn_mw30_main"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_mpsw30_main w_mpsw30_main

on open;szInquiry = "w_inquiry"
iCurInst = 0
bCancel = False
mn_mw30_main.bScreenOpen = False
wMainScreen = w_mpsw30_main

end on

on w_mpsw30_main.create
if this.MenuName = "mn_mw30_main" then this.MenuID = create mn_mw30_main
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_mpsw30_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mpsw30_main
long BackColor=12632256
end type


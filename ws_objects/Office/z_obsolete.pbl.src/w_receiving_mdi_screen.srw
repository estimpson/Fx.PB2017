$PBExportHeader$w_receiving_mdi_screen.srw
forward
global type w_receiving_mdi_screen from Window
end type
type mdi_1 from mdiclient within w_receiving_mdi_screen
end type
end forward

global type w_receiving_mdi_screen from Window
int X=0
int Y=0
int Width=3657
int Height=2400
boolean TitleBar=true
string MenuName="m_receiving_dock"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_receiving_mdi_screen w_receiving_mdi_screen

type variables
/*
***********************************************************************
This object is the MDI Frame for the receiving dock application.

Called from:
Smart PO Processor		w_smart_po
Receiving Dock Application	mrd

References:
Generic Structure		st_generic_structure
Monitor System Variables	monsys
GF Build Custom Arrays		f_build_custom_arrays
GF Build Custom Menu		f_build_custom_menu
Receiving Dock Sheet		w_visual_receiving_dock_version2
***********************************************************************
*/

end variables

event open;//	Declarations.
st_generic_structure lst_Parm

//	I.	Set global variable for MDI screen.
wMainScreen = w_receiving_mdi_screen

//	II.	Set title to include database connection.
Title = monsys.Title + sqlca.is_Profile

//	III.	Build custom menus.
f_build_custom_arrays ( "mrd.main" )
f_build_custom_menu ( MenuID, this )

//	IV.	Open receiving dock sheet.

//		A.	Prepare generic structure to indicate no PO.
lst_Parm.value1 = String ( -1 )
lst_Parm.value2 = ''

//		B.	Open sheet.
OpenSheetWithParm ( w_visual_receiving_dock_version2, lst_Parm, wMainScreen, 3, Layered! )

end event

on w_receiving_mdi_screen.create
if this.MenuName = "m_receiving_dock" then this.MenuID = create m_receiving_dock
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_receiving_mdi_screen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_receiving_mdi_screen
long BackColor=275605865
end type


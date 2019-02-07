$PBExportHeader$w_main_screen.srw
forward
global type w_main_screen from window
end type
type mdi_1 from mdiclient within w_main_screen
end type
end forward

global type w_main_screen from window
integer x = 672
integer y = 264
integer width = 1582
integer height = 1060
boolean titlebar = true
string menuname = "m_main_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 12632256
mdi_1 mdi_1
end type
global w_main_screen w_main_screen

type variables
Boolean bOpen
Boolean bMAD30, bMIC30, bMOE30, bMPS30, bMPO30
Boolean bCustom1, bCustom2, bCustom3, bCustom4, bCustom5


end variables

forward prototypes
public subroutine f_setup_main_menu ()
public subroutine f_show_main_menu ()
end prototypes

public subroutine f_setup_main_menu ();String szButtonText
String szMenuText
String szDescription
String szCallWindow

gnv_App.of_GetFrame().ChangeMenu ( m_main_menu )
end subroutine

public subroutine f_show_main_menu ();gnv_App.of_GetFrame().ChangeMenu ( m_main_menu )

If bMIC30 = True Then
	m_main_menu.m_file.m_inventorycontrol.visible = True	
	m_main_menu.m_file.m_inventorycontrol.ToolBarItemVisible = True
End if

If bMOE30 = True Then
	m_main_menu.m_file.m_orderentry.visible = True
	m_main_menu.m_file.m_orderentry.ToolBarItemVisible = True
End if

If bMAD30 = True Then
	m_main_menu.m_file.m_administrativesetups.visible = True	
	m_main_menu.m_file.m_administrativesetups.ToolBarItemVisible = True
End if

If bMPS30 = True Then
	m_main_menu.m_file.m_productionscheduling.visible = True
	m_main_menu.m_file.m_productionscheduling.ToolBarItemVisible = True
End if

If bMPO30 = True Then
	m_main_menu.m_file.m_purchasing.visible = True
	m_main_menu.m_file.m_purchasing.ToolBarItemVisible = True
End if

//If bCustom1 = True Then
//	m_main_menu.m_file.m_custom.visible = True
//	m_main_menu.m_file.m_custom.ToolBarItemVisible = True
//End if
//
//If bCustom2 = True Then
//	m_main_menu.m_file.m_custom2.visible = True
//	m_main_menu.m_file.m_custom2.ToolBarItemVisible = True
//End if
//
//If bCustom3 = True Then
//	m_main_menu.m_file.m_custom3.visible = True
//	m_main_menu.m_file.m_custom3.ToolBarItemVisible = True
//End if
//
////If bCustom4 = True Then
////	m_main_menu.m_file.m_custom4.visible = True
////	m_main_menu.m_file.m_custom4.ToolBarItemVisible = True
////End if
////
////If bCustom5 = True Then
////	m_main_menu.m_file.m_custom5.visible = True
////	m_main_menu.m_file.m_custom5.ToolBarItemVisible = True
////End if
////
end subroutine

event open;wMainScreen = w_main_screen

//If f_get_string_value ( is_Company ) = "" Then
//	gnv_App.of_GetFrame().Title = "Administrative  --  Monitor Systems, Inc."
//Else
//	gnv_App.of_GetFrame().Title = "Administrative  --  " + is_Company
//End if

gnv_App.of_GetFrame().Title = monsys.title + sqlca.is_Profile

szInquiry = "w_inquiry"

bOpen = True

OpenSheet ( w_title_screen, w_main_screen, 3, Original! )

f_setup_main_menu ( )
f_build_custom_arrays ( "monitor.main" )
f_build_custom_menu ( This.MenuID, This )

gf_get_info ( 'w_main_screen', 0 )


end event

event activate;If bOpen = True Then
	bOpen = False
End if
end event

on w_main_screen.create
if this.MenuName = "m_main_menu" then this.MenuID = create m_main_menu
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main_screen.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_main_screen
long BackColor=12632256
end type


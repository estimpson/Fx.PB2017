$PBExportHeader$syscolor.sru
forward
global type syscolor from nonvisualobject
end type
end forward

shared variables

end variables

global type syscolor from nonvisualobject
event ue_constructor ( )
end type
global syscolor syscolor

type variables
LONG	Scrollbar, &
	Background, &
	ActiveTitle, &
	InactiveTitle, &
	Menu, &
	Window, &
	WindowFrame, &
	MenuText, &
	WindowText, &
	TitleText, &
	ActiveBorder, &
	InactiveBorder, &
	AppWorkspace, &
	Hilight, &
	HilightText, &
	ButtonFace, &
	ButtonShadow, &
	GrayText, &
	ButtonText, &
	InactiveTitleText, &
	ButtonHilight, &
	ButtonDkShadow, &
	ButtonLight, &
	InfoText, &
	InfoWindow
end variables

forward prototypes
public function long uf_parse_color (string a_s_color)
end prototypes

event ue_constructor;STRING	l_s_Scrollbar, &
			l_s_Background, &
			l_s_ActiveTitle, &
			l_s_InactiveTitle, &
			l_s_Menu, &
			l_s_Window, &
			l_s_WindowFrame, &
			l_s_MenuText, &
			l_s_WindowText, &
			l_s_TitleText, &
			l_s_ActiveBorder, &
			l_s_InactiveBorder, &
			l_s_AppWorkspace, &
			l_s_Hilight, &
			l_s_HilightText, &
			l_s_ButtonFace, &
			l_s_ButtonShadow, &
			l_s_GrayText, &
			l_s_ButtonText, &
			l_s_InactiveTitleText, &
			l_s_ButtonHilight, &
			l_s_ButtonDkShadow, &
			l_s_ButtonLight, &
			l_s_InfoText, &
			l_s_InfoWindow

RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "Scrollbar", l_s_Scrollbar )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "Background", l_s_Background )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ActiveTitle", l_s_ActiveTitle )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "InactiveTitle", l_s_InactiveTitle )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "Menu", l_s_Menu )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "Window", l_s_Window )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "WindowFrame", l_s_WindowFrame )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "MenuText", l_s_MenuText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "WindowText", l_s_WindowText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "TitleText", l_s_TitleText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ActiveBorder", l_s_ActiveBorder )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "InactiveBorder", l_s_InactiveBorder )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "AppWorkspace", l_s_AppWorkspace )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "Hilight", l_s_Hilight )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "HilightText", l_s_HilightText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ButtonFace", l_s_ButtonFace )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ButtonShadow", l_s_ButtonShadow )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "GrayText", l_s_GrayText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ButtonText", l_s_ButtonText ) 
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "InactiveTitleText", l_s_InactiveTitleText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ButtonHilight", l_s_ButtonHilight )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ButtonDkShadow", l_s_ButtonDkShadow )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "ButtonLight", l_s_ButtonLight )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "InfoText", l_s_InfoText )
RegistryGet ( "HKEY_CURRENT_USER\Control Panel\Colors", "InfoWindow", l_s_InfoWindow )

Scrollbar = uf_parse_color ( l_s_Scrollbar )
Background = uf_parse_color ( l_s_Background )
ActiveTitle = uf_parse_color ( l_s_ActiveTitle )
InactiveTitle = uf_parse_color ( l_s_InactiveTitle )
Menu = uf_parse_color ( l_s_Menu )
Window = uf_parse_color ( l_s_Window )
WindowFrame = uf_parse_color ( l_s_WindowFrame )
MenuText = uf_parse_color ( l_s_MenuText )
WindowText = uf_parse_color ( l_s_WindowText )
TitleText = uf_parse_color ( l_s_TitleText )
ActiveBorder = uf_parse_color ( l_s_ActiveBorder )
InactiveBorder = uf_parse_color ( l_s_InactiveBorder )
AppWorkspace = uf_parse_color ( l_s_AppWorkspace )
Hilight = uf_parse_color ( l_s_Hilight )
HilightText = uf_parse_color ( l_s_HilightText )
ButtonFace = uf_parse_color ( l_s_ButtonFace )
ButtonShadow = uf_parse_color ( l_s_ButtonShadow )
GrayText = uf_parse_color ( l_s_GrayText )
ButtonText = uf_parse_color ( l_s_ButtonText )
InactiveTitleText = uf_parse_color ( l_s_InactiveTitleText )
ButtonHilight = uf_parse_color ( l_s_ButtonHilight )
ButtonDkShadow = uf_parse_color ( l_s_ButtonDkShadow )
ButtonLight = uf_parse_color ( l_s_ButtonLight )
InfoText = uf_parse_color ( l_s_InfoText )
InfoWindow = uf_parse_color ( l_s_InfoWindow )
end event

public function long uf_parse_color (string a_s_color);INTEGER	l_i_red, &
			l_i_green, &
			l_i_blue, &
			l_i_space_pos

STRING	l_s_color

l_i_space_pos = PosA ( a_s_color, ' ', 1 )
l_s_color = MidA ( a_s_color, 1, l_i_space_pos - 1 )
l_i_red = Integer ( l_s_color )
a_s_color = RightA ( a_s_color, LenA ( a_s_color ) - l_i_space_pos )
l_i_space_pos = PosA ( a_s_color, ' ', 1 )
l_s_color = MidA ( a_s_color, 1, l_i_space_pos - 1 )
l_i_green = Integer ( l_s_color )
a_s_color = RightA ( a_s_color, LenA ( a_s_color ) - l_i_space_pos )
l_s_color = a_s_color
l_i_blue = Integer ( l_s_color )

Return ( RGB ( l_i_red, l_i_green, l_i_blue ) )
end function

on syscolor.create
TriggerEvent( this, "constructor" )
end on

on syscolor.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;TRIGGER EVENT ue_constructor ( )
end event


$PBExportHeader$sysmetrics.sru
forward
global type sysmetrics from nonvisualobject
end type
end forward

shared variables

end variables

global type sysmetrics from nonvisualobject
event ue_constructor ( )
end type
global sysmetrics sysmetrics

type variables
INTEGER	IconSpacingFactor, &
		BorderWidth, &
		ScrollWidth, &
		ScrollHeight, &
		CaptionWidth, &
		CaptionHeight, &
		SmCaptionWidth, &
		SmCaptionHeight, &
		MenuWidth, &
		MenuHeight, &
		IconSpacing, &
		IconVerticalSpacing, &
		Shell_Icon_Size, &
		Shell_Icon_BPP
end variables

event ue_constructor;STRING	l_s_IconSpacingFactor, &
			l_s_BorderWidth, &
			l_s_ScrollWidth, &
			l_s_ScrollHeight, &
			l_s_CaptionWidth, &
			l_s_CaptionHeight, &
			l_s_SmCaptionWidth, &
			l_s_SmCaptionHeight, &
			l_s_MenuWidth, &
			l_s_MenuHeight, &
			l_s_IconSpacing, &
			l_s_IconVerticalSpacing, &
			l_s_Shell_Icon_Size, &
			l_s_Shell_Icon_BPP
			
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "IconSpacingFactor", l_s_IconSpacingFactor )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "BorderWidth", l_s_BorderWidth )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "ScrollWidth", l_s_ScrollWidth )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "ScrollHeight", l_s_ScrollHeight )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "CaptionWidth", l_s_CaptionWidth )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "CaptionHeight", l_s_CaptionHeight )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "SmCaptionWidth", l_s_SmCaptionWidth )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "SmCaptionHeight", l_s_SmCaptionHeight )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "MenuWidth", l_s_MenuWidth )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "MenuHeight", l_s_MenuHeight )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "IconSpacing", l_s_IconSpacing )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "IconVerticalSpacing", l_s_IconVerticalSpacing )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "Shell Icon Size", l_s_Shell_Icon_Size )
RegistryGet ( "HKEY_CURRENT_USER\Contol Panel\Colors", "Shell Icon BPP", l_s_Shell_Icon_BPP )

IconSpacingFactor = Integer ( l_s_IconSpacingFactor )
BorderWidth = Integer ( l_s_BorderWidth )
ScrollWidth = Integer ( l_s_ScrollWidth )
ScrollHeight = Integer ( l_s_ScrollHeight )
CaptionWidth = Integer ( l_s_CaptionWidth )
CaptionHeight = Integer ( l_s_CaptionHeight )
SmCaptionWidth = Integer ( l_s_SmCaptionWidth )
SmCaptionHeight = Integer ( l_s_SmCaptionHeight )
MenuWidth = Integer ( l_s_MenuWidth )
MenuHeight = Integer ( l_s_MenuHeight )
IconSpacing = Integer ( l_s_IconSpacing )
IconVerticalSpacing = Integer ( l_s_IconVerticalSpacing )
Shell_Icon_Size = Integer ( l_s_Shell_Icon_Size )
Shell_Icon_BPP = Integer ( l_s_Shell_Icon_BPP )
end event

on sysmetrics.create
TriggerEvent( this, "constructor" )
end on

on sysmetrics.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;POST EVENT ue_constructor ( )
end event


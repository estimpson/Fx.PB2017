$PBExportHeader$n_tmg_tooltip.sru
forward
global type n_tmg_tooltip from timing
end type
end forward

global type n_tmg_tooltip from timing
end type
global n_tmg_tooltip n_tmg_tooltip

type variables

u_tooltip ToolTip

end variables

event timer;
Stop()
if	not ToolTip.Visible then
	ToolTip.Show()
	ToolTip.BringToTop = true
	Start(3)
else
	ToolTip.RequestorWindow.CloseUserObject(ToolTip)
end if

end event

on n_tmg_tooltip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_tmg_tooltip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


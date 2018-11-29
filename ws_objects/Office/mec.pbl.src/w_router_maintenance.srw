$PBExportHeader$w_router_maintenance.srw
forward
global type w_router_maintenance from w_sheet_4t
end type
end forward

global type w_router_maintenance from w_sheet_4t
string title = "Flow Router Maintenance"
string menuname = "m_router_maint"
event type integer ue_maint_mode ( integer a_i_mode )
event type integer ue_change_display ( integer a_i_mode )
event type integer ue_save_router ( )
event type integer ue_clicked_popup ( string text )
event ue_print ( )
event ue_fastcopy ( )
end type
global w_router_maintenance w_router_maintenance

type variables
u_router_explorer	i_uo_router
end variables

event ue_maint_mode;i_uo_router.Trigger Event ue_maint_mode ( a_i_mode )
return 1
end event

event ue_change_display;i_uo_router.Trigger Event ue_change_display ( a_i_mode )
return 1
end event

event ue_save_router;i_uo_router.Trigger Event ue_save_router ( )
return 1

end event

event ue_clicked_popup;i_uo_router.Trigger Event ue_clicked_popup ( text )
return 1
end event

event ue_print;i_uo_router.Trigger Event ue_print_router()

end event

event ue_fastcopy;i_uo_router.Trigger Event ue_setup_parts()

end event

on w_router_maintenance.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_router_maint" then this.MenuID = create m_router_maint
end on

on w_router_maintenance.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;call super::closequery;IF IsValid ( i_uo_router ) THEN 
	IF i_uo_router.of_check_for_orphans ( ) = 2 THEN
		return 1
	ELSE
		CloseUserObject ( i_uo_router )
	END IF
END IF


end event

event resize;call super::resize;IF IsValid ( i_uo_router ) THEN 
	i_uo_router.height 	= height - 125
	i_uo_router.width 	= width - 75
END IF
end event

event open;call super::open;
OpenUserObjectWithParm ( i_uo_router, Message.StringParm, "u_router_explorer" )

end event


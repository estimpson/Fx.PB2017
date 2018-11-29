$PBExportHeader$u_tabpg_fxcop_torcarawdemand.sru
forward
global type u_tabpg_fxcop_torcarawdemand from u_tabpg_dw
end type
end forward

global type u_tabpg_fxcop_torcarawdemand from u_tabpg_dw
string text = "Raw Demand"
end type
global u_tabpg_fxcop_torcarawdemand u_tabpg_fxcop_torcarawdemand

type variables
boolean Refreshing
string RawPart
end variables

forward prototypes
public function integer refresh ()
end prototypes

public function integer refresh ();
dw_1.of_Refresh(Refreshing) ; Refreshing = false
return dw_1.event pfc_retrieve()

end function

on u_tabpg_fxcop_torcarawdemand.create
call super::create
end on

on u_tabpg_fxcop_torcarawdemand.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get necessary notifications.
gnv_App.inv_StateMSGRouter.of_RequestNotification(this, "torcaraw.RawPart")


end event

event pfd_event;call super::pfd_event;
choose case EventName
	case "torcaraw.RawPart"
		Refreshing = (RawPart = eventmessage.of_GetItem("torcaraw.RawPart"))
		RawPart = eventmessage.of_GetItem("torcaraw.RawPart")
		Refresh()
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_fxcop_torcarawdemand
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_fxcop_torcarawdemand
string dataobject = "d_fxcop_demanddetails_part"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(RawPart)

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)

end event


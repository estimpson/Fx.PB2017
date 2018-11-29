$PBExportHeader$u_tabpg_partinventory_inlocation.sru
forward
global type u_tabpg_partinventory_inlocation from u_tabpg_dw
end type
end forward

global type u_tabpg_partinventory_inlocation from u_tabpg_dw
string text = "Serials"
end type
global u_tabpg_partinventory_inlocation u_tabpg_partinventory_inlocation

type variables

string Part
string LocationCode

end variables

on u_tabpg_partinventory_inlocation.create
call super::create
end on

on u_tabpg_partinventory_inlocation.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.location"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

event pfd_event;call super::pfd_event;
Part = IsNull(message.inv_Parm.of_GetItem("part"), "N/S")

//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (LocationCode = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.location"), ""))
		LocationCode = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.location"), "")
		Refresh()
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_partinventory_inlocation
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_partinventory_inlocation
string dataobject = "d_objects_per_location"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(Part, LocationCode)

end event


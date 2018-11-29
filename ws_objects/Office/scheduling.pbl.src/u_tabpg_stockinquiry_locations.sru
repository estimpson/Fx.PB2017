$PBExportHeader$u_tabpg_stockinquiry_locations.sru
forward
global type u_tabpg_stockinquiry_locations from u_tabpg_dw
end type
end forward

global type u_tabpg_stockinquiry_locations from u_tabpg_dw
integer width = 1977
string text = "Locations"
end type
global u_tabpg_stockinquiry_locations u_tabpg_stockinquiry_locations

type variables
boolean Refreshing
string	Part
string	PackType
decimal {6} PackSize

end variables

forward prototypes
public function integer refresh ()
end prototypes

public function integer refresh ();
dw_1.of_Refresh(Refreshing) ; Refreshing = false
return dw_1.event pfc_retrieve()

end function

on u_tabpg_stockinquiry_locations.create
call super::create
end on

on u_tabpg_stockinquiry_locations.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get necessary notifications.
string stockinquiryRowChangeParm [3] = {"stockinquiry.Part", "stockinquiry.PackType", "stockinquiry.PackSize"}
gnv_App.inv_StateMSGRouter.Register("stockinquiry.PartPack", stockinquiryRowChangeParm, this)

end event

event pfd_event;call super::pfd_event;
choose case eventName
	case "stockinquiry.PartPack"
		Part = eventMessage.of_GetItem("stockinquiry.Part")
		PackType = eventMessage.of_GetItem("stockinquiry.PackType")
		PackSize = eventMessage.of_GetItem("stockinquiry.PackSize")
		dw_1.event pfc_retrieve()
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_stockinquiry_locations
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_stockinquiry_locations
string dataobject = "d_stockinquiry_locations"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(Part, PackType, PackSize)

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)

end event


$PBExportHeader$u_tabpg_stockinquiry_summary.sru
forward
global type u_tabpg_stockinquiry_summary from u_tabpg_dw
end type
end forward

global type u_tabpg_stockinquiry_summary from u_tabpg_dw
integer width = 1977
string text = "Summary"
end type
global u_tabpg_stockinquiry_summary u_tabpg_stockinquiry_summary

type variables
boolean Refreshing

end variables

forward prototypes
public function integer refresh ()
end prototypes

public function integer refresh ();
dw_1.of_Refresh(Refreshing) ; Refreshing = false
return dw_1.event pfc_retrieve()

end function

on u_tabpg_stockinquiry_summary.create
call super::create
end on

on u_tabpg_stockinquiry_summary.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_stockinquiry_summary
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_stockinquiry_summary
string dataobject = "d_stockinquiry_summary"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
ib_RMBMenu = false
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event dw_1::retrieveend;call super::retrieveend;
if	rowcount > 0 then
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("stockinquiry.Part", object.Part[GetRow()])
	eventParm.of_SetItem("stockinquiry.PackType", object.PackageType[GetRow()])
	eventParm.of_SetItem("stockinquiry.PackSize", object.PackSize[GetRow()])
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
if	currentrow > 0 then
	n_cst_associative_array	eventParm
	eventParm.of_SetItem("stockinquiry.Part", object.Part[currentrow])
	eventParm.of_SetItem("stockinquiry.PackType", object.PackageType[currentrow])
	eventParm.of_SetItem("stockinquiry.PackSize", object.PackSize[currentrow])
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event


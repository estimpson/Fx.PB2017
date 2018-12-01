$PBExportHeader$w_customreport_inventoryvalue.srw
forward
global type w_customreport_inventoryvalue from w_customreport
end type
end forward

global type w_customreport_inventoryvalue from w_customreport
integer x = 214
integer y = 221
string title = "Inv Value"
end type
global w_customreport_inventoryvalue w_customreport_inventoryvalue

on w_customreport_inventoryvalue.create
call super::create
end on

on w_customreport_inventoryvalue.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;
dw_report.event pfc_Retrieve()

end event

type dw_report from w_customreport`dw_report within w_customreport_inventoryvalue
string dataobject = "customreport_inventory_value"
end type

event dw_report::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event


HA$PBExportHeader$u_tabpg_shipping_showlistedshippers.sru
forward
global type u_tabpg_shipping_showlistedshippers from u_tabpg_dw
end type
end forward

global type u_tabpg_shipping_showlistedshippers from u_tabpg_dw
integer width = 2359
end type
global u_tabpg_shipping_showlistedshippers u_tabpg_shipping_showlistedshippers

type variables

string _shipperList

end variables

forward prototypes
public function integer setshipperlist (string shipperlist)
end prototypes

public function integer setshipperlist (string shipperlist);
_shipperList = shipperList
return Refresh()

end function

on u_tabpg_shipping_showlistedshippers.create
call super::create
end on

on u_tabpg_shipping_showlistedshippers.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_showlistedshippers
string text = "Open Shippers"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_showlistedshippers
string dataobject = "d_shipping_viewlistedshippers"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_shipperList)

end event


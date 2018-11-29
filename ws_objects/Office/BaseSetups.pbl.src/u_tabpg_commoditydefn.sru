$PBExportHeader$u_tabpg_commoditydefn.sru
forward
global type u_tabpg_commoditydefn from u_tabpg_dw
end type
end forward

global type u_tabpg_commoditydefn from u_tabpg_dw
string text = "Commodity Definitions"
end type
global u_tabpg_commoditydefn u_tabpg_commoditydefn

on u_tabpg_commoditydefn.create
call super::create
end on

on u_tabpg_commoditydefn.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_commoditydefn
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_commoditydefn
string dataobject = "d_xcommoditydefn"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)
Retrieve()

end event


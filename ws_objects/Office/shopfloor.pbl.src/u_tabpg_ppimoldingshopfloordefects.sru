$PBExportHeader$u_tabpg_ppimoldingshopfloordefects.sru
forward
global type u_tabpg_ppimoldingshopfloordefects from u_tabpg_ppimoldingshopfloorjobdetails
end type
end forward

global type u_tabpg_ppimoldingshopfloordefects from u_tabpg_ppimoldingshopfloorjobdetails
string text = "Defects"
end type
global u_tabpg_ppimoldingshopfloordefects u_tabpg_ppimoldingshopfloordefects

on u_tabpg_ppimoldingshopfloordefects.create
int iCurrent
call super::create
end on

on u_tabpg_ppimoldingshopfloordefects.destroy
call super::destroy
end on

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloordefects
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloordefects
end type

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloordefects
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloordefects
end type

type uo_rowcontrol from u_tabpg_ppimoldingshopfloorjobdetails`uo_rowcontrol within u_tabpg_ppimoldingshopfloordefects
end type


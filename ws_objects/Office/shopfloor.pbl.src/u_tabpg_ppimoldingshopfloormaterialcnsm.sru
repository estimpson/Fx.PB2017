$PBExportHeader$u_tabpg_ppimoldingshopfloormaterialcnsm.sru
forward
global type u_tabpg_ppimoldingshopfloormaterialcnsm from u_tabpg_ppimoldingshopfloorjobdetails
end type
end forward

global type u_tabpg_ppimoldingshopfloormaterialcnsm from u_tabpg_ppimoldingshopfloorjobdetails
string text = "Material Consumption"
end type
global u_tabpg_ppimoldingshopfloormaterialcnsm u_tabpg_ppimoldingshopfloormaterialcnsm

on u_tabpg_ppimoldingshopfloormaterialcnsm.create
call super::create
end on

on u_tabpg_ppimoldingshopfloormaterialcnsm.destroy
call super::destroy
end on

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloormaterialcnsm
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloormaterialcnsm
end type

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloormaterialcnsm
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloormaterialcnsm
end type


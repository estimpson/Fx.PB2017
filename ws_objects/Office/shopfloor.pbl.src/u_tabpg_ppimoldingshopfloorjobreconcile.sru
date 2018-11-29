$PBExportHeader$u_tabpg_ppimoldingshopfloorjobreconcile.sru
forward
global type u_tabpg_ppimoldingshopfloorjobreconcile from u_tabpg_ppimoldingshopfloorjobdetails
end type
end forward

global type u_tabpg_ppimoldingshopfloorjobreconcile from u_tabpg_ppimoldingshopfloorjobdetails
string text = "Job Reconciliation"
end type
global u_tabpg_ppimoldingshopfloorjobreconcile u_tabpg_ppimoldingshopfloorjobreconcile

on u_tabpg_ppimoldingshopfloorjobreconcile.create
call super::create
end on

on u_tabpg_ppimoldingshopfloorjobreconcile.destroy
call super::destroy
end on

type gb_1 from u_tabpg_ppimoldingshopfloorjobdetails`gb_1 within u_tabpg_ppimoldingshopfloorjobreconcile
end type

type dw_1 from u_tabpg_ppimoldingshopfloorjobdetails`dw_1 within u_tabpg_ppimoldingshopfloorjobreconcile
end type

type dw_parent from u_tabpg_ppimoldingshopfloorjobdetails`dw_parent within u_tabpg_ppimoldingshopfloorjobreconcile
end type

type gb_parent from u_tabpg_ppimoldingshopfloorjobdetails`gb_parent within u_tabpg_ppimoldingshopfloorjobreconcile
end type


$PBExportHeader$part_detail_maint_from.srw
$PBExportComments$TSM Cust. Serv. - Part Detail Table Maint. Form (Form) - Ok to be used with SQL Server DB
forward
global type part_detail_maint_from from w_pbstyle_freeform
end type
end forward

global type part_detail_maint_from from w_pbstyle_freeform
int Width=5852
int Height=3841
boolean TitleBar=true
string Title="part_detail_maint_from"
end type
global part_detail_maint_from part_detail_maint_from

on part_detail_maint_from.create
call w_pbstyle_freeform::create
end on

on part_detail_maint_from.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within part_detail_maint_from
int Width=5852
int Height=3841
string DataObject="part_detail_maint_from@1"
end type


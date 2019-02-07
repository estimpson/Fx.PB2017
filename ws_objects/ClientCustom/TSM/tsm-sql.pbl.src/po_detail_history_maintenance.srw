$PBExportHeader$po_detail_history_maintenance.srw
$PBExportComments$TSM Matl. Mngmt. - Monitor PO Detail History Maintenance (Form) - Ok to be used with SQL Server DB
forward
global type po_detail_history_maintenance from w_pbstyle_freeform
end type
end forward

global type po_detail_history_maintenance from w_pbstyle_freeform
int Width=5852
int Height=3841
boolean TitleBar=true
string Title="po_detail_history_maintenance"
end type
global po_detail_history_maintenance po_detail_history_maintenance

on po_detail_history_maintenance.create
call w_pbstyle_freeform::create
end on

on po_detail_history_maintenance.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within po_detail_history_maintenance
int Width=5852
int Height=3841
string DataObject="po_detail_history_maintenance@1"
end type


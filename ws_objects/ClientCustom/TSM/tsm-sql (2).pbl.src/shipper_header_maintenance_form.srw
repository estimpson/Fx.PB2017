$PBExportHeader$shipper_header_maintenance_form.srw
$PBExportComments$TSM Shpg. - Form used to record reasons for late shipments and premium freight issues (Form) - Ok to be used with SQL Server DB
forward
global type shipper_header_maintenance_form from w_pbstyle_freeform
end type
end forward

global type shipper_header_maintenance_form from w_pbstyle_freeform
int Width=5852
int Height=3841
boolean TitleBar=true
string Title="shipper_header_maintenance_form"
end type
global shipper_header_maintenance_form shipper_header_maintenance_form

on shipper_header_maintenance_form.create
call w_pbstyle_freeform::create
end on

on shipper_header_maintenance_form.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within shipper_header_maintenance_form
int Width=5852
int Height=3841
string DataObject="shipper_header_maintenance_form@1"
end type


$PBExportHeader$shop_floor_time_log_form.srw
$PBExportComments$TSM Manf. - Shop Floor Time Log Maintenance (Form) - Ok to be used with SQL Server DB
forward
global type shop_floor_time_log_form from w_pbstyle_freeform
end type
end forward

global type shop_floor_time_log_form from w_pbstyle_freeform
int Width=5852
int Height=3841
boolean TitleBar=true
string Title="sftimelg"
end type
global shop_floor_time_log_form shop_floor_time_log_form

on shop_floor_time_log_form.create
call w_pbstyle_freeform::create
end on

on shop_floor_time_log_form.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within shop_floor_time_log_form
int Width=5852
int Height=3841
string DataObject="shop_floor_time_log_form@1"
end type


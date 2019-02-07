$PBExportHeader$part_mach_pcs_per_hour_form.srw
forward
global type part_mach_pcs_per_hour_form from w_pbstyle_freeform
end type
end forward

global type part_mach_pcs_per_hour_form from w_pbstyle_freeform
int Width=5852
int Height=3841
boolean TitleBar=true
string Title="part_mach_pcs_per_hour_form"
end type
global part_mach_pcs_per_hour_form part_mach_pcs_per_hour_form

on part_mach_pcs_per_hour_form.create
call w_pbstyle_freeform::create
end on

on part_mach_pcs_per_hour_form.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within part_mach_pcs_per_hour_form
int Width=5852
int Height=3841
string DataObject="part_mach_pcs_per_hour_form@1"
end type


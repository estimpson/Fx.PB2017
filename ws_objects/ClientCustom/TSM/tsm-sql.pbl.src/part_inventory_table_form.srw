$PBExportHeader$part_inventory_table_form.srw
$PBExportComments$TSM Matl. Mngmt. - Monitor's Part_Inventory Table with modified usage so that Torca could use it for better purposes. (Form) Ok to be used with SQL Server DB
forward
global type part_inventory_table_form from w_pbstyle_freeform
end type
end forward

global type part_inventory_table_form from w_pbstyle_freeform
int Width=5852
int Height=3841
boolean TitleBar=true
string Title="part_inventory_table_form"
end type
global part_inventory_table_form part_inventory_table_form

on part_inventory_table_form.create
call w_pbstyle_freeform::create
end on

on part_inventory_table_form.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within part_inventory_table_form
int Width=5852
int Height=3841
string DataObject="part_inventory_table_form@1"
end type


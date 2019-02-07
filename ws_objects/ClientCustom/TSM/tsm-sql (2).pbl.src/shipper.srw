$PBExportHeader$shipper.srw
forward
global type shipper from w_pbstyle_freeform
end type
end forward

global type shipper from w_pbstyle_freeform
int Width=7314
int Height=4800
boolean TitleBar=true
string Title="shipper"
end type
global shipper shipper

on shipper.create
call super::create
end on

on shipper.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within shipper
int Width=7314
int Height=2400
string DataObject="shipper@1"
end type


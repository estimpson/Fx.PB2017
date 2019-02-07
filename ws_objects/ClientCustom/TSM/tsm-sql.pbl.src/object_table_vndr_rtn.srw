$PBExportHeader$object_table_vndr_rtn.srw
forward
global type object_table_vndr_rtn from w_pbstyle_freeform
end type
end forward

global type object_table_vndr_rtn from w_pbstyle_freeform
int Width=5689
int Height=3841
boolean TitleBar=true
string Title="object_table_vndr_rtn"
end type
global object_table_vndr_rtn object_table_vndr_rtn

on object_table_vndr_rtn.create
call w_pbstyle_freeform::create
end on

on object_table_vndr_rtn.destroy
call w_pbstyle_freeform::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within object_table_vndr_rtn
int Width=5689
int Height=3841
string DataObject="object_table_vndr_rtn@1"
end type


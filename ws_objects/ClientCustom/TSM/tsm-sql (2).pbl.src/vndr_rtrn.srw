$PBExportHeader$vndr_rtrn.srw
forward
global type vndr_rtrn from w_pbstyle_freeform
end type
end forward

global type vndr_rtrn from w_pbstyle_freeform
int Width=7314
int Height=4800
boolean TitleBar=true
string Title="vndr_rtrn"
end type
global vndr_rtrn vndr_rtrn

on vndr_rtrn.create
call super::create
end on

on vndr_rtrn.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_freeform from w_pbstyle_freeform`dw_freeform within vndr_rtrn
int Width=7314
int Height=2400
string DataObject="vndr_rtrn@1"
end type


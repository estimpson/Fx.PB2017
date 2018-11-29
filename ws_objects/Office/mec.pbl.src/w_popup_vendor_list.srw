$PBExportHeader$w_popup_vendor_list.srw
forward
global type w_popup_vendor_list from w_popup_list_ancestor
end type
end forward

global type w_popup_vendor_list from w_popup_list_ancestor
boolean TitleBar=true
string Title="Vendor List"
end type
global w_popup_vendor_list w_popup_vendor_list

on w_popup_vendor_list.create
call w_popup_list_ancestor::create
end on

on w_popup_vendor_list.destroy
call w_popup_list_ancestor::destroy
end on

type dw_1 from w_popup_list_ancestor`dw_1 within w_popup_vendor_list
string Tag="vendor"
string DataObject="d_popup_vendor_list"
string Icon="Next5!"
end type


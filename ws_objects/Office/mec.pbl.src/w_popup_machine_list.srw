$PBExportHeader$w_popup_machine_list.srw
forward
global type w_popup_machine_list from w_popup_list_ancestor
end type
end forward

global type w_popup_machine_list from w_popup_list_ancestor
boolean TitleBar=true
string Title="Machine List"
end type
global w_popup_machine_list w_popup_machine_list

on w_popup_machine_list.create
call w_popup_list_ancestor::create
end on

on w_popup_machine_list.destroy
call w_popup_list_ancestor::destroy
end on

type dw_1 from w_popup_list_ancestor`dw_1 within w_popup_machine_list
string Tag="machine"
string DataObject="d_popup_machine_list"
end type


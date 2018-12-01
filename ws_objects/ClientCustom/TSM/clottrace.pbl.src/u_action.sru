$PBExportHeader$u_action.sru
forward
global type u_action from u_fxdw
end type
end forward

global type u_action from u_fxdw
integer width = 480
integer height = 656
string dataobject = "d_actionmenu"
end type
global u_action u_action

type variables

string CommandButtonsText[]
string Commands[]

end variables
on u_action.create
call super::create
end on

on u_action.destroy
call super::destroy
end on


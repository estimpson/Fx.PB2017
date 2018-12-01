$PBExportHeader$u_tabpg_electricaltester_loadedkanbans.sru
forward
global type u_tabpg_electricaltester_loadedkanbans from u_tabpg_dw
end type
end forward

global type u_tabpg_electricaltester_loadedkanbans from u_tabpg_dw
integer width = 1977
end type
global u_tabpg_electricaltester_loadedkanbans u_tabpg_electricaltester_loadedkanbans

type variables

string _electricalTesterMachine

end variables
forward prototypes
public function integer setelectricaltestermachine (string code)
end prototypes

public function integer setelectricaltestermachine (string code);
_electricalTesterMachine = code
return Refresh()

end function

on u_tabpg_electricaltester_loadedkanbans.create
call super::create
end on

on u_tabpg_electricaltester_loadedkanbans.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_electricaltester_loadedkanbans
string text = "Loaded Kanbans"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_electricaltester_loadedkanbans
string dataobject = "d_electricaltester_kanbanloadhistory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_electricalTesterMachine)

end event


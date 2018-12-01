$PBExportHeader$u_tabpg_leaktester_inprocessharnesses.sru
forward
global type u_tabpg_leaktester_inprocessharnesses from u_tabpg_dw
end type
end forward

global type u_tabpg_leaktester_inprocessharnesses from u_tabpg_dw
end type
global u_tabpg_leaktester_inprocessharnesses u_tabpg_leaktester_inprocessharnesses

type variables

string _leakTesterMachine
end variables
forward prototypes
public function integer setleaktestermachine (string machine)
end prototypes

public function integer setleaktestermachine (string machine);
_leakTesterMachine = machine
return Refresh()

end function

on u_tabpg_leaktester_inprocessharnesses.create
call super::create
end on

on u_tabpg_leaktester_inprocessharnesses.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_leaktester_inprocessharnesses
string text = "Inprocess Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_leaktester_inprocessharnesses
string dataobject = "d_leaktester_inprocessharnesslist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_leakTesterMachine)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event


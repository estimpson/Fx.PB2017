$PBExportHeader$u_tabpg_pottingroom_inprocessharnesses.sru
forward
global type u_tabpg_pottingroom_inprocessharnesses from u_tabpg_dw
end type
end forward

global type u_tabpg_pottingroom_inprocessharnesses from u_tabpg_dw
end type
global u_tabpg_pottingroom_inprocessharnesses u_tabpg_pottingroom_inprocessharnesses

type variables

string _pottingRoomMachineCode

end variables
forward prototypes
public function integer setpottingroommachine (string code)
end prototypes

public function integer setpottingroommachine (string code);
_pottingRoomMachineCode = code
return Refresh()

end function

on u_tabpg_pottingroom_inprocessharnesses.create
call super::create
end on

on u_tabpg_pottingroom_inprocessharnesses.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_pottingroom_inprocessharnesses
string text = "Inprocess Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_pottingroom_inprocessharnesses
string dataobject = "d_pottingroom_inprocessharnesslist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_pottingRoomMachineCode)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event


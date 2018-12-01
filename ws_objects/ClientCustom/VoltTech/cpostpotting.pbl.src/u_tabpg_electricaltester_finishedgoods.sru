$PBExportHeader$u_tabpg_electricaltester_finishedgoods.sru
forward
global type u_tabpg_electricaltester_finishedgoods from u_tabpg_dw
end type
end forward

global type u_tabpg_electricaltester_finishedgoods from u_tabpg_dw
end type
global u_tabpg_electricaltester_finishedgoods u_tabpg_electricaltester_finishedgoods

type variables

private:
long _boxSerial
end variables
forward prototypes
public function integer setboxserial (long serial)
end prototypes

public function integer setboxserial (long serial);
_BoxSerial = serial
return Refresh()

end function

on u_tabpg_electricaltester_finishedgoods.create
call super::create
end on

on u_tabpg_electricaltester_finishedgoods.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_electricaltester_finishedgoods
string text = "Good Harnesses"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_electricaltester_finishedgoods
string dataobject = "d_electricaltester_boxharnesslist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_boxSerial)

end event


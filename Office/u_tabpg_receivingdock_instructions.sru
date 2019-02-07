HA$PBExportHeader$u_tabpg_receivingdock_instructions.sru
forward
global type u_tabpg_receivingdock_instructions from u_tabpg_dw
end type
end forward

global type u_tabpg_receivingdock_instructions from u_tabpg_dw
end type
global u_tabpg_receivingdock_instructions u_tabpg_receivingdock_instructions

type variables

private:

//	Model data.
string _receiverNumber

//	Controller reference.
n_cst_receivingdock_controller _myController

end variables

forward prototypes
public function integer setreceivernumber (string receivernumber)
end prototypes

public function integer setreceivernumber (string receivernumber);
_receiverNumber = receiverNumber
return Refresh()

end function

on u_tabpg_receivingdock_instructions.create
call super::create
end on

on u_tabpg_receivingdock_instructions.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receivingdock_instructions
string text = "Instructions"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receivingdock_instructions
string dataobject = "d_receivingdock_getreceiverinstructions"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_receiverNumber)

end event


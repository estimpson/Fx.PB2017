$PBExportHeader$w_inventory_cyclecount_recoverserial_pu.srw
forward
global type w_inventory_cyclecount_recoverserial_pu from w_response_4t
end type
end forward

shared variables

end variables

global type w_inventory_cyclecount_recoverserial_pu from w_response_4t
integer x = 214
integer y = 221
string title = "Recover Serial"
end type
global w_inventory_cyclecount_recoverserial_pu w_inventory_cyclecount_recoverserial_pu

type variables

n_cst_inventory_cyclecount_controller Controller

end variables

event pfc_preopen;call super::pfc_preopen;
of_SetUpdateable(true)

Controller = message.PowerObjectParm
Controller.ShowRecoverSerial()

end event

on w_inventory_cyclecount_recoverserial_pu.create
int iCurrent
call super::create
end on

on w_inventory_cyclecount_recoverserial_pu.destroy
call super::destroy
end on

type uo_1 from w_response_4t`uo_1 within w_inventory_cyclecount_recoverserial_pu
integer width = 1751
end type


$PBExportHeader$u_tabpg_custsrv_custmaint_billtos.sru
forward
global type u_tabpg_custsrv_custmaint_billtos from u_tabpg_custsrv_custmaint_base
end type
end forward

global type u_tabpg_custsrv_custmaint_billtos from u_tabpg_custsrv_custmaint_base
end type
global u_tabpg_custsrv_custmaint_billtos u_tabpg_custsrv_custmaint_billtos

type variables

string BillToCode
end variables

on u_tabpg_custsrv_custmaint_billtos.create
call super::create
end on

on u_tabpg_custsrv_custmaint_billtos.destroy
call super::destroy
end on

type gb_1 from u_tabpg_custsrv_custmaint_base`gb_1 within u_tabpg_custsrv_custmaint_billtos
end type

type dw_1 from u_tabpg_custsrv_custmaint_base`dw_1 within u_tabpg_custsrv_custmaint_billtos
string dataobject = "d_customerservice_billtos"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activeRow <= 0 or activeRow > RowCount() then
	BillToCode = ""
	//Controller.SetBillToCode(BillToCode)
	return
end if
BillToCode = Object.BillToCode[activeRow]
//Controller.SetBillToCode(BillToCode)

end event

event dw_1::getfocus;call super::getfocus;
//Controller.event BillTosHaveFocus()

end event


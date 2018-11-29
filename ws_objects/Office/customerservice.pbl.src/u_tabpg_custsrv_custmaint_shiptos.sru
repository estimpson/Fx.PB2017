$PBExportHeader$u_tabpg_custsrv_custmaint_shiptos.sru
forward
global type u_tabpg_custsrv_custmaint_shiptos from u_tabpg_custsrv_custmaint_base
end type
end forward

global type u_tabpg_custsrv_custmaint_shiptos from u_tabpg_custsrv_custmaint_base
end type
global u_tabpg_custsrv_custmaint_shiptos u_tabpg_custsrv_custmaint_shiptos

type variables

string	BillToCode
string ShipToCode

end variables

on u_tabpg_custsrv_custmaint_shiptos.create
call super::create
end on

on u_tabpg_custsrv_custmaint_shiptos.destroy
call super::destroy
end on

type gb_1 from u_tabpg_custsrv_custmaint_base`gb_1 within u_tabpg_custsrv_custmaint_shiptos
end type

type dw_1 from u_tabpg_custsrv_custmaint_base`dw_1 within u_tabpg_custsrv_custmaint_shiptos
string dataobject = "d_customerservice_shiptos"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(BillToCode)

end event

event dw_1::getfocus;call super::getfocus;
//Controller.event ShipTosHaveFocus()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activeRow <= 0 or activeRow > RowCount() then
	ShipToCode = ""
	//Controller.SetShipToCode(ShipToCode)
	return
end if
ShipToCode = Object.ShipToCode[activeRow]
//Controller.SetShipToCode(ShipToCode)

end event


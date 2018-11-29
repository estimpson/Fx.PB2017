$PBExportHeader$u_tabpg_customerservice_shiptos.sru
forward
global type u_tabpg_customerservice_shiptos from u_tabpg_dw
end type
end forward

global type u_tabpg_customerservice_shiptos from u_tabpg_dw
integer width = 3826
string text = "Destinations"
end type
global u_tabpg_customerservice_shiptos u_tabpg_customerservice_shiptos

type variables

string	BillToCode

end variables

on u_tabpg_customerservice_shiptos.create
call super::create
end on

on u_tabpg_customerservice_shiptos.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
//	e.g.:
masterDWO[1] = dw_1.object.shiptocode

//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.billtocode"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		any newBillToCode
		newBillToCode = eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.billtocode")
		if	not IsNull(newBillToCode) then
			Refreshing = (BillToCode = newBillToCode)
			BillToCode = newBillToCode
			Refresh()
		else
			dw_1.Reset()
		end if
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_customerservice_shiptos
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_customerservice_shiptos
string dataobject = "d_customerservice_shiptos"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(BillToCode)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event


$PBExportHeader$u_tabpg_cs_orderpendingapprovaldetails.sru
forward
global type u_tabpg_cs_orderpendingapprovaldetails from u_tabpg_dw
end type
end forward

global type u_tabpg_cs_orderpendingapprovaldetails from u_tabpg_dw
integer width = 1977
string text = "Order Details"
end type
global u_tabpg_cs_orderpendingapprovaldetails u_tabpg_cs_orderpendingapprovaldetails

type variables

long	OrderNo

end variables

on u_tabpg_cs_orderpendingapprovaldetails.create
call super::create
end on

on u_tabpg_cs_orderpendingapprovaldetails.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.orderno"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (OrderNo = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.orderno"), -1))
		OrderNo = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.orderno"), -1)
		Refresh()
end choose

end event

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_cs_orderpendingapprovaldetails
string dataobject = "d_dbo_cs_orderpendingapprovaldetails"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(OrderNo)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_cs_orderpendingapprovaldetails
string text = "Order Details"
end type


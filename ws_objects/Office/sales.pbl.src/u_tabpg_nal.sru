$PBExportHeader$u_tabpg_nal.sru
forward
global type u_tabpg_nal from u_tabpg_dw
end type
end forward

global type u_tabpg_nal from u_tabpg_dw
string text = "RAN History"
end type
global u_tabpg_nal u_tabpg_nal

type variables

int	SalesOrderNo

end variables

on u_tabpg_nal.create
call super::create
end on

on u_tabpg_nal.destroy
call super::destroy
end on

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
//	e.g.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (SalesOrderNo = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.salesorderno"), -1))
		SalesOrderNo = IsNull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.salesorderno"), -1)
		Refresh()
end choose

end event

event constructor;call super::constructor;
//	Descendents (detail)
//	Register for notification to changes in the master.
//	e.g.
masterDWOName[1] = String(windowHandle)+".MasterDWO.salesorderno"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_nal
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_nal
string dataobject = "d_nalrannumbersshipped"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
datawindowchild dwc

if	GetChild("OrderNo", dwc) = 1 then
	dwc.SetTransObject(SQLCA)
	if	dwc.Retrieve(SalesOrderNo) = 0 then
		dwc.InsertRow(0)
	end if
end if

if	GetChild("RanNumber", dwc) = 1 then
	dwc.SetTransObject(SQLCA)
	if	dwc.Retrieve(SalesOrderNo) = 0 then
		dwc.InsertRow(0)
	end if
end if

if	GetChild("Shipper", dwc) = 1 then
	dwc.SetTransObject(SQLCA)
	if	dwc.Retrieve(SalesOrderNo) = 0 then
		dwc.InsertRow(0)
	end if
end if

return Retrieve(SalesOrderNo)

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::updateend;call super::updateend;
commit using SQLCA  ;

end event


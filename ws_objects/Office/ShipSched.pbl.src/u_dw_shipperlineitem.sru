$PBExportHeader$u_dw_shipperlineitem.sru
forward
global type u_dw_shipperlineitem from u_dw
end type
end forward

global type u_dw_shipperlineitem from u_dw
int Width=2514
int Height=944
string DataObject="d_shipperlineitem"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean HSplitScroll=true
event pfc_event(string eventname,  n_cst_associative_array eventmessage)
end type
global u_dw_shipperlineitem u_dw_shipperlineitem

type variables

private long	il_Shipper = -1

end variables

event pfc_event;
//	Process destination changes.
choose case EventName
	case "Shipper"
		il_Shipper = EventMessage.of_GetItem("Shipper")
		of_Retrieve()
end choose

end event

event constructor;call super::constructor;
//	Set Transaction Object and Retrieve.
SetTransObject(SQLCA)

//	Turn off Row Selection service.
of_SetRowSelect(false)

//	Turn off PFC right button popup menu so that our own can be used.
ib_RMBMenu = false

//	Request notification of Shipper change.
gnv_App.inv_StateMsgRouter.of_RequestNotification(this, "Shipper")

end event

event pfc_retrieve;call super::pfc_retrieve;
//	Retrieve the line items.
return Retrieve(il_Shipper)

end event


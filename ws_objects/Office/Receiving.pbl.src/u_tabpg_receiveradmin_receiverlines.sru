$PBExportHeader$u_tabpg_receiveradmin_receiverlines.sru
forward
global type u_tabpg_receiveradmin_receiverlines from u_tabpg_dw
end type
end forward

global type u_tabpg_receiveradmin_receiverlines from u_tabpg_dw
integer width = 2263
string text = "Lines Overview"
end type
global u_tabpg_receiveradmin_receiverlines u_tabpg_receiveradmin_receiverlines

type prototypes


end prototypes

type variables

private long ReceiverID
private n_cst_receivingdock ReceivingDock
end variables

forward prototypes
public function integer save ()
public function integer new ()
end prototypes

public function integer save ();
integer updateReturn
updateReturn = dw_1.Update(true)
if	updateReturn = 1 then
	commit;
else
	msgBox("Save Failed!")
end if
return	updateReturn

end function

public function integer new ();
return dw_1.InsertRow(dw_1.GetRow())

end function

on u_tabpg_receiveradmin_receiverlines.create
call super::create
end on

on u_tabpg_receiveradmin_receiverlines.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
masterDWO[1] = dw_1.object.receiverlineid

//	Descendents (detail)
//	Register for notification to changes in the master.
masterDWOName[1] = String(windowHandle)+".MasterDWO.receiverid"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

ReceivingDock = create n_cst_receivingdock

end event

event pfd_event;call super::pfd_event;
choose case EventName
//	Descendents (detail)
//	Handle notification to changes in the master.
	case String(windowHandle)+".MasterDWO"
		Refreshing = (ReceiverID = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.receiverid"), -1))
		ReceiverID = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.receiverid"), -1)
		Refresh()
end choose

end event

event destructor;call super::destructor;
destroy ReceivingDock

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receiveradmin_receiverlines
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receiveradmin_receiverlines
string tag = "receiveradmin"
string dataobject = "d_receiverlines"
end type

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
of_SetTransObject(SQLCA)

of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

end event

event dw_1::pfc_addrow;
//Not supported, override ancestor.
msgbox("Manually entered lines not supported.")
return GetRow()

end event

event dw_1::itemchanged;call super::itemchanged;
integer	confirmation
long	changeResult
long	remainingBoxes
decimal stdPackQty, remainingQty, receivedQty, totalReceiveQty
choose case lower(dwo.Name)
	case "packagetype"
		confirmation = MsgBox("Change package type on all unreceived boxes?", Question!, YesNo!, 2)
		if	confirmation = 1 then
			if	ReceivingDock.changePackageType_ofReceiverLine(object.ReceiverLineID[row], data, changeResult) = SUCCESS then
				RefreshNotify()
			else
				MsgBox("Change failed! [" + String(changeResult)+ "]")
				return 2
			end if
		else
			return 2
		end if
	case "remainingboxes"
		remainingBoxes = Integer(data)
		stdPackQty = object.StdPackQty[row]
		remainingQty = remainingBoxes * stdPackQty
		confirmation = MsgBox("The new remaining quantity to be received will be " + String (remainingQty, "###,##0.0#####") + &
			" (" + String (remainingBoxes) + " objects @ " + String (stdPackQty, "###,##0.0#####") + ").  Change remaining boxes?", Information!, YesNo!, 2)
		if	confirmation = 1 then
			if	ReceivingDock.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				RefreshNotify()
			else
				MsgBox("Change failed! [" + String(changeResult)+ "]")
				return 2
			end if
		else
			return 2
		end if
	case "stdpackqty"
		remainingBoxes = object.RemainingBoxes[row]
		stdPackQty = Dec(data)
		remainingQty = remainingBoxes * stdPackQty
		confirmation = MsgBox("The new remaining quantity to be received will be " + String (remainingQty, "###,##0.0#####") + &
			" (" + String (remainingBoxes) + " objects @ " + String (stdPackQty, "###,##0.0#####") + " per object).  Change per object quantity?", Information!, YesNo!, 2)
		if	confirmation = 1 then
			if	ReceivingDock.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				RefreshNotify()
			else
				MsgBox("Change failed! [" + String(changeResult)+ "]")
				return 2
			end if
		else
			return 2
		end if
	case "totalreceiveqty"
		totalReceiveQty = Dec(data)
		stdPackQty = object.StdPackQty[row]
		receivedQty = (object.receivedqty[row])
		remainingQty = totalReceiveQty - receivedQty 
		if	remainingQty < 0 then
			MsgBox("You cannot set the total receive quantity below below the quantity already received (" + String (receivedQty, "###,##0.0#####") + ")!")
			return 2
		end if
		confirmation = MsgBox("The remaining balance to be received will be " + String (remainingQty, "###,##0.0#####") + &
			" (" + String (totalReceiveQty, "###,##0.0#####") + " total - " + String (object.TotalReceiveQty[row] - object.TotalRemainingQty[row], "###,##0.0#####") + " received).  Change total receive quantity?", Information!, YesNo!, 2)
		if	confirmation = 1 then
			if	ReceivingDock.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				RefreshNotify()
			else
				MsgBox("Change failed! [" + String(changeResult)+ "]")
				return 2
			end if
		else
			return 2
		end if
	case "totalremainingqty"
		stdPackQty = object.StdPackQty[row]
		remainingQty = Dec(data)
		confirmation = MsgBox("The remaining balance to be received will be " + String (remainingQty, "###,##0.0#####") + ".  Change total receive quantity?", Information!, YesNo!, 2)
		if	confirmation = 1 then
			if	ReceivingDock.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				RefreshNotify()
			else
				MsgBox("Change failed! [" + String(changeResult)+ "]")
				return 2
			end if
		else
			return 2
		end if
end choose

///refactor to bll
Update(true)
commit  ;

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(ReceiverID)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow < 1 then return

string currentPart
currentPart = object.PartCode[activerow]

datawindowchild packageTypeDWC
if	GetChild("PackageType", packageTypeDWC) = 1 then
	packageTypeDWC.SetTransObject(SQLCA)
	if	packageTypeDWC.Retrieve(currentPart) = 0 then
		packageTypeDWC.InsertRow(0)
	end if
end if

end event


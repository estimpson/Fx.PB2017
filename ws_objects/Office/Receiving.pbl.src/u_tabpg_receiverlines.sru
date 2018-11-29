$PBExportHeader$u_tabpg_receiverlines.sru
forward
global type u_tabpg_receiverlines from u_tabpg_dw
end type
type cb_receive from commandbutton within u_tabpg_receiverlines
end type
type cb_delete from commandbutton within u_tabpg_receiverlines
end type
end forward

global type u_tabpg_receiverlines from u_tabpg_dw
integer width = 2263
string text = "Lines Overview"
cb_receive cb_receive
cb_delete cb_delete
end type
global u_tabpg_receiverlines u_tabpg_receiverlines

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

on u_tabpg_receiverlines.create
int iCurrent
call super::create
this.cb_receive=create cb_receive
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_receive
this.Control[iCurrent+2]=this.cb_delete
end on

on u_tabpg_receiverlines.destroy
call super::destroy
destroy(this.cb_receive)
destroy(this.cb_delete)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_receive.X + (cb_receive.X - gb_1.X - gb_1.Width) + cb_receive.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_receive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
masterDWO[1] = dw_1.object.receiverlineid

//	Descendents (detail)
//	Register for notification to changes in the master.
masterDWOName[1] = String(windowHandle)+".MasterDWO.receiverid"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

//	Get necessary notifications.
gnv_App.inv_StateMSGRouter.of_RequestNotification(this, "CreateLines")

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
	case "CreateLines"
		long result
		if	ReceivingDock.createReceiverLines(eventmessage.of_GetItem("CreateLines"), result) = SUCCESS then
			RefreshNotify()
		else
			msgBox("Create lines for " + String(eventmessage.of_GetItem("CreateLines")) + " failed!")
		end if
end choose

end event

event destructor;call super::destructor;
destroy ReceivingDock

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receiverlines
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receiverlines
string tag = "receivingdock"
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
return retrieve(ReceiverID)


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

type cb_receive from commandbutton within u_tabpg_receiverlines
boolean visible = false
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Receive lines..."
end type

type cb_delete from commandbutton within u_tabpg_receiverlines
integer x = 1806
integer y = 140
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete lines..."
end type

event clicked;
if	MsgBox("All selected rows will be deleted or remaining boxes will be set to zero for lines that have been received against.", Question!, OkCancel!, 2) = 2 then
	return
end if

long row; row = 0

dw_1.AcceptText()
do while dw_1.GetSelectedRow(0) > 0
	row = dw_1.GetSelectedRow(0)
	
	//Refactor to bll_receiver
	long result
	if	ReceivingDock.deleteReceiverLine(dw_1.object.receiverlineid[row], result) = SUCCESS then
		dw_1.DeleteRow(row)
	else
		msgBox("Deletion of line " + String(dw_1.object.receiverlineid[row]) + " failed!")
		exit
	end if
loop

RefreshNotify()

end event


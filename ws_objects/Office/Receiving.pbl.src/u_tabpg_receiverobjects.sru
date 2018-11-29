$PBExportHeader$u_tabpg_receiverobjects.sru
forward
global type u_tabpg_receiverobjects from u_tabpg_dwchild
end type
type cb_receive from commandbutton within u_tabpg_receiverobjects
end type
type cb_undoreceive from commandbutton within u_tabpg_receiverobjects
end type
type cb_relabel from commandbutton within u_tabpg_receiverobjects
end type
end forward

global type u_tabpg_receiverobjects from u_tabpg_dwchild
integer width = 2725
string text = "Line Objects"
cb_receive cb_receive
cb_undoreceive cb_undoreceive
cb_relabel cb_relabel
end type
global u_tabpg_receiverobjects u_tabpg_receiverobjects

type variables

long ReceiverLineID
n_cst_receivingdock ReceivingDock

end variables

forward prototypes
public function integer save ()
public function integer new ()
end prototypes

public function integer save ();integer updateReturn
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

on u_tabpg_receiverobjects.create
int iCurrent
call super::create
this.cb_receive=create cb_receive
this.cb_undoreceive=create cb_undoreceive
this.cb_relabel=create cb_relabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_receive
this.Control[iCurrent+2]=this.cb_undoreceive
this.Control[iCurrent+3]=this.cb_relabel
end on

on u_tabpg_receiverobjects.destroy
call super::destroy
destroy(this.cb_receive)
destroy(this.cb_undoreceive)
destroy(this.cb_relabel)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_receive.X + (cb_receive.X - gb_1.X - gb_1.Width) + cb_receive.Width, gb_parent.Y + gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_receive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_undoreceive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

//	Descendents (detail)
//	Register for notification to changes in the master.
masterDWOName[1] = String(windowHandle)+".MasterDWO.receiverlineid"
gnv_App.inv_StateMSGRouter.Register(String(windowHandle)+".MasterDWO", masterDWOName, this, false)

ReceivingDock = create n_cst_receivingdock

end event

event pfd_event;call super::pfd_event;
//	Descendents (detail)
//	Handle notification to changes in the master.
choose case EventName
	case String(windowHandle)+".MasterDWO"
		Refreshing = (ReceiverLineID = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.receiverlineid"), -1))
		ReceiverLineID = isnull(eventmessage.of_GetItem(String(windowHandle)+".MasterDWO.receiverlineid"), -1)
		Refresh()
end choose

end event

event destructor;call super::destructor;
destroy ReceivingDock

end event

type gb_1 from u_tabpg_dwchild`gb_1 within u_tabpg_receiverobjects
integer x = 0
integer width = 2007
end type

type dw_1 from u_tabpg_dwchild`dw_1 within u_tabpg_receiverobjects
integer width = 1993
string dataobject = "d_receiverlineobjects"
end type

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)
of_SetTransObject(SQLCA)

datawindowchild statusDWC
if	GetChild("Status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve("ReceiverObjects") = 0 then
		statusDWC.InsertRow(0)
	end if
end if

datawindowchild packageTypeDWC
if	GetChild("PackageType", packageTypeDWC) = 1 then
	packageTypeDWC.SetTransObject(SQLCA)
	if	packageTypeDWC.Retrieve("") = 0 then
		packageTypeDWC.InsertRow(0)
	end if
end if

datawindowchild locationDWC
if	GetChild("Location", locationDWC) = 1 then
	locationDWC.SetTransObject(SQLCA)
	if	locationDWC.Retrieve("") = 0 then
		locationDWC.InsertRow(0)
	end if
end if

datawindowchild plantDWC
if	GetChild("Plant", plantDWC) = 1 then
	plantDWC.SetTransObject(SQLCA)
	if	plantDWC.Retrieve("") = 0 then
		plantDWC.InsertRow(0)
	end if
end if

of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetDropDownNotes(true)
iuo_Notes.of_Register("note", iuo_Notes.DDLB)

of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

end event

event dw_1::itemchanged;call super::itemchanged;
long	selectedRow = 0
choose case lower(dwo.name)
	case "lot"
		string lots[]; lots = dw_1.object.Lot.Selected;
		
		if UpperBound(lots) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.lot[selectedRow] = data
			loop
		end if
	case "packagetype"
		string packageTypes[]; packageTypes = dw_1.object.PackageType.Selected;
		
		if UpperBound(packageTypes) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.PackageType[selectedRow] = data
			loop
		end if
	case "location"
		string locations[]; locations = dw_1.object.Location.Selected;
		
		if UpperBound(locations) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.Location[selectedRow] = data
			loop
		end if
	case "plant"
		string plants[]; plants = dw_1.object.Plant.Selected;
		
		if UpperBound(plants) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.Plant[selectedRow] = data
			loop
		end if
	case "note"
		string notes[]; notes = dw_1.object.Note.Selected;
		
		if UpperBound(notes) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.Note[selectedRow] = data
			loop
		end if
end choose

///refactor to bll
Update(true)
commit  ;

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
string currentPart
if	currentrow > 0 then
	currentPart = object.PartCode[currentrow]
end if

datawindowchild packageTypeDWC
if	GetChild("PackageType", packageTypeDWC) = 1 then
	packageTypeDWC.SetTransObject(SQLCA)
	if	packageTypeDWC.Retrieve(currentPart) = 0 then
		packageTypeDWC.InsertRow(0)
	end if
end if

end event

event dw_1::retrieveend;call super::retrieveend;
string currentPart
if	rowcount > 0 then
	SelectRow(GetRow(), true)
	currentPart = object.PartCode[GetRow()]
end if

datawindowchild packageTypeDWC
if	GetChild("PackageType", packageTypeDWC) = 1 then
	packageTypeDWC.SetTransObject(SQLCA)
	if	packageTypeDWC.Retrieve(currentPart) = 0 then
		packageTypeDWC.InsertRow(0)
	end if
end if

end event

event dw_1::clicked;call super::clicked;
choose case lower(dwo.name)
	case "noteicon"
		SetColumn("note")
		event pfc_ddnotes()
end choose

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(ReceiverLineID)

end event

type dw_parent from u_tabpg_dwchild`dw_parent within u_tabpg_receiverobjects
string tag = "receivingdock"
integer width = 1993
boolean enabled = true
string dataobject = "d_receiverlines"
end type

event dw_parent::itemchanged;call super::itemchanged;
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

event dw_parent::constructor;call super::constructor;
of_SetUpdateable(false)
of_SetTransObject(SQLCA)

of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetRowSelect(true)

end event

event dw_parent::rowfocuschanged;call super::rowfocuschanged;
string currentPart
if	currentrow > 0 then
	currentPart = object.PartCode[currentrow]
end if

datawindowchild packageTypeDWC
if	GetChild("PackageType", packageTypeDWC) = 1 then
	packageTypeDWC.SetTransObject(SQLCA)
	if	packageTypeDWC.Retrieve(currentPart) = 0 then
		packageTypeDWC.InsertRow(0)
	end if
end if

end event

type gb_parent from u_tabpg_dwchild`gb_parent within u_tabpg_receiverobjects
integer width = 2007
end type

type cb_receive from commandbutton within u_tabpg_receiverobjects
integer x = 2066
integer y = 12
integer width = 416
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Receive Boxes"
end type

event clicked;
long procResult
long selectedRow = 0
long boxSerialNumber
string boxLabelFormat
dw_1.AcceptText()
do while dw_1.GetSelectedRow(selectedRow) > 0
	selectedRow = dw_1.GetSelectedRow(selectedRow)
	if	ReceivingDock.receiveObject_againstReceiverObject(dw_1.object.receiverobjectid[selectedRow], procResult, true) = SUCCESS then
		//	Print label.
		if	ReceivingDock.getBoxLabelParms_forReceiverObject(dw_1.object.receiverobjectid[selectedRow], boxSerialNumber, boxLabelFormat) = SUCCESS then
			if boxLabelFormat > "" then
				n_cst_associative_array	printerParm
				printerParm.of_SetItem ( "Arg1", boxSerialNumber)
				printerParm.of_SetItem ( "Report", "Label" )
				printerParm.of_SetItem ( "Name", boxLabelFormat )
				Print(printerParm)
			end if
		end if
	end if
loop

RefreshNotify()

end event

type cb_undoreceive from commandbutton within u_tabpg_receiverobjects
integer x = 2066
integer y = 144
integer width = 416
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Undo Receive"
end type

event clicked;
long procResult
long selectedRow = 0
n_cst_associative_array	printerParm
long boxSerialNumber
string boxLabelFormat
do while dw_1.GetSelectedRow(selectedRow) > 0
	selectedRow = dw_1.GetSelectedRow(selectedRow)
	ReceivingDock.undoReceiveObject_againstReceiverObject(dw_1.object.receiverobjectid[selectedRow], procResult, true)
loop

RefreshNotify()

end event

type cb_relabel from commandbutton within u_tabpg_receiverobjects
integer x = 2066
integer y = 276
integer width = 416
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Relabel"
end type

event clicked;
long procResult
long selectedRow = 0
n_cst_associative_array	printerParm
long boxSerialNumber
string boxLabelFormat
dw_1.AcceptText()
do while dw_1.GetSelectedRow(selectedRow) > 0
	selectedRow = dw_1.GetSelectedRow(selectedRow)
	if	ReceivingDock.getBoxLabelParms_forReceiverObject(dw_1.object.receiverobjectid[selectedRow], boxSerialNumber, boxLabelFormat) = SUCCESS then
		if boxLabelFormat > "" then
			printerParm.of_SetItem ( "Arg1", boxSerialNumber)
			printerParm.of_SetItem ( "Report", "Label" )
			printerParm.of_SetItem ( "Name", boxLabelFormat )
			Print(printerParm)
		end if
	end if
loop

RefreshNotify()

end event


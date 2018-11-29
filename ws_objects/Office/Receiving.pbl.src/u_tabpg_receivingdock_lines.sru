$PBExportHeader$u_tabpg_receivingdock_lines.sru
forward
global type u_tabpg_receivingdock_lines from u_tabpg_dw
end type
type cb_receive from commandbutton within u_tabpg_receivingdock_lines
end type
type cb_delete from commandbutton within u_tabpg_receivingdock_lines
end type
end forward

global type u_tabpg_receivingdock_lines from u_tabpg_dw
integer width = 2263
string text = "Lines Overview"
cb_receive cb_receive
cb_delete cb_delete
end type
global u_tabpg_receivingdock_lines u_tabpg_receivingdock_lines

type prototypes


end prototypes

type variables

private string _receiverNumber
private n_cst_receivingdock_controller _myController

end variables

forward prototypes
public function integer save ()
public function integer new ()
public function integer setreceivernumber (string receivernumber)
public function integer reset ()
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

public function integer setreceivernumber (string receivernumber);
Refreshing = (_receiverNumber = receiverNumber)
_receiverNumber = receiverNumber
return Refresh()

end function

public function integer reset ();
SetNull(_receiverNumber)
return dw_1.Reset()

end function

on u_tabpg_receivingdock_lines.create
int iCurrent
call super::create
this.cb_receive=create cb_receive
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_receive
this.Control[iCurrent+2]=this.cb_delete
end on

on u_tabpg_receivingdock_lines.destroy
call super::destroy
destroy(this.cb_receive)
destroy(this.cb_delete)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_receive.X + (cb_receive.X - gb_1.X - gb_1.Width) + cb_receive.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_receive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_delete, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receivingdock_lines
string text = "Receiver Lines"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receivingdock_lines
string tag = "receivingdock"
string dataobject = "d_receiverlinelist"
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
n_cst_receivingdocktrans receivingDockTrans

choose case lower(dwo.Name)
	case "packagetype"
		confirmation = MsgBox("Change package type on all unreceived boxes?", Question!, YesNo!, 2)
		if	confirmation = 1 then
			receivingDockTrans = create n_cst_receivingdocktrans
			if	receivingDockTrans.changePackageType_ofReceiverLine(object.ReceiverLineID[row], data, changeResult) = SUCCESS then
				destroy receivingDockTrans
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
			receivingDockTrans = create n_cst_receivingdocktrans
			if	receivingDockTrans.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				destroy receivingDockTrans
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
			receivingDockTrans = create n_cst_receivingdocktrans
			if	receivingDockTrans.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				destroy receivingDockTrans
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
			receivingDockTrans = create n_cst_receivingdocktrans
			if	receivingDockTrans.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				destroy receivingDockTrans
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
			receivingDockTrans = create n_cst_receivingdocktrans
			if	receivingDockTrans.setRemainingQty_ofReceiverLines(object.ReceiverLineID[row], stdPackQty, remainingQty, changeResult) = SUCCESS then
				destroy receivingDockTrans
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
return retrieve(_receiverNumber)

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

type cb_receive from commandbutton within u_tabpg_receivingdock_lines
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

event clicked;
if	not IsValid(_myController) then return

//	Get all selected receiver lines.
string receiverLineList = ""
long row, rows
long selectedArray []
long receiverLineArray []

selectedArray = dw_1.Object.IsSelected.Primary
receiverLineArray = dw_1.Object.ReceiverLineID.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	Len(receiverLineList + String(receiverLineArray[row])) > 8000 then
			MessageBox(gnv_App.iapp_Object.DisplayName, "There are too many receiver lines selected to receive all at once.  Select receiver lines to be received and try again.")
			return FAILURE
		end if
		receiverLineList += String(receiverLineArray[row]) + ","
	end if
next

return _myController.ShowReceiverObjects(receiverLineList)

end event

type cb_delete from commandbutton within u_tabpg_receivingdock_lines
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
if	not IsValid(_myController) then return

if	MsgBox("All selected rows will be deleted or remaining boxes will be set to zero for lines that have been received against.", Question!, OkCancel!, 2) = 2 then
	return
end if

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	_myController.DeleteReceiverLine(dw_1.object.receiverlineid[row]) <> SUCCESS then
			msgBox("Deletion of line " + String(dw_1.object.receiverlineid[row]) + " failed!")
			exit
		end if
	end if
next

_myController.Refresh()

end event


HA$PBExportHeader$u_tabpg_receivingdock_objects.sru
forward
global type u_tabpg_receivingdock_objects from u_tabpg_dw
end type
type cb_receive from commandbutton within u_tabpg_receivingdock_objects
end type
type cb_undoreceive from commandbutton within u_tabpg_receivingdock_objects
end type
type cb_relabel from commandbutton within u_tabpg_receivingdock_objects
end type
type cb_cancel from commandbutton within u_tabpg_receivingdock_objects
end type
type cb_scan from commandbutton within u_tabpg_receivingdock_objects
end type
end forward

global type u_tabpg_receivingdock_objects from u_tabpg_dw
integer width = 2720
cb_receive cb_receive
cb_undoreceive cb_undoreceive
cb_relabel cb_relabel
cb_cancel cb_cancel
cb_scan cb_scan
end type
global u_tabpg_receivingdock_objects u_tabpg_receivingdock_objects

type variables

private string _receiverNumber, _receiverLineList
private n_cst_receivingdock ReceivingDock
private n_cst_receivingdock_controller _myController

end variables

forward prototypes
public function integer setreceiverlinelist (string receivernumber, string receiverlinelist)
end prototypes

public function integer setreceiverlinelist (string receivernumber, string receiverlinelist);
_receiverNumber = receiverNumber
_receiverLineList = receiverLineList
return dw_1.event pfc_retrieve()

end function

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_receive.X + (cb_receive.X - gb_1.X - gb_1.Width) + cb_receive.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_receive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_undoreceive, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)
inv_Resize.of_Register(cb_scan, 100, 0, 0, 0)
inv_Resize.of_Register(cb_cancel, 100, 100, 0, 0)

ReceivingDock = create n_cst_receivingdock

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

on u_tabpg_receivingdock_objects.create
int iCurrent
call super::create
this.cb_receive=create cb_receive
this.cb_undoreceive=create cb_undoreceive
this.cb_relabel=create cb_relabel
this.cb_cancel=create cb_cancel
this.cb_scan=create cb_scan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_receive
this.Control[iCurrent+2]=this.cb_undoreceive
this.Control[iCurrent+3]=this.cb_relabel
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_scan
end on

on u_tabpg_receivingdock_objects.destroy
call super::destroy
destroy(this.cb_receive)
destroy(this.cb_undoreceive)
destroy(this.cb_relabel)
destroy(this.cb_cancel)
destroy(this.cb_scan)
end on

event destructor;call super::destructor;
destroy ReceivingDock

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receivingdock_objects
string text = "Receiver Objects"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receivingdock_objects
string dataobject = "d_receiverobjectlist"
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

event dw_1::clicked;call super::clicked;
choose case lower(dwo.name)
	case "noteicon"
		SetColumn("note")
		event pfc_ddnotes()
end choose

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then
	return
end if

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

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_receiverNumber, _receiverLineList)

end event

type cb_receive from commandbutton within u_tabpg_receivingdock_objects
integer x = 1810
integer y = 12
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
string text = "Receive Boxes"
end type

event clicked;
if	not IsValid(_myController) then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		_myController.ReceiveReceiverObject(dw_1.object.receiverobjectid[row])
	end if
next

_myController.Refresh()

end event

type cb_undoreceive from commandbutton within u_tabpg_receivingdock_objects
integer x = 1810
integer y = 144
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
string text = "Undo Receive"
end type

event clicked;
if	not IsValid(_myController) then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		_myController.UndoReceiveReceiverObject(dw_1.Object.ReceiverObjectID[row])
	end if
next

_myController.Refresh()

end event

type cb_relabel from commandbutton within u_tabpg_receivingdock_objects
integer x = 1810
integer y = 276
integer width = 416
integer height = 112
integer taborder = 60
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
if	not IsValid(_myController) then return

//	Get all selected receiver lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		_myController.LabelBox(dw_1.Object.Serial[row])
	end if
next

_myController.Refresh()

end event

type cb_cancel from commandbutton within u_tabpg_receivingdock_objects
integer x = 1810
integer y = 972
integer width = 416
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;
if	not IsValid(_myController) then return

_myController.DoneShowReceiverObjects()

end event

type cb_scan from commandbutton within u_tabpg_receivingdock_objects
integer x = 1810
integer y = 408
integer width = 416
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Scan"
end type

event clicked;
if	not IsValid(_myController) then return

choose case Text
	case "Scan"
		_myController.StartReceiptScanning()
	case "Stop Scan"
		_myController.StopReceiptScanning()
end choose


end event


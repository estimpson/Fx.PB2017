$PBExportHeader$u_tabpg_receivingdock_headers.sru
forward
global type u_tabpg_receivingdock_headers from u_tabpg_dw
end type
type cb_createlines from commandbutton within u_tabpg_receivingdock_headers
end type
type cb_putaway from commandbutton within u_tabpg_receivingdock_headers
end type
type cb_new from commandbutton within u_tabpg_receivingdock_headers
end type
type p_showinstructions from picture within u_tabpg_receivingdock_headers
end type
end forward

global type u_tabpg_receivingdock_headers from u_tabpg_dw
integer width = 2263
string text = "Receivers Overview"
cb_createlines cb_createlines
cb_putaway cb_putaway
cb_new cb_new
p_showinstructions p_showinstructions
end type
global u_tabpg_receivingdock_headers u_tabpg_receivingdock_headers

type variables

n_cst_receivingdock ReceivingDock
private n_cst_receivingdock_controller _myController

end variables

forward prototypes
public function integer save ()
public function integer new ()
public function integer newreceiver ()
end prototypes

public function integer save ();integer updateReturn
dw_1.AcceptText()
updateReturn = dw_1.Update(true)
if	updateReturn = 1 then
	commit;
else
	msgBox("Save Failed!")
end if
return	updateReturn

end function

public function integer new ();
return dw_1.ScrollToRow(dw_1.InsertRow(0))

end function

public function integer newreceiver ();
return dw_1.ScrollToRow(dw_1.event pfc_addrow())

end function

on u_tabpg_receivingdock_headers.create
int iCurrent
call super::create
this.cb_createlines=create cb_createlines
this.cb_putaway=create cb_putaway
this.cb_new=create cb_new
this.p_showinstructions=create p_showinstructions
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_createlines
this.Control[iCurrent+2]=this.cb_putaway
this.Control[iCurrent+3]=this.cb_new
this.Control[iCurrent+4]=this.p_showinstructions
end on

on u_tabpg_receivingdock_headers.destroy
call super::destroy
destroy(this.cb_createlines)
destroy(this.cb_putaway)
destroy(this.cb_new)
destroy(this.p_showinstructions)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_createlines.X + (cb_createlines.X - gb_1.X - gb_1.Width) + cb_new.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_new, 100, 0, 0, 0)
inv_Resize.of_Register(cb_createlines, 100, 0, 0, 0)
inv_Resize.of_Register(cb_putaway, 100, 0, 0, 0)
inv_Resize.of_Register(p_showinstructions, 100, 100, 0, 0)

ReceivingDock = create n_cst_receivingdock

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

event pfc_new;call super::pfc_new;
New()

end event

event destructor;call super::destructor;
destroy ReceivingDock

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receivingdock_headers
string text = "Open Receivers"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receivingdock_headers
integer y = 136
integer height = 940
string dataobject = "d_openreceiverheaderlist"
end type

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)

of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.SINGLE)

of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()

of_SetTransObject(SQLCA)

datawindowchild statusDWC
if	GetChild("Status", statusDWC) = 1 then
	statusDWC.SetTransObject(SQLCA)
	if	statusDWC.Retrieve("ReceiverHeaders") = 0 then
		statusDWC.InsertRow(0)
	end if
end if

datawindowchild typeDWC
if	GetChild("Type", typeDWC) = 1 then
	typeDWC.SetTransObject(SQLCA)
	if	typeDWC.Retrieve("ReceiverHeaders") = 0 then
		typeDWC.InsertRow(0)
	end if
end if

datawindowchild shipFromDWC
if	GetChild("ShipFrom", shipFromDWC) = 1 then
	shipFromDWC.SetTransObject(SQLCA)
	if	shipFromDWC.Retrieve(0) = 0 then
		shipFromDWC.InsertRow(0)
	end if
end if

of_SetDropDownNotes(true)
iuo_Notes.of_Register("note", iuo_Notes.DDLB)

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;
if	row > 0 then
	if	lower(dwo.name) = "shipfrom" then
		datawindowchild shipFromDWC
		if	GetChild("ShipFrom", shipFromDWC) = 1 then
			shipFromDWC.SetTransObject(SQLCA)
			if	shipFromDWC.Retrieve(object.type[row]) = 0 then
				shipFromDWC.InsertRow(0)
			end if
		end if
	end if
end if
end event

event dw_1::updateend;call super::updateend;
RefreshNotify()
end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//	Retrieve new and received receiver headers.  Do not retrieve put away or cancelled receivers.
int OpenStatuses []
OpenStatuses [1] = ReceivingDock.RECEIVER_NEW
OpenStatuses [2] = ReceivingDock.RECEIVER_CONFIRMED
OpenStatuses [3] = ReceivingDock.RECEIVER_SHIPPED
OpenStatuses [4] = ReceivingDock.RECEIVER_ARRIVED
OpenStatuses [5] = ReceivingDock.RECEIVER_RECEIVED
if	Retrieve(OpenStatuses) = 0 then
	InsertRow(0)
end if
return 0

end event

event dw_1::clicked;call super::clicked;
choose case lower(dwo.name)
	case "noteicon"
		SetColumn("note")
		event pfc_ddnotes()
end choose

end event

event dw_1::itemchanged;call super::itemchanged;
long	selectedRow = 0
choose case lower(dwo.name)
	case "note"
		string notes[]; notes = dw_1.object.Note.Selected;
		
		if UpperBound(notes) >= 2 then
			do while dw_1.GetSelectedRow(selectedRow) > 0
				selectedRow = dw_1.GetSelectedRow(selectedRow)
				dw_1.object.Note[selectedRow] = data
			loop
		end if
end choose

//	Ignore new rows.
DWItemStatus rowStatus
rowStatus = GetItemStatus(row, 0, primary!)
if	rowStatus = NewModified! or rowStatus = New! then return

///refactor to bll
Update(true)
commit  ;

end event

event dw_1::resize;call super::resize;
PowerFilter.event ue_positionbuttons()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) then return

//	If no valid row, hide receiver.
if	activerow <= 0 then
	_myController.HideReceiver()
	return
end if
_myController.ShowReceiver(object.ReceiverNumber[activerow])

end event

type cb_createlines from commandbutton within u_tabpg_receivingdock_headers
integer x = 1806
integer y = 260
integer width = 407
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Create Lines"
end type

event clicked;
if	not IsValid(_myController) then return

//	Check if this is a new currentRow.
boolean	promptCreateLines = false
datetime arrivalDT
integer currentRow
currentRow = dw_1.GetRow()
if	currentRow <= 0 then return

if	dw_1.AcceptText() <> SUCCESS then return
if	dw_1.Update() = SUCCESS then
	commit  ;
else
	return
end if

arrivalDT = dw_1.object.ExpectedReceiveDT.primary[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if
arrivalDT = dw_1.object.ConfirmedArrivalDT.primary[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if
arrivalDT = dw_1.object.ActualArrivalDT.primary[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if
arrivalDT = dw_1.object.ReceiveDT.primary[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if

MsgBox("Specify expected or actual arrival date priort to creating lines.")
dw_1.SetColumn("ExpectedReceiveDT")
return

Prompt:
if	MsgBox("Any changes to this and/or other receiver headers will be saved.  Any existing lines on this receiver will be deleted.  New releases due on or before " + String (arrivalDT) + " will be added.", question!, okcancel!, 2) = 1 then
	Save()
	if	_myController.CreateReceiverLines(dw_1.object.ReceiverID[currentRow]) <> SUCCESS then
		MsgBox("Create lines for " + String(dw_1.object.ReceiverID[currentRow]) + " failed!")
	end if
end if

_myController.Refresh()

end event

type cb_putaway from commandbutton within u_tabpg_receivingdock_headers
integer x = 1806
integer y = 136
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
string text = "Put Away..."
end type

event clicked;
if	not IsValid(_myController) then return

//	Get all selected receivers.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	_myController.PutAwayReceiver(dw_1.object.receiverid[row]) <> SUCCESS then
			msgBox("Put away of reciever " + String(dw_1.object.receivernumber[row]) + " failed!")
			exit
		end if
	end if
next

_myController.Refresh()

end event

type cb_new from commandbutton within u_tabpg_receivingdock_headers
integer x = 1806
integer y = 12
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
string text = "New Receiver"
end type

event clicked;
NewReceiver()

end event

type p_showinstructions from picture within u_tabpg_receivingdock_headers
integer x = 2066
integer y = 956
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "note-yes-green-32.bmp"
boolean focusrectangle = false
string powertiptext = "View Instructions"
end type

event clicked;
//	Get the controller for this control's window.
if	not IsValid(_myController) then return
_myController.ToggleShowInstructions()

end event

event constructor;
Visible = false

end event


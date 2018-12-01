$PBExportHeader$u_tabpg_receiverheaders.sru
forward
global type u_tabpg_receiverheaders from u_tabpg_dw
end type
type cb_createlines from commandbutton within u_tabpg_receiverheaders
end type
type cb_putaway from commandbutton within u_tabpg_receiverheaders
end type
end forward

global type u_tabpg_receiverheaders from u_tabpg_dw
integer width = 2263
string text = "Receivers Overview"
cb_createlines cb_createlines
cb_putaway cb_putaway
end type
global u_tabpg_receiverheaders u_tabpg_receiverheaders

type variables

long _receiverID
n_cst_receivingdock ReceivingDock

end variables
forward prototypes
public function integer save ()
public function integer new ()
end prototypes

public function integer save ();integer updateReturn
dw_1.AcceptText()
updateReturn = dw_1.Update(true)
if	updateReturn = 1 then
	commit;
	Refresh()
else
	msgBox("Save Failed!")
end if
return	updateReturn

end function

public function integer new ();
return dw_1.ScrollToRow(dw_1.InsertRow(0))

end function

on u_tabpg_receiverheaders.create
int iCurrent
call super::create
this.cb_createlines=create cb_createlines
this.cb_putaway=create cb_putaway
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_createlines
this.Control[iCurrent+2]=this.cb_putaway
end on

on u_tabpg_receiverheaders.destroy
call super::destroy
destroy(this.cb_createlines)
destroy(this.cb_putaway)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_createlines.X + (cb_createlines.X - gb_1.X - gb_1.Width) + cb_createlines.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_createlines, 100, 0, 0, 0)
inv_Resize.of_Register(cb_putaway, 100, 0, 0, 0)

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
masterDWO[1] = dw_1.object.receiverid

ReceivingDock = create n_cst_receivingdock

end event

event pfc_new;call super::pfc_new;
New()

end event

event destructor;call super::destructor;
destroy ReceivingDock

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receiverheaders
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receiverheaders
integer y = 88
integer height = 988
string dataobject = "d_receiverheaders"
end type

event dw_1::constructor;call super::constructor;
of_SetUpdateable(false)

of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

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

dw_1.event pfc_retrieve()

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

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//	Retrieve new and received receiver headers.  Do not retrieve put away or cancelled receivers.
string _openStatuses 
_openStatuses = String (ReceivingDock.RECEIVER_NEW) + "," +&
	String (ReceivingDock.RECEIVER_CONFIRMED) + "," +&
	String (ReceivingDock.RECEIVER_SHIPPED) + "," +&
	String (ReceivingDock.RECEIVER_ARRIVED) + "," +&
	String (ReceivingDock.RECEIVER_RECEIVED) + ","
	
if	Retrieve(_openStatuses) = 0 then
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

end event

event dw_1::resize;call super::resize;
PowerFilter.event ue_positionbuttons()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activeRow <= 0 or activeRow > RowCount() then
	return
end if

_receiverID = Object.ReceiverID[activeRow]

end event

type cb_createlines from commandbutton within u_tabpg_receiverheaders
integer x = 1806
integer y = 8
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
string text = "Create lines"
end type

event clicked;
//	Start accepting changed values.
dw_1.AcceptText()

//	Check if this is a new currentRow.
boolean	promptCreateLines = false
datetime arrivalDT
integer currentRow
currentRow = dw_1.GetRow()
if	currentRow <= 0 then return

arrivalDT = dw_1.object.ReceiveDT[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if
arrivalDT = dw_1.object.ActualArrivalDT[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if
arrivalDT = dw_1.object.ConfirmedArrivalDT[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if
arrivalDT = dw_1.object.ExpectedReceiveDT[currentRow]
if	not IsNull(arrivalDT) then
	promptCreateLines = true
	goto Prompt
end if

msgBox("Specify expected or actual arrival date priort to creating lines.")
dw_1.SetColumn("ActualArrivalDT")
return

Prompt:
if	MessageBox(gnv_App.iapp_Object.DisplayName, "Any changes to this and/or other receiver headers will be saved.  Any existing lines on this receiver will be deleted.  New releases due on or before " + String (arrivalDT) + " will be added.", question!, okcancel!, 2) = 1 then
	long receiverID
	receiverID = dw_1.object.ReceiverID[currentRow] // Try reading before save in case current row changes after save.
	Save()
	n_cst_associative_array eventParm
	eventParm.of_SetItem("CreateLines", IsNull(receiverID, Long(dw_1.object.ReceiverID[currentRow])))
	gnv_App.inv_StateMSGRouter.post of_Broadcast(eventParm)
end if

end event

type cb_putaway from commandbutton within u_tabpg_receiverheaders
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
long procResult
long selectedRow = 0
n_cst_associative_array	printerParm
long boxSerialNumber
string boxLabelFormat
do while dw_1.GetSelectedRow(selectedRow) > 0
	selectedRow = dw_1.GetSelectedRow(selectedRow)
	ReceivingDock.putAwayReceiver(dw_1.object.receiverid[selectedRow], procResult)
loop

RefreshNotify()

end event


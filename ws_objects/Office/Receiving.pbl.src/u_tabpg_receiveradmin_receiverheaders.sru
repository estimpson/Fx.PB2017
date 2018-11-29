$PBExportHeader$u_tabpg_receiveradmin_receiverheaders.sru
forward
global type u_tabpg_receiveradmin_receiverheaders from u_tabpg_dw
end type
type cb_archive from commandbutton within u_tabpg_receiveradmin_receiverheaders
end type
end forward

global type u_tabpg_receiveradmin_receiverheaders from u_tabpg_dw
integer width = 2263
string text = "Receivers Overview"
cb_archive cb_archive
end type
global u_tabpg_receiveradmin_receiverheaders u_tabpg_receiveradmin_receiverheaders

type variables

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
return dw_1.ScrollToRow(dw_1.InsertRow(0))

end function

on u_tabpg_receiveradmin_receiverheaders.create
int iCurrent
call super::create
this.cb_archive=create cb_archive
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_archive
end on

on u_tabpg_receiveradmin_receiverheaders.destroy
call super::destroy
destroy(this.cb_archive)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_archive.X + (cb_archive.X - gb_1.X - gb_1.Width) + cb_archive.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_archive, 100, 0, 0, 0)

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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_receiveradmin_receiverheaders
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_receiveradmin_receiverheaders
string dataobject = "d_receiverheaders_admin"
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
OpenStatuses [6] = ReceivingDock.RECEIVER_PUTAWAY
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

///refactor to bll
Update(true)
commit  ;

end event

type cb_archive from commandbutton within u_tabpg_receiveradmin_receiverheaders
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
string text = "Archive..."
end type

event clicked;
long procResult
long selectedRow = 0
n_cst_associative_array	printerParm
long boxSerialNumber
string boxLabelFormat
do while dw_1.GetSelectedRow(selectedRow) > 0
	selectedRow = dw_1.GetSelectedRow(selectedRow)
	ReceivingDock.archiveReceiver(dw_1.object.receiverid[selectedRow], procResult)
loop

RefreshNotify()

end event


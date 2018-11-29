$PBExportHeader$u_tabpg_receiveradmin_receiverobjects.sru
forward
global type u_tabpg_receiveradmin_receiverobjects from u_tabpg_dwchild
end type
end forward

global type u_tabpg_receiveradmin_receiverobjects from u_tabpg_dwchild
integer width = 2725
string text = "Line Objects"
end type
global u_tabpg_receiveradmin_receiverobjects u_tabpg_receiveradmin_receiverobjects

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

on u_tabpg_receiveradmin_receiverobjects.create
call super::create
end on

on u_tabpg_receiveradmin_receiverobjects.destroy
call super::destroy
end on

event constructor;call super::constructor;
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

type gb_1 from u_tabpg_dwchild`gb_1 within u_tabpg_receiveradmin_receiverobjects
integer width = 2007
end type

type dw_1 from u_tabpg_dwchild`dw_1 within u_tabpg_receiveradmin_receiverobjects
integer width = 1998
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

type dw_parent from u_tabpg_dwchild`dw_parent within u_tabpg_receiveradmin_receiverobjects
string tag = "receiveradmin"
integer width = 1998
string dataobject = "d_receiverlines"
end type

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

type gb_parent from u_tabpg_dwchild`gb_parent within u_tabpg_receiveradmin_receiverobjects
integer width = 2007
end type


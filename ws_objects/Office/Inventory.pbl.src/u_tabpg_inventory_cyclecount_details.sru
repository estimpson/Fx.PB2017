$PBExportHeader$u_tabpg_inventory_cyclecount_details.sru
forward
global type u_tabpg_inventory_cyclecount_details from u_tabpg_dw
end type
type cb_markfound from commandbutton within u_tabpg_inventory_cyclecount_details
end type
type cb_marklost from commandbutton within u_tabpg_inventory_cyclecount_details
end type
type cb_recover from commandbutton within u_tabpg_inventory_cyclecount_details
end type
type cb_relabel from commandbutton within u_tabpg_inventory_cyclecount_details
end type
type cb_markignore from commandbutton within u_tabpg_inventory_cyclecount_details
end type
type cb_unmark from commandbutton within u_tabpg_inventory_cyclecount_details
end type
type cb_update from commandbutton within u_tabpg_inventory_cyclecount_details
end type
end forward

global type u_tabpg_inventory_cyclecount_details from u_tabpg_dw
integer width = 2455
cb_markfound cb_markfound
cb_marklost cb_marklost
cb_recover cb_recover
cb_relabel cb_relabel
cb_markignore cb_markignore
cb_unmark cb_unmark
cb_update cb_update
end type
global u_tabpg_inventory_cyclecount_details u_tabpg_inventory_cyclecount_details

type variables

boolean IsReadOnly
n_cst_inventorytrans_cyclecount InventoryTrans_CycleCount

string	CycleCountNumber

end variables

forward prototypes
public function integer setmarkedrows (integer mark)
public function integer updatemarkallflag ()
public function integer markstatus (long newstatus)
public function integer updatequantitylocation ()
public function integer relabel ()
public subroutine setenabled (boolean enabledflag)
end prototypes

public function integer setmarkedrows (integer mark);
long	row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	datetime rowCommittedDT
	rowCommittedDT = dw_1.Object.RowCommittedDT[row]
	if	IsNull(rowCommittedDT) then
		dw_1.Object.Selected[row] = Mark
	end if
next

return SUCCESS

end function

public function integer updatemarkallflag ();
int marked
long row, rows
rows = dw_1.RowCount()
if	rows <= 0 then
	return NO_ACTION
end if

marked = -2
for row = 1 to rows
	datetime rowCommittedDT
	rowCommittedDT = dw_1.Object.RowCommittedDT[row]
	if	marked <> dw_1.Object.Selected[row] and IsNull(rowCommittedDT) then
		if	marked <> -2 then
			marked = -1
			exit
		end if
		marked = dw_1.Object.Selected[row]
	end if
next

for	row = 1 to rows
	dw_1.Object.MarkAll[row] = marked
next
return SUCCESS

end function

public function integer markstatus (long newstatus);
//	Build a list of serials that need to have the new status.
string serialList = ""
long row, rows
long SelectedArray []
long SerialArray []

SelectedArray = dw_1.Object.Selected.Primary
SerialArray = dw_1.Object.Serial.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		if	Len(serialList + String(SerialArray[row])) > 8000 then
			if	InventoryTrans_CycleCount.MarkListedObjects(CycleCountNumber, serialList, NewStatus) <> SUCCESS then
				rollback using SQLCA  ;
				return FAILURE
			end if
			serialList = ""
		end if
		serialList += String(SerialArray[row]) + ","
	end if
next

if	InventoryTrans_CycleCount.MarkListedObjects(CycleCountNumber, serialList, NewStatus) = success then
	commit using SQLCA  ;
	Controller.Refresh()
	return SUCCESS
end if

return FAILURE

end function

public function integer updatequantitylocation ();
long row, rows
rows = dw_1.RowCount()
dw_1.AcceptText()
for	row = 1 to rows
	decimal origQuantity, newQuantity
	origQuantity = dw_1.Object.CorrectedQuantity.Original[row]
	newQuantity = dw_1.Object.CorrectedQuantity.Current[row]
	if	IsNull(origQuantity, -1) <> IsNull(newQuantity, -1) then
		InventoryTrans_CycleCount.CorrectQuantity(CycleCountNumber, dw_1.Object.Serial[row], newQuantity)
	end if
	
	string origLocation, newLocation
	origLocation = dw_1.Object.CorrectedLocation.Original[row]
	newLocation = dw_1.Object.CorrectedLocation.Current[row]
	if	IsNull(origLocation, "") <> IsNull(newLocation, "") then
		InventoryTrans_CycleCount.CorrectLocation(CycleCountNumber, dw_1.Object.Serial[row], newLocation)
	end if
next
commit using SQLCA  ;
Controller.Refresh()
return SUCCESS

end function

public function integer relabel ();
long row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	if	dw_1.Object.Selected[row] = 1 then
		//	Check if object needs to be created first...
		if	dw_1.Object.Type[row] = 1 then
			//InventoryTrans_CycleCount.CreateObject()
		end if
		n_cst_associative_array	printerParm
		printerParm.of_SetItem ( "Arg1", dw_1.Object.Serial[row])
		printerParm.of_SetItem ( "Report", "Label" )
		printerParm.of_SetItem ( "Name", dw_1.Object.BoxLabelFormat[row])
		Print(printerParm)
		//	Check if object needs to be created first...
		if	dw_1.Object.Type[row] = 1 then
			//InventoryTrans_CycleCount.RemoveObject()
		end if
	end if
next
return SUCCESS

end function

public subroutine setenabled (boolean enabledflag);
cb_markfound.enabled = enabledFlag
cb_marklost.enabled = enabledFlag
cb_markignore.enabled = enabledFlag
cb_unmark.enabled = enabledFlag
cb_update.enabled = enabledFlag
cb_recover.enabled = enabledFlag
cb_relabel.enabled = enabledFlag

IsReadOnly = not EnabledFlag

end subroutine

on u_tabpg_inventory_cyclecount_details.create
int iCurrent
call super::create
this.cb_markfound=create cb_markfound
this.cb_marklost=create cb_marklost
this.cb_recover=create cb_recover
this.cb_relabel=create cb_relabel
this.cb_markignore=create cb_markignore
this.cb_unmark=create cb_unmark
this.cb_update=create cb_update
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_markfound
this.Control[iCurrent+2]=this.cb_marklost
this.Control[iCurrent+3]=this.cb_recover
this.Control[iCurrent+4]=this.cb_relabel
this.Control[iCurrent+5]=this.cb_markignore
this.Control[iCurrent+6]=this.cb_unmark
this.Control[iCurrent+7]=this.cb_update
end on

on u_tabpg_inventory_cyclecount_details.destroy
call super::destroy
destroy(this.cb_markfound)
destroy(this.cb_marklost)
destroy(this.cb_recover)
destroy(this.cb_relabel)
destroy(this.cb_markignore)
destroy(this.cb_unmark)
destroy(this.cb_update)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_markfound.X + (cb_markfound.X - gb_1.X - gb_1.Width) + cb_markfound.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_markfound, 100, 0, 0, 0)
inv_Resize.of_Register(cb_marklost, 100, 0, 0, 0)
inv_Resize.of_Register(cb_markignore, 100, 0, 0, 0)
inv_Resize.of_Register(cb_unmark, 100, 0, 0, 0)
inv_Resize.of_Register(cb_update, 100, 0, 0, 0)
inv_Resize.of_Register(cb_recover, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

InventoryTrans_CycleCount = create n_cst_inventorytrans_cyclecount

end event

event destructor;call super::destructor;
destroy InventoryTrans_CycleCount

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_cyclecount_details
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_cyclecount_details
string dataobject = "d_dbo_inventorycontrol_cyclecountobjects"
end type

event dw_1::constructor;call super::constructor;
//of_SetRowSelect(false)
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(CycleCountNumber)

end event

event dw_1::clicked;call super::clicked;
if	IsReadOnly then return

//if	dwo.Name = "selected" and row > 0 and row <= RowCount() then
//	SetRedraw(false)
//	if	Object.Selected[row] = 1 then
//		Object.Selected[row] = 0
//	else
//		Object.Selected[row] = 1
//	end if
//	UpdateMarkAllFlag()
//	SetRedraw(true)
//end if

if	dwo.Name = "markall" then
	SetRedraw(false)
	if	Object.MarkAll[1] = -1 or Object.MarkAll[1] = 0 then
		SetMarkedRows(1)
	else
		SetMarkedRows(0)
	end if
	UpdateMarkAllFlag()
	SetRedraw(true)
end if

end event

event dw_1::selectionchanged;call super::selectionchanged;
if	IsReadOnly then return

UpdateMarkAllFlag()

end event

event dw_1::itemchanged;call super::itemchanged;
if	IsReadOnly then
	post MessageBox(gnv_App.iapp_Object.DisplayName, "This cycle count has been closed and is now read only.")
	return 2
end if

end event

type cb_markfound from commandbutton within u_tabpg_inventory_cyclecount_details
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Mark Found"
end type

event clicked;
MarkStatus(InventoryTrans_CycleCount.OBJECTSTATUS_FOUND)

end event

type cb_marklost from commandbutton within u_tabpg_inventory_cyclecount_details
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
string text = "Mark Lost"
end type

event clicked;
MarkStatus(InventoryTrans_CycleCount.OBJECTSTATUS_LOST)

end event

type cb_recover from commandbutton within u_tabpg_inventory_cyclecount_details
integer x = 1806
integer y = 668
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Recover ..."
end type

event clicked;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_cyclecount_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.ShowRecoverSerialPopup()

end event

type cb_relabel from commandbutton within u_tabpg_inventory_cyclecount_details
integer x = 1806
integer y = 800
integer width = 407
integer height = 112
integer taborder = 70
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
Relabel()

end event

type cb_markignore from commandbutton within u_tabpg_inventory_cyclecount_details
integer x = 1806
integer y = 272
integer width = 407
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Mark Ignore"
end type

event clicked;
MarkStatus(InventoryTrans_CycleCount.OBJECTSTATUS_IGNORE)

end event

type cb_unmark from commandbutton within u_tabpg_inventory_cyclecount_details
integer x = 1806
integer y = 404
integer width = 407
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Unmark"
end type

event clicked;
MarkStatus(InventoryTrans_CycleCount.OBJECTSTATUS_UNKNOWN)

end event

type cb_update from commandbutton within u_tabpg_inventory_cyclecount_details
integer x = 1806
integer y = 536
integer width = 407
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save Qty / Loc"
end type

event clicked;
UpdateQuantityLocation()

end event


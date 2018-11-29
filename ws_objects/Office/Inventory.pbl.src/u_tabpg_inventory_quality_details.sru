$PBExportHeader$u_tabpg_inventory_quality_details.sru
forward
global type u_tabpg_inventory_quality_details from u_tabpg_dw
end type
type cb_save from commandbutton within u_tabpg_inventory_quality_details
end type
type cb_writeqc from commandbutton within u_tabpg_inventory_quality_details
end type
type cb_markapproved from commandbutton within u_tabpg_inventory_quality_details
end type
type cb_relabel from commandbutton within u_tabpg_inventory_quality_details
end type
end forward

global type u_tabpg_inventory_quality_details from u_tabpg_dw
integer width = 2455
cb_save cb_save
cb_writeqc cb_writeqc
cb_markapproved cb_markapproved
cb_relabel cb_relabel
end type
global u_tabpg_inventory_quality_details u_tabpg_inventory_quality_details

type variables

boolean IsReadOnly
n_cst_inventorytrans_quality InventoryTrans_Quality

string	QualityBatchNumber

end variables

forward prototypes
public function integer setmarkedrows (integer mark)
public function integer updatemarkallflag ()
public function integer relabel ()
public function integer updatechanges ()
public function integer setbasestatus (string newstatus)
public function integer writeobjectstatus ()
public subroutine setenabled (boolean enabledflag)
end prototypes

public function integer setmarkedrows (integer mark);
long	row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	dw_1.Object.Selected[row] = Mark
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

marked = dw_1.Object.Selected[1]
for row = 1 to rows
	if	marked <> dw_1.Object.Selected[row] then
		marked = -1
		exit
	end if
next

for	row = 1 to rows
	dw_1.Object.MarkAll[row] = marked
next
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

public function integer updatechanges ();
long row, rows
rows = dw_1.RowCount()
dw_1.AcceptText()
for	row = 1 to rows
	decimal origScrapQuantity, newScrapQuantity
	string origNewStatus, newNewStatus
	string origNotes, newNotes
	origNewStatus = dw_1.Object.NewStatus.Original[row]
	newNewStatus = dw_1.Object.NewStatus.Current[row]
	origScrapQuantity = dw_1.Object.ScrapQuantity.Original[row]
	newScrapQuantity = dw_1.Object.ScrapQuantity.Current[row]
	origNotes = dw_1.Object.Notes.Original[row]
	newNotes = dw_1.object.Notes.Current[row]
	
	if	IsNull(origNewStatus, "") <> IsNull(newNewStatus, "") &
			or IsNull(origScrapQuantity, -1) <> IsNull(newScrapQuantity, -1) &
			or IsNull(origNotes, "") <> IsNull(newNotes, "") then
		if	InventoryTrans_Quality.SetObjectState(QualityBatchNumber, dw_1.Object.Serial[row], newNewStatus, newScrapQuantity, newNotes) <> SUCCESS then
			return FAILURE
		end if
	end if
next
commit using SQLCA  ;

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_inventory_quality_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

myController.Refresh()
return SUCCESS

end function

public function integer setbasestatus (string newstatus);
long row, rows
rows = dw_1.RowCount()
string	newUserStatus
if	InventoryTrans_Quality.GetDefaultUserDefinedStatus(newStatus, newUserStatus) <> SUCCESS then
	return FAILURE
end if

for	row = 1 to rows
	if	dw_1.Object.IsSelected[row] = 1 then
		dw_1.Object.NewStatus[row] = newUserStatus
	end if
next

return SUCCESS

end function

public function integer writeobjectstatus ();
if	MessageBox(gnv_App.iapp_Object.DisplayName, "Any unsaved changes will be saved and quality transactions written to the database.", Information!, OkCancel!,  2) = 2 then
	return NO_ACTION
end if

long row, rows
rows = dw_1.RowCount()
dw_1.AcceptText()
for	row = 1 to rows
	if	InventoryTrans_Quality.WriteObjectStatus(QualityBatchNumber, dw_1.Object.Serial[row]) <> SUCCESS then
		return FAILURE
	end if
next
commit using SQLCA  ;

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_inventory_quality_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

myController.Refresh()
return SUCCESS

end function

public subroutine setenabled (boolean enabledflag);
cb_markapproved.enabled = enabledFlag
cb_save.enabled = enabledFlag
cb_writeqc.enabled = enabledFlag

IsReadOnly = not enabledFlag

end subroutine

on u_tabpg_inventory_quality_details.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.cb_writeqc=create cb_writeqc
this.cb_markapproved=create cb_markapproved
this.cb_relabel=create cb_relabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.cb_writeqc
this.Control[iCurrent+3]=this.cb_markapproved
this.Control[iCurrent+4]=this.cb_relabel
end on

on u_tabpg_inventory_quality_details.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.cb_writeqc)
destroy(this.cb_markapproved)
destroy(this.cb_relabel)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_markapproved, 100, 0, 0, 0)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(cb_writeqc, 100, 0, 0, 0)
inv_Resize.of_Register(cb_relabel, 100, 0, 0, 0)

InventoryTrans_Quality = create n_cst_inventorytrans_quality

end event

event destructor;call super::destructor;
destroy InventoryTrans_Quality

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_quality_details
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_quality_details
string dataobject = "d_dbo_inventorycontrol_qcbatchobjects"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(QualityBatchNumber)

end event

event dw_1::clicked;call super::clicked;
if	IsReadOnly then return

choose case lower(dwo.name)
	case "markall"
		SetRedraw(false)
		if	Object.MarkAll[1] = -1 or Object.MarkAll[1] = 0 then
			SetMarkedRows(1)
		else
			SetMarkedRows(0)
		end if
		UpdateMarkAllFlag()
		SetRedraw(true)
		
	case "noteicon"
		SetColumn("notes")
		event pfc_ddnotes()
end choose

end event

event dw_1::selectionchanged;call super::selectionchanged;
if	IsReadOnly then return
UpdateMarkAllFlag()

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

of_SetDropDownNotes(true)
iuo_Notes.of_Register("notes", iuo_Notes.DDLB)

end event

event dw_1::itemchanged;call super::itemchanged;
if	IsReadOnly then
	post MessageBox(gnv_App.iapp_Object.DisplayName, "This quality batch has been closed and is now read only.")
	return 2
end if

/* not working properly when clicking off modified cell to new row.
int isSelected[]
long i, rows

choose case lower(dwo.name)
	case "notes"
		isSelected = dw_1.object.IsSelected.Primary
		rows = upperBound(isSelected)
		for	i = 1 to rows
			if	isSelected[i] = 1 then
				dw_1.object.Notes[i] = data
			end if
		next
		
	case "newstatus"
		isSelected = dw_1.object.IsSelected.Primary
		rows = upperBound(isSelected)
		for	i = 1 to rows
			if	isSelected[i] = 1 then
				dw_1.object.NewStatus[i] = data
			end if
		next
end choose
*/

datawindowchild statusDDWC

choose case lower(dwo.name)
	case "newstatus"
		//	If new status is (S) scrapped or (R) rejected then set the scrap quantity equal to the remaining quantity.
		if	GetChild("NewStatus", statusDDWC) = 1 then
			long selectedRow
			selectedRow = statusDDWC.Find("Status = ~"" + data + "~"", 1, statusDDWC.RowCount())
			if	selectedRow > 0 then
				if	object.NewStatus.dddw.object.BaseType[selectedRow] = "S" then
					object.ScrapQuantity[row] = object.RemainingQuantity[row]
				end if
			end if
		else
			return 2 //reject value but allow focus to change.
		end if
	case "scrapquantity"
		//	If the scrap quantity is more than remaining quantity, reject the change.
		if	dec(data) > object.RemainingQuantity[row] then
			return 2 //reject value but allow focus to change.
		end if
end choose

end event

type cb_save from commandbutton within u_tabpg_inventory_quality_details
integer x = 1806
integer y = 140
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
string text = "Save Changes"
end type

event clicked;
UpdateChanges()

end event

type cb_writeqc from commandbutton within u_tabpg_inventory_quality_details
integer x = 1806
integer y = 272
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
string text = "Write QC to Obj."
end type

event clicked;
WriteObjectStatus()

end event

type cb_markapproved from commandbutton within u_tabpg_inventory_quality_details
integer x = 1806
integer y = 8
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
string text = "Mark Approved"
end type

event clicked;
SetBaseStatus(InventoryTrans_Quality.OBJECTSTATUS_APPROVED)

end event

type cb_relabel from commandbutton within u_tabpg_inventory_quality_details
integer x = 1806
integer y = 404
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
string text = "Relabel"
end type

event clicked;
Relabel()

end event


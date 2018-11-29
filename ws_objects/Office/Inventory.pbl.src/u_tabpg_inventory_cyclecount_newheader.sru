$PBExportHeader$u_tabpg_inventory_cyclecount_newheader.sru
forward
global type u_tabpg_inventory_cyclecount_newheader from u_tabpg_dw
end type
type dw_headercriteria from u_fxdw within u_tabpg_inventory_cyclecount_newheader
end type
type cb_ok from commandbutton within u_tabpg_inventory_cyclecount_newheader
end type
type cb_cancel from commandbutton within u_tabpg_inventory_cyclecount_newheader
end type
type cb_preview from commandbutton within u_tabpg_inventory_cyclecount_newheader
end type
type cb_editquery from commandbutton within u_tabpg_inventory_cyclecount_newheader
end type
end forward

global type u_tabpg_inventory_cyclecount_newheader from u_tabpg_dw
integer width = 3598
integer height = 1344
string text = "New Cycle Count"
dw_headercriteria dw_headercriteria
cb_ok cb_ok
cb_cancel cb_cancel
cb_preview cb_preview
cb_editquery cb_editquery
end type
global u_tabpg_inventory_cyclecount_newheader u_tabpg_inventory_cyclecount_newheader

type variables

n_cst_inventorytrans_cyclecount InventoryTrans_CycleCount

end variables

forward prototypes
public function integer reset ()
public function integer savenewheader ()
end prototypes

public function integer reset ();
dw_headercriteria.event pfc_retrieve()
dw_1.Reset()

return SUCCESS

end function

public function integer savenewheader ();
string description
choose case dw_headercriteria.Object.Selector[1]
	case "P"
		description = "All inventory of part '" + dw_headercriteria.Object.Part[1] + "'"
	case "L"
		description = "All inventory in location '" + dw_headercriteria.Object.Location[1] + "'"
	case "A"
		description = "All inventory"
end choose

if	dw_headercriteria.Object.ChoosePlant[1] = "Y" then
	description += " and in plant " + IsNull("'" + dw_headercriteria.Object.Plant[1] + "'", "<null>")
end if
description += "."

long returnValue
string cycleCountNumber
if	InventoryTrans_CycleCount.NewHeader(description, cycleCountNumber) = SUCCESS then
	dw_1.SetFilter("")
	dw_1.Filter()
	
	//	Build a list of serials that to add.
	if	dw_1.RowCount() > 0 then
		string serialList = ""
		long row, rows
		long SerialArray []
		
		SerialArray = dw_1.Object.Serial.Primary
		rows = UpperBound(SerialArray)
		for	row = 1 to rows
			if	Len(serialList + String(SerialArray[row])) > 8000 then
				if	InventoryTrans_CycleCount.AddListedObjects(CycleCountNumber, serialList) <> SUCCESS then
					rollback using SQLCA  ;
					return FAILURE
				end if
				serialList = ""
			end if
			serialList += String(SerialArray[row]) + ","
		next
		if	InventoryTrans_CycleCount.AddListedObjects(cycleCountNumber, serialList) <> SUCCESS then
			rollback using SQLCA;
			return FAILURE
		end if
	end if
	if	InventoryTrans_CycleCount.Begin(cycleCountNumber) = SUCCESS then
		commit using SQLCA;
		return SUCCESS
	end if
end if
rollback using SQLCA;
return FAILURE

end function

on u_tabpg_inventory_cyclecount_newheader.create
int iCurrent
call super::create
this.dw_headercriteria=create dw_headercriteria
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_preview=create cb_preview
this.cb_editquery=create cb_editquery
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_headercriteria
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_preview
this.Control[iCurrent+5]=this.cb_editquery
end on

on u_tabpg_inventory_cyclecount_newheader.destroy
call super::destroy
destroy(this.dw_headercriteria)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_preview)
destroy(this.cb_editquery)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_cancel.X + cb_cancel.Width + (cb_cancel.X - (gb_1.X + gb_1.Width)), gb_1.Y + gb_1.Height)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(cb_ok, 100, 0, 0, 0)
inv_Resize.of_Register(cb_cancel, 100, 0, 0, 0)

InventoryTrans_CycleCount = create n_cst_inventorytrans_cyclecount

end event

event destructor;call super::destructor;
destroy InventoryTrans_CycleCount

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_cyclecount_newheader
integer x = 978
integer y = 4
integer width = 2039
integer height = 1088
integer taborder = 0
string text = "Inventory"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_cyclecount_newheader
integer x = 987
integer y = 84
integer width = 2021
integer height = 1000
integer taborder = 20
string dataobject = "d_inventorylist"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;

if	not dw_1.inv_QueryMode.of_GetEnabled() then
	dw_1.SetRedraw(false)
	dw_1.Object.DataWindow.QueryMode = "yes"
	dw_1.Object.DataWindow.QueryClear = "yes"
	
	string	criteria
	choose case dw_headercriteria.Object.Selector[1]
		case "P"
			criteria = "~t~t" + isnull(dw_headercriteria.Object.Part[1], "") + "~t~t"
		case "L"
			criteria = "~t~t~t" + isnull(dw_headercriteria.Object.Location[1], "") + "~t"
		case "A"
			criteria = "~t~t~t~t"
	end choose
	
	if	dw_headercriteria.Object.ChoosePlant[1] = "Y" then
		criteria += dw_headercriteria.Object.Plant[1]
	end if
	criteria +=  "~t~t"
	dw_1.ImportString(criteria)
	dw_1.Object.DataWindow.QueryMode = "no"
	dw_1.SetRedraw(true)
end if

post Retrieve()
return SUCCESS


//
//if	not dw_1.inv_QueryMode.of_GetEnabled() then
//	dw_1.inv_QueryMode.of_SetEnabled(true)
//	dw_1.SetRedraw(false)
//	dw_1.Object.DataWindow.QueryClear = "yes"
//	
//	string	criteria
//	choose case dw_headercriteria.Object.Selector[1]
//		case "P"
//			criteria = "~t" + dw_headercriteria.Object.Part[1] + "~t"
//		case "L"
//			criteria = "~t~t" + dw_headercriteria.Object.Location[1]
//		case "A"
//			criteria = "~t~t"
//	end choose
//	
//	if	dw_headercriteria.Object.ChoosePlant[1] = "Y" then
//		criteria += dw_headercriteria.Object.Plant[1]
//	end if
//	criteria +=  "~t~t~t"
//	dw_1.ImportString(criteria)
//	dw_1.inv_QueryMode.of_SetEnabled(false)
//end if
//
//post Retrieve()
//return SUCCESS
//
//
end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetQueryMode(true)
inv_QueryMode.of_SetRetrieveOnDisabled(false)

end event

type dw_headercriteria from u_fxdw within u_tabpg_inventory_cyclecount_newheader
integer width = 969
integer height = 972
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cyclecount_newheader"
boolean vscrollbar = false
end type

event constructor;call super::constructor;
of_SetRowSelect(false)
of_SetTransObject(SQLCA)
event pfc_retrieve()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_ok from commandbutton within u_tabpg_inventory_cyclecount_newheader
integer x = 3095
integer y = 44
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
end type

event clicked;
dw_headercriteria.AcceptText()
dw_1.event pfc_Retrieve()

SaveNewHeader()
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_cyclecount_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.EndNewHeader()

end event

type cb_cancel from commandbutton within u_tabpg_inventory_cyclecount_newheader
integer x = 3095
integer y = 224
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
Reset()
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_cyclecount_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.CancelNewHeader()

end event

type cb_preview from commandbutton within u_tabpg_inventory_cyclecount_newheader
integer x = 535
integer y = 956
integer width = 425
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Preview >>"
end type

event clicked;
dw_headercriteria.AcceptText()
dw_1.event pfc_Retrieve()

end event

type cb_editquery from commandbutton within u_tabpg_inventory_cyclecount_newheader
boolean visible = false
integer x = 535
integer y = 1088
integer width = 425
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Edit Query >>"
end type

event clicked;
if	dw_1.Object.DataWindow.QueryMode = "yes" then
	dw_1.Object.DataWindow.QueryMode = "no"
else
	dw_1.Object.DataWindow.QueryMode = "yes"
end if


end event


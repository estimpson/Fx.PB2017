$PBExportHeader$u_tabpg_inventory_cyclecount_headers.sru
forward
global type u_tabpg_inventory_cyclecount_headers from u_tabpg_dw
end type
type cb_startnew from commandbutton within u_tabpg_inventory_cyclecount_headers
end type
type cb_end from commandbutton within u_tabpg_inventory_cyclecount_headers
end type
type cb_print from commandbutton within u_tabpg_inventory_cyclecount_headers
end type
end forward

global type u_tabpg_inventory_cyclecount_headers from u_tabpg_dw
integer width = 2496
cb_startnew cb_startnew
cb_end cb_end
cb_print cb_print
end type
global u_tabpg_inventory_cyclecount_headers u_tabpg_inventory_cyclecount_headers

type variables
n_cst_inventorytrans_cyclecount InventoryTrans_CycleCount
string CycleCountNumber

end variables

on u_tabpg_inventory_cyclecount_headers.create
int iCurrent
call super::create
this.cb_startnew=create cb_startnew
this.cb_end=create cb_end
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_startnew
this.Control[iCurrent+2]=this.cb_end
this.Control[iCurrent+3]=this.cb_print
end on

on u_tabpg_inventory_cyclecount_headers.destroy
call super::destroy
destroy(this.cb_startnew)
destroy(this.cb_end)
destroy(this.cb_print)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_startnew.X + (cb_startnew.X - gb_1.X - gb_1.Width) + cb_startnew.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_startnew, 100, 0, 0, 0)
inv_Resize.of_Register(cb_end, 100, 0, 0, 0)
inv_Resize.of_Register(cb_print, 100, 0, 0, 0)

//	Descendents (master):
//	Set the master DWO to the column(s) that acts as a header in a header-detail relationship.
masterDWO[1] = dw_1.object.cyclecountnumber

InventoryTrans_CycleCount = create n_cst_inventorytrans_cyclecount

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_cyclecount_headers
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_cyclecount_headers
string dataobject = "d_dbo_inventorycontrol_cyclecountheaders"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_cyclecount_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

if	activeRow <= 0 or activeRow > RowCount() then
	myController.HideDetails()
	return
end if
myController.ShowDetails(Object.CycleCountNumber[activeRow])
myController.DetailsEnabled(Object.Status[activeRow] = 1)
cb_end.Enabled = (Object.Status[activeRow] < 2)
CycleCountNumber = Object.CycleCountNumber[activeRow]

end event

type cb_startnew from commandbutton within u_tabpg_inventory_cyclecount_headers
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
string text = "Start new ..."
end type

event clicked;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_cyclecount_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.ShowNewHeader()

end event

type cb_end from commandbutton within u_tabpg_inventory_cyclecount_headers
integer x = 1806
integer y = 268
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
string text = "End"
end type

event clicked;
Controller.Refresh()
if	dw_1.RowCount() <= 0 or dw_1.GetRow() <= 0 or dw_1.GetRow() > dw_1.RowCount() then
	return
end if

if	dw_1.Object.Status[dw_1.GetRow()] = 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "This cycle count has not yet begun.")
	return
end if

if	dw_1.Object.Status[dw_1.GetRow()] = 2 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "This cycle count has already been ended.")
	return
end if

if	dw_1.Object.Status[dw_1.GetRow()] <> 1 or dw_1.Object.CountCompleted[dw_1.GetRow()] <> 1 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Only completed cycle counts can be ended.  Finish marking all objects as 'Found', 'Lost', or 'Ignored'")
	return
end if
	
if	MessageBox(gnv_App.iapp_Object.DisplayName, "Once you end the cycle count, all transactions will be final.  Are you ready to continue?", Question!, YesNo!, 2) = 1 then
	if	InventoryTrans_CycleCount.EndCount(CycleCountNumber) = SUCCESS then
		commit using SQLCA  ;
		MessageBox(gnv_App.iapp_Object.DisplayName, "Cycle count ended successfully.")
	else
		MessageBox(gnv_App.iapp_Object.DisplayName, "Cycle count could not be ended.")
	end if
end if
Controller.Refresh()

end event

type cb_print from commandbutton within u_tabpg_inventory_cyclecount_headers
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
string text = "Print"
end type

event clicked;
n_cst_associative_array	printParm
printParm.of_SetItem("Report", "Cycle Count")
printParm.of_SetItem("Arg1", dw_1.Object.CycleCountNumber[dw_1.GetRow()])
Print(printParm)

end event


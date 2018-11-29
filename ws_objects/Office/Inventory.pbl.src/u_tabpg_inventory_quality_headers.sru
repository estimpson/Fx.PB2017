$PBExportHeader$u_tabpg_inventory_quality_headers.sru
forward
global type u_tabpg_inventory_quality_headers from u_tabpg_dw
end type
type cb_startnew from commandbutton within u_tabpg_inventory_quality_headers
end type
type cb_end from commandbutton within u_tabpg_inventory_quality_headers
end type
type cb_print from commandbutton within u_tabpg_inventory_quality_headers
end type
end forward

global type u_tabpg_inventory_quality_headers from u_tabpg_dw
integer width = 2496
cb_startnew cb_startnew
cb_end cb_end
cb_print cb_print
end type
global u_tabpg_inventory_quality_headers u_tabpg_inventory_quality_headers

type variables

n_cst_inventorytrans_quality InventoryTrans_Quality
string QualityBatchNumber

end variables

forward prototypes
public function integer endqualitybatch ()
end prototypes

public function integer endqualitybatch ();
if	MessageBox(gnv_App.iapp_Object.DisplayName, "Any unsaved changes to the quality batch will be lost.   Any unwritten quality transactions written to the database and the quality batch will be closed.", Exclamation!, OkCancel!,  2) = 2 then
	return NO_ACTION
end if

if	InventoryTrans_Quality.EndQualityBatch(QualityBatchNumber) <> SUCCESS then
	return FAILURE
end if
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

on u_tabpg_inventory_quality_headers.create
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

on u_tabpg_inventory_quality_headers.destroy
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

InventoryTrans_Quality = create n_cst_inventorytrans_quality

end event

event destructor;call super::destructor;
destroy InventoryTrans_Quality

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_quality_headers
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_quality_headers
string dataobject = "d_dbo_inventorycontrol_qcbatchheaders"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_inventory_quality_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

if	activeRow <= 0 or activeRow > RowCount() then
	//myController.HideDetails()
	return
end if
myController.ShowDetails(Object.QualityBatchNumber[activeRow])
myController.DetailsEnabled(Object.Status[activeRow] < 2)
cb_end.Enabled = (Object.Status[activeRow] < 2)
QualityBatchNumber = Object.QualityBatchNumber[activeRow]

end event

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

type cb_startnew from commandbutton within u_tabpg_inventory_quality_headers
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

n_cst_inventory_quality_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

myController.ShowNewHeader()

end event

type cb_end from commandbutton within u_tabpg_inventory_quality_headers
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
EndQualityBatch()
end event

type cb_print from commandbutton within u_tabpg_inventory_quality_headers
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
string text = "Print Report"
end type

event clicked;
if	dw_1.GetRow() <= 0 then return

n_cst_associative_array	printParm
if	dw_1.Object.Status[dw_1.GetRow()] < 2 then
	printParm.of_SetItem("Report", "Quality Batch - Sort")
else
	printParm.of_SetItem("Report", "Quality Batch - Posted")
end if
printParm.of_SetItem("Arg1", dw_1.Object.QualityBatchNumber[dw_1.GetRow()])
Print(printParm)

end event


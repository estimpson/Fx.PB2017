$PBExportHeader$u_tabpg_outproc_maint_inventory.sru
forward
global type u_tabpg_outproc_maint_inventory from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_outproc_maint_inventory
end type
type cb_2 from commandbutton within u_tabpg_outproc_maint_inventory
end type
type dw_2 from u_fxdw within u_tabpg_outproc_maint_inventory
end type
type gb_2 from groupbox within u_tabpg_outproc_maint_inventory
end type
end forward

global type u_tabpg_outproc_maint_inventory from u_tabpg_dw
integer width = 2309
string text = "Inventory"
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
gb_2 gb_2
end type
global u_tabpg_outproc_maint_inventory u_tabpg_outproc_maint_inventory

type variables

Private:
//	Controller reference.
n_outproc_maint_controller _myController

//	Model data.
long _opDefRowID

end variables

forward prototypes
public function integer setopdefrowid (long opdefrowid)
public function integer refresh ()
end prototypes

public function integer setopdefrowid (long opdefrowid);
_opDefRowID = opDefRowID
return Refresh()

end function

public function integer refresh ();
super::Refresh()
dw_2.of_Refresh(Refreshing) ; Refreshing = false
return dw_2.event pfc_retrieve()


end function

on u_tabpg_outproc_maint_inventory.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.gb_2
end on

on u_tabpg_outproc_maint_inventory.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)

inv_Resize.of_Register(gb_1, 0, 0, 100, 0)
inv_Resize.of_Register(dw_1, 0, 0, 100, 0)

inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

inv_Resize.of_Register(gb_2, 0, 0, 100, 100)
inv_Resize.of_Register(dw_2, 0, 0, 100, 100)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_outproc_maint_inventory
integer y = 4
integer height = 428
string text = "Supplier Inventory"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_outproc_maint_inventory
integer height = 344
string dataobject = "d_outproc_maint_vendorinventory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve(_opDefRowID)

end event

type cb_1 from commandbutton within u_tabpg_outproc_maint_inventory
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adjust Qty"
end type

event clicked;
if	not IsValid(_myController) then return

dw_1.AcceptText()

long procResult
long selectedRow = 0
n_cst_associative_array	printerParm
long boxSerialNumber
string boxLabelFormat

decimal adjustedQtys[]
adjustedQtys = dw_1.object.AdjustedQuantity.primary

int i
for i = 1 to UpperBound(adjustedQtys)
	if	adjustedQtys[i] >= 0 then
		string partCode
		string vendorLocation
		decimal systemQty
		partCode = dw_1.object.PartCode[i]
		vendorLocation = dw_1.object.VendorLocation[i]
		systemQty = dw_1.object.SystemQuantity[i]
		
		if	MessageBox (gnv_App.iapp_Object.DisplayName, "Are you sure you want to adjust " + vendorLocation + "'s inventory of " + partCode + " from " + string (systemQty) + " to " + string (adjustedQtys[i]) + "?", Question!, YesNo!, 2) = 1 then
			if	_myController.AdjustSupplierQty(partCode, adjustedQtys[i]) <> SUCCESS then
				if	MessageBox (gnv_App.iapp_Object.DisplayName, "Adjustment failed.  Continue?", StopSign!, OkCancel!, 2) = 2 then
					return
				end if
			end if
		end if
	end if
next

post Refresh()

end event

type cb_2 from commandbutton within u_tabpg_outproc_maint_inventory
boolean visible = false
integer x = 1806
integer y = 448
integer width = 407
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "All Dates"
end type

event clicked;
dw_2.of_Refresh(true)
datetime lastDT
SetNull(lastDT)
return dw_2.Retrieve(_opDefRowID, lastDT)

end event

type dw_2 from u_fxdw within u_tabpg_outproc_maint_inventory
integer x = 37
integer y = 548
integer width = 1733
integer height = 632
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_outproc_maint_inventorytranhist"
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
datetime lastDT
lastDT = Datetime(RelativeDate(Today(),-30))
return Retrieve(_opDefRowID, lastDT)

end event

event constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

type gb_2 from groupbox within u_tabpg_outproc_maint_inventory
integer x = 27
integer y = 460
integer width = 1751
integer height = 728
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Transaction History"
end type


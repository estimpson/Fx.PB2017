$PBExportHeader$u_tabpg_inventory_cyclecount_recover.sru
forward
global type u_tabpg_inventory_cyclecount_recover from u_sheet_tabpg
end type
type cb_cancel from commandbutton within u_tabpg_inventory_cyclecount_recover
end type
type cb_ok from commandbutton within u_tabpg_inventory_cyclecount_recover
end type
type dw_1 from u_fxdw within u_tabpg_inventory_cyclecount_recover
end type
end forward

global type u_tabpg_inventory_cyclecount_recover from u_sheet_tabpg
integer width = 2057
integer height = 1052
long backcolor = 1073741824
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global u_tabpg_inventory_cyclecount_recover u_tabpg_inventory_cyclecount_recover

type variables

n_cst_inventory_cyclecount_controller Controller
n_cst_inventorytrans_cyclecount InventoryTrans_CycleCount
string CycleCountNumber

end variables

on u_tabpg_inventory_cyclecount_recover.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on u_tabpg_inventory_cyclecount_recover.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_ok.X + (cb_ok.X - dw_1.X - dw_1.Width) + cb_ok.Width, dw_1.Y * 2 + dw_1.Height)
inv_Resize.of_Register(cb_ok, 100, 0, 0, 0)
inv_Resize.of_Register(cb_cancel, 100, 0, 0, 0)

InventoryTrans_CycleCount = create n_cst_inventorytrans_cyclecount

end event

event destructor;call super::destructor;
destroy InventoryTrans_CycleCount

end event

type cb_cancel from commandbutton within u_tabpg_inventory_cyclecount_recover
integer x = 1431
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
string text = "Cancel"
boolean cancel = true
end type

event clicked;
Controller.HideRecoverSerialPopup()

end event

type cb_ok from commandbutton within u_tabpg_inventory_cyclecount_recover
integer x = 1431
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
string text = "OK"
boolean default = true
end type

event clicked;
long serial
decimal quantity
string location

if	dw_1.RowCount() <= 0 then
	dw_1.InsertRow(0)
	return
end if

serial = dw_1.Object.Serial[1]
quantity = dw_1.Object.Quantity[1]
location = dw_1.Object.Location[1]

if	InventoryTrans_CycleCount.RecoverObject(CycleCountNumber, serial, quantity, location) = SUCCESS then
	commit using SQLCA  ;
	dw_1.of_SetUpdateable(false)
end if

Controller.HideRecoverSerialPopup()

end event

type dw_1 from u_fxdw within u_tabpg_inventory_cyclecount_recover
integer width = 1403
integer height = 880
integer taborder = 10
string dataobject = "d_cyclecount_recoverserial"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;
of_SetRowSelect(false)
of_SetTransObject(SQLCA)

end event

event clicked;call super::clicked;
if	dwo.Name = "b_lookup" then
	event pfc_Retrieve()
end if

end event

event pfc_retrieve;call super::pfc_retrieve;
AcceptText()
if	RowCount() <= 0 then
	InsertRow(0)
end if

long serial
serial = Object.Serial[1]
return Retrieve(serial)

end event


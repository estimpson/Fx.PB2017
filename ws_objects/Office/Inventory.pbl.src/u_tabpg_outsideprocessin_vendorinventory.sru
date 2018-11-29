$PBExportHeader$u_tabpg_outsideprocessin_vendorinventory.sru
forward
global type u_tabpg_outsideprocessin_vendorinventory from u_tabpg_dw
end type
type cb_save from commandbutton within u_tabpg_outsideprocessin_vendorinventory
end type
end forward

global type u_tabpg_outsideprocessin_vendorinventory from u_tabpg_dw
integer width = 2414
string text = "Vendor Inventory"
cb_save cb_save
end type
global u_tabpg_outsideprocessin_vendorinventory u_tabpg_outsideprocessin_vendorinventory

type variables

n_cst_outsideprocessing_inventorytrans InventoryTrans

end variables

on u_tabpg_outsideprocessin_vendorinventory.create
int iCurrent
call super::create
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
end on

on u_tabpg_outsideprocessin_vendorinventory.destroy
call super::destroy
destroy(this.cb_save)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - gb_1.X - gb_1.Width) + cb_save.Width, gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)

InventoryTrans = create n_cst_outsideprocessing_inventorytrans

end event

event destructor;call super::destructor;
destroy InventoryTrans

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_outsideprocessin_vendorinventory
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_outsideprocessin_vendorinventory
string dataobject = "d_dbo_outsideprocessing_vendorinventory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_save from commandbutton within u_tabpg_outsideprocessin_vendorinventory
integer x = 1810
integer y = 20
integer width = 489
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save Changes"
end type

event clicked;
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
			if	InventoryTrans.AdjustVendorInventory(vendorLocation, partCode, adjustedQtys[i]) <> SUCCESS then
				if	MessageBox (gnv_App.iapp_Object.DisplayName, "Adjustment failed.  Continue?", StopSign!, OkCancel!, 2) = 2 then
					return
				end if
			end if
		end if
	end if
next

post Refresh()

end event


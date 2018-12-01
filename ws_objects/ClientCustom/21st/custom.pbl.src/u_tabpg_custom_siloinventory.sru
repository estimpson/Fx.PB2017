$PBExportHeader$u_tabpg_custom_siloinventory.sru
forward
global type u_tabpg_custom_siloinventory from u_tabpg_dw
end type
type cb_activate from commandbutton within u_tabpg_custom_siloinventory
end type
type cb_scrap from commandbutton within u_tabpg_custom_siloinventory
end type
end forward

global type u_tabpg_custom_siloinventory from u_tabpg_dw
integer width = 2277
cb_activate cb_activate
cb_scrap cb_scrap
end type
global u_tabpg_custom_siloinventory u_tabpg_custom_siloinventory

type variables

n_cst_custom_mes_inventorytrans InventoryTrans

end variables

on u_tabpg_custom_siloinventory.create
int iCurrent
call super::create
this.cb_activate=create cb_activate
this.cb_scrap=create cb_scrap
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_activate
this.Control[iCurrent+2]=this.cb_scrap
end on

on u_tabpg_custom_siloinventory.destroy
call super::destroy
destroy(this.cb_activate)
destroy(this.cb_scrap)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_activate.X + (cb_activate.X - gb_1.X - gb_1.Width) + cb_activate.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_activate, 100, 0, 0, 0)
inv_Resize.of_Register(cb_scrap, 100, 0, 0, 0)

InventoryTrans = create n_cst_custom_mes_inventorytrans

end event

event destructor;call super::destructor;
destroy InventoryTrans

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_custom_siloinventory
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_custom_siloinventory
string dataobject = "d_custom_mes_siloinventory"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type cb_activate from commandbutton within u_tabpg_custom_siloinventory
integer x = 1806
integer y = 12
integer width = 416
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Activate Silo"
end type

event clicked;
dw_1.AcceptText()
int siloRow
siloRow = dw_1.GetRow()
if	siloRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

string siloLocationCode

siloLocationCode = dw_1.object.Silo[siloRow]
if	InventoryTrans.activatesilo (siloLocationCode) = SUCCESS then
	MessageBox(gnv_App.iapp_Object.DisplayName, siloLocationCode + " activated.")
end if

Refreshing=true
Refresh()


end event

type cb_scrap from commandbutton within u_tabpg_custom_siloinventory
integer x = 1806
integer y = 144
integer width = 416
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Scrap Remaining"
end type

event clicked;
dw_1.AcceptText()
int siloRow
siloRow = dw_1.GetRow()
if	siloRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

long siloSerial
string siloLocation, siloPart
decimal siloQuantity

siloLocation = dw_1.object.Silo[siloRow]
siloSerial = dw_1.object.Serial[siloRow]
siloPart = dw_1.object.Part[siloRow]
siloQuantity = dw_1.object.Quantity[siloRow]

if	isNull(siloSerial) then
	MessageBox(gnv_App.iapp_Object.DisplayName, siloLocation + " is empty.")
	return
end if
if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure you want to scrap Serial: " + string(siloSerial) + " of " + siloPart + ", Qty: " + String(siloQuantity) + " in " + siloLocation + "?", Question!, YesNo!, 2) = 1 then
	if	InventoryTrans.ScrapSiloSerial (siloSerial) = SUCCESS then
		MessageBox(gnv_App.iapp_Object.DisplayName, "Serial: " + string(siloSerial) + " scrapped.")
	end if
end if

Refreshing=true
Refresh()


end event


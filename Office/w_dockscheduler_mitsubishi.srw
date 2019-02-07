HA$PBExportHeader$w_dockscheduler_mitsubishi.srw
forward
global type w_dockscheduler_mitsubishi from w_sheet_4t
end type
type dw_shipmentdetails from u_fxdw within w_dockscheduler_mitsubishi
end type
type dw_shipperheaderedit from u_fxdw within w_dockscheduler_mitsubishi
end type
type dw_randetails from u_fxdw within w_dockscheduler_mitsubishi
end type
type cb_save from commandbutton within w_dockscheduler_mitsubishi
end type
type st_vsplit from u_st_splitbar within w_dockscheduler_mitsubishi
end type
type st_hsplit2 from u_st_splitbar within w_dockscheduler_mitsubishi
end type
type st_hsplit1 from u_st_splitbar within w_dockscheduler_mitsubishi
end type
type dw_unscheduleddeliveries from u_fxdw within w_dockscheduler_mitsubishi
end type
type gb_unscheduleddeliveries from groupbox within w_dockscheduler_mitsubishi
end type
type gb_shipmentdetails from groupbox within w_dockscheduler_mitsubishi
end type
type gb_randetails from groupbox within w_dockscheduler_mitsubishi
end type
end forward

global type w_dockscheduler_mitsubishi from w_sheet_4t
integer width = 3950
string title = "Mitsubishi Dock Scheduler"
dw_shipmentdetails dw_shipmentdetails
dw_shipperheaderedit dw_shipperheaderedit
dw_randetails dw_randetails
cb_save cb_save
st_vsplit st_vsplit
st_hsplit2 st_hsplit2
st_hsplit1 st_hsplit1
dw_unscheduleddeliveries dw_unscheduleddeliveries
gb_unscheduleddeliveries gb_unscheduleddeliveries
gb_shipmentdetails gb_shipmentdetails
gb_randetails gb_randetails
end type
global w_dockscheduler_mitsubishi w_dockscheduler_mitsubishi

type variables

long RANHeaderID = 0
n_shipping_edimitsubishi_trans ShippingEDIMitsubishiTrans

end variables

on w_dockscheduler_mitsubishi.create
int iCurrent
call super::create
this.dw_shipmentdetails=create dw_shipmentdetails
this.dw_shipperheaderedit=create dw_shipperheaderedit
this.dw_randetails=create dw_randetails
this.cb_save=create cb_save
this.st_vsplit=create st_vsplit
this.st_hsplit2=create st_hsplit2
this.st_hsplit1=create st_hsplit1
this.dw_unscheduleddeliveries=create dw_unscheduleddeliveries
this.gb_unscheduleddeliveries=create gb_unscheduleddeliveries
this.gb_shipmentdetails=create gb_shipmentdetails
this.gb_randetails=create gb_randetails
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipmentdetails
this.Control[iCurrent+2]=this.dw_shipperheaderedit
this.Control[iCurrent+3]=this.dw_randetails
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.st_vsplit
this.Control[iCurrent+6]=this.st_hsplit2
this.Control[iCurrent+7]=this.st_hsplit1
this.Control[iCurrent+8]=this.dw_unscheduleddeliveries
this.Control[iCurrent+9]=this.gb_unscheduleddeliveries
this.Control[iCurrent+10]=this.gb_shipmentdetails
this.Control[iCurrent+11]=this.gb_randetails
end on

on w_dockscheduler_mitsubishi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_shipmentdetails)
destroy(this.dw_shipperheaderedit)
destroy(this.dw_randetails)
destroy(this.cb_save)
destroy(this.st_vsplit)
destroy(this.st_hsplit2)
destroy(this.st_hsplit1)
destroy(this.dw_unscheduleddeliveries)
destroy(this.gb_unscheduleddeliveries)
destroy(this.gb_shipmentdetails)
destroy(this.gb_randetails)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - dw_shipperheaderedit.X - dw_shipperheaderedit.Width) + cb_save.Width, dw_shipperheaderedit.Y + gb_shipmentdetails.Y + gb_shipmentdetails.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(gb_randetails, 0, 0, 0, 100)
inv_Resize.of_Register(dw_randetails, 0, 0, 0, 100)
inv_Resize.of_Register(dw_shipperheaderedit, 0, 0, 100, 0)
inv_Resize.of_Register(st_hsplit2, 0, 0, 100, 0)
inv_Resize.of_Register(gb_shipmentdetails, 0, 0, 100, 100)
inv_Resize.of_Register(dw_shipmentdetails, 0, 0, 100, 100)
inv_Resize.of_Register(st_vsplit, 0, 0, 0, 100)

st_hsplit1.of_Register(gb_unscheduleddeliveries, st_hsplit1.ABOVE)
st_hsplit1.of_Register(dw_unscheduleddeliveries, st_hsplit1.ABOVE)
st_hsplit1.of_Register(gb_randetails, st_hsplit1.BELOW)
st_hsplit1.of_Register(dw_randetails, st_hsplit1.BELOW)

st_vsplit.of_Register(gb_unscheduleddeliveries, st_vsplit.LEFT)
st_vsplit.of_Register(dw_unscheduleddeliveries, st_vsplit.LEFT)
st_vsplit.of_Register(gb_randetails, st_vsplit.LEFT)
st_vsplit.of_Register(dw_randetails, st_vsplit.LEFT)
st_vsplit.of_Register(st_hsplit1, st_vsplit.LEFT)
st_vsplit.of_Register(dw_shipperheaderedit, st_vsplit.RIGHT)
st_vsplit.of_Register(gb_shipmentdetails, st_vsplit.RIGHT)
st_vsplit.of_Register(dw_shipmentdetails, st_vsplit.RIGHT)
st_vsplit.of_Register(st_hsplit2, st_vsplit.RIGHT)

st_hsplit2.of_Register(dw_shipperheaderedit, st_hsplit1.ABOVE)
st_hsplit2.of_Register(gb_shipmentdetails, st_hsplit1.BELOW)
st_hsplit2.of_Register(dw_shipmentdetails, st_hsplit1.BELOW)

//	Shipping transaction service.
ShippingEDIMitsubishiTrans = create n_shipping_edimitsubishi_trans

end event

event pfc_refresh;call super::pfc_refresh;
dw_unscheduleddeliveries.Refresh()

end event

event close;call super::close;
if	IsValid(ShippingEDIMitsubishiTrans) then destroy ShippingEDIMitsubishiTrans

end event

type dw_shipmentdetails from u_fxdw within w_dockscheduler_mitsubishi
integer x = 1664
integer y = 796
integer width = 1559
integer height = 496
integer taborder = 40
string dataobject = "d_edimitsubishi_shipmentdetails_byran"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
of_SetRowSelect(false)
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type dw_shipperheaderedit from u_fxdw within w_dockscheduler_mitsubishi
integer x = 1632
integer width = 1600
integer height = 672
integer taborder = 40
string dataobject = "d_edimitsubishi_shippereditx3"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetRowSelect(false)
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(RANHeaderID)

end event

type dw_randetails from u_fxdw within w_dockscheduler_mitsubishi
integer x = 32
integer y = 528
integer width = 1531
integer height = 764
integer taborder = 30
string dataobject = "d_edimitsubishi_randetails_byranheaderid"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Turn on the PowerFilter service.
SetPowerFilter (true)
PowerFilter.of_SetDW (this)
PowerFilter.post Show()

//	Turn on the sort service
of_SetSort (true)
inv_sort.of_SetStyle(inv_sort.DRAGDROP)
inv_Sort.SetColumnHeaderExt (true)

//	Turn on the filter service
of_SetFilter (true)
inv_filter.of_SetStyle(inv_filter.EXTENDED)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetRowSelect(false)
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(RANHeaderID)

end event

event retrieveend;call super::retrieveend;
SelectRow(0, true)

end event

type cb_save from commandbutton within w_dockscheduler_mitsubishi
integer x = 3291
integer y = 32
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Save"
end type

event clicked;
//	If no rows, do nothing.
if	dw_shipperheaderedit.RowCount() <= 0 then return

//	Read all of the values off of the new shipper.
dw_shipperheaderedit.AcceptText()
datetime pickupDT
string shipToCode, plant, fob, carrier, transMode, freightType, aetcNumber, dockCode, shipperNote
decimal freightAmount
pickupDT = dw_shipperheaderedit.object.PickupDT[1]
shipToCode = dw_shipperheaderedit.object.ShipToCode[1]
plant = dw_shipperheaderedit.object.Plant[1]
fob = dw_shipperheaderedit.object.FOB[1]
carrier = dw_shipperheaderedit.object.Carrier[1]
transMode = dw_shipperheaderedit.object.TransMode[1]
freightType = dw_shipperheaderedit.object.FreightType[1]
freightAmount = dw_shipperheaderedit.object.FreightAmount[1]
aetcNumber = dw_shipperheaderedit.object.AETCNumber[1]
dockCode = dw_shipperheaderedit.object.DockCode[1]
shipperNote = dw_shipperheaderedit.object.ShipperNote[1]

//	Prompt.
if	MessageBox(gnv_App.iapp_Object.DisplayName, "A new shipper will be scheduled from " + plant + " to " + shipToCode + " on " + String(pickupDT, "yyyy-mm-dd hh:mm") + ".", Information!, OkCancel!, 2) = 2 then return

//	Create new shipper.
long newShipper
if	ShippingEDIMitsubishiTrans.SaveNewShipper(newShipper, pickupDT, plant, fob, carrier, transMode, freightType, freightAmount, aetcNumber, dockCode, shipperNote) = SUCCESS then
	commit using SQLCA  ;
	MessageBox(gnv_App.iapp_Object.DisplayName, "New Shipper:  " + String(newShipper) + ".  Shipper Created successfully")
	parent.event pfc_refresh()
end if	

end event

type st_vsplit from u_st_splitbar within w_dockscheduler_mitsubishi
integer x = 1600
integer width = 27
integer height = 1300
end type

type st_hsplit2 from u_st_splitbar within w_dockscheduler_mitsubishi
integer x = 1632
integer y = 676
integer width = 1618
integer height = 28
end type

type st_hsplit1 from u_st_splitbar within w_dockscheduler_mitsubishi
integer y = 400
integer width = 1600
integer height = 28
end type

type dw_unscheduleddeliveries from u_fxdw within w_dockscheduler_mitsubishi
integer x = 32
integer y = 80
integer width = 1531
integer height = 312
integer taborder = 20
string dataobject = "d_edimitsubishi_unscheduledranshippers"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//	Turn on the PowerFilter service.
SetPowerFilter (true)
PowerFilter.of_SetDW (this)
PowerFilter.post Show()

//	Turn on the sort service
of_SetSort (true)
inv_sort.of_SetStyle(inv_sort.DRAGDROP)
inv_Sort.SetColumnHeaderExt (true)

//	Turn on the filter service
of_SetFilter (true)
inv_filter.of_SetStyle(inv_filter.EXTENDED)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event activerowchanged;call super::activerowchanged;
if	activeRow <= 0 then
	dw_randetails.Reset()
	dw_shipperheaderedit.Reset()
	dw_shipmentdetails.Reset()
	return
end if

RANHeaderID = object.RANHeaderID[activeRow]
dw_randetails.Refresh()
dw_shipperheaderedit.Refresh()

n_ds createTempRANHeaderIDs
createTempRANHeaderIDs = create n_ds
createTempRANHeaderIDs.DataObject = "d_edimitsubishi_createtempranheaderids"
createTempRANHeaderIDs.of_SetTransObject(SQLCA)
createTempRANHeaderIDs.Retrieve(RANHeaderID)
destroy createTempRANHeaderIDs
dw_shipmentdetails.Refresh()

end event

type gb_unscheduleddeliveries from groupbox within w_dockscheduler_mitsubishi
integer x = 27
integer width = 1545
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Unscheduled Deliveries"
end type

type gb_shipmentdetails from groupbox within w_dockscheduler_mitsubishi
integer x = 1659
integer y = 704
integer width = 1573
integer height = 596
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Shipment Details (Review Only)"
end type

type gb_randetails from groupbox within w_dockscheduler_mitsubishi
integer x = 27
integer y = 444
integer width = 1545
integer height = 856
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "RAN Details"
end type


$PBExportHeader$w_dockscheduler_toyota.srw
forward
global type w_dockscheduler_toyota from w_sheet_4t
end type
type cb_restore from commandbutton within w_dockscheduler_toyota
end type
type cb_delete from commandbutton within w_dockscheduler_toyota
end type
type dw_shipmentdetails from u_fxdw within w_dockscheduler_toyota
end type
type dw_shipperheaderedit from u_fxdw within w_dockscheduler_toyota
end type
type dw_manifestheaders from u_fxdw within w_dockscheduler_toyota
end type
type cb_save from commandbutton within w_dockscheduler_toyota
end type
type st_vsplit from u_st_splitbar within w_dockscheduler_toyota
end type
type st_hsplit2 from u_st_splitbar within w_dockscheduler_toyota
end type
type st_hsplit1 from u_st_splitbar within w_dockscheduler_toyota
end type
type dw_unscheduleddeliveries from u_fxdw within w_dockscheduler_toyota
end type
type gb_unscheduleddeliveries from groupbox within w_dockscheduler_toyota
end type
type gb_shipmentdetails from groupbox within w_dockscheduler_toyota
end type
type gb_manifestheaders from groupbox within w_dockscheduler_toyota
end type
end forward

global type w_dockscheduler_toyota from w_sheet_4t
integer width = 3950
string title = "Toyota Manifest Dock Scheduler"
cb_restore cb_restore
cb_delete cb_delete
dw_shipmentdetails dw_shipmentdetails
dw_shipperheaderedit dw_shipperheaderedit
dw_manifestheaders dw_manifestheaders
cb_save cb_save
st_vsplit st_vsplit
st_hsplit2 st_hsplit2
st_hsplit1 st_hsplit1
dw_unscheduleddeliveries dw_unscheduleddeliveries
gb_unscheduleddeliveries gb_unscheduleddeliveries
gb_shipmentdetails gb_shipmentdetails
gb_manifestheaders gb_manifestheaders
end type
global w_dockscheduler_toyota w_dockscheduler_toyota

type variables

long PickupID = 0
string _lastManifestNumber = ""
n_shipping_editoyota_trans EDIToyotaTrans

end variables

on w_dockscheduler_toyota.create
int iCurrent
call super::create
this.cb_restore=create cb_restore
this.cb_delete=create cb_delete
this.dw_shipmentdetails=create dw_shipmentdetails
this.dw_shipperheaderedit=create dw_shipperheaderedit
this.dw_manifestheaders=create dw_manifestheaders
this.cb_save=create cb_save
this.st_vsplit=create st_vsplit
this.st_hsplit2=create st_hsplit2
this.st_hsplit1=create st_hsplit1
this.dw_unscheduleddeliveries=create dw_unscheduleddeliveries
this.gb_unscheduleddeliveries=create gb_unscheduleddeliveries
this.gb_shipmentdetails=create gb_shipmentdetails
this.gb_manifestheaders=create gb_manifestheaders
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_restore
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.dw_shipmentdetails
this.Control[iCurrent+4]=this.dw_shipperheaderedit
this.Control[iCurrent+5]=this.dw_manifestheaders
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.st_vsplit
this.Control[iCurrent+8]=this.st_hsplit2
this.Control[iCurrent+9]=this.st_hsplit1
this.Control[iCurrent+10]=this.dw_unscheduleddeliveries
this.Control[iCurrent+11]=this.gb_unscheduleddeliveries
this.Control[iCurrent+12]=this.gb_shipmentdetails
this.Control[iCurrent+13]=this.gb_manifestheaders
end on

on w_dockscheduler_toyota.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_restore)
destroy(this.cb_delete)
destroy(this.dw_shipmentdetails)
destroy(this.dw_shipperheaderedit)
destroy(this.dw_manifestheaders)
destroy(this.cb_save)
destroy(this.st_vsplit)
destroy(this.st_hsplit2)
destroy(this.st_hsplit1)
destroy(this.dw_unscheduleddeliveries)
destroy(this.gb_unscheduleddeliveries)
destroy(this.gb_shipmentdetails)
destroy(this.gb_manifestheaders)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_save.X + (cb_save.X - dw_shipperheaderedit.X - dw_shipperheaderedit.Width) + cb_save.Width, dw_shipperheaderedit.Y + cb_restore.Y + cb_restore.Height)
inv_Resize.of_Register(cb_save, 100, 0, 0, 0)
inv_Resize.of_Register(gb_manifestheaders, 0, 0, 0, 100)
inv_Resize.of_Register(dw_manifestheaders, 0, 0, 0, 100)
inv_Resize.of_Register(dw_shipperheaderedit, 0, 0, 100, 0)
inv_Resize.of_Register(st_hsplit2, 0, 0, 100, 0)
inv_Resize.of_Register(gb_shipmentdetails, 0, 0, 100, 100)
inv_Resize.of_Register(dw_shipmentdetails, 0, 0, 100, 100)
inv_Resize.of_Register(st_vsplit, 0, 0, 0, 100)

st_hsplit1.of_Register(gb_unscheduleddeliveries, st_hsplit1.ABOVE)
st_hsplit1.of_Register(dw_unscheduleddeliveries, st_hsplit1.ABOVE)
st_hsplit1.of_Register(gb_manifestheaders, st_hsplit1.BELOW)
st_hsplit1.of_Register(dw_manifestheaders, st_hsplit1.BELOW)

st_vsplit.of_Register(gb_unscheduleddeliveries, st_vsplit.LEFT)
st_vsplit.of_Register(dw_unscheduleddeliveries, st_vsplit.LEFT)
st_vsplit.of_Register(gb_manifestheaders, st_vsplit.LEFT)
st_vsplit.of_Register(dw_manifestheaders, st_vsplit.LEFT)
st_vsplit.of_Register(st_hsplit1, st_vsplit.LEFT)
st_vsplit.of_Register(dw_shipperheaderedit, st_vsplit.RIGHT)
st_vsplit.of_Register(gb_shipmentdetails, st_vsplit.RIGHT)
st_vsplit.of_Register(dw_shipmentdetails, st_vsplit.RIGHT)
st_vsplit.of_Register(st_hsplit2, st_vsplit.RIGHT)

st_hsplit2.of_Register(dw_shipperheaderedit, st_hsplit1.ABOVE)
st_hsplit2.of_Register(gb_shipmentdetails, st_hsplit1.BELOW)
st_hsplit2.of_Register(dw_shipmentdetails, st_hsplit1.BELOW)

//	Shipping transaction service.
EDIToyotaTrans = create n_shipping_editoyota_trans


end event

event pfc_refresh;call super::pfc_refresh;
dw_unscheduleddeliveries.Refresh()

end event

event close;call super::close;
if	IsValid(EDIToyotaTrans) then destroy EDIToyotaTrans

end event

type cb_restore from commandbutton within w_dockscheduler_toyota
integer x = 2126
integer y = 1188
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Restore ..."
end type

event clicked;
open (w_dockscheduler_toyota_restoredeleted)
w_dockscheduler_toyota_restoredeleted.EDIToyotaTrans = EDIToyotaTrans
w_dockscheduler_toyota_restoredeleted.ParentView = parent

end event

type cb_delete from commandbutton within w_dockscheduler_toyota
integer x = 1659
integer y = 1188
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Delete"
end type

event clicked;
//	Get all selected shipper lines.
long row, rows
long selectedArray []

selectedArray = dw_shipmentdetails.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		string part, customerPart
		part = dw_shipmentdetails.Object.Part[row]
		customerPart = dw_shipmentdetails.Object.CustomerPart[row]
		if	msgbox("Are you sure you want to delete the part " + part + ", customer part " + customerPart + ", from the shipper?  You will have to restore it to schedule it to another shipper.", Question!, YesNo!, 2) = 1 then
			if	EDIToyotaTrans.DeleteManifestDetailsPart(customerPart, PickupID, _lastManifestNumber) = SUCCESS then
				commit using SQLCA  ;
			end if				
		end if
	end if
next

parent.event pfc_refresh()

end event

type dw_shipmentdetails from u_fxdw within w_dockscheduler_toyota
integer x = 1664
integer y = 796
integer width = 1559
integer height = 372
integer taborder = 40
string dataobject = "d_editoyota_shipmentdetails_forpickup"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_lastManifestNumber)

end event

type dw_shipperheaderedit from u_fxdw within w_dockscheduler_toyota
integer x = 1632
integer width = 1600
integer height = 672
integer taborder = 40
string dataobject = "d_editoyota_shippereditx3"
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
return Retrieve(PickupID)

end event

type dw_manifestheaders from u_fxdw within w_dockscheduler_toyota
integer x = 32
integer y = 528
integer width = 1531
integer height = 764
integer taborder = 30
string dataobject = "d_editoyota_manifestheaders_bypickupid"
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
long rowCount
rowCount = Retrieve(PickupID)

SetRow(rowCount)
return rowCount



end event

event activerowchanged;call super::activerowchanged;
if	activeRow <= 0 then
	dw_shipmentdetails.Reset()
	return
end if

SetRedraw(false)
long r
for	r = 1 to RowCount()
	if	r <= activerow then
		Object.IsSelected[r] = 1
	else
		Object.IsSelected[r] = 0
	end if	
next
SetRedraw(true)

_lastManifestNumber = object.ManifestNumber[activeRow]
dw_shipmentdetails.Refresh()

end event

type cb_save from commandbutton within w_dockscheduler_toyota
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
if	MsgBox("A new shipper will be scheduled from " + plant + " to " + shipToCode + " on " + String(pickupDT, "yyyy-mm-dd hh:mm") + ".", Information!, OkCancel!, 2) = 2 then return

//	Create new shipper.
long newShipper
if	EDIToyotaTrans.SaveNewShipper(newShipper, _lastManifestNumber, pickupDT, plant, fob, carrier, transMode, freightType, freightAmount, aetcNumber, dockCode, shipperNote) = SUCCESS then
	commit using SQLCA  ;
	MsgBox("New Shipper:  " + String(newShipper) + ".  Shipper Created successfully")
	parent.event pfc_refresh()
end if	

end event

type st_vsplit from u_st_splitbar within w_dockscheduler_toyota
integer x = 1600
integer width = 27
integer height = 1300
end type

type st_hsplit2 from u_st_splitbar within w_dockscheduler_toyota
integer x = 1632
integer y = 676
integer width = 1618
integer height = 28
end type

type st_hsplit1 from u_st_splitbar within w_dockscheduler_toyota
integer y = 400
integer width = 1600
integer height = 28
end type

type dw_unscheduleddeliveries from u_fxdw within w_dockscheduler_toyota
integer x = 32
integer y = 80
integer width = 1531
integer height = 312
integer taborder = 20
string dataobject = "d_editoyota_unscheduledpickups"
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
	dw_manifestheaders.Reset()
	dw_shipperheaderedit.Reset()
	dw_shipmentdetails.Reset()
	return
end if

PickupID = object.PickupID[activeRow]

n_ds createTempPickupIDs
createTempPickupIDs = create n_ds
createTempPickupIDs.DataObject = "d_editoyota_createtemppickupids"
createTempPickupIDs.of_SetTransObject(SQLCA)
createTempPickupIDs.Retrieve(PickupID)
destroy createTempPickupIDs

dw_manifestheaders.Refresh()
dw_shipperheaderedit.Refresh()

end event

type gb_unscheduleddeliveries from groupbox within w_dockscheduler_toyota
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

type gb_shipmentdetails from groupbox within w_dockscheduler_toyota
event move pbm_move
event resize pbm_size
integer x = 1659
integer y = 704
integer width = 1573
integer height = 472
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

event move;
cb_restore.X += gb_shipmentdetails.X - cb_delete.X
cb_delete.X = gb_shipmentdetails.X

end event

event resize;
cb_delete.Y = gb_shipmentdetails.Height + gb_shipmentdetails.Y + 12
cb_restore.Y = cb_delete.Y

end event

type gb_manifestheaders from groupbox within w_dockscheduler_toyota
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
string text = "Toyota Manifests"
end type


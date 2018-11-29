$PBExportHeader$w_dockscheduler_toyota_restoredeleted.srw
forward
global type w_dockscheduler_toyota_restoredeleted from w_popup
end type
type cb_cancel from commandbutton within w_dockscheduler_toyota_restoredeleted
end type
type cb_restore from commandbutton within w_dockscheduler_toyota_restoredeleted
end type
type dw_1 from u_fxdw within w_dockscheduler_toyota_restoredeleted
end type
type gb_1 from groupbox within w_dockscheduler_toyota_restoredeleted
end type
end forward

global type w_dockscheduler_toyota_restoredeleted from w_popup
integer x = 214
integer y = 221
integer width = 3579
integer height = 1228
string title = "Restore Deleted Manifests"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean clientedge = true
cb_cancel cb_cancel
cb_restore cb_restore
dw_1 dw_1
gb_1 gb_1
end type
global w_dockscheduler_toyota_restoredeleted w_dockscheduler_toyota_restoredeleted

type variables

private:
boolean _isBusy = false

public:
n_shipping_editoyota_trans EDIToyotaTrans
w_dockscheduler_toyota ParentView
end variables

on w_dockscheduler_toyota_restoredeleted.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_restore=create cb_restore
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_restore
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_dockscheduler_toyota_restoredeleted.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_restore)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize(cb_cancel.X + (cb_cancel.X - gb_1.X - gb_1.Width) + cb_cancel.Width, 2 * gb_1.Y + gb_1.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(cb_cancel, 100, 0, 0, 0)
inv_Resize.of_Register(cb_restore, 100, 0, 0, 0)

//	Set preferences.
of_SetPreference(true)
inv_Preference.of_SetWindow(false)

//	Center.
of_SetBase(true)
inv_base.of_Center()

//	Show data.
dw_1.post Refresh()

end event

event deactivate;call super::deactivate;
if	_isBusy then return
close(this)

end event

type cb_cancel from commandbutton within w_dockscheduler_toyota_restoredeleted
integer x = 3040
integer y = 40
integer width = 402
integer height = 112
integer taborder = 20
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
_isBusy = true
close(parent)

end event

type cb_restore from commandbutton within w_dockscheduler_toyota_restoredeleted
integer x = 3040
integer y = 180
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Restore"
boolean default = true
end type

event clicked;
if	not IsValid(EDIToyotaTrans) then return FAILURE
_isBusy = true

//	Get all selected shipper lines.
long row, rows
long selectedArray []

selectedArray = dw_1.Object.IsSelected.Primary
rows = UpperBound(SelectedArray)
for	row = 1 to rows
	if	SelectedArray[row] = 1 then
		long pickupID
		string part, customerPart, manifestNumber
		pickupID = dw_1.Object.PickupID[row]
		part = dw_1.Object.Part[row]
		customerPart = dw_1.Object.CustomerPart[row]
		manifestNumber = dw_1.Object.ManifestNumber[row]
		if	EDIToyotaTrans.RestoreManifestDetailsPart(customerPart, pickupID, manifestNumber) = SUCCESS then
			commit using SQLCA  ;
		end if				
	end if
next

if	IsValid(ParentView) then ParentView.event pfc_refresh()
_isBusy = false
close(parent)

end event

type dw_1 from u_fxdw within w_dockscheduler_toyota_restoredeleted
integer x = 37
integer y = 136
integer width = 2958
integer height = 912
integer taborder = 10
string dataobject = "d_editoyota_deletedmanifests"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

type gb_1 from groupbox within w_dockscheduler_toyota_restoredeleted
integer x = 32
integer y = 16
integer width = 2971
integer height = 1040
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Select manifests to restore"
end type


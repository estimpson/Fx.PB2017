HA$PBExportHeader$u_tabpg_supplieredi_admin_vendorpolist.sru
forward
global type u_tabpg_supplieredi_admin_vendorpolist from u_tabpg_dw
end type
type cb_ediauto from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
end type
type cb_edienable from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
end type
type cb_generatetest from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
end type
type cb_preview from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
end type
type cb_edidisable from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
end type
type cb_adjustaccum from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
end type
end forward

global type u_tabpg_supplieredi_admin_vendorpolist from u_tabpg_dw
integer width = 2377
string text = "Vendor PO List"
cb_ediauto cb_ediauto
cb_edienable cb_edienable
cb_generatetest cb_generatetest
cb_preview cb_preview
cb_edidisable cb_edidisable
cb_adjustaccum cb_adjustaccum
end type
global u_tabpg_supplieredi_admin_vendorpolist u_tabpg_supplieredi_admin_vendorpolist

type variables

private:

//	Constants.
constant long STATUS_DISABLED = 0
constant long STATUS_ENABLED = 1
constant long STATUS_AUTO = 2

//	Controller reference.
n_supplieredi_admin_controller _myController

//	Model data.
string _vendorCode

end variables

forward prototypes
public function integer setvendorcode (string vendorcode)
public function integer setblanketporeleaseplanstatus (long newstatus)
public function integer sendtestreleaseplan ()
public function integer adjustpoaccum ()
end prototypes

public function integer setvendorcode (string vendorcode);
_vendorCode = vendorCode
return Refresh()

end function

public function integer setblanketporeleaseplanstatus (long newstatus);
if	not IsValid(_myController) then return FAILURE

long row, rows
rows = dw_1.RowCount()

for	row = 1 to rows
	long poNumber
	
	if	dw_1.Object.IsSelected[row] = 1 then
		poNumber = dw_1.object.PONumber[row]
		_myController.SetBlanketPOReleasePlanStatus(poNumber, newStatus)
	end if
next

return Refresh()

end function

public function integer sendtestreleaseplan ();
if	not IsValid(_myController) then return FAILURE

long row, rows
rows = dw_1.RowCount()

for	row = 1 to rows
	long poNumber
	
	if	dw_1.Object.IsSelected[row] = 1 and dw_1.Object.EDIStatus[row] > 0 then
		poNumber = dw_1.object.PONumber[row]
		_myController.SendTestReleasePlan(poNumber)
	end if
next

return Refresh()

end function

public function integer adjustpoaccum ();return NO_ACTION

end function

on u_tabpg_supplieredi_admin_vendorpolist.create
int iCurrent
call super::create
this.cb_ediauto=create cb_ediauto
this.cb_edienable=create cb_edienable
this.cb_generatetest=create cb_generatetest
this.cb_preview=create cb_preview
this.cb_edidisable=create cb_edidisable
this.cb_adjustaccum=create cb_adjustaccum
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ediauto
this.Control[iCurrent+2]=this.cb_edienable
this.Control[iCurrent+3]=this.cb_generatetest
this.Control[iCurrent+4]=this.cb_preview
this.Control[iCurrent+5]=this.cb_edidisable
this.Control[iCurrent+6]=this.cb_adjustaccum
end on

on u_tabpg_supplieredi_admin_vendorpolist.destroy
call super::destroy
destroy(this.cb_ediauto)
destroy(this.cb_edienable)
destroy(this.cb_generatetest)
destroy(this.cb_preview)
destroy(this.cb_edidisable)
destroy(this.cb_adjustaccum)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_edienable.X + (cb_edienable.X - gb_1.X - gb_1.Width) + cb_edienable.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_edienable, 100, 0, 0, 0)
inv_Resize.of_Register(cb_ediauto, 100, 0, 0, 0)
inv_Resize.of_Register(cb_edidisable, 100, 0, 0, 0)
inv_Resize.of_Register(cb_generatetest, 100, 0, 0, 0)
inv_Resize.of_Register(cb_preview, 100, 0, 0, 0)
inv_Resize.of_Register(cb_adjustaccum, 100, 100, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_supplieredi_admin_vendorpolist
string text = "Purchase Orders"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_supplieredi_admin_vendorpolist
string dataobject = "d_supplieredi_admin_polist_byvendor"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
//datawindowchild dddw
//
//if	GetChild("Status", dddw) = SUCCESS then
//	dddw.SetTransObject(SQLCA)
//	if	dddw.Retrieve("custom.WireHarnesses") <= 0 then
//		dddw.InsertRow(0)
//	end if
//end if

return Retrieve(_vendorCode)

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) or activeRow <= 0 then return

end event

type cb_ediauto from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
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
string text = "Set Auto"
end type

event clicked;
return SetBlanketPOReleasePlanStatus(STATUS_AUTO)

end event

type cb_edienable from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Enable EDI"
end type

event clicked;
return SetBlanketPOReleasePlanStatus(STATUS_ENABLED)

end event

type cb_generatetest from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
integer x = 1806
integer y = 404
integer width = 407
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Send Test"
end type

event clicked;
return SendTestReleasePlan()

end event

type cb_preview from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
boolean visible = false
integer x = 1806
integer y = 536
integer width = 407
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Preview"
end type

type cb_edidisable from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
integer x = 1806
integer y = 272
integer width = 407
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Disable EDI"
end type

event clicked;
return SetBlanketPOReleasePlanStatus(STATUS_DISABLED)

end event

type cb_adjustaccum from commandbutton within u_tabpg_supplieredi_admin_vendorpolist
integer x = 1806
integer y = 972
integer width = 407
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Adjust Accum"
end type

event clicked;
return AdjustPOAccum()

end event


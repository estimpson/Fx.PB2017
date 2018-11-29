$PBExportHeader$u_tabpg_packaging_bulk_master.sru
forward
global type u_tabpg_packaging_bulk_master from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_packaging_bulk_master
end type
type cb_2 from commandbutton within u_tabpg_packaging_bulk_master
end type
end forward

global type u_tabpg_packaging_bulk_master from u_tabpg_dw
integer width = 2482
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_packaging_bulk_master u_tabpg_packaging_bulk_master

type variables

Private:
//	Controller reference.
n_packaging_bulk_controller _myController

end variables

forward prototypes
public function integer enabletracking ()
public function integer disabletracking ()
end prototypes

public function integer enabletracking ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
_myController.ShowEnableTracking()
SetPointer(Arrow!)

return SUCCESS

end function

public function integer disabletracking ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
_myController.DisableTracking()
SetPointer(Arrow!)

return SUCCESS

end function

on u_tabpg_packaging_bulk_master.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_packaging_bulk_master.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_packaging_bulk_master
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_packaging_bulk_master
string dataobject = "d_packaging_bulktracking_headers"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
of_Refresh(true)
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	not IsValid(_myController) then return

string packageCode
if	activeRow <= 0 or activeRow > RowCount() then
	SetNull(packageCode)
	_myController.SetPackageCode(packageCode)
	return
else
	packageCode = Object.PackageCode[activerow]
end if

if	SingleSelected then
	int bulkTrackFlag
	bulkTrackFlag = Object.BulkTrackFlag[activeRow]
	cb_1.enabled = (bulkTrackFlag = 0)
	cb_2.enabled = (bulkTrackFlag = 1)
else
	cb_1.enabled = false
	cb_2.enabled = false
end if

_myController.SetPackageCode(packageCode)

end event

type cb_1 from commandbutton within u_tabpg_packaging_bulk_master
integer x = 1806
integer y = 8
integer width = 553
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Enable Tracking..."
end type

event clicked;
EnableTracking()

end event

type cb_2 from commandbutton within u_tabpg_packaging_bulk_master
boolean visible = false
integer x = 1806
integer y = 132
integer width = 553
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Disable Tracking"
end type

event clicked;
DisableTracking()

end event


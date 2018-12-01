$PBExportHeader$u_tabpg_cntmgr_master_manifest.sru
forward
global type u_tabpg_cntmgr_master_manifest from u_tabpg_dw
end type
type cb_1 from commandbutton within u_tabpg_cntmgr_master_manifest
end type
type cb_2 from commandbutton within u_tabpg_cntmgr_master_manifest
end type
end forward

global type u_tabpg_cntmgr_master_manifest from u_tabpg_dw
integer width = 2533
string text = "Container Manifest Summary"
cb_1 cb_1
cb_2 cb_2
end type
global u_tabpg_cntmgr_master_manifest u_tabpg_cntmgr_master_manifest

type variables

Private:
//	Controller reference.
n_cntmgr_master_controller _myController

//	Model data.
long _shipperID

//	State data.
boolean _isScanning

end variables

forward prototypes
public function integer setscanning (boolean isscanning)
public function integer setshipperid (long shipperid)
public function integer editmanual ()
end prototypes

public function integer setscanning (boolean isscanning);
_isScanning = isScanning
if	_isScanning then
	cb_1.Text = "Stop Scanning"
else
	cb_1.Text = "Start Scanning"
end if
cb_2.Enabled = not _isScanning

return SUCCESS

end function

public function integer setshipperid (long shipperid);
_shipperID = shipperID
return Refresh()

end function

public function integer editmanual ();
if	not IsValid(_myController) then return FAILURE

dw_1.Reset()
SetPointer(HourGlass!)
_myController.func2()
SetPointer(Arrow!)

return SUCCESS

end function

on u_tabpg_cntmgr_master_manifest.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on u_tabpg_cntmgr_master_manifest.destroy
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

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_cntmgr_master_manifest
string text = "Container Manifest Summary"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_cntmgr_master_manifest
string dataobject = "d_cntmgr_manifestsummary"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
cb_1.Enabled = (not IsNull(_shipperID))
cb_2.Enabled = (not IsNull(_shipperID))

if	IsNull(_shipperID) then
	return Reset()
end if

return Retrieve(_shipperID)

end event

type cb_1 from commandbutton within u_tabpg_cntmgr_master_manifest
integer x = 1806
integer y = 8
integer width = 439
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Start Scanning"
end type

event clicked;
if	_isScanning then
	_myController.StopContainerStagingScanning()
else
	_myController.StartContainerStagingScanning()
end if

end event

type cb_2 from commandbutton within u_tabpg_cntmgr_master_manifest
integer x = 1806
integer y = 136
integer width = 439
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
string text = "Edit Manual..."
end type

event clicked;
EditManual()

end event


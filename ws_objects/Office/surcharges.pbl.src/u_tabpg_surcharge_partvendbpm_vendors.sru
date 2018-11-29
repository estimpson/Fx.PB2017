$PBExportHeader$u_tabpg_surcharge_partvendbpm_vendors.sru
forward
global type u_tabpg_surcharge_partvendbpm_vendors from u_tabpg_dw
end type
type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_partvendbpm_vendors
end type
end forward

global type u_tabpg_surcharge_partvendbpm_vendors from u_tabpg_dw
integer width = 2309
dw_quickgridmenu dw_quickgridmenu
end type
global u_tabpg_surcharge_partvendbpm_vendors u_tabpg_surcharge_partvendbpm_vendors

type variables

Private:
//	Model data.
string _partCode

//	Controller reference.
n_surcharge_partvendbpm_controller _myController

end variables

forward prototypes
public function integer setpartcode (string partcode)
public function integer savechanges ()
end prototypes

public function integer setpartcode (string partcode);
Refreshing = (_partCode = partCode)
_partCode = partCode
return Refresh()

end function

public function integer savechanges ();
dw_1.AcceptText()
return _myController.SavePartVendor()

end function

on u_tabpg_surcharge_partvendbpm_vendors.create
int iCurrent
call super::create
this.dw_quickgridmenu=create dw_quickgridmenu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_quickgridmenu
end on

on u_tabpg_surcharge_partvendbpm_vendors.destroy
call super::destroy
destroy(this.dw_quickgridmenu)
end on

event constructor;call super::constructor;
inv_Resize.of_Register(dw_quickgridmenu, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_surcharge_partvendbpm_vendors
string text = "Vendors"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_surcharge_partvendbpm_vendors
string dataobject = "d_surcharge_partvendbpm"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_partCode)

end event

event dw_1::activerowchanged;call super::activerowchanged;
string activeVendor
if	activerow > 0 then
	if	dw_1.object.Enabled[activeRow] = 1 then
		activeVendor = dw_1.object.VendorCode[activerow]
	end if
end if
_myController.SetActiveVendor(activeVendor)

end event

event dw_1::itemchanged;call super::itemchanged;
if	row <= 0 then return

choose case lower(dwo.Name)
	case Lower("Enabled")
		if	data = "0" then
			decimal nullDec
			SetNull(nullDec)
			object.BaseBlanketPrice[row] = nullDec
		end if
end choose

end event

type dw_quickgridmenu from u_fxdw_quickgridmenu within u_tabpg_surcharge_partvendbpm_vendors
integer x = 1550
integer width = 201
integer height = 68
integer taborder = 30
boolean bringtotop = true
integer deleterowenabled = 0
integer insertrowenabled = 0
end type

event saveclicked;call super::saveclicked;
SaveChanges()

end event

event cancelclicked;call super::cancelclicked;
parent.Refresh()

end event


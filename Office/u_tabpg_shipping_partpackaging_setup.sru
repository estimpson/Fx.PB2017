HA$PBExportHeader$u_tabpg_shipping_partpackaging_setup.sru
forward
global type u_tabpg_shipping_partpackaging_setup from u_tabpg_dw
end type
type cb_enable from commandbutton within u_tabpg_shipping_partpackaging_setup
end type
type cb_disable from commandbutton within u_tabpg_shipping_partpackaging_setup
end type
type cb_warn from commandbutton within u_tabpg_shipping_partpackaging_setup
end type
type cb_setdefault from commandbutton within u_tabpg_shipping_partpackaging_setup
end type
end forward

global type u_tabpg_shipping_partpackaging_setup from u_tabpg_dw
integer width = 2455
cb_enable cb_enable
cb_disable cb_disable
cb_warn cb_warn
cb_setdefault cb_setdefault
end type
global u_tabpg_shipping_partpackaging_setup u_tabpg_shipping_partpackaging_setup

type variables

n_cst_shippingtrans_partpackaging ShippingTrans_PartPackaging

string	CycleCountNumber

end variables

forward prototypes
public function integer enablepack ()
public function integer disablepack ()
public function integer enablepackwithwarning ()
public function integer setdefaultpack ()
end prototypes

public function integer enablepack ();
long row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	if	dw_1.Object.IsSelected[row] = 1 then
		ShippingTrans_PartPackaging.EnablePack(dw_1.Object.ShipperID[row], dw_1.Object.ShipperPart[row], dw_1.Object.PackagingCode[row])
	end if
next
commit using SQLCA  ;

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_shipping_partpackaging_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

myController.Refresh()
return SUCCESS

end function

public function integer disablepack ();
long row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	if	dw_1.Object.IsSelected[row] = 1 then
		ShippingTrans_PartPackaging.DisablePack(dw_1.Object.ShipperID[row], dw_1.Object.ShipperPart[row], dw_1.Object.PackagingCode[row])
	end if
next
commit using SQLCA  ;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_shipping_partpackaging_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

myController.Refresh()
return SUCCESS

end function

public function integer enablepackwithwarning ();
long row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	if	dw_1.Object.IsSelected[row] = 1 then
		ShippingTrans_PartPackaging.EnablePackWithWarning(dw_1.Object.ShipperID[row], dw_1.Object.ShipperPart[row], dw_1.Object.PackagingCode[row])
	end if
next
commit using SQLCA  ;

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_shipping_partpackaging_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

myController.Refresh()
return SUCCESS

end function

public function integer setdefaultpack ();
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return FAILURE

n_cst_shipping_partpackaging_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return FAILURE

long row, rows
rows = dw_1.RowCount()
for	row = 1 to rows
	if	dw_1.Object.IsSelected[row] = 1 then
		ShippingTrans_PartPackaging.SetDefaultPack(dw_1.Object.ShipperID[row], dw_1.Object.ShipperPart[row], dw_1.Object.PackagingCode[row])
		commit using SQLCA  ;
		myController.Refresh()
		return SUCCESS
	end if
next

return NO_ACTION

end function

on u_tabpg_shipping_partpackaging_setup.create
int iCurrent
call super::create
this.cb_enable=create cb_enable
this.cb_disable=create cb_disable
this.cb_warn=create cb_warn
this.cb_setdefault=create cb_setdefault
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_enable
this.Control[iCurrent+2]=this.cb_disable
this.Control[iCurrent+3]=this.cb_warn
this.Control[iCurrent+4]=this.cb_setdefault
end on

on u_tabpg_shipping_partpackaging_setup.destroy
call super::destroy
destroy(this.cb_enable)
destroy(this.cb_disable)
destroy(this.cb_warn)
destroy(this.cb_setdefault)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_enable.X + (cb_enable.X - gb_1.X - gb_1.Width) + cb_enable.Width, gb_1.Y * 2 + gb_1.Height)
inv_Resize.of_Register(cb_enable, 100, 0, 0, 0)
inv_Resize.of_Register(cb_disable, 100, 0, 0, 0)
inv_Resize.of_Register(cb_warn, 100, 0, 0, 0)
inv_Resize.of_Register(cb_setdefault, 100, 0, 0, 0)

ShippingTrans_PartPackaging = create n_cst_shippingtrans_partpackaging

end event

event destructor;call super::destructor;
destroy ShippingTrans_PartPackaging

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_shipping_partpackaging_setup
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_shipping_partpackaging_setup
string dataobject = "d_dbo_shipping_partpackaging_setup"
end type

event dw_1::constructor;call super::constructor;
//of_SetRowSelect(false)
of_SetTransObject(SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(CycleCountNumber)

end event

type cb_enable from commandbutton within u_tabpg_shipping_partpackaging_setup
integer x = 1806
integer y = 8
integer width = 407
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Enable Pack"
end type

event clicked;
EnablePack()

end event

type cb_disable from commandbutton within u_tabpg_shipping_partpackaging_setup
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
string text = "Disable Pack"
end type

event clicked;
DisablePack()

end event

type cb_warn from commandbutton within u_tabpg_shipping_partpackaging_setup
integer x = 1806
integer y = 272
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
string text = "Enable w/ Warn"
end type

event clicked;
EnablePackWithWarning()

end event

type cb_setdefault from commandbutton within u_tabpg_shipping_partpackaging_setup
integer x = 1806
integer y = 404
integer width = 407
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Set Default"
end type

event clicked;
SetDefaultPack()

end event


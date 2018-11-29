$PBExportHeader$n_cst_shipping_partpackaging_controller.sru
forward
global type n_cst_shipping_partpackaging_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_shipping_partpackaging_controller from n_cst_virtual_controller
end type
global n_cst_shipping_partpackaging_controller n_cst_shipping_partpackaging_controller

type variables

private w_shipping_partpackaging ShippingPartPackagingWindow
private u_tabpg_shipping_partpackaging_setup ShippingPartPackagingSetup

end variables

forward prototypes
public function integer registerwindow (ref w_shipping_partpackaging aShippingPartPackagingWindow)
public function integer showlist ()
public function integer refresh ()
end prototypes

public function integer registerwindow (ref w_shipping_partpackaging aShippingPartPackagingWindow);
if	not IsValid(aShippingPartPackagingWindow) or IsNull(aShippingPartPackagingWindow) then
	return FAILURE
end if

ShippingPartPackagingWindow = aShippingPartPackagingWindow

//	Create the header, detail, and new header controls.
ShippingPartPackagingWindow.OpenUserObject(ShippingPartPackagingSetup, "u_tabpg_shipping_partpackaging_setup")
ShippingPartPackagingWindow.uo_1.AddPanelControl(ShippingPartPackagingSetup)
ShippingPartPackagingSetup.Controller = this

return SUCCESS

end function

public function integer showlist ();
if	not IsValid(ShippingPartPackagingWindow) or not IsValid(ShippingPartPackagingWindow) then
	return FAILURE
end if

ShippingPartPackagingWindow.uo_1.ShowControl(ShippingPartPackagingSetup)
ShippingPartPackagingSetup.BringToTop = true
ShippingPartPackagingSetup.BringToTop = true
return SUCCESS

end function

public function integer refresh ();
ShippingPartPackagingSetup.Refreshing = true
ShippingPartPackagingSetup.Refresh()
return SUCCESS

end function

on n_cst_shipping_partpackaging_controller.create
call super::create
end on

on n_cst_shipping_partpackaging_controller.destroy
call super::destroy
end on


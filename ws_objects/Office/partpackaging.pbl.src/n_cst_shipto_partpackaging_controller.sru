$PBExportHeader$n_cst_shipto_partpackaging_controller.sru
forward
global type n_cst_shipto_partpackaging_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_shipto_partpackaging_controller from n_cst_virtual_controller
end type
global n_cst_shipto_partpackaging_controller n_cst_shipto_partpackaging_controller

type variables

private w_shipto_partpackaging shiptoPartPackagingWindow
private u_tabpg_shipto_partpackaging_setup shiptoPartPackagingSetup

end variables

forward prototypes
public function integer registerwindow (ref w_shipto_partpackaging ashiptoPartPackagingWindow)
public function integer showlist ()
public function integer refresh ()
end prototypes

public function integer registerwindow (ref w_shipto_partpackaging ashiptoPartPackagingWindow);
if	not IsValid(ashiptoPartPackagingWindow) or IsNull(ashiptoPartPackagingWindow) then
	return FAILURE
end if

shiptoPartPackagingWindow = ashiptoPartPackagingWindow

//	Create the header, detail, and new header controls.
shiptoPartPackagingWindow.OpenUserObject(shiptoPartPackagingSetup, "u_tabpg_shipto_partpackaging_setup")
shiptoPartPackagingWindow.uo_1.AddPanelControl(shiptoPartPackagingSetup)
shiptoPartPackagingSetup.Controller = this

return SUCCESS

end function

public function integer showlist ();
if	not IsValid(shiptoPartPackagingWindow) or not IsValid(shiptoPartPackagingWindow) then
	return FAILURE
end if

shiptoPartPackagingWindow.uo_1.ShowControl(shiptoPartPackagingSetup)
shiptoPartPackagingSetup.BringToTop = true
shiptoPartPackagingSetup.BringToTop = true
return SUCCESS

end function

public function integer refresh ();
shiptoPartPackagingSetup.Refreshing = true
shiptoPartPackagingSetup.Refresh()
return SUCCESS

end function

on n_cst_shipto_partpackaging_controller.create
call super::create
end on

on n_cst_shipto_partpackaging_controller.destroy
call super::destroy
end on


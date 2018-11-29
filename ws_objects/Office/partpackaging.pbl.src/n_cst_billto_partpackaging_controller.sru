$PBExportHeader$n_cst_billto_partpackaging_controller.sru
forward
global type n_cst_billto_partpackaging_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_billto_partpackaging_controller from n_cst_virtual_controller
end type
global n_cst_billto_partpackaging_controller n_cst_billto_partpackaging_controller

type variables

private w_billto_partpackaging BillToPartPackagingWindow
private u_tabpg_billto_partpackaging_setup BillToPartPackagingSetup

end variables

forward prototypes
public function integer registerwindow (ref w_billto_partpackaging aBillToPartPackagingWindow)
public function integer showlist ()
public function integer refresh ()
end prototypes

public function integer registerwindow (ref w_billto_partpackaging aBillToPartPackagingWindow);
if	not IsValid(aBillToPartPackagingWindow) or IsNull(aBillToPartPackagingWindow) then
	return FAILURE
end if

BillToPartPackagingWindow = aBillToPartPackagingWindow

//	Create the header, detail, and new header controls.
BillToPartPackagingWindow.OpenUserObject(BillToPartPackagingSetup, "u_tabpg_billto_partpackaging_setup")
BillToPartPackagingWindow.uo_1.AddPanelControl(BillToPartPackagingSetup)
BillToPartPackagingSetup.Controller = this

return SUCCESS

end function

public function integer showlist ();
if	not IsValid(BillToPartPackagingWindow) or not IsValid(BillToPartPackagingWindow) then
	return FAILURE
end if

BillToPartPackagingWindow.uo_1.ShowControl(BillToPartPackagingSetup)
BillToPartPackagingSetup.BringToTop = true
BillToPartPackagingSetup.BringToTop = true
return SUCCESS

end function

public function integer refresh ();
BillToPartPackagingSetup.Refreshing = true
BillToPartPackagingSetup.Refresh()
return SUCCESS

end function

on n_cst_billto_partpackaging_controller.create
call super::create
end on

on n_cst_billto_partpackaging_controller.destroy
call super::destroy
end on


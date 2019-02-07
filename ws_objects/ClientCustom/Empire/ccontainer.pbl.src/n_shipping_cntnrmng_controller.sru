$PBExportHeader$n_shipping_cntnrmng_controller.sru
forward
global type n_shipping_cntnrmng_controller from n_cst_virtual_controller
end type
end forward

global type n_shipping_cntnrmng_controller from n_cst_virtual_controller
end type
global n_shipping_cntnrmng_controller n_shipping_cntnrmng_controller

type variables

private:

//	View references.
u_tabpg_shipping_cntnrmng_containerlist _containerlistView

w_shipping_cntnrmng _parentSheet

//	Data context.
n_shipping_trans _bfTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer func1 ()
public function integer func2 ()
end prototypes

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

_parentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

//	Link up frame controller for control of scanning.
GetFrameController()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_containerlistView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_containerlistView, "u_tabpg_shipping_cntnrmng_containerlist")
_parentSheet.uo_1.AddPanelControl(_containerlistView)
MasterListControl = _containerlistView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _containerlistView.Refresh()

end function

public function integer func1 ();
if	not IsValid(_bfTrans) then return FAILURE

if	_bfTrans.func1() <> SUCCESS then
	return FAILURE
end if

_bfTrans.CommitTrans()

return Refresh()

end function

public function integer func2 ();
if	not IsValid(_bfTrans) then return FAILURE

if	_bfTrans.func2() <> SUCCESS then
	return FAILURE
end if

_bfTrans.CommitTrans()

return Refresh()

end function

on n_shipping_cntnrmng_controller.create
call super::create
end on

on n_shipping_cntnrmng_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_bfTrans = create n_shipping_trans

end event

event destructor;call super::destructor;
destroy _bfTrans

end event


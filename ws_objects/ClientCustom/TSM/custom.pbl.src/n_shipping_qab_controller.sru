$PBExportHeader$n_shipping_qab_controller.sru
forward
global type n_shipping_qab_controller from n_cst_virtual_controller
end type
end forward

global type n_shipping_qab_controller from n_cst_virtual_controller
end type
global n_shipping_qab_controller n_shipping_qab_controller

type variables

private:

//	View references.
u_panel_leftright2 u_leftright
u_tabpg_shipping_qab_qabCategories _qabCategoriesView
u_tabpg_shipping_qab_partqabs _partQABsView

w_shipping_qab _parentSheet

//	Data context.
n_shipping_qab_trans _trans

end variables
forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer func1 ()
public function integer func2 (long someValue)
public function integer savecategories ()
public function integer savepartqabs ()
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
_parentSheet.uo_1.ShowControl(u_leftright)
u_leftright.uo_1.ShowControl(_qabCategoriesView)
u_leftright.uo_2.ShowControl(_partQABsView)

return SUCCESS

end function

public function integer createlayout ();
//	Left - Right split view.
_parentSheet.OpenUserObject(u_leftright, "u_panel_leftright2")
_parentSheet.uo_1.AddPanelControl(u_leftright)

//	QAB categories view.
_parentSheet.OpenUserObject(_qabCategoriesView, "u_tabpg_shipping_qab_qabCategories")
u_leftright.uo_1.AddPanelControl(_qabCategoriesView)
MasterListControl = _qabCategoriesView

//	Part QABs view.
_parentSheet.OpenUserObject(_partQABsView, "u_tabpg_shipping_qab_partqabs")
u_leftright.uo_2.AddPanelControl(_partQABsView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
_qabCategoriesView.Refresh()
_partQABsView.Refresh()
return SUCCESS


end function

public function integer func1 ();
if	not IsValid(_trans) then return FAILURE

if	_trans.func1() <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return Refresh()

end function

public function integer func2 (long someValue);
if	not IsValid(_trans) then return FAILURE

if	_trans.func2(someValue) <> SUCCESS then
	return FAILURE
end if

_trans.CommitTrans()

return Refresh()

end function

public function integer savecategories ();

_qabCategoriesView.dw_1.Update()
_trans.CommitTrans()

return Refresh()


end function

public function integer savepartqabs ();

_partQABsView.dw_1.Update()
_trans.CommitTrans()

return Refresh()

end function

on n_shipping_qab_controller.create
call super::create
end on

on n_shipping_qab_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_shipping_qab_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


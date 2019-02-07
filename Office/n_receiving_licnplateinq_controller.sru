HA$PBExportHeader$n_receiving_licnplateinq_controller.sru
forward
global type n_receiving_licnplateinq_controller from n_cst_virtual_controller
end type
end forward

global type n_receiving_licnplateinq_controller from n_cst_virtual_controller
end type
global n_receiving_licnplateinq_controller n_receiving_licnplateinq_controller

type variables

private:

//	View references.
u_tabpg_receiving_licnplateinq_list _listView

w_receiving_licnplateinq _parentSheet

//	Data context.
n_cst_receivingdocktrans _trans

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
_parentSheet.uo_1.ShowControl(_listView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_listView, "u_tabpg_receiving_licnplateinq_list")
_parentSheet.uo_1.AddPanelControl(_listView)
MasterListControl = _listView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _listView.Refresh()

end function

public function integer func1 ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func1() <> SUCCESS then
//	return FAILURE
//end if

_trans.CommitTrans()

return Refresh()

end function

public function integer func2 ();
if	not IsValid(_trans) then return FAILURE

//if	_trans.func2() <> SUCCESS then
//	return FAILURE
//end if

_trans.CommitTrans()

return Refresh()

end function

on n_receiving_licnplateinq_controller.create
call super::create
end on

on n_receiving_licnplateinq_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_cst_receivingdocktrans

end event

event destructor;call super::destructor;
destroy _trans

end event

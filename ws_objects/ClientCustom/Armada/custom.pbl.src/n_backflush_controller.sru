$PBExportHeader$n_backflush_controller.sru
forward
global type n_backflush_controller from n_cst_virtual_controller
end type
end forward

global type n_backflush_controller from n_cst_virtual_controller
end type
global n_backflush_controller n_backflush_controller

type variables

private:

//	View references.
u_tabpg_backflush_batchprocess _batchProcessView

w_backflush_batchprocess _parentSheet

//	Data context.
n_backflush_trans _bfTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer backflush ()
public function integer backflushwithoverride ()
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
_parentSheet.uo_1.ShowControl(_batchProcessView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_batchProcessView, "u_tabpg_backflush_batchprocess")
_parentSheet.uo_1.AddPanelControl(_batchProcessView)
MasterListControl = _batchProcessView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _batchProcessView.Refresh()

end function

public function integer backflush ();
if	not IsValid(_bfTrans) then return FAILURE

if	_bfTrans.Backflush() <> SUCCESS then
	return FAILURE
end if

_bfTrans.CommitTrans()

return Refresh()

end function

public function integer backflushwithoverride ();
if	not IsValid(_bfTrans) then return FAILURE

if	_bfTrans.BackflushWithOverride() <> SUCCESS then
	return FAILURE
end if

_bfTrans.CommitTrans()

return Refresh()

end function

on n_backflush_controller.create
call super::create
end on

on n_backflush_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_bfTrans = create n_backflush_trans

end event

event destructor;call super::destructor;
destroy _bfTrans

end event


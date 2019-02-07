HA$PBExportHeader$n_shipping_expeditecodes_controller.sru
forward
global type n_shipping_expeditecodes_controller from n_cst_virtual_controller
end type
end forward

global type n_shipping_expeditecodes_controller from n_cst_virtual_controller
end type
global n_shipping_expeditecodes_controller n_shipping_expeditecodes_controller

type variables

private:

//	Model data.

//	View references.
u_tabpg_shipping_expeditecodes_setup _expediteCodesView

w_shipping_expeditecodes _parentSheet

//	Data context.
//n_shipping_expeditecodes_trans _expediteCodesTrans

end variables
forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer createlayout ()
public function integer showcontrols ()
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

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_expediteCodesView, "u_tabpg_shipping_expeditecodes_setup")
_parentSheet.uo_1.AddPanelControl(_expediteCodesView)
MasterListControl = _expediteCodesView

 //	Show controls
post ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_expediteCodesView)
 
return SUCCESS

end function

on n_shipping_expeditecodes_controller.create
call super::create
end on

on n_shipping_expeditecodes_controller.destroy
call super::destroy
end on


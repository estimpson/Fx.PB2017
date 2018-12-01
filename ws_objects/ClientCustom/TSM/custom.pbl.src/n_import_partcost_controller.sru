$PBExportHeader$n_import_partcost_controller.sru
forward
global type n_import_partcost_controller from n_cst_virtual_controller
end type
end forward

global type n_import_partcost_controller from n_cst_virtual_controller
end type
global n_import_partcost_controller n_import_partcost_controller

type variables

private:

//	View references.
u_tabpg_import_partcost_parts _partsView

w_import_partcost _parentSheet

//	Data context.
n_import_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer saveimport ()
public function integer clearimport ()
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
_parentSheet.uo_1.ShowControl(_partsView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_partsView, "u_tabpg_import_partcost_parts")
_parentSheet.uo_1.AddPanelControl(_partsView)
MasterListControl = _partsView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _partsView.Refresh()

end function

public function integer saveimport ();
if	not IsValid(_trans) then return FAILURE

if	_partsView.DWUpdate() = SUCCESS then
	if	_trans.SaveImportedCosts() <> SUCCESS then
		return FAILURE
	end if
else
	_trans.RollbackTrans()
	msgBox("Saving imported costs failed.", stopsign!)
end if

_trans.CommitTrans()
msgBox("Cost import finished successfully.")

return Refresh()

end function

public function integer clearimport ();
if	not IsValid(_trans) then return FAILURE

return Refresh()

end function

on n_import_partcost_controller.create
call super::create
end on

on n_import_partcost_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_import_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


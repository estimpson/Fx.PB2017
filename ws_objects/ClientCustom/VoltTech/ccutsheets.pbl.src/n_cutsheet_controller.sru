$PBExportHeader$n_cutsheet_controller.sru
forward
global type n_cutsheet_controller from n_cst_virtual_controller
end type
end forward

global type n_cutsheet_controller from n_cst_virtual_controller
end type
global n_cutsheet_controller n_cutsheet_controller

type variables

private:

//	Model data.
string _wireHarness = "AUTB0019-PR-00-A"

//	View references.
w_cutsheet_wireharness _parentSheet

u_panel_headerdetail _headerDetailSplitView

u_tabpg_wireharnesslist _wireHarnessList
u_cutsheet _cutSheet

//	Data context.
n_leaktester_trans _leakTesterTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer createlayout ()
public function integer showcontrols ()
public function integer refresh ()
public function integer setwireharness (string wireharness)
end prototypes

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

_parentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

return SUCCESS

end function

public function integer createlayout ();
_parentSheet.SetRedraw(false)

//	Header-detail split view:
_parentSheet.OpenUserObject(_headerDetailSplitView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailSplitView)

//	Wire harness list view:
_parentSheet.OpenUserObject(_wireHarnessList, "u_tabpg_wireharnesslist")
_headerDetailSplitView.uo_1.AddPanelControl(_wireHarnessList)
 
//	Cut sheet view:
_parentSheet.OpenUserObject(_cutSheet, "u_cutsheet")
_headerDetailSplitView.uo_2.AddPanelControl(_cutSheet)
 
//	Show controls
ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_headerDetailSplitView)
_headerDetailSplitView.uo_1.ShowControl(_wireHarnessList)
_headerDetailSplitView.uo_2.ShowControl(_cutSheet)

_parentSheet.SetRedraw(true)

return SUCCESS

end function

public function integer refresh ();
_wireHarnessList.Refresh()

return SUCCESS

end function

public function integer setwireharness (string wireharness);
_wireHarness = wireHarness
_cutSheet.SetWireHarness(_wireHarness)

return SUCCESS

end function

on n_cutsheet_controller.create
call super::create
end on

on n_cutsheet_controller.destroy
call super::destroy
end on


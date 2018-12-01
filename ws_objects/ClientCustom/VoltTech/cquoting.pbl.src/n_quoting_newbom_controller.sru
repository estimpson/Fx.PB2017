$PBExportHeader$n_quoting_newbom_controller.sru
forward
global type n_quoting_newbom_controller from n_cst_virtual_controller
end type
end forward

global type n_quoting_newbom_controller from n_cst_virtual_controller
end type
global n_quoting_newbom_controller n_quoting_newbom_controller

type variables

//	View references.
u_tabpg_newbom _newBOMView
u_fxdw _existingPartListView
u_fxdw_newquotedbomcomponent _newQuotedBOMComponentView
u_fxdw_newbomitem _newBOMItemView

w_quoting _parentSheet
u_panel _hostPanel
end variables
forward prototypes
public function integer createlayout ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet, ref u_panel hostpanel)
public function integer showcontrols ()
end prototypes

public function integer createlayout ();
_parentSheet.SetRedraw(false)

//	New quote bom component view. 
_parentSheet.OpenUserObject(_newBOMView, "u_tabpg_newbom")
_hostPanel.AddPanelControl(_newBOMView)

//	Existing parts list.
_parentSheet.OpenUserObject(_existingPartListView, "u_fxdw")
_existingPartListView.DataObject = "d_custom_partmaster_setuplist"
_existingPartListView.of_SetTransObject(SQLCA)
_existingPartListView.Retrieve()
_newBOMView._existingPartPanel.AddPanelControl(_existingPartListView)

//	New quoted part view.
_parentSheet.OpenUserObject(_newQuotedBOMComponentView, "u_fxdw_newquotedbomcomponent")
_newQuotedBOMComponentView.InsertRow(0)
_newBOMView._newPartPanel.AddPanelControl(_newQuotedBOMComponentView)

//	New bom item view.
_parentSheet.OpenUserObject(_newBOMItemView, "u_fxdw_newbomitem")
_newBOMItemView.InsertRow(0)
_newBOMView._newBOMPanel.AddPanelControl(_newBOMItemView)

//	Show controls
ShowControls()

return SUCCESS

end function

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet, ref u_panel hostpanel);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) or not IsValid(hostPanel) or IsNull(hostPanel) then
	return FAILURE
end if

_parentSheet = aParentSheet
_hostPanel = hostPanel

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

//	Link up frame controller for control of scanning.
GetFrameController()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_hostPanel.ShowControl(_newBOMView)
_newBOMView._existingPartPanel.ShowControl(_existingPartListView)
_newBOMView._newPartPanel.ShowControl(_newQuotedBOMComponentView)
_newBOMView._newBOMPanel.ShowControl(_newBOMItemView)

_parentSheet.SetRedraw(true)

return SUCCESS

end function

on n_quoting_newbom_controller.create
call super::create
end on

on n_quoting_newbom_controller.destroy
call super::destroy
end on


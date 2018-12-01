$PBExportHeader$n_whassembly_kanbanracks_controller.sru
forward
global type n_whassembly_kanbanracks_controller from n_cst_virtual_controller
end type
end forward

global type n_whassembly_kanbanracks_controller from n_cst_virtual_controller
end type
global n_whassembly_kanbanracks_controller n_whassembly_kanbanracks_controller

type variables

private:
//constant integer MODE_SHOWLINES = 1
//constant integer MODE_SHOWOBJECTS = 2
constant int NONE = 0, OPERATOR = 1, MATERIALHANDLER = 2

//	Model data.
string _parentLocation, _aisle
string _wireHarnessPart

//	View references.
u_panel_leftright _locationPartSplitView
u_panel_headerdetail _parentLocationAisleSplitView, _aisleDefinitionLocationSplitView, _harnessComponentsSplitView
u_tabpg_whassembly_parentlocations _parentLocationsView
u_tabpg_whassembly_aisledefinitions _aisleDefinitionsView
u_tabpg_whassembly_kanbanLocations _kanbanLocationsView
u_tabpg_whassembly_activewireharnesses _activeWireharnessesView
u_tabpg_whassembly_replenishmentdefs _replenishmentDefinitionsView

w_whassembly_kanbanracks _parentSheet

//	Data context.
n_whassembly_kanbanracks_trans _wireHarnessAssemblyKanbanRacksTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer createlayout ()
public function integer showcontrols ()
public function integer refresh ()
public function integer setparentlocation (string parentlocation)
public function integer setaisle (string aisle)
public function integer setwireharnesspart (string partcode)
public function integer saveaisledefinitions ()
public function integer savereplenishmentdefinitions ()
public function integer savekanbanlocations ()
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
//	Location - Part Split View
_parentSheet.OpenUserObject(_locationPartSplitView, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_locationPartSplitView)

//	Parent Location - Aisle Split View
_parentSheet.OpenUserObject(_parentLocationAisleSplitView, "u_panel_headerdetail")
_locationPartSplitView.uo_1.AddPanelControl(_parentLocationAisleSplitView)

//	Aisle Definition - Location Split View
_parentSheet.OpenUserObject(_aisleDefinitionLocationSplitView, "u_panel_headerdetail")
_parentLocationAisleSplitView.uo_2.AddPanelControl(_aisleDefinitionLocationSplitView)

//	Harness - Components Split View
_parentSheet.OpenUserObject(_harnessComponentsSplitView, "u_panel_headerdetail")
_locationPartSplitView.uo_2.AddPanelControl(_harnessComponentsSplitView)

//	Parent Locations View
_parentSheet.OpenUserObject(_parentLocationsView, "u_tabpg_whassembly_parentlocations")
_parentLocationAisleSplitView.uo_1.AddPanelControl(_parentLocationsView)

//	Aisle Definitions View
_parentSheet.OpenUserObject(_aisleDefinitionsView, "u_tabpg_whassembly_aisledefinitions")
_aisleDefinitionLocationSplitView.uo_1.AddPanelControl(_aisleDefinitionsView)

//	Kanban Locations View
_parentSheet.OpenUserObject(_kanbanLocationsView, "u_tabpg_whassembly_kanbanLocations")
_aisleDefinitionLocationSplitView.uo_2.AddPanelControl(_kanbanLocationsView)

//	Active Wireharnesses View
_parentSheet.OpenUserObject(_activeWireharnessesView, "u_tabpg_whassembly_activewireharnesses")
_harnessComponentsSplitView.uo_1.AddPanelControl(_activeWireharnessesView)

//	Active Wireharnesses View
_parentSheet.OpenUserObject(_replenishmentDefinitionsView, "u_tabpg_whassembly_replenishmentdefs")
_harnessComponentsSplitView.uo_2.AddPanelControl(_replenishmentDefinitionsView)

 //	Show controls
post ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_locationPartSplitView)
_locationPartSplitView.uo_1.ShowControl(_parentLocationAisleSplitView)
_parentLocationAisleSplitView.uo_2.ShowControl(_aisleDefinitionLocationSplitView)
_locationPartSplitView.uo_2.ShowControl(_harnessComponentsSplitView)
_parentLocationAisleSplitView.uo_1.ShowControl(_parentLocationsView)
_aisleDefinitionLocationSplitView.uo_1.ShowControl(_aisleDefinitionsView)
_aisleDefinitionLocationSplitView.uo_2.ShowControl(_kanbanLocationsView)
_harnessComponentsSplitView.uo_1.ShowControl(_activeWireharnessesView)
_harnessComponentsSplitView.uo_2.ShowControl(_replenishmentDefinitionsView)

return SUCCESS

end function

public function integer refresh ();
_parentLocationsView.Refresh()
_aisleDefinitionsView.SetParentLocation(_parentLocation)
_kanbanLocationsView.SetParentLocationAisle(_parentLocation, _aisle)
_activeWireharnessesView.Refresh()
_replenishmentDefinitionsView.SetWireHarnessPart(_wireHarnessPart)

return SUCCESS


end function

public function integer setparentlocation (string parentlocation);
_parentLocation = parentLocation
_aisleDefinitionsView.SetParentLocation(_parentLocation)
_kanbanLocationsView.Reset()

return SUCCESS

end function

public function integer setaisle (string aisle);
_aisle = aisle
_kanbanLocationsView.SetParentLocationAisle(_parentLocation, _aisle)

return SUCCESS

end function

public function integer setwireharnesspart (string partcode);
_wireHarnessPart = partCode
_replenishmentDefinitionsView.SetWireHarnessPart(_wireHarnessPart)

return SUCCESS

end function

public function integer saveaisledefinitions ();
long row, rows
rows = _aisleDefinitionsView.dw_1.RowCount()

string parentLocation, aisle, parentLocationPrefix
int layers, positions
long aisleRowID

for	row = 1 to rows
	dwitemstatus status
	status = _aisleDefinitionsView.dw_1.GetItemStatus(row, 0, Primary!)
	
	parentLocation = _aisleDefinitionsView.dw_1.Object.parentlocation[row]
	aisle = _aisleDefinitionsView.dw_1.Object.Aisle[row]
	parentLocationPrefix = _aisleDefinitionsView.dw_1.Object.ParentLocationPrefix[row]
	layers = _aisleDefinitionsView.dw_1.Object.Layers[row]
	positions = _aisleDefinitionsView.dw_1.Object.Positions[row]
	aisleRowID = _aisleDefinitionsView.dw_1.Object.RowID[row]
	
	choose case status
		case DataModified!
			if	_wireHarnessAssemblyKanbanRacksTrans.UpdateAisleDefinition(aisleRowID, aisle, parentLocationPrefix, layers, positions) = SUCCESS then
				_wireHarnessAssemblyKanbanRacksTrans.CommitTrans()
			else
				_wireHarnessAssemblyKanbanRacksTrans.RollbackTrans()
				return FAILURE
			end if
		case NewModified!
			if	_wireHarnessAssemblyKanbanRacksTrans.NewAisleDefinition(parentLocation, aisle, parentLocationPrefix, layers, positions) = SUCCESS then
				_wireHarnessAssemblyKanbanRacksTrans.CommitTrans()
			else
				_wireHarnessAssemblyKanbanRacksTrans.RollbackTrans()
				return FAILURE
			end if
	end choose
next

rows = _aisleDefinitionsView.dw_1.DeletedCount()

for	row = 1 to rows
	parentLocation = _aisleDefinitionsView.dw_1.Object.ParentLocation.Delete[row]
	aisle = _aisleDefinitionsView.dw_1.Object.Aisle.Delete[row]
	parentLocationPrefix = _aisleDefinitionsView.dw_1.Object.ParentLocationPrefix.Delete[row]
	layers = _aisleDefinitionsView.dw_1.Object.Layers.Delete[row]
	positions = _aisleDefinitionsView.dw_1.Object.Positions.Delete[row]
	aisleRowID = _aisleDefinitionsView.dw_1.Object.RowID.Delete[row]
	
	if	_wireHarnessAssemblyKanbanRacksTrans.DeleteAisleDefinition(aisleRowID) = SUCCESS then
			_wireHarnessAssemblyKanbanRacksTrans.CommitTrans()
		else
			_wireHarnessAssemblyKanbanRacksTrans.RollbackTrans()
			return FAILURE
		end if
next

return Refresh()

end function

public function integer savereplenishmentdefinitions ();
long row, rows
rows = _replenishmentDefinitionsView.dw_1.RowCount()

string location, componentPart

for	row = 1 to rows
	dwitemstatus status
	status = _replenishmentDefinitionsView.dw_1.GetItemStatus(row, 0, Primary!)
	
	location = _replenishmentDefinitionsView.dw_1.Object.AssignedAssemblyKanbanLocation[row]
	componentPart = _replenishmentDefinitionsView.dw_1.Object.ComponentPart[row]
	
	choose case status
		case DataModified!
			if	_wireHarnessAssemblyKanbanRacksTrans.UpdateComponentPartLocation(componentPart, location) = SUCCESS then
				_wireHarnessAssemblyKanbanRacksTrans.CommitTrans()
			else
				_wireHarnessAssemblyKanbanRacksTrans.RollbackTrans()
				return FAILURE
			end if
	end choose
next

return Refresh()

end function

public function integer savekanbanlocations ();
long row, rows
rows = _kanbanLocationsView.dw_1.RowCount()

string location, componentPart

for	row = 1 to rows
	dwitemstatus status
	status = _kanbanLocationsView.dw_1.GetItemStatus(row, 0, Primary!)
	
	location = _kanbanLocationsView.dw_1.Object.LocationCode[row]
	componentPart = _kanbanLocationsView.dw_1.Object.ComponentPart[row]
	
	choose case status
		case DataModified!
			if	_wireHarnessAssemblyKanbanRacksTrans.UpdateLocationComponentPart(location, componentPart) = SUCCESS then
				_wireHarnessAssemblyKanbanRacksTrans.CommitTrans()
			else
				_wireHarnessAssemblyKanbanRacksTrans.RollbackTrans()
				return FAILURE
			end if
	end choose
next

return Refresh()

end function

on n_whassembly_kanbanracks_controller.create
call super::create
end on

on n_whassembly_kanbanracks_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_wireHarnessAssemblyKanbanRacksTrans = create n_whassembly_kanbanracks_trans

end event

event destructor;call super::destructor;
destroy _wireHarnessAssemblyKanbanRacksTrans

end event


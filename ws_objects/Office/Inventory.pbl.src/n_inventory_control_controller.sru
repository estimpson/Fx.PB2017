$PBExportHeader$n_inventory_control_controller.sru
forward
global type n_inventory_control_controller from n_cst_virtual_controller
end type
end forward

global type n_inventory_control_controller from n_cst_virtual_controller
end type
global n_inventory_control_controller n_inventory_control_controller

type variables

private:
//	State management.
int _qFilterMode
constant int QF_ShowAll = 0
constant int QF_Serial = 1
constant int QF_Part = 2
constant int QF_Location = 3
constant int QF_Pallet = 4

int _inprocessCommand
constant int IC_NONE = 0
constant int IC_TRANSFER = 1
constant int IC_BREAKOUT = 2
constant int IC_COMBINE = 3
constant int IC_RELABEL = 4

//	Model data.
long _selectedSerials[]

//	View references.
u_panel_leftright _lrMain
u_panel_leftright _lrQuickFindCommandDetails
u_panel_headerdetail _hdInventory
u_tabpg_inventory_control_objects _objectsView
u_tabpg_inventory_control_breakout _breakoutCommandView
u_tabpg_inventory_control_combine _combineCommandView
u_tabpg_inventory_control_transfer _transferCommandView
u_tabpg_inventory_control_relabel _relabelCommandView
u_fxdw_inventory_control_commands _commandsView
u_tabpg_inventory_control_qfilter _quickFindView
u_fxdw_inventory_control_quickfindselect _quickFindSelectionView

w_inventory_control _parentSheet

//	Data context.
n_inventory_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer partfilter ()
public function integer locationfilter ()
public function integer palletfilter ()
public function integer serialfilter ()
public function integer nofilter ()
public function integer setpartfilter (string partlist)
public function integer starttransfer ()
public function integer setlocationfilter (string locationlist)
public function integer setpalletfilter (long palletserial)
public function integer setselectedobjects (long selectedserials[])
public function integer endinventorycommand ()
public function integer transfer (string seriallist, integer superobjectflag, string location, long palletserial)
public function integer startbreakout ()
public function integer startcombine ()
public function integer startrelabel ()
public function integer combine (string seriallist, string labelformat)
public function integer printlabel (long serial, string labelformat)
public function integer relabel (long serials[], string labelformat)
public function integer breakout (long serials[], decimal qtyperobject, string unit, string packagetype, integer objectcount, string labelformat)
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
_parentSheet.uo_1.ShowControl(_lrMain)
_lrMain.uo_1.ShowControl(_commandsView)
_lrMain.uo_2.ShowControl(_hdInventory)
_hdInventory.uo_1.ShowControl(_lrQuickFindCommandDetails)
_hdInventory.uo_2.ShowControl(_objectsView)
_lrQuickFindCommandDetails.uo_1.ShowControl(_quickFindSelectionView)
_lrQuickFindCommandDetails.uo_2.ShowControl(_quickFindView)

_objectsView.post ShowAll()

return SUCCESS

end function

public function integer createlayout ();
_parentSheet.OpenUserObject(_lrMain, "u_panel_leftright")
_parentSheet.uo_1.AddPanelControl(_lrMain)

_parentSheet.OpenUserObject(_commandsView, "u_fxdw_inventory_control_commands")
_lrMain.uo_1.AddPanelControl(_commandsView)

_parentSheet.OpenUserObject(_hdInventory, "u_panel_headerdetail")
_lrMain.uo_2.AddPanelControl(_hdInventory)

_parentSheet.OpenUserObject(_lrQuickFindCommandDetails, "u_panel_leftright")
_hdInventory.uo_1.AddPanelControl(_lrQuickFindCommandDetails)

_parentSheet.OpenUserObject(_objectsView, "u_tabpg_inventory_control_objects")
_hdInventory.uo_2.AddPanelControl(_objectsView)

_parentSheet.OpenUserObject(_quickFindSelectionView, "u_fxdw_inventory_control_quickfindselect")
_lrQuickFindCommandDetails.uo_1.AddPanelControl(_quickFindSelectionView)

_parentSheet.OpenUserObject(_quickFindView, "u_tabpg_inventory_control_qfilter")
_parentSheet.OpenUserObject(_breakoutCommandView, "u_tabpg_inventory_control_breakout")
_parentSheet.OpenUserObject(_combineCommandView, "u_tabpg_inventory_control_combine")
_parentSheet.OpenUserObject(_transferCommandView, "u_tabpg_inventory_control_transfer")
_parentSheet.OpenUserObject(_relabelCommandView, "u_tabpg_inventory_control_relabel")
_lrQuickFindCommandDetails.uo_2.AddPanelControl(_quickFindView)
_hdInventory.uo_1.AddPanelControl(_breakoutCommandView)
_hdInventory.uo_1.AddPanelControl(_combineCommandView)
_hdInventory.uo_1.AddPanelControl(_transferCommandView)
_hdInventory.uo_1.AddPanelControl(_relabelCommandView)

MasterListControl = _objectsView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _objectsView.Refresh()

end function

public function integer partfilter ();
//	Set part filter.
_qFilterMode = QF_PART

_lrQuickFindCommandDetails.uo_2.ShowControl(_quickFindView)

return _quickFindView.ShowPartFilter()

end function

public function integer locationfilter ();
//	Set location filter.
_qFilterMode = QF_LOCATION

_lrQuickFindCommandDetails.uo_2.ShowControl(_quickFindView)

return _quickFindView.ShowLocationFilter()

end function

public function integer palletfilter ();
//	Set location filter.
_qFilterMode = QF_PALLET

_lrQuickFindCommandDetails.uo_2.ShowControl(_quickFindView)

return _quickFindView.ShowPalletFilter()

end function

public function integer serialfilter ();return NO_ACTION

end function

public function integer nofilter ();
//	Set location filter.
_qFilterMode = QF_ShowAll

_lrQuickFindCommandDetails.uo_2.ShowControl(_quickFindView)
_quickFindView.ShowAll()

return _objectsView.ShowAll()

end function

public function integer setpartfilter (string partlist);
return _objectsView.SetPartFilter(partList)

end function

public function integer starttransfer ();
//	Show transfer screen.
_inprocessCommand = IC_TRANSFER

_hdInventory.uo_1.ShowControl(_transferCommandView)
_transferCommandView.SetTransferObjectList(_selectedSerials)

return _transferCommandView.SetOperator(_trans.GetUser())

end function

public function integer setlocationfilter (string locationlist);
return _objectsView.SetLocationFilter(locationList)

end function

public function integer setpalletfilter (long palletserial);
return _objectsView.SetPalletFilter(palletSerial)

end function

public function integer setselectedobjects (long selectedserials[]);
_selectedSerials = selectedSerials

choose case _inprocessCommand
	case IC_TRANSFER
		_transferCommandView.SetTransferObjectList(_selectedSerials)
	case IC_BREAKOUT
		_breakoutCommandView.SetBreakoutObjectList(_selectedSerials)
	case IC_COMBINE
		_combineCommandView.SetCombineObjectList(_selectedSerials)
	case IC_RELABEL
		_relabelCommandView.SetRelabelObjectList(_selectedSerials)
end choose

return SUCCESS

end function

public function integer endinventorycommand ();
//	Show transfer screen.
_inprocessCommand = IC_NONE

_hdInventory.uo_1.ShowControl(_lrQuickFindCommandDetails)

return Refresh()

end function

public function integer transfer (string seriallist, integer superobjectflag, string location, long palletserial);
if	_trans.TransferObjects(serialList, superObjectFlag, location, palletSerial) = SUCCESS then
	_trans.CommitTrans()
	
	if	superObjectFlag = 0 then
		MsgBox("Serial(s) " + serialList + " transfered to " + location + ".")
	else
		MsgBox("Serial(s) " + serialList + " transfered to pallet " + string(palletSerial) + ".")
	end if
	
	return Refresh()
end if

return FAILURE

end function

public function integer startbreakout ();
//	Show breakout screen.
_inprocessCommand = IC_BREAKOUT

_hdInventory.uo_1.ShowControl(_breakoutCommandView)
_breakoutCommandView.SetBreakoutObjectList(_selectedSerials)

return _breakoutCommandView.SetOperator(_trans.GetUser())

end function

public function integer startcombine ();
//	Show combine screen.
_inprocessCommand = IC_COMBINE

_hdInventory.uo_1.ShowControl(_combineCommandView)
_combineCommandView.SetCombineObjectList(_selectedSerials)

return _combineCommandView.SetOperator(_trans.GetUser())

end function

public function integer startrelabel ();
//	Show relabel screen.
_inprocessCommand = IC_RELABEL

_hdInventory.uo_1.ShowControl(_relabelCommandView)
_relabelCommandView.SetRelabelObjectList(_selectedSerials)

return _relabelCommandView.SetOperator(_trans.GetUser())

end function

public function integer combine (string seriallist, string labelformat);
long combinedSerial
if	_trans.CombineObjects(serialList, combinedSerial) = SUCCESS then
	_trans.CommitTrans()
	
	//	Do label reprint.
	PrintLabel(combinedSerial, labelFormat)
	
	MsgBox("Serials " + serialList + " combined to serial " + string(combinedSerial) + ".")

	return Refresh()
end if

return FAILURE

end function

public function integer printlabel (long serial, string labelformat);
//	Print Label.
if	labelFormat > "" then
	n_cst_associative_array	printerParm
	printerParm.of_SetItem ("Arg1", serial)
	printerParm.of_SetItem ("Report", "Label")
	printerParm.of_SetItem ("Name", labelFormat)
	return Print(printerParm)
end if

return FAILURE

end function

public function integer relabel (long serials[], string labelformat);
//	Print labels.
int i, count
count = UpperBound(serials)
for	i = 1 to count
	PrintLabel(serials[i], labelFormat)
next

return Refresh()


end function

public function integer breakout (long serials[], decimal qtyperobject, string unit, string packagetype, integer objectcount, string labelformat);
int originalDeleted
long fromSerial
long firstNewSerial

int i, count
count = UpperBound(serials)
for	i = 1 to count

	if	_trans.BreakoutObjects(serials[i], qtyPerObject, unit, packageType, objectCount, firstNewSerial, originalDeleted) = SUCCESS then
		_trans.CommitTrans()
		
		int j
		for	j = 0 to objectCount - 1
			PrintLabel(firstNewSerial + j, labelFormat)
		next
		
		if	originalDeleted = 0 then
			PrintLabel(serials[i], labelFormat)
		end if
		
		MsgBox(string(objectCount) + " object(s) broken out from serial " + String(serials[i]) + ".")
	else
		return FAILURE
	end if
next

return Refresh()

end function

on n_inventory_control_controller.create
call super::create
end on

on n_inventory_control_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_inventory_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


$PBExportHeader$n_receiving_passthrough_controller.sru
forward
global type n_receiving_passthrough_controller from n_cst_virtual_controller
end type
end forward

global type n_receiving_passthrough_controller from n_cst_virtual_controller
end type
global n_receiving_passthrough_controller n_receiving_passthrough_controller

type variables

private:

//	View references.
u_tabpg_receiving_passthrough_parts _partsView

w_receiving_passthrough _parentSheet

//	Model data.
long _receiverID

//	Data context.
n_receiving_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer printlabels (long wodid, long newlabelcount, string boxlabelformat)
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
_parentSheet.OpenUserObject(_partsView, "u_tabpg_receiving_passthrough_parts")
_parentSheet.uo_1.AddPanelControl(_partsView)
MasterListControl = _partsView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _partsView.SetReceiverID(_receiverID)

end function

public function integer printlabels (long wodid, long newlabelcount, string boxlabelformat);
if	not IsValid(_trans) then return FAILURE

long firstNewSerial
if	_trans.NewPreObjects(wodid, newLabelCount, firstNewSerial) <> SUCCESS then
	return FAILURE
end if
_trans.CommitTrans()

long boxSerialNumber
for	boxSerialNumber = firstNewSerial to firstNewSerial + newLabelCount - 1
	//Open pre-objects
	_trans.OpenPreObject (boxSerialNumber)
	
	//Print Labels
	n_cst_associative_array	printerParm
	printerParm.of_SetItem ( "Arg1", boxSerialNumber)
	printerParm.of_SetItem ( "Report", "Label" )
	printerParm.of_SetItem ( "Name", boxLabelFormat )
	Print(printerParm)
	
	//Close pre-objects
	_trans.ClosePreObject (boxSerialNumber)
next

return Refresh()

end function

on n_receiving_passthrough_controller.create
call super::create
end on

on n_receiving_passthrough_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_receiverID = Message.DoubleParm

_trans = create n_receiving_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


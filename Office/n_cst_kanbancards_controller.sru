HA$PBExportHeader$n_cst_kanbancards_controller.sru
forward
global type n_cst_kanbancards_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_kanbancards_controller from n_cst_virtual_controller
end type
global n_cst_kanbancards_controller n_cst_kanbancards_controller

type variables

private:
//	Constants.
constant int KANBAN_TYPE_RPL = 1
constant int KANBAN_TYPE_MFG = 2

//	Model data.
string _kanbanNumber

//	View references.
u_panel_headerdetail _kanbanHeaderDetailPanel
u_tabpg_kanbancards_kanbans _kanbanCardsView
u_tabpg_kanbancards_contents _kanbanContentsView
u_fxdw_kanbancards_newmfgcards_edit _newMfgCardsView
u_fxdw_kanbancards_newrplcards_edit _newRplCardsView
u_fxdw_kanbancontents_movetarget_edit _moveTargetView

w_kanbancards _parentSheet

//	Data context.
n_cst_kanbancardstrans _kanbanCardsTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer getframecontroller ()
public function integer createlayout ()
public function integer newmfgkanbancards ()
public function integer cancelnewmfgkanbancards ()
public function integer createnewmfgkanbancards (string toppart, string firstpart, string lastpart, integer newcardcount)
public function integer printmfgkanbanlabel (long kanbanserial)
public function integer newrplkanbancards ()
public function integer createnewrplkanbancards (string componentpart, decimal kanbanqty, integer newcardcount)
public function integer printrplkanbanlabel (long kanbanserial)
public function integer printkanbanlabel (long kanbanserial, integer kanbantype)
public function integer setkanbannumber (string kanbannumber)
public function integer deletekanbanbins (string kanbanbinlist)
public function integer scrapkanbancontents (string objectlist)
public function integer showmovekanbancontents (string objectlist)
public function integer cancelmovekanbancontents ()
public function integer movekanbancontents (string objectlist, string newkanbannumber)
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

public function integer getframecontroller ();
//	Get the controller for this control's window.
w_master myFrameWindow
myFrameWindow = gnv_App.of_GetFrame()
if	not IsValid(myFrameWindow) or IsNull(myFrameWindow) then return FAILURE

_frameController = myFrameWindow.Container.of_GetItem("Controller")

return SUCCESS

end function

public function integer createlayout ();
//	Kanban Header Detail.
_parentSheet.OpenUserObject(_kanbanHeaderDetailPanel, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_kanbanHeaderDetailPanel)
MainControl = _kanbanHeaderDetailPanel

//	Kanban card list:
_parentSheet.OpenUserObject(_kanbanCardsView, "u_tabpg_kanbancards_kanbans")
_kanbanHeaderDetailPanel.uo_1.AddPanelControl(_kanbanCardsView)
MasterListControl = _kanbanCardsView

//	Kanban contents view:
_parentSheet.OpenUserObject(_kanbanContentsView, "u_tabpg_kanbancards_contents")
_kanbanHeaderDetailPanel.uo_2.AddPanelControl(_kanbanContentsView)

//	Move contents view:
_parentSheet.OpenUserObject(_moveTargetView, "u_fxdw_kanbancontents_movetarget_edit")
_kanbanHeaderDetailPanel.uo_2.AddPanelControl(_moveTargetView)

//	New manufacturing Kanban cards:
_parentSheet.OpenUserObject(_newMfgCardsView, "u_fxdw_kanbancards_newmfgcards_edit")
_parentSheet.uo_1.AddPanelControl(_newMfgCardsView)

//	New replenishment Kanban cards:
_parentSheet.OpenUserObject(_newRplCardsView, "u_fxdw_kanbancards_newrplcards_edit")
_parentSheet.uo_1.AddPanelControl(_newRplCardsView)

//	Show controls.
_parentSheet.uo_1.ShowControl(_kanbanHeaderDetailPanel)
_kanbanHeaderDetailPanel.uo_1.ShowControl(_kanbanCardsView)
_kanbanHeaderDetailPanel.uo_2.ShowControl(_kanbanContentsView)

return SUCCESS

end function

public function integer newmfgkanbancards ();
if	not isValid(_parentSheet) or not isValid(_newMfgCardsView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_newMfgCardsView)
_newMfgCardsView.Refresh()
return SUCCESS

end function

public function integer cancelnewmfgkanbancards ();
if	not isValid(_parentSheet) or not isValid(_kanbanHeaderDetailPanel) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_kanbanHeaderDetailPanel)
return SUCCESS

end function

public function integer createnewmfgkanbancards (string toppart, string firstpart, string lastpart, integer newcardcount);
if	not isValid(_parentSheet) or not isValid(_kanbanHeaderDetailPanel) or not isValid(_kanbanCardsTrans) then
	return FAILURE
end if

long	firstNewKanbanSerial
if	_kanbanCardsTrans.NewMfgKanbanCards(topPart, firstPart, lastPart, newCardCount, firstNewKanbanSerial) = SUCCESS then
	_kanbanCardsTrans.CommitTrans()
	//	Loop through new Kanbans and print Kanban label.
	long kanbanSerial
	for kanbanSerial = firstNewKanbanSerial to firstNewKanbanSerial + newCardCount - 1
		PrintMfgKanbanLabel(kanbanSerial)
	next
else
	_kanbanCardsTrans.RollbackTrans()
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_kanbanHeaderDetailPanel)
return SUCCESS

end function

public function integer printmfgkanbanlabel (long kanbanserial);
string kanbanLabelFormat = "Mfg Kanban Card"
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", kanbanSerial)
printerParm.of_SetItem ( "Report", "Label" )
printerParm.of_SetItem ( "Name", kanbanLabelFormat )
return Print(printerParm)

end function

public function integer newrplkanbancards ();
if	not isValid(_parentSheet) or not isValid(_newRplCardsView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_newRplCardsView)
_newRplCardsView.Refresh()
return SUCCESS

end function

public function integer createnewrplkanbancards (string componentpart, decimal kanbanqty, integer newcardcount);
if	not isValid(_parentSheet) or not isValid(_kanbanHeaderDetailPanel) or not isValid(_kanbanCardsTrans) then
	return FAILURE
end if

long	firstNewKanbanSerial
if	_kanbanCardsTrans.NewRplKanbanCards(componentPart, kanbanQty, newCardCount, firstNewKanbanSerial) = SUCCESS then
	_kanbanCardsTrans.CommitTrans()
	//	Loop through new Kanbans and print Kanban label.
	long kanbanSerial
	for kanbanSerial = firstNewKanbanSerial to firstNewKanbanSerial + newCardCount - 1
		PrintRplKanbanLabel(kanbanSerial)
	next
else
	_kanbanCardsTrans.RollbackTrans()
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_kanbanHeaderDetailPanel)
return NO_ACTION

end function

public function integer printrplkanbanlabel (long kanbanserial);
string kanbanLabelFormat = "Rpl Kanban Card"
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", kanbanSerial)
printerParm.of_SetItem ( "Report", "Label" )
printerParm.of_SetItem ( "Name", kanbanLabelFormat )
return Print(printerParm)

end function

public function integer printkanbanlabel (long kanbanserial, integer kanbantype);
choose case kanbanType
	case KANBAN_TYPE_RPL
		return PrintRplKanbanLabel(kanbanSerial)
	case KANBAN_TYPE_MFG
		return PrintMfgKanbanLabel(kanbanSerial)
end choose

return NO_ACTION


end function

public function integer setkanbannumber (string kanbannumber);
_kanbanNumber = kanbanNumber
return _kanbanContentsView.SetKanbanNumber(_kanbanNumber)


end function

public function integer deletekanbanbins (string kanbanbinlist);
long	firstNewKanbanSerial
if	_kanbanCardsTrans.DeleteKanbanList(kanbanbinlist) = SUCCESS then
	_kanbanCardsTrans.CommitTrans()
else
	_kanbanCardsTrans.RollbackTrans()
	return FAILURE
end if

return Refresh()


end function

public function integer scrapkanbancontents (string objectlist);
long	firstNewKanbanSerial
if	_kanbanCardsTrans.ScrapObjectList(objectList) = SUCCESS then
	_kanbanCardsTrans.CommitTrans()
else
	_kanbanCardsTrans.RollbackTrans()
	return FAILURE
end if

return Refresh()

end function

public function integer showmovekanbancontents (string objectlist);
if	not isValid(_parentSheet) or not isValid(_moveTargetView) then
	return FAILURE
end if

_moveTargetView.SetObjectList(objectList)
_kanbanHeaderDetailPanel.uo_2.ShowControl(_moveTargetView)
return SUCCESS

end function

public function integer cancelmovekanbancontents ();
if	not isValid(_kanbanContentsView) or not isValid(_kanbanContentsView) then
	return FAILURE
end if

_kanbanHeaderDetailPanel.uo_2.ShowControl(_kanbanContentsView)
return SUCCESS

end function

public function integer movekanbancontents (string objectlist, string newkanbannumber);
if	not isValid(_kanbanCardsTrans) then return FAILURE

if	_kanbanCardsTrans.MoveObjectListToKanban(objectList, newKanbanNumber) = SUCCESS then
	_kanbanCardsTrans.CommitTrans()
else
	_kanbanCardsTrans.RollbackTrans()
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_kanbanHeaderDetailPanel)
CancelMoveKanbanContents()
return Refresh()

end function

on n_cst_kanbancards_controller.create
call super::create
end on

on n_cst_kanbancards_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_kanbanCardsTrans = create n_cst_kanbancardstrans

end event

event destructor;call super::destructor;
destroy _kanbanCardsTrans

end event


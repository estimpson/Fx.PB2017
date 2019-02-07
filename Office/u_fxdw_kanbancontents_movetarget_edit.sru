HA$PBExportHeader$u_fxdw_kanbancontents_movetarget_edit.sru
forward
global type u_fxdw_kanbancontents_movetarget_edit from u_fxdw
end type
end forward

global type u_fxdw_kanbancontents_movetarget_edit from u_fxdw
integer width = 1902
integer height = 748
string dataobject = "d_kanban_kanbanmovetarget_edit"
boolean vscrollbar = false
end type
global u_fxdw_kanbancontents_movetarget_edit u_fxdw_kanbancontents_movetarget_edit

type variables

//	Model data.
private string _objectList

private n_cst_kanbancards_controller _myController

end variables

forward prototypes
public function integer setobjectlist (string objectlist)
end prototypes

public function integer setobjectlist (string objectlist);
_objectList = objectList

return Refresh()

end function

on u_fxdw_kanbancontents_movetarget_edit.create
call super::create
end on

on u_fxdw_kanbancontents_movetarget_edit.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

string groupName
choose case dwo.Name
	case "p_ok"
		//	Save new kanban cards.
		AcceptText()
		
		string	newKanbanNumber
		string objectList

		newKanbanNumber = object.MoveToKanbanNumber[row]
		objectList = object.ObjectList[row]

		return _myController.MoveKanbanContents(objectList, newKanbanNumber)
	case "p_cancel"
		Reset()
		return _myController.CancelMoveKanbanContents()
end choose

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_objectList)

end event

event retrieveend;call super::retrieveend;
if	rowcount = 0 then return InsertRow(0)

string partCode
partCode = object.PartCode[1]

datawindowchild dwcKanbanList
if	GetChild("MoveToKanbanNumber", dwcKanbanList) = 1 then
	dwcKanbanList.SetTransObject(SQLCA)
	if	dwcKanbanList.Retrieve(partCode) = 0 then
		dwcKanbanList.InsertRow(0)
	end if
end if

end event


$PBExportHeader$u_fxdw_kanbancards_newrplcards_edit.sru
forward
global type u_fxdw_kanbancards_newrplcards_edit from u_fxdw
end type
end forward

global type u_fxdw_kanbancards_newrplcards_edit from u_fxdw
integer width = 2043
integer height = 620
string dataobject = "d_newrplkanbancards_edit"
boolean vscrollbar = false
boolean livescroll = false
end type
global u_fxdw_kanbancards_newrplcards_edit u_fxdw_kanbancards_newrplcards_edit

type variables

private n_cst_kanbancards_controller _myController

end variables

on u_fxdw_kanbancards_newrplcards_edit.create
call super::create
end on

on u_fxdw_kanbancards_newrplcards_edit.destroy
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

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

string groupName
choose case dwo.Name
	case "p_ok"
		//	Save new kanban cards.
		AcceptText()
		
		string	componentPart
		decimal kanbanQty
		int newCardCount
		
		componentPart = object.ComponentPart[row]
		kanbanQty = object.KanbanQty[row]
		newCardCount = object.NewCardCount[row]
		return _myController.CreateNewRplKanbanCards(componentPart, kanbanQty, newCardCount)
	case "p_cancel"
		Reset()
		return _myController.CancelNewMfgKanbanCards()
end choose

end event

event itemchanged;call super::itemchanged;
datawindowchild dropDown

choose case lower(dwo.name)
	case lower("TopPart")
		if	GetChild("FirstPart", dropDown) = SUCCESS then
			dropDown.SetTransObject(SQLCA)
			dropDown.Retrieve(data)
		end if

		if	GetChild("LastPart", dropDown) = SUCCESS then
			dropDown.SetTransObject(SQLCA)
			dropDown.Retrieve(data)
		end if
end choose

end event


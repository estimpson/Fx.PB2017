$PBExportHeader$u_fxdw_wireharnessinquiry_newharnesses.sru
forward
global type u_fxdw_wireharnessinquiry_newharnesses from u_fxdw
end type
end forward

global type u_fxdw_wireharnessinquiry_newharnesses from u_fxdw
integer width = 1902
integer height = 816
string dataobject = "d_wireharness_newharnesssetup"
end type
global u_fxdw_wireharnessinquiry_newharnesses u_fxdw_wireharnessinquiry_newharnesses

type variables

private:

//	Controller reference:
n_wireharnessinquiry_controller _myController

//	Model data:
string _wireHarnessPart, _initialPart
long _numberOfLabels


end variables
on u_fxdw_wireharnessinquiry_newharnesses.create
call super::create
end on

on u_fxdw_wireharnessinquiry_newharnesses.destroy
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
datawindowchild dddw
if	GetChild("InitialPartCode", dddw) = SUCCESS then
	dddw.SetTransObject(SQLCA)
	if	dddw.Retrieve(_wireHarnessPart) <= 0 then
		dddw.InsertRow(0)
	end if
end if
	
if	Retrieve(IsNull(_wireHarnessPart, ""), IsNull(_initialPart, ""), IsNull(_numberOfLabels, -1)) > 0 then
	_wireHarnessPart = object.WireHarnessPartCode[1]
	_initialPart = object.InitialPartCode[1]
	_numberOfLabels = object.NumberOfLabels[1]
end if

return RowCount()

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.Name)
	case lower("WireHarnessPartCode")
		_wireHarnessPart = data
	case lower("InitialPartCode")
		_initialPart = data
	case lower("NumberOfLabels")
		_numberOfLabels = long(data)
end choose

post Refresh()

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

string groupName
choose case dwo.Name
	case "p_ok"
		//	Save new kanban cards.
		AcceptText()
		
		return _myController.CreateNewHarnesses(_wireHarnessPart, _initialPart, _numberOfLabels)
	case "p_cancel"
		SetNull(_wireHarnessPart)
		SetNull(_initialPart)
		SetNull(_numberOfLabels)

		Reset()
		return _myController.CancelNewHarnesses()
end choose

end event


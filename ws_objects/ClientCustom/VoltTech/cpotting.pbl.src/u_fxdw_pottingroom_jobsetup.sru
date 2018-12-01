$PBExportHeader$u_fxdw_pottingroom_jobsetup.sru
forward
global type u_fxdw_pottingroom_jobsetup from u_fxdw
end type
end forward

global type u_fxdw_pottingroom_jobsetup from u_fxdw
integer width = 2665
integer height = 1652
string dataobject = "d_pottingroom_jobsetup"
end type
global u_fxdw_pottingroom_jobsetup u_fxdw_pottingroom_jobsetup

type variables

private:
//	Controller reference.
n_pottingroom_controller _myController

//	Model data.
constant int NONE = 0, OPERATOR = 1, MATERIALHANDLER = 2
string _pottingRoomMachineCode, _pottingRoomOperator, _pottingRoomMaterialHandler
string _kanbanNumber
int	_activeOperatorInput = NONE

end variables
forward prototypes
public function integer setpottingroomoperator (string code)
public function integer setpottingroommaterialhandler (string code)
public function integer setkanbannumber (string kanbannumber)
public function integer setactiveoperatorinput (integer activeoperatorinput)
public function integer getjobsetupdetails (ref long resinserial, ref long hardenerserial)
public function integer setpottingroommachine (string code)
end prototypes

public function integer setpottingroomoperator (string code);
_pottingRoomOperator = code
Refresh()

//	Validate operator for potting room operator.
string operatorName
operatorName = Object.PottingRoomOperatorName[1]
if	operatorName > "" then
	return SUCCESS
end if
return FAILURE

end function

public function integer setpottingroommaterialhandler (string code);
_pottingRoomMaterialHandler = code
Refresh()

//	Validate operator for potting room material handler.
string operatorName
operatorName = Object.PottingRoomMaterialHandlerOperatorName[1]
if	operatorName > "" then
	return SUCCESS
end if
return FAILURE

end function

public function integer setkanbannumber (string kanbannumber);
_kanbanNumber = kanbanNumber
return Refresh()

end function

public function integer setactiveoperatorinput (integer activeoperatorinput);
_activeOperatorInput = activeOperatorInput
return Refresh()

end function

public function integer getjobsetupdetails (ref long resinserial, ref long hardenerserial);
if	RowCount() < 1 then
	return FAILURE
end if

resinSerial = object.ResinSerial[1]
hardenerSerial = object.HardenerSerial[1]

return SUCCESS

end function

public function integer setpottingroommachine (string code);
_pottingRoomMachineCode = code
Refresh()

//	Validate machine code for potting room.
string machineCode
machineCode = Object.PottingRoomMachineCode[1]
if	machineCode > "" then
	return SUCCESS
end if
return FAILURE

end function

on u_fxdw_pottingroom_jobsetup.create
call super::create
end on

on u_fxdw_pottingroom_jobsetup.destroy
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
return Retrieve(_pottingRoomMachineCode, _pottingRoomOperator, _pottingRoomMaterialHandler, _kanbanNumber, _activeOperatorInput)

end event


$PBExportHeader$u_fxdw_electricaltester_jobsetup.sru
forward
global type u_fxdw_electricaltester_jobsetup from u_fxdw
end type
end forward

global type u_fxdw_electricaltester_jobsetup from u_fxdw
integer width = 2427
integer height = 1112
string dataobject = "d_electricaltester_jobsetup"
end type
global u_fxdw_electricaltester_jobsetup u_fxdw_electricaltester_jobsetup

type variables

private:
//	Controller reference.
n_electricaltester_controller _myController

//	Model data.
string _electricalTesterMachine
string _electricalTesterOperator
long _boxSerial

end variables

forward prototypes
public function integer setoperator (string code)
public function integer setboxserial (long boxserial)
public function integer setelectricaltestermachine (string code)
end prototypes

public function integer setoperator (string code);
_electricalTesterOperator = code
Refresh()

//	Validate operator for electrical tester operator.
string operatorName
operatorName = Object.ElectricalTesterOperatorName[1]
if	operatorName > "" then
	return SUCCESS
end if
return FAILURE

end function

public function integer setboxserial (long boxserial);
_boxSerial = boxSerial
return Refresh()

end function

public function integer setelectricaltestermachine (string code);
_electricalTesterMachine = code
Refresh()

//	Validate operator for leak tester operator.
_electricalTesterMachine = Object.ElectricalTesterMachineCode[1]
if	_electricalTesterMachine > "" then
	return SUCCESS
end if
return FAILURE

end function

on u_fxdw_electricaltester_jobsetup.create
call super::create
end on

on u_fxdw_electricaltester_jobsetup.destroy
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
return Retrieve(_electricalTesterMachine, _electricalTesterOperator, _boxSerial)

end event


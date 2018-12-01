$PBExportHeader$u_fxdw_leaktester_jobsetup.sru
forward
global type u_fxdw_leaktester_jobsetup from u_fxdw
end type
end forward

global type u_fxdw_leaktester_jobsetup from u_fxdw
integer width = 2427
integer height = 1199
string dataobject = "d_leaktester_jobsetup"
end type
global u_fxdw_leaktester_jobsetup u_fxdw_leaktester_jobsetup

type variables

private:
//	Controller reference.
n_leaktester_controller _myController

//	Model data.
string _leakTesterMachine, _electricalTesterMachine
string _leakTesterOperator
string _kanbanNumber

end variables
forward prototypes
public function integer setoperator (string code)
public function integer setkanbannumber (string kanbannumber)
public function integer setleaktestermachine (string machine)
public function integer setelectricaltestermachine (string code)
end prototypes

public function integer setoperator (string code);
_leakTesterOperator = code
Refresh()

//	Validate operator for leak tester operator.
string operatorName
operatorName = Object.LeakTesterOperatorName[1]
if	operatorName > "" then
	return SUCCESS
end if
return FAILURE

end function

public function integer setkanbannumber (string kanbannumber);
_kanbanNumber = kanbanNumber
return Refresh()

end function

public function integer setleaktestermachine (string machine);
_leakTesterMachine = machine
Refresh()

//	Validate operator for leak tester operator.
_leakTesterMachine = Object.LeakTesterMachineCode[1]
if	_leakTesterMachine > "" then
	return SUCCESS
end if
return FAILURE

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

on u_fxdw_leaktester_jobsetup.create
call super::create
end on

on u_fxdw_leaktester_jobsetup.destroy
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
return Retrieve(_leakTesterMachine, _leakTesterOperator, _kanbanNumber, _electricalTesterMachine)

end event


$PBExportHeader$u_fxdw_inventory_control_commands.sru
forward
global type u_fxdw_inventory_control_commands from u_fxdw
end type
end forward

global type u_fxdw_inventory_control_commands from u_fxdw
integer width = 809
integer height = 1572
string dataobject = "d_inventory_control_commands"
boolean vscrollbar = false
end type
global u_fxdw_inventory_control_commands u_fxdw_inventory_control_commands

type variables

Private:
//	Controller reference.
n_inventory_control_controller _myController

end variables

on u_fxdw_inventory_control_commands.create
call super::create
end on

on u_fxdw_inventory_control_commands.destroy
call super::destroy
end on

event dwmousemove;call super::dwmousemove;
setrow(row)

end event

event clicked;call super::clicked;
if	row <= 0 then return

string command
command = object.ActiveCommand[row]
choose case Upper(command)
	case "TRANSFER"
		_myController.StartTransfer()
	case "BREAKOUT"
		_myController.StartBreakout()
	case "COMBINE"
		_myController.StartCombine()
	case "RELABEL"
		_myController.StartRelabel()
end choose

end event

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event


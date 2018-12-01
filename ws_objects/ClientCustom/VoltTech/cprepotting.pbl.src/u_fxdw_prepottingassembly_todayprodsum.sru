$PBExportHeader$u_fxdw_prepottingassembly_todayprodsum.sru
forward
global type u_fxdw_prepottingassembly_todayprodsum from u_fxdw
end type
end forward

global type u_fxdw_prepottingassembly_todayprodsum from u_fxdw
integer width = 1874
integer height = 404
string dataobject = "d_prepottingassembly_todayproductionsum"
boolean vscrollbar = false
boolean livescroll = false
end type
global u_fxdw_prepottingassembly_todayprodsum u_fxdw_prepottingassembly_todayprodsum

type variables

private:

//	Controller reference:
n_prepottingassembly_controller _myController

//	Model data:
string _operatorCode, _partCode

end variables

forward prototypes
public function integer setoperatorcode (string operatorcode)
public function integer setproductionpart (string partcode)
end prototypes

public function integer setoperatorcode (string operatorcode);
if	IsNull(operatorCode) then
	return FAILURE
end if

_operatorCode = operatorCode
return Refresh()

end function

public function integer setproductionpart (string partcode);
if	IsNull(partCode) then
	return FAILURE
end if

_partCode = partCode
return Refresh()

end function

on u_fxdw_prepottingassembly_todayprodsum.create
call super::create
end on

on u_fxdw_prepottingassembly_todayprodsum.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

insertRow(0)
end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_operatorCode, _partCode)

end event


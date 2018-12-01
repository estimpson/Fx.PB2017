$PBExportHeader$u_fxdw_prepottingassembly_kanbaninfo.sru
forward
global type u_fxdw_prepottingassembly_kanbaninfo from u_fxdw
end type
end forward

global type u_fxdw_prepottingassembly_kanbaninfo from u_fxdw
integer width = 1874
integer height = 920
string dataobject = "d_prepottingassembly_kanbaninfo"
end type
global u_fxdw_prepottingassembly_kanbaninfo u_fxdw_prepottingassembly_kanbaninfo

type variables

private:

//	Controller reference:
n_prepottingassembly_controller _myController

//	Model data:
string _kanbanNumber

end variables

forward prototypes
public function integer setkanbannumber (string kanbannumber)
end prototypes

public function integer setkanbannumber (string kanbannumber);
if	IsNull(kanbanNumber) then
	return FAILURE
end if

_kanbanNumber = kanbanNumber
return Refresh()

end function

on u_fxdw_prepottingassembly_kanbaninfo.create
call super::create
end on

on u_fxdw_prepottingassembly_kanbaninfo.destroy
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
return Retrieve(_kanbanNumber)

end event


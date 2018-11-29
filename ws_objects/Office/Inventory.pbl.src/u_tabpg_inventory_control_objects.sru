$PBExportHeader$u_tabpg_inventory_control_objects.sru
forward
global type u_tabpg_inventory_control_objects from u_tabpg_dw
end type
end forward

global type u_tabpg_inventory_control_objects from u_tabpg_dw
integer width = 2309
end type
global u_tabpg_inventory_control_objects u_tabpg_inventory_control_objects

type variables

Private:
//	Controller reference.
n_inventory_control_controller _myController

end variables

forward prototypes
public function integer setpartfilter (string partlist)
public function integer setlocationfilter (string locationlist)
public function integer setpalletfilter (long palletserial)
public function integer clearfilter ()
public function integer showall ()
end prototypes

public function integer setpartfilter (string partlist);
ClearFilter()
return dw_1.PowerFilter.of_buildfilter("Part in (" + partList + ")", 2)

end function

public function integer setlocationfilter (string locationlist);
ClearFilter()
return dw_1.PowerFilter.of_buildfilter("Location in (" + locationList + ")", 5)

end function

public function integer setpalletfilter (long palletserial);
ClearFilter()
return dw_1.PowerFilter.of_buildfilter("PalletSerial in (" + String(palletSerial) + ")", 10)

end function

public function integer clearfilter ();
string emptyFilters[32]
int cols[32]

int i
for	i = 1 to 32
	cols[i] = i
next

dw_1.PowerFilter.BuildFilters(emptyFilters, cols, false)

return SUCCESS

end function

public function integer showall ();
string emptyFilters[32]
int cols[32]

int i
for	i = 1 to 32
	cols[i] = i
next

dw_1.PowerFilter.BuildFilters(emptyFilters, cols, true)

return SUCCESS

end function

on u_tabpg_inventory_control_objects.create
call super::create
end on

on u_tabpg_inventory_control_objects.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_control_objects
string text = "Inventory"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_control_objects
string dataobject = "d_inventory_control_objectlist"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::selectionchanged;call super::selectionchanged;
if	not IsValid(_myController) then return

long row, rows, serialList[]
int serials = 0
rows = RowCount()
for	row = 1 to rows
	if	dw_1.Object.IsSelected[row] = 1 then
		serials ++
		serialList[serials] = dw_1.Object.Serial[row]
	end if
next

_myController.SetSelectedObjects(serialLIst)

end event


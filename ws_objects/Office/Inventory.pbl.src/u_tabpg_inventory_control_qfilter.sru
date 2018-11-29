$PBExportHeader$u_tabpg_inventory_control_qfilter.sru
forward
global type u_tabpg_inventory_control_qfilter from u_tabpg_dw
end type
end forward

global type u_tabpg_inventory_control_qfilter from u_tabpg_dw
integer width = 2309
end type
global u_tabpg_inventory_control_qfilter u_tabpg_inventory_control_qfilter

type variables

Private:
//	State management.
int _qFilterMode
constant int QF_ShowAll = 0
constant int QF_Serial = 1
constant int QF_Part = 2
constant int QF_Location = 3
constant int QF_Pallet = 4

//	Controller reference.
n_inventory_control_controller _myController

end variables

forward prototypes
public function integer showpartfilter ()
public function integer showlocationfilter ()
public function integer showpalletfilter ()
public function integer showall ()
end prototypes

public function integer showpartfilter ();
dw_1.dataobject = "d_inventory_control_partinventorylist"
dw_1.SetTransObject(SQLCA)
_qFilterMode = QF_Part

return Refresh()

end function

public function integer showlocationfilter ();
dw_1.dataobject = "d_inventory_control_locatioinventorylist"
dw_1.SetTransObject(SQLCA)
_qFilterMode = QF_Location

return Refresh()

end function

public function integer showpalletfilter ();
dw_1.dataobject = "d_inventory_control_palletinventorylist"
dw_1.SetTransObject(SQLCA)
_qFilterMode = QF_Pallet

return Refresh()

end function

public function integer showall ();
dw_1.dataobject = ""
_qFilterMode = QF_SHOWALL

return SUCCESS


end function

on u_tabpg_inventory_control_qfilter.create
call super::create
end on

on u_tabpg_inventory_control_qfilter.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_control_qfilter
string text = "QFilter"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_control_qfilter
string dataobject = "{d_list}"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::activerowchanged;call super::activerowchanged;
if	activerow <= 0 then return
if	not IsValid(_myController) then return

choose case _qFilterMode
	case QF_Part
		_myController.SetPartFilter("~"" + object.Part[activerow] + "~"")
	case QF_Location
		_myController.SetLocationFilter("~"" + object.Location[activerow] + "~"")
	case QF_Pallet
		_myController.SetPalletFilter(object.PalletSerial[activerow])
end choose

end event


$PBExportHeader$u_fxdw_container_edittrackinginfo.sru
forward
global type u_fxdw_container_edittrackinginfo from u_fxdw
end type
end forward

global type u_fxdw_container_edittrackinginfo from u_fxdw
integer width = 1915
integer height = 1132
string dataobject = "d_cntmgr_departuretrackinginfo"
end type
global u_fxdw_container_edittrackinginfo u_fxdw_container_edittrackinginfo

type variables

Private:
//	Controller reference.
n_cntmgr_master_controller _myController

//	Model data.
string _aetcNumber, _proNumber, _truckNumber, _sealNumber

end variables

on u_fxdw_container_edittrackinginfo.create
call super::create
end on

on u_fxdw_container_edittrackinginfo.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

//	Set transobject.
of_SetTransObject(SQLCA)

post event pfc_retrieve()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_aetcNumber, _proNumber, _truckNumber, _sealNumber)

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.name)
	case lower("AETCNumber")
		_aetcNumber = data
	case lower("ProNumber")
		_proNumber = data
	case lower("TruckNumber")
		_truckNumber = data
	case lower("SealNumber")
		_sealNumber = data
end choose

post event pfc_retrieve()
post SetColumn(GetColumn())

end event

event clicked;call super::clicked;
if	not IsValid(_myController) then
	return FAILURE
end if

choose case lower(dwo.Name)
	case lower("p_ok")
		_myController.CompleteShipout(_aetcNumber, _proNumber, _truckNumber, _sealNumber)
	case lower("p_cancel")
		_myController.EndShipout()
end choose

end event


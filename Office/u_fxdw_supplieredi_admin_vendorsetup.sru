HA$PBExportHeader$u_fxdw_supplieredi_admin_vendorsetup.sru
forward
global type u_fxdw_supplieredi_admin_vendorsetup from u_fxdw
end type
end forward

global type u_fxdw_supplieredi_admin_vendorsetup from u_fxdw
integer width = 3017
integer height = 1104
string dataobject = "d_supplieredi_admin_vendorsetup"
end type
global u_fxdw_supplieredi_admin_vendorsetup u_fxdw_supplieredi_admin_vendorsetup

type variables

private:
//	Controller reference.
n_supplieredi_admin_controller _myController

//	Model data.
string _vendorCode

end variables

forward prototypes
public function integer setvendorcode (string vendorcode)
public function integer refresh ()
public function integer save ()
end prototypes

public function integer setvendorcode (string vendorcode);
_vendorCode = vendorCode
return Refresh()

end function

public function integer refresh ();
if	ModifiedCount() > 0 then
	if	msgbox("There are unsaved changes.  Do you wish to continue and revert unsaved changes?", Question!, YesNo!, 2) = 1 then
		return super::Refresh()
	end if
	return PREVENT_ACTION
end if

return super::Refresh()

end function

public function integer save ();
if	not IsValid(_myController) then return FAILURE

string vendorCode
vendorCode = object.vendorsettings_vendorcode[1]

//	Determine if EDI Status is changing.
long oldStatus, newStatus
oldStatus = object.vendorsettings_status.original[1]
newStatus = object.vendorsettings_status.current[1]

//	Save new status
choose case true
	case newStatus = -2
		if	msgbox("If you set the status to 'Undefined' all EDI data associated with this vendor and its POs will be lost.  Are you sure you want to clear this data?", Question!, YesNo!, 2) = 2 then
			return NO_ACTION
		end if
		// do clearing of data.
		_myController.ClearVendor(vendorCode)
	case else
		//	do save of status.
		_myController.SaveVendorEDIStatus(vendorCode, newStatus)
end choose

Reset()
return _myController.Refresh()

end function

on u_fxdw_supplieredi_admin_vendorsetup.create
call super::create
end on

on u_fxdw_supplieredi_admin_vendorsetup.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize (2 * 37 + 2889, 2 * 4 + 1088)
inv_Resize.of_Register ("gb_1", 0, 0, 100, 0)
inv_Resize.of_Register ("compute_1", 0, 0, 100, 0)
inv_Resize.of_Register ("t_1", 50, 0, 0, 0)
inv_Resize.of_Register ("address1", 50, 0, 50, 0)
inv_Resize.of_Register ("address2", 50, 0, 50, 0)
inv_Resize.of_Register ("address3", 50, 0, 50, 0)
inv_Resize.of_Register ("address4", 50, 0, 50, 0)
inv_Resize.of_Register ("address5", 50, 0, 50, 0)
inv_Resize.of_Register ("address6", 50, 0, 50, 0)
inv_Resize.of_Register ("vendorsettings_tradingpartnercode_t", 50, 0, 0, 0)
inv_Resize.of_Register ("vendorsettings_tradingpartnercode", 50, 0, 50, 0)
inv_Resize.of_Register ("t_4", 100, 0, 0, 0)
inv_Resize.of_Register ("t_5", 100, 0, 0, 0)
inv_Resize.of_Register ("p_enabled", 100, 0, 0, 0)
inv_Resize.of_Register ("p_auto", 100, 0, 0, 0)
inv_Resize.of_Register ("p_save", 100, 0, 0, 0)
inv_Resize.of_Register ("p_refresh", 100, 0, 0, 0)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_vendorCode)

end event

event clicked;call super::clicked;
AcceptText()
long	currentStatus
choose case dwo.Name
	case "p_save"
		Save()
	case "p_refresh"
		Refresh()
	case "p_enabled"
		currentStatus = object.vendorsettings_status[1]
		choose case currentStatus
			case 0
				object.vendorsettings_status[1] = 1
			case 1
				object.vendorsettings_status[1] = 2
			case 2
				object.vendorsettings_status[1] = -1
			case -1
				object.vendorsettings_status[1] = 0
			case -2
				object.vendorsettings_status[1] = 1
		end choose
	case "p_auto"
		currentStatus = object.vendorsettings_status[1]
		choose case currentStatus
			case 0
				object.vendorsettings_status[1] = 2
			case 1
				object.vendorsettings_status[1] = 2
			case 2
				object.vendorsettings_status[1] = 1
			case -1
				object.vendorsettings_status[1] = 2
			case -2
				object.vendorsettings_status[1] = 2
		end choose
end choose

end event


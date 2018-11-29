$PBExportHeader$u_fxdw_shipping_departingshippers.sru
forward
global type u_fxdw_shipping_departingshippers from u_fxdw
end type
end forward

global type u_fxdw_shipping_departingshippers from u_fxdw
integer width = 1961
integer height = 1780
string dataobject = "d_shipping_departingshippers"
end type
global u_fxdw_shipping_departingshippers u_fxdw_shipping_departingshippers

type variables

boolean _isEditing

end variables

on u_fxdw_shipping_departingshippers.create
call super::create
end on

on u_fxdw_shipping_departingshippers.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
if	not _isEditing then
	return Retrieve()
else
	return RowCount()
end if


end event

event clicked;call super::clicked;
AcceptText()

//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_cst_shipping_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

string	shipperList
choose case dwo.Name
	case "p_ok"
		string proNumber
		
		shipperList = Object.ShipperNumberList[row]
		proNumber = Object.PRONumber[row]
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Ready to complete shipout of shipper(s): " + shipperList, Question!, YesNo!, 2) = 2 then
			return
		end if
		
		//	Complete departure.
		myController.CompleteShipout(shipperList, proNumber)
		
	case "p_cancel"
		shipperList = Object.ShipperNumberList[row]
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Cancel departure of shipper(s): " + shipperList, Question!, YesNo!, 2) = 2 then
			return
		end if
		
		//	Cancel departure.
		myController.CancelDeparture(shipperList)
	
	case "p_prodetails"
		string truckNumber
		truckNumber = Object.TruckNumber[row]
		myController.EditTruckProNumbers(truckNumber)
		refresh ()
		
	case "p_override"
		shipperList = Object.ShipperNumberList[row]
		if	MessageBox(gnv_App.iapp_Object.DisplayName, "Are you sure that you want to manually override scanning these shipper(s): " + shipperList + " to the truck?  If you proceed, the shipper(s) will be ready to depart without scanning.", Question!, YesNo!, 2) = 2 then
			return
		end if
		
		//	Override scanning.
		myController.ShowBeginOverrideScanning(shipperList)
	
	case "p_print"
		shipperList = Object.ShipperNumberList[row]
		
		//	Print packing slips.
		myController.ReprintPackingSlips(shipperList)
		
end choose

end event

event editchanged;call super::editchanged;
_isEditing = (data > "")

end event

event itemchanged;call super::itemchanged;
_isEditing = false

end event


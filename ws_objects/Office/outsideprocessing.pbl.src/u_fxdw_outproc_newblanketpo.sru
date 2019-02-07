$PBExportHeader$u_fxdw_outproc_newblanketpo.sru
forward
global type u_fxdw_outproc_newblanketpo from u_fxdw
end type
end forward

global type u_fxdw_outproc_newblanketpo from u_fxdw
integer width = 3758
integer height = 1296
string dataobject = "d_outproc_maint_newblanketpo"
end type
global u_fxdw_outproc_newblanketpo u_fxdw_outproc_newblanketpo

type variables

long _opDefRowID

datawindowchild _termsDWC, _shipViaDWC, _freightTypeDWC, _deliveryPlantDWC, _nextPartDWC, _secondarySupplierDWC, _secondaryShipFromDWC
end variables
forward prototypes
public function integer setopdefrowid (long opdefrowid)
end prototypes

public function integer setopdefrowid (long opdefrowid);
_opDefRowID = opDefRowID
return Refresh()

end function

on u_fxdw_outproc_newblanketpo.create
call super::create
end on

on u_fxdw_outproc_newblanketpo.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

if	GetChild("terms", _termsDWC) = SUCCESS then
	_termsDWC.SetTransObject(SQLCA)
end if

if	GetChild("shipvia", _shipViaDWC) = SUCCESS then
	_shipViaDWC.SetTransObject(SQLCA)
end if

if	GetChild("freighttype", _freightTypeDWC) = SUCCESS then
	_freightTypeDWC.SetTransObject(SQLCA)
end if

if	GetChild("deliveryplant", _deliveryPlantDWC) = SUCCESS then
	_deliveryPlantDWC.SetTransObject(SQLCA)
end if

if	GetChild("nextpart", _nextPartDWC) = SUCCESS then
	_nextPartDWC.SetTransObject(SQLCA)
end if

if	GetChild("secondarysuppliercode", _secondarySupplierDWC) = SUCCESS then
	_secondarySupplierDWC.SetTransObject(SQLCA)
end if

if	GetChild("secondaryshipfromcode", _secondaryShipFromDWC) = SUCCESS then
	_secondaryShipFromDWC.SetTransObject(SQLCA)
end if

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_opDefRowID)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_outproc_maint_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		
//		string	confirmedShipper, notes
//		decimal quantity
//		confirmedShipper = Object.ConfirmedShipper[1]
//		quantity = Object.Quantity[1]
//		notes = Object.Notes[1]
//		
//		myController.NewBTBShipment(confirmedShipper, quantity, notes)
		myController.CancelNewBTBShipment()
		Reset()
		
	case "p_cancel"
		Reset()
		
		myController.CancelNewBlanketPO()
end choose

end event

event retrieveend;call super::retrieveend;
if	rowcount <= 0 then return FAILURE
string supplierCode, shipFromCode, blanketPart, secondarySupplierCode

supplierCode = object.SupplierCode[1]
shipFromCode = object.ShipFromCode[1]
blanketPart = object.BlanketPart[1]
secondarySupplierCode = object.secondarySupplierCode[1]

_termsDWC.Retrieve(supplierCode)
_shipViaDWC.Retrieve(shipFromCode)
_freightTypeDWC.Retrieve(shipFromCode)
_deliveryPlantDWC.Retrieve()
_nextPartDWC.Retrieve(blanketPart)
_secondarySupplierDWC.Retrieve(blanketPart)
_secondaryShipFromDWC.Retrieve(secondarySupplierCode)

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.Name)
	case "suppliercode"
		_termsDWC.Retrieve(data)
	case "shipfromcode"
		_shipViaDWC.Retrieve(data)
		_freightTypeDWC.Retrieve(data)
	case "blanketpart"
		_nextPartDWC.Retrieve(data)
		
	case "nextpart"
		//	Show display name.
		long nextPartRow
		nextPartRow = _nextPartDWC.GetRow()
		string nextPartName
		if	nextPartRow > 0 and nextPartRow <= _nextPartDWC.RowCount() then
			nextPartName = _nextPartDWC.GetItemString(nextPartRow, "suppliername")
		else
			SetNull(nextPartName)
		end if
		object.NextPartName[1] = nextPartName
		
		//	Retrieve and default related drop down.
		_secondarySupplierDWC.Retrieve(data)

	case "secondarysuppliercode"
		//	Show display name.
		long secondarySupplierRow
		secondarySupplierRow = _secondarySupplierDWC.GetRow()
		string secondarySupplierName
		if	secondarySupplierRow > 0 and secondarySupplierRow <= _secondarySupplierDWC.RowCount() then
			secondarySupplierName = _secondarySupplierDWC.GetItemString(secondarySupplierRow, "suppliername")
		else
			SetNull(secondarySupplierName)
		end if
		object.SecondarySupplierName[1] = secondarySupplierName
		
		//	Retrieve and default related drop down.
		string shipFromCode, shipFromName
		if	_secondaryShipFromDWC.Retrieve(data) = 1 then
			shipFromCode = _secondaryShipFromDWC.GetItemString(1, "shipfromcode")
			shipFromName = _secondaryShipFromDWC.GetItemString(1, "shipfromname")
		else
			SetNull(shipFromCode)
			SetNull(shipFromName)
		end if
		object.SecondaryShipFromCode[1] = shipFromCode
		object.SecondaryShipFromName[1] = shipFromName

	case "secondaryshipfrom"
		//	Show display name.
		long secondaryShipFromRow
		secondaryShipFromRow = _secondaryShipFromDWC.GetRow()
		string secondaryShipFromName
		if	secondaryShipFromRow > 0 and secondaryShipFromRow <= _secondaryShipFromDWC.RowCount() then
			secondaryShipFromName = _secondaryShipFromDWC.GetItemString(secondaryShipFromRow, "shipfromname")
		else
			SetNull(secondaryShipFromName)
		end if
		object.SecondaryShipFromName[1] = secondaryShipFromName
end choose

end event


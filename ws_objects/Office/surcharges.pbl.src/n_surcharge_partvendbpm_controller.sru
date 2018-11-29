$PBExportHeader$n_surcharge_partvendbpm_controller.sru
forward
global type n_surcharge_partvendbpm_controller from n_cst_virtual_controller
end type
end forward

global type n_surcharge_partvendbpm_controller from n_cst_virtual_controller
end type
global n_surcharge_partvendbpm_controller n_surcharge_partvendbpm_controller

type variables

private:

//	Model data.
string _activePart
string _activeVendor

//	View references.
u_panel_headerdetail _headerDetail1
u_panel_leftright2 _leftRight1
u_tabpg_surcharge_partvendbpm_parts _partsView
//u_tabpg_surcharge_partvendbpm_vendors _vendorsView
u_tabpg_surcharge_partvendbpm_vendors _blanketPricesView
u_tabpg_surcharge_partvendbpm_bsurch _blanketPriceSurchargesView

w_surcharge_partvendbpm _parentSheet

//	Data context.
n_surcharge_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setactivepart (string activepart)
public function integer setactivevendor (string activevendor)
public function integer savesurcharges ()
public function integer savepartvendor ()
end prototypes

public function integer registerwindow (ref w_sheet_panel_4t aparentsheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

_parentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

//	Link up frame controller for control of scanning.
GetFrameController()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_headerDetail1)
_headerDetail1.uo_1.ShowControl(_partsView)
_headerDetail1.uo_2.ShowControl(_leftRight1)
_leftRight1.uo_1.ShowControl(_blanketPricesView)
_leftRight1.uo_2.ShowControl(_blanketPriceSurchargesView)

return SUCCESS

end function

public function integer createlayout ();
//	Header - Details 1 split view.
_parentSheet.OpenUserObject(_headerDetail1, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetail1)

//	Part list view.
_parentSheet.OpenUserObject(_partsView, "u_tabpg_surcharge_partvendbpm_parts")
_headerDetail1.uo_1.AddPanelControl(_partsView)
MasterListControl = _partsView

//	Left - Right 1 split view
_parentSheet.OpenUserObject(_leftRight1, "u_panel_leftright2")
_headerDetail1.uo_2.AddPanelControl(_leftRight1)

//	Part-vendors view.
_parentSheet.OpenUserObject(_blanketPricesView, "u_tabpg_surcharge_partvendbpm_vendors")
_leftRight1.uo_1.AddPanelControl(_blanketPricesView)

//	Surcharges view.
_parentSheet.OpenUserObject(_blanketPriceSurchargesView, "u_tabpg_surcharge_partvendbpm_bsurch")
_leftRight1.uo_2.AddPanelControl(_blanketPriceSurchargesView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _partsView.Refresh()

end function

public function integer setactivepart (string activepart);
if	_activePart <> activePart then
	_activeVendor = ''
	_blanketPriceSurchargesView.SetPartVendor(_activePart,_activeVendor)
end if

_activePart = activePart
return _blanketPricesView.SetPartCode(_activePart)

end function

public function integer setactivevendor (string activevendor);
_activeVendor = activeVendor
return _blanketPriceSurchargesView.SetPartVendor(_activePart,_activeVendor)

end function

public function integer savesurcharges ();
datawindow surchargesDW
surchargesDW = _blanketPriceSurchargesView.dw_1
long row, rows
rows = surchargesDW.RowCount()

string publisher
string surchargeClassCode
long surchargeID
for	row = 1 to rows
	int activationType, applicationType
	decimal{12} applicationRate
	publisher = surchargesDW.object.Publisher[row]
	surchargeClassCode = surchargesDW.object.SurchargeClassCode[row]
	activationType = surchargesDW.object.ActivationType[row]
	applicationType = surchargesDW.object.ApplicationType[row]
	applicationRate = surchargesDW.object.ApplicationRate[row]
	surchargeID = surchargesDW.object.SurchargeID[row]
	if	surchargeID = -1 then
		if	publisher > '' then
			if	_trans.NewPartVendorBlanketPriceSurcharge(_activePart, _activeVendor, publisher, surchargeClassCode, activationType, applicationType, applicationRate) <> SUCCESS then
				_trans.RollbackTrans()
				return FAILURE
			end if
		end if
	else
		if	_trans.UpdatePartVendorBlanketPriceSurcharge(surchargeID, publisher, surchargeClassCode, activationType, applicationType, applicationRate) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
	end if
next

long deletedRows
deletedRows = surchargesDW.DeletedCount()
for row = 1 to deletedRows
	surchargeID = surchargesDW.object.SurchargeID.Delete[row]
	if	surchargeID > -1 then
		if	_trans.DeletePartVendorBlanketPriceSurcharge(surchargeID) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
	end if
next

_trans.CommitTrans()

return Refresh()

end function

public function integer savepartvendor ();
datawindow partVendorDW
partVendorDW = _blanketPricesView.dw_1
long row, rows
rows = partVendorDW.RowCount()

for	row = 1 to rows
	boolean isEnabled, isEnabledOriginal
	string vendor
	string vendorPart
	decimal{12} baseBlanketPrice
	decimal{6} standardPack

	isEnabled = (partVendorDW.object.Enabled[row] = 1)
	isEnabledOriginal = (partVendorDW.object.Enabled.Original[row] = 1)
	vendor = partVendorDW.object.VendorCode[row]
	vendorPart = partVendorDW.object.VendorPart[row]
	baseBlanketPrice = partVendorDW.object.BaseBlanketPrice[row]
	standardPack = partVendorDW.object.StandardPack[row]

	if	isEnabled then
		if	_trans.UpdatePartVendorBlanketPrice(_activePart, vendor, vendorPart, baseBlanketPrice, standardPack) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
	else
		if	isEnabledOriginal then
			if	_trans.DeletePartVendorBlanketPrice(_activePart, vendor) <> SUCCESS then
				_trans.RollbackTrans()
				return FAILURE
			end if
		end if
	end if
next
_trans.CommitTrans()

return Refresh()

end function

on n_surcharge_partvendbpm_controller.create
call super::create
end on

on n_surcharge_partvendbpm_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_surcharge_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


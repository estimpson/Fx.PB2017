$PBExportHeader$n_mes_manufacturedparts_controller.sru
forward
global type n_mes_manufacturedparts_controller from n_cst_virtual_controller
end type
end forward

global type n_mes_manufacturedparts_controller from n_cst_virtual_controller
end type
global n_mes_manufacturedparts_controller n_mes_manufacturedparts_controller

type variables

private:

//	View references.
u_tabpg_MES_manufacturedparts_partlist _partlistView

w_MES_manufacturedparts _parentSheet

//	Data context.
n_cst_mes_inventorytrans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer generateserials (integer newboxes, string partcode, long jobid, long primarysalesorder, string machinecode, decimal standardpack, string boxpackagetype, string boxlabelformat)
public function integer generatepallets (integer newpallets, string partcode, long jobid, long primarysalesorder, string machinecode, string palletpackagetype, string palletlabelformat)
public function integer printlabel (long boxserialnumber, string boxlabelformat)
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
_parentSheet.uo_1.ShowControl(_partlistView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_partlistView, "u_tabpg_MES_manufacturedparts_partlist")
_parentSheet.uo_1.AddPanelControl(_partlistView)
MasterListControl = _partlistView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _partlistView.Refresh()

end function

public function integer generateserials (integer newboxes, string partcode, long jobid, long primarysalesorder, string machinecode, decimal standardpack, string boxpackagetype, string boxlabelformat);// Arguments: newBoxes, partCode, WODID, primarySalesOrder, machineCode, standardPack, boxPackageType, boxLabelFormat

if	not IsValid(_trans) then return FAILURE

//	Create job if necessary.
if	IsNull(jobID, 0) <= 0 then
	if	_trans.ScheduleManualJob(jobID, partCode, primarySalesOrder, machineCode, newBoxes * standardPack, datetime(today())) <> SUCCESS then
		return FAILURE
	end if
end if

//	Create new preobjects.
long	firstNewSerial
if	_trans.NewPreObjects(jobID, newBoxes * standardPack, standardPack, boxPackageType, '', firstNewSerial, newBoxes) <> SUCCESS then
	return FAILURE
end if

//	Print new labels.
long	boxSerialNumber
for	boxSerialNumber = firstNewSerial to firstNewSerial + newBoxes - 1
	PrintLabel(boxSerialNumber, boxLabelFormat)
next

_trans.CommitTrans()

return Refresh()

end function

public function integer generatepallets (integer newpallets, string partcode, long jobid, long primarysalesorder, string machinecode, string palletpackagetype, string palletlabelformat);// Arguments: newpallets, partCode, jobid, primarySalesOrder, machineCode, palletPackageType, palletLabelFormat

if	not IsValid(_trans) then return FAILURE

//	Create job if necessary.
if	IsNull(jobID, 0) <= 0 then
	if	_trans.ScheduleManualJob(jobID, partCode, primarySalesOrder, machineCode, 1, datetime(today())) <> SUCCESS then
		return FAILURE
	end if
end if

//	Create new preobjects.
long	firstNewSerial
if	_trans.CreatePallets(jobID, palletPackageType, newPallets, firstNewSerial) <> SUCCESS then
	return FAILURE
end if

//	Print new labels.
long palletSerial
for	palletSerial = firstNewSerial to firstNewSerial + newPallets - 1
	PrintLabel(palletSerial, palletLabelFormat)
next

return NO_ACTION

end function

public function integer printlabel (long boxserialnumber, string boxlabelformat);
//Open pre-objects
_trans.OpenPreObject (boxSerialNumber)

//Print Labels
n_cst_associative_array	printerParm
printerParm.of_SetItem ( "Arg1", boxSerialNumber)
printerParm.of_SetItem ( "Report", "Label" )
printerParm.of_SetItem ( "Name", boxLabelFormat )
Print(printerParm)

//Close pre-objects
_trans.ClosePreObject (boxSerialNumber)

return SUCCESS

end function

on n_mes_manufacturedparts_controller.create
call super::create
end on

on n_mes_manufacturedparts_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_cst_mes_inventorytrans

end event

event destructor;call super::destructor;
destroy _trans

end event


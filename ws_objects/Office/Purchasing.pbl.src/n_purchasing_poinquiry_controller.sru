$PBExportHeader$n_purchasing_poinquiry_controller.sru
forward
global type n_purchasing_poinquiry_controller from n_cst_virtual_controller
end type
end forward

global type n_purchasing_poinquiry_controller from n_cst_virtual_controller
end type
global n_purchasing_poinquiry_controller n_purchasing_poinquiry_controller

type variables

private:

//	View references.
u_tabpg_purchasing_poinquiry_polist _polistView

w_purchasing_poinquiry _parentSheet

//	Data context.
n_purchasing_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer newblanketpurchaseorder ()
public function integer newnormalpurchaseorder ()
public function integer closepolist (long poarray[])
public function integer cleanpolist (long poarray[])
public function integer deletepolist (long poarray[])
public function integer editpo (long ponumber)
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
_parentSheet.uo_1.ShowControl(_polistView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_polistView, "u_tabpg_purchasing_poinquiry_polist")
_parentSheet.uo_1.AddPanelControl(_polistView)
MasterListControl = _polistView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _polistView.Refresh()

end function

public function integer newblanketpurchaseorder ();
return OpenSheetWithParm(w_blanket_po_entry, -1, gnv_App.of_GetFrame(), 0, Original!)

end function

public function integer newnormalpurchaseorder ();
return OpenSheetWithParm(w_normal_po_entry, -1, gnv_App.of_GetFrame(), 0, Original!)

end function

public function integer closepolist (long poarray[]);
//	Build a list of serials that need to have the new status.
string poList = ""
long row, rows

rows = UpperBound(POArray)

//	Verify intent.
if	rows > 0 then
	if	MsgBox("This will close the " + string(rows) + " selected PO(s) by closing all the open releases.", Question!,OkCancel!, 2) = 2 then
		return NO_ACTION
	end if
end if

//	Process request in batches.
long deletedReleaseCountTotal = 0, deletedReleaseCountBatch
for	row = 1 to rows
	if	Len(poList + String(POArray[row])) > 8000 then
		if	_trans.ClosePOList(poList, deletedReleaseCountBatch) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
		deletedReleaseCountTotal += deletedReleaseCountBatch
		poList = ""
	end if
	poList += String(POArray[row]) + ","
next

if	_trans.ClosePOList(poList, deletedReleaseCountBatch) <> SUCCESS then
	_trans.RollbackTrans()
	return FAILURE
end if
_trans.CommitTrans()
deletedReleaseCountTotal += deletedReleaseCountBatch

if	deletedReleaseCountTotal <= 0 then
	MsgBox("No releases were closed.  There were no release quantities that were fully received.")
else
	MsgBox("In total, "+string(deletedReleaseCountTotal) + " fully received releases were closed.")
end if

return SUCCESS

end function

public function integer cleanpolist (long poarray[]);
//	Build a list of serials that need to have the new status.
string poList = ""
long row, rows

rows = UpperBound(POArray)

//	Verify intent.
if	rows > 0 then
	if	MsgBox("This will clean the " + string(rows) + " selected PO(s) by closing all the fully received releases.", Question!,OkCancel!, 2) = 2 then
		return NO_ACTION
	end if
end if

//	Process request in batches.
long deletedReleaseCountTotal = 0, deletedReleaseCountBatch
for	row = 1 to rows
	if	Len(poList + String(POArray[row])) > 8000 then
		if	_trans.CleanPOList(poList, deletedReleaseCountBatch) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
		deletedReleaseCountTotal += deletedReleaseCountBatch
		poList = ""
	end if
	poList += String(POArray[row]) + ","
next

if	_trans.CleanPOList(poList, deletedReleaseCountBatch) <> SUCCESS then
	_trans.RollbackTrans()
	return FAILURE
end if
_trans.CommitTrans()
deletedReleaseCountTotal += deletedReleaseCountBatch

if	deletedReleaseCountTotal <= 0 then
	MsgBox("No releases were closed.  There were no release quantities that were fully received.")
else
	MsgBox("In total, "+string(deletedReleaseCountTotal) + " fully received releases were closed.")
end if

return SUCCESS

end function

public function integer deletepolist (long poarray[]);
//	Build a list of serials that need to have the new status.
string poList = ""
long row, rows

rows = UpperBound(POArray)

//	Verify intent.
if	rows > 0 then
	if	MsgBox("This will delete the " + string(rows) + " selected PO(s).", Question!,OkCancel!, 2) = 2 then
		return NO_ACTION
	end if
end if

//	Process request in batches.
long deletedReleaseCountTotal = 0, deletedReleaseCountBatch
long deletePOCountTotal = 0, deletedPOCountBatch
for	row = 1 to rows
	if	Len(poList + String(POArray[row])) > 8000 then
		if	_trans.DeletePOList(poList, deletedReleaseCountBatch, deletedPOCountBatch) <> SUCCESS then
			_trans.RollbackTrans()
			return FAILURE
		end if
		deletedReleaseCountTotal += deletedReleaseCountBatch
		deletePOCountTotal += deletedPOCountBatch
		poList = ""
	end if
	poList += String(POArray[row]) + ","
next

if	_trans.DeletePOList(poList, deletedReleaseCountBatch, deletedPOCountBatch) <> SUCCESS then
	_trans.RollbackTrans()
	return FAILURE
end if
_trans.CommitTrans()
deletedReleaseCountTotal += deletedReleaseCountBatch
deletePOCountTotal += deletedPOCountBatch

if	deletePOCountTotal <= 0 then
	MsgBox("No POs were deleted.   Only POs that have been closed can be deleted.")
else
	MsgBox("In total, "+string(deletePOCountTotal) + " POs were closed.")
end if

return SUCCESS

end function

public function integer editpo (long ponumber);
string poType

if	_trans.GetPOType(poNumber, poType) <> SUCCESS then
	_trans.RollbackTrans()
	return FAILURE
end if
_trans.CommitTrans()

if	poType = 'B' then
	OpenSheetWithParm(w_blanket_po_entry, poNumber, gnv_App.of_GetFrame(), 3, Original!)
else
	OpenSheetWithParm(w_normal_po_entry, poNumber, gnv_App.of_GetFrame(), 3, Original!)
end if

return SUCCESS

end function

on n_purchasing_poinquiry_controller.create
call super::create
end on

on n_purchasing_poinquiry_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_purchasing_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


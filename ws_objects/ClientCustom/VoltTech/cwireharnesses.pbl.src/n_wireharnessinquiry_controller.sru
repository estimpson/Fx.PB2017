$PBExportHeader$n_wireharnessinquiry_controller.sru
forward
global type n_wireharnessinquiry_controller from n_cst_virtual_controller
end type
end forward

global type n_wireharnessinquiry_controller from n_cst_virtual_controller
end type
global n_wireharnessinquiry_controller n_wireharnessinquiry_controller

type variables

private:
//constant integer MODE_SHOWLINES = 1
//constant integer MODE_SHOWOBJECTS = 2
constant int NONE = 0, OPERATOR = 1, MATERIALHANDLER = 2

//	Model data.

//	View references.
u_tabpg_wireharnesses_list _harnessesListView
u_fxdw_wireharnessinquiry_newharnesses _newHarnessesView

w_wireharnessinquiry _parentSheet

//	Data context.
n_wireharnessinquiry_trans _wireHarnessInquiryTrans

end variables
forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer createlayout ()
public function integer showcontrols ()
public function integer printharnesslabel (long serialnumber)
public function integer cancelnewharnesses ()
public function integer shownewharnesses ()
public function integer createnewharnesses (string wireharnesspart, string initialpart, long numberoflabels)
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

public function integer createlayout ();
//	Harnesses list view
_parentSheet.OpenUserObject(_harnessesListView, "u_tabpg_wireharnesses_list")
_parentSheet.uo_1.AddPanelControl(_harnessesListView)
MasterListControl = _harnessesListView

 //	New harnesses view
_parentSheet.OpenUserObject(_newHarnessesView, "u_fxdw_wireharnessinquiry_newharnesses")
_parentSheet.uo_1.AddPanelControl(_newHarnessesView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_harnessesListView)

return SUCCESS

end function

public function integer printharnesslabel (long serialnumber);
string labelFormat = "Wire Harness"
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", serialNumber)
printerParm.of_SetItem ( "Report", "Label" )
printerParm.of_SetItem ( "Name", labelFormat )
return Print(printerParm)

end function

public function integer cancelnewharnesses ();
if	not IsValid(_parentSheet) or not IsValid(_harnessesListView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_harnessesListView)
return Refresh()

end function

public function integer shownewharnesses ();
if	not IsValid(_parentSheet) or not IsValid(_newHarnessesView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_newHarnessesView)
_newHarnessesView.Refresh()
return SUCCESS

end function

public function integer createnewharnesses (string wireharnesspart, string initialpart, long numberoflabels);
if	not IsValid(_wireHarnessInquiryTrans) then
	return FAILURE
end if

long firstNewSerial
if	_wireHarnessInquiryTrans.NewHarnesses(wireHarnessPart, initialPart, numberOfLabels, ref firstNewSerial) <> SUCCESS then
	_wireHarnessInquiryTrans.RollbackTrans()
	return FAILURE
end if

_wireHarnessInquiryTrans.CommitTrans()
long harnessSerial
for	harnessSerial = firstNewSerial to firstNewSerial + numberOfLabels - 1
	PrintHarnessLabel(harnessSerial)
next

if	not IsValid(_parentSheet) or not IsValid(_harnessesListView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_harnessesListView)
return Refresh()

end function

on n_wireharnessinquiry_controller.create
call super::create
end on

on n_wireharnessinquiry_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_wireHarnessInquiryTrans = create n_wireharnessinquiry_trans

end event

event destructor;call super::destructor;
destroy _wireHarnessInquiryTrans

end event


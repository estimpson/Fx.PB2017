$PBExportHeader$n_surcharge_setups_controller.sru
forward
global type n_surcharge_setups_controller from n_cst_virtual_controller
end type
end forward

global type n_surcharge_setups_controller from n_cst_virtual_controller
end type
global n_surcharge_setups_controller n_surcharge_setups_controller

type variables

private:

//	Model data.
string _publisherList
string _publisherArray[]
long _rateHeaderID = -1

//	View references.
u_panel_headerdetail _headerDetail1
u_panel_leftright2 _leftRight1
u_panel_leftright2 _leftRight2

u_tabpg_surcharge_setups_publishers _publishersView
u_tabpg_surcharge_setups_pubclasscodes _publisherClassCodesView
u_tabpg_surcharge_setups_pubr8headers _publisherRateHeadersView
u_tabpg_surcharge_setups_pubr8details _publisherRateDetailsView

w_surcharge_setups _parentSheet

//	Data context.
n_surcharge_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setpublisherlist (string publisherarray[])
public function integer activatepublisherclasscode (string publisherlist, string classcode, string unit)
public function integer deactivatepublisherclasscode (string publisherlist, string classcode)
public function integer editrateheader (long rateheaderid)
public function integer newrateheader ()
public function integer saveratedetails ()
public function integer saverateheader ()
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
_headerDetail1.uo_1.ShowControl(_leftRight1)
_leftRight1.uo_1.ShowControl(_publishersView)
_leftRight1.uo_2.ShowControl(_publisherClassCodesView)
_headerDetail1.uo_2.ShowControl(_leftRight2)
_leftRight2.uo_1.ShowControl(_publisherRateHeadersView)
_leftRight2.uo_2.ShowControl(_publisherRateDetailsView)

return SUCCESS

end function

public function integer createlayout ();
//	Header - Details 1 split view.
_parentSheet.OpenUserObject(_headerDetail1, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetail1)

//	Left - Right 1 split view
_parentSheet.OpenUserObject(_leftRight1, "u_panel_leftright2")
_headerDetail1.uo_1.AddPanelControl(_leftRight1)

//	Publishers view.
_parentSheet.OpenUserObject(_publishersView, "u_tabpg_surcharge_setups_publishers")
_leftRight1.uo_1.AddPanelControl(_publishersView)

//	Publisher Class view.
_parentSheet.OpenUserObject(_publisherClassCodesView, "u_tabpg_surcharge_setups_pubclasscodes")
_leftRight1.uo_2.AddPanelControl(_publisherClassCodesView)

//	Left - Right 2 split view
_parentSheet.OpenUserObject(_leftRight2, "u_panel_leftright2")
_headerDetail1.uo_2.AddPanelControl(_leftRight2)

//	Publisher Rate Headers view.
_parentSheet.OpenUserObject(_publisherRateHeadersView, "u_tabpg_surcharge_setups_pubr8headers")
_leftRight2.uo_1.AddPanelControl(_publisherRateHeadersView)

//	Publisher Rate Details view.
_parentSheet.OpenUserObject(_publisherRateDetailsView, "u_tabpg_surcharge_setups_pubr8details")
_leftRight2.uo_2.AddPanelControl(_publisherRateDetailsView)
 
//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
_publishersView.Refresh()

_publisherClassCodesView.SetPublisherList(_publisherList)
_publisherRateHeadersView.SetPublisherList(_publisherList)

return SUCCESS

end function

public function integer setpublisherlist (string publisherarray[]);
//	Build a list of serials that need to have the new status.
_publisherList = ""
long row, rows

_publisherArray = publisherArray
rows = UpperBound(_publisherArray)

//	Process request in batches.
for	row = 1 to rows
	_publisherList += String(_publisherArray[row]) + ","
next

_publisherClassCodesView.SetPublisherList(_publisherList)
_publisherRateHeadersView.SetPublisherList(_publisherList)
return SUCCESS

end function

public function integer activatepublisherclasscode (string publisherlist, string classcode, string unit);
//	Confirm intent.
if	MsgBox(classCode + " will be activated for publishers: " + publisherList + " with unit: " + isnull(unit, "[NULL]") + ".", Question!, OkCancel!, 2) = 2 then
	return NO_ACTION
end if

if	_trans.ActivatePublisherClassCode(publisherList, classCode, unit) = SUCCESS then
	_trans.CommitTrans()
	return SUCCESS
end if

_trans.RollbackTrans()
return FAILURE

end function

public function integer deactivatepublisherclasscode (string publisherlist, string classcode);
//	Confirm intent.
if	MsgBox(classCode + " will be deactivated for publishers: " + publisherList + ".", Question!, OkCancel!, 2) = 2 then
	return NO_ACTION
end if

if	_trans.DeactivatePublisherClassCode(publisherList, classCode) = SUCCESS then
	_trans.CommitTrans()
	return SUCCESS
end if

_trans.RollbackTrans()
return FAILURE

end function

public function integer editrateheader (long rateheaderid);
_rateHeaderID = rateHeaderID
_publisherRateDetailsView.SetRateHeader(_rateHeaderID)
return SUCCESS

end function

public function integer newrateheader ();
_rateHeaderID = -1
_publisherRateDetailsView.SetRateHeader(_rateHeaderID)
return SUCCESS

end function

public function integer saveratedetails ();
datawindow dw_details
dw_details = _publisherRateDetailsView.dw_1
long row, rows
rows = dw_details.RowCount()

for	row = 1 to rows
	string rateClassCode
	decimal {6} rate
	rateClassCode = dw_details.object.ClassCode[row]
	rate = dw_details.object.Rate[row]
	if	_trans.SetRate(_rateHeaderID, rateClassCode, rate) <> SUCCESS then
		_trans.RollbackTrans()
		return FAILURE
	end if
next
_trans.CommitTrans()

return Refresh()

end function

public function integer saverateheader ();
datawindow dw_header
dw_header = _publisherRateDetailsView.dw_header

if	dw_header.RowCount() <> 1 then
	return FAILURE
end if

string effectivityType
int month, year
datetime beginDT, endDT
string name

effectivityType = dw_header.object.EffectivityType[1]
month = dw_header.object.Month[1]
year = dw_header.object.Year[1]
beginDT = dw_header.object.BeginDT[1]
endDT = dw_header.object.EndDT[1]
name = dw_header.object.Name[1]

if	_rateHeaderID = -1 then
	if	_trans.NewRateHeader(_publisherList, effectivityType, month, year, beginDT, endDT, name) <> SUCCESS then
		_trans.RollbackTrans()
		return FAILURE
	end if
else
	if	_trans.UpdateRateHeader(_rateHeaderID, effectivityType, month, year, beginDT, endDT, name) <> SUCCESS then
		_trans.RollbackTrans()
		return FAILURE
	end if
end if
_trans.CommitTrans()

return Refresh()

end function

on n_surcharge_setups_controller.create
call super::create
end on

on n_surcharge_setups_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_surcharge_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


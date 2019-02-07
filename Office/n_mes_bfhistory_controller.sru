HA$PBExportHeader$n_mes_bfhistory_controller.sru
forward
global type n_mes_bfhistory_controller from n_cst_virtual_controller
end type
end forward

global type n_mes_bfhistory_controller from n_cst_virtual_controller
end type
global n_mes_bfhistory_controller n_mes_bfhistory_controller

type variables

private:

//	Model data.
datetime _recentDate
string _workOrderNumber
long _jobID
string _backflushNumber

//	View references.
u_panel_headerdetail _hd
u_panel_leftright _lr1
u_tabpg_mes_bfhistory_recenthistory _recentHistory
u_tabpg_mes_bfhistory_recentwohistory _recentWOHistory

u_tab_4t _backflushDetailsTabView
u_tabpg_mes_bfhistory_backflushdetails _backflushDetailsView
u_tabpg_mes_bfhistory_jobbom _jobBOMView

w_mes_backflushhistory_inquiry _parentSheet

//	Data context.
n_mes_bfhistory_trans _bfHistoryTrans

end variables

forward prototypes
public function integer createlayout ()
public function integer showcontrols ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer refresh ()
public function integer setworkordernumber (string workordernumber)
public function integer setbackflushnumber (string backflushnumber)
public function integer settempwip (string childpart)
public function integer cleartempwip (string childpart)
public function integer setrecentdate (datetime recentdate)
public function integer showcomponentledgerreport (string componentpart)
end prototypes

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_hd, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_hd)

//	Left - Right 1 split view.
_parentSheet.OpenUserObject(_lr1, "u_panel_leftright")
_hd.uo_1.AddPanelControl(_lr1)

//	Recent history view.
_parentSheet.OpenUserObject(_recentHistory, "u_tabpg_mes_bfhistory_recenthistory")
_lr1.uo_1.AddPanelControl(_recentHistory)

//	Recent work order history view.
_parentSheet.OpenUserObject(_recentWOHistory, "u_tabpg_mes_bfhistory_recentwohistory")
_lr1.uo_2.AddPanelControl(_recentWOHistory)

//	Backflush Details Tab View
_parentSheet.OpenUserObject(_backflushDetailsTabView, "u_tab_4t")
 _hd.uo_2.AddPanelControl(_backflushDetailsTabView)

//	Backflush details view.
_backflushDetailsTabView.OpenTab(_backflushDetailsView, "u_tabpg_mes_bfhistory_backflushdetails", 1)
_backflushDetailsTabView.SelectTab(1)

//	Job BOM view.
_backflushDetailsTabView.OpenTab(_jobBomView, "u_tabpg_mes_bfhistory_jobbom", 2)

 //	Show controls
post ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_hd)
_hd.uo_1.ShowControl(_lr1)
_lr1.uo_1.ShowControl(_recentHistory)
_lr1.uo_2.ShowControl(_recentWOHistory)
_hd.uo_2.ShowControl(_backflushDetailsTabView)
 
return SUCCESS

end function

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

public function integer refresh ();
_recentHistory.SetRecentDate(_recentDate)
_recentWOHistory.SetRecentDate(_recentDate)

return SUCCESS

end function

public function integer setworkordernumber (string workordernumber);
_workOrderNumber = workOrderNumber
_recentWOHistory.SetWorkOrderNumber(_workOrderNumber)
_jobBOMView.SetWorkOrderNumber(_workOrderNumber)

return SUCCESS

end function

public function integer setbackflushnumber (string backflushnumber);
_backflushNumber = backflushNumber
_backflushDetailsView.SetBackflushNumber(_backflushNumber)

return SUCCESS

end function

public function integer settempwip (string childpart);
if	not IsValid(_bfHistoryTrans) then return FAILURE

if	_bfHistoryTrans.SetTempWIP (childPart) <> SUCCESS then
	return FAILURE
end if

_bfHistoryTrans.CommitTrans()
return SUCCESS

end function

public function integer cleartempwip (string childpart);
if	not IsValid(_bfHistoryTrans) then return FAILURE

if	_bfHistoryTrans.ClearTempWIP (childPart) <> SUCCESS then
	return FAILURE
end if

_bfHistoryTrans.CommitTrans()
return SUCCESS

end function

public function integer setrecentdate (datetime recentdate);
_recentDate = recentDate
return Refresh()

end function

public function integer showcomponentledgerreport (string componentpart);
w_mes_bfhist_componentledgerpopupreport w_test
open(w_test, "w_mes_bfhist_componentledgerpopupreport")
w_test.SetComponentPart (componentPart)
return NO_ACTION

end function

on n_mes_bfhistory_controller.create
call super::create
end on

on n_mes_bfhistory_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_bfHistoryTrans = create n_mes_bfhistory_trans
_recentDate = DateTime(RelativeDate(Today(), -1))

end event

event destructor;call super::destructor;
destroy _bfHistoryTrans

end event


$PBExportHeader$n_lot_trace_controller.sru
forward
global type n_lot_trace_controller from n_cst_virtual_controller
end type
end forward

global type n_lot_trace_controller from n_cst_virtual_controller
end type
global n_lot_trace_controller n_lot_trace_controller

type variables

private:

//	Model data
string _traceNumber

//	View references.
u_panel_headerdetail _headerDetailView
u_tabpg_lot_trace_headers _headersView
u_tab_lot_trace_details _lotTraceDetailTabView
u_tabpg_lot_trace_topdown _lotTraceTopDownView
u_tabpg_lot_trace_bottomup _lotTraceBottomUpView
u_tabpg_lot_trace_objects _lotTraceObjectsView
u_tabpg_lot_trace_receipthistory _lotTraceReceiptHistoryView
u_fxdw_lot_trace_newheader _lotTraceNewHeaderView

u_tabpg_lot_trace_inv_quality_newheader _lotTraceInvQualityNewHeaderView

w_lot_trace _parentSheet

//	Data context.
n_lot_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer settracenumber (string tracenumber)
public function integer newqualitybatch (string seriallist)
public function integer endnewqualitybatch ()
public function integer cancelnewqualitybatch ()
public function integer shownewtrace ()
public function integer newlottrace (string description, string seriallist)
public function integer cancelnewlottrace ()
public function integer hidenewtrace ()
public function integer refreshtraceup ()
public function integer refreshtracedown ()
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
_parentSheet.uo_1.ShowControl(_headerDetailView)
_headerDetailView.uo_1.ShowControl(_headersView)
_headerDetailView.uo_2.ShowControl(_lotTraceDetailTabView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_headerDetailView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailView)

//	Header - Details split view.
_parentSheet.OpenUserObject(_headersView, "u_tabpg_lot_trace_headers")
_headerDetailView.uo_1.AddPanelControl(_headersView)
MasterListControl = _headersView

//	Lot trace details tab view.
_parentSheet.OpenUserObject(_lotTraceDetailTabView, "u_tab_lot_trace_details")
	//	Top-down view.
	_lotTraceDetailTabView.OpenTab(_lotTraceTopDownView, "u_tabpg_lot_trace_topdown", 1)
	_lotTraceTopDownView.SetTransObject(_trans)
	
	//	Bottom-up view.
	_lotTraceDetailTabView.OpenTab(_lotTraceBottomUpView, "u_tabpg_lot_trace_bottomup", 2)
	_lotTraceBottomUpView.SetTransObject(_trans)
	
	//	Lot trace objects view.
//	_lotTraceDetailTabView.OpenTab(_lotTraceObjectsView, "u_tabpg_lot_trace_objects", 3)
//	_lotTraceObjectsView.Text = "Objects"

	//	Receipt history view.
//	_lotTraceDetailTabView.OpenTab(_lotTraceReceiptHistoryView, "u_tabpg_lot_trace_receipthistory", 4)
//	_lotTraceReceiptHistoryView.Text = "Receipt History"
	
_lotTraceDetailTabView.SelectTab(1)
_headerDetailView.uo_2.AddPanelControl(_lotTraceDetailTabView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _headersView.Refresh()

end function

public function integer settracenumber (string tracenumber);
_traceNumber = traceNumber
_lotTraceTopDownview.SetTraceNumber(_traceNumber)
_lotTraceBottomUpview.SetTraceNumber(_traceNumber)

return SUCCESS

end function

public function integer newqualitybatch (string seriallist);
if	not IsValid(_trans) or IsNull(_trans) then return FAILURE

string traceDescription
if	_trans.GetTraceDescription(_traceNumber, traceDescription) = SUCCESS then
	
	_parentSheet.OpenUserObject(_lotTraceInvQualityNewHeaderView, "u_tabpg_lot_trace_inv_quality_newheader")
	_lotTraceInvQualityNewHeaderView.SetSerialList(serialList, traceDescription)
	
	_parentSheet.uo_1.AddPanelControl(_lotTraceInvQualityNewHeaderView)
	_parentSheet.uo_1.ShowControl(_lotTraceInvQualityNewHeaderView)
	return SUCCESS
end if

return NO_ACTION

end function

public function integer endnewqualitybatch ();
_parentSheet.CloseUserObject(_lotTraceInvQualityNewHeaderView)
SetNull(_lotTraceInvQualityNewHeaderView)
_parentSheet.uo_1.ShowControl(_headerDetailView)

return NO_ACTION

end function

public function integer cancelnewqualitybatch ();
return EndNewQualityBatch()


end function

public function integer shownewtrace ();
if	not IsValid(_trans) or IsNull(_trans) then return FAILURE

_parentSheet.OpenUserObject(_lotTraceNewHeaderView, "u_fxdw_lot_trace_newheader")
_lotTraceNewHeaderView.Refresh()

_parentSheet.uo_1.AddPanelControl(_lotTraceNewHeaderView)
_parentSheet.uo_1.ShowControl(_lotTraceNewHeaderView)
return SUCCESS

end function

public function integer newlottrace (string description, string seriallist);
if	not IsValid(_trans) or IsNull(_trans) then return FAILURE

string traceNumber
if	_trans.NewTraceHeader(description, serialList, traceNumber) = SUCCESS then
	_trans.CommitTrans()
	MsgBox("Trace number " + traceNumber + " created successfully")
	return HideNewTrace()
end if
_trans.RollbackTrans()

return NO_ACTION

end function

public function integer cancelnewlottrace ();
return HideNewTrace()


end function

public function integer hidenewtrace ();
if	not IsValid(_lotTraceNewHeaderView) then return NO_ACTION

_parentSheet.CloseUserObject(_lotTraceNewHeaderView)
SetNull(_lotTraceNewHeaderView)

_parentSheet.uo_1.ShowControl(_headerDetailView)
return Refresh()

end function

public function integer refreshtraceup ();
if	not IsValid(_trans) or IsNull(_trans) then return FAILURE

if	_trans.RefreshTraceUp(_traceNumber) = SUCCESS then
	_trans.CommitTrans()
	_lotTraceBottomUpview.SetTraceNumber(_traceNumber)
end if
_trans.RollbackTrans()

return NO_ACTION

end function

public function integer refreshtracedown ();
if	not IsValid(_trans) or IsNull(_trans) then return FAILURE

if	_trans.RefreshTraceDown(_traceNumber) = SUCCESS then
	_trans.CommitTrans()
	_lotTraceTopDownView.SetTraceNumber(_traceNumber)
end if
_trans.RollbackTrans()

return NO_ACTION

end function

on n_lot_trace_controller.create
call super::create
end on

on n_lot_trace_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_lot_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


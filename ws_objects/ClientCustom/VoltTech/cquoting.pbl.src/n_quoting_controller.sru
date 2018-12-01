$PBExportHeader$n_quoting_controller.sru
forward
global type n_quoting_controller from n_cst_virtual_controller
end type
end forward

global type n_quoting_controller from n_cst_virtual_controller
end type
global n_quoting_controller n_quoting_controller

type variables
private:

//	Subcontrollers.
n_quoting_newbom_controller _newBOMController

//	Model data.
string _quoteNumber

//	View references.
u_panel_headerdetail _headerDetailSplitView
u_tabpg_quotelog_setup _quoteLogView
u_fxdw_newquoteheader _newQuoteHeaderView
u_tabpg_quotebom_setup _quoteBOMView

w_quoting _parentSheet

//	View state data.
long _restoreQuoteLogHeight = 0

//	Data context.
n_quoting_trans _quotingTrans

end variables

forward prototypes
public function integer getframecontroller ()
public function integer showcontrols ()
public function integer createlayout ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showallcomments ()
public function integer hideallcomments ()
public function integer showcomment ()
public function integer setquotenumber (string quotenumber)
public function integer cancelnewquoteheader ()
public function integer shownewquoteheader ()
public function integer shownewecnquoteheader (long parentquoteid)
public function integer shownewrevquoteheader (long parentquoteid)
public function integer createnewquoteheader (st_newquote newquotevalues)
public function integer expandquotelog ()
public function integer collapsequotelog ()
public function n_quoting_newbom_controller getnewbomcontroller ()
public function integer shownewquotedbomcomponent ()
end prototypes

public function integer getframecontroller ();
_parentSheet.SetRedraw(false)

//	Show controls
//ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_headerDetailSplitView)
_headerDetailSplitView.uo_1.ShowControl(_quoteLogView)
_headerDetailSplitView.uo_2.ShowControl(_quoteBOMView)

_parentSheet.SetRedraw(true)

return SUCCESS

end function

public function integer createlayout ();
_parentSheet.SetRedraw(false)

//	Side by side split view:
_parentSheet.OpenUserObject(_headerDetailSplitView, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetailSplitView)

//	Quote log view.
_parentSheet.OpenUserObject(_quoteLogView, "u_tabpg_quotelog_setup")
_headerDetailSplitView.uo_1.AddPanelControl(_quoteLogView)
MasterListControl = _quoteLogView

//	New quote header view.
_parentSheet.OpenUserObject(_newQuoteHeaderView, "u_fxdw_newquoteheader")
_parentSheet.uo_1.AddPanelControl(_newQuoteHeaderView)

//	Quote BOM view.
_parentSheet.OpenUserObject(_quoteBOMView, "u_tabpg_quotebom_setup")
_headerDetailSplitView.uo_2.AddPanelControl(_quoteBOMView)

//	Show controls
ShowControls()

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

public function integer showallcomments ();
if	not IsValid(_quoteLogView) then return FAILURE

return _quoteLogView.ShowAllHotSpots(true)

end function

public function integer hideallcomments ();
if	not IsValid(_quoteLogView) then return FAILURE

return _quoteLogView.ShowAllHotSpots(false)

end function

public function integer showcomment ();
if	not IsValid(_quoteLogView) then return FAILURE

return _quoteLogView.ShowColumnComment()

end function

public function integer setquotenumber (string quotenumber);
_quoteNumber = quoteNumber
_quoteBOMView.SetQuoteNumber(_quoteNumber)
return SUCCESS

end function

public function integer cancelnewquoteheader ();
if	not isValid(_parentSheet) or not isValid(_headerDetailSplitView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_headerDetailSplitView)
return SUCCESS

end function

public function integer shownewquoteheader ();
//	Show controls.
_parentSheet.uo_1.ShowControl(_newQuoteHeaderView)

_parentSheet.SetRedraw(true)

return _newQuoteHeaderView.NewQuote()

end function

public function integer shownewecnquoteheader (long parentquoteid);
//	Show controls.
_parentSheet.uo_1.ShowControl(_newQuoteHeaderView)

_parentSheet.SetRedraw(true)

return _newQuoteHeaderView.NewECN(parentQuoteID)

end function

public function integer shownewrevquoteheader (long parentquoteid);
//	Show controls.
_parentSheet.uo_1.ShowControl(_newQuoteHeaderView)

_parentSheet.SetRedraw(true)

return _newQuoteHeaderView.NewRevision(parentQuoteID)

end function

public function integer createnewquoteheader (st_newquote newquotevalues);if	not IsValid(_quotingTrans) then return FAILURE

//	Attempt to save new quote header.
if	_quotingTrans.NewQuoteHeader(newQuoteValues) = SUCCESS then
	_quotingTrans.CommitTrans()
else
	_quotingTrans.RollbackTrans()
	return FAILURE
end if

if	not isValid(_parentSheet) or not isValid(_headerDetailSplitView) then
	return FAILURE
end if

_parentSheet.uo_1.ShowControl(_headerDetailSplitView)
return NO_ACTION

end function

public function integer expandquotelog ();
//	Restore quote log height to the hight prior to collapse.
if	_restoreQuoteLogHeight = 0 then return NO_ACTION

_headerDetailSplitView.SetHeaderHeight(_restoreQuoteLogHeight)
_headerDetailSplitView.st_1.Show()
return _quoteLogView.SetExpandedView()

end function

public function integer collapsequotelog ();
//	Restore quote log height to the hight prior to collapse.
_restoreQuoteLogHeight = _quoteLogView.Height
_headerDetailSplitView.SetHeaderHeight(_quoteLogView.GetCollapseHeight())
_headerDetailSplitView.st_1.Hide()
return _quoteLogView.SetCollapsedView()

end function

public function n_quoting_newbom_controller getnewbomcontroller ();
return _newBOMController

end function

public function integer shownewquotedbomcomponent ();
if	IsValid(_newBOMController) then destroy _newBOMController
_newBOMController = create n_quoting_newbom_controller

//	Give panel to new BOM controller.
_newBOMController.RegisterWindow(_parentSheet, _headerDetailSplitView.uo_2)

return NO_ACTION

end function

on n_quoting_controller.create
call super::create
end on

on n_quoting_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;_quotingTrans = create n_quoting_trans
end event

event destructor;call super::destructor;if	not IsValid(_quotingTrans) then return
destroy _quotingTrans
end event

event closing;call super::closing;
ExpandQuoteLog()

end event


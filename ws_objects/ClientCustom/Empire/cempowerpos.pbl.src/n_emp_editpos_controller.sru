$PBExportHeader$n_emp_editpos_controller.sru
forward
global type n_emp_editpos_controller from n_cst_virtual_controller
end type
end forward

global type n_emp_editpos_controller from n_cst_virtual_controller
end type
global n_emp_editpos_controller n_emp_editpos_controller

type variables

private:

//	View references.
u_panel_headerdetail _headerDetail
u_tabpg_emp_editpos_poheaders _poHeadersView
u_tabpg_emp_editpos_poitems _poItemsView

w_emp_editpos _parentSheet

//	Model data.
string _activePONumber

//	Data context.
n_emp_trans _trans

end variables
forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer setactiveponumber (string ponumber)
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
_parentSheet.uo_1.ShowControl(_headerDetail)
_headerDetail.uo_1.ShowControl(_poHeadersView)
_headerDetail.uo_2.ShowControl(_poItemsView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_headerDetail, "u_panel_headerdetail")
_parentSheet.uo_1.AddPanelControl(_headerDetail)

//	Header - Details split view.
_parentSheet.OpenUserObject(_poheadersView, "u_tabpg_emp_editpos_poheaders")
_headerDetail.uo_1.AddPanelControl(_poheadersView)
MasterListControl = _poheadersView

//	Header - Details split view.
_parentSheet.OpenUserObject(_poItemsView, "u_tabpg_emp_editpos_poitems")
_headerDetail.uo_2.AddPanelControl(_poItemsView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer setactiveponumber (string ponumber);
_activePONumber = poNumber

return _poItemsView.SetPONumber(_activePONumber)

end function

on n_emp_editpos_controller.create
call super::create
end on

on n_emp_editpos_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_emp_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


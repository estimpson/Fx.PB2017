$PBExportHeader$n_purchmst_poedit_controller.sru
forward
global type n_purchmst_poedit_controller from n_cst_virtual_controller
end type
end forward

global type n_purchmst_poedit_controller from n_cst_virtual_controller
end type
global n_purchmst_poedit_controller n_purchmst_poedit_controller

type variables

private:

//	View references.
u_tabpg_purchmst_poedit_bolist _blanketorderlistView

w_purchmst_poedit _parentSheet

//	Data context.
n_purchmst_trans _bfTrans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setorderlistasdefault (string orderlist)
public function integer sendpoemails (string orderlist)
public function integer sendpoemail (long ordernumber)
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
_parentSheet.uo_1.ShowControl(_blanketorderlistView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_blanketorderlistView, "u_tabpg_purchmst_poedit_bolist")
_parentSheet.uo_1.AddPanelControl(_blanketorderlistView)
MasterListControl = _blanketorderlistView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _blanketorderlistView.Refresh()

end function

public function integer setorderlistasdefault (string orderlist);
if	not IsValid(_bfTrans) then return FAILURE

if	_bfTrans.SetListedOrdersAsDefault(orderList) <> SUCCESS then
	return FAILURE
end if

_bfTrans.CommitTrans()

return Refresh()

end function

public function integer sendpoemails (string orderlist);
if	not IsValid(_bfTrans) then return FAILURE

if	_bfTrans.func1() <> SUCCESS then
	return FAILURE
end if

_bfTrans.CommitTrans()

return Refresh()

end function

public function integer sendpoemail (long ordernumber);

n_cst_associative_array	lnv_Parm
lnv_Parm.of_SetItem("Report", "PO - Release")
lnv_Parm.of_SetItem("Arg1", orderNumber)
openwithparm(w_sendporeleases_auto, lnv_Parm)

return SUCCESS

end function

on n_purchmst_poedit_controller.create
call super::create
end on

on n_purchmst_poedit_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_bfTrans = create n_purchmst_trans

end event

event destructor;call super::destructor;
destroy _bfTrans

end event


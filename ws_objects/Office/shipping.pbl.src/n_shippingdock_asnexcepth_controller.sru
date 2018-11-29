$PBExportHeader$n_shippingdock_asnexcepth_controller.sru
forward
global type n_shippingdock_asnexcepth_controller from n_cst_virtual_controller
end type
end forward

global type n_shippingdock_asnexcepth_controller from n_cst_virtual_controller
end type
global n_shippingdock_asnexcepth_controller n_shippingdock_asnexcepth_controller

type variables

private:
//	Model data.
long _shipperID
string _dwSyntax

//	View references.
u_tabpg_shippingdock_asnexcepth_inst _instructionsView

w_shippingdock_asnexceptionhandler _parentSheet

//	Data context.
n_cst_trans_shipping _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
public function integer setdatawindow (string pblname, string dwname, long shipperid)
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
_parentSheet.uo_1.ShowControl(_instructionsView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Header - Details split view.
_parentSheet.OpenUserObject(_instructionsView, "u_tabpg_shippingdock_asnexcepth_inst")
_parentSheet.uo_1.AddPanelControl(_instructionsView)
MasterListControl = _instructionsView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
return _instructionsView.SetDatawindowSyntax(_dwSyntax, _shipperID)

end function

public function integer setdatawindow (string pblname, string dwname, long shipperid);
_dwSyntax = libraryexport(pblName, dwName, ExportDataWindow!)
_shipperID = shipperID

return Refresh()


end function

on n_shippingdock_asnexcepth_controller.create
call super::create
end on

on n_shippingdock_asnexcepth_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_cst_trans_shipping

end event

event destructor;call super::destructor;
destroy _trans

end event


HA$PBExportHeader$n_setup_employees_controller.sru
forward
global type n_setup_employees_controller from n_cst_virtual_controller
end type
end forward

global type n_setup_employees_controller from n_cst_virtual_controller
end type
global n_setup_employees_controller n_setup_employees_controller

type variables

private:

//	Model data.

//	View references.
u_tabpg_setup_employees _employeesListView

w_setup_employees _parentSheet

//	Data context.
n_setup_employees_trans _setupEmployeesTrans

end variables

forward prototypes
public function integer printemployeelabel (long rowid)
public function integer createlayout ()
public function integer showcontrols ()
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
end prototypes

public function integer printemployeelabel (long rowid);
string labelFormat = "Employee Label"
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", rowID)
printerParm.of_SetItem ( "Report", "Employee Label" )
printerParm.of_SetItem ( "Name", labelFormat )
return Print(printerParm)

end function

public function integer createlayout ();
//	Defect codes list view
_parentSheet.OpenUserObject(_employeesListView, "u_tabpg_setup_employees")
_parentSheet.uo_1.AddPanelControl(_employeesListView)
MasterListControl = _employeesListView

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer showcontrols ();
_parentSheet.uo_1.ShowControl(_employeesListView)

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

on n_setup_employees_controller.create
call super::create
end on

on n_setup_employees_controller.destroy
call super::destroy
end on


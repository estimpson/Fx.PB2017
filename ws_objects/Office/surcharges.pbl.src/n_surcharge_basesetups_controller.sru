$PBExportHeader$n_surcharge_basesetups_controller.sru
forward
global type n_surcharge_basesetups_controller from n_cst_virtual_controller
end type
end forward

global type n_surcharge_basesetups_controller from n_cst_virtual_controller
end type
global n_surcharge_basesetups_controller n_surcharge_basesetups_controller

type variables

private:

//	View references.
u_panel_leftright2 _leftRight1
u_panel_leftright2 _leftRight2
u_tabpg_surcharge_basesetups_categories _categoriesView
u_tabpg_surcharge_basesetups_units _unitsView
u_tabpg_surcharge_basesetups_classcodes _classCodesView

w_surcharge_basesetups _parentSheet

//	Data context.
n_surcharge_trans _trans

end variables

forward prototypes
public function integer registerwindow (ref w_sheet_panel_4t aparentsheet)
public function integer showcontrols ()
public function integer createlayout ()
public function integer refresh ()
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
_parentSheet.uo_1.ShowControl(_leftRight1)
_leftRight1.uo_1.ShowControl(_categoriesView)
_leftRight1.uo_2.ShowControl(_leftRight2)
_leftRight2.uo_1.ShowControl(_unitsView)
_leftRight2.uo_2.ShowControl(_classCodesView)
 
return SUCCESS

end function

public function integer createlayout ();
//	Left - Right 11 split view
_parentSheet.OpenUserObject(_leftRight1, "u_panel_leftright2")
_parentSheet.uo_1.AddPanelControl(_leftRight1)

//	Categories view.
_parentSheet.OpenUserObject(_categoriesView, "u_tabpg_surcharge_basesetups_categories")
_leftRight1.uo_1.AddPanelControl(_categoriesView)
MasterListControl = _categoriesView

//	Left - Right 12 split view
_parentSheet.OpenUserObject(_leftRight2, "u_panel_leftright2")
_leftRight1.uo_2.AddPanelControl(_leftRight2)

//	Units view.
_parentSheet.OpenUserObject(_unitsView, "u_tabpg_surcharge_basesetups_units")
_leftRight2.uo_1.AddPanelControl(_unitsView)

//	Class Codes view
_parentSheet.OpenUserObject(_classCodesView, "u_tabpg_surcharge_basesetups_classcodes")
_leftRight2.uo_2.AddPanelControl(_classCodesView)

//	Show controls
post ShowControls()

return SUCCESS

end function

public function integer refresh ();
_categoriesView.Refresh()
_unitsView.Refresh()
_classCodesView.Refresh()

return SUCCESS

end function

on n_surcharge_basesetups_controller.create
call super::create
end on

on n_surcharge_basesetups_controller.destroy
call super::destroy
end on

event constructor;call super::constructor;
_trans = create n_surcharge_trans

end event

event destructor;call super::destructor;
destroy _trans

end event


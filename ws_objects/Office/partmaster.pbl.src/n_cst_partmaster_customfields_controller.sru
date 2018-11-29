$PBExportHeader$n_cst_partmaster_customfields_controller.sru
forward
global type n_cst_partmaster_customfields_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_partmaster_customfields_controller from n_cst_virtual_controller
end type
global n_cst_partmaster_customfields_controller n_cst_partmaster_customfields_controller

type variables
u_tabpg_partmaster_partedit_parts parts

end variables

forward prototypes
public function integer createlayout ()
public function integer setcustomfieldname (string customfieldname)
end prototypes

public function integer createlayout ();
//	Create the layout panels (example, override).
u_panel_leftright leftRightPanel
ParentSheet.OpenUserObject(leftRightPanel, "u_panel_leftright")
ParentSheet.uo_1.AddPanelControl(leftRightPanel)
ParentSheet.uo_1.ShowControl(leftRightPanel)

//	Create editable control(s) for each panel (example, override).
dragobject editableControlsExample[2]
this.EditableControls = editableControlsExample

u_tabpg_partmaster_customfields customFields
ParentSheet.OpenUserObject(customFields, "u_tabpg_partmaster_customfields")
EditableControls[1] = customFields
leftRightPanel.uo_1.AddPanelControl(EditableControls[1])
leftRightPanel.uo_1.ShowControl(EditableControls[1])
MasterListControl = customFields

u_tabpg_partmaster_customstringvalues customStringValues
ParentSheet.OpenUserObject(customStringValues, "u_tabpg_partmaster_customstringvalues")
customStringValues.Controller = this
EditableControls[2] = customStringValues
leftRightPanel.uo_2.AddPanelControl(EditableControls[2])
leftRightPanel.uo_2.ShowControl(EditableControls[2])

return SUCCESS
end function

public function integer setcustomfieldname (string customfieldname);
//	Show part edit.
u_tabpg_partmaster_customstringvalues customStringValues
customStringValues = EditableControls[2] //Add safety
customStringValues.CustomFieldName = customFieldName
customStringValues.Refresh()

//	Done.
return SUCCESS

end function

on n_cst_partmaster_customfields_controller.create
call super::create
end on

on n_cst_partmaster_customfields_controller.destroy
call super::destroy
end on


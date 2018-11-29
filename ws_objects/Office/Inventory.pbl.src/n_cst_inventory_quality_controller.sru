$PBExportHeader$n_cst_inventory_quality_controller.sru
forward
global type n_cst_inventory_quality_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_inventory_quality_controller from n_cst_virtual_controller
end type
global n_cst_inventory_quality_controller n_cst_inventory_quality_controller

type variables

u_tabpg_inventory_quality_newheader QualityNewHeader
u_tabpg_inventory_quality_details QualityDetails

end variables

forward prototypes
public function integer createlayout ()
public function integer endnewheader ()
public function integer shownewheader ()
public function integer cancelnewheader ()
public function integer showdetails (string qualitybatchnumber)
public function integer hidedetails ()
public function integer detailsenabled (boolean enabled)
end prototypes

public function integer createlayout ();
//	Create the layout panels (example, override).
u_panel_headerdetail headerDetailPanel
ParentSheet.OpenUserObject(headerDetailPanel, "u_panel_headerdetail")
ParentSheet.uo_1.AddPanelControl(headerDetailPanel)
ParentSheet.uo_1.ShowControl(headerDetailPanel)
MainControl = headerDetailPanel

//	Create editable control(s) for each panel (example, override).
dragobject editableControlsExample[2]
this.EditableControls = editableControlsExample

u_tabpg_inventory_quality_headers qualityHeaders
ParentSheet.OpenUserObject(qualityHeaders, "u_tabpg_inventory_quality_headers")
EditableControls[1] = qualityHeaders
headerDetailPanel.uo_1.AddPanelControl(EditableControls[1])
headerDetailPanel.uo_1.ShowControl(EditableControls[1])
MasterListControl = qualityHeaders

ParentSheet.OpenUserObject(QualityNewHeader, "u_tabpg_inventory_quality_newheader")
EditableControls[2] = QualityNewHeader
ParentSheet.uo_1.AddPanelControl(EditableControls[2])

ParentSheet.OpenUserObject(QualityDetails, "u_tabpg_inventory_quality_details")
EditableControls[3] = QualityDetails
headerDetailPanel.uo_2.AddPanelControl(EditableControls[3])
headerDetailPanel.uo_2.ShowControl(EditableControls[3])


return SUCCESS

end function

public function integer endnewheader ();
ShowMain()
return Refresh()

end function

public function integer shownewheader ();
if	not IsValid(ParentSheet) or not IsValid(QualityNewHeader) then
	return FAILURE
end if

ParentSheet.uo_1.ShowControl(QualityNewHeader)
return SUCCESS

end function

public function integer cancelnewheader ();
return ShowMain()

end function

public function integer showdetails (string qualitybatchnumber);
if	qualityBatchNumber = QualityDetails.QualityBatchNumber then
	QualityDetails.Refreshing = true
end if
QualityDetails.QualityBatchNumber = qualityBatchNumber
return QualityDetails.Refresh()

end function

public function integer hidedetails ();
QualityDetails.Refreshing = false
QualityDetails.QualityBatchNumber = ""
return QualityDetails.Refresh()


end function

public function integer detailsenabled (boolean enabled);
if	not IsValid(QualityDetails) or IsNull(QualityDetails) then
	return FAILURE
end if

QualityDetails.SetEnabled(Enabled)
return SUCCESS

end function

on n_cst_inventory_quality_controller.create
call super::create
end on

on n_cst_inventory_quality_controller.destroy
call super::destroy
end on


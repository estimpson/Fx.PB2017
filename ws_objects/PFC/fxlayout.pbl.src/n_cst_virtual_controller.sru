$PBExportHeader$n_cst_virtual_controller.sru
forward
global type n_cst_virtual_controller from n_base
end type
end forward

global type n_cst_virtual_controller from n_base
event contextmenuclick ( string menutext,  any menutag )
event closing ( )
event activated ( )
end type
global n_cst_virtual_controller n_cst_virtual_controller

type variables

Protected:
constant integer MODE_SCANNING = 6

integer _displayMode = MODE_SCANNING

//	Frame controller.
n_cst_fxframe_controller _frameController

//	View references.
w_sheet_panel_4t ParentSheet
u_tabpg_dw MasterListControl
dragobject EditableControls[]
dragobject MainControl

end variables

forward prototypes
public function integer getframecontroller ()
public function integer showmain ()
public function integer refresh ()
public function integer registerwindow (ref w_sheet_panel_4t aParentSheet)
public function integer createlayout ()
public function integer handlescan (string scanvalue)
public function integer activated ()
public function integer beginscanning ()
public function integer endscanning ()
end prototypes

public function integer getframecontroller ();
//	Get the controller for this control's window.
w_master myFrameWindow
myFrameWindow = gnv_App.of_GetFrame()
if	not IsValid(myFrameWindow) or IsNull(myFrameWindow) then return FAILURE

_frameController = myFrameWindow.Container.of_GetItem("Controller")

return SUCCESS

end function

public function integer showmain ();
if	not IsValid(ParentSheet) or IsNull(ParentSheet) then
	return FAILURE
end if

//	If the main control has been set, show it.
if	IsValid(MainControl) then
	ParentSheet.uo_1.ShowControl(MainControl)
end if

//	Bring all editable controls to top.
int	i, editableControlCount
editableControlCount = UpperBound(EditableControls)
for	i = 1 to editableControlCount
	if	not IsValid(EditableControls[i]) or IsNull(EditableControls[i]) then
		continue
	end if
	EditableControls[i].BringToTop = true
next

return SUCCESS

end function

public function integer refresh ();
if	not IsValid(MasterListControl) or IsNull(MasterListControl) then
	return FAILURE
end if

//	Tell master list control to refresh.
MasterListControl.Refreshing = true
MasterListControl.Refresh()
return SUCCESS

end function

public function integer registerwindow (ref w_sheet_panel_4t aParentSheet);
if	not IsValid(aParentSheet) or IsNull(aParentSheet) then
	return FAILURE
end if

ParentSheet = aParentSheet

//	Create the layout panels and editable control(s) for each panel.
CreateLayout()

return SUCCESS

end function

public function integer createlayout ();
//	Create the layout panels (example, override).
u_panel_leftright leftRightPanel
ParentSheet.OpenUserObject(leftRightPanel, "u_panel_leftright")
ParentSheet.uo_1.AddPanelControl(leftRightPanel)
ParentSheet.uo_1.ShowControl(leftRightPanel)
MainControl = leftRightPanel

u_panel_headerdetail headerDetailPanel
ParentSheet.OpenUserObject(headerDetailPanel, "u_panel_headerdetail")
leftRightPanel.uo_1.AddPanelControl(headerDetailPanel)
leftRightPanel.uo_1.ShowControl(headerDetailPanel)

//	Create editable control(s) for each panel (example, override).
u_tabpg_4t editableControlsExample[3]
this.EditableControls = editableControlsExample

ParentSheet.OpenUserObject(EditableControls[1], "u_tabpg_dw")
headerDetailPanel.uo_1.AddPanelControl(EditableControls[1])
headerDetailPanel.uo_1.ShowControl(EditableControls[1])
u_tabpg_dw fxTabPageDW
fxTabPageDW = EditableControls[1]
fxTabPageDW.Controller = this
MasterListControl = EditableControls[1]

ParentSheet.OpenUserObject(EditableControls[2], "u_fxdw")
headerDetailPanel.uo_2.AddPanelControl(EditableControls[2])
headerDetailPanel.uo_2.ShowControl(EditableControls[2])
u_fxdw fxDW
fxDW = EditableControls[2]
fxDW.Controller = this

ParentSheet.OpenUserObject(EditableControls[3], "u_tabpg_4t")
leftRightPanel.uo_2.AddPanelControl(EditableControls[3])
leftRightPanel.uo_2.ShowControl(EditableControls[3])
u_tabpg_4t fxTabPage
fxTabPage = EditableControls[1]
fxTabPage.Controller = this

return SUCCESS
end function

public function integer handlescan (string scanvalue);
return NO_ACTION

end function

public function integer activated ();
if	BitwiseAnd(_displayMode, MODE_SCANNING) = MODE_SCANNING then
	BeginScanning()
end if

return SUCCESS

end function

public function integer beginscanning ();
if	not IsValid(_frameController) then
	return FAILURE
end if

n_cst_virtual_controller thisController
thisController = this
return _frameController.StartScanning(thisController)

end function

public function integer endscanning ();
if	not IsValid(_frameController) then
	return FAILURE
end if

return _frameController.StopScanning()

end function

on n_cst_virtual_controller.create
call super::create
end on

on n_cst_virtual_controller.destroy
call super::destroy
end on


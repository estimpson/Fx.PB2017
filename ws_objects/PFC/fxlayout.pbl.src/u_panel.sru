$PBExportHeader$u_panel.sru
forward
global type u_panel from u_base
end type
type st_1 from statictext within u_panel
end type
end forward

global type u_panel from u_base
integer width = 2121
integer height = 1344
event move pbm_move
event shown ( )
st_1 st_1
end type
global u_panel u_panel

type variables

public int XOffset, YOffset
public protectedwrite dragobject PanelControls[]
public protectedwrite n_panelcontrolgroup PanelControlGroups[]
public protectedwrite int PanelControlCount = 0, PanelControlGroupCount = 0
public protectedwrite int ActivePanelControlIndex = -1, ActivePanelControlGroupIndex = -1
public protectedwrite dragobject ActivePanelControl
public protectedwrite n_panelcontrolgroup ActivePanelControlGroup
public protectedwrite window PanelParentWindow

end variables

forward prototypes
public function integer showcontrol (integer panelcontrolindex)
protected function integer hidecontrol (integer panelcontrolindex)
public function integer getpanelparentwindow ()
public function integer getcontrolindex (ref dragobject panelcontrol)
public function integer addpanelcontrol (ref dragobject panelcontrol, ref integer panelcontrolindex)
public function integer showcontrol (ref dragobject panelcontrol)
public function integer addpanelcontrol (ref dragobject panelcontrol)
protected function integer sizeandpositioncontrol (dragobject panelcontrol)
public function integer getcontrolgroupindex (string name)
public function integer addpanelcontroltogroup (string groupname, ref dragobject groupcontrol, integer controlwidth, integer controlheight, ref integer panelcontrolgroupcontrolindex)
protected function integer hidecontrolgroup (integer panelcontrolgroupindex)
public function integer showcontrolgroup (integer panelcontrolgroupindex)
public function integer showcontrolgroup (string groupname)
public function integer addpanelcontrolgroup (string name, integer orientation, ref integer panelcontrolgroupindex)
public function integer addpanelcontrolgroup (string name, integer orientation)
public function integer addpanelcontroltogroup (string groupname, ref dragobject groupcontrol, integer controlwidth, integer controlheight)
public function integer setactivecontrol (integer panelcontrolindex)
public function integer setactivecontrol (ref dragobject panelcontrol)
end prototypes

event move;
if	not IsNull(ActivePanelControl) and IsValid(ActivePanelControl) then
	SizeAndPositionControl(ActivePanelControl)
end if
if	not IsNull(ActivePanelControlGroup) and IsValid(ActivePanelControlGroup) then
	ActivePanelControlGroup.Resize(XOffset + X, YOffset + Y, Width, Height)
end if

ShowControl(ActivePanelControlIndex)
ShowControlGroup(ActivePanelControlGroupIndex)

end event

event shown();
if	not IsNull(ActivePanelControl) and IsValid(ActivePanelControl) then
	SizeAndPositionControl(ActivePanelControl)
end if
if	not IsNull(ActivePanelControlGroup) and IsValid(ActivePanelControlGroup) then
	ActivePanelControlGroup.Resize(XOffset + X, YOffset + Y, Width, Height)
end if

ShowControl(ActivePanelControlIndex)
ShowControlGroup(ActivePanelControlGroupIndex)

end event

public function integer showcontrol (integer panelcontrolindex);
if	panelControlIndex < 1 or panelControlIndex > UpperBound(PanelControls) then return FAILURE
if	isnull (PanelControls[panelControlIndex]) then return FAILURE
if	not IsValid(PanelControls[panelControlIndex]) then return FAILURE

dragobject panelControl
panelControl = PanelControls[panelControlIndex]

if	panelControlIndex = ActivePanelControlIndex then
	if	panelControl.Visible then
		panelControl.Show()
	end if
	panelControl.BringToTop = true
	panelControl.triggerevent("shown")
	return NO_ACTION
end if

SizeAndPositionControl(panelControl)
panelControl.Show()
panelControl.BringToTop = true
panelControl.triggerevent("shown")
HideControl(ActivePanelControlIndex)
HideControlGroup(ActivePanelControlGroupIndex)	
ActivePanelControlIndex = panelControlIndex
ActivePanelControl = panelControl
return success

end function

protected function integer hidecontrol (integer panelcontrolindex);
if	panelControlIndex < 1 or panelControlIndex > UpperBound(PanelControls) then return FAILURE
if	isnull (PanelControls[panelControlIndex]) then return FAILURE
if	not IsValid(PanelControls[panelControlIndex]) then return FAILURE

dragobject panelControl
panelControl = PanelControls[panelControlIndex]
panelControl.Hide()
ActivePanelControlIndex = -1
SetNull(ActivePanelControl)
return success

end function

public function integer getpanelparentwindow ();
powerobject		parentPO
parentPO = GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (parentPO)
	if	parentPO.TypeOf() <> window! then
		parentPO = parentPO.GetParent()
	else
		exit
	end if
loop

if	IsNull(parentPO) or not IsValid(parentPO) then
	setnull(PanelParentWindow)	
	return FAILURE
end If

PanelParentWindow = parentPO
return SUCCESS

end function

public function integer getcontrolindex (ref dragobject panelcontrol);
int	i, count
count = UpperBound(PanelControls)
for	i = 1 to count
	if	IsNull(PanelControls[i]) then continue
	if	not IsValid(PanelControls[i]) then continue
	if	PanelControls[i] = panelControl then return i
next
return -1

end function

public function integer addpanelcontrol (ref dragobject panelcontrol, ref integer panelcontrolindex);
if	isnull(panelControl) then return FAILURE
if	not IsValid(panelControl) then return FAILURE
panelControl.Hide()

//	Check to see if this control is already registered.
panelControlIndex = GetControlIndex(panelControl)
if	panelControlIndex = -1 then
	PanelControls[UpperBound(PanelControls) + 1] = panelControl
	PanelControlCount = UpperBound(PanelControls)
	panelControlIndex = PanelControlCount
end if

return SUCCESS

end function

public function integer showcontrol (ref dragobject panelcontrol);
return ShowControl(GetControlIndex(panelControl))

end function

public function integer addpanelcontrol (ref dragobject panelcontrol);
int discardedIndex
return AddPanelControl(panelControl, discardedIndex)

end function

protected function integer sizeandpositioncontrol (dragobject panelcontrol);
if	isnull(panelControl) or not IsValid(panelControl) then return failure

//panelControl.BringToTop = true
panelControl.Move (XOffset + X, YOffset +  Y)
panelControl.Resize (Width, Height)
//panelControl.BringToTop = true
return SUCCESS

end function

public function integer getcontrolgroupindex (string name);
int	i, count
count = UpperBound(PanelControlGroups)
for	i = 1 to count
	if	IsNull(PanelControlGroups[i]) then continue
	if	not IsValid(PanelControlGroups[i]) then continue
	if	PanelControlGroups[i].GroupName = name then return i
next
return -1

end function

public function integer addpanelcontroltogroup (string groupname, ref dragobject groupcontrol, integer controlwidth, integer controlheight, ref integer panelcontrolgroupcontrolindex);
if	isnull(groupName) then return FAILURE
if	isnull(groupControl) or not IsValid(groupControl) then return FAILURE

//	Check to see if this control group is already registered.
int panelControlGroupIndex
panelControlGroupIndex = GetControlGroupIndex(groupName)
if	panelControlGroupIndex = -1 then return FAILURE

//	Make panelControl nonvisible.
return PanelControlGroups[panelControlGroupIndex].AddGroupControl(groupControl, controlWidth, controlHeight, panelControlGroupControlIndex)

end function

protected function integer hidecontrolgroup (integer panelcontrolgroupindex);
if	panelControlGroupIndex < 1 or panelControlGroupIndex > UpperBound(PanelControlGroups) then return FAILURE
if	isnull (PanelControlGroups[panelControlGroupIndex]) then return FAILURE
if	not IsValid(PanelControlGroups[panelControlGroupIndex]) then return FAILURE

PanelControlGroups[panelControlGroupIndex].Hide()
ActivePanelControlGroupIndex = -1
SetNull(ActivePanelControlGroup)
return SUCCESS

end function

public function integer showcontrolgroup (integer panelcontrolgroupindex);
if	panelControlGroupIndex < 1 or panelControlGroupIndex > UpperBound(PanelControlGroups) then return FAILURE
if	isnull (PanelControlGroups[panelControlGroupIndex]) then return FAILURE
if	not IsValid(PanelControlGroups[panelControlGroupIndex]) then return FAILURE

if	panelControlGroupIndex = ActivePanelControlGroupIndex then
	ActivePanelControlGroup.Resize(XOffset + X, YOffset +  Y, Width, Height)
	return ActivePanelControlGroup.Show()
end if

PanelControlGroups[panelControlGroupIndex].Show()
PanelControlGroups[panelControlGroupIndex].Resize(XOffset + X, YOffset +  Y, Width, Height)
HideControl(ActivePanelControlIndex)
HideControlGroup(ActivePanelControlGroupIndex)	
ActivePanelControlGroupIndex = panelControlGroupIndex
ActivePanelControlGroup = PanelControlGroups[panelControlGroupIndex]
return SUCCESS

end function

public function integer showcontrolgroup (string groupname);
return ShowControlGroup(GetControlGroupIndex(groupName))

end function

public function integer addpanelcontrolgroup (string name, integer orientation, ref integer panelcontrolgroupindex);
if	isnull(name) then return FAILURE

//	Check to see if this control group is already registered.
panelControlGroupIndex = GetControlGroupIndex(name)
if	panelControlGroupIndex = -1 then
	PanelControlGroupCount = UpperBound(PanelControlGroups) + 1
	panelControlGroupIndex = PanelControlGroupCount
	PanelControlGroups[panelControlGroupIndex] = create n_panelcontrolgroup
	PanelControlGroups[panelControlGroupIndex].GroupName = name
	PanelControlGroups[panelControlGroupIndex].Orientation = orientation
end if

return SUCCESS

end function

public function integer addpanelcontrolgroup (string name, integer orientation);
int discardedIndex
return AddPanelControlGroup(name, orientation, discardedIndex)

end function

public function integer addpanelcontroltogroup (string groupname, ref dragobject groupcontrol, integer controlwidth, integer controlheight);
int discardedIndex
return AddPanelControlToGroup(groupName, groupControl, controlWidth, controlHeight, discardedIndex)

end function

public function integer setactivecontrol (integer panelcontrolindex);
if	panelControlIndex < 1 or panelControlIndex > UpperBound(PanelControls) then return FAILURE
if	isnull (PanelControls[panelControlIndex]) then return FAILURE
if	not IsValid(PanelControls[panelControlIndex]) then return FAILURE
if	panelControlIndex = ActivePanelControlIndex then
	return NO_ACTION
end if

dragobject panelControl
panelControl = PanelControls[panelControlIndex]
SizeAndPositionControl(panelControl)
HideControl(ActivePanelControlIndex)
HideControlGroup(ActivePanelControlGroupIndex)	
ActivePanelControlIndex = panelControlIndex
ActivePanelControl = panelControl
return success

end function

public function integer setactivecontrol (ref dragobject panelcontrol);
return SetActiveControl(GetControlIndex(panelControl))

end function

on u_panel.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on u_panel.destroy
call super::destroy
destroy(this.st_1)
end on

event constructor;call super::constructor;
Hide()
st_1.Hide()
GetPanelParentWindow()

end event

event resize;call super::resize;
if	not IsNull(ActivePanelControl) and IsValid(ActivePanelControl) then
	SizeAndPositionControl(ActivePanelControl)
end if
if	not IsNulL(ActivePanelControlGroup) and IsValid(ActivePanelControlGroup) then
	ActivePanelControlGroup.Resize(XOffset + X, YOffset + Y, newWidth, newHeight)
end if

ShowControl(ActivePanelControlIndex)
ShowControlGroup(ActivePanelControlGroupIndex)

end event

type st_1 from statictext within u_panel
integer x = 5
integer y = 4
integer width = 1202
integer height = 220
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Panel"
boolean focusrectangle = false
end type


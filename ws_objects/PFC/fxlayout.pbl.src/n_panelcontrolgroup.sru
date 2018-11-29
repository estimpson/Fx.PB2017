$PBExportHeader$n_panelcontrolgroup.sru
forward
global type n_panelcontrolgroup from n_base
end type
end forward

global type n_panelcontrolgroup from n_base
end type
global n_panelcontrolgroup n_panelcontrolgroup

type variables

constant int HORIZONTAL = 1
constant int VERTICAL = 2

int Orientation = VERTICAL
dragobject GroupControls[]
int ControlWidths[]
int ControlHeights[]
int LastVariableSizedControl
string GroupName

end variables

forward prototypes
public function integer addgroupcontrol (ref dragobject groupcontrol, integer controlwidth, integer controlheight, ref integer groupcontrolindex)
public function integer getcontrolindex (ref dragobject groupcontrol)
public function integer hide ()
public function integer show ()
public function integer resize (integer x, integer y, integer width, integer height)
end prototypes

public function integer addgroupcontrol (ref dragobject groupcontrol, integer controlwidth, integer controlheight, ref integer groupcontrolindex);
if	isnull(groupControl) then return FAILURE
if	not IsValid(groupControl) then return FAILURE
groupControl.Hide()

//	Check to see if this control is already registered.
groupControlIndex = GetControlIndex(groupControl)
if	groupControlIndex = -1 then
	groupControlIndex = UpperBound(GroupControls) + 1
	GroupControls[groupControlIndex] = groupControl
	ControlWidths[groupControlIndex] = controlWidth
	ControlHeights[groupControlIndex] = controlHeight
end if

return SUCCESS

end function

public function integer getcontrolindex (ref dragobject groupcontrol);
int	i, count
count = UpperBound(GroupControls)
for	i = 1 to count
	if	IsNull(GroupControls[i]) then continue
	if	not IsValid(GroupControls[i]) then continue
	if	GroupControls[i] = groupControl then return i
next
return -1

end function

public function integer hide ();
int i
for	i = 1 to UpperBound(GroupControls)
	if	IsNull(GroupControls[i]) then continue
	if	not IsValid(GroupControls[i]) then continue
	GroupControls[i].Hide()
next
return SUCCESS

end function

public function integer show ();
int i
for	i = 1 to UpperBound(GroupControls)
	if	IsNull(GroupControls[i]) then continue
	if	not IsValid(GroupControls[i]) then continue
	GroupControls[i].Show()
	GroupControls[i].BringToTop = true
	GroupControls[i].triggerevent("shown")
next
return SUCCESS

end function

public function integer resize (integer x, integer y, integer width, integer height);
int floatSpace = 0, remainingFloatSpace = 0
int floatFraction = 0
int i

//	First pass to calculate float space and total fraction.
if	Orientation = HORIZONTAL then
	floatSpace = width
	for	i = 1 to UpperBound(GroupControls)
		if	ControlWidths[i] >= 0 then
			floatSpace -= ControlWidths[i]
		else
			floatFraction += -ControlWidths[i]
			LastVariableSizedControl = i
		end if
	next
elseif Orientation = VERTICAL then
	floatSpace = height
	for	i = 1 to UpperBound(GroupControls)
		if	ControlHeights[i] >= 0 then
			floatSpace -= ControlHeights[i]
		else
			floatFraction += -ControlHeights[i]
			LastVariableSizedControl = i
		end if
	next
else
	return FAILURE
end if
if	floatSpace < 0 then
	floatSpace = 0
end if
remainingFloatSpace = floatSpace

//	Resize and position controls.
int offset = 0
if	Orientation = HORIZONTAL then
	for i = 1 to UpperBound(GroupControls)
		GroupControls[i].Move(x + offset, y)
		if	ControlWidths[i] >= 0 then
			GroupControls[i].Resize(ControlWidths[i], height)
			offset += ControlWidths[i]
		elseif LastVariableSizedControl = i then
			GroupControls[i].Resize(remainingFloatSpace, height)
			offset += remainingFloatSpace
			remainingFloatSpace = 0
		else
			GroupControls[i].Resize(remainingFloatSpace * -ControlWidths[i] / floatFraction, height)
			offset += remainingFloatSpace * -ControlWidths[i] / floatFraction
			remainingFloatSpace -= remainingFloatSpace * -ControlWidths[i] / floatFraction
		end if
	next
else
	for i = 1 to UpperBound(GroupControls)
		GroupControls[i].Move(x, y + offset)
		if	ControlHeights[i] >= 0 then
			GroupControls[i].Resize(width, ControlHeights[i])
			offset += ControlHeights[i]
		elseif LastVariableSizedControl = i then
			GroupControls[i].Resize(width, remainingFloatSpace)
			offset += remainingFloatSpace
			remainingFloatSpace = 0
		else
			GroupControls[i].Resize(width, remainingFloatSpace * -ControlHeights[i] / floatFraction)
			offset += remainingFloatSpace * -ControlHeights[i] / floatFraction
			remainingFloatSpace -= remainingFloatSpace * -ControlHeights[i] / floatFraction
		end if
	next
end if

return SUCCESS

end function

on n_panelcontrolgroup.create
call super::create
end on

on n_panelcontrolgroup.destroy
call super::destroy
end on


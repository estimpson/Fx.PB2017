$PBExportHeader$u_panel_splitterbase.sru
forward
global type u_panel_splitterbase from u_base
end type
type uo_2 from u_panel within u_panel_splitterbase
end type
type uo_1 from u_panel within u_panel_splitterbase
end type
type st_1 from u_st_splitbar within u_panel_splitterbase
end type
end forward

global type u_panel_splitterbase from u_base
integer width = 2679
integer height = 1648
long backcolor = 1073741824
event shown ( )
event move pbm_move
uo_2 uo_2
uo_1 uo_1
st_1 st_1
end type
global u_panel_splitterbase u_panel_splitterbase

type variables

// Offsets for parent containers.
int _xOffset
int _yOffset

end variables

forward prototypes
public function integer setsplitter (integer splitterpercentage)
public function integer enablesplitter ()
public function integer disablesplitter ()
public function integer getcontaineroffset ()
end prototypes

event shown();
GetContainerOffset()

uo_1.XOffset = x + _xOffset
uo_1.YOffset = y + _yOffset
uo_1.event shown()

uo_2.XOffset = x + _xOffset
uo_2.YOffset = y + _yOffset
uo_2.event shown()

end event

event move;
GetContainerOffset()

uo_1.XOffset = xpos + _xOffset
uo_1.YOffset = ypos + _yOffset
uo_1.event shown()
//uo_1.event move(uo_1.x, uo_1.y)

uo_2.XOffset = xpos + _xOffset
uo_2.YOffset = ypos + _yOffset
uo_2.event shown()
//uo_2.event move(uo_2.x, uo_2.y)

end event

public function integer setsplitter (integer splitterpercentage);
if	splitterPercentage < 0 then
	splitterPercentage = 0
elseif	splitterPercentage > 100 then
	splitterPercentage = 100
end if

int splitterMargin

splitterMargin = st_1.X - (uo_1.X + uo_1.Width)
uo_1.Width = (width - st_1.width - 2 * splitterMargin) * splitterPercentage / 100
st_1.X = uo_1.Width + splitterMargin
uo_2.X = uo_1.Width + 2 * splitterMargin + st_1.Width
uo_2.Width = (width - st_1.width - 2 * splitterMargin) - uo_1.Width

of_SetResize(false)
of_SetResize(true)
inv_Resize.of_SetOrigSize(uo_1.X + uo_2.X + uo_2.Width, 2 * uo_2.Y + uo_2.Height)
inv_Resize.of_Register(uo_1, 0, 0, splitterPercentage, 100)
inv_Resize.of_Register(st_1, splitterPercentage, 0, 0, 100)
inv_Resize.of_Register(uo_2, splitterPercentage, 0, 100 - splitterPercentage, 100)

return SUCCESS

end function

public function integer enablesplitter ();
st_1.Visible = true
return SUCCESS

end function

public function integer disablesplitter ();
st_1.Visible = false
return SUCCESS

end function

public function integer getcontaineroffset ();
powerobject parentPObject

//	Loop getting the parent of the object until it is of type window!
_xOffset = 0
_yOffset = 0

parentPObject = GetParent()
do while IsValid (parentPObject)
	if	parentPObject.TypeOf() = window! then exit
	if	parentPObject.TypeOf() = tab! then
		tab tabObject
		tabObject = parentPObject
		_xOffset += tabObject.X
		_yOffset += tabObject.Y
	end if
	parentPObject = parentPObject.GetParent()
loop

return SUCCESS

end function

event constructor;call super::constructor;
of_SetResize(true)
inv_Resize.of_SetOrigSize(uo_1.X + uo_2.X + uo_2.Width, 2 * uo_2.Y + uo_2.Height)
inv_Resize.of_Register(uo_1, 0, 0, 0, 100)
inv_Resize.of_Register(st_1, 0, 0, 0, 100)
inv_Resize.of_Register(uo_2, 0, 0, 100, 100)

st_1.post of_Register(uo_1, st_1.LEFT)
st_1.post of_Register(uo_2, st_1.RIGHT)

end event

on u_panel_splitterbase.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_1
end on

on u_panel_splitterbase.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.st_1)
end on

event resize;call super::resize;
GetContainerOffset()

uo_1.XOffset = x + _xOffset
uo_1.YOffset = y + _yOffset
uo_1.event shown()

uo_2.XOffset = x + _xOffset
uo_2.YOffset = y + _yOffset
uo_2.event shown()

end event

type uo_2 from u_panel within u_panel_splitterbase
integer x = 1216
integer width = 1189
integer height = 1476
integer taborder = 20
end type

on uo_2.destroy
call u_panel::destroy
end on

type uo_1 from u_panel within u_panel_splitterbase
integer width = 1184
integer height = 1476
integer taborder = 10
end type

on uo_1.destroy
call u_panel::destroy
end on

type st_1 from u_st_splitbar within u_panel_splitterbase
integer x = 1189
integer width = 23
integer height = 1476
end type

event mousemove;call super::mousemove;
if	not KeyDown(keyLeftButton!) then
	return
end if

BringToTop = true
parent.BringToTop = true
BringToTop = true

end event

event lbuttonup;
of_lbuttonup(flags, xpos, ypos)
uo_1.event Shown()
uo_2.event Shown()

end event


﻿$PBExportHeader$u_tabpg_inventory_control_breakout.sru
forward
global type u_tabpg_inventory_control_breakout from u_tabpg_dw
end type
type dw_2 from u_fxdw within u_tabpg_inventory_control_breakout
end type
type gb_2 from groupbox within u_tabpg_inventory_control_breakout
end type
end forward

global type u_tabpg_inventory_control_breakout from u_tabpg_dw
integer width = 4402
dw_2 dw_2
gb_2 gb_2
end type
global u_tabpg_inventory_control_breakout u_tabpg_inventory_control_breakout

type variables

Private:
//	Controller reference.
n_inventory_control_controller _myController

string _operator
decimal _qtyPerObject
string _unit, _labelFormat, _packageType
int _batchFlag, _objectCount
long _breakoutSerialList[]

end variables

forward prototypes
public function integer setoperator (string operator)
public function integer setbreakoutobjectlist (long seriallist[])
public function integer refresh ()
public function integer donewithbreakout ()
public function integer dobreakout ()
end prototypes

public function integer setoperator (string operator);
_operator = operator
return Refresh()

end function

public function integer setbreakoutobjectlist (long seriallist[]);
_breakoutSerialList = serialList
SetNull(_packageType)
return Refresh()

end function

public function integer refresh ();
dw_2.of_Refresh(Refreshing) ; Refreshing = false
dw_2.event pfc_retrieve()

return super::refresh()

end function

public function integer donewithbreakout ();
if	not Isvalid(_myController) then return FAILURE

_operator = ""
_batchFlag = 0
_qtyPerObject = 0
_unit = ""
_objectCount = 0

long emptyList[]
_breakoutSerialList = emptyList

return _myController.EndInventoryCommand()

end function

public function integer dobreakout ();
if	dw_2.GetRow()<=0 or dw_2.GetRow() > dw_2.RowCount() then return FAILURE
if	not Isvalid(_myController) then return FAILURE

//string batchSerials
//batchSerials = dw_2.Object.BreakoutSerial[dw_2.GetRow()]

long batchSerials[]

if	_batchFlag = 1 then
	batchSerials = _breakoutSerialList
else
	batchSerials[1] = _breakoutSerialList[1]
end if

_myController.Breakout(batchSerials, _qtyPerObject, _unit, _packageType, _objectCount, _labelFormat)

Refresh()

if	dw_1.RowCount() = 0 then
	return DoneWithBreakout()
end if

return SUCCESS

end function

on u_tabpg_inventory_control_breakout.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on u_tabpg_inventory_control_breakout.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
of_SetResize(false)
of_SetResize(true)
inv_Resize.of_SetOrigSize(gb_2.X + gb_2.Width, gb_2.Y + gb_2.Height)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)
inv_Resize.of_Register(gb_2, 100, 0, 0, 100)
inv_Resize.of_Register(dw_2, 100, 0, 0, 100)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_inventory_control_breakout
integer taborder = 0
string text = "Breakout Object List"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_inventory_control_breakout
string dataobject = "d_inventorycontrol_breakoutobjectlist"
boolean showpowerfilter = false
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_breakoutSerialList, _qtyPerObject, _unit, _objectcount)

end event

type dw_2 from u_fxdw within u_tabpg_inventory_control_breakout
integer x = 1824
integer y = 80
integer width = 2290
integer height = 996
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_usp_inventorycontrol_breakoutrequest"
boolean vscrollbar = false
end type

event pfc_retrieve;call super::pfc_retrieve;
string breakoutSerialList
int i, count
count = UpperBound(_breakoutSerialList)
for	i = 1 to count
	breakoutSerialList += string(_breakoutSerialList[i]) + ","
next

datawindowchild dwcUnit
if	GetChild("Unit", dwcUnit) = 1 then
	dwcUnit.SetTransObject(SQLCA)
	dwcUnit.Retrieve(breakoutSerialList)
end if

datawindowchild dwcPackageType
if	GetChild("PackageType", dwcPackageType) = 1 then
	dwcPackageType.SetTransObject(SQLCA)
	dwcPackageType.Retrieve(breakoutSerialList)
end if

if	Retrieve(_operator, _batchFlag, _labelFormat, _qtyPerObject, _unit, _packageType, _objectCount, breakoutSerialList) > 0 then
	_unit = Object.Unit[1]
	_packageType = Object.PackageType[1]
	_labelFormat = Object.LabelFormat[1]
end if

return RowCount()

end event

event constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.Name)
	case lower("BatchFlag")
		_batchFlag = long(data)
	case lower("QtyPerObject")
		_qtyPerObject = dec(data)
	case lower("Unit")
		_unit = data
	case lower("PackageType")
		_packageType = trim(data)
	case lower("LabelFormat")
		_labelFormat = data
	case lower("ObjectCount")
		_objectCount = long(data)
end choose

parent.Refresh()

end event

event clicked;call super::clicked;
choose case lower(dwo.Name)
	case lower("p_ok")
		DoBreakout()
	case lower("p_cancel")
		DoneWithBreakout()
end choose

end event

type gb_2 from groupbox within u_tabpg_inventory_control_breakout
integer x = 1815
integer width = 2309
integer height = 1084
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Breakout"
end type

$PBExportHeader$u_customdropdown.sru
forward
global type u_customdropdown from u_resizeablepanel
end type
end forward

global type u_customdropdown from u_resizeablepanel
event type integer pfc_dropdown ( )
end type
global u_customdropdown u_customdropdown

type variables
Public:
// Datawindow Register columnStyle.
constant integer DDSTYLE_NONE = 1
constant integer DDSTYLE_DDLB = 2
constant integer DDSTYLE_DDLB_WITHARROW = 3

constant integer COLTYPE_STRING = 1
constant integer COLTYPE_NUMERIC = 2
constant integer COLTYPE_DATE = 3
constant integer COLTYPE_TIME = 4
constant integer COLTYPE_DATETIME = 5

constant integer INVALID_CONTROL = -3

n_cst_dropdown	DropDownController

integer ii_registry

Protected:
// Internal attibutes.
n_customdropdownattrib CustomDropDownAttrib
dragobject RequestorDO
datawindow RequestorDW

//API accessible attributes - DataWindow only attributes.
n_customdropdownattrib CustomDropDowns[]
n_cst_associative_array CustomControlsDictionary

end variables

forward prototypes
public function integer setrequestor (dragobject requestor)
public function integer dropdown ()
public function integer register (string customcontroltype, integer columntype, string columnname, integer dropdownstyle, boolean defaultdropdown)
public function integer getdefaultcustomcontrolindex (string columnname, ref integer customcontrolindex)
public function integer register (ref u_customdropdowncontrol customcontrol, integer columntype, string columnname, integer dropdownstyle)
public function integer isregistered (ref u_customdropdowncontrol customcontrol, string columnname, ref boolean isregistered)
end prototypes

event type integer pfc_dropdown();
return DropDown()

end event

public function integer setrequestor (dragobject requestor);
dragobject invalidDO
editmask editMaskDO

// Validate arguments.
if	IsNull(requestor) or not IsValid(requestor) then
	return failure
end if

// Invalidate references.
RequestorDO = invalidDO
RequestorDW = invalidDO

// Make sure it is one of the expected type and get the 
// parent window reference.
choose case TypeOf(requestor)
	case DataWindow!
		RequestorDW = requestor
	case else
		return FAILURE
end choose

// Set the generic reference.
RequestorDO = requestor

return SUCCESS

end function

public function integer dropdown ();
//	Check the required references.
if	IsNull(DropDownController) or not IsValid(DropDownController) or IsNull(RequestorDW) or not IsValid(RequestorDW) then
	return FAILURE
end if

//	Datawindow control specific checks.
//	Get the current column name.
string currentColumnName
currentColumnName = RequestorDW.GetColumnName()

//	Check if column is in the search column array.
int customControlIndex
if	GetDefaultCustomControlIndex(currentColumnName, customControlIndex) <> SUCCESS then
	return NO_ACTION
end if
if	not customControlIndex > 0 then
	return FAILURE
end if

//	Validate that it is still correct type.
//return FAILURE

//	Set this object on its new Position.
int positionReturn
DropDownController.of_SetRequestor(PanelControls[customControlIndex])
positionReturn = DropDownController.of_Position(RequestorDW, false)
if	positionReturn < 0 then
	return FAILURE
end if

//	Show the custom drop down.
u_customdropdownControl customDropDownControl
customDropDownControl = PanelControls[customControlIndex]
customDropDownControl.SetRequestor(RequestorDW)

// Bring focus on the note.
SetFocus(customDropDownControl)
customDropDownControl.event ShowDropDown()

//ShowControl(customControlIndex)

return SUCCESS

end function

public function integer register (string customcontroltype, integer columntype, string columnname, integer dropdownstyle, boolean defaultdropdown);
//	Check the required references.
if	IsNull(RequestorDW) or not IsValid(RequestorDW) then
	return FAILURE
end if

//	Attempt to get the custom control from the dictionary.
u_customdropdowncontrol customControl
customControl = IsNull(CustomControlsDictionary.of_GetItem(customControlType), customControl)
if	IsNull(customControl) or not IsValid(customControl) then
	//	New custom, try creating.
	PanelParentWindow.OpenUserObject(customControl, customControlType)
	if	not IsValid(customControl) then
		return FAILURE
	else
		CustomControlsDictionary.of_SetItem(customControlType, customControl)
	end if
end if

//	Verify specified custom control is a descendent of u_customdropdown.

//	Check arguments.
if	columnType < COLTYPE_STRING or columnType > COLTYPE_DATETIME then
	return FAILURE
end if

//	Normalize column name.
columnName = Trim(Lower(columnName))

//	Check if the column is already registered to this custom control.
boolean isRegistered
if	IsRegistered(customControl, columnName, isRegistered) = FAILURE then
	return FAILURE
end if
if	isRegistered then
	return NO_ACTION
end if

//	Get the column type.
string dwColumnType
dwColumntype = RequestorDW.Describe(columnName + ".coltype")

//	Validate column type.

//	Look for open slot or add to end.
int	newDropDownIndex = 0
int i, customDropDownCount
customDropDownCount = UpperBound(CustomDropDowns)
for	i = 1 to customDropDownCount
	if	Len(String(IsNull(CustomDropDowns[i].columnName, ""))) = 0 then
		newDropDownIndex = i
		exit
	end if
next
if	newDropDownIndex = 0 then
	newDropDownIndex = customDropDownCount + 1
end if

//	Add/initialize new entry.
//		Store modify expression needed to unregister the column
string	restoreModifyExpression = "", modifyExpression = "", originalEditStyle, describeReturn
if	dropDownStyle = DDSTYLE_DDLB or dropDownStyle = DDSTYLE_DDLB_WITHARROW then
	originalEditStyle = RequestorDW.Describe(columnName + ".Edit.Style")
	choose case lower(originalEditStyle)
		case "edit"
			describeReturn = RequestorDW.Describe(columnName + ".Edit.Required")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + "Edit.Required=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.Required=" + describeReturn + " "
			end if
			describeReturn = RequestorDW.Describe(columnName + ".Edit.NilIsNull")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + ".Edit.NilIsNull=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.NilIsNull=" + describeReturn + " "
			end if
				
		case "editmask"
			describeReturn = RequestorDW.Describe(columnName + ".EditMask.Mask")
			if	describeReturn = "?" or describeReturn = "!" then
				restoreModifyExpression += columnName + ".EditMask.Mask='' "
			else
				restoreModifyExpression += columnName + ".EditMask.Mask='" + describeReturn + "' "
			end if
			describeReturn = RequestorDW.Describe(columnName + ".EditMask.Required")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + "EditMask.Required=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.Required=" + describeReturn + " "
			end if
			describeReturn = RequestorDW.Describe(columnName + ".EditMask.NilIsNull")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + ".EditMask.NilIsNull=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.NilIsNull=" + describeReturn + " "
			end if
			
		case "ddlb"
			describeReturn = RequestorDW.Describe(columnName + ".DDLB.useasborder")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + ".DDLB.useasborder=" + describeReturn + " "
			end if
			
		case else
			return FAILURE
	end choose
	
	//	Convert to DDLB.
	modifyExpression += columnName + ".DDLB.limit = 0 " + columnName + ".DDLB.AllowEdit=Yes " 
end if

//		Convert to DDLB.
string modifyReturn
modifyReturn = RequestorDW.Modify(modifyExpression)
if	Len(modifyReturn) > 0 then
	return FAILURE
end if

//		Add column to the list of controls.
int customControlIndex
customControlIndex = AddPanelControl(customControl)
if	not customControlIndex >= 1 then
	RequestorDW.Modify(restoreModifyExpression)
	return FAILURE
end if

//		Record details.
CustomDropDowns[newDropDownIndex].ColumnName = columnName
CustomDropDowns[newDropDownIndex].CustomControlIndex = customControlIndex
CustomDropDowns[newDropDownIndex].DropDownStyle = dropDownStyle
CustomDropDowns[newDropDownIndex].RestoreModifyExpression = restoreModifyExpression
CustomDropDowns[newDropDownIndex].DefaultDropDown = defaultDropDown

//	Finished.
return SUCCESS

end function

public function integer getdefaultcustomcontrolindex (string columnname, ref integer customcontrolindex);
//	Check arguments.
if	Len(String(IsNull(Trim(columnName), ''))) = 0 then
	return FAILURE
end if

//	Trim column name and convert to lower case.
columnName = Trim(lower(columnName))

//	Find column name.
int i, count
count = upperbound(CustomDropDowns)
for	i = 1 to count
	if	CustomDropDowns[i].ColumnName = columnName and CustomDropDowns[i].DefaultDropDown then
		customControlIndex = CustomDropDowns[i].CustomControlIndex
		return SUCCESS
	end if
next

//	Not found.
customControlIndex = -1
return SUCCESS

end function

public function integer register (ref u_customdropdowncontrol customcontrol, integer columntype, string columnname, integer dropdownstyle);
//	Check the required references.
if	IsNull(RequestorDW) or not IsValid(RequestorDW) then
	return FAILURE
end if
if	IsNull(customControl) or not IsValid(customControl) then
	return FAILURE
end if

//	Verify specified custom control is a descendent of u_customdropdown.

//	Check arguments.
if	columnType < COLTYPE_STRING or columnType > COLTYPE_DATETIME then
	return FAILURE
end if

//	Normalize column name.
columnName = Trim(Lower(columnName))

//	Check if the column is already registered to this custom control.
boolean isRegistered
if	IsRegistered(customControl, columnName, isRegistered) = FAILURE then
	return FAILURE
end if
if	isRegistered then
	return NO_ACTION
end if

//	Get the column type.
string dwColumnType
dwColumntype = RequestorDW.Describe(columnName + ".coltype")

//	Validate column type.

//	Look for open slot or add to end.
int	newDropDownIndex = 0
int i, customDropDownCount
customDropDownCount = UpperBound(CustomDropDowns)
for	i = 1 to customDropDownCount
	if	Len(String(IsNull(CustomDropDowns[i].columnName, ""))) = 0 then
		newDropDownIndex = i
		exit
	end if
next
if	newDropDownIndex = 0 then
	newDropDownIndex = customDropDownCount + 1
end if

//	Add/initialize new entry.
//		Store modify expression needed to unregister the column
string	restoreModifyExpression = "", modifyExpression = "", originalEditStyle, describeReturn
if	dropDownStyle = DDSTYLE_DDLB or dropDownStyle = DDSTYLE_DDLB_WITHARROW then
	originalEditStyle = RequestorDW.Describe(columnName + ".Edit.Style")
	choose case lower(originalEditStyle)
		case "edit"
			describeReturn = RequestorDW.Describe(columnName + ".Edit.Required")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + "Edit.Required=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.Required=" + describeReturn + " "
			end if
			describeReturn = RequestorDW.Describe(columnName + ".Edit.NilIsNull")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + ".Edit.NilIsNull=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.NilIsNull=" + describeReturn + " "
			end if
				
		case "editmask"
			describeReturn = RequestorDW.Describe(columnName + ".EditMask.Mask")
			if	describeReturn = "?" or describeReturn = "!" then
				restoreModifyExpression += columnName + ".EditMask.Mask='' "
			else
				restoreModifyExpression += columnName + ".EditMask.Mask='" + describeReturn + "' "
			end if
			describeReturn = RequestorDW.Describe(columnName + ".EditMask.Required")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + "EditMask.Required=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.Required=" + describeReturn + " "
			end if
			describeReturn = RequestorDW.Describe(columnName + ".EditMask.NilIsNull")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + ".EditMask.NilIsNull=" + describeReturn + " "
				modifyExpression += columnName + ".DDLB.NilIsNull=" + describeReturn + " "
			end if
			
		case "ddlb"
			describeReturn = RequestorDW.Describe(columnName + ".DDLB.useasborder")
			if	describeReturn = "yes" or describeReturn = "no" then
				restoreModifyExpression += columnName + ".DDLB.useasborder=" + describeReturn + " "
			end if
			
		case else
			return FAILURE
	end choose
	
	//	Convert to DDLB.
	modifyExpression += columnName + ".DDLB.limit = 0 " + columnName + ".DDLB.AllowEdit=Yes " 
end if

//		Convert to DDLB.
string modifyReturn
modifyReturn = RequestorDW.Modify(modifyExpression)
if	Len(modifyReturn) > 0 then
	return FAILURE
end if

//		Add column to the list of controls.
int customControlIndex
customControlIndex = AddPanelControl(customControl)
if	not customControlIndex >= 1 then
	RequestorDW.Modify(restoreModifyExpression)
	return FAILURE
end if

//		Record details.
CustomDropDowns[newDropDownIndex].ColumnName = columnName
CustomDropDowns[newDropDownIndex].CustomControlIndex = customControlIndex
CustomDropDowns[newDropDownIndex].DropDownStyle = dropDownStyle
CustomDropDowns[newDropDownIndex].RestoreModifyExpression = restoreModifyExpression

//	Finished.
return SUCCESS

end function

public function integer isregistered (ref u_customdropdowncontrol customcontrol, string columnname, ref boolean isregistered);
//	Check arguments.
if	Len(String(IsNull(Trim(columnName), ''))) = 0 then
	return FAILURE
end if

//	Trim column name and convert to lower case.
columnName = Trim(lower(columnName))

//	Find column name.
int customControlIndex, i, count
customControlIndex = GetControlIndex(customControl)
count = upperbound(CustomDropDowns)
for	i = 1 to count
	if	CustomDropDowns[i].columnName = columnName and CustomDropDowns[i].customControlIndex = customControlIndex then
		isRegistered = true
		return SUCCESS
	end if
next

//	Not found.
isRegistered = false
return SUCCESS

end function

on u_customdropdown.create
call super::create
end on

on u_customdropdown.destroy
call super::destroy
end on

event constructor;call super::constructor;
DropDownController = create n_cst_dropdown
DropDownController.of_SetRequestor(this)

end event

event destructor;call super::destructor;
destroy DropDownController

end event

type st_1 from u_resizeablepanel`st_1 within u_customdropdown
end type


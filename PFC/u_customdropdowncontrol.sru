HA$PBExportHeader$u_customdropdowncontrol.sru
forward
global type u_customdropdowncontrol from u_base
end type
end forward

global type u_customdropdowncontrol from u_base
event showdropdown ( )
end type
global u_customdropdowncontrol u_customdropdowncontrol

type variables

datawindow RequestorDW

end variables

forward prototypes
public function integer setrequestor (dragobject requestor)
end prototypes

event showdropdown();
Visible = true

end event

public function integer setrequestor (dragobject requestor);
dragobject invalidDO
editmask editMaskDO

// Validate arguments.
if	IsNull(requestor) or not IsValid(requestor) then
	return failure
end if

// Invalidate references.
RequestorDW = invalidDO

// Make sure it is one of the expected type and get the 
// parent window reference.
choose case TypeOf(requestor)
	case DataWindow!
		RequestorDW = requestor
	case else
		return FAILURE
end choose

return SUCCESS

end function

on u_customdropdowncontrol.create
call super::create
end on

on u_customdropdowncontrol.destroy
call super::destroy
end on


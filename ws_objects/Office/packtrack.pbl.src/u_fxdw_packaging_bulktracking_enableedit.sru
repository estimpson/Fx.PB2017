$PBExportHeader$u_fxdw_packaging_bulktracking_enableedit.sru
forward
global type u_fxdw_packaging_bulktracking_enableedit from u_fxdw
end type
end forward

global type u_fxdw_packaging_bulktracking_enableedit from u_fxdw
integer width = 1376
integer height = 1072
string dataobject = "d_packaging_bulktracking_enableedit"
boolean vscrollbar = false
boolean livescroll = false
end type
global u_fxdw_packaging_bulktracking_enableedit u_fxdw_packaging_bulktracking_enableedit

type variables

//	Model data.
string _packageCode

end variables

forward prototypes
public function integer setpackagecode (string packagecode)
end prototypes

public function integer setpackagecode (string packagecode);
_packageCode = packageCode
return Refresh()

end function

on u_fxdw_packaging_bulktracking_enableedit.create
call super::create
end on

on u_fxdw_packaging_bulktracking_enableedit.destroy
call super::destroy
end on

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_packageCode)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

n_packaging_bulk_controller myController
myController = myParentWindow.Container.of_GetItem("Controller")
if	not IsValid(myController) or IsNull(myController) then return

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		
		int startingInHouseQty, startingOutsideQty
		datetime startingAccumDT
		startingInHouseQty = Object.StartingInHouseQuantity[1]
		startingAccumDT = Object.StartingAccumDT[1]
		
		myController.EnableTracking(_packageCode, startingInHouseQty, startingAccumDT)
		
	case "p_cancel"
		
		myController.CancelEnableTracking()
end choose

end event


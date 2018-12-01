$PBExportHeader$u_tabpg_oee_shifthistory_shiftinfo.sru
forward
global type u_tabpg_oee_shifthistory_shiftinfo from u_tabpg_dw
end type
type dw_2 from u_fxdw within u_tabpg_oee_shifthistory_shiftinfo
end type
end forward

global type u_tabpg_oee_shifthistory_shiftinfo from u_tabpg_dw
integer width = 2194
integer height = 2056
dw_2 dw_2
end type
global u_tabpg_oee_shifthistory_shiftinfo u_tabpg_oee_shifthistory_shiftinfo

type variables

Private:
//	Model data.
date _shiftDate
int _shift

//	Controller reference.
n_oee_shifthistory_controller _myController

end variables
forward prototypes
public function integer setshift (date shiftdate, integer shift)
public function integer reset ()
end prototypes

public function integer setshift (date shiftdate, integer shift);
_shiftDate = shiftDate
_shift = shift

return Refresh()


end function

public function integer reset ();
dw_1.Reset()
dw_2.Reset()
return SUCCESS

end function

on u_tabpg_oee_shifthistory_shiftinfo.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on u_tabpg_oee_shifthistory_shiftinfo.destroy
call super::destroy
destroy(this.dw_2)
end on

event constructor;call super::constructor;
//inv_Resize.of_SetOrigSize(cb_1.X + (cb_1.X - gb_1.X - gb_1.Width) + cb_1.Width, gb_1.Y * 2 + gb_1.Height)
//inv_Resize.of_Register(cb_1, 100, 0, 0, 0)
//inv_Resize.of_Register(cb_2, 100, 0, 0, 0)

//	Get the controller for this control's window.
w_master myParentWindow
of_GetParentWindow(myParentWindow)
if	not IsValid(myParentWindow) or IsNull(myParentWindow) then return

_myController = myParentWindow.Container.of_GetItem("Controller")

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_oee_shifthistory_shiftinfo
integer x = 32
integer y = 936
integer width = 1568
string text = "Cell Activity"
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_oee_shifthistory_shiftinfo
integer x = 41
integer y = 1016
integer width = 1550
string dataobject = "d_custom_oee_setcellruntimeshift"
end type

event dw_1::constructor;call super::constructor;
of_SetTransObject (SQLCA)

end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(_shiftDate, _shift)

end event

event dw_1::retrieveend;call super::retrieveend;
commit  ;
return dw_2.Retrieve(_myController.GetUser(), datetime(_shiftDate), _shift)

end event

event dw_1::clicked;call super::clicked;
if	row <= 0 or row > RowCount() then return NO_ACTION

choose case lower(dwo.Name)
	case lower("IsActive")
		if	object.IsActive[row]=1 then
			object.RunTime[row]=0
			object.IsActive[row]=0
		else
			decimal shiftMinutes
			shiftMinutes = dw_2.object.ShiftMinutes[1]
			object.RunTime[row]=shiftMinutes
			object.IsActive[row]=1
		end if
end choose

end event

event dw_1::itemchanged;call super::itemchanged;
if	row <= 0 or row > RowCount() then return NO_ACTION

choose case lower(dwo.Name)
	case lower("RunTime")
		if	dec(data) > 0 then
			object.IsActive[row]=1
		else
			object.IsActive[row]=0
		end if
end choose

end event

type dw_2 from u_fxdw within u_tabpg_oee_shifthistory_shiftinfo
integer width = 1563
integer height = 916
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_custom_oee_editshiftinfo"
boolean vscrollbar = false
boolean livescroll = false
end type

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		dw_2.AcceptText()
		dw_1.Update()
		
		decimal shiftHours
		string shiftNotes
		
		shiftHours = object.ShiftMinutes[1] / 60.0
		shiftNotes = object.ShiftNotes[1]		

		_myController.SaveShiftInfo(shiftHours, shiftNotes)
		
	case "p_cancel"
		_myController.HideEditShiftInfo()
end choose

end event

event constructor;call super::constructor;
SetTransObject(SQLCA)

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.Name)
	case lower ("ShiftMinutes")
		decimal shiftMinutes
		shiftMinutes = dec(data)
		long cellrow
		for cellrow = 1 to RowCount(dw_1)
			if dw_1.object.IsActive[cellrow]=1 then
				dw_1.object.RunTime[cellrow]=shiftMinutes
			end if
		next
end choose


end event

event editchanged;call super::editchanged;
choose case lower(dwo.Name)
	case lower ("ShiftNotes")
		AcceptText()
end choose

end event


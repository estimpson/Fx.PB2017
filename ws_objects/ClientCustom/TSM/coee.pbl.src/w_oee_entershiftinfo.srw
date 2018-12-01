$PBExportHeader$w_oee_entershiftinfo.srw
forward
global type w_oee_entershiftinfo from w_response
end type
type dw_2 from u_fxdw within w_oee_entershiftinfo
end type
type dw_1 from u_fxdw within w_oee_entershiftinfo
end type
type gb_1 from groupbox within w_oee_entershiftinfo
end type
end forward

global type w_oee_entershiftinfo from w_response
integer x = 214
integer y = 221
integer width = 1650
integer height = 2044
boolean controlmenu = false
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
end type
global w_oee_entershiftinfo w_oee_entershiftinfo

type variables

datetime _shiftDT
int _shift
end variables
on w_oee_entershiftinfo.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_oee_entershiftinfo.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;
_shiftDT = Message.inv_Parm.of_GetItem("ShiftDT")
_shift = Message.inv_Parm.of_GetItem("Shift")

dw_1.Refresh()

end event

type dw_2 from u_fxdw within w_oee_entershiftinfo
integer x = 37
integer y = 1012
integer width = 1554
integer height = 916
integer taborder = 20
string dataobject = "d_custom_oee_setcellruntimeshift"
boolean livescroll = false
end type

event constructor;call super::constructor;
SetTransObject(SQLCA)

end event

event clicked;call super::clicked;
if	row <= 0 then return NO_ACTION
if	row >= RowCount() then return FAILURE

//	Toggle active flag
int isActive
isActive = object.IsActive[row]
if	isActive = 1 then
	object.IsActive[row] = 0
else
	object.IsActive[row] = 1
end if

end event

type dw_1 from u_fxdw within w_oee_entershiftinfo
integer width = 1563
integer height = 916
integer taborder = 10
string dataobject = "d_custom_oee_editshiftinfo"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;
SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve('ees', _shiftDT, _shift)

end event

event retrieveend;call super::retrieveend;
return dw_2.Retrieve(_shiftDT, _shift)

end event

event clicked;call super::clicked;
//	Check to make sure we have a valid row.
if	row < 1 or row > RowCount() then return FAILURE

choose case dwo.Name
	case "p_ok"
		//	Begin shipout.
		AcceptText()
		dw_2.AcceptText()
		
		decimal shiftHours
		string shiftNotes
		
		shiftHours = object.ShiftMinutes[1] / 60.0
		shiftNotes = object.ShiftNotes[1]		

		
		n_oee_trans oeeTrans
		oeeTrans = create n_oee_trans
		oeeTrans.SetTransObject(SQLCA)
		
		if	oeeTrans.SetShiftInfo(_shiftDT, _shift, shiftHours, shiftNotes) = SUCCESS then
			oeeTrans.CommitTrans()
		else
			oeeTrans.RollbackTrans()
		end if
		
		destroy oeeTrans

		CloseWithReturn(parent, SUCCESS)
		
	case "p_cancel"
		Reset()
		
		CloseWithReturn(parent, NO_ACTION)
end choose

end event

type gb_1 from groupbox within w_oee_entershiftinfo
integer x = 32
integer y = 928
integer width = 1568
integer height = 1008
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Cell Activity"
borderstyle borderstyle = stylebox!
end type


$PBExportHeader$w_mes_movejob.srw
forward
global type w_mes_movejob from w_response
end type
type cb_cancel from commandbutton within w_mes_movejob
end type
type cb_ok from commandbutton within w_mes_movejob
end type
type dw_edit from u_fxdw within w_mes_movejob
end type
end forward

global type w_mes_movejob from w_response
integer x = 214
integer y = 221
integer width = 2149
integer height = 1108
string title = "Schedule Manual Job"
cb_cancel cb_cancel
cb_ok cb_ok
dw_edit dw_edit
end type
global w_mes_movejob w_mes_movejob

type variables

end variables

event pfc_preopen;call super::pfc_preopen;
long jobID
jobID = IsNull(message.inv_Parm.of_GetItem("JobID"), jobID)
if	dw_edit.Retrieve(jobID) < 1 then
	dw_edit.InsertRow(0)
end if

end event

on w_mes_movejob.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_edit=create dw_edit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_edit
end on

on w_mes_movejob.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_edit)
end on

type cb_cancel from commandbutton within w_mes_movejob
integer x = 599
integer y = 872
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
CloseWithReturn(parent, NO_ACTION)

end event

type cb_ok from commandbutton within w_mes_movejob
integer x = 110
integer y = 872
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean cancel = true
boolean default = true
end type

event clicked;
string machineCode

machineCode = dw_edit.object.NewMachineCode[dw_edit.GetRow()]
message.inv_Parm.of_SetItem("NewMachine", machineCode)
CloseWithReturn(parent, CONTINUE_ACTION)

end event

type dw_edit from u_fxdw within w_mes_movejob
integer x = 23
integer y = 28
integer width = 2048
integer height = 800
integer taborder = 10
string dataobject = "d_edit_movejob"
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetRowSelect(true)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()
of_SetUpdateable(false)
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

end event

event itemfocuschanged;call super::itemfocuschanged;
choose case lower(dwo.Name)
	case lower("SubstitutionRate")
		SelectText(1,10)
end choose

end event

event clicked;call super::clicked;
/*	If the clicked column is qty required, it is editable so set the tab. */
if	lower(dwo.Name) = lower("MachineCode") then
	object.MachineCode.TabSequence = 10
end if

end event


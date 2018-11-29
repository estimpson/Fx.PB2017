$PBExportHeader$w_ppimoldingendallocserial.srw
forward
global type w_ppimoldingendallocserial from w_response
end type
type cb_cancel from commandbutton within w_ppimoldingendallocserial
end type
type dw_1 from u_dw within w_ppimoldingendallocserial
end type
type cb_ok from commandbutton within w_ppimoldingendallocserial
end type
end forward

global type w_ppimoldingendallocserial from w_response
integer x = 214
integer y = 221
integer width = 1865
integer height = 1172
string title = "End Allocation"
boolean center = true
cb_cancel cb_cancel
dw_1 dw_1
cb_ok cb_ok
end type
global w_ppimoldingendallocserial w_ppimoldingendallocserial

type variables

string WorkOrderNumber
decimal WorkOrderDetailLine
decimal WorkOrderDetailBOMLine
long Serial

end variables

on w_ppimoldingendallocserial.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.dw_1=create dw_1
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_ok
end on

on w_ppimoldingendallocserial.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.dw_1)
destroy(this.cb_ok)
end on

event pfc_preopen;call super::pfc_preopen;
WorkOrderNumber = IsNull(message.inv_Parm.of_GetItem("WorkOrderNumber"), "")
WorkOrderDetailLine = IsNull(message.inv_Parm.of_GetItem("WorkOrderDetailLine"), -1)
WorkOrderDetailBOMLine = IsNull(message.inv_Parm.of_GetItem("WorkOrderDetailBOMLine"), -1)
Serial = IsNull(message.inv_Parm.of_GetItem("Serial"), -1)
dw_1.event pfc_Retrieve()

end event

type cb_cancel from commandbutton within w_ppimoldingendallocserial
integer x = 1385
integer y = 172
integer width = 402
integer height = 112
integer taborder = 40
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

type dw_1 from u_dw within w_ppimoldingendallocserial
integer x = 37
integer y = 48
integer width = 1271
integer height = 716
integer taborder = 30
string dataobject = "d_ppimolding_endserialalloc"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve (Serial)

end event

event itemerror;call super::itemerror;
return 1

end event

event clicked;call super::clicked;
choose case lower(dwo.name)
	case "isempty"
		if	object.isempty[1] = 1 then
			object.isempty[1] = 0
		else
			object.isempty[1] = 1
			SetColumn("estimatedqtyremaining")
		end if
end choose

end event

type cb_ok from commandbutton within w_ppimoldingendallocserial
integer x = 1385
integer y = 44
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type

event clicked;
int isEmpty
decimal estimatedQtyRemaining
string changeReason
dw_1.AcceptText()
isEmpty = dw_1.object.isempty[1]
estimatedQtyRemaining = dw_1.object.estimatedqtyremaining[1]
changeReason = dw_1.object.changereason[1]
message.inv_Parm.of_SetItem("IsEmpty", isEmpty)
message.inv_Parm.of_SetItem("EstimatedQtyRemaining", estimatedQtyRemaining)
message.inv_Parm.of_SetItem("ChangeReason", changeReason)
CloseWithReturn(parent, CONTINUE_ACTION)

end event


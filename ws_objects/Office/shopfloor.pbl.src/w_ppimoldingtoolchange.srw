$PBExportHeader$w_ppimoldingtoolchange.srw
forward
global type w_ppimoldingtoolchange from w_response
end type
type dw_1 from u_dw within w_ppimoldingtoolchange
end type
type cb_cancel from commandbutton within w_ppimoldingtoolchange
end type
type cb_ok from commandbutton within w_ppimoldingtoolchange
end type
end forward

global type w_ppimoldingtoolchange from w_response
integer width = 1966
integer height = 1012
string title = "Choose Machine Tooling"
boolean center = true
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_ppimoldingtoolchange w_ppimoldingtoolchange

type variables

string WorkOrderNumber

end variables

on w_ppimoldingtoolchange.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_ppimoldingtoolchange.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event pfc_preopen;call super::pfc_preopen;
WorkOrderNumber = IsNull(message.inv_Parm.of_GetItem("WorkOrderNumber"), -1)
dw_1.event pfc_Retrieve()

end event

type dw_1 from u_dw within w_ppimoldingtoolchange
integer x = 27
integer y = 48
integer width = 1417
integer height = 856
integer taborder = 30
string dataobject = "d_ppimolding_toolchange"
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
if	Retrieve (WorkOrderNumber) > 0 then
	
	datawindowchild toolList
	if	GetChild("newmold", toolList) = 1 then
		toolList.SetTransObject(SQLCA)
		if	toolList.Retrieve(object.partcode[1]) = 0 then
			toolList.InsertRow(0)
		end if
	end if

	return RowCount()
end if

return -1

end event

event itemchanged;call super::itemchanged;
if	lower(dwo.name) = "moldsetter" then
	string operatorName
	select
		name
	into
		:operatorName
	from
		employee
	where
		password = :data using SQLCA  ;
	
	cb_ok.enabled = (SQLCA.SQLCode = 0)
	if	SQLCA.SQLCode <> 0 then
		msgbox("Invalid operator code.  Try again.")
		return 1
	else
		object.operatorname[1] = operatorName
	end if
end if

end event

event itemerror;call super::itemerror;
return 1

end event

type cb_cancel from commandbutton within w_ppimoldingtoolchange
integer x = 1513
integer y = 184
integer width = 402
integer height = 112
integer taborder = 20
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
dw_1.Reset()
CloseWithReturn(parent, NO_ACTION)

end event

type cb_ok from commandbutton within w_ppimoldingtoolchange
integer x = 1513
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
boolean enabled = false
string text = "OK"
end type

event clicked;
string	moldSetter
string	newMold
string toolChangeNotes
dw_1.AcceptText()
moldSetter = dw_1.object.moldsetter[1]
newMold = dw_1.object.newmold[1]
toolChangeNotes = dw_1.object.notes[1]
message.inv_Parm.of_SetItem("MoldSetter", moldSetter)
message.inv_Parm.of_SetItem("NewMold", newMold)
message.inv_Parm.of_SetItem("ToolChangeNotes", toolChangeNotes)
CloseWithReturn(parent, CONTINUE_ACTION)

end event


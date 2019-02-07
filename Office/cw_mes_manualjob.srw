HA$PBExportHeader$cw_mes_manualjob.srw
forward
global type cw_mes_manualjob from w_response
end type
type cb_cancel from commandbutton within cw_mes_manualjob
end type
type cb_ok from commandbutton within cw_mes_manualjob
end type
type dw_edit from u_fxdw within cw_mes_manualjob
end type
end forward

global type cw_mes_manualjob from w_response
integer width = 1074
integer height = 1108
string title = "Schedule Manual Job"
cb_cancel cb_cancel
cb_ok cb_ok
dw_edit dw_edit
end type
global cw_mes_manualjob cw_mes_manualjob

type variables

end variables

event pfc_preopen;call super::pfc_preopen;
string machine
machine = IsNull(message.inv_Parm.of_GetItem("Machine"), "")
if	dw_edit.RowCount() < 1 then
	dw_edit.InsertRow(0)
end if
dw_edit.object.MachineCode[1] = machine

//	Show the machine list.
datawindowchild machineDWC
if	dw_edit.GetChild("MachineCode", machineDWC) = 1 then
	machineDWC.SetTransObject(SQLCA)
	machineDWC.Retrieve()
end if

//	Show the part list for the selected machine.
datawindowchild partDWC
if	dw_edit.GetChild("PartCode", partDWC) = 1 then
	partDWC.SetTransObject(SQLCA)
	partDWC.Retrieve(machine)
end if

end event

on cw_mes_manualjob.create
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

on cw_mes_manualjob.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_edit)
end on

type cb_cancel from commandbutton within cw_mes_manualjob
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

type cb_ok from commandbutton within cw_mes_manualjob
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
boolean enabled = false
string text = "Ok"
boolean default = true
end type

event clicked;
string machineCode
string partCode
string billToCode
decimal qtyBuild
datetime dueDT
dw_edit.AcceptText()
machineCode = dw_edit.object.MachineCode[1]
partCode = dw_edit.object.PartCode[1]
billToCode = dw_edit.object.BillToCode[1]
qtyBuild = dw_edit.object.QtyBuild[1]
dueDT = dw_edit.object.DueDT[1]
message.inv_Parm.of_SetItem("Machine", machineCode)
message.inv_Parm.of_SetItem("Part", partCode)
message.inv_Parm.of_SetItem("BillTo", billToCode)
message.inv_Parm.of_SetItem("BuildQty", qtyBuild)
message.inv_Parm.of_SetItem("DueDT", dueDT)
CloseWithReturn(parent, CONTINUE_ACTION)

end event

type dw_edit from u_fxdw within cw_mes_manualjob
integer x = 23
integer y = 28
integer width = 983
integer height = 544
integer taborder = 10
string dataobject = "d_edit_manualjob"
boolean vscrollbar = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetRowSelect(false)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()
of_SetUpdateable(false)
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

end event

event retrieveend;call super::retrieveend;
if	rowcount <= 0 then
	return
end if

string primaryCommodity
primaryCommodity = object.PrimaryCommodity[1]
datawindowchild substitutePartListDWC
if	GetChild("SubstitutePartCode", substitutePartListDWC) = 1 then
	substitutePartListDWC.SetTransObject(SQLCA)
	substitutePartListDWC.Retrieve(primaryCommodity)
end if

end event

event itemchanged;call super::itemchanged;
string machineCode
string partCode
string billToCode
decimal qtyBuild
datetime dueDT
machineCode = object.MachineCode[1]
partCode = object.PartCode[1]
billToCode = object.BillToCode[1]
qtyBuild = object.QtyBuild[1]
dueDT = object.DueDT[1]

choose case lower(dwo.Name)
	case lower("MachineCode")
		//	Show the part list for the selected machine.
		datawindowchild partDWC
		if	GetChild("PartCode", partDWC) = 1 then
			partDWC.SetTransObject(SQLCA)
			partDWC.Retrieve(data)
		end if
		object.MachineCode.TabSequence = 0
		machineCode = data
	case lower("PartCode")
		//	Show the part list for the selected machine.
		datawindowchild billToDWC
		if	GetChild("BillToCode", billToDWC) = 1 then
			billToDWC.SetTransObject(SQLCA)
			billToDWC.Retrieve(data)
		end if
		partCode = data
	case lower("BillToCode")
		billToCode = data
	case lower("QtyBuild")
		qtyBuild = Dec(data)
	case lower("DueDT")
		dueDT = datetime(data)
end choose

if	machineCode > "" and partCode > "" and qtyBuild > 0 then
	cb_ok.enabled = true
end if

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


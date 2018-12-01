$PBExportHeader$w_mes_createpallets.srw
forward
global type w_mes_createpallets from w_response
end type
type cb_cancel from commandbutton within w_mes_createpallets
end type
type cb_ok from commandbutton within w_mes_createpallets
end type
type dw_edit from u_fxdw within w_mes_createpallets
end type
end forward

global type w_mes_createpallets from w_response
integer width = 1166
integer height = 832
string title = "Create New Pallet(s)"
cb_cancel cb_cancel
cb_ok cb_ok
dw_edit dw_edit
end type
global w_mes_createpallets w_mes_createpallets

type variables

end variables

event pfc_preopen;call super::pfc_preopen;
string machineCode, palletPackageType
machineCode = IsNull(message.inv_Parm.of_getItem("MachineCode"), machineCode)
palletPackageType = IsNull(message.inv_Parm.of_GetItem("PalletPackageType"), palletPackageType)

if	dw_edit.Retrieve(machineCode, palletPackageType) < 1 then
	dw_edit.InsertRow(0)
end if

end event

on w_mes_createpallets.create
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

on w_mes_createpallets.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_edit)
end on

type cb_cancel from commandbutton within w_mes_createpallets
integer x = 599
integer y = 596
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

type cb_ok from commandbutton within w_mes_createpallets
integer x = 110
integer y = 596
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
dw_edit.AcceptText()
int editRow
editRow = dw_edit.GetRow()
if	editRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

long palletCount

palletCount = dw_edit.object.NewPallets[editRow]
message.inv_Parm.of_SetItem("PalletCount", palletCount)
CloseWithReturn(parent, CONTINUE_ACTION)

end event

type dw_edit from u_fxdw within w_mes_createpallets
integer x = 23
integer y = 28
integer width = 1074
integer height = 496
integer taborder = 10
string dataobject = "d_edit_createpallets"
boolean vscrollbar = false
boolean livescroll = false
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


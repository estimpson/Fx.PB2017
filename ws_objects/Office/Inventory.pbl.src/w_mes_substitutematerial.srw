$PBExportHeader$w_mes_substitutematerial.srw
forward
global type w_mes_substitutematerial from w_response
end type
type cb_cancel from commandbutton within w_mes_substitutematerial
end type
type cb_ok from commandbutton within w_mes_substitutematerial
end type
type dw_edit from u_fxdw within w_mes_substitutematerial
end type
end forward

global type w_mes_substitutematerial from w_response
integer x = 214
integer y = 221
integer width = 3515
integer height = 1456
string title = "Substitute Materials"
cb_cancel cb_cancel
cb_ok cb_ok
dw_edit dw_edit
end type
global w_mes_substitutematerial w_mes_substitutematerial

type variables

long WODBOMID

end variables

event pfc_preopen;call super::pfc_preopen;
WODBOMID = IsNull(message.inv_Parm.of_GetItem("BomID"), -1)
dw_edit.event pfc_Retrieve()

end event

on w_mes_substitutematerial.create
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

on w_mes_substitutematerial.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_edit)
end on

type cb_cancel from commandbutton within w_mes_substitutematerial
integer x = 3049
integer y = 1232
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

type cb_ok from commandbutton within w_mes_substitutematerial
integer x = 2560
integer y = 1232
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
string	substitutePart
decimal substitutionRate
dw_edit.AcceptText()
substitutePart = dw_edit.object.SubstitutePartCode[1]
substitutionRate = dw_edit.object.SubstitutionRate[1]
message.inv_Parm.of_SetItem("SubstitutePart", substitutePart)
message.inv_Parm.of_SetItem("SubstitutionRate", substitutionRate)
CloseWithReturn(parent, CONTINUE_ACTION)

end event

type dw_edit from u_fxdw within w_mes_substitutematerial
integer x = 23
integer y = 28
integer width = 3470
integer height = 1184
integer taborder = 10
string dataobject = "d_edit_dbo_mes_jobbomsubstitutions"
boolean vscrollbar = false
end type

event constructor;call super::constructor;
of_SetTransObject(SQLCA)
of_SetRowSelect(false)
of_SetDropDownSearch(true)
inv_DropDownSearch.of_Register()
of_SetUpdateable(false)

end event

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WODBOMID)

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
choose case lower(dwo.Name)
	case lower("SubstitutionType")
		choose case data
			case "1"
				object.SubstitutionRate[1] = 1
				cb_ok.enabled = true
			case "2"
				object.SubstitutionRate[1] = 0
				cb_ok.enabled = true
			case "3"
				object.SubstitutionRate[1] = 0
		end choose
	case lower("SubstitutionRate")
		if	dec(data) > 0 then
			cb_ok.enabled = true
		end if
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;
choose case lower(dwo.Name)
	case lower("SubstitutionRate")
		SelectText(1,10)
end choose

end event


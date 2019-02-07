HA$PBExportHeader$w_mes_verifybom.srw
forward
global type w_mes_verifybom from w_response
end type
type cb_cancel from commandbutton within w_mes_verifybom
end type
type cb_ok from commandbutton within w_mes_verifybom
end type
type dw_verifybom from u_fxdw within w_mes_verifybom
end type
end forward

global type w_mes_verifybom from w_response
integer width = 2473
integer height = 968
string title = "Verify BOM"
cb_cancel cb_cancel
cb_ok cb_ok
dw_verifybom dw_verifybom
end type
global w_mes_verifybom w_mes_verifybom

type variables

end variables

event pfc_preopen;call super::pfc_preopen;
dw_verifybom.event pfc_Retrieve()

end event

on w_mes_verifybom.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_verifybom=create dw_verifybom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_verifybom
end on

on w_mes_verifybom.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_verifybom)
end on

type cb_cancel from commandbutton within w_mes_verifybom
integer x = 2002
integer y = 712
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

type cb_ok from commandbutton within w_mes_verifybom
integer x = 1513
integer y = 712
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
string	notes, operatorCode
dw_verifybom.AcceptText()
notes = dw_verifybom.object.Notes[1]
operatorCode = dw_verifybom.object.OperatorCode[1]
message.inv_Parm.of_SetItem("Notes", notes)
message.inv_Parm.of_SetItem("OperatorCode", operatorCode)
CloseWithReturn(parent, CONTINUE_ACTION)

end event

type dw_verifybom from u_fxdw within w_mes_verifybom
integer x = 23
integer y = 28
integer width = 2386
integer height = 660
integer taborder = 10
string dataobject = "d_verifybom"
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
return Retrieve()

end event

event itemchanged;call super::itemchanged;
choose case lower(dwo.Name)
	case lower("OperatorPassword")
		cb_ok.enabled = false
		
		string operatorCode, operatorName
		
		select
			e.name
		,	e.operator_code
		into
			:operatorName
		,	:operatorCode
		from
			dbo.employee e
		where
			e.operator_code = :data  ;
			
		if	SQLCA.SQLCode <> 0 then
			MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid password.", StopSign!)
			return 2 // Reject data
		end if
		
		object.OperatorCode[1] = operatorCode
		object.OperatorName[1] = operatorName
		
		cb_ok.enabled = true
end choose

end event


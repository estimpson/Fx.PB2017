$PBExportHeader$w_ppimoldingshopfloorsubstitute.srw
forward
global type w_ppimoldingshopfloorsubstitute from w_response
end type
type dw_1 from u_dw within w_ppimoldingshopfloorsubstitute
end type
type cb_cancel from commandbutton within w_ppimoldingshopfloorsubstitute
end type
type cb_ok from commandbutton within w_ppimoldingshopfloorsubstitute
end type
end forward

global type w_ppimoldingshopfloorsubstitute from w_response
integer x = 214
integer y = 221
integer width = 2185
integer height = 888
string title = "Choose Substitute Material"
boolean center = true
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_ppimoldingshopfloorsubstitute w_ppimoldingshopfloorsubstitute

type variables

long WODBOMRowID
end variables

on w_ppimoldingshopfloorsubstitute.create
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

on w_ppimoldingshopfloorsubstitute.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event pfc_preopen;call super::pfc_preopen;
WODBOMRowID = IsNull(message.inv_Parm.of_GetItem("PrimaryRowID"), -1)
dw_1.event pfc_Retrieve()

end event

type dw_1 from u_dw within w_ppimoldingshopfloorsubstitute
integer x = 27
integer y = 56
integer width = 1646
integer height = 700
integer taborder = 30
string dataobject = "d_ppimoldingjobbomsubstitution"
boolean hscrollbar = true
boolean border = false
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
if	Retrieve (WODBOMRowID) > 0 then
	
	datawindowchild subListDWC
	if	GetChild("SubstitutePart", subListDWC) = 1 then
		subListDWC.SetTransObject(SQLCA)
		if	subListDWC.Retrieve(WODBOMRowID, object.commodity[1]) = 0 then
			subListDWC.InsertRow(0)
		end if
	end if
	
	if	RowCount() > 0 then
		SetColumn("substitutepart")
		event itemfocuschanged(1, object.substitutepart)
	end if
	return RowCount()
end if

return -1

end event

type cb_cancel from commandbutton within w_ppimoldingshopfloorsubstitute
integer x = 1701
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
CloseWithReturn(parent, NO_ACTION)

end event

type cb_ok from commandbutton within w_ppimoldingshopfloorsubstitute
integer x = 1701
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
string	substitutePart
decimal substitutionRate
dw_1.AcceptText()
substitutePart = dw_1.object.substitutepart[1]
substitutionRate = dw_1.object.substitutionrate[1]
message.inv_Parm.of_SetItem("SubstitutePart", substitutePart)
message.inv_Parm.of_SetItem("SubstitutionRate", substitutionRate)
CloseWithReturn(parent, CONTINUE_ACTION)

end event


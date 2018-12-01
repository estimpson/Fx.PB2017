$PBExportHeader$u_action_receipts.sru
forward
global type u_action_receipts from u_base
end type
type cb_3 from commandbutton within u_action_receipts
end type
type cb_2 from commandbutton within u_action_receipts
end type
end forward

global type u_action_receipts from u_base
integer width = 581
integer height = 864
long backcolor = 1073741824
event print ( )
event clipboard ( )
cb_3 cb_3
cb_2 cb_2
end type
global u_action_receipts u_action_receipts

on u_action_receipts.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
end on

on u_action_receipts.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
end on

type cb_3 from commandbutton within u_action_receipts
integer y = 128
integer width = 581
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clipboard"
end type

event clicked;event clipboard()

end event

type cb_2 from commandbutton within u_action_receipts
integer width = 581
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print"
end type

event clicked;event print()

end event


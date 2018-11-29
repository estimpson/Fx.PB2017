$PBExportHeader$w_password.srw
forward
global type w_password from w_response
end type
type cb_ok from commandbutton within w_password
end type
type cb_cancel from commandbutton within w_password
end type
type sle_password from singlelineedit within w_password
end type
end forward

global type w_password from w_response
integer x = 214
integer y = 221
integer width = 631
integer height = 372
string title = "Admin Password"
boolean controlmenu = false
cb_ok cb_ok
cb_cancel cb_cancel
sle_password sle_password
end type
global w_password w_password

type variables

boolean	LoginValid = false

end variables

on w_password.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.sle_password=create sle_password
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.sle_password
end on

on w_password.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.sle_password)
end on

event close;call super::close;
if	sle_password.text = "4T" and Message.DoubleParm = 0 then
	Message.DoubleParm = SUCCESS
end if

end event

type cb_ok from commandbutton within w_password
integer x = 37
integer y = 160
integer width = 256
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ok"
boolean default = true
end type

event clicked;
integer	validLogin = -1

select	1
into	:validLogin
from	parameters
where	admin_password = :sle_password.text  ;

if	validLogin = 1 then
	LoginValid = true
	CloseWithReturn(parent, SUCCESS)
else
	if	MessageBox("Incorrect Password", "Incorrect administrative password.  Try again?", StopSign!, YesNo!, 1) = 1 then
		sle_password.text = ""
		sle_password.SetFocus()
	else
		CloseWithReturn(parent, FAILURE)
	end if
end if

end event

type cb_cancel from commandbutton within w_password
integer x = 329
integer y = 160
integer width = 256
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;
CloseWithReturn(parent, FAILURE)

end event

type sle_password from singlelineedit within w_password
integer x = 37
integer y = 32
integer width = 549
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Reference Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type


$PBExportHeader$w_clearactivated.srw
forward
global type w_clearactivated from window
end type
type cb_2 from commandbutton within w_clearactivated
end type
type st_3 from statictext within w_clearactivated
end type
type cb_1 from commandbutton within w_clearactivated
end type
type mc_1 from monthcalendar within w_clearactivated
end type
end forward

global type w_clearactivated from window
integer width = 1234
integer height = 1164
boolean titlebar = true
string title = "Clear Activated"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
st_3 st_3
cb_1 cb_1
mc_1 mc_1
end type
global w_clearactivated w_clearactivated

type variables
date selDate
end variables

on w_clearactivated.create
this.cb_2=create cb_2
this.st_3=create st_3
this.cb_1=create cb_1
this.mc_1=create mc_1
this.Control[]={this.cb_2,&
this.st_3,&
this.cb_1,&
this.mc_1}
end on

on w_clearactivated.destroy
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.mc_1)
end on

type cb_2 from commandbutton within w_clearactivated
integer x = 782
integer y = 928
integer width = 343
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "")
end event

type st_3 from statictext within w_clearactivated
integer x = 46
integer y = 40
integer width = 1152
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clear all activated price changes on or before:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_clearactivated
integer x = 101
integer y = 928
integer width = 311
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clear"
end type

event clicked;closewithreturn(parent, string(selDate))
end event

type mc_1 from monthcalendar within w_clearactivated
integer x = 110
integer y = 124
integer width = 1006
integer height = 760
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
end type

event datechanged;mc_1.GetSelectedDate(seldate)

end event

event constructor;selDate = today()
end event


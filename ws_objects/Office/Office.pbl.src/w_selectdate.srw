$PBExportHeader$w_selectdate.srw
forward
global type w_selectdate from w_response
end type
type em_date from editmask within w_selectdate
end type
type cb_cancel from commandbutton within w_selectdate
end type
type cb_ok from commandbutton within w_selectdate
end type
type uo_calendar from u_calendar_small within w_selectdate
end type
end forward

global type w_selectdate from w_response
integer width = 626
integer height = 1000
string title = "Select Date"
em_date em_date
cb_cancel cb_cancel
cb_ok cb_ok
uo_calendar uo_calendar
end type
global w_selectdate w_selectdate

on w_selectdate.create
int iCurrent
call super::create
this.em_date=create em_date
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.uo_calendar=create uo_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.uo_calendar
end on

on w_selectdate.destroy
call super::destroy
destroy(this.em_date)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.uo_calendar)
end on

event pfc_preopen;call super::pfc_preopen;
//	Get the initial date.
uo_calendar.of_SetDate(Date(Message.StringParm), false)

end event

type em_date from editmask within w_selectdate
integer x = 37
integer y = 64
integer width = 512
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

event constructor;
//	Setup relationship with calendar object.
//	Initialize with date.
uo_calendar.of_SetInitialValue(true)

//	Set requester.
uo_calendar.of_SetRequestor(this)

//	Enable editing of edit mask.
DisplayOnly = false

end event

event modified;
//	Set calendar to modified date but don't ask calendar to set this date.
uo_calendar.of_SetDate(Date(em_date.text), false)

end event

type cb_cancel from commandbutton within w_selectdate
integer x = 329
integer y = 768
integer width = 219
integer height = 96
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
//	Return nothing.
Close(parent)

end event

type cb_ok from commandbutton within w_selectdate
integer x = 73
integer y = 768
integer width = 219
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;
//	Return selected date.
CloseWithReturn(parent, em_date.Text)

end event

type uo_calendar from u_calendar_small within w_selectdate
integer x = 37
integer y = 160
integer taborder = 20
end type

on uo_calendar.destroy
call u_calendar_small::destroy
end on


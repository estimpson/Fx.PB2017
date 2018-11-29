$PBExportHeader$w_customreport_date.srw
forward
global type w_customreport_date from w_customreport
end type
type st_1 from statictext within w_customreport_date
end type
type em_date1 from u_em within w_customreport_date
end type
type p_calendar from picture within w_customreport_date
end type
type cb_retrieve from commandbutton within w_customreport_date
end type
end forward

global type w_customreport_date from w_customreport
st_1 st_1
em_date1 em_date1
p_calendar p_calendar
cb_retrieve cb_retrieve
end type
global w_customreport_date w_customreport_date

on w_customreport_date.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_date1=create em_date1
this.p_calendar=create p_calendar
this.cb_retrieve=create cb_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_date1
this.Control[iCurrent+3]=this.p_calendar
this.Control[iCurrent+4]=this.cb_retrieve
end on

on w_customreport_date.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.em_date1)
destroy(this.p_calendar)
destroy(this.cb_retrieve)
end on

type dw_report from w_customreport`dw_report within w_customreport_date
integer y = 96
end type

event dw_report::pfc_retrieve;call super::pfc_retrieve;
return Retrieve(DateTime(Date(em_date1.text)))

end event

type st_1 from statictext within w_customreport_date
integer x = 32
integer y = 16
integer width = 146
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Date:"
boolean focusrectangle = false
end type

type em_date1 from u_em within w_customreport_date
integer x = 187
integer y = 4
integer width = 315
integer height = 76
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
long textcolor = 33554432
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

event constructor;
text = String(Today())

//	Enable calendar control.
this.of_SetDropDownCalendar(true)
this.iuo_Calendar.of_SetDropDown(true)

end event

type p_calendar from picture within w_customreport_date
integer x = 535
integer y = 8
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.bmp"
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;
em_date1.event pfc_DDCalendar()

end event

type cb_retrieve from commandbutton within w_customreport_date
integer x = 649
integer width = 320
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Retreive"
end type

event clicked;
dw_report.event pfc_Retrieve()
end event


$PBExportHeader$w_generatedw.srw
forward
global type w_generatedw from w_sheet_4t
end type
type sle_3 from singlelineedit within w_generatedw
end type
type sle_2 from singlelineedit within w_generatedw
end type
type sle_1 from singlelineedit within w_generatedw
end type
type cb_4 from commandbutton within w_generatedw
end type
type cb_3 from commandbutton within w_generatedw
end type
type cb_2 from commandbutton within w_generatedw
end type
type cb_1 from commandbutton within w_generatedw
end type
type dw_1 from u_fxdw within w_generatedw
end type
type gb_1 from groupbox within w_generatedw
end type
end forward

global type w_generatedw from w_sheet_4t
integer x = 214
integer y = 221
integer width = 2560
integer height = 1920
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_generatedw w_generatedw

on w_generatedw.create
int iCurrent
call super::create
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_3
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_generatedw.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event pfc_preopen;call super::pfc_preopen;
of_SetResize(true)
inv_Resize.of_Register(gb_1, 0, 0, 100, 100)
inv_Resize.of_Register(dw_1, 0, 0, 100, 100)

end event

type sle_3 from singlelineedit within w_generatedw
integer x = 1472
integer y = 12
integer width = 142
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "all"
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_generatedw
integer x = 704
integer y = 12
integer width = 709
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "[tablename]"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_generatedw
integer x = 389
integer y = 12
integer width = 270
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "dbo"
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_generatedw
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

event clicked;
//	Generate datawindow.
dw_1.GenerateDW()

//	Retrieve new datawindow.
dw_1.SetTransObject(SQLCA)
dw_1.post event pfc_Retrieve()

end event

type cb_3 from commandbutton within w_generatedw
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

event clicked;
//	Generate datawindow.
dw_1.GenerateDW()

//	Retrieve new datawindow.
dw_1.SetTransObject(SQLCA)
dw_1.post event pfc_Retrieve()

end event

type cb_2 from commandbutton within w_generatedw
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

event clicked;
//	Generate datawindow.
dw_1.GenerateDW()

//	Retrieve new datawindow.
dw_1.SetTransObject(SQLCA)
dw_1.post event pfc_Retrieve()

end event

type cb_1 from commandbutton within w_generatedw
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

event clicked;
//	Set the current name:
dw_1.TableAlias = sle_1.text
dw_1.TableName = sle_2.text
dw_1.ColumnGroupList = sle_3.text

//	Generate datawindow.
dw_1.GenerateDW()

//	Retrieve new datawindow.
dw_1.SetTransObject(SQLCA)
dw_1.post event pfc_Retrieve()

end event

type dw_1 from u_fxdw within w_generatedw
integer x = 9
integer y = 196
integer width = 1733
integer height = 996
integer taborder = 20
boolean hscrollbar = true
boolean autoscroll = true
end type

event constructor;call super::constructor;
//	Set PowerFilter.
SetPowerFilter(true)
PowerFilter.of_SetDW(this)

//	Turn on the sort service
of_SetSort (true)
inv_sort.of_SetStyle(inv_sort.DRAGDROP)
inv_Sort.SetColumnHeaderExt (true)

//	Turn on the filter service
of_SetFilter (true)
inv_filter.of_SetStyle(inv_filter.EXTENDED)

//	Turn on the calendar for editable dates.
of_SetDropDownCalendar(true)
iuo_Calendar.of_Register(iuo_Calendar.DDLB)

end event

event dwlbuttonup;call super::dwlbuttonup;
PowerFilter.event post ue_buttonclicked(dwo.Type, dwo.Name)

end event

type gb_1 from groupbox within w_generatedw
integer y = 116
integer width = 1751
integer height = 1084
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Records"
end type


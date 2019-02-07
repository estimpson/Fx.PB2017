$PBExportHeader$w_powerfilterdemo_main.srw
$PBExportComments$Generated SDI Main Window
forward
global type w_powerfilterdemo_main from window
end type
type sle_number from singlelineedit within w_powerfilterdemo_main
end type
type cb_5 from commandbutton within w_powerfilterdemo_main
end type
type cbx_1 from checkbox within w_powerfilterdemo_main
end type
type htb_1 from htrackbar within w_powerfilterdemo_main
end type
type tab_1 from tab within w_powerfilterdemo_main
end type
type tabpage_1 from userobject within tab_1
end type
type cbx_filter from u_powerfilter_checkbox within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cbx_filter cbx_filter
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type cbx_2 from u_powerfilter_checkbox within tabpage_2
end type
type dw_3 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cbx_2 cbx_2
dw_3 dw_3
end type
type tab_1 from tab within w_powerfilterdemo_main
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_reset from commandbutton within w_powerfilterdemo_main
end type
type cb_4 from commandbutton within w_powerfilterdemo_main
end type
type cb_cancel from commandbutton within w_powerfilterdemo_main
end type
type dw_1 from datawindow within w_powerfilterdemo_main
end type
type cb_3 from commandbutton within w_powerfilterdemo_main
end type
type cb_2 from commandbutton within w_powerfilterdemo_main
end type
type cb_1 from commandbutton within w_powerfilterdemo_main
end type
type cb_morerows from commandbutton within w_powerfilterdemo_main
end type
type cbx_powerfilter from u_powerfilter_checkbox within w_powerfilterdemo_main
end type
end forward

global type w_powerfilterdemo_main from window
integer width = 4663
integer height = 3228
boolean titlebar = true
string title = "PowerFilter Demo"
string menuname = "m_powerfilterdemo_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79416533
boolean center = true
event ue_powerfilter ( )
sle_number sle_number
cb_5 cb_5
cbx_1 cbx_1
htb_1 htb_1
tab_1 tab_1
cb_reset cb_reset
cb_4 cb_4
cb_cancel cb_cancel
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_morerows cb_morerows
cbx_powerfilter cbx_powerfilter
end type
global w_powerfilterdemo_main w_powerfilterdemo_main

type variables
n_cst_powerfilter iu_powerfilter 
end variables

event ue_powerfilter();//called from menu to toggle powerfilter
iu_powerfilter.checked = NOT iu_powerfilter.checked
iu_powerfilter.event ue_clicked()
m_powerfilterdemo_main.m_data.m_powerfilter.checked = iu_powerfilter.checked
end event

on w_powerfilterdemo_main.create
if this.MenuName = "m_powerfilterdemo_main" then this.MenuID = create m_powerfilterdemo_main
this.sle_number=create sle_number
this.cb_5=create cb_5
this.cbx_1=create cbx_1
this.htb_1=create htb_1
this.tab_1=create tab_1
this.cb_reset=create cb_reset
this.cb_4=create cb_4
this.cb_cancel=create cb_cancel
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_morerows=create cb_morerows
this.cbx_powerfilter=create cbx_powerfilter
this.Control[]={this.sle_number,&
this.cb_5,&
this.cbx_1,&
this.htb_1,&
this.tab_1,&
this.cb_reset,&
this.cb_4,&
this.cb_cancel,&
this.dw_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_morerows,&
this.cbx_powerfilter}
end on

on w_powerfilterdemo_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_number)
destroy(this.cb_5)
destroy(this.cbx_1)
destroy(this.htb_1)
destroy(this.tab_1)
destroy(this.cb_reset)
destroy(this.cb_4)
destroy(this.cb_cancel)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_morerows)
destroy(this.cbx_powerfilter)
end on

event resize;dw_1.width = this.workspacewidth( ) - dw_1.x
//dw_1.height = this.workspaceheight( ) - dw_1.y
end event

event open;This.ToolbarVisible = FALSE
end event

type sle_number from singlelineedit within w_powerfilterdemo_main
integer x = 3287
integer y = 4
integer width = 128
integer height = 80
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type cb_5 from commandbutton within w_powerfilterdemo_main
integer x = 3465
integer width = 375
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SetLang"
end type

event clicked;Integer li_lang

li_lang = Integer(sle_number.text)

iu_powerfilter.of_setlanguage(li_lang)
end event

type cbx_1 from checkbox within w_powerfilterdemo_main
integer x = 4078
integer y = 20
integer width = 389
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Offsettest"
end type

event clicked;IF this.checked THEN
	cbx_powerfilter.of_setdropdownoffset(-300,-100)
ELSE
	cbx_powerfilter.of_setdropdownoffset(0,0)
END IF
end event

type htb_1 from htrackbar within w_powerfilterdemo_main
integer y = 1592
integer width = 4535
integer height = 136
integer minposition = 10
integer maxposition = 500
integer position = 100
integer tickfrequency = 10
integer pagesize = 10
integer linesize = 1
htickmarks tickmarks = hticksontop!
end type

event moved;dw_1.Object.DataWindow.Zoom=this.position
end event

event lineleft;dw_1.Object.DataWindow.Zoom=this.position
end event

event lineright;dw_1.Object.DataWindow.Zoom=this.position
end event

event pageleft;dw_1.Object.DataWindow.Zoom=this.position
end event

event pageright;dw_1.Object.DataWindow.Zoom=this.position
end event

type tab_1 from tab within w_powerfilterdemo_main
integer y = 1728
integer width = 4544
integer height = 948
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4507
integer height = 820
long backcolor = 79416533
string text = "Test Tab"
long tabtextcolor = 33554432
long tabbackcolor = 79416533
long picturemaskcolor = 536870912
cbx_filter cbx_filter
dw_2 dw_2
end type

on tabpage_1.create
this.cbx_filter=create cbx_filter
this.dw_2=create dw_2
this.Control[]={this.cbx_filter,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.cbx_filter)
destroy(this.dw_2)
end on

type cbx_filter from u_powerfilter_checkbox within tabpage_1
integer x = 5
integer y = 4
integer height = 60
integer weight = 700
long backcolor = 134217728
boolean promptusertorestore = true
string defaulttiptext = "(No Filter Applied)"
boolean bubblestyle = true
end type

type dw_2 from datawindow within tabpage_1
event ue_leftbuttonup pbm_dwnlbuttonup
integer width = 4590
integer height = 816
integer taborder = 50
string title = "none"
string dataobject = "d_testdatashortheaders"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event ue_leftbuttonup;//post an event to either reposition the powerfilter buttons or handle a buttonclick. ue_buttonclicked will call ue_positionbuttons
cbx_filter.event post ue_buttonclicked(dwo.type,dwo.name)

end event

event constructor;
cbx_filter.of_setdw(this)

//Optional, to limit filter to specific columns, or if headernames are not = column + '_t'
String ls_Columns[] = {'State','City','DOB'}
cbx_filter.of_SetColumns(ls_Columns) 

//Optional, must equal either number of columns passed in of_SetColumns() 
//or # of columns with headers = column + '_t' if of_SetColumns not used
cbx_filter.of_SetTitles({'Title one state','Title two city','Title Three dob'}) 

//Alternative way to pass values, load the array, then pass the array
//String ls_Titles[] = {'Title one state','Title two city','Title Three dob'}
//cbx_filter.of_SetTitles(ls_Titles) 


end event

event resize;cbx_powerfilter.event ue_positionbuttons()
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4507
integer height = 820
long backcolor = 79416533
string text = "Tab #2"
long tabtextcolor = 33554432
long tabbackcolor = 79416533
long picturemaskcolor = 536870912
cbx_2 cbx_2
dw_3 dw_3
end type

on tabpage_2.create
this.cbx_2=create cbx_2
this.dw_3=create dw_3
this.Control[]={this.cbx_2,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.cbx_2)
destroy(this.dw_3)
end on

type cbx_2 from u_powerfilter_checkbox within tabpage_2
integer width = 224
integer maxitems = 5000
integer buttonheight = 57
integer buttonwidth = 65
integer buttonyoffset = -70
boolean allowquicksort = false
end type

event clicked;call super::clicked;m_powerfilterdemo_main.m_data.m_powerfilter.checked = this.checked
end event

type dw_3 from datawindow within tabpage_2
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 80
integer width = 4507
integer height = 736
integer taborder = 60
boolean titlebar = true
string title = "Moveable"
string dataobject = "d_testdata"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event ue_leftbuttonup;//post an event to either reposition the powerfilter buttons or handle a buttonclick. ue_buttonclicked will call ue_positionbuttons
cbx_2.event post ue_buttonclicked(dwo.type,dwo.name)

end event

event constructor;cbx_2.of_setdw(this)

//String ls_Columns[] = {'State','City','DOB'}
String ls_Titles[] = {'Title one custom title','Title two ','Title Three ','custom title 4',&
							'custom title 5','custom title 6','custom title 7','custom title 8',&
							'custom title 9','custom title 10','custom title 11'}

//cbx_2.of_setcolumns( ls_Columns)
cbx_2.of_settitles( ls_Titles)



end event

event resize;cbx_powerfilter.event ue_positionbuttons()
end event

type cb_reset from commandbutton within w_powerfilterdemo_main
integer x = 2697
integer width = 375
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
end type

event clicked;dw_1.RowsDiscard (9,dw_1.rowcount(), Primary! ) 
end event

type cb_4 from commandbutton within w_powerfilterdemo_main
integer x = 1929
integer width = 375
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seq Datetime"
end type

event clicked;Long	ll_row,ll_rows
Time	lt_time

ll_rows = dw_1.rowcount()
lt_time = now()

FOR ll_row = 1 to ll_rows
	dw_1.SetItem(ll_row,'timetest',lt_time)
	lt_time = RelativeTime ( lt_time, 95 )
NEXT
end event

type cb_cancel from commandbutton within w_powerfilterdemo_main
integer x = 2313
integer width = 375
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Exit"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_powerfilterdemo_main
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 112
integer width = 4535
integer height = 1464
integer taborder = 70
string dataobject = "d_testdata"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;//post an event to either reposition the powerfilter buttons or handle a buttonclick. ue_buttonclicked will call ue_positionbuttons
iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)

end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)

//cbx_powerfilter.of_setdw(this)

this.Object.DataWindow.Print.Preview='Yes'
this.Object.DataWindow.Print.Preview.rulers='Yes'
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type cb_3 from commandbutton within w_powerfilterdemo_main
integer x = 777
integer width = 375
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seq DOB"
end type

event clicked;Long	ll_row,ll_rows
Date	ldt_date

ll_rows = dw_1.rowcount()
ldt_date = RelativeDate(today(),-365)

FOR ll_row = 1 to ll_rows
	dw_1.SetItem(ll_row,'DOB',ldt_date)
	ldt_date = RelativeDate ( ldt_date, 1 )
NEXT
end event

type cb_2 from commandbutton within w_powerfilterdemo_main
integer x = 1545
integer width = 375
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seq Decimal"
end type

event clicked;Long	ll_row,ll_rows
Decimal	ldc_counter

ll_rows = dw_1.rowcount()
ldc_counter = 1
FOR ll_row = 1 to ll_rows
	dw_1.SetItem(ll_row,'decimaltest',ldc_counter)
	ldc_counter = ldc_counter + 1.377
NEXT
end event

type cb_1 from commandbutton within w_powerfilterdemo_main
integer x = 1161
integer width = 375
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seq Age"
end type

event clicked;Long	ll_row,ll_rows

ll_rows = dw_1.rowcount()

FOR ll_row = 1 to ll_rows
	dw_1.SetItem(ll_row,'Age',ll_row)
NEXT

end event

type cb_morerows from commandbutton within w_powerfilterdemo_main
integer x = 393
integer width = 375
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "More Rows"
boolean default = true
end type

event clicked;dw_1.RowsCopy(1,dw_1.RowCount(), Primary!, dw_1, 1, Primary!) //duplicates all current rows
end event

type cbx_powerfilter from u_powerfilter_checkbox within w_powerfilterdemo_main
boolean visible = false
integer x = 14
integer y = 4
integer width = 261
boolean enabled = false
boolean promptusertorestore = true
boolean allowquicksort = false
end type

event clicked;call super::clicked;m_powerfilterdemo_main.m_data.m_powerfilter.checked = this.checked
end event


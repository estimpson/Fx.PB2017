$PBExportHeader$w_planning_board.srw
forward
global type w_planning_board from w_sheet_4t
end type
type cb_1 from commandbutton within w_planning_board
end type
type st_3 from statictext within w_planning_board
end type
type st_2 from statictext within w_planning_board
end type
type em_1 from editmask within w_planning_board
end type
type st_1 from statictext within w_planning_board
end type
type ddlb_1 from dropdownlistbox within w_planning_board
end type
type ddlb_2 from dropdownlistbox within w_planning_board
end type
end forward

global type w_planning_board from w_sheet_4t
string title = "Planning Board"
string menuname = "m_pbmenu"
event ue_exit ( )
event ue_open ( )
cb_1 cb_1
st_3 st_3
st_2 st_2
em_1 em_1
st_1 st_1
ddlb_1 ddlb_1
ddlb_2 ddlb_2
end type
global w_planning_board w_planning_board

type variables
integer	ii_interval=1
string	is_intervaltype='Day'
string	is_group='All'
end variables

event ue_exit;close ( This ) 

end event

event ue_open;// 	1. Open the dwplanningboard user object
title = 'Planning Board  ('+is_intervaltype+' Mode)'
st_1.hide()
st_2.hide()
st_3.hide()
ddlb_1.hide()
em_1.hide()
ddlb_2.hide()
cb_1.hide()
n_cst_associative_array	lncst_aalist
lncst_aalist.of_SetItem ( "intervaltype", is_intervaltype)
lncst_aalist.of_SetItem ( "interval", ii_interval)
lncst_aalist.of_SetItem ( "group", is_group)
openuserobjectwithparm ( u_dwPlanningBoard, lncst_aalist, 5, 5 ) 
//openuserobjectwithparm ( u_dwPlanningBoard, is_intervaltype, 5, 5 ) 

// 	2. Set the values for the co-ordinates
u_dwPlanningBoard.width = width - 30
u_dwPlanningBoard.height = height - 500

end event

on w_planning_board.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_pbmenu" then this.MenuID = create m_pbmenu
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.em_1=create em_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.ddlb_2
end on

on w_planning_board.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
end on

event open;call super::open;//	Declaration
string	ls_group
int	li_index

//	Enable controls
st_1.show()
st_2.show()
st_3.show()
ddlb_1.show()
em_1.show()
ddlb_2.show()
cb_1.show()
ddlb_1.text = 'Day'
em_1.text = '1'
ddlb_1.setfocus()

//	Assign values to the drop down list box
declare groups cursor for
select	distinct group_no
from	location
where	type = 'MC' and group_no is not null
order by group_no;

ddlb_2.InsertItem('All', 1)
li_index = 2

open	groups;
fetch	groups into :ls_group;
do while (sqlca.sqlcode = 0 ) 
	ddlb_2.InsertItem(ls_group, li_index)
	li_index++
	fetch	groups into :ls_group;
Loop 
Close groups;

ddlb_2.text = 'All'
end event

event closequery;call super::closequery;if isvalid ( u_dwPlanningBoard ) then 
	if isvalid ( u_dwPlanningBoard.ids_Tasks ) then destroy u_dwPlanningBoard.ids_Tasks
	if isvalid ( u_dwPlanningBoard.ids_Shifts ) then destroy u_dwPlanningBoard.ids_Shifts
	closeuserobject ( u_dwPlanningBoard ) 
end if 	


end event

type cb_1 from commandbutton within w_planning_board
integer x = 1870
integer y = 928
integer width = 384
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;triggerevent('ue_open')
end event

type st_3 from statictext within w_planning_board
integer x = 1225
integer y = 772
integer width = 631
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Resource Group"
boolean focusrectangle = false
end type

type st_2 from statictext within w_planning_board
integer x = 1225
integer y = 640
integer width = 631
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Interval"
boolean focusrectangle = false
end type

type em_1 from editmask within w_planning_board
integer x = 1870
integer y = 640
integer width = 384
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "00"
boolean spin = true
double increment = 1
string minmax = "1~~"
end type

event modified;ii_interval = integer(text)
end event

type st_1 from statictext within w_planning_board
integer x = 1225
integer y = 508
integer width = 631
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Interval Type"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_planning_board
integer x = 1870
integer y = 508
integer width = 384
integer height = 404
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Day","Hour","Week"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_intervaltype = text
end event

type ddlb_2 from dropdownlistbox within w_planning_board
integer x = 1870
integer y = 772
integer width = 384
integer height = 432
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_group = text
end event


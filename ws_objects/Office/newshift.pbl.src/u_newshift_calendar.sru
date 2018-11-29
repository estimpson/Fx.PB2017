$PBExportHeader$u_newshift_calendar.sru
forward
global type u_newshift_calendar from userobject
end type
type cb_4 from commandbutton within u_newshift_calendar
end type
type cb_3 from commandbutton within u_newshift_calendar
end type
type cb_2 from commandbutton within u_newshift_calendar
end type
type cb_1 from commandbutton within u_newshift_calendar
end type
type dw_1 from datawindow within u_newshift_calendar
end type
end forward

global type u_newshift_calendar from userobject
integer width = 850
integer height = 860
boolean border = true
long backcolor = 77897888
event ue_paint_calendar pbm_custom01
event ue_day_clicked pbm_custom02
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global u_newshift_calendar u_newshift_calendar

type variables
DATE	id_Date, &
	id_ClickedDate

INTEGER	ii_ClickedColumn
end variables

forward prototypes
public function integer uof_paint_month (date argd_date)
public function integer uof_paint_days (integer argi_beginday, integer argi_numdays)
public function string uof_get_month_string (integer argi_month)
end prototypes

on ue_paint_calendar;uof_paint_month ( id_Date )
end on

public function integer uof_paint_month (date argd_date);INTEGER	i_FirstDayNum, &
			i_Cell, &
			i_DaysInMonth, &
			i_Year, &
			i_Month, &
			i_Day

DATE		d_FirstDay

STRING		s_Year, &
			s_Month, &
			s_Modify, &
			s_Return

SetPointer ( Hourglass! )
dw_1.Reset ( )
dw_1.SetRedraw ( FALSE )
dw_1.InsertRow ( 0 )

i_Year = Year ( argd_Date )
i_Month = Month ( argd_Date )
i_Day = Day ( argd_Date )

i_DaysInMonth = f_days_in_month ( argd_Date )
d_FirstDay = Date ( i_Year, i_Month, 1 )
i_FirstDayNum = DayNumber ( d_FirstDay )
i_Cell = i_FirstDayNum + i_Day - 1
s_Month = uof_get_month_string ( i_Month )
s_Modify = 'st_month.text="' + s_Month + ' ' + String ( i_Year ) + '"'
s_Return = dw_1.Modify ( s_Modify )
uof_paint_days ( i_FirstDayNum, i_DaysInMonth )

SetPointer ( Arrow! )
dw_1.SetRedraw ( TRUE )

Return 0
end function

public function integer uof_paint_days (integer argi_beginday, integer argi_numdays);INTEGER	i_Count, &
			i_DayCount

STRING		s_Modify

IF Month ( Today ( ) ) = Month ( id_Date ) AND Year ( Today ( ) ) = Year ( id_Date ) THEN
	s_Modify = 'cell' + String ( Day ( Today ( ) ) + argi_BeginDay - 1 ) + '.Border = 5'
	dw_1.Modify ( s_Modify )
ELSE
	FOR i_Count = 1 TO 42
		s_Modify += 'cell' + String ( i_Count ) + '.Border = 0 '
		dw_1.Modify ( s_Modify )
	NEXT
END IF
FOR i_Count = 0 TO argi_NumDays - 1
	dw_1.SetItem ( 1, i_Count + argi_BeginDay, String ( i_Count + 1 ) )
NEXT
Return 0
end function

public function string uof_get_month_string (integer argi_month);CHOOSE CASE argi_Month
	CASE 1
		Return 'January'
	CASE 2
		Return 'February'
	CASE 3
		Return 'March'
	CASE 4
		Return 'April'
	CASE 5
		Return 'May'
	CASE 6
		Return 'June'
	CASE 7
		Return 'July'
	CASE 8
		Return 'August'
	CASE 9
		Return 'September'
	CASE 10
		Return 'October'
	CASE 11
		Return 'November'
	CASE 12
		Return 'December'
	CASE ELSE
		Return 'Error'
END CHOOSE
end function

on constructor;STRING	s_Date

s_Date = Message.StringParm

IF IsDate ( s_Date ) THEN
	id_Date = Date ( s_Date )
ELSE
	id_Date = Today ( )
END IF

PostEvent ( 'ue_paint_calendar' )
end on

on u_newshift_calendar.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on u_newshift_calendar.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_4 from commandbutton within u_newshift_calendar
integer x = 535
integer y = 744
integer width = 133
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

on clicked;id_Date = Date ( Year ( id_Date ) + 1, Month ( id_Date ), 1 )
Parent.TriggerEvent ( 'ue_paint_calendar' )
end on

type cb_3 from commandbutton within u_newshift_calendar
integer x = 402
integer y = 744
integer width = 133
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

on clicked;IF Month ( id_Date ) < 12 THEN
	id_Date = Date ( Year ( id_Date ), Month ( id_Date ) + 1, 1 )
ELSE
	id_Date = Date ( Year ( id_Date ) + 1, 1, 1 )
END IF
Parent.TriggerEvent ( 'ue_paint_calendar' )
end on

type cb_2 from commandbutton within u_newshift_calendar
integer x = 270
integer y = 744
integer width = 133
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

on clicked;IF Month ( id_Date ) > 1 THEN
	id_Date = Date ( Year ( id_Date ), Month ( id_Date ) - 1, 1 )
ELSE
	id_Date = Date ( Year ( id_Date ) - 1, 12, 1 )
END IF
Parent.TriggerEvent ( 'ue_paint_calendar' )
end on

type cb_1 from commandbutton within u_newshift_calendar
integer x = 137
integer y = 744
integer width = 133
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

on clicked;id_Date = Date ( Year ( id_Date ) - 1, Month ( id_Date ), 1 )
Parent.TriggerEvent ( 'ue_paint_calendar' )
end on

type dw_1 from datawindow within u_newshift_calendar
integer x = 46
integer y = 28
integer width = 759
integer height = 696
integer taborder = 10
string dataobject = "d_calendar"
boolean border = false
boolean livescroll = true
end type

on clicked;INTEGER	li_Day

ii_ClickedColumn = GetClickedColumn ( )
IF ii_ClickedColumn = 0 THEN
	Return
END IF
li_Day = Integer ( GetItemString ( 1, ii_ClickedColumn ) )
IF li_Day >= 1 THEN
	id_ClickedDate = Date ( Year ( id_Date ), Month ( id_Date ), li_Day )
ELSE
	Return
END IF
Parent.PostEvent ( 'ue_day_clicked' )
end on


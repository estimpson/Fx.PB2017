$PBExportHeader$u_create_shift_wizard_range.sru
forward
global type u_create_shift_wizard_range from u_wizard_ancestor
end type
type st_1 from statictext within u_create_shift_wizard_range
end type
type st_3 from statictext within u_create_shift_wizard_range
end type
type vsb_1 from vscrollbar within u_create_shift_wizard_range
end type
type uo_1 from u_newshift_calendar within u_create_shift_wizard_range
end type
type r_1 from rectangle within u_create_shift_wizard_range
end type
type r_2 from rectangle within u_create_shift_wizard_range
end type
type st_4 from statictext within u_create_shift_wizard_range
end type
type st_5 from statictext within u_create_shift_wizard_range
end type
type st_2 from statictext within u_create_shift_wizard_range
end type
type em_1 from editmask within u_create_shift_wizard_range
end type
end forward

type str_range from structure
    date d_week
    boolean b_days[7]
    integer i_weeks
end type

global type u_create_shift_wizard_range from u_wizard_ancestor
int Height=924
st_1 st_1
st_3 st_3
vsb_1 vsb_1
uo_1 uo_1
r_1 r_1
r_2 r_2
st_4 st_4
st_5 st_5
st_2 st_2
em_1 em_1
end type
global u_create_shift_wizard_range u_create_shift_wizard_range

type variables
Public:
str_range	istr_Range

Private:

LONG	il_Blue = 16711680, &
	il_BlueGreen = 16776960, &
	il_Grey = 12632256
end variables

forward prototypes
private function integer uof_paint_data ()
private function integer uof_reset_calendar ()
private function integer uof_paint_month_color ()
end prototypes

private function integer uof_paint_data ();IF ib_Painted THEN
	w_create_new_shift_wizard.wf_enable_next ( TRUE )
ELSE
	istr_Range.i_Weeks = 1
	ib_Painted = TRUE
END IF
Return 0
end function

private function integer uof_reset_calendar ();INTEGER i_Count

STRING s_Modify

FOR i_Count = 1 TO 42
	s_Modify += 'cell' + String ( i_Count ) + '.Background.Color = ' + String ( il_Grey ) + ' '
NEXT
uo_1.dw_1.Modify ( s_Modify )
Return 0
end function

private function integer uof_paint_month_color ();// This function will color a month according to the following rules:
//		1. If the start week is in this month, those days will be colored blue.
//		2. If days in the month are covered by the range, they will be colored bluegreen.
//
// This function is called when the shown month is changed or when the range is changed.

LONG	ll_SetColor

INTEGER	li_WeekCount=0, &
			li_DayCount

STRING	ls_Modify

DATE	ld_CalendarFirstDay, &
		ld_CalendarWeekOf, &
		ld_FirstWeekOf, &
		ld_LastWeekOf, &
		ld_CountWeekOf
		
// Set first and last week in range.
ld_FirstWeekOf = istr_Range.d_Week
ld_LastWeekOf = RelativeDate ( ld_FirstWeekOf, ( istr_Range.i_Weeks - 1 )* 7 )
//ld_LastWeekOf = RelativeDate ( ld_FirstWeekOf, ( istr_Range.i_Weeks) * 7 )

// Determine first week on calendar.
ld_CalendarFirstDay = RelativeDate ( uo_1.id_Date, - ( Day ( uo_1.id_Date ) - 1 ) )
ld_CalendarWeekOf = RelativeDate ( ld_CalendarFirstDay, - ( DayNumber ( ld_CalendarFirstDay ) - 1 ) )

ld_CountWeekOf = ld_CalendarWeekOf
// Loop while the count week is not past month on calendar.

DO WHILE Month ( ld_CountWeekOf ) <= Month ( ld_CalendarfirstDay ) and &
      	Year ( ld_CountWeekOf ) <= Year ( ld_CalendarfirstDay )
// Set color of days according to rules.
	CHOOSE CASE ld_CountWeekOf
	CASE ld_FirstWeekOf
		ll_SetColor = il_Blue
	CASE RelativeDate ( ld_FirstWeekOf, 7 ) TO ld_LastWeekOf
		ll_SetColor = il_BlueGreen
	CASE IS > ld_LastWeekOf
		ll_SetColor = il_Grey
	CASE ELSE
		ll_SetColor = il_Grey
	END CHOOSE
// Color all days in count week and in month on calendar.
	FOR li_DayCount = 1 TO 7
		IF Month ( RelativeDate ( ld_CountWeekOf, li_DayCount - 1 ) ) = Month ( ld_CalendarFirstDay ) THEN
			IF istr_Range.b_Days [ li_DayCount ] THEN
				ls_Modify += 'cell' + String ( ( li_WeekCount * 7 ) + li_DayCount ) + '.Background.Color = ' + String ( ll_SetColor ) + ' '
			ELSE
				ls_Modify += 'cell' + String ( ( li_WeekCount * 7 ) + li_DayCount ) + '.Background.Color = ' + String ( il_Grey ) + ' '
			END IF
		END IF
	NEXT
	li_WeekCount ++
	ld_CountWeekOf = RelativeDate ( ld_CountWeekOf, 7 )
LOOP
uo_1.dw_1.Modify ( ls_Modify )
Return 0
end function

on u_create_shift_wizard_range.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_3=create st_3
this.vsb_1=create vsb_1
this.uo_1=create uo_1
this.r_1=create r_1
this.r_2=create r_2
this.st_4=create st_4
this.st_5=create st_5
this.st_2=create st_2
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.vsb_1
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.r_1
this.Control[iCurrent+6]=this.r_2
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_1
end on

on u_create_shift_wizard_range.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.vsb_1)
destroy(this.uo_1)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.em_1)
end on

type st_1 from statictext within u_create_shift_wizard_range
int X=960
int Y=44
int Width=933
int Height=408
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on constructor;Text = 'Select multiple days to be scheduled from one week and specify a range in weeks.'
end on

type st_3 from statictext within u_create_shift_wizard_range
int X=1010
int Y=528
int Width=187
int Height=72
boolean Enabled=false
string Text="Range"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type vsb_1 from vscrollbar within u_create_shift_wizard_range
int X=1467
int Y=516
int Width=78
int Height=84
boolean Enabled=false
boolean StdWidth=false
end type

on lineup;em_1.Text = String ( Integer ( em_1.Text ) + 1 )
em_1.TriggerEvent ( 'modified' )
end on

on linedown;IF em_1.Text > '1' THEN
	em_1.Text = String ( Integer ( em_1.Text ) - 1 )
END IF
em_1.TriggerEvent ( 'modified' )
end on

type uo_1 from u_newshift_calendar within u_create_shift_wizard_range
int X=0
int Y=44
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event ue_day_clicked;LONG	ll_SetColor

INTEGER li_Count

STRING	ls_Modify

DATE	ld_WeekOf

BOOLEAN	lb_NextEnabled = FALSE


//IF uo_1.id_ClickedDate < Today() then 
//	Messagebox(monsys.msg_title,"Cannot schedule shifts before "+string(today()))
//	return
//end if
// Determine week of day clicked
ld_WeekOf = RelativeDate ( uo_1.id_ClickedDate, - ( DayNumber ( uo_1.id_ClickedDate ) - 1 ) )

// If it isn't the current week, then clear all selected days.
IF ld_WeekOf <> istr_Range.d_Week THEN
	uof_reset_calendar ( )
	FOR li_Count = 1 TO 7
		istr_Range.b_Days [ li_Count ] = FALSE
	NEXT
END IF

// Toggle day clicked.
IF istr_Range.b_Days [ DayNumber ( uo_1.id_ClickedDate ) ] THEN
	istr_Range.b_Days [ DayNumber ( uo_1.id_ClickedDate ) ] = FALSE
ELSE
	istr_Range.b_Days [ DayNumber ( uo_1.id_ClickedDate ) ] = TRUE
END IF

// Set current week
istr_Range.d_Week = ld_WeekOf

// If no days are selected, disable else enable next:
FOR li_Count = 1 TO 7
	IF istr_Range.b_Days [ li_Count ] THEN
		lb_NextEnabled = TRUE
	END IF
NEXT
IF lb_NextEnabled THEN
	w_create_new_shift_wizard.wf_enable_next ( TRUE )
ELSE
	w_create_new_shift_wizard.wf_enable_next ( FALSE )
END IF

uof_paint_month_color ( )
end event

event ue_paint_calendar;uof_reset_calendar ( )
uof_paint_month ( id_Date )
uof_paint_month_color ( )
end event

on uo_1.destroy
call u_newshift_calendar::destroy
end on

type r_1 from rectangle within u_create_shift_wizard_range
int X=864
int Y=816
int Width=73
int Height=72
boolean Enabled=false
int LineThickness=4
long LineColor=16711680
long FillColor=16711680
end type

type r_2 from rectangle within u_create_shift_wizard_range
int X=1394
int Y=816
int Width=73
int Height=72
boolean Enabled=false
int LineThickness=4
long LineColor=16776960
long FillColor=16776960
end type

type st_4 from statictext within u_create_shift_wizard_range
int X=974
int Y=816
int Width=283
int Height=72
boolean Enabled=false
string Text="Start Date"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within u_create_shift_wizard_range
int X=1504
int Y=816
int Width=430
int Height=72
boolean Enabled=false
string Text="Included Days"
boolean FocusRectangle=false
long BackColor=77897888
long BorderColor=12632256
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_create_shift_wizard_range
int X=1577
int Y=528
int Width=215
int Height=72
boolean Enabled=false
string Text="Weeks"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within u_create_shift_wizard_range
int X=1221
int Y=516
int Width=242
int Height=84
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##,###"
string Text="1"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;istr_Range.i_Weeks = Integer ( Text )
uof_paint_month_color ( )
end event


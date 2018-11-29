$PBExportHeader$u_cst_schedule.sru
forward
global type u_cst_schedule from UserObject
end type
type em_end from editmask within u_cst_schedule
end type
type em_begin from editmask within u_cst_schedule
end type
type st_2 from statictext within u_cst_schedule
end type
type st_1 from statictext within u_cst_schedule
end type
type rb_months from radiobutton within u_cst_schedule
end type
type rb_weeks from radiobutton within u_cst_schedule
end type
type rb_days from radiobutton within u_cst_schedule
end type
type rb_hours from radiobutton within u_cst_schedule
end type
type rb_minutes from radiobutton within u_cst_schedule
end type
type rb_seconds from radiobutton within u_cst_schedule
end type
type rb_every from radiobutton within u_cst_schedule
end type
type rb_once from radiobutton within u_cst_schedule
end type
type gb_3 from groupbox within u_cst_schedule
end type
type gb_2 from groupbox within u_cst_schedule
end type
type em_interval from editmask within u_cst_schedule
end type
type gb_1 from groupbox within u_cst_schedule
end type
end forward

global type u_cst_schedule from UserObject
int Width=1266
int Height=996
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_modified ( integer interval,  integer interval_type,  datetime begindt,  datetime enddt )
em_end em_end
em_begin em_begin
st_2 st_2
st_1 st_1
rb_months rb_months
rb_weeks rb_weeks
rb_days rb_days
rb_hours rb_hours
rb_minutes rb_minutes
rb_seconds rb_seconds
rb_every rb_every
rb_once rb_once
gb_3 gb_3
gb_2 gb_2
em_interval em_interval
gb_1 gb_1
end type
global u_cst_schedule u_cst_schedule

type variables
Private:

integer	ii_Mode

Public:

constant integer	SUCCESS = 1
constant integer	ONCE = 1
constant integer	SECONDS = 2
constant integer	MINUTES = 3
constant integer	HOURS = 4
constant integer	DAYS = 5
constant integer	WEEKS = 6
constant integer	MONTHS = 7
end variables

forward prototypes
public function integer of_interval (boolean ab_enabled)
public function integer of_setschedule (integer ai_mode, integer ai_interval, datetime adt_begin, datetime adt_end)
private subroutine of_schedulemodified ()
end prototypes

public function integer of_interval (boolean ab_enabled);
//	Description:
//	Enables interval controls.
//
//	Syntax:
//	of_Interval ( Enabled )
//
//	Arguments:
//	Enabled		When true, controls are enabled, false they are diabled.
//
//	Returns 1 for success.

//	Declarations.
integer	li_ReturnValue = SUCCESS

em_interval.enabled = ab_Enabled
rb_seconds.enabled = ab_Enabled
rb_minutes.enabled = ab_Enabled
rb_hours.enabled = ab_Enabled
rb_days.enabled = ab_Enabled
rb_weeks.enabled = ab_Enabled
rb_months.enabled = ab_Enabled

//	Return success.
return li_ReturnValue
end function

public function integer of_setschedule (integer ai_mode, integer ai_interval, datetime adt_begin, datetime adt_end);
//	Description:
//	Sets schedule according to passed values.
//
//	Syntax:
//	of_Interval ( Type )
//
//	Arguments:
//	Type		Radio button that was clicked
//
//	Returns 1 for success.

//	Declarations.
integer	li_ReturnValue = SUCCESS

//	Uncheck all.
rb_once.checked = false
rb_every.checked = false
rb_seconds.checked = false
rb_minutes.checked = false
rb_hours.checked = false
rb_days.checked = false
rb_weeks.checked = false
rb_months.checked = false

//	Set radio buttons.
choose case ai_Mode
	case ONCE
		rb_once.checked = true
		rb_once.post event clicked ( )
	case SECONDS
		rb_every.checked = true
		rb_seconds.checked = true
		rb_seconds.post event clicked ( )
	case MINUTES
		rb_every.checked = true
		rb_minutes.checked = true
		rb_minutes.post event clicked ( )
	case HOURS
		rb_every.checked = true
		rb_hours.checked = true
		rb_hours.post event clicked ( )
	case DAYS
		rb_every.checked = true
		rb_days.checked = true
		rb_days.post event clicked ( )
	case WEEKS
		rb_every.checked = true
		rb_weeks.checked = true
		rb_weeks.post event clicked ( )
	case MONTHS
		rb_every.checked = true
		rb_months.checked = true
		rb_months.post event clicked ( )
end choose

//	Set interval.
em_Interval.text = String ( ai_Interval )

//	Set begin and end date times.
em_Begin.text = String ( adt_Begin, "[shortdate] [time]" )
em_End.text = String ( adt_End, "[shortdate] [time]" )

//	Return success.
return li_ReturnValue
end function

private subroutine of_schedulemodified ();
//	Declarations
datetime	ldt_Begin
datetime	ldt_End

decimal	ldec_Interval

//	Get values from edit masks.
em_Interval.GetData ( ldec_Interval )
em_Begin.GetData ( ldt_Begin )
em_End.GetData ( ldt_End )

//	Send modified message.
if rb_once.checked then
	event ue_Modified ( 1, ONCE, ldt_Begin, ldt_End )
else
	event ue_Modified ( Integer ( ldec_Interval ), ii_Mode, ldt_Begin, ldt_End )
end if
end subroutine

on u_cst_schedule.create
this.em_end=create em_end
this.em_begin=create em_begin
this.st_2=create st_2
this.st_1=create st_1
this.rb_months=create rb_months
this.rb_weeks=create rb_weeks
this.rb_days=create rb_days
this.rb_hours=create rb_hours
this.rb_minutes=create rb_minutes
this.rb_seconds=create rb_seconds
this.rb_every=create rb_every
this.rb_once=create rb_once
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_interval=create em_interval
this.gb_1=create gb_1
this.Control[]={this.em_end,&
this.em_begin,&
this.st_2,&
this.st_1,&
this.rb_months,&
this.rb_weeks,&
this.rb_days,&
this.rb_hours,&
this.rb_minutes,&
this.rb_seconds,&
this.rb_every,&
this.rb_once,&
this.gb_3,&
this.gb_2,&
this.em_interval,&
this.gb_1}
end on

on u_cst_schedule.destroy
destroy(this.em_end)
destroy(this.em_begin)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_months)
destroy(this.rb_weeks)
destroy(this.rb_days)
destroy(this.rb_hours)
destroy(this.rb_minutes)
destroy(this.rb_seconds)
destroy(this.rb_every)
destroy(this.rb_once)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_interval)
destroy(this.gb_1)
end on

type em_end from editmask within u_cst_schedule
int X=347
int Y=796
int Width=645
int Height=76
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
string Mask="[date][time]"
MaskDataType MaskDataType=DateTimeMask!
boolean Spin=true
double Increment=1
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;
//	Send modified message.
of_ScheduleModified ( )
end event

type em_begin from editmask within u_cst_schedule
int X=347
int Y=656
int Width=645
int Height=76
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string Mask="[date][time]"
MaskDataType MaskDataType=DateTimeMask!
boolean Spin=true
double Increment=1
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;
//	Send modified message.
of_ScheduleModified ( )
end event

type st_2 from statictext within u_cst_schedule
int X=192
int Y=812
int Width=178
int Height=76
boolean Enabled=false
string Text="End:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_cst_schedule
int X=192
int Y=676
int Width=178
int Height=76
boolean Enabled=false
string Text="Begin:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_months from radiobutton within u_cst_schedule
int X=928
int Y=388
int Width=288
int Height=76
boolean Enabled=false
string Text="Months"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Set mode.
ii_Mode = MONTHS

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_weeks from radiobutton within u_cst_schedule
int X=928
int Y=296
int Width=288
int Height=76
boolean Enabled=false
string Text="Weeks"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Set mode.
ii_Mode = WEEKS

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_days from radiobutton within u_cst_schedule
int X=928
int Y=204
int Width=288
int Height=76
boolean Enabled=false
string Text="Days"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Set mode.
ii_Mode = DAYS

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_hours from radiobutton within u_cst_schedule
int X=613
int Y=388
int Width=315
int Height=76
boolean Enabled=false
string Text="Hours"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Set mode.
ii_Mode = HOURS

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_minutes from radiobutton within u_cst_schedule
int X=613
int Y=296
int Width=315
int Height=76
boolean Enabled=false
string Text="Minutes"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Set mode.
ii_Mode = MINUTES

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_seconds from radiobutton within u_cst_schedule
int X=613
int Y=204
int Width=315
int Height=76
boolean Enabled=false
string Text="Seconds"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Set mode.
ii_Mode = SECONDS

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_every from radiobutton within u_cst_schedule
int X=50
int Y=184
int Width=247
int Height=76
string Text="Every"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Enable interval selections.
of_Interval ( true )

//	Send modified message.
of_ScheduleModified ( )
end event

type rb_once from radiobutton within u_cst_schedule
int X=50
int Y=92
int Width=247
int Height=76
string Text="Once"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Disable interval selections.
of_Interval ( false )

//	Default every mode to seconds.
rb_seconds.checked = true

//	Set mode.
ii_Mode = SECONDS

//	Send modified message.
of_ScheduleModified ( )
end event

type gb_3 from groupbox within u_cst_schedule
int X=585
int Y=104
int Width=603
int Height=396
int TabOrder=50
boolean Visible=false
string Text="none"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within u_cst_schedule
int X=14
int Y=556
int Width=1221
int Height=412
int TabOrder=10
string Text="Begin/Ending"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_interval from editmask within u_cst_schedule
int X=297
int Y=184
int Width=302
int Height=84
int TabOrder=20
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
boolean Spin=true
string MinMax="1~~99999"
string Text="1"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;
//	Send modified message.
of_ScheduleModified ( )
end event

type gb_1 from groupbox within u_cst_schedule
int X=14
int Y=8
int Width=1221
int Height=528
int TabOrder=60
string Text="Run"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


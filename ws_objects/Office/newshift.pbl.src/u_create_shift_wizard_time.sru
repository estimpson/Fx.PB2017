$PBExportHeader$u_create_shift_wizard_time.sru
forward
global type u_create_shift_wizard_time from u_wizard_ancestor
end type
type uo_1 from u_hour_min_pm_digital_clock within u_create_shift_wizard_time
end type
type rb_1 from radiobutton within u_create_shift_wizard_time
end type
type rb_2 from radiobutton within u_create_shift_wizard_time
end type
type rb_3 from radiobutton within u_create_shift_wizard_time
end type
type vsb_1 from vscrollbar within u_create_shift_wizard_time
end type
type gb_1 from groupbox within u_create_shift_wizard_time
end type
type st_1 from statictext within u_create_shift_wizard_time
end type
type st_2 from statictext within u_create_shift_wizard_time
end type
type st_3 from statictext within u_create_shift_wizard_time
end type
type rb_4 from radiobutton within u_create_shift_wizard_time
end type
type rb_5 from radiobutton within u_create_shift_wizard_time
end type
type em_1 from editmask within u_create_shift_wizard_time
end type
type em_2 from editmask within u_create_shift_wizard_time
end type
type st_4 from statictext within u_create_shift_wizard_time
end type
end forward

global type u_create_shift_wizard_time from u_wizard_ancestor
uo_1 uo_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
vsb_1 vsb_1
gb_1 gb_1
st_1 st_1
st_2 st_2
st_3 st_3
rb_4 rb_4
rb_5 rb_5
em_1 em_1
em_2 em_2
st_4 st_4
end type
global u_create_shift_wizard_time u_create_shift_wizard_time

type variables
INTEGER	ii_Position = 0, &
	ii_RelMaxPos = 1438, &
	ii_RelMinPos = 0
end variables

on ue_paint;call u_wizard_ancestor::ue_paint;uo_1.ib_24HourDisplay = FALSE
uo_1.it_Time = Time ( em_1.Text )
uo_1.TriggerEvent ( 'ue_paint' )
w_create_new_shift_wizard.wf_enable_next ( TRUE )
end on

on u_create_shift_wizard_time.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.vsb_1=create vsb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.em_1=create em_1
this.em_2=create em_2
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.vsb_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.rb_4
this.Control[iCurrent+11]=this.rb_5
this.Control[iCurrent+12]=this.em_1
this.Control[iCurrent+13]=this.em_2
this.Control[iCurrent+14]=this.st_4
end on

on u_create_shift_wizard_time.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.vsb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_4)
end on

type uo_1 from u_hour_min_pm_digital_clock within u_create_shift_wizard_time
int X=18
int Y=456
int TabOrder=30
end type

on uo_1.destroy
call u_hour_min_pm_digital_clock::destroy
end on

type rb_1 from radiobutton within u_create_shift_wizard_time
int X=1367
int Y=584
int Width=251
int Height=72
string Text="Hour"
boolean Checked=true
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within u_create_shift_wizard_time
int X=1367
int Y=660
int Width=261
int Height=72
string Text="15 Min"
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within u_create_shift_wizard_time
int X=1367
int Y=736
int Width=261
int Height=72
string Text="Minute"
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type vsb_1 from vscrollbar within u_create_shift_wizard_time
event ue_paint_time pbm_custom01
int X=1106
int Y=456
int Width=73
int Height=416
boolean Enabled=false
int MaxPosition=1439
end type

on ue_paint_time;uo_1.it_Time = Time ( ii_Position / 60, Mod ( ii_Position, 60 ), 0 )
IF rb_4.Checked THEN
	em_1.Text = String ( uo_1.it_Time, 'hh:mm AM/PM' )
//	IF Time ( em_1.Text ) >= Time ( em_2.Text ) THEN
//		em_2.Text = String ( RelativeTime ( uo_1.it_Time, 60 ), 'hh:mm AM/PM' )
//	END IF
ELSE
	em_2.Text = String ( uo_1.it_Time, 'hh:mm AM/PM' )
END IF
IF Time ( em_1.Text ) >= Time ( em_2.Text ) THEN
	st_4.Visible = TRUE
ELSE
	st_4.Visible = FALSE
END IF
uo_1.TriggerEvent ( 'ue_paint' )
end on

on lineup;IF ii_Position > ii_RelMinPos THEN
	IF rb_1.Checked THEN
		ii_Position = ( ii_Position / 60 ) - 1
		ii_Position *= 60
	ELSEIF rb_2.Checked THEN
		ii_Position = ( ii_Position / 15 ) - 1
		ii_Position *= 15
	ELSE
		ii_Position -= 1
	END IF
END IF
IF ii_Position < ii_RelMinPos THEN
	ii_Position = ii_RelMinPos
END IF
Position = ii_Position
TriggerEvent ( 'ue_paint_time' )
end on

on linedown;IF ii_Position < ii_RelMaxPos THEN
	IF rb_1.Checked THEN
		ii_Position = ( ii_Position / 60 ) + 1
		ii_Position *= 60
	ELSEIF rb_2.Checked THEN
		ii_Position = ( ii_Position / 15 ) + 1
		ii_Position *= 15
	ELSE
		ii_Position += 1
	END IF
END IF
IF ii_Position > ii_RelMaxPos THEN
	ii_Position = ii_RelMaxPos
END IF
Position = ii_Position
TriggerEvent ( 'ue_paint_time' )
end on

on pagedown;TriggerEvent ( 'ue_paint_time' )
end on

on pageup;TriggerEvent ( 'ue_paint_time' )
end on

event moved;ii_Position = scrollpos
if ii_Position < ii_RelMinPos then
	scrollpos = ii_RelMinPos	
	ii_Position = scrollpos
end if 	
IF ii_Position < ii_RelMaxPos THEN
	IF rb_1.Checked THEN
		ii_Position = ( ii_Position / 60 ) + 1
		ii_Position *= 60
	ELSEIF rb_2.Checked THEN
		ii_Position = ( ii_Position / 15 ) + 1
		ii_Position *= 15
	ELSE
		ii_Position += 1
	END IF
END IF
IF ii_Position > ii_RelMaxPos THEN
	scrollpos = ii_RelMaxPos		
	ii_Position = scrollpos
END IF
Position = ii_Position
TriggerEvent ( 'ue_paint_time' )
end event

type gb_1 from groupbox within u_create_shift_wizard_time
int X=1307
int Y=516
int Width=357
int Height=324
int TabOrder=40
string Text="Increment"
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_create_shift_wizard_time
int X=1605
int Y=152
int Width=311
int Height=72
boolean Enabled=false
string Text="Begin Time"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_create_shift_wizard_time
int X=1605
int Y=240
int Width=265
int Height=72
boolean Enabled=false
string Text="End Time"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_create_shift_wizard_time
int X=18
int Y=12
int Width=1161
int Height=360
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

on constructor;Text = 'Specify Begin and End times using the digital clock or by manual entry.  If a shift spans midnight, set the end time to any time less than the begin time.  No shift can be longer than 24 hours.'
end on

type rb_4 from radiobutton within u_create_shift_wizard_time
int X=1253
int Y=136
int Width=73
int Height=72
boolean Checked=true
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ii_RelMinPos = 0
ii_RelMaxPos = 1438
vsb_1.Position = Hour ( Time ( em_1.Text) ) * 60 + Minute ( Time ( em_1.Text ) )
ii_Position = vsb_1.Position
uo_1.it_Time = Time ( em_1.Text )
uo_1.TriggerEvent ( 'ue_paint' )
end on

type rb_5 from radiobutton within u_create_shift_wizard_time
int X=1253
int Y=256
int Width=73
int Height=72
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//ii_RelMinPos = Hour ( Time ( em_1.Text ) ) * 60 + Minute ( Time ( em_1.Text ) ) + 1
ii_RelMinPos = 0
ii_RelMaxPos = 1439
vsb_1.Position = Hour ( Time ( em_2.Text) ) * 60 + Minute ( Time ( em_2.Text ) )
ii_Position = vsb_1.Position
uo_1.it_Time = Time ( em_2.Text )
uo_1.TriggerEvent ( 'ue_paint' )
end on

type em_1 from editmask within u_create_shift_wizard_time
int X=1344
int Y=128
int Width=229
int Height=100
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm AM/PM"
MaskDataType MaskDataType=TimeMask!
double Increment=1
string MinMax="~~"
string Text="12:00 A"
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;IF Time ( Text ) > Time ( '11:58 PM' ) THEN
	Text = '11:58 PM'
//	em_2.Text = '11:59 PM'
//ELSEIF Time ( Text ) >= Time ( em_2.Text ) THEN
//	em_2.Text = String ( RelativeTime ( Time ( em_1.Text ), 60 ), 'hh:mm AM/PM' )
END IF
IF Time ( Text ) >= Time ( em_2.Text ) THEN
	st_4.Visible = TRUE
ELSE
	st_4.Visible = FALSE
END IF
rb_4.TriggerEvent ( 'clicked' )
end on

on getfocus;rb_4.Checked = TRUE
rb_4.TriggerEvent ( 'clicked' )
end on

type em_2 from editmask within u_create_shift_wizard_time
int X=1344
int Y=252
int Width=229
int Height=100
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm AM/PM"
MaskDataType MaskDataType=TimeMask!
string Text="12:00 A"
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;IF Time ( Text ) <= Time ( em_1.Text ) THEN
	st_4.Visible = TRUE
ELSE
	st_4.Visible = FALSE
END IF
//IF Time ( Text ) <= Time ( em_1.Text ) THEN
//	Text = String ( RelativeTime ( Time ( em_1.Text ), 60 ), 'hh:mm AM/PM' )
//END IF
rb_5.TriggerEvent ( 'clicked' )
end on

on getfocus;rb_5.Checked = TRUE
rb_5.TriggerEvent ( 'clicked' )
end on

type st_4 from statictext within u_create_shift_wizard_time
int X=1605
int Y=344
int Width=270
int Height=56
boolean Enabled=false
string Text="NEXT DAY"
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


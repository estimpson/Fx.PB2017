$PBExportHeader$w_shift_time_scale.srw
$PBExportComments$Showing the shift in the day time scale
forward
global type w_shift_time_scale from Window
end type
type st_43 from statictext within w_shift_time_scale
end type
type st_42 from statictext within w_shift_time_scale
end type
type em_1 from singlelineedit within w_shift_time_scale
end type
type st_41 from statictext within w_shift_time_scale
end type
type st_40 from statictext within w_shift_time_scale
end type
type st_39 from statictext within w_shift_time_scale
end type
type st_38 from statictext within w_shift_time_scale
end type
type st_37 from statictext within w_shift_time_scale
end type
type st_36 from statictext within w_shift_time_scale
end type
type st_35 from statictext within w_shift_time_scale
end type
type st_34 from statictext within w_shift_time_scale
end type
type st_33 from statictext within w_shift_time_scale
end type
type st_32 from statictext within w_shift_time_scale
end type
type st_31 from statictext within w_shift_time_scale
end type
type st_30 from statictext within w_shift_time_scale
end type
type cb_2 from commandbutton within w_shift_time_scale
end type
type cb_1 from commandbutton within w_shift_time_scale
end type
type sle_hours from singlelineedit within w_shift_time_scale
end type
type st_29 from statictext within w_shift_time_scale
end type
type sle_end_time from singlelineedit within w_shift_time_scale
end type
type st_28 from statictext within w_shift_time_scale
end type
type sle_begin_time from singlelineedit within w_shift_time_scale
end type
type st_27 from statictext within w_shift_time_scale
end type
type st_26 from statictext within w_shift_time_scale
end type
type p_2 from picture within w_shift_time_scale
end type
type p_1 from picture within w_shift_time_scale
end type
type st_24 from statictext within w_shift_time_scale
end type
type st_23 from statictext within w_shift_time_scale
end type
type st_22 from statictext within w_shift_time_scale
end type
type st_21 from statictext within w_shift_time_scale
end type
type st_20 from statictext within w_shift_time_scale
end type
type st_19 from statictext within w_shift_time_scale
end type
type st_18 from statictext within w_shift_time_scale
end type
type st_17 from statictext within w_shift_time_scale
end type
type st_16 from statictext within w_shift_time_scale
end type
type st_15 from statictext within w_shift_time_scale
end type
type st_14 from statictext within w_shift_time_scale
end type
type st_12 from statictext within w_shift_time_scale
end type
type st_11 from statictext within w_shift_time_scale
end type
type st_10 from statictext within w_shift_time_scale
end type
type st_9 from statictext within w_shift_time_scale
end type
type st_8 from statictext within w_shift_time_scale
end type
type st_7 from statictext within w_shift_time_scale
end type
type st_6 from statictext within w_shift_time_scale
end type
type st_5 from statictext within w_shift_time_scale
end type
type st_4 from statictext within w_shift_time_scale
end type
type st_3 from statictext within w_shift_time_scale
end type
type st_2 from statictext within w_shift_time_scale
end type
type st_1 from statictext within w_shift_time_scale
end type
type st_13 from statictext within w_shift_time_scale
end type
type st_25 from statictext within w_shift_time_scale
end type
type gb_1 from groupbox within w_shift_time_scale
end type
type ln_1 from line within w_shift_time_scale
end type
type r_shift from rectangle within w_shift_time_scale
end type
end forward

global type w_shift_time_scale from Window
int X=73
int Y=184
int Width=2775
int Height=572
long BackColor=77897888
WindowType WindowType=popup!
st_43 st_43
st_42 st_42
em_1 em_1
st_41 st_41
st_40 st_40
st_39 st_39
st_38 st_38
st_37 st_37
st_36 st_36
st_35 st_35
st_34 st_34
st_33 st_33
st_32 st_32
st_31 st_31
st_30 st_30
cb_2 cb_2
cb_1 cb_1
sle_hours sle_hours
st_29 st_29
sle_end_time sle_end_time
st_28 st_28
sle_begin_time sle_begin_time
st_27 st_27
st_26 st_26
p_2 p_2
p_1 p_1
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_19 st_19
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_13 st_13
st_25 st_25
gb_1 gb_1
ln_1 ln_1
r_shift r_shift
end type
global w_shift_time_scale w_shift_time_scale

type variables
Boolean bDragBeginArrow
Boolean bDragEndArrow

Integer iDistance = 73
end variables

forward prototypes
public function decimal wf_get_hours (time tBeginTime, time tEndTime)
public function time wf_get_end_time (time tbegintime, decimal nhours)
public subroutine wf_draw_bar (time tbegintime, decimal nhours)
end prototypes

public function decimal wf_get_hours (time tBeginTime, time tEndTime);If IsNull(tBeginTime) then
	Return 0
End If

If IsNull(tEndTime) then
	Return 0
End If

If tEndTime < tBeginTime then
	Return (24 - (SecondsAfter(tEndTime, tBeginTime) / 3600))
Else
	Return SecondsAfter(tBeginTime, tEndTime) / 3600
End If
end function

public function time wf_get_end_time (time tbegintime, decimal nhours);Decimal 	nTotalHours

Integer	iHour
Integer	iMinute
Integer	iSecond

nTotalHours	= nHours + Hour(tBeginTime) + (Minute(tBeginTime) / 60) + (Second(tBeginTime) / 3600)

Do while nTotalHours >= 24 
	nTotalHours	= nTotalHours - 24
Loop

iHour		= Truncate(nTotalHours ,0)
iMinute	= Truncate((nTotalHours - iHour) * 60, 0)
iSecond	= (nTotalHours - iHour - (iMinute / 60)) * 3600

Return Time(iHour, iMinute, iSecond)
end function

public subroutine wf_draw_bar (time tbegintime, decimal nhours);Integer 	iHour
Integer 	iMinute
Integer 	nSeconds

Time		tTime

iHour						= Hour(tBeginTime)
iMinute					= Minute(tBeginTime)

r_shift.x			=	st_1.x + ((iHour + (iMinute / 60)) * iDistance)

//----------- Check whether goes to next day ----------------------------
If (r_shift.x + (nHours * iDistance)) / iDistance >= 24 then
	nSeconds			=  ((r_shift.x / iDistance) + nHours	- 24) * 3600
	tTime				=  RelativeTime(Time("00:00:00"), nSeconds)
Else	//----------Same day-----------------------------------------------
	tTime				=  RelativeTime(tBeginTime, nHours * 3600)
End If

iHour			=  Hour(tTime)
iMinute		=  Minute(tTime)

p_1.x			= r_shift.x - p_1.width
p_2.x			= r_shift.x	+ (nHours * iDistance)

r_shift.width = (nHours * iDistance)				
end subroutine

on open;Integer iHour
Integer iMinute

Time    tTime
Decimal nSeconds

Long    iWidth

w_plant_monitor.enabled	= FALSE

em_1.text				= "30"
sle_begin_time.text	= String(w_plant_monitor.tShiftBeginTime)
sle_hours.text			= String(Truncate(w_plant_monitor.nShiftHour, 2))
sle_end_time.text		= String(wf_get_end_time(w_plant_monitor.tShiftBeginTime, &
															 w_plant_monitor.nShiftHour))

wf_draw_bar(w_plant_monitor.tShiftBeginTime, w_plant_monitor.nShiftHour)


end on

on dragwithin;Integer iHour
Integer iMinute
Integer iSecond
Integer iCurrentX
Integer iCurrentEndX
Integer iOrigHour

Decimal nValue


If bDragBeginArrow then
	iCurrentEndX	= r_shift.X + r_shift.Width
	nValue	= (PointerX() + (p_1.width / 2) - st_1.x) / iDistance
	iHour		= Truncate(nValue, 0)

	nValue	= nValue - iHour
	iMinute	= Truncate(nValue * 60 , 0) / Integer(em_1.text)
	iMinute	= iMinute * Integer(em_1.text)
	If iMinute	= 60 then
		iMinute	= 0
	End If
	sle_begin_time.text	= String(iHour) + ":" + String(iMinute) + ":00"
	iCurrentX= st_1.X + ((iHour + (iMinute / 60)) * iDistance) 

	r_shift.width			= iCurrentEndX - iCurrentX 	
	r_shift.x				= iCurrentX 

Else

	nValue			= ( PointerX() - (p_2.Width / 2) - st_1.x) / iDistance

	iHour			= Truncate(nValue, 0)
	iOrigHour	= iHour

	If	iHour >= 24 then
		iHour		= iHour - 24
		nValue	= nValue - 24
	End If

	nValue	= nValue - iHour
	iMinute	= Truncate(nValue * 60 , 0) / Integer(em_1.text)
	iMinute	= iMinute * Integer(em_1.text)

	If iMinute	= 60 then
		iMinute	= 0
	End If
	
	sle_end_time.text	= String(iHour) + ":" + String(iMinute) + ":00"
	iCurrentX= st_1.x + ((iOrigHour + (iMinute / 60)) * iDistance)

	r_shift.width			= iCurrentX - r_shift.X	

End If	

sle_hours.text			= String(Truncate(r_shift.Width / iDistance , 2))

end on

on dragdrop;If bDragBeginArrow then
	p_1.x	= r_shift.x - p_1.Width
End If

If bDragEndArrow then
	p_2.X	= (r_shift.X + r_shift.Width)
End If


end on

on w_shift_time_scale.create
this.st_43=create st_43
this.st_42=create st_42
this.em_1=create em_1
this.st_41=create st_41
this.st_40=create st_40
this.st_39=create st_39
this.st_38=create st_38
this.st_37=create st_37
this.st_36=create st_36
this.st_35=create st_35
this.st_34=create st_34
this.st_33=create st_33
this.st_32=create st_32
this.st_31=create st_31
this.st_30=create st_30
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_hours=create sle_hours
this.st_29=create st_29
this.sle_end_time=create sle_end_time
this.st_28=create st_28
this.sle_begin_time=create sle_begin_time
this.st_27=create st_27
this.st_26=create st_26
this.p_2=create p_2
this.p_1=create p_1
this.st_24=create st_24
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.st_19=create st_19
this.st_18=create st_18
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_13=create st_13
this.st_25=create st_25
this.gb_1=create gb_1
this.ln_1=create ln_1
this.r_shift=create r_shift
this.Control[]={this.st_43,&
this.st_42,&
this.em_1,&
this.st_41,&
this.st_40,&
this.st_39,&
this.st_38,&
this.st_37,&
this.st_36,&
this.st_35,&
this.st_34,&
this.st_33,&
this.st_32,&
this.st_31,&
this.st_30,&
this.cb_2,&
this.cb_1,&
this.sle_hours,&
this.st_29,&
this.sle_end_time,&
this.st_28,&
this.sle_begin_time,&
this.st_27,&
this.st_26,&
this.p_2,&
this.p_1,&
this.st_24,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.st_19,&
this.st_18,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_13,&
this.st_25,&
this.gb_1,&
this.ln_1,&
this.r_shift}
end on

on w_shift_time_scale.destroy
destroy(this.st_43)
destroy(this.st_42)
destroy(this.em_1)
destroy(this.st_41)
destroy(this.st_40)
destroy(this.st_39)
destroy(this.st_38)
destroy(this.st_37)
destroy(this.st_36)
destroy(this.st_35)
destroy(this.st_34)
destroy(this.st_33)
destroy(this.st_32)
destroy(this.st_31)
destroy(this.st_30)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_hours)
destroy(this.st_29)
destroy(this.sle_end_time)
destroy(this.st_28)
destroy(this.sle_begin_time)
destroy(this.st_27)
destroy(this.st_26)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_24)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_13)
destroy(this.st_25)
destroy(this.gb_1)
destroy(this.ln_1)
destroy(this.r_shift)
end on

on close;w_plant_monitor.enabled		= TRUE
w_plant_monitor.BringToTop	= TRUE
end on

type st_43 from statictext within w_shift_time_scale
int X=2505
int Y=256
int Width=128
int Height=64
boolean Enabled=false
string Text="Mins"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_42 from statictext within w_shift_time_scale
int X=2021
int Y=264
int Width=261
int Height=72
boolean Enabled=false
string Text="Time Grid"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from singlelineedit within w_shift_time_scale
int X=2304
int Y=256
int Width=183
int Height=72
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="30"
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_41 from statictext within w_shift_time_scale
int X=2670
int Y=100
int Width=73
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_40 from statictext within w_shift_time_scale
int X=2597
int Y=100
int Width=55
int Height=64
boolean Enabled=false
string Text="11"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_39 from statictext within w_shift_time_scale
int X=2523
int Y=100
int Width=64
int Height=64
boolean Enabled=false
string Text="10"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_38 from statictext within w_shift_time_scale
int X=2450
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="9"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_37 from statictext within w_shift_time_scale
int X=2377
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="8"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_36 from statictext within w_shift_time_scale
int X=2304
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="7"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_35 from statictext within w_shift_time_scale
int X=2231
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="6"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_34 from statictext within w_shift_time_scale
int X=2158
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="5"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_33 from statictext within w_shift_time_scale
int X=2085
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="4"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_32 from statictext within w_shift_time_scale
int X=2011
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="3"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_31 from statictext within w_shift_time_scale
int X=1938
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="2"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_30 from statictext within w_shift_time_scale
int X=1865
int Y=100
int Width=41
int Height=64
boolean Enabled=false
string Text="1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_shift_time_scale
int X=1403
int Y=400
int Width=247
int Height=108
int TabOrder=70
string Text="Exit"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(Parent)
end on

type cb_1 from commandbutton within w_shift_time_scale
int X=1093
int Y=400
int Width=247
int Height=108
int TabOrder=60
string Text="Save"
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;w_plant_monitor.tShiftBeginTime	= Time(sle_begin_time.text)
w_plant_monitor.tShiftEndTime		= Time(sle_end_time.text)
w_plant_monitor.nShiftHour			= Dec(sle_hours.text)
w_plant_monitor.TriggerEvent("update_shift")
Close(Parent)
end on

type sle_hours from singlelineedit within w_shift_time_scale
int X=1705
int Y=260
int Width=247
int Height=72
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If sle_begin_time.text	> " " then
	sle_end_time.text	= String(wf_get_end_time(Time(sle_begin_time.text), Dec(this.text)))
	wf_draw_bar(Time(sle_begin_time.text), Dec(sle_hours.text))
End If 
end on

type st_29 from statictext within w_shift_time_scale
int X=1477
int Y=260
int Width=174
int Height=72
boolean Enabled=false
string Text="Hours"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_end_time from singlelineedit within w_shift_time_scale
int X=1093
int Y=260
int Width=247
int Height=72
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If this.text > " " then
	sle_hours.text	= String(Truncate(wf_get_hours(Time(sle_begin_time.text), Time(sle_end_time.text)),2))
	wf_draw_bar(Time(sle_begin_time.text), Dec(sle_hours.text))
End If
end on

type st_28 from statictext within w_shift_time_scale
int X=805
int Y=260
int Width=251
int Height=72
boolean Enabled=false
string Text="End Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_begin_time from singlelineedit within w_shift_time_scale
int X=507
int Y=260
int Width=247
int Height=72
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;If this.text > " " then
	sle_hours.text	= String(Truncate(wf_get_hours(Time(this.text), Time(sle_end_time.text)), 2))
	wf_draw_bar(Time(sle_begin_time.text), Dec(sle_hours.text))
End If
end on

type st_27 from statictext within w_shift_time_scale
int X=187
int Y=260
int Width=311
int Height=72
boolean Enabled=false
string Text="Begin Time"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_26 from statictext within w_shift_time_scale
int X=901
int Y=144
int Width=73
int Height=40
boolean Enabled=false
string Text="PM"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_2 from picture within w_shift_time_scale
int X=2633
int Y=160
int Width=73
int Height=64
string PictureName="first1.bmp"
boolean FocusRectangle=false
end type

on clicked;bDragBeginArrow	= FALSE
bDragEndArrow		= TRUE
p_2.Drag(Begin!)

end on

type p_1 from picture within w_shift_time_scale
int X=110
int Y=160
int Width=73
int Height=64
string PictureName="last1.bmp"
boolean FocusRectangle=false
end type

on clicked;bDragEndArrow	= FALSE
bDragBeginArrow= TRUE
p_1.Drag(Begin!)
end on

type st_24 from statictext within w_shift_time_scale
int X=910
int Y=100
int Width=64
int Height=64
boolean Enabled=false
string Text="12"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_23 from statictext within w_shift_time_scale
int X=983
int Y=100
int Width=41
int Height=64
boolean Enabled=false
string Text="1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_22 from statictext within w_shift_time_scale
int X=1056
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="2"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_21 from statictext within w_shift_time_scale
int X=1129
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="3"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_20 from statictext within w_shift_time_scale
int X=1202
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="4"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_19 from statictext within w_shift_time_scale
int X=1275
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="5"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_18 from statictext within w_shift_time_scale
int X=1349
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="6"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_17 from statictext within w_shift_time_scale
int X=1422
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="7"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_16 from statictext within w_shift_time_scale
int X=1495
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="8"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_15 from statictext within w_shift_time_scale
int X=1568
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="9"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_shift_time_scale
int X=1641
int Y=100
int Width=64
int Height=64
boolean Enabled=false
string Text="10"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_shift_time_scale
int X=837
int Y=100
int Width=64
int Height=64
boolean Enabled=false
string Text="11"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_shift_time_scale
int X=763
int Y=100
int Width=64
int Height=64
boolean Enabled=false
string Text="10"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within w_shift_time_scale
int X=690
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="9"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_shift_time_scale
int X=617
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="8"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_shift_time_scale
int X=544
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="7"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_shift_time_scale
int X=471
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="6"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_shift_time_scale
int X=398
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="5"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_shift_time_scale
int X=325
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="4"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_shift_time_scale
int X=256
int Y=100
int Width=32
int Height=64
boolean Enabled=false
string Text="3"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_shift_time_scale
int X=178
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="2"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_shift_time_scale
int X=105
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_shift_time_scale
int X=32
int Y=100
int Width=37
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within w_shift_time_scale
int X=1714
int Y=100
int Width=55
int Height=64
boolean Enabled=false
string Text="11"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_25 from statictext within w_shift_time_scale
int X=1792
int Y=100
int Width=73
int Height=64
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_shift_time_scale
int X=5
int Y=24
int Width=1861
int Height=104
int TabOrder=10
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-5
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_1 from line within w_shift_time_scale
boolean Enabled=false
int BeginX=64
int BeginY=920
int EndX=1856
int EndY=920
int LineThickness=4
long LineColor=33554432
end type

type r_shift from rectangle within w_shift_time_scale
int X=155
int Y=24
int Width=2560
int Height=68
boolean Enabled=false
int LineThickness=4
long LineColor=12632256
long FillColor=8388608
end type


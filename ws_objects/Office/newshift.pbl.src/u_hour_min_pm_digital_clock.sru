$PBExportHeader$u_hour_min_pm_digital_clock.sru
forward
global type u_hour_min_pm_digital_clock from u_hour_min_digital_clock
end type
type st_1 from statictext within u_hour_min_pm_digital_clock
end type
end forward

global type u_hour_min_pm_digital_clock from u_hour_min_digital_clock
int Width=1079
st_1 st_1
end type
global u_hour_min_pm_digital_clock u_hour_min_pm_digital_clock

type variables
BOOLEAN	ib_24HourDisplay = TRUE
end variables

forward prototypes
private function integer uof_paint_time ()
end prototypes

private function integer uof_paint_time ();INTEGER	i_Hour, &
			i_Hour1, &
			i_Hour2, &
			i_Min, &
			i_Min1, &
			i_Min2, &
			i_Sec, &
			i_Sec1, &
			i_Sec2

i_Hour = Hour ( it_Time )
i_Hour1 = i_Hour / 10
i_Hour2 = Mod ( i_Hour, 10 )
i_Min = Minute ( it_Time )
i_Min1 = i_Min / 10
i_Min2 = Mod ( i_Min, 10 )
i_Sec = Second ( it_Time )
i_Sec1 = i_Sec / 10
i_Sec2 = Mod ( i_Sec, 10 )

IF ib_24HourDisplay = FALSE THEN
	CHOOSE CASE i_Hour
	CASE 0
		i_Hour1 = 1
		i_Hour2 = 2
		st_1.Visible = FALSE
	CASE 12
		st_1.Visible = TRUE
	CASE 13 TO 19
		i_Hour1 --
		i_Hour2 -= 2
		st_1.Visible = TRUE
	CASE 20 TO 21
		i_Hour1 -= 2
		i_Hour2 += 8
		st_1.Visible = TRUE
	CASE 22 TO 23
		i_Hour1 --
		i_Hour2 -= 2
		st_1.Visible = TRUE
	CASE ELSE
		st_1.Visible = FALSE
	END CHOOSE
END IF
		
uo_1.ii_Value = i_Hour1
uo_2.ii_Value = i_Hour2
uo_3.ii_Value = i_Min1
uo_4.ii_Value = i_Min2
uo_5.ii_Value = i_Sec1
uo_6.ii_Value = i_Sec2

uo_1.TriggerEvent ( 'ue_paint' )
uo_2.TriggerEvent ( 'ue_paint' )
uo_3.TriggerEvent ( 'ue_paint' )
uo_4.TriggerEvent ( 'ue_paint' )
uo_5.TriggerEvent ( 'ue_paint' )
uo_6.TriggerEvent ( 'ue_paint' )

Return 0
end function

on ue_paint;call u_hour_min_digital_clock::ue_paint;IF ib_DisplaySeconds THEN
	st_1.Move ( 1427, 1 )
ELSE
	st_1.Move ( 951, 1 )
END IF
end on

on u_hour_min_pm_digital_clock.create
int iCurrent
call u_hour_min_digital_clock::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_1
end on

on u_hour_min_pm_digital_clock.destroy
call u_hour_min_digital_clock::destroy
destroy(this.st_1)
end on

type st_1 from statictext within u_hour_min_pm_digital_clock
int X=951
int Width=119
int Height=85
boolean Enabled=false
boolean BringToTop=true
string Text="PM"
boolean FocusRectangle=false
long TextColor=255
long BackColor=0
int TextSize=-12
int Weight=700
string FaceName="Arial Black"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on constructor;Visible = FALSE
end on


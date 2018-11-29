$PBExportHeader$u_hour_min_digital_clock.sru
forward
global type u_hour_min_digital_clock from UserObject
end type
type uo_6 from u_clock_digit within u_hour_min_digital_clock
end type
type uo_5 from u_clock_digit within u_hour_min_digital_clock
end type
type uo_3 from u_clock_digit within u_hour_min_digital_clock
end type
type uo_2 from u_clock_digit within u_hour_min_digital_clock
end type
type uo_1 from u_clock_digit within u_hour_min_digital_clock
end type
type uo_4 from u_clock_digit within u_hour_min_digital_clock
end type
type oval_1 from oval within u_hour_min_digital_clock
end type
type oval_2 from oval within u_hour_min_digital_clock
end type
type oval_3 from oval within u_hour_min_digital_clock
end type
type oval_4 from oval within u_hour_min_digital_clock
end type
end forward

global type u_hour_min_digital_clock from UserObject
int Width=910
int Height=409
long BackColor=0
event ue_paint pbm_custom01
uo_6 uo_6
uo_5 uo_5
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
uo_4 uo_4
oval_1 oval_1
oval_2 oval_2
oval_3 oval_3
oval_4 oval_4
end type
global u_hour_min_digital_clock u_hour_min_digital_clock

type variables
TIME	it_Time

BOOLEAN	ib_DisplaySeconds
end variables

forward prototypes
private function integer uof_paint_time ()
end prototypes

on ue_paint;IF ib_DisplaySeconds THEN
	uo_5.Visible = TRUE
	uo_6.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = TRUE
ELSE
	uo_5.Visible = FALSE
	uo_6.Visible = FALSE
	oval_3.Visible = FALSE
	oval_4.Visible = FALSE
END IF
uof_paint_time ( )
end on

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

on u_hour_min_digital_clock.create
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
this.uo_4=create uo_4
this.oval_1=create oval_1
this.oval_2=create oval_2
this.oval_3=create oval_3
this.oval_4=create oval_4
this.Control[]={ this.uo_6,&
this.uo_5,&
this.uo_3,&
this.uo_2,&
this.uo_1,&
this.uo_4,&
this.oval_1,&
this.oval_2,&
this.oval_3,&
this.oval_4}
end on

on u_hour_min_digital_clock.destroy
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.uo_4)
destroy(this.oval_1)
destroy(this.oval_2)
destroy(this.oval_3)
destroy(this.oval_4)
end on

type uo_6 from u_clock_digit within u_hour_min_digital_clock
int X=1207
int Y=17
int Width=188
int Height=377
int TabOrder=30
boolean Visible=false
end type

on uo_6.destroy
call u_clock_digit::destroy
end on

type uo_5 from u_clock_digit within u_hour_min_digital_clock
int X=1006
int Y=13
int Width=188
int Height=377
int TabOrder=40
boolean Visible=false
end type

on uo_5.destroy
call u_clock_digit::destroy
end on

type uo_3 from u_clock_digit within u_hour_min_digital_clock
int X=503
int Y=13
int Width=188
int Height=377
int TabOrder=60
end type

on uo_3.destroy
call u_clock_digit::destroy
end on

type uo_2 from u_clock_digit within u_hour_min_digital_clock
int X=225
int Y=17
int Width=188
int Height=377
int TabOrder=20
end type

on uo_2.destroy
call u_clock_digit::destroy
end on

type uo_1 from u_clock_digit within u_hour_min_digital_clock
int X=14
int Y=17
int Height=377
int TabOrder=10
end type

on uo_1.destroy
call u_clock_digit::destroy
end on

type uo_4 from u_clock_digit within u_hour_min_digital_clock
int X=714
int Y=13
int Width=188
int Height=377
int TabOrder=50
end type

on uo_4.destroy
call u_clock_digit::destroy
end on

type oval_1 from oval within u_hour_min_digital_clock
int X=439
int Y=129
int Width=42
int Height=37
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_2 from oval within u_hour_min_digital_clock
int X=439
int Y=237
int Width=42
int Height=37
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_3 from oval within u_hour_min_digital_clock
int X=933
int Y=129
int Width=42
int Height=37
boolean Visible=false
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_4 from oval within u_hour_min_digital_clock
int X=933
int Y=237
int Width=42
int Height=37
boolean Visible=false
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type


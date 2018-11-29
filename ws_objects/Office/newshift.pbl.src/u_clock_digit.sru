$PBExportHeader$u_clock_digit.sru
forward
global type u_clock_digit from UserObject
end type
type oval_4 from oval within u_clock_digit
end type
type oval_5 from oval within u_clock_digit
end type
type oval_6 from oval within u_clock_digit
end type
type oval_7 from oval within u_clock_digit
end type
type oval_1 from oval within u_clock_digit
end type
type oval_2 from oval within u_clock_digit
end type
type oval_3 from oval within u_clock_digit
end type
end forward

global type u_clock_digit from UserObject
int Width=197
int Height=385
long BackColor=0
event ue_paint pbm_custom01
oval_4 oval_4
oval_5 oval_5
oval_6 oval_6
oval_7 oval_7
oval_1 oval_1
oval_2 oval_2
oval_3 oval_3
end type
global u_clock_digit u_clock_digit

type variables
INTEGER	ii_Value
end variables

forward prototypes
private function integer uof_paint_number ()
end prototypes

on ue_paint;uof_paint_number ( )
end on

private function integer uof_paint_number ();CHOOSE CASE ii_Value
CASE 0
	oval_1.Visible = TRUE
	oval_2.Visible = FALSE
	oval_3.Visible = TRUE
	oval_4.Visible = TRUE
	oval_5.Visible = TRUE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
CASE 1
	oval_1.Visible = FALSE
	oval_2.Visible = FALSE
	oval_3.Visible = FALSE
	oval_4.Visible = FALSE
	oval_5.Visible = FALSE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
CASE 2
	oval_1.Visible = TRUE
	oval_2.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = FALSE
	oval_5.Visible = TRUE
	oval_6.Visible = TRUE
	oval_7.Visible = FALSE
CASE 3
	oval_1.Visible = TRUE
	oval_2.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = FALSE
	oval_5.Visible = FALSE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
CASE 4
	oval_1.Visible = FALSE
	oval_2.Visible = TRUE
	oval_3.Visible = FALSE
	oval_4.Visible = TRUE
	oval_5.Visible = FALSE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
CASE 5
	oval_1.Visible = TRUE
	oval_2.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = TRUE
	oval_5.Visible = FALSE
	oval_6.Visible = FALSE
	oval_7.Visible = TRUE
CASE 6
	oval_1.Visible = TRUE
	oval_2.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = TRUE
	oval_5.Visible = TRUE
	oval_6.Visible = FALSE
	oval_7.Visible = TRUE
CASE 7
	oval_1.Visible = TRUE
	oval_2.Visible = FALSE
	oval_3.Visible = FALSE
	oval_4.Visible = FALSE
	oval_5.Visible = FALSE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
CASE 8
	oval_1.Visible = TRUE
	oval_2.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = TRUE
	oval_5.Visible = TRUE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
CASE 9
	oval_1.Visible = TRUE
	oval_2.Visible = TRUE
	oval_3.Visible = TRUE
	oval_4.Visible = TRUE
	oval_5.Visible = FALSE
	oval_6.Visible = TRUE
	oval_7.Visible = TRUE
END CHOOSE

Return 0
end function

on u_clock_digit.create
this.oval_4=create oval_4
this.oval_5=create oval_5
this.oval_6=create oval_6
this.oval_7=create oval_7
this.oval_1=create oval_1
this.oval_2=create oval_2
this.oval_3=create oval_3
this.Control[]={ this.oval_4,&
this.oval_5,&
this.oval_6,&
this.oval_7,&
this.oval_1,&
this.oval_2,&
this.oval_3}
end on

on u_clock_digit.destroy
destroy(this.oval_4)
destroy(this.oval_5)
destroy(this.oval_6)
destroy(this.oval_7)
destroy(this.oval_1)
destroy(this.oval_2)
destroy(this.oval_3)
end on

type oval_4 from oval within u_clock_digit
int X=5
int Y=37
int Width=42
int Height=145
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_5 from oval within u_clock_digit
int X=5
int Y=205
int Width=42
int Height=145
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_6 from oval within u_clock_digit
int X=147
int Y=37
int Width=42
int Height=145
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_7 from oval within u_clock_digit
int X=147
int Y=205
int Width=42
int Height=145
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_1 from oval within u_clock_digit
int X=23
int Y=5
int Width=147
int Height=37
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_2 from oval within u_clock_digit
int X=23
int Y=173
int Width=147
int Height=37
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type

type oval_3 from oval within u_clock_digit
int X=23
int Y=341
int Width=147
int Height=37
boolean Enabled=false
int LineThickness=5
long LineColor=255
long FillColor=255
end type


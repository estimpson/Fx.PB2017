$PBExportHeader$w_create_new_shift_wizard.srw
forward
global type w_create_new_shift_wizard from w_wizard_ancestor
end type
type cb_4 from commandbutton within w_create_new_shift_wizard
end type
type rb_1 from radiobutton within w_create_new_shift_wizard
end type
type rb_2 from radiobutton within w_create_new_shift_wizard
end type
type rb_3 from radiobutton within w_create_new_shift_wizard
end type
end forward

global type w_create_new_shift_wizard from w_wizard_ancestor
int Height=1240
event ue_open pbm_custom03
event ue_set_time pbm_custom04
cb_4 cb_4
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_create_new_shift_wizard w_create_new_shift_wizard

type variables
BOOLEAN	ib_EditShift

str_ShiftParm1	istr_ShiftParm
end variables

on ue_set_time;call w_wizard_ancestor::ue_set_time;u_create_shift_wizard_time uo_1

uo_1 = uo_Page [ 1 ]

uo_1.em_2.Text = String ( Time ( istr_ShiftParm.dt_EndDateTime ), 'hh:mm AM/PM' )
uo_1.em_1.Text = String ( Time ( istr_ShiftParm.dt_BeginDateTime ), 'hh:mm AM/PM' )
uo_1.em_1.TriggerEvent ( 'modified' )
end on

on open;call w_wizard_ancestor::open;STRING s_Machine

u_create_shift_wizard_machines	uo_create_shift_wizard_machines
u_create_shift_wizard_range		uo_create_shift_wizard_range
u_create_shift_wizard_time		uo_create_shift_wizard_time
u_create_shift_wizard_crew		uo_create_shift_wizard_crew

istr_ShiftParm = Message.PowerObjectParm

IF IsValid ( istr_ShiftParm ) THEN
	s_Machine = istr_ShiftParm.s_Machine
	ib_EditShift = TRUE
ELSE
	ib_EditShift = FALSE
END IF

uo_create_shift_wizard_machines = CREATE u_create_shift_wizard_machines
uo_create_shift_wizard_range = CREATE u_create_shift_wizard_range
uo_create_shift_wizard_time = CREATE u_create_shift_wizard_time
uo_create_shift_wizard_crew = CREATE u_create_shift_wizard_crew

IF ib_EditShift THEN

	   SELECT	end_datetime
	     INTO	:istr_ShiftParm.dt_EndDateTime
	     FROM	shop_floor_calendar
	    WHERE	machine = :istr_ShiftParm.s_Machine AND
				begin_datetime = :istr_ShiftParm.dt_BeginDateTime  ;

	IF SQLCA.SQLCode = 0 THEN
		uo_Page [ 1 ] = uo_create_shift_wizard_time

		ii_NumberOfPages = 1
		cb_4.Visible = TRUE
		rb_1.Visible = TRUE
		rb_2.Text += LeftA ( istr_ShiftParm.s_Machine, 8 )
		rb_2.Visible = TRUE
		rb_3.Visible = TRUE

		OpenUserObject ( uo_Page [ 1 ], 'uo_create_shift_wizard_time', 0, 0 )
		PostEvent ( 'ue_set_time' )
	ELSE
		MessageBox ( 'Warning', 'Shift not found!!!' )
		TriggerEvent ( 'close' )
		Return
	END IF
ELSE
	uo_Page [ 1 ] = uo_create_shift_wizard_machines
	uo_Page [ 2 ] = uo_create_shift_wizard_range
	uo_Page [ 3 ] = uo_create_shift_wizard_time
	uo_Page [ 4 ] = uo_create_shift_wizard_crew

	ii_NumberOfPages = 4

	OpenUserObject ( uo_Page [ 1 ], 'uo_create_shift_wizard_machines', 0, 0 )
	OpenUserObject ( uo_Page [ 2 ], 'uo_create_shift_wizard_range', 0, 0 )
	OpenUserObject ( uo_Page [ 3 ], 'uo_create_shift_wizard_time', 0, 0 )
	OpenUserObject ( uo_Page [ 4 ], 'uo_create_shift_wizard_crew', 0, 0 )
END IF

PostEvent ( 'ue_open' )
end on

event ue_finish;STRING	ls_Machine, &
		ls_LaborCode

INTEGER	li_MachineCount, &
			li_WeekCount, &
			li_DayCount, &
			li_CrewSize, &
			li_UpHours, &
			li_UpMins, &
			li_DateCarry

TIME	lt_BeginTime, &
		lt_EndTime

DATE	ld_ScheduleDate, &
		ld_EndDate

DATETIME		ldt_BeginDateTime, &
				ldt_EndDateTime

DECIMAL {2}	ldec_UpTime

u_create_shift_wizard_machines	uo_1
u_create_shift_wizard_range		uo_2
u_create_shift_wizard_time		uo_3
u_create_shift_wizard_crew		uo_4

IF NOT ib_EditShift THEN
	uo_1 = uo_Page [ 1 ]
	uo_2 = uo_Page [ 2 ]
	uo_3 = uo_Page [ 3 ]
	uo_4 = uo_Page [ 4 ]
ELSE
	uo_3 = uo_Page [ 1 ]
END IF

lt_BeginTime = Time ( uo_3.em_1.Text )
lt_EndTime = Time ( uo_3.em_2.Text )
li_UpHours =  Hour ( lt_EndTime ) - Hour ( lt_BeginTime )
li_UpMins = Minute ( lt_EndTime ) - Minute ( lt_BeginTime )
IF li_UpMins < 0 THEN
	li_UpHours --
	li_UpMins += 60
END IF
IF li_UpHours <= 0 THEN
	li_UpHours += 24
	li_DateCarry = 1
ELSE
	li_DateCarry = 0
END IF

ldec_UpTime = li_UpHours + ( li_UpMins / 60 )

IF NOT ib_EditShift THEN
	li_CrewSize = Integer ( uo_4.em_1.Text )
	ls_LaborCode = uo_4.lb_1.SelectedItem ( )
	IF ls_LaborCode = '<none>' THEN
		SetNull ( ls_LaborCode )
	END IF
	FOR li_MachineCount = 1 TO uo_1.lb_3.TotalItems ( )
		ls_Machine = uo_1.lb_3.Text ( li_MachineCount )
		ld_ScheduleDate = uo_2.istr_Range.d_Week
		FOR li_WeekCount = 1 TO uo_2.istr_Range.i_Weeks
			FOR li_DayCount = 1 TO 7
				IF uo_2.istr_Range.b_Days [ li_DayCount ] THEN
					ld_EndDate = RelativeDate ( ld_ScheduleDate, li_DateCarry )
					ldt_BeginDateTime = DateTime ( ld_ScheduleDate, lt_BeginTime )
					ldt_EndDateTime = DateTime ( ld_EndDate, lt_EndTime )

					INSERT INTO shop_floor_calendar
							(	machine,
								begin_datetime,
								end_datetime,
								labor_code,
								crew_size )
					  VALUES
							(	:ls_Machine,
								:ldt_BeginDateTime,
								:ldt_EndDateTime,
								:ls_LaborCode,
								:li_CrewSize  )  ;

					IF SQLCA.SQLCode <> 0 THEN
						IF SQLCA.SQLDBCode = -193 THEN
//							UPDATE shop_floor_calendar_new
//							   SET end_datetime = :ldt_EndDateTime,
//									labor_code = :ls_LaborCode,
//									crew_size = :li_CrewSize
//							 WHERE machine = :ls_Machine AND
//									begin_datetime = :ldt_BeginDateTime  ;
									
							UPDATE shop_floor_calendar_new
							   SET end_date = :ldt_EndDateTime,
									labor_code = :ls_LaborCode,
									crew_size = :li_CrewSize
							 WHERE machine = :ls_Machine AND
									begin_time = :ldt_BeginDateTime  ;
									
 							IF SQLCA.SQLCode <> 0 THEN
								MessageBox ( 'Error', 'Unable to create shifts!')
								Rollback  ;
								TriggerEvent ( 'close' )
								Return
							END IF
						ELSE
							MessageBox ( 'Error', 'Unable to create shifts!')

							Rollback  ;

							Halt
						END IF
					END IF
				END IF
				ld_ScheduleDate = RelativeDate ( ld_ScheduleDate, 1 )
			NEXT
		NEXT
	NEXT
ELSE
	ld_EndDate = RelativeDate ( Date ( istr_ShiftParm.dt_BeginDateTime ), li_DateCarry )
	ldt_EndDateTime = DateTime ( ld_EndDate, lt_EndTime )
	ldt_BeginDateTime = DateTime ( Date ( istr_ShiftParm.dt_BeginDateTime ), lt_BeginTime )
	UPDATE shop_floor_calendar
	   SET begin_datetime = :ldt_BeginDateTime,
			end_datetime = :ldt_EndDateTime
	 WHERE machine = :istr_ShiftParm.s_Machine AND
			begin_datetime = :istr_ShiftParm.dt_BeginDateTime  ;
	IF SQLCA.SQLCode <> 0 THEN
		MessageBox ( 'Error', 'Unable to create shifts!')
		Rollback  ;
		TriggerEvent ( 'close' )
		Return
	END IF
END IF

Commit  ;
			
PostEvent ( 'close' )
end event

on w_create_new_shift_wizard.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
end on

on w_create_new_shift_wizard.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
end on

type cb_3 from w_wizard_ancestor`cb_3 within w_create_new_shift_wizard
int X=1641
int Y=1024
end type

type cb_2 from w_wizard_ancestor`cb_2 within w_create_new_shift_wizard
int X=1289
int Y=1024
end type

type cb_1 from w_wizard_ancestor`cb_1 within w_create_new_shift_wizard
int X=937
int Y=1024
end type

type cb_4 from commandbutton within w_create_new_shift_wizard
int X=27
int Y=1024
int Width=288
int Height=84
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string Text="Delete"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;IF rb_1.Checked THEN

	DELETE FROM shop_floor_calendar
	 WHERE machine = :istr_ShiftParm.s_Machine AND
			begin_datetime = :istr_ShiftParm.dt_BeginDateTime  ;

ELSEIF rb_2.Checked THEN

	DELETE FROM shop_floor_calendar
	 WHERE machine = :istr_ShiftParm.s_Machine  ;

ELSE

	DELETE FROM shop_floor_calendar  ;

END IF

IF SQLCA.SQLCode <> 0 THEN
	MessageBox ( 'Error', 'Unable to delete shifts!' )
		Rollback  ;

	Parent.TriggerEvent ( 'close' )
	Return
END IF
Parent.TriggerEvent ( 'close' )

end on

type rb_1 from radiobutton within w_create_new_shift_wizard
int X=325
int Y=960
int Width=411
int Height=60
boolean Visible=false
boolean BringToTop=true
string Text="Current Shift"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_create_new_shift_wizard
int X=325
int Y=1024
int Width=690
int Height=60
boolean Visible=false
boolean BringToTop=true
string Text="All Shifts for "
BorderStyle BorderStyle=StyleLowered!
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_create_new_shift_wizard
int X=325
int Y=1088
int Width=320
int Height=60
boolean Visible=false
boolean BringToTop=true
string Text="All Shifts"
BorderStyle BorderStyle=StyleLowered!
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


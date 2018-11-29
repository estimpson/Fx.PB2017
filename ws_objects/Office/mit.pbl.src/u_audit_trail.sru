$PBExportHeader$u_audit_trail.sru
forward
global type u_audit_trail from UserObject
end type
type p_trash from picture within u_audit_trail
end type
type dw_audit_trail from datawindow within u_audit_trail
end type
type st_2 from statictext within u_audit_trail
end type
type st_1 from statictext within u_audit_trail
end type
type cb_exit from commandbutton within u_audit_trail
end type
type cb_reset from commandbutton within u_audit_trail
end type
type cb_accept from commandbutton within u_audit_trail
end type
type sle_operator_password from singlelineedit within u_audit_trail
end type
type em_serial from editmask within u_audit_trail
end type
type sle_operator_code from singlelineedit within u_audit_trail
end type
type st_operator from statictext within u_audit_trail
end type
type cb_cancel from commandbutton within u_audit_trail
end type
type cb_enter from commandbutton within u_audit_trail
end type
type cb_background from commandbutton within u_audit_trail
end type
end forward

global type u_audit_trail from UserObject
int Width=2798
int Height=992
long BackColor=12632256
long PictureMaskColor=25166016
long TabBackColor=67108864
p_trash p_trash
dw_audit_trail dw_audit_trail
st_2 st_2
st_1 st_1
cb_exit cb_exit
cb_reset cb_reset
cb_accept cb_accept
sle_operator_password sle_operator_password
em_serial em_serial
sle_operator_code sle_operator_code
st_operator st_operator
cb_cancel cb_cancel
cb_enter cb_enter
cb_background cb_background
end type
global u_audit_trail u_audit_trail

type variables
Long		il_AuditRow
Window		iw_Parent
String		is_TransactionType, &
		is_Machine
DateTime		idt_Today
end variables

forward prototypes
public subroutine uf_operator (boolean ab_mode)
public subroutine uf_setup_object (str_audit_trail astr_parm)
public subroutine uf_serial_search_attrib (boolean ab_Mode)
end prototypes

public subroutine uf_operator (boolean ab_mode);cb_exit.Enabled 					= ( NOT ab_Mode )
p_trash.Enabled 					= ( NOT ab_Mode )
st_operator.Visible				= ab_Mode
sle_operator_password.Visible	= ab_Mode
sle_operator_code.Visible		= ab_Mode
cb_accept.Visible					= ab_Mode
cb_cancel.Visible					= ab_Mode

CHOOSE CASE iw_Parent
	CASE w_job_complete
		w_job_complete.ib_Password 	= ab_Mode
		IF ab_Mode THEN
			w_job_complete.enable_chars ( )
			w_job_complete.enable_numbers ( )
		ELSE
			w_job_complete.disable_chars ( )
			w_job_complete.disable_numbers ( )
		END IF
		w_job_complete.cb_clear.Enabled 	= ab_Mode
		w_job_complete.cb_back.Enabled 	= ab_Mode
	CASE w_combo_scan
		w_combo_scan.ib_Password 	= ab_Mode
		IF ab_Mode THEN
			w_combo_scan.enable_chars ( )
			w_combo_scan.enable_numbers ( )
		ELSE
			w_combo_scan.disable_chars ( )
			w_combo_scan.disable_numbers ( )
		END IF
		w_combo_scan.cb_clear.Enabled 	= ab_Mode
		w_combo_scan.cb_back.Enabled 	= ab_Mode
	CASE w_touch_screen_generic_trans
		w_touch_screen_generic_trans.ib_Password = ab_Mode
		IF ab_Mode THEN
			w_touch_screen_generic_trans.enable_chars ( )
			w_touch_screen_generic_trans.enable_numbers ( )
		ELSE
			w_touch_screen_generic_trans.disable_chars ( )
			w_touch_screen_generic_trans.disable_numbers ( )
		END IF
		w_touch_screen_generic_trans.cb_37.Enabled 	= ab_Mode
		w_touch_screen_generic_trans.cb_57.Enabled 	= ab_Mode
END CHOOSE

sle_operator_password.SetFocus ( )
end subroutine

public subroutine uf_setup_object (str_audit_trail astr_parm);Long l_l_serial
iw_Parent = Parent
is_TransactionType	= astr_Parm.as_TransactionType
is_Machine				= astr_Parm.as_Machine
idt_Today 				= astr_Parm.adt_Today
/*  Setup audit trail datawindow  */
CHOOSE CASE is_TransactionType
	CASE "JC"
		dw_audit_trail.DataObject = "d_generic_audit_trail_by_machine"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve ( idt_Today, "J", is_Machine )
	CASE "CS"
		l_l_serial=Long (is_Machine)		
		dw_audit_trail.DataObject = "d_audit_trail"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve (l_l_serial)		
	CASE "MI"
		dw_audit_trail.DataObject = "d_generic_audit_trail_by_machine_mi"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve ( idt_Today, "M", is_Machine )
	CASE "BO"
		dw_audit_trail.DataObject = "d_generic_audit_trail"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve ( idt_Today, "B" )
	CASE "CB"
		dw_audit_trail.DataObject = "d_generic_audit_trail"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve ( idt_Today, "C" )
	CASE "QC"
		dw_audit_trail.DataObject = "d_generic_audit_trail"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve ( idt_Today, "Q" )
	CASE "TR"
		dw_audit_trail.DataObject = "d_generic_audit_trail"
		dw_audit_trail.SetTransObject ( sqlca )
		dw_audit_trail.Retrieve ( idt_Today, "T" )
END CHOOSE

/*  Setup trash can for undo  */
IF is_TransactionType = "JC" OR &
	is_TransactionType = "CS" OR &
	is_TransactionType = "MI" THEN
	p_trash.Show ( )
	IF is_TransactionType = "MI" THEN
		uf_serial_search_attrib ( TRUE )
	END IF
END IF

end subroutine

public subroutine uf_serial_search_attrib (boolean ab_Mode);IF ab_Mode THEN
	st_2.Show ( )
	em_serial.Show ( )
	cb_enter.Show ( )
	cb_reset.Show ( )
ELSE
	st_2.Hide ( )
	em_serial.Hide ( )
	cb_enter.Hide ( )
	cb_reset.Hide ( )
END IF	

end subroutine

event constructor;uf_setup_object ( Message.PowerObjectParm )
end event

on u_audit_trail.create
this.p_trash=create p_trash
this.dw_audit_trail=create dw_audit_trail
this.st_2=create st_2
this.st_1=create st_1
this.cb_exit=create cb_exit
this.cb_reset=create cb_reset
this.cb_accept=create cb_accept
this.sle_operator_password=create sle_operator_password
this.em_serial=create em_serial
this.sle_operator_code=create sle_operator_code
this.st_operator=create st_operator
this.cb_cancel=create cb_cancel
this.cb_enter=create cb_enter
this.cb_background=create cb_background
this.Control[]={this.p_trash,&
this.dw_audit_trail,&
this.st_2,&
this.st_1,&
this.cb_exit,&
this.cb_reset,&
this.cb_accept,&
this.sle_operator_password,&
this.em_serial,&
this.sle_operator_code,&
this.st_operator,&
this.cb_cancel,&
this.cb_enter,&
this.cb_background}
end on

on u_audit_trail.destroy
destroy(this.p_trash)
destroy(this.dw_audit_trail)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_exit)
destroy(this.cb_reset)
destroy(this.cb_accept)
destroy(this.sle_operator_password)
destroy(this.em_serial)
destroy(this.sle_operator_code)
destroy(this.st_operator)
destroy(this.cb_cancel)
destroy(this.cb_enter)
destroy(this.cb_background)
end on

type p_trash from picture within u_audit_trail
int X=2560
int Y=832
int Width=201
int Height=144
boolean Visible=false
string PictureName="trash.bmp"
boolean FocusRectangle=false
end type

on dragdrop;IF is_TransactionType = "MI" THEN
	uf_serial_search_attrib ( FALSE )
END IF
uf_operator ( TRUE )

end on

type dw_audit_trail from datawindow within u_audit_trail
int X=37
int Y=80
int Width=2725
int Height=736
int TabOrder=20
string DragIcon="BOX.ICO"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

on clicked;il_AuditRow = GetClickedRow ( )
SelectRow ( 0, False )

If il_AuditRow < 1 Then Return

SelectRow ( il_AuditRow, True )
SetRow ( il_AuditRow )
Drag ( Begin! )

end on

type st_2 from statictext within u_audit_trail
int X=713
int Y=832
int Width=914
int Height=144
boolean Visible=false
boolean Enabled=false
string Text="Scan / Enter Serial Number To Show Audit Trail for Undo:"
Alignment Alignment=Center!
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

type st_1 from statictext within u_audit_trail
int X=37
int Y=16
int Width=2725
int Height=64
boolean Enabled=false
string Text="Audit Trail"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_exit from commandbutton within u_audit_trail
int X=37
int Y=848
int Width=256
int Height=112
int TabOrder=30
string Text="E&xit"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iw_Parent.PostEvent ( "ue_close_audit_trail" )
end on

type cb_reset from commandbutton within u_audit_trail
int X=366
int Y=848
int Width=274
int Height=112
int TabOrder=70
boolean Visible=false
string Text="&Reset"
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_audit_trail.DataObject = "d_generic_audit_trail_by_machine_mi"
dw_audit_trail.SetTransObject ( sqlca )
dw_audit_trail.Show ( )
dw_audit_trail.Retrieve ( idt_Today, "M", is_Machine )

end on

type cb_accept from commandbutton within u_audit_trail
int X=1883
int Y=848
int Width=293
int Height=112
int TabOrder=90
boolean Visible=false
string Text="&Accept"
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;String	s_OperatorCode

SELECT operator_code  
  INTO :s_OperatorCode  
  FROM employee
 WHERE password = :sle_operator_password.Text   ;

IF SQLCA.SQLCode = 0 THEN
	sle_operator_code.Text = s_OperatorCode
	iw_Parent.PostEvent ( "undo" )
	uf_operator ( FALSE )
	IF is_TransactionType = "MI" THEN
		uf_serial_search_attrib ( TRUE )
	END IF
	u_audit_trail.SetRedraw ( TRUE )
ELSE
	MessageBox ( "Error", "Invalid operator password!  Please enter a valid one.", StopSign!  )
	sle_operator_password.Text = ''
	sle_operator_code.Text = ''
	sle_operator_password.SetFocus ( )
END IF

end on

type sle_operator_password from singlelineedit within u_audit_trail
int X=1262
int Y=864
int Width=219
int Height=96
int TabOrder=10
boolean Visible=false
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;cb_accept.PostEvent ( Clicked! )
end on

type em_serial from editmask within u_audit_trail
int X=1682
int Y=864
int Width=439
int Height=96
int TabOrder=50
boolean Visible=false
Alignment Alignment=Center!
string Mask="##########"
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_operator_code from singlelineedit within u_audit_trail
int X=1499
int Y=864
int Width=347
int Height=96
int TabOrder=40
boolean Visible=false
boolean Enabled=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_operator from statictext within u_audit_trail
int X=347
int Y=880
int Width=901
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Enter Your Operator Password:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within u_audit_trail
int X=2194
int Y=848
int Width=297
int Height=112
int TabOrder=80
boolean Visible=false
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;uf_operator ( FALSE )
IF is_TransactionType = "MI" THEN
	uf_serial_search_attrib ( TRUE )
END IF
end on

type cb_enter from commandbutton within u_audit_trail
int X=2194
int Y=848
int Width=293
int Height=112
int TabOrder=60
boolean Visible=false
string Text="&Enter"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	ll_Serial

If f_get_string_value ( em_serial.Text ) = "" Then Return

ll_Serial = Long ( em_serial.Text )

dw_audit_trail.DataObject = "d_generic_audit_trail_undo_mi"
dw_audit_trail.Show ( )
dw_audit_trail.SetTransObject ( sqlca )
If dw_audit_trail.Retrieve ( "M", ll_Serial ) < 1 Then
	f_beep ( 5 )
	MessageBox ( "Error", "This object shows no material issue in it's past!  Please check your serial number and try again.", StopSign! )
	em_serial.Text = ""
	dw_audit_trail.DataObject = "d_generic_audit_trail_by_machine_mi"
	dw_audit_trail.Show ( )
	dw_audit_trail.SetTransObject ( sqlca )
	dw_audit_trail.Retrieve ( idt_Today, "M", is_Machine )
	em_serial.SetFocus ( )
End if
end event

type cb_background from commandbutton within u_audit_trail
int Y=4
int Width=2798
int Height=992
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


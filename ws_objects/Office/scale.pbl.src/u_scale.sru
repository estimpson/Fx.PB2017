$PBExportHeader$u_scale.sru
forward
global type u_scale from UserObject
end type
type cb_ok from commandbutton within u_scale
end type
type uo_threshold from u_threshold_meter within u_scale
end type
type cb_cancel from commandbutton within u_scale
end type
type st_steady from statictext within u_scale
end type
type st_1 from statictext within u_scale
end type
type em_weight from editmask within u_scale
end type
end forward

global type u_scale from UserObject
int Width=2177
int Height=993
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event ue_timer pbm_custom01
cb_ok cb_ok
uo_threshold uo_threshold
cb_cancel cb_cancel
st_steady st_steady
st_1 st_1
em_weight em_weight
end type
global u_scale u_scale

type variables
boolean		i_b_done,&
		i_b_threshold,&
		i_b_threshold_wait,&
		i_b_cancel,&
		i_b_steady,&
		i_b_show_buttons
dec		i_dec_threshold_upper,&
		i_dec_threshold_lower,&
		i_n_weight
string		i_s_round_to_whole_number

end variables

forward prototypes
public function decimal uf_timer ()
public function integer uf_set_values (decimal a_n_amount, boolean a_b_steady)
public function decimal uf_init (window a_w_parent, boolean a_b_show_buttons, decimal a_dec_threshold_upper, decimal a_dec_threshold_lower, boolean a_b_threshold_wait, string a_s_round_to_whole_number, string a_s_serial_type)
end prototypes

public function decimal uf_timer ();string	l_s_data
int		l_i_count

Do While NOT i_b_done
	if i_n_weight <> -9999 then
		if em_weight.Text <> String ( i_n_weight, "#####0.00" ) then
			This.SetRedraw ( FALSE )
			em_weight.Text = String ( i_n_weight, "#####0.00" )
			This.SetRedraw ( TRUE )
		end if
		if i_b_steady then
			if st_steady.Text <> "Steady" then
				This.SetRedraw ( FALSE )
				st_steady.Text = "Steady"
				st_steady.TextColor = f_get_color_value ( "green" )
				IF NOT i_b_threshold THEN &
					cb_ok.Enabled = TRUE
				This.SetRedraw ( TRUE )
			end if
		else
			if st_steady.Text <> "Not Steady" then
				This.SetRedraw ( FALSE )
				st_steady.Text = "Not Steady"
				st_steady.TextColor = f_get_color_value ( "red" )
				cb_ok.Enabled = FALSE
				This.SetRedraw ( TRUE )
			end if
		end if
		if i_b_threshold then
			if uo_threshold.uf_refresh ( i_n_weight ) then
				if i_b_steady then
					if i_b_threshold_wait then
						i_b_done = FALSE
					else
						IF NOT i_b_show_buttons THEN
							i_b_done = TRUE
						ELSE
							cb_ok.Enabled = TRUE
						END IF
					end if
				else
					i_b_done = FALSE
				end if
			else
				i_b_threshold_wait = FALSE
			end if
		else
			if NOT i_b_show_buttons THEN &
				i_b_done = i_b_steady
		end if
	end if
	Yield ( )
	if KeyDown ( keyF8! ) then
		i_b_done 	= TRUE
		i_b_cancel 	= TRUE
	end if
Loop

if i_b_cancel then i_n_weight = -8888

return i_n_weight
end function

public function integer uf_set_values (decimal a_n_amount, boolean a_b_steady);i_n_weight = a_n_amount
i_b_steady = a_b_steady

RETURN 1
end function

public function decimal uf_init (window a_w_parent, boolean a_b_show_buttons, decimal a_dec_threshold_upper, decimal a_dec_threshold_lower, boolean a_b_threshold_wait, string a_s_round_to_whole_number, string a_s_serial_type);dec	l_dec_weight

cb_ok.Visible 		= a_b_show_buttons
cb_cancel.Visible = a_b_show_buttons
	
i_b_threshold_wait			= a_b_threshold_wait
i_s_round_to_whole_number	= a_s_round_to_whole_number
i_b_show_buttons				= a_b_show_buttons
CHOOSE CASE a_s_serial_type
	CASE "Piece Count"
		st_1.Text = "Piece Count"
	CASE "Piece Weight"
		st_1.Text = "Scale Weight"
END CHOOSE

i_b_threshold = ( a_dec_threshold_lower > 0 and a_dec_threshold_upper > 0 )
if i_b_threshold then
	i_dec_threshold_lower = a_dec_threshold_lower 
	i_dec_threshold_upper = a_dec_threshold_upper
	uo_threshold.Show ( )
	uo_threshold.uf_init ( i_dec_threshold_lower, i_dec_threshold_upper )
else
	uo_threshold.Hide ( )
	st_1.x = 238
	em_weight.x = 458
	st_steady.x = 330
end if
i_b_done = FALSE
l_dec_weight = uf_timer ( )

return l_dec_weight
end function

on u_scale.create
this.cb_ok=create cb_ok
this.uo_threshold=create uo_threshold
this.cb_cancel=create cb_cancel
this.st_steady=create st_steady
this.st_1=create st_1
this.em_weight=create em_weight
this.Control[]={ this.cb_ok,&
this.uo_threshold,&
this.cb_cancel,&
this.st_steady,&
this.st_1,&
this.em_weight}
end on

on u_scale.destroy
destroy(this.cb_ok)
destroy(this.uo_threshold)
destroy(this.cb_cancel)
destroy(this.st_steady)
destroy(this.st_1)
destroy(this.em_weight)
end on

type cb_ok from commandbutton within u_scale
int X=458
int Y=769
int Width=545
int Height=193
int TabOrder=40
boolean Enabled=false
string Text="&Ok"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;i_b_cancel 	= FALSE
i_b_done 	= TRUE

end event

type uo_threshold from u_threshold_meter within u_scale
int X=1463
int Y=65
int Width=618
int Height=625
int TabOrder=20
boolean Visible=false
end type

on uo_threshold.destroy
call u_threshold_meter::destroy
end on

type cb_cancel from commandbutton within u_scale
int X=1134
int Y=769
int Width=526
int Height=193
int TabOrder=30
string Text="&Cancel"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_b_done = TRUE
i_b_cancel = TRUE
end on

type st_steady from statictext within u_scale
int X=129
int Y=545
int Width=1221
int Height=193
boolean Enabled=false
string Text="Not Steady"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-28
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_scale
int X=28
int Y=13
int Width=1409
int Height=241
boolean Enabled=false
string Text="Scale Weight"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-36
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_weight from editmask within u_scale
int X=257
int Y=273
int Width=965
int Height=241
int TabOrder=10
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####0.00"
long BackColor=16777215
int TextSize=-36
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


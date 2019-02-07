$PBExportHeader$u_threshold_meter.sru
$PBExportComments$Threshold meter for all versions of scale interface
forward
global type u_threshold_meter from UserObject
end type
type st_2 from statictext within u_threshold_meter
end type
type st_1 from statictext within u_threshold_meter
end type
type st_lower from statictext within u_threshold_meter
end type
type st_upper from statictext within u_threshold_meter
end type
type r_1 from rectangle within u_threshold_meter
end type
type ln_upper from line within u_threshold_meter
end type
type ln_lower from line within u_threshold_meter
end type
type ln_current from line within u_threshold_meter
end type
end forward

global type u_threshold_meter from UserObject
int Width=554
int Height=637
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
st_2 st_2
st_1 st_1
st_lower st_lower
st_upper st_upper
r_1 r_1
ln_upper ln_upper
ln_lower ln_lower
ln_current ln_current
end type
global u_threshold_meter u_threshold_meter

type variables
dec		i_dec_multiplier,&
		i_dec_upper,&
		i_dec_lower,&
		i_dec_previous
end variables

forward prototypes
public function boolean uf_refresh (decimal a_dec_value)
public subroutine uf_setup (decimal a_dec_lower, decimal a_dec_upper)
public subroutine uf_init (decimal a_dec_lower, decimal a_dec_upper)
end prototypes

public function boolean uf_refresh (decimal a_dec_value);if a_dec_value <> i_dec_previous then

	This.SetRedraw ( FALSE )
	
	if a_dec_value < 0 then
		IF ln_current.beginy <> ( r_1.height + r_1.y ) + ln_lower.LineThickness THEN &
			ln_current.beginy = ( r_1.height + r_1.y ) + ln_lower.LineThickness
		IF ln_current.endy <> ln_current.beginy THEN &
			ln_current.endy = ln_current.beginy
	elseif a_dec_value > i_dec_upper then
		IF ln_current.beginy <> ln_upper.beginy - ln_upper.LineThickness THEN &
			ln_current.beginy = ln_upper.beginy - ln_upper.LineThickness
		IF ln_current.endy <> ln_current.beginy THEN &
			ln_current.endy = ln_current.beginy
	else
		IF ln_current.beginy <> ( r_1.height + r_1.y ) - ( a_dec_value * i_dec_multiplier ) THEN &
			ln_current.beginy = ( r_1.height + r_1.y ) - ( a_dec_value * i_dec_multiplier )
		IF ln_current.endy <> ln_current.beginy THEN &
			ln_current.endy = ln_current.beginy
	end if
	
	if a_dec_value >= i_dec_lower and a_dec_value <= i_dec_upper then
		IF ln_current.LineColor <> f_get_color_value ( "green" ) THEN &
			ln_current.LineColor = f_get_color_value ( "green" )
	else
		IF ln_current.LineColor <> f_get_color_value ( "red" ) THEN &
			ln_current.LineColor = f_get_color_value ( "red" )
	end if

	This.SetRedraw ( TRUE )

	i_dec_previous = a_dec_value

end if

if a_dec_value >= i_dec_lower and a_dec_value <= i_dec_upper then
	return TRUE
else
	return FALSE
end if
end function

public subroutine uf_setup (decimal a_dec_lower, decimal a_dec_upper);st_upper.Text = String ( a_dec_upper, "#####0.00" )
st_lower.Text = String ( a_dec_lower, "#####0.00" )

i_dec_upper = a_dec_upper
i_dec_lower = a_dec_lower

i_dec_multiplier = ( r_1.height - ln_upper.LineThickness ) / a_dec_upper

ln_lower.beginy = ( r_1.height + r_1.y ) - ( i_dec_multiplier * a_dec_lower )
ln_lower.endy = ln_lower.beginy
st_lower.y = ln_lower.beginy - ln_lower.LineThickness

end subroutine

public subroutine uf_init (decimal a_dec_lower, decimal a_dec_upper);st_upper.Text = String ( a_dec_upper, "#####0.00" )
st_lower.Text = String ( a_dec_lower, "#####0.00" )

i_dec_upper = a_dec_upper
i_dec_lower = a_dec_lower

i_dec_multiplier = ( r_1.height - ln_upper.LineThickness ) / a_dec_upper

ln_lower.beginy = ( r_1.height + r_1.y ) - ( i_dec_multiplier * a_dec_lower )
ln_lower.endy = ln_lower.beginy
st_lower.y = ln_lower.beginy - ln_lower.LineThickness

end subroutine

on u_threshold_meter.create
this.st_2=create st_2
this.st_1=create st_1
this.st_lower=create st_lower
this.st_upper=create st_upper
this.r_1=create r_1
this.ln_upper=create ln_upper
this.ln_lower=create ln_lower
this.ln_current=create ln_current
this.Control[]={ this.st_2,&
this.st_1,&
this.st_lower,&
this.st_upper,&
this.r_1,&
this.ln_upper,&
this.ln_lower,&
this.ln_current}
end on

on u_threshold_meter.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_lower)
destroy(this.st_upper)
destroy(this.r_1)
destroy(this.ln_upper)
destroy(this.ln_lower)
destroy(this.ln_current)
end on

type st_2 from statictext within u_threshold_meter
int X=19
int Y=17
int Width=485
int Height=73
boolean Enabled=false
string Text="Threshold Meter"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_threshold_meter
int X=293
int Y=561
int Width=220
int Height=65
boolean Enabled=false
string Text="0"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_lower from statictext within u_threshold_meter
int X=293
int Y=321
int Width=220
int Height=65
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_upper from statictext within u_threshold_meter
int X=293
int Y=113
int Width=220
int Height=65
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within u_threshold_meter
int Y=129
int Width=275
int Height=481
boolean Enabled=false
FillPattern FillPattern=diamond!
int LineThickness=5
long FillColor=12632256
end type

type ln_upper from line within u_threshold_meter
boolean Enabled=false
int BeginX=19
int BeginY=145
int EndX=257
int EndY=145
int LineThickness=37
long LineColor=65535
end type

type ln_lower from line within u_threshold_meter
boolean Enabled=false
int BeginX=19
int BeginY=353
int EndX=257
int EndY=353
int LineThickness=37
long LineColor=65535
end type

type ln_current from line within u_threshold_meter
boolean Enabled=false
int BeginX=19
int BeginY=593
int EndX=257
int EndY=593
int LineThickness=37
long LineColor=255
end type


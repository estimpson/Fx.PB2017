$PBExportHeader$u_inactivity_prompt.sru
forward
global type u_inactivity_prompt from UserObject
end type
type st_seconds from statictext within u_inactivity_prompt
end type
type cb_no from commandbutton within u_inactivity_prompt
end type
type cb_yes from commandbutton within u_inactivity_prompt
end type
type st_1 from statictext within u_inactivity_prompt
end type
end forward

global type u_inactivity_prompt from UserObject
int Width=1971
int Height=865
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
st_seconds st_seconds
cb_no cb_no
cb_yes cb_yes
st_1 st_1
end type
global u_inactivity_prompt u_inactivity_prompt

type variables
int		i_i_button
window		i_w_parent
end variables

forward prototypes
public subroutine uf_wait_for_response ()
public function integer uf_init (integer a_i_seconds, window a_w_parent)
end prototypes

public subroutine uf_wait_for_response ();Do While i_i_button = 0
	Yield ( )
Loop
end subroutine

public function integer uf_init (integer a_i_seconds, window a_w_parent);int	l_i_button

i_w_parent = a_w_parent

x = ( i_w_parent.Width - Width ) / 2
y = ( i_w_parent.Height - Height ) / 2

st_seconds.Text = string ( a_i_seconds )
uf_wait_for_response ( )

l_i_button = i_i_button
i_i_button = 0

return l_i_button
end function

on u_inactivity_prompt.create
this.st_seconds=create st_seconds
this.cb_no=create cb_no
this.cb_yes=create cb_yes
this.st_1=create st_1
this.Control[]={ this.st_seconds,&
this.cb_no,&
this.cb_yes,&
this.st_1}
end on

on u_inactivity_prompt.destroy
destroy(this.st_seconds)
destroy(this.cb_no)
destroy(this.cb_yes)
destroy(this.st_1)
end on

type st_seconds from statictext within u_inactivity_prompt
int X=55
int Y=49
int Width=311
int Height=129
boolean Enabled=false
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-22
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_no from commandbutton within u_inactivity_prompt
int X=1043
int Y=609
int Width=421
int Height=225
int TabOrder=20
string Text="&No"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_i_button = 2
end on

type cb_yes from commandbutton within u_inactivity_prompt
int X=458
int Y=609
int Width=421
int Height=225
int TabOrder=10
string Text="&Yes"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_i_button = 1
end on

type st_1 from statictext within u_inactivity_prompt
int X=37
int Y=33
int Width=1884
int Height=561
boolean Enabled=false
string Text="       seconds have elapsed since the last scale activity.  Do you want to cancel the operation?"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-22
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


$PBExportHeader$u_alf_labels.sru
$PBExportComments$Prints piece labels based on package_type qty.
forward
global type u_alf_labels from UserObject
end type
type st_left from statictext within u_alf_labels
end type
type st_2 from statictext within u_alf_labels
end type
type st_1 from statictext within u_alf_labels
end type
end forward

global type u_alf_labels from UserObject
int Width=1971
int Height=565
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
st_left st_left
st_2 st_2
st_1 st_1
end type
global u_alf_labels u_alf_labels

forward prototypes
public subroutine uf_init (window a_w_parent, string a_s_part, string a_s_package_type, long a_l_quantity)
end prototypes

public subroutine uf_init (window a_w_parent, string a_s_part, string a_s_package_type, long a_l_quantity);int		l_i_count

x = ( a_w_parent.Width - Width ) / 2
y = ( a_w_parent.Height - Height ) / 2

for l_i_count = a_l_quantity to 1 step -1
	Yield ( )
	f_print_dummy_label ( a_s_part, a_s_package_type, 1, 0 )
	st_left.Text = String ( l_i_count )
next
end subroutine

on u_alf_labels.create
this.st_left=create st_left
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.st_left,&
this.st_2,&
this.st_1}
end on

on u_alf_labels.destroy
destroy(this.st_left)
destroy(this.st_2)
destroy(this.st_1)
end on

type st_left from statictext within u_alf_labels
int X=311
int Y=289
int Width=604
int Height=241
boolean Enabled=false
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-36
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_alf_labels
int X=951
int Y=289
int Width=513
int Height=241
boolean Enabled=false
string Text="Left"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-36
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_alf_labels
int X=37
int Y=33
int Width=1866
int Height=241
boolean Enabled=false
string Text="Printing Labels"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-36
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


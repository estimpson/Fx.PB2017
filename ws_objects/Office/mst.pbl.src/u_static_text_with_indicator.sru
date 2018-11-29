$PBExportHeader$u_static_text_with_indicator.sru
$PBExportComments$(mst) This is used in the shopfloor calendar. It has a COPY-FROM/TO flag.
forward
global type u_static_text_with_indicator from UserObject
end type
type st_indicator from statictext within u_static_text_with_indicator
end type
type st_text from statictext within u_static_text_with_indicator
end type
end forward

global type u_static_text_with_indicator from UserObject
int Width=476
int Height=93
long BackColor=12632256
event ue_initialize pbm_custom01
st_indicator st_indicator
st_text st_text
end type
global u_static_text_with_indicator u_static_text_with_indicator

type variables
long	il_origpos

integer	ii_indicator_ptr 	= 1

string	is_copy_from	= '3'
string	is_copy_to	= '4'

end variables

forward prototypes
public subroutine uf_set_width (integer ai_width)
end prototypes

on ue_initialize;st_indicator.text =''
end on

public subroutine uf_set_width (integer ai_width);st_text.width	= ai_width
st_indicator.x	= st_text.x + st_text.width + 5
end subroutine

on u_static_text_with_indicator.create
this.st_indicator=create st_indicator
this.st_text=create st_text
this.Control[]={ this.st_indicator,&
this.st_text}
end on

on u_static_text_with_indicator.destroy
destroy(this.st_indicator)
destroy(this.st_text)
end on

on constructor;this.triggerevent( 'ue_initialize' )
end on

type st_indicator from statictext within u_static_text_with_indicator
int X=385
int Width=110
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_text from statictext within u_static_text_with_indicator
int Width=403
int Height=65
string Text="none"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;if st_indicator.text	= is_copy_from then
	st_indicator.text	= is_copy_to
else
	if st_indicator.text = is_copy_to then
		st_indicator.text	= ''
	else 
		if st_indicator.text = '' then
			st_indicator.text	= is_copy_from
		end if
	end if
end if

st_indicator.visible	= (st_indicator.text <> '' )
end on


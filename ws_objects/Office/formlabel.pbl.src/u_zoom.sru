$PBExportHeader$u_zoom.sru
forward
global type u_zoom from u_base_custom
end type
type st_zoom from statictext within u_zoom
end type
type sle_zoom from singlelineedit within u_zoom
end type
type cb_plus from commandbutton within u_zoom
end type
type cb_minus from commandbutton within u_zoom
end type
end forward

global type u_zoom from u_base_custom
int Width=521
int Height=116
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
string Tag="zoom control"
st_zoom st_zoom
sle_zoom sle_zoom
cb_plus cb_plus
cb_minus cb_minus
end type
global u_zoom u_zoom

on u_zoom.create
int iCurrent
call super::create
this.st_zoom=create st_zoom
this.sle_zoom=create sle_zoom
this.cb_plus=create cb_plus
this.cb_minus=create cb_minus
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_zoom
this.Control[iCurrent+2]=this.sle_zoom
this.Control[iCurrent+3]=this.cb_plus
this.Control[iCurrent+4]=this.cb_minus
end on

on u_zoom.destroy
call super::destroy
destroy(this.st_zoom)
destroy(this.sle_zoom)
destroy(this.cb_plus)
destroy(this.cb_minus)
end on

type st_zoom from statictext within u_zoom
int Y=24
int Width=160
int Height=72
boolean Enabled=false
string Text="Zoom"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_zoom from singlelineedit within u_zoom
event modified pbm_enmodified
int X=187
int Y=4
int Width=274
int Height=112
int TabOrder=10
boolean Enabled=false
string Tag="Manual zoom entry"
BorderStyle BorderStyle=StyleLowered!
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;INTEGER	l_i_zoom

IF LeftA ( text, 1 ) = 'F' THEN
	l_i_zoom = -50
	text = 'FULL'
ELSEIF LeftA ( text, 1 ) = 'O' THEN
	l_i_zoom = 0
	text = 'ORIG'
ELSE
	l_i_zoom = Integer ( text )
	IF l_i_zoom < 0 THEN
		l_i_zoom = -50
		text = 'FULL'
	ELSEIF l_i_zoom = 0 THEN
		text = 'ORIG'
	ELSE
		text = String ( l_i_zoom )
	END IF
END IF
i_w_parent.TRIGGER DYNAMIC EVENT ue_preview_zoom ( l_i_zoom )
end event

type cb_plus from commandbutton within u_zoom
event clicked pbm_bnclicked
int X=466
int Width=59
int Height=60
int TabOrder=20
boolean Enabled=false
string Tag="Zoom In"
string Text="+"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CHOOSE CASE sle_zoom.text
	CASE 'FULL'
		sle_zoom.text = 'ORIG'
	CASE 'ORIG'
		sle_zoom.text = '50'
	CASE ELSE
		sle_zoom.text = String ( Integer ( sle_zoom.text ) + 50 )
END CHOOSE
sle_zoom.PostEvent ( modified! )
end event

type cb_minus from commandbutton within u_zoom
event clicked pbm_bnclicked
int X=466
int Y=60
int Width=59
int Height=60
int TabOrder=2
boolean Enabled=false
string Tag="Zoom out"
string Text="-"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CHOOSE CASE Integer ( sle_zoom.text )
	CASE 0
		sle_zoom.text = 'FULL'
	CASE IS <= 50
		sle_zoom.text = 'ORIG'
	CASE ELSE
		sle_zoom.text = String ( Integer ( sle_zoom.text ) - 50 )
END CHOOSE
sle_zoom.PostEvent ( modified! )
end event


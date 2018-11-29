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
string tag = "zoom control"
integer width = 521
integer height = 116
boolean border = false
long backcolor = 79741120
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
integer y = 24
integer width = 160
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Zoom"
boolean focusrectangle = false
end type

type sle_zoom from singlelineedit within u_zoom
event modified pbm_enmodified
string tag = "Manual zoom entry"
integer x = 187
integer y = 4
integer width = 274
integer height = 112
integer taborder = 10
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event modified;INTEGER	l_i_zoom

IF Left ( text, 1 ) = 'F' THEN
	l_i_zoom = -50
	text = 'FULL'
ELSEIF left ( text, 1 ) = 'O' THEN
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
string tag = "Zoom In"
integer x = 466
integer width = 59
integer height = 60
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "+"
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
string tag = "Zoom out"
integer x = 466
integer y = 60
integer width = 59
integer height = 60
integer taborder = 2
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "-"
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


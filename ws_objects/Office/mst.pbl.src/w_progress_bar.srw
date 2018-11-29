$PBExportHeader$w_progress_bar.srw
$PBExportComments$statusbar for the grids.
forward
global type w_progress_bar from window
end type
type cb_1 from commandbutton within w_progress_bar
end type
type st_11 from statictext within w_progress_bar
end type
type st_10 from statictext within w_progress_bar
end type
type st_9 from statictext within w_progress_bar
end type
type st_8 from statictext within w_progress_bar
end type
type st_7 from statictext within w_progress_bar
end type
type st_6 from statictext within w_progress_bar
end type
type st_5 from statictext within w_progress_bar
end type
type st_4 from statictext within w_progress_bar
end type
type st_3 from statictext within w_progress_bar
end type
type st_2 from statictext within w_progress_bar
end type
type st_1 from statictext within w_progress_bar
end type
type st_back from statictext within w_progress_bar
end type
end forward

global type w_progress_bar from window
integer x = 832
integer y = 356
integer width = 933
integer height = 512
boolean titlebar = true
string title = "Task Status"
windowtype windowtype = popup!
long backcolor = 12632256
cb_1 cb_1
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_back st_back
end type
global w_progress_bar w_progress_bar

type variables
Private:

integer	ii_Bars
end variables

forward prototypes
public function integer wf_setstatus (string a_s_statustext, integer a_i_percent)
end prototypes

public function integer wf_setstatus (string a_s_statustext, integer a_i_percent);INTEGER	li_Bars

if st_11.Text <> a_s_statustext then
	st_11.Text = a_s_statustext
end if

li_Bars = .999 + a_i_percent / 10
if ii_Bars <> li_Bars then
	ii_Bars = li_Bars
else
	return 1
end if

CHOOSE CASE ii_Bars
	CASE 1
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF st_2.Visible THEN st_2.Hide ( )
		IF st_3.Visible THEN st_3.Hide ( )
		IF st_4.Visible THEN st_4.Hide ( )
		IF st_5.Visible THEN st_5.Hide ( )
		IF st_6.Visible THEN st_6.Hide ( )
		IF st_7.Visible THEN st_7.Hide ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 2
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF st_3.Visible THEN st_3.Hide ( )
		IF st_4.Visible THEN st_4.Hide ( )
		IF st_5.Visible THEN st_5.Hide ( )
		IF st_6.Visible THEN st_6.Hide ( )
		IF st_7.Visible THEN st_7.Hide ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 3
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF st_4.Visible THEN st_4.Hide ( )
		IF st_5.Visible THEN st_5.Hide ( )
		IF st_6.Visible THEN st_6.Hide ( )
		IF st_7.Visible THEN st_7.Hide ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 4
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF st_5.Visible THEN st_5.Hide ( )
		IF st_6.Visible THEN st_6.Hide ( )
		IF st_7.Visible THEN st_7.Hide ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 5
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF NOT st_5.Visible THEN st_5.Show ( )
		IF st_6.Visible THEN st_6.Hide ( )
		IF st_7.Visible THEN st_7.Hide ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 6
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF NOT st_5.Visible THEN st_5.Show ( )
		IF NOT st_6.Visible THEN st_6.Show ( )
		IF st_7.Visible THEN st_7.Hide ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 7
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF NOT st_5.Visible THEN st_5.Show ( )
		IF NOT st_6.Visible THEN st_6.Show ( )
		IF NOT st_7.Visible THEN st_7.Show ( )
		IF st_8.Visible THEN st_8.Hide ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 8
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF NOT st_5.Visible THEN st_5.Show ( )
		IF NOT st_6.Visible THEN st_6.Show ( )
		IF NOT st_7.Visible THEN st_7.Show ( )
		IF NOT st_8.Visible THEN st_8.Show ( )
		IF st_9.Visible THEN st_9.Hide ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 9
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF NOT st_5.Visible THEN st_5.Show ( )
		IF NOT st_6.Visible THEN st_6.Show ( )
		IF NOT st_7.Visible THEN st_7.Show ( )
		IF NOT st_8.Visible THEN st_8.Show ( )
		IF NOT st_9.Visible THEN st_9.Show ( )
		IF st_10.Visible THEN st_10.Hide ( )

	CASE 10
		IF NOT st_1.Visible THEN st_1.Show ( )
		IF NOT st_2.Visible THEN st_2.Show ( )
		IF NOT st_3.Visible THEN st_3.Show ( )
		IF NOT st_4.Visible THEN st_4.Show ( )
		IF NOT st_5.Visible THEN st_5.Show ( )
		IF NOT st_6.Visible THEN st_6.Show ( )
		IF NOT st_7.Visible THEN st_7.Show ( )
		IF NOT st_8.Visible THEN st_8.Show ( )
		IF NOT st_9.Visible THEN st_9.Show ( )
		IF NOT st_10.Visible THEN st_10.Show ( )

END CHOOSE

RETURN 1
end function

on open;str_statusbar	l_str_parm
Window			l_w_parent

l_w_parent = ParentWindow ( )
l_str_parm = Message.PowerObjectParm

IF ISVALID ( l_w_parent ) THEN 
	X = ( l_w_parent.Width / 2 ) - ( Width / 2 )
	Y = ( l_w_parent.Height / 2 ) - ( Height / 2 )
END IF

Title 			= l_str_parm.title
IF l_str_parm.enable_cancel THEN
	cb_1.Visible = TRUE
ELSE
	cb_1.Visible = FALSE
	Height = 393
END IF

end on

on w_progress_bar.create
this.cb_1=create cb_1
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_back=create st_back
this.Control[]={this.cb_1,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_back}
end on

on w_progress_bar.destroy
destroy(this.cb_1)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_back)
end on

type cb_1 from commandbutton within w_progress_bar
integer x = 311
integer y = 288
integer width = 256
integer height = 108
integer taborder = 1
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

on clicked;bcancel = TRUE
end on

type st_11 from statictext within w_progress_bar
integer x = 91
integer y = 16
integer width = 731
integer height = 144
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_10 from statictext within w_progress_bar
boolean visible = false
integer x = 750
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_progress_bar
boolean visible = false
integer x = 677
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within w_progress_bar
boolean visible = false
integer x = 603
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_progress_bar
boolean visible = false
integer x = 530
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_progress_bar
boolean visible = false
integer x = 457
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_progress_bar
boolean visible = false
integer x = 384
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_progress_bar
boolean visible = false
integer x = 311
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_progress_bar
boolean visible = false
integer x = 238
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_progress_bar
boolean visible = false
integer x = 165
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_progress_bar
boolean visible = false
integer x = 91
integer y = 176
integer width = 73
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 8388608
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_back from statictext within w_progress_bar
integer x = 91
integer y = 176
integer width = 731
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type


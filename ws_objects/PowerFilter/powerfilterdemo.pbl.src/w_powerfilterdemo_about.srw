$PBExportHeader$w_powerfilterdemo_about.srw
$PBExportComments$Generated SDI About Box
forward
global type w_powerfilterdemo_about from window
end type
type st_2 from statictext within w_powerfilterdemo_about
end type
type st_builddate from statictext within w_powerfilterdemo_about
end type
type st_copyright2 from statictext within w_powerfilterdemo_about
end type
type st_copyright1 from statictext within w_powerfilterdemo_about
end type
type st_author from statictext within w_powerfilterdemo_about
end type
type st_version from statictext within w_powerfilterdemo_about
end type
type st_1 from statictext within w_powerfilterdemo_about
end type
type cb_ok from commandbutton within w_powerfilterdemo_about
end type
end forward

global type w_powerfilterdemo_about from window
integer x = 873
integer y = 428
integer width = 1184
integer height = 912
boolean titlebar = true
string title = "About"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79416533
boolean center = true
st_2 st_2
st_builddate st_builddate
st_copyright2 st_copyright2
st_copyright1 st_copyright1
st_author st_author
st_version st_version
st_1 st_1
cb_ok cb_ok
end type
global w_powerfilterdemo_about w_powerfilterdemo_about

on w_powerfilterdemo_about.create
this.st_2=create st_2
this.st_builddate=create st_builddate
this.st_copyright2=create st_copyright2
this.st_copyright1=create st_copyright1
this.st_author=create st_author
this.st_version=create st_version
this.st_1=create st_1
this.cb_ok=create cb_ok
this.Control[]={this.st_2,&
this.st_builddate,&
this.st_copyright2,&
this.st_copyright1,&
this.st_author,&
this.st_version,&
this.st_1,&
this.cb_ok}
end on

on w_powerfilterdemo_about.destroy
destroy(this.st_2)
destroy(this.st_builddate)
destroy(this.st_copyright2)
destroy(this.st_copyright1)
destroy(this.st_author)
destroy(this.st_version)
destroy(this.st_1)
destroy(this.cb_ok)
end on

event open;st_version.text = st_version.text + string(gul_build)
st_builddate.text = 'Built on ' + string(gd_build) + ' at ' + string(gtm_build)
end event

type st_2 from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 28
integer width = 1061
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "PowerFilter"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_builddate from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 280
integer width = 1061
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "Built on..."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_copyright2 from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 580
integer width = 1061
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "All Rights Reserved"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_copyright1 from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 504
integer width = 1061
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "Copyright © 2010 James R. Reese"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_author from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 384
integer width = 1061
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "By Jim Reese"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 204
integer width = 1061
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "Version 1.0.0."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_powerfilterdemo_about
integer x = 41
integer y = 128
integer width = 1061
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79416533
string text = "Datawindow Filter Service demo"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_powerfilterdemo_about
integer x = 407
integer y = 704
integer width = 334
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;//*-----------------------------------------------------------------*/
//*    clicked:  Close "About" Window
//*-----------------------------------------------------------------*/
Close ( Parent )
end event


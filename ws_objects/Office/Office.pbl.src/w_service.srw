$PBExportHeader$w_service.srw
forward
global type w_service from w_child
end type
type st_1 from statictext within w_service
end type
end forward

global type w_service from w_child
boolean visible = false
integer x = 214
integer y = 221
integer width = 2459
integer height = 1388
boolean enabled = false
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
boolean ib_isupdateable = false
st_1 st_1
end type
global w_service w_service

on w_service.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_service.destroy
call super::destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_service
integer width = 1970
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use as ancestor to non-visual service windows (like labels, ole hosts, etc.)."
boolean focusrectangle = false
end type


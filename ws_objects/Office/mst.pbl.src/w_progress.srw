$PBExportHeader$w_progress.srw
forward
global type w_progress from window
end type
type dw_progress from datawindow within w_progress
end type
type st_name from statictext within w_progress
end type
type cb_cancel from commandbutton within w_progress
end type
end forward

global type w_progress from window
integer x = 846
integer y = 696
integer width = 1221
integer height = 520
boolean titlebar = true
string title = "Progress"
boolean maxbox = true
long backcolor = 67108864
dw_progress dw_progress
st_name st_name
cb_cancel cb_cancel
end type
global w_progress w_progress

type variables
int ii_bar_width
string is_cancel_event
window iw_cancel_window, &
             i_w_parent
Boolean bCancel
Boolean bHideCancelButton = FALSE
end variables

forward prototypes
public subroutine wf_progress (real pct, string txt)
end prototypes

public subroutine wf_progress (real pct, string txt);integer resp
if pct > 1 then return // if more than 100% then do not display
dw_progress.setredraw(false)
dw_progress.object.pct[1] = String(pct, "0.00%")
dw_progress.object.pct.width = string(int(pct * ii_bar_width))
dw_progress.setredraw(true)
// display the message
st_name.text = txt

end subroutine

event open;bCancel = False

str_progress parm
string tmp,command, bar_x,bar_y
// get the parameters
parm = message.powerobjectparm
iw_cancel_window = parm.cancel_window
is_cancel_event = parm.cancel_event
this.title = parm.title
// set up the window
dw_progress.insertrow(0)
ii_bar_width = integer(dw_progress.object.pct_rectangle.width)

end event

on w_progress.create
this.dw_progress=create dw_progress
this.st_name=create st_name
this.cb_cancel=create cb_cancel
this.Control[]={this.dw_progress,&
this.st_name,&
this.cb_cancel}
end on

on w_progress.destroy
destroy(this.dw_progress)
destroy(this.st_name)
destroy(this.cb_cancel)
end on

type dw_progress from datawindow within w_progress
integer x = 110
integer width = 1024
integer height = 96
integer taborder = 10
boolean enabled = false
string dataobject = "d_progress"
boolean border = false
end type

type st_name from statictext within w_progress
integer x = 110
integer y = 128
integer width = 983
integer height = 152
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_progress
boolean visible = false
integer x = 489
integer y = 300
integer width = 256
integer height = 108
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;//iw_cancel_window.triggerevent(is_cancel_event)
//close(parent)
bCancel = True

end event


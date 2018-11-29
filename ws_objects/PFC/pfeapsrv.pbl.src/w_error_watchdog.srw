$PBExportHeader$w_error_watchdog.srw
$PBExportComments$(PFD)
forward
global type w_error_watchdog from w_response
end type
type cb_1 from commandbutton within w_error_watchdog
end type
type cb_copy from commandbutton within w_error_watchdog
end type
type dw_watchdog from datawindow within w_error_watchdog
end type
type cb_save from commandbutton within w_error_watchdog
end type
type p_1 from picture within w_error_watchdog
end type
type cb_print from commandbutton within w_error_watchdog
end type
type cb_halt from commandbutton within w_error_watchdog
end type
type cb_continue from commandbutton within w_error_watchdog
end type
end forward

global type w_error_watchdog from w_response
int x=361
int y=260
int width=2235
int height=1576
boolean titlebar=true
string title="runtime issue"
long backcolor=78682240
cb_1 cb_1
cb_copy cb_copy
dw_watchdog dw_watchdog
cb_save cb_save
p_1 p_1
cb_print cb_print
cb_halt cb_halt
cb_continue cb_continue
end type
global w_error_watchdog w_error_watchdog

type variables

end variables

event open;
rollback using sqlca ;
dw_watchdog.object.errormessage [ 1 ] = error.text
dw_watchdog.object.window [ 1 ] = error.windowmenu
dw_watchdog.object.object [ 1 ] = error.object
dw_watchdog.object.eventname [ 1 ] = error.objectevent
dw_watchdog.object.line [ 1 ] = string ( error.line )
end event

on w_error_watchdog.create
int icurrent
call super::create
this.cb_1=create cb_1
this.cb_copy=create cb_copy
this.dw_watchdog=create dw_watchdog
this.cb_save=create cb_save
this.p_1=create p_1
this.cb_print=create cb_print
this.cb_halt=create cb_halt
this.cb_continue=create cb_continue
icurrent=upperbound(this.control)
this.control[icurrent+1]=this.cb_1
this.control[icurrent+2]=this.cb_copy
this.control[icurrent+3]=this.dw_watchdog
this.control[icurrent+4]=this.cb_save
this.control[icurrent+5]=this.p_1
this.control[icurrent+6]=this.cb_print
this.control[icurrent+7]=this.cb_halt
this.control[icurrent+8]=this.cb_continue
end on

on w_error_watchdog.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_copy)
destroy(this.dw_watchdog)
destroy(this.cb_save)
destroy(this.p_1)
destroy(this.cb_print)
destroy(this.cb_halt)
destroy(this.cb_continue)
end on

type cb_1 from commandbutton within w_error_watchdog
int x=78
int y=1344
int width=407
int height=88
int taborder=30
string text="copy &html"
int textsize=-8
int weight=400
string facename="ms sans serif"
fontcharset fontcharset=ansi!
fontfamily fontfamily=swiss!
fontpitch fontpitch=variable!
end type

event clicked;
clipboard ( dw_watchdog.object.datawindow.data.htmltable )
end event

type cb_copy from commandbutton within w_error_watchdog
int x=78
int y=1248
int width=407
int height=88
int taborder=30
string text="copy &data"
int textsize=-8
int weight=400
string facename="ms sans serif"
fontcharset fontcharset=ansi!
fontfamily fontfamily=swiss!
fontpitch fontpitch=variable!
end type

event clicked;
clipboard ( dw_watchdog.object.datawindow.data )
end event

type dw_watchdog from datawindow within w_error_watchdog
int x=315
int y=24
int width=1865
int height=1248
int taborder=10
string dataobject="d_watchdog"
boolean border=false
boolean livescroll=true
end type

type cb_save from commandbutton within w_error_watchdog
int x=494
int y=1292
int width=407
int height=88
int taborder=20
string text="&save"
int textsize=-8
int weight=400
string facename="ms sans serif"
fontcharset fontcharset=ansi!
fontfamily fontfamily=swiss!
fontpitch fontpitch=variable!
end type

event clicked;
dw_watchdog.saveas ( )
end event

type p_1 from picture within w_error_watchdog
int x=41
int y=44
int width=174
int height=152
string picturename="quest.bmp"
boolean border=true
borderstyle borderstyle=styleraised!
boolean focusrectangle=false
boolean originalsize=true
end type

type cb_print from commandbutton within w_error_watchdog
int x=1742
int y=1292
int width=407
int height=88
int taborder=60
string text="&print"
int textsize=-8
int weight=400
string facename="ms sans serif"
fontcharset fontcharset=ansi!
fontfamily fontfamily=swiss!
fontpitch fontpitch=variable!
end type

event clicked;
dw_watchdog.print ( )
end event

type cb_halt from commandbutton within w_error_watchdog
int x=1326
int y=1292
int width=407
int height=88
int taborder=50
string text="hal&t"
boolean cancel=true
int textsize=-8
int weight=400
string facename="ms sans serif"
fontcharset fontcharset=ansi!
fontfamily fontfamily=swiss!
fontpitch fontpitch=variable!
end type

event clicked;
halt
end event

type cb_continue from commandbutton within w_error_watchdog
int x=910
int y=1292
int width=407
int height=88
int taborder=40
string text="&continue"
boolean default=true
int textsize=-8
int weight=400
string facename="ms sans serif"
fontcharset fontcharset=ansi!
fontfamily fontfamily=swiss!
fontpitch fontpitch=variable!
end type

event clicked;close ( parent )
end event


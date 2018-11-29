$PBExportHeader$w_error_watch_dog.srw
forward
global type w_error_watch_dog from Window
end type
type cb_1 from commandbutton within w_error_watch_dog
end type
type cb_copy from commandbutton within w_error_watch_dog
end type
type dw_watchdog from datawindow within w_error_watch_dog
end type
type cb_save from commandbutton within w_error_watch_dog
end type
type p_1 from picture within w_error_watch_dog
end type
type cb_print from commandbutton within w_error_watch_dog
end type
type cb_halt from commandbutton within w_error_watch_dog
end type
type cb_continue from commandbutton within w_error_watch_dog
end type
end forward

global type w_error_watch_dog from Window
int X=361
int Y=260
int Width=2235
int Height=1576
boolean TitleBar=true
string Title="Runtime Issue"
long BackColor=78682240
WindowType WindowType=response!
cb_1 cb_1
cb_copy cb_copy
dw_watchdog dw_watchdog
cb_save cb_save
p_1 p_1
cb_print cb_print
cb_halt cb_halt
cb_continue cb_continue
end type
global w_error_watch_dog w_error_watch_dog

type variables

end variables

event open;Rollback using SQLCA ;
dw_watchdog.object.errormessage [ 1 ] = error.text
dw_watchdog.object.window [ 1 ] = error.windowmenu
dw_watchdog.object.object [ 1 ] = error.object
dw_watchdog.object.eventname [ 1 ] = error.ObjectEvent
dw_watchdog.object.line [ 1 ] = String ( error.line )
end event

on w_error_watch_dog.create
this.cb_1=create cb_1
this.cb_copy=create cb_copy
this.dw_watchdog=create dw_watchdog
this.cb_save=create cb_save
this.p_1=create p_1
this.cb_print=create cb_print
this.cb_halt=create cb_halt
this.cb_continue=create cb_continue
this.Control[]={this.cb_1,&
this.cb_copy,&
this.dw_watchdog,&
this.cb_save,&
this.p_1,&
this.cb_print,&
this.cb_halt,&
this.cb_continue}
end on

on w_error_watch_dog.destroy
destroy(this.cb_1)
destroy(this.cb_copy)
destroy(this.dw_watchdog)
destroy(this.cb_save)
destroy(this.p_1)
destroy(this.cb_print)
destroy(this.cb_halt)
destroy(this.cb_continue)
end on

type cb_1 from commandbutton within w_error_watch_dog
int X=78
int Y=1344
int Width=407
int Height=88
int TabOrder=30
string Text="Copy &HTML"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_copy from commandbutton within w_error_watch_dog
int X=78
int Y=1248
int Width=407
int Height=88
int TabOrder=30
string Text="Copy &Data"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Clipboard ( dw_watchdog.object.datawindow.data )
end event

type dw_watchdog from datawindow within w_error_watch_dog
int X=315
int Y=24
int Width=1865
int Height=1248
int TabOrder=10
string DataObject="d_watchdog"
boolean Border=false
boolean LiveScroll=true
end type

type cb_save from commandbutton within w_error_watch_dog
int X=494
int Y=1292
int Width=407
int Height=88
int TabOrder=20
string Text="&Save"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_watchdog.SaveAs ( )
end event

type p_1 from picture within w_error_watch_dog
int X=14
int Y=16
int Width=219
int Height=248
string PictureName="d:\think tank\edi\incoming raw\huh.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type cb_print from commandbutton within w_error_watch_dog
int X=1742
int Y=1292
int Width=407
int Height=88
int TabOrder=60
string Text="&Print"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_watchdog.Print ( )
end event

type cb_halt from commandbutton within w_error_watch_dog
int X=1326
int Y=1292
int Width=407
int Height=88
int TabOrder=50
string Text="Hal&t"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Halt
end event

type cb_continue from commandbutton within w_error_watch_dog
int X=910
int Y=1292
int Width=407
int Height=88
int TabOrder=40
string Text="&Continue"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close ( Parent )
end event


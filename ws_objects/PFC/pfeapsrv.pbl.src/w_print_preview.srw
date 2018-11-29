$PBExportHeader$w_print_preview.srw
forward
global type w_print_preview from w_response
end type
type uo_zoom from u_zoom within w_print_preview
end type
type st_title from statictext within w_print_preview
end type
type cb_print from commandbutton within w_print_preview
end type
type cb_next from commandbutton within w_print_preview
end type
type dw_report from u_dw within w_print_preview
end type
type cb_prev from commandbutton within w_print_preview
end type
type cb_close from commandbutton within w_print_preview
end type
end forward

global type w_print_preview from w_response
int X=114
int Y=300
WindowState WindowState=maximized!
uo_zoom uo_zoom
st_title st_title
cb_print cb_print
cb_next cb_next
dw_report dw_report
cb_prev cb_prev
cb_close cb_close
end type
global w_print_preview w_print_preview

type variables

Public:
constant integer	PRINT = 1
constant integer	PRINTCANCEL = 0
end variables

on w_print_preview.create
int iCurrent
call super::create
this.uo_zoom=create uo_zoom
this.st_title=create st_title
this.cb_print=create cb_print
this.cb_next=create cb_next
this.dw_report=create dw_report
this.cb_prev=create cb_prev
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_zoom
this.Control[iCurrent+2]=this.st_title
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_next
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.cb_prev
this.Control[iCurrent+7]=this.cb_close
end on

on w_print_preview.destroy
call super::destroy
destroy(this.uo_zoom)
destroy(this.st_title)
destroy(this.cb_print)
destroy(this.cb_next)
destroy(this.dw_report)
destroy(this.cb_prev)
destroy(this.cb_close)
end on

event open;call super::open;
//	Declarations
DataStore	lds_Report

//	Initialie Report from parameter.
lds_Report = Message.PowerObjectParm

//	Display Report.
dw_report.Create ( lds_Report.object.DataWindow.Syntax )
lds_Report.ShareData ( dw_report )
dw_report.of_SetPrintPreview ( true )
if dw_report.Describe ( "datawindow.print.preview" ) = "no" then
	dw_report.event pfc_printpreview ( )
end if

//	Turn on desired services.
of_SetResize ( true )

//	Register controls for resizing
inv_Resize.of_Register ( uo_zoom, inv_Resize.FIXEDBOTTOM )
inv_Resize.of_Register ( dw_report, inv_Resize.SCALERIGHTBOTTOM )
inv_Resize.of_Register ( st_title, inv_Resize.SCALERIGHT )

end event

type uo_zoom from u_zoom within w_print_preview
int X=23
int Y=1260
int TabOrder=10
string Tag="zoom control"
end type

on uo_zoom.destroy
call u_zoom::destroy
end on

type st_title from statictext within w_print_preview
int X=23
int Y=136
int Width=2427
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Title"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_print from commandbutton within w_print_preview
int X=27
int Y=28
int Width=306
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="&Print"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Close.
CloseWithReturn ( parent, PRINT )
end event

type cb_next from commandbutton within w_print_preview
int X=361
int Y=28
int Width=306
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="&Next Page"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_report from u_dw within w_print_preview
int X=23
int Y=220
int Width=2427
int Height=1016
int TabOrder=20
boolean HScrollBar=true
end type

type cb_prev from commandbutton within w_print_preview
int X=695
int Y=28
int Width=306
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="Pre&v Page"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_print_preview
int X=1029
int Y=28
int Width=306
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="&Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Close.
CloseWithReturn ( parent, PRINTCANCEL )
end event


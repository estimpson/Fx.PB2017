$PBExportHeader$w_report_list.srw
forward
global type w_report_list from Window
end type
type cb_delete_row from commandbutton within w_report_list
end type
type cb_cancel from commandbutton within w_report_list
end type
type cb_ok from commandbutton within w_report_list
end type
type dw_report_list from datawindow within w_report_list
end type
type gb_1 from groupbox within w_report_list
end type
end forward

global type w_report_list from Window
int X=1326
int Y=672
int Width=2386
int Height=1568
boolean TitleBar=true
string Title="Report List Maintenance"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
cb_delete_row cb_delete_row
cb_cancel cb_cancel
cb_ok cb_ok
dw_report_list dw_report_list
gb_1 gb_1
end type
global w_report_list w_report_list

type variables
boolean	ib_newrow = false
end variables

on w_report_list.create
this.cb_delete_row=create cb_delete_row
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_report_list=create dw_report_list
this.gb_1=create gb_1
this.Control[]={this.cb_delete_row,&
this.cb_cancel,&
this.cb_ok,&
this.dw_report_list,&
this.gb_1}
end on

on w_report_list.destroy
destroy(this.cb_delete_row)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_report_list)
destroy(this.gb_1)
end on

type cb_delete_row from commandbutton within w_report_list
int X=2062
int Y=292
int Width=247
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Delete"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	ll_CurrentRow

ll_CurrentRow = dw_report_list.GetRow ( )

if dw_report_list.object.report_usage [ ll_CurrentRow ] > 0 then
	MessageBox ( monsys.msg_title, "Unable to remove report type because there are reports in the report library using this type.", StopSign! )
else
	dw_report_list.DeleteRow ( ll_CurrentRow )
end if
end event

type cb_cancel from commandbutton within w_report_list
int X=2062
int Y=120
int Width=247
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( parent, -1 )
end event

type cb_ok from commandbutton within w_report_list
int X=2062
int Y=28
int Width=247
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations

//	Accept text entries
dw_report_list.AcceptText ( )

//	Get data for validation checks.

//	In order for validation checks to work properly,
//	default data must not have nulls for checked fields.
//	Validate data.

//	Update data and commit.
if dw_report_list.Update ( ) = 1 then
	SQLCA.uf_commit ( )
else
	SQLCA.uf_rollback ( )
end if

CloseWithReturn ( parent, 1 )
end event

type dw_report_list from datawindow within w_report_list
event keydown pbm_dwnkey
int X=37
int Y=64
int Width=1989
int Height=1344
int TabOrder=10
string DataObject="d_report_list_entry"
boolean Border=false
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event keydown;//	Declarations.
long	ll_row
long	ll_rows
long	ll_column

//	Information about current position.
ll_row = getrow ( )
ll_rows = rowcount ( )
ll_column = getcolumn ( )

//	If tab key pressed and on last column of last line, insert and scroll to new row.
ib_newrow = ( key = KeyTab! and keyflags = 0 and ll_row = ll_rows and ll_column = 2 )
if ib_newrow then
	ScrollToRow ( InsertRow ( 0 ) )
end if
end event

event constructor;SetTransObject ( SQLCA )
Retrieve ( )
SetRow ( InsertRow ( 0 ) )
ScrollToRow ( RowCount ( ) )
SetColumn ( 1 )
end event

event losefocus;//	Prevent focus change for new row.
if ib_newrow then
	SetFocus ( )
	SetRow ( RowCount ( ) )
	SetColumn ( 1 )
end if
ib_newrow = false
end event

type gb_1 from groupbox within w_report_list
int X=27
int Y=4
int Width=2007
int Height=1412
string Text="Report List"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


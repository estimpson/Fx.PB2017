$PBExportHeader$w_external_datasource.srw
forward
global type w_external_datasource from Window
end type
type cb_dwname from commandbutton within w_external_datasource
end type
type cb_library from commandbutton within w_external_datasource
end type
type sle_dwname from singlelineedit within w_external_datasource
end type
type sle_library from singlelineedit within w_external_datasource
end type
type st_2 from statictext within w_external_datasource
end type
type st_1 from statictext within w_external_datasource
end type
type cb_delete_row from commandbutton within w_external_datasource
end type
type cb_cancel from commandbutton within w_external_datasource
end type
type cb_ok from commandbutton within w_external_datasource
end type
type dw_datasource from datawindow within w_external_datasource
end type
type gb_2 from groupbox within w_external_datasource
end type
type gb_1 from groupbox within w_external_datasource
end type
end forward

global type w_external_datasource from Window
int X=1326
int Y=672
int Width=2386
int Height=1568
boolean TitleBar=true
string Title="Report List Maintenance"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
cb_dwname cb_dwname
cb_library cb_library
sle_dwname sle_dwname
sle_library sle_library
st_2 st_2
st_1 st_1
cb_delete_row cb_delete_row
cb_cancel cb_cancel
cb_ok cb_ok
dw_datasource dw_datasource
gb_2 gb_2
gb_1 gb_1
end type
global w_external_datasource w_external_datasource

type variables
boolean	ib_newrow = false
end variables

on w_external_datasource.create
this.cb_dwname=create cb_dwname
this.cb_library=create cb_library
this.sle_dwname=create sle_dwname
this.sle_library=create sle_library
this.st_2=create st_2
this.st_1=create st_1
this.cb_delete_row=create cb_delete_row
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_datasource=create dw_datasource
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_dwname,&
this.cb_library,&
this.sle_dwname,&
this.sle_library,&
this.st_2,&
this.st_1,&
this.cb_delete_row,&
this.cb_cancel,&
this.cb_ok,&
this.dw_datasource,&
this.gb_2,&
this.gb_1}
end on

on w_external_datasource.destroy
destroy(this.cb_dwname)
destroy(this.cb_library)
destroy(this.sle_dwname)
destroy(this.sle_library)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_delete_row)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_datasource)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_dwname from commandbutton within w_external_datasource
int X=1486
int Y=1296
int Width=247
int Height=84
int TabOrder=70
string Text="Browse..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	ls_Object
string	ls_Value
		 
st_generic_structure lst_Parm

lst_Parm.value1 = sle_library.Text
lst_Parm.value2 = 'dat'
openwithparm ( w_select_object, lst_Parm )
ls_Value = message.stringparm
sle_dwname.Text = ls_Value
sle_dwname.trigger event modified ( )
end event

type cb_library from commandbutton within w_external_datasource
int X=1486
int Y=1200
int Width=247
int Height=84
int TabOrder=60
string Text="Browse..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	ls_DocName
string	ls_Named

integer	li_Value

li_Value = GetFileOpenName ( "Select PowerBuilder Library", ls_DocName, ls_Named, "PBL", "PowerBuilder Library file (*.PBL),*.PBL" )
sle_library.Text = ls_DocName
sle_library.trigger event modified ( )
end event

type sle_dwname from singlelineedit within w_external_datasource
int X=768
int Y=1304
int Width=663
int Height=68
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long	ll_CurrentRow

ll_CurrentRow = dw_datasource.GetRow ( )

if ll_CurrentRow > 0 then
	dw_datasource.object.dw_name [ ll_CurrentRow ] = text
end if
end event

type sle_library from singlelineedit within w_external_datasource
int X=768
int Y=1208
int Width=663
int Height=68
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long	ll_CurrentRow

ll_CurrentRow = dw_datasource.GetRow ( )

if ll_CurrentRow > 0 then
	dw_datasource.object.library_name [ ll_CurrentRow ] = text
end if


end event

type st_2 from statictext within w_external_datasource
int X=261
int Y=1304
int Width=448
int Height=68
boolean Enabled=false
string Text="DataWindow Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
long BorderColor=3680296
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_external_datasource
int X=261
int Y=1208
int Width=448
int Height=68
boolean Enabled=false
string Text="Library Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
long BorderColor=3680296
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_delete_row from commandbutton within w_external_datasource
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

ll_CurrentRow = dw_datasource.GetRow ( )

if dw_datasource.object.report_usage [ ll_CurrentRow ] > 0 then
	MessageBox ( monsys.msg_title, "Unable to remove Data Source because there are reports in the report library using this data source.", StopSign! )
else
	dw_datasource.DeleteRow ( ll_CurrentRow )
end if
end event

type cb_cancel from commandbutton within w_external_datasource
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

type cb_ok from commandbutton within w_external_datasource
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
dw_datasource.AcceptText ( )

//	Get data for validation checks.

//	In order for validation checks to work properly,
//	default data must not have nulls for checked fields.
//	Validate data.

//	Update data and commit.
if dw_datasource.Update ( ) = 1 then
	SQLCA.uf_commit ( )
else
	SQLCA.uf_rollback ( )
end if

CloseWithReturn ( parent, 1 )
end event

type dw_datasource from datawindow within w_external_datasource
event keydown pbm_dwnkey
int X=37
int Y=64
int Width=1989
int Height=1056
int TabOrder=10
string DataObject="d_external_datasource_entry"
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
ib_newrow = ( key = KeyTab! and keyflags = 0 and ll_row = ll_rows and ll_column = 4 )
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

event rowfocuschanged;if currentrow > 0 then
	sle_library.text = object.library_name [ currentrow ]
	sle_dwname.text = object.dw_name [ currentrow ]
end if
end event

type gb_2 from groupbox within w_external_datasource
int X=27
int Y=1136
int Width=2007
int Height=280
int TabOrder=50
string Text="Data Source Properties"
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

type gb_1 from groupbox within w_external_datasource
int X=27
int Y=4
int Width=2007
int Height=1124
string Text="Data Source List"
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


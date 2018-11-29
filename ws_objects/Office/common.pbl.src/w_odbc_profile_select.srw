$PBExportHeader$w_odbc_profile_select.srw
forward
global type w_odbc_profile_select from Window
end type
type dw_1 from datawindow within w_odbc_profile_select
end type
type cb_3 from commandbutton within w_odbc_profile_select
end type
type cb_2 from commandbutton within w_odbc_profile_select
end type
type cb_1 from commandbutton within w_odbc_profile_select
end type
end forward

global type w_odbc_profile_select from Window
int X=1056
int Y=484
int Width=1609
int Height=1356
boolean TitleBar=true
string Title="Please select ODBC Profile to connect to:"
long BackColor=77897888
WindowType WindowType=response!
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_odbc_profile_select w_odbc_profile_select

on w_odbc_profile_select.create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_odbc_profile_select.destroy
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;f_center_window ( This )
end event

type dw_1 from datawindow within w_odbc_profile_select
int X=18
int Y=16
int Width=1536
int Height=1104
int TabOrder=10
string DataObject="d_datasource_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;//	declare local variables
string	ls_subkeylist[]
string	ls_keyvalue

integer	li_rtn
integer	li_count
integer	li_upperbound
integer	li_incrementor=0

// get odbc profiles into an array from the registry
li_rtn = RegistryValues ( "HKEY_CURRENT_USER\Software\ODBC\ODBC.INI\ODBC Data Sources", ls_subkeylist )

// if no errors continue, user dsns
IF li_rtn <> -1 THEN
	// loop through array and add items to self
	li_upperbound = UpperBound ( ls_subkeylist )
	for li_count = 1 to li_upperbound
		InsertRow ( li_count )
		SetItem ( li_count, 1, ls_subkeylist [ li_count ] )
		RegistryGet ( "HKEY_CURRENT_USER\Software\ODBC\ODBC.INI\ODBC Data Sources", ls_subkeylist [ li_count ], RegString!, ls_keyvalue )
		SetItem ( li_count, 2, ls_keyvalue )
	next
	
END IF

li_incrementor = isnull(upperbound ( ls_subkeylist ),0)

// get odbc profiles into an array from the registry
li_rtn = RegistryValues ( "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources", ls_subkeylist )

// if no errors continue, user dsns
IF li_rtn <> -1 THEN
	// loop through array and add items to self
	li_upperbound = UpperBound ( ls_subkeylist )
	for li_count = 1 to li_upperbound
		InsertRow ( li_count + li_incrementor )
		SetItem ( li_count+ li_incrementor, 1, ls_subkeylist [ li_count ] )
		RegistryGet ( "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources", ls_subkeylist [ li_count ], RegString!, ls_keyvalue )
		SetItem ( li_count+ li_incrementor, 2, ls_keyvalue )
	next
	
END IF

Sort ( )
Filter ( )
end event

event clicked;selectrow ( 0, FALSE )

if row > 0 then
	selectrow ( row, TRUE )
end if
end event

event doubleclicked;selectrow ( 0, FALSE )

if row > 0 then
	selectrow ( row, TRUE )
	cb_1.TriggerEvent ( "clicked" )
end if
end event

type cb_3 from commandbutton within w_odbc_profile_select
int X=603
int Y=1136
int Width=274
int Height=112
int TabOrder=40
boolean Visible=false
boolean Enabled=false
string Text="&New"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_odbc_profile_select
int X=311
int Y=1136
int Width=274
int Height=112
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, '' )
end event

type cb_1 from commandbutton within w_odbc_profile_select
int X=18
int Y=1136
int Width=274
int Height=112
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	ls_profile = ''

if dw_1.GetRow ( ) > 0 then
	if dw_1.IsSelected ( dw_1.GetRow ( ) ) then
		ls_profile = dw_1.GetItemString ( dw_1.GetRow ( ), 1 )
	end if
end if

CloseWithReturn ( Parent, ls_profile )
end event


$PBExportHeader$w_popup_list_ancestor.srw
forward
global type w_popup_list_ancestor from Window
end type
type dw_2 from datawindow within w_popup_list_ancestor
end type
type rb_2 from radiobutton within w_popup_list_ancestor
end type
type rb_1 from radiobutton within w_popup_list_ancestor
end type
type cb_1 from commandbutton within w_popup_list_ancestor
end type
type cbx_1 from checkbox within w_popup_list_ancestor
end type
type sle_1 from singlelineedit within w_popup_list_ancestor
end type
type dw_1 from datawindow within w_popup_list_ancestor
end type
type gb_1 from groupbox within w_popup_list_ancestor
end type
end forward

global type w_popup_list_ancestor from Window
int X=1074
int Y=484
int Width=2331
int Height=1632
boolean TitleBar=true
long BackColor=79741120
WindowType WindowType=popup!
event ue_open ( )
dw_2 dw_2
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
cbx_1 cbx_1
sle_1 sle_1
dw_1 dw_1
gb_1 gb_1
end type
global w_popup_list_ancestor w_popup_list_ancestor

type variables
STRING		i_s_data_column,&
		i_s_column,&
		i_s_syntax,&
		is_filter,&
		is_searchstring
end variables

forward prototypes
public function integer wf_retrieve (string as_filter, string as_searchstring)
end prototypes

event ue_open;i_s_syntax = dw_1.object.DataWindow.Table.Select
i_s_data_column = dw_1.Describe ( "#1.Name" )
i_s_column = i_s_data_column

end event

public function integer wf_retrieve (string as_filter, string as_searchstring);STRING	ls_where_clause,&
			ls_first_half,&
			ls_second_half,&
			ls_dummy,&
			ls_syntax
INT		li_pos
LONG		ll_count,&
			ll_row,&
			ll_rowcount

IF as_searchstring > '' AND as_filter > '' THEN
	ls_where_clause = " WHERE " + as_searchstring + " AND " + as_filter
ELSEIF as_searchstring > '' THEN
	ls_where_clause = " WHERE " + as_searchstring
ELSEIF as_filter > '' THEN
	ls_where_clause = " WHERE " + as_filter
ELSE
	ls_where_clause = ''
END IF

IF ls_where_clause > '' THEN
	li_pos = PosA ( i_s_syntax, "ORDER BY" )
		
	If li_pos > 0 Then
		ls_first_half = LeftA ( i_s_syntax, li_pos - 1 )
		ls_second_half = RightA ( i_s_syntax, LenA ( i_s_syntax ) - li_pos + 2 )
		ls_syntax = ls_first_half + ls_where_clause + ls_second_half
	Else
		ls_syntax = i_s_syntax + " WHERE " + ls_where_clause
	End if
ELSE
	ls_syntax = i_s_syntax
END IF

ls_dummy = ""

For ll_count = 1 to LenA ( ls_syntax )
	If MidA ( ls_syntax, ll_count, 1 ) <> "~~" Then
		ls_dummy += MidA ( ls_syntax, ll_count, 1 )
	End if
Next
	
dw_1.SetSQLSelect ( ls_dummy )
dw_1.Retrieve ( )

return 1
end function

on w_popup_list_ancestor.create
this.dw_2=create dw_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_2,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.cbx_1,&
this.sle_1,&
this.dw_1,&
this.gb_1}
end on

on w_popup_list_ancestor.destroy
destroy(this.dw_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;PostEvent ( "ue_open" )
end event

type dw_2 from datawindow within w_popup_list_ancestor
event ue_constructor ( )
int X=55
int Y=128
int Width=2194
int Height=432
int TabOrder=20
boolean Enabled=false
string DataObject="d_popup_filter"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_constructor;// Populate column list from datawindow columns
INT					li_columns,&
						li_count
STRING				ls_column,&
						ls_text
LONG					ll_newrow
DataWindowChild	ldwc_items

GetChild ( "column_name", ldwc_items )

li_columns = Integer ( dw_1.object.datawindow.column.count )

FOR li_count = 1 to li_columns
	ls_column = dw_1.Describe ( "#" + String ( li_count ) + ".name" )
	ls_text = dw_1.Describe ( ls_column + "_t.Text" )
	ll_newrow = ldwc_items.InsertRow ( 0 )
	ldwc_items.SetItem ( ll_newrow, "column_display", ls_text )
	ldwc_items.SetItem ( ll_newrow, "column_name", ls_column )
NEXT

InsertRow ( 0 )
end event

event constructor;Post Event ue_constructor ( )
end event

event losefocus;String				ls_FirstHalf, &
						ls_SecondHalf, &
						ls_Column, &
						ls_Operator, &
						ls_Value, &
						ls_Logical, &
						ls_DataType, &
						ls_Char
Int					li_Pos, &
						li_RtnCode, &
						li_Count,&
						l_i_columntypes
Long					ll_Count,&
						ll_rowcount
String				ls_Dummy
DataWindowChild	ldwc_items

AcceptText ( )

GetChild ( "column_name", ldwc_items )

ll_rowcount = RowCount ( )

is_filter = ''

For li_Count = 1 to ll_rowcount

	ls_Column 	= GetItemString ( li_Count, "column_name" )
	ls_Operator	= GetItemString ( li_Count, "operator" )
	ls_Value		= GetItemString ( li_Count, "value" )
	ls_Logical	= GetItemString ( li_Count, "logical" )
	ls_datatype	= dw_1.Describe ( ls_column + ".ColType" )
	
	is_filter = is_filter + ls_Column + " " + ls_Operator
	If ls_Operator = "like" Then ls_Value = "%" + ls_Value + "%"

	If LeftA ( ls_DataType, 4 ) = "char" Or LeftA ( ls_DataType, 4 ) = "varc" Then
		is_filter = is_filter + " ~'" + ls_Value + "~'"
	Elseif ls_DataType = "date" Then
		If Not IsDate ( ls_Value ) Then
			MessageBox ( "Error", "The date you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
			Return
		End if
		is_filter = is_filter + " ~'" + ls_Value + "~'"
	Elseif ls_DataType = "time" Then
		If Not IsTime ( ls_Value ) Then
			MessageBox ( "Error", "The time you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
			Return
		End if
		is_filter += " ~'" + ls_Value + "~'"
	Else
		is_filter += " " + ls_Value
	End if
	If li_Count < ll_rowcount Then
		is_filter = is_filter + " " + ls_Logical + " "
	End if
Next


end event

event itemchanged;String	ls_Column, &
			ls_Logical, &
			ls_Dummy, &
			ls_Temp, &
			ls_DataType, &
			ls_ColumnName
Int		li_Count, &
			li_Row
Dec		ld_Temp
DateTime ldt_Date
Long		ll_Temp

ls_Column 	= GetColumnName ( )
li_Row		= GetRow ( )

Choose Case ls_Column
	Case "logical"
		ls_Logical = GetText ( )
		If ( ls_Logical = "And" Or ls_Logical = "Or" ) And li_Row = RowCount ( ) Then
			InsertRow ( 0 )
			SetColumn ( "column_name" )
			SetRow ( RowCount ( ) )
			SetFocus ( )
		Elseif ls_Logical = " " Then
			For li_Count = RowCount ( ) to li_Row + 1 Step -1
				If li_Count > 1 Then &
					DeleteRow ( li_Count )
			Next
		End if
End Choose

 ls_dummy = ""

end event

type rb_2 from radiobutton within w_popup_list_ancestor
int X=37
int Y=592
int Width=261
int Height=76
string Text="No Filter "
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_filter = ''
dw_2.Enabled = FALSE

wf_retrieve ( is_filter, is_searchstring )
end event

type rb_1 from radiobutton within w_popup_list_ancestor
int X=37
int Y=48
int Width=288
int Height=76
string Text="Use Filter "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.Enabled = TRUE
end event

type cb_1 from commandbutton within w_popup_list_ancestor
int X=311
int Y=1424
int Width=407
int Height=96
string Text="Display Records"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_searchstring = ''
wf_retrieve ( is_filter, is_searchstring )
end event

type cbx_1 from checkbox within w_popup_list_ancestor
int X=18
int Y=1424
int Width=256
int Height=96
string Text="Search"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sle_1.Post Event ue_retrieve_dw ( )
sle_1.SetFocus ( )
end event

type sle_1 from singlelineedit within w_popup_list_ancestor
event key pbm_keydown
event ue_retrieve_dw ( )
int X=768
int Y=1424
int Width=1518
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event key;IF cbx_1.Checked THEN
	INT	li_count
	
	FOR li_count = 1 to 1000
		Yield ( )
	NEXT
	
	Post Event ue_retrieve_dw ( )
END IF
end event

event ue_retrieve_dw;is_searchstring = i_s_column + " like ~'%" + Text + "%~'"

wf_retrieve ( is_filter, is_searchstring )

end event

type dw_1 from datawindow within w_popup_list_ancestor
event type string ue_get_data ( )
int X=18
int Y=704
int Width=2267
int Height=704
string DragIcon="not.ico"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event ue_get_data;Return GetItemString ( GetRow ( ), i_s_data_column )
end event

event clicked;IF row > 0 THEN
	SelectRow ( 0, FALSE )
	SelectRow ( row, TRUE )
	Drag ( Begin! )
	i_s_column = dwo.name
ELSE
	i_s_column = LeftA ( dwo.name, LenA ( String ( dwo.name ) ) - 2 )
END IF


end event

event constructor;SetTransObject ( sqlca )
end event

type gb_1 from groupbox within w_popup_list_ancestor
int X=18
int Width=2267
int Height=688
int TabOrder=30
string Text="Filter Options"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


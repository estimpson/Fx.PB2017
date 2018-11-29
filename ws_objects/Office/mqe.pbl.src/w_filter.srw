$PBExportHeader$w_filter.srw
forward
global type w_filter from Window
end type
type cb_4 from commandbutton within w_filter
end type
type cb_3 from commandbutton within w_filter
end type
type cbx_1 from checkbox within w_filter
end type
type cb_2 from commandbutton within w_filter
end type
type cb_1 from commandbutton within w_filter
end type
type dw_filter from datawindow within w_filter
end type
end forward

global type w_filter from Window
int X=695
int Y=576
int Width=2258
int Height=1244
boolean TitleBar=true
string Title="Filter"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_4 cb_4
cb_3 cb_3
cbx_1 cbx_1
cb_2 cb_2
cb_1 cb_1
dw_filter dw_filter
end type
global w_filter w_filter

type variables
Window		iw_ParentWindow
DataWindow	idw_FilterDW
DataWindowChild	idwc_Columns, &
		idwc_Data
String		is_SQLSyntax
boolean		i_b_filter
end variables

forward prototypes
public subroutine wf_populate_columns ()
public subroutine wf_filter ()
end prototypes

public subroutine wf_populate_columns ();Int		li_ColumnCount, &
			li_Count, &
			li_FROMPos, &
			li_PeriodPos = 1, &
			li_CommaPos = 1
String	ls_Column, &
			ls_Syntax, &
			ls_Dummy
Boolean	lb_Done

ls_Syntax = idw_FilterDW.Describe ( "datawindow.table.select" )

li_FROMPos = PosA ( ls_Syntax, "FROM" )

Do
	li_PeriodPos 	= PosA ( ls_Syntax, ".", li_CommaPos )
	li_CommaPos		= PosA ( ls_Syntax, ",", li_PeriodPos )
	If li_CommaPos < 1 Or li_PeriodPos < 1 Or li_CommaPos > li_FROMPos Or li_PeriodPos > li_FROMPos Then
		lb_Done = True
	Else
		ls_Column = Trim ( MidA ( ls_Syntax, li_PeriodPos + 1, li_CommaPos - li_PeriodPos - 1 ) )
		ls_Dummy = ""
		For li_Count = 1 to LenA ( ls_Column )
			If MidA ( ls_Column, li_Count, 1 ) <> "~~" And MidA ( ls_Column, li_Count, 1 ) <> "~"" Then &
				ls_Dummy = ls_Dummy + MidA ( ls_Column, li_Count, 1 )
		Next
		ls_Column = ls_Dummy
		idwc_Columns.InsertRow ( 0 )
		idwc_Columns.SetItem ( idwc_Columns.RowCount ( ), "data", ls_Column )
	End if
Loop While Not lb_Done


end subroutine

public subroutine wf_filter ();String	ls_WhereClause, &
			ls_FirstHalf, &
			ls_SecondHalf, &
			ls_Column, &
			ls_Operator, &
			ls_Value, &
			ls_Logical, &
			ls_DataType, &
			ls_Char
Int		li_Pos, &
			li_RtnCode, &
			li_Count
Long		ll_Count
String	ls_Dummy

If f_get_string_value ( szReturnedString ) = "" Then &
	szReturnedString = idw_FilterDW.Describe ( "datawindow.table.select" )

is_SQLSyntax 		= szReturnedString

idw_FilterDW.SetTransObject ( sqlca )

dw_filter.AcceptText ( )

ls_WhereClause = " WHERE "

For li_Count = 1 to dw_filter.RowCount ( )
	ls_Column 	= dw_filter.GetItemString ( li_Count, "column_name" )
	ls_Operator	= dw_filter.GetItemString ( li_Count, "operator" )
	ls_Value		= dw_filter.GetItemString ( li_Count, "value" )
	ls_Logical	= dw_filter.GetItemString ( li_Count, "logical" )
	ls_DataType	= idw_FilterDW.Describe ( ls_Column + ".ColType" )
	ls_WhereClause = ls_WhereClause + ls_Column + " " + ls_Operator
	If ls_Operator = "like" Then ls_Value = "%" + ls_Value + "%"

	If LeftA ( ls_DataType, 4 ) = "char" Or LeftA ( ls_DataType, 4 ) = "varc" Then
		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'"
	Elseif ls_DataType = "date" Then
		If Not IsDate ( ls_Value ) Then
			MessageBox ( "Error", "The date you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
			Return
		End if
		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'"
//	Elseif ls_DataType = "datetime" Then
//		If Not IsDate ( ls_Value ) Then
//			MessageBox ( "Error", "The date you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
//			Return
//		Elseif Not IsTime
//		End if
//		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'"
	Elseif ls_DataType = "time" Then
		If Not IsTime ( ls_Value ) Then
			MessageBox ( "Error", "The time you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
			Return
		End if
		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'"
//	Elseif ls_DataType = "timestamp" Then
//		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'"
	Else
		ls_WhereClause = ls_WhereClause + " " + ls_Value
	End if
	If li_Count < dw_filter.RowCount ( ) Then
		ls_WhereClause = ls_WhereClause + " " + ls_Logical + " "
	End if
Next

li_Pos = PosA ( is_SQLSyntax, "ORDER BY" )
If li_Pos > 0 Then
	ls_FirstHalf = LeftA ( is_SQLSyntax, li_Pos - 1 )
	ls_SecondHalf = RightA ( is_SQLSyntax, LenA ( is_SQLSyntax ) - li_Pos + 2 )
	is_SQLSyntax = ls_FirstHalf + ls_WhereClause + ls_SecondHalf
Else
	is_SQLSyntax = is_SQLSyntax + ls_WhereClause
End if

ls_Dummy = ""

For ll_Count = 1 to LenA ( is_SQLSyntax )
	If MidA ( is_SQLSyntax, ll_Count, 1 ) <> "~~" Then
		ls_Dummy = ls_Dummy + MidA ( is_SQLSyntax, ll_Count, 1 )
	End if
Next


li_RtnCode = idw_FilterDW.SetSQLSelect ( ls_Dummy )

idw_FilterDW.SetTransObject ( sqlca )
i_b_filter = TRUE
//idw_FilterDW.Retrieve ( )
end subroutine

on open;Int			li_Count
String		ls_Char, &
				ls_Dummy
str_filter	lstr_Filter

lstr_Filter = Message.PowerObjectParm

iw_ParentWindow 	= lstr_Filter.ParentWindow
idw_FilterDW		= lstr_Filter.FilterDW

dw_filter.InsertRow ( 1 )
wf_populate_columns ( )
end on

on w_filter.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cbx_1=create cbx_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_filter=create dw_filter
this.Control[]={this.cb_4,&
this.cb_3,&
this.cbx_1,&
this.cb_2,&
this.cb_1,&
this.dw_filter}
end on

on w_filter.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cbx_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_filter)
end on

type cb_4 from commandbutton within w_filter
int X=823
int Y=1008
int Width=434
int Height=112
int TabOrder=31
string Text="&Retrieve All"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_parentwindow.PostEvent ( "ue_reset" )
Close ( Parent )
end event

type cb_3 from commandbutton within w_filter
int X=1134
int Y=640
int Width=585
int Height=112
int TabOrder=40
boolean Visible=false
string Text="&Reset Filter"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;idw_FilterDW.SetSQLSelect ( szReturnedString )
iw_ParentWindow.TriggerEvent ( "ue_return_from_filter" )
Close ( Parent )
end on

type cbx_1 from checkbox within w_filter
int X=37
int Y=656
int Width=357
int Height=72
boolean Visible=false
string Text="Live Data"
boolean Checked=true
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_filter
int X=1390
int Y=1008
int Width=274
int Height=112
int TabOrder=30
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type cb_1 from commandbutton within w_filter
int X=425
int Y=1008
int Width=274
int Height=112
int TabOrder=20
string Text="&Filter"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_filter ( )
if i_b_filter then
	iw_parentwindow.PostEvent ( "ue_refresh" )
	Close ( Parent )
end if
end event

type dw_filter from datawindow within w_filter
int X=37
int Y=16
int Width=2176
int Height=960
int TabOrder=10
string DataObject="d_external_filter"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemchanged;String	ls_Column, &
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
	Case "column_name"
		ls_ColumnName = GetText ( )
		idwc_Data.Reset ( )
		If cbx_1.Checked Then
			Choose Case ls_ColumnName
				Case "issue_number"
					 DECLARE issue_number CURSOR FOR  
					  SELECT DISTINCT issues.issue_number  
					    FROM issues  
					ORDER BY issues.issue_number ASC  ;
					Open issue_number;
					Do
						Fetch issue_number Into :ll_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", String ( ll_Temp ) )
						End if
					Loop While SQLCA.SQLCode = 0
					Close issue_number ;
				Case "status"
					 DECLARE status CURSOR FOR  
					  SELECT DISTINCT issues.status  
					    FROM issues  
					ORDER BY issues.status ASC  ;
					Open status ;
					Do
						Fetch status Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close status ;
				Case "solution"
					 DECLARE solution CURSOR FOR  
					  SELECT DISTINCT issues.solution  
					    FROM issues  
					ORDER BY issues.solution ASC  ;
					Open solution ;
					Do
						Fetch solution Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close solution ;
				Case "start_date"
					 DECLARE start_date CURSOR FOR  
					  SELECT DISTINCT issues.start_date  
					    FROM issues  
					ORDER BY issues.start_date ASC  ;
					Open start_date ;
					Do
						Fetch start_date Into :ldt_Date ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", String ( ldt_Date, "yyyy/mm/dd hh:mm:ss" ) )
						End if
					Loop While SQLCA.SQLCode = 0
					Close start_date ;
				Case "stop_date"
					 DECLARE stop_date CURSOR FOR  
					  SELECT DISTINCT issues.stop_date  
					    FROM issues  
					ORDER BY issues.stop_date ASC  ;
					Open stop_date ;
					Do
						Fetch stop_date Into :ldt_Date ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", String ( ldt_Date, "yyyy/mm/dd hh:mm:ss" ) )
						End if
					Loop While SQLCA.SQLCode = 0
					Close stop_date ;
				Case "category"
					 DECLARE category CURSOR FOR  
					  SELECT DISTINCT issues.category  
					    FROM issues  
					ORDER BY issues.category ASC  ;
					Open category ;
					Do
						Fetch category Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close category ;
				Case "sub_category"
					 DECLARE sub_category CURSOR FOR  
					  SELECT DISTINCT issues.sub_category  
					    FROM issues  
					ORDER BY issues.sub_category ASC  ;
					Open sub_category ;
					Do
						Fetch sub_category Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close sub_category ;
				Case "priority"
					 DECLARE priority CURSOR FOR  
					  SELECT DISTINCT issues.priority_level  
					    FROM issues  
					ORDER BY issues.priority_level ASC  ;
					Open priority ;
					Do
						Fetch priority Into :ll_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", String ( ll_Temp ) )
						End if
					Loop While SQLCA.SQLCode = 0
					Close priority ;
				Case "product_line"
					 DECLARE product_line CURSOR FOR  
					  SELECT DISTINCT issues.product_line  
					    FROM issues  
					ORDER BY issues.product_line ASC  ;
					Open product_line ;
					Do
						Fetch product_line Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close product_line ;
				Case "product_code"
					 DECLARE product_code CURSOR FOR  
					  SELECT DISTINCT issues.product_code  
					    FROM issues  
					ORDER BY issues.product_code ASC  ;
					Open product_code ;
					Do
						Fetch product_code Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close product_code ;
				Case "origin_type"
					 DECLARE origin_type CURSOR FOR  
					  SELECT DISTINCT issues.origin_type  
					    FROM issues  
					ORDER BY issues.origin_type ASC  ;
					Open origin_type ;
					Do
						Fetch origin_type Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close origin_type ;
				Case "origin"
					 DECLARE origin CURSOR FOR  
					  SELECT DISTINCT issues.origin  
					    FROM issues  
					ORDER BY issues.origin ASC  ;
					Open origin ;
					Do
						Fetch origin Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close origin ;
				Case "reference"
					 DECLARE reference CURSOR FOR  
					  SELECT DISTINCT issues.doc_reference  
					    FROM issues  
					ORDER BY issues.doc_reference ASC  ;
					Open reference ;
					Do
						Fetch reference Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close reference ;
				Case "assigned_to"
					 DECLARE assigned_to CURSOR FOR  
					  SELECT DISTINCT issues.assigned_to  
					    FROM issues  
					ORDER BY issues.assigned_to ASC  ;
					Open assigned_to ;
					Do
						Fetch assigned_to Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close assigned_to ;
				Case "authorized_by"
					 DECLARE authorized_by CURSOR FOR  
					  SELECT DISTINCT issues.authorized_by  
					    FROM issues  
					ORDER BY issues.authorized_by ASC  ;
					Open authorized_by ;
					Do
						Fetch authorized_by Into :ls_Temp ;
						If SQLCA.SQLCode = 0 Then
							idwc_Data.InsertRow ( 0 )
							idwc_Data.SetItem ( idwc_Data.RowCount ( ), "data", ls_Temp )
						End if
					Loop While SQLCA.SQLCode = 0
					Close authorized_by ;
			End Choose
		End if
		SetItem ( li_Row, "operator", "=" )
		SetColumn ( "value" )
		SetFocus ( )
End Choose

ls_Dummy = ""
end on

on constructor;GetChild ( "column_name", idwc_Columns )
GetChild ( "value", idwc_Data )
end on


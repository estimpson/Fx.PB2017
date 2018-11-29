$PBExportHeader$w_search_shipping_dock.srw
$PBExportComments$window to search for shippers in shipping dock.
forward
global type w_search_shipping_dock from Window
end type
type cb_2 from commandbutton within w_search_shipping_dock
end type
type cb_1 from commandbutton within w_search_shipping_dock
end type
type dw_filter from datawindow within w_search_shipping_dock
end type
end forward

type str_columns from structure
	string		s_column_name
	string		s_data_type
end type

global type w_search_shipping_dock from Window
int X=695
int Y=576
int Width=2478
int Height=1244
boolean TitleBar=true
string Title="Search "
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_filter dw_filter
end type
global w_search_shipping_dock w_search_shipping_dock

type variables
str_columns	i_str_columns[]
end variables

forward prototypes
public function string wf_build_where_clause ()
public subroutine wf_populate_columns ()
public subroutine wf_populate_columntypes (string a_s_tables[])
end prototypes

public function string wf_build_where_clause ();String	ls_WhereClause, &
			ls_FirstHalf, &
			ls_SecondHalf, &
			ls_Column, &
			ls_Operator, &
			ls_Value, &
			ls_Logical, &
			ls_DataType, &
			ls_Char,&
			ls_left,&
			ls_right
Int		li_Pos, &
			li_RtnCode, &
			li_Count,&
			l_i_columntypes
Long		ll_Count
String	ls_Dummy

dw_filter.AcceptText ( )

For li_Count = 1 to dw_filter.RowCount ( )

	ls_left		= f_get_string_value ( dw_filter.GetItemString ( li_count, "left_parenthesis" ) )
	ls_Column 	= dw_filter.GetItemString ( li_Count, "column_name" )
	ls_Operator	= dw_filter.GetItemString ( li_Count, "operator" )
	ls_Value		= dw_filter.GetItemString ( li_Count, "value" )
	ls_right		= f_get_string_value ( dw_filter.GetItemString ( li_count, "right_parenthesis" ) )
	ls_Logical	= dw_filter.GetItemString ( li_Count, "logical" )
	For l_i_columntypes = 1 to UpperBound ( i_str_columns )
		if i_str_columns[l_i_columntypes].s_column_name = ls_column then
			ls_DataType	= i_str_columns[l_i_columntypes].s_data_type
			l_i_columntypes = Upperbound ( i_str_columns )
		end if
	Next
	ls_WhereClause = ls_WhereClause + ls_left + ls_Column + " " + ls_Operator
	If ls_Operator = "like" Then ls_Value = "%" + ls_Value + "%"
	If LeftA ( ls_DataType, 4 ) = "char" Or LeftA ( ls_DataType, 4 ) = "varc" Then
		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'" + ls_right
	Elseif ls_DataType = "date" Then
		If Not IsDate ( ls_Value ) Then
			MessageBox ( "Error", "The date you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
			Return ''
		End if
		ls_WhereClause = ls_WhereClause + "date (" + " ~'" + ls_Value + "~'" + ")" + ls_right
	Elseif ls_DataType = "time" Then
		If Not IsTime ( ls_Value ) Then
			MessageBox ( "Error", "The time you entered for column:" + ls_Column + " is invalid!  Please enter a valid one.", StopSign! )
			Return ''
		End if
		ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'" + ls_right
	Else
		ls_WhereClause = ls_WhereClause + " " + ls_Value + ls_right
	End if
	If li_Count < dw_filter.RowCount ( ) Then
		ls_WhereClause = ls_WhereClause + " " + ls_Logical + " "
	End if
Next

return ls_whereclause
end function

public subroutine wf_populate_columns ();STRING	ls_column_list, &
				ls_object, &
				ls_column [ ]

IF IsValid ( w_list_of_active_shippers.dw_shipping_dock ) THEN
	ls_column_list = w_list_of_active_shippers.dw_shipping_dock.object.datawindow.objects
	
	INTEGER	li_next_tab_pos, &
					li_column_count
	
	li_next_tab_pos = PosA ( ls_column_list, '~t' )
	
	DO
		ls_object = LeftA ( ls_column_list, li_next_tab_pos - 1 )
		ls_column_list = RightA ( ls_column_list, LenA ( ls_column_list ) - li_next_tab_pos )

		IF w_list_of_active_shippers.dw_shipping_dock.Describe ( ls_object + ".Type" ) = "column" THEN
			li_column_count ++
			ls_column [ li_column_count ] = ls_object
		END IF
		li_next_tab_pos = PosA ( ls_column_list, '~t' )
	LOOP UNTIL li_next_tab_pos = 0
	ls_object = ls_column_list
	IF w_list_of_active_shippers.dw_shipping_dock.Describe ( ls_object + ".Type" ) = "column" THEN
		li_column_count ++
		ls_column [ li_column_count ] = ls_object
	END IF

	DataWindowChild	l_dwc_columns
	INTEGER	li_count
	
	dw_filter.GetChild ( "column_name", l_dwc_columns )
	FOR li_count = 1 TO li_column_count
		l_dwc_columns.InsertRow ( 0 )
		l_dwc_columns.SetItem ( li_count, "data", ls_column [ li_count ] ) 
	NEXT
END IF
end subroutine

public subroutine wf_populate_columntypes (string a_s_tables[]);//////////////////////////////////////////////////////////////////////////////////////////
//
//	Fn. to populate the columns & data types into an array of structure
//	Receives an array of table name(s) as argument
//	
//////////////////////////////////////////////////////////////////////////////////////////

string				l_s_column,&
						l_s_datatype,&
						l_s_table
int					l_i_count,&
						l_i_upper
datawindowchild	l_dwc_columns
long					l_l_tableid

Choose Case g_s_platform
	Case "Sybase SQL Anywhere"
		For l_i_count = 1 to upperbound ( a_s_tables )
			l_s_table = a_s_tables[l_i_count]
			
			DECLARE sqlany_columns CURSOR FOR 
				SELECT	cname,   
							coltype  
				FROM 		syscolumns
				WHERE 	tname = :l_s_table;
				
			Open sqlany_columns ;
			Fetch sqlany_columns into :l_s_column, :l_s_datatype ;
			Do While sqlca.sqlcode = 0
				if UpperBound ( a_s_tables ) > 1 then
					l_i_upper = UpperBound ( i_str_columns ) + 1
					i_str_columns[l_i_upper].s_column_name = a_s_tables[l_i_count] + "." + l_s_column
					i_str_columns[l_i_upper].s_data_type 	= l_s_datatype
					Fetch sqlany_columns into :l_s_column, :l_s_datatype ;
				else
					l_i_upper = UpperBound ( i_str_columns ) + 1
					i_str_columns[l_i_upper].s_column_name = l_s_column
					i_str_columns[l_i_upper].s_data_type 	= l_s_datatype
					Fetch sqlany_columns into :l_s_column, :l_s_datatype ;
				end if
			Loop
			Close sqlany_columns ;
		Next
	Case "Microsoft SQL Server"
		For l_i_count = 1 to upperbound ( a_s_tables )
			l_s_table = a_s_tables[l_i_count]
			DECLARE mssql_columns CURSOR FOR 
 				SELECT 	syscolumns.name,   
         				systypes.name  
    			FROM 		syscolumns,   
         				sysobjects,   
         				systypes  
   			WHERE 	syscolumns.id = sysobjects.id and  
         				syscolumns.usertype = systypes.usertype and  
         				sysobjects.name = :l_s_table ;
							
			Open mssql_columns ;
			Fetch mssql_columns into :l_s_column, :l_s_datatype ;
			Do While sqlca.sqlcode = 0
				if UpperBound ( a_s_tables ) > 1 then
					l_i_upper = UpperBound ( i_str_columns ) + 1
					i_str_columns[l_i_upper].s_column_name = a_s_tables[l_i_count] + "." + l_s_column
					i_str_columns[l_i_upper].s_data_type 	= l_s_datatype
					Fetch mssql_columns into :l_s_column, :l_s_datatype ;
				else
					l_i_upper = UpperBound ( i_str_columns ) + 1
					i_str_columns[l_i_upper].s_column_name = l_s_column
					i_str_columns[l_i_upper].s_data_type 	= l_s_datatype
					Fetch mssql_columns into :l_s_column, :l_s_datatype ;
				end if
			Loop
			Close mssql_columns ;
		Next
End Choose

dw_filter.GetChild ( "column_name", l_dwc_columns )
For l_i_count = 1 to UpperBound ( i_str_columns )
If i_str_columns[l_i_count].s_column_name <> "printed" then
	l_dwc_columns.InsertRow ( 0 )
	l_dwc_columns.SetItem ( l_dwc_columns.RowCount ( ), "data", i_str_columns[l_i_count].s_column_name ) 
end if
Next




end subroutine

event open;dw_filter.InsertRow ( 1 )
wf_populate_columns ( )

string			l_s_tables[]

l_s_tables[1]		=  "shipper"


wf_populate_columntypes ( l_s_tables )

end event

on w_search_shipping_dock.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_filter=create dw_filter
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_filter}
end on

on w_search_shipping_dock.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_filter)
end on

event activate;f_center_window ( w_search_shipping_dock )
end event

type cb_2 from commandbutton within w_search_shipping_dock
int X=1275
int Y=1000
int Width=274
int Height=112
int TabOrder=30
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( w_search_shipping_dock , '')
end event

type cb_1 from commandbutton within w_search_shipping_dock
int X=923
int Y=1000
int Width=302
int Height=112
int TabOrder=20
string Text="&Search"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( w_search_shipping_dock, wf_build_where_clause ( ) )
end event

type dw_filter from datawindow within w_search_shipping_dock
int Width=2464
int Height=960
int TabOrder=10
string DataObject="d_search_shipping_dock"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type


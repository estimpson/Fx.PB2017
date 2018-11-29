$PBExportHeader$w_search_invoice.srw
forward
global type w_search_invoice from window
end type
type rb_3 from radiobutton within w_search_invoice
end type
type rb_2 from radiobutton within w_search_invoice
end type
type cb_7 from commandbutton within w_search_invoice
end type
type cb_6 from commandbutton within w_search_invoice
end type
type cb_5 from commandbutton within w_search_invoice
end type
type dw_filter from datawindow within w_search_invoice
end type
type gb_1 from groupbox within w_search_invoice
end type
type str_columns from structure within w_search_invoice
end type
end forward

type str_columns from structure
	string		s_column_name
	string		s_data_type
end type

global type w_search_invoice from window
integer x = 695
integer y = 576
integer width = 2478
integer height = 1244
boolean titlebar = true
string title = "Search "
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
rb_3 rb_3
rb_2 rb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
dw_filter dw_filter
gb_1 gb_1
end type
global w_search_invoice w_search_invoice

type variables
str_columns	i_str_columns[]
end variables

forward prototypes
public subroutine wf_populate_columns (string a_s_tables[])
public function string wf_build_where_clause ()
end prototypes

public subroutine wf_populate_columns (string a_s_tables[]);string				l_s_column,&
						l_s_datatype,&
						l_s_table
int					l_i_count,&
						l_i_upper
datawindowchild	l_dwc_columns
long					l_l_tableid

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

dw_filter.GetChild ( "column_name", l_dwc_columns )
For l_i_count = 1 to UpperBound ( i_str_columns )
If i_str_columns[l_i_count].s_column_name <> "printed" then
	l_dwc_columns.InsertRow ( 0 )
	l_dwc_columns.SetItem ( l_dwc_columns.RowCount ( ), "data", i_str_columns[l_i_count].s_column_name ) 
end if
Next




end subroutine

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
	ls_Datatype = LeftA ( ls_DataType, 4 )	
	
	ls_WhereClause = ls_WhereClause + ls_left 
	choose case ls_Datatype
		case "date","time"
			ls_WhereClause = ls_WhereClause + "date ( "+ls_column+" ) " + ls_operator
		case else
			ls_WhereClause = ls_WhereClause + ls_column + " " + ls_operator
	end choose 		

	If ls_Operator = "like" Then ls_Value = "%" + ls_Value + "%"

	choose case ls_Datatype
		case "char", "varc"
			ls_WhereClause = ls_WhereClause + " ~'" + ls_Value + "~'" + ls_right
		case "date","time"
			ls_WhereClause = ls_WhereClause + "date (" + " ~'" + ls_Value + "~'" + ")" + ls_right
		case else
			ls_WhereClause = ls_WhereClause + " " + ls_Value + ls_right			
	end choose		
	If li_Count < dw_filter.RowCount ( ) Then
		ls_WhereClause = ls_WhereClause + " " + ls_Logical + " "
	End if
Next

/* included this to modify where clause to have printed status */
if ls_whereclause > '' then
	ls_WhereClause = ls_WhereClause + " and (type is null or type <> 'O' or type <> 'R') "
else
	ls_WhereClause = " (type is null or type <> 'O' or type <> 'R') "
end if

if rb_2.checked then
	
	if ls_whereclause > '' then
		ls_WhereClause = ls_WhereClause + " and isnull(invoice_printed,'N') <> 'Y' "
	else
		ls_WhereClause = " isnull(invoice_printed,'N') <> 'Y' "
	end if
	
elseif rb_3.checked then
	
	if ls_whereclause > '' then	
		ls_WhereClause = ls_WhereClause + " and isnull(invoice_printed,'N') = 'Y' "
	else
		ls_WhereClause = " isnull(invoice_printed,'N') = 'Y' "
	end if
	
end if

return ls_whereclause
end function

event open;string					l_s_tables[]

l_s_tables[1]		=  "cdivw_inv_inquiry"

dw_filter.InsertRow ( 1 )
wf_populate_columns ( l_s_tables )


end event

on w_search_invoice.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.dw_filter=create dw_filter
this.gb_1=create gb_1
this.Control[]={this.rb_3,&
this.rb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.dw_filter,&
this.gb_1}
end on

on w_search_invoice.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.dw_filter)
destroy(this.gb_1)
end on

event activate;f_center_window ( w_search_invoice)
end event

type rb_3 from radiobutton within w_search_invoice
integer x = 1394
integer y = 836
integer width = 576
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Printed Invoices"
boolean lefttext = true
end type

type rb_2 from radiobutton within w_search_invoice
integer x = 539
integer y = 836
integer width = 663
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Unprinted Invoices"
boolean checked = true
boolean lefttext = true
end type

type cb_7 from commandbutton within w_search_invoice
integer x = 608
integer y = 992
integer width = 306
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Search"
boolean default = true
end type

event clicked;CloseWithReturn ( w_search_invoice, wf_build_where_clause ( ) )
end event

type cb_6 from commandbutton within w_search_invoice
integer x = 1541
integer y = 992
integer width = 274
integer height = 104
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

event clicked;CloseWithReturn ( w_search_invoice, "cancel" )
end event

type cb_5 from commandbutton within w_search_invoice
integer x = 1010
integer y = 992
integer width = 434
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Display All"
end type

event clicked;string	ls_whereclause

if rb_2.checked then
	
	ls_WhereClause = " isnull(invoice_printed,'N') <> 'Y' "
	
elseif rb_3.checked then
	
	ls_WhereClause = " isnull(invoice_printed,'N') = 'Y' "
	
end if

CloseWithReturn ( w_search_invoice, ls_whereclause )
end event

type dw_filter from datawindow within w_search_invoice
integer width = 2464
integer height = 724
integer taborder = 10
string dataobject = "d_search_invoices"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

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

ls_Dummy = ""
end event

type gb_1 from groupbox within w_search_invoice
integer x = 338
integer y = 752
integer width = 1714
integer height = 188
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Invoice Print Status"
end type


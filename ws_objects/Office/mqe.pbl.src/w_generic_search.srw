$PBExportHeader$w_generic_search.srw
forward
global type w_generic_search from w_response
end type
type cbx_1 from checkbox within w_generic_search
end type
type cb_3 from commandbutton within w_generic_search
end type
type cbx_livedata from checkbox within w_generic_search
end type
type cb_4 from commandbutton within w_generic_search
end type
type cb_2 from commandbutton within w_generic_search
end type
type cb_1 from commandbutton within w_generic_search
end type
type sle_1 from singlelineedit within w_generic_search
end type
type st_1 from statictext within w_generic_search
end type
type dw_savedfilters from datawindow within w_generic_search
end type
type dw_filter from datawindow within w_generic_search
end type
type str_columns from structure within w_generic_search
end type
type str_filter from structure within w_generic_search
end type
end forward

type str_columns from structure
	string		s_column_name
	string		s_data_type
end type

type str_filter from structure
	string		openparen
	string		columnname
	string		operator
	string		value
	string		logical
	string		closeparen
end type

shared variables
n_cst_associative_array	sn_query
end variables

global type w_generic_search from w_response
integer x = 695
integer y = 576
integer width = 2587
integer height = 1244
string title = "Search"
long backcolor = 80269524
cbx_1 cbx_1
cb_3 cb_3
cbx_livedata cbx_livedata
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
st_1 st_1
dw_savedfilters dw_savedfilters
dw_filter dw_filter
end type
global w_generic_search w_generic_search

type variables
private:
string	is_Tables [ ]

str_columns	i_str_columns[]
long	il_clickedrow
string	is_tablename

public:
string		is_parent_title

end variables

forward prototypes
public function string wf_build_where_clause ()
public subroutine wf_populate_columns (string as_tables[])
end prototypes

public function string wf_build_where_clause ();//	Declarations.
long	ll_ColumnRow
long	ll_Count
long	ll_Counter

string	ls_WhereClause
string	ls_DataType

str_filter	lstr_Filter [ ]
datawindowchild	ldwc_Column
window	lw_Parent

//	Initializations.
lw_Parent = ParentWindow ( )
dw_filter.AcceptText ( )
lstr_Filter = dw_filter.object.data.primary
if dw_filter.GetChild ( "column_name", ldwc_Column ) = -1 then
	return ls_WhereClause
end if
sn_query.of_reset()	//re-setting the nvo

//	Build where clause for each line in filter.
ll_Count = UpperBound ( lstr_Filter )
for ll_Counter = 1 to ll_Count
	
	//	Get the datatype for the current column.
	ll_ColumnRow = ldwc_Column.Find ( "cname = '" + lstr_Filter [ ll_Counter ].columnname + "'", 1, ldwc_Column.RowCount ( ) )
	if ll_ColumnRow > 0 then
		ls_DataType = ldwc_Column.GetItemString ( ll_ColumnRow, "dtype" )
	end if
	
	//	Use format appropriate to operator.
	choose case Upper ( lstr_Filter [ ll_Counter ].operator )
		case "CONTAINS"
		case "FREETEXT"
		case else
			if Upper ( lstr_Filter [ ll_Counter ].operator ) = "LIKE" then
				lstr_Filter [ ll_Counter ].value = "%" + lstr_Filter [ ll_Counter ].value + "%"
			end if

			choose case Upper ( LeftA ( ls_DataType, 5 ) )
				case "CHAR(", "VARCH", "TEXT", "CHAR"
					lstr_Filter [ ll_Counter ].value = "'" + lstr_Filter [ ll_Counter ].value + "'"
				case "DATE"
					lstr_Filter [ ll_Counter ].value = "'" + lstr_Filter [ ll_Counter ].value + "'"
				case "TIME"
					lstr_Filter [ ll_Counter ].value = "'" + lstr_Filter [ ll_Counter ].value + "'"
				case "DATET", "TIMES"
					lstr_Filter [ ll_Counter ].value = "'" + lstr_Filter [ ll_Counter ].value + "'"
				case "INT","INTEG"
					lstr_Filter [ ll_Counter ].value = "'" + lstr_Filter [ ll_Counter ].value + "'"
			end choose

			ls_WhereClause += IsNull ( &
				IsNull ( lstr_Filter [ ll_Counter ].openparen, '' ) +&
				is_tables [ 1 ] + "." + lstr_Filter [ ll_Counter ].columnname +&
				" " + lstr_Filter [ ll_Counter ].operator +&
				" " + lstr_Filter [ ll_Counter ].value +&
				IsNull ( lstr_Filter [ ll_Counter ].closeparen, '' ), '' )
			if ll_Counter <> ll_Count then
				ls_WhereClause += IsNull ( " " + lstr_Filter [ ll_Counter ].logical + " ", '' )
			end if
	end choose
	if IsValid ( lw_Parent ) then
		sn_query.of_SetItem ( is_parent_title + "-column" +  string ( ll_Counter ), lstr_Filter [ ll_Counter ].columnname )
		sn_query.of_SetItem ( is_parent_title + "-operator" + string ( ll_Counter ), lstr_Filter [ ll_Counter ].operator )
	end if
next
return ls_WhereClause
end function

public subroutine wf_populate_columns (string as_tables[]);
//	Declarations.
long	ll_Count
long	ll_Counter

string	ls_TableList

datawindowchild	ldwc_Columns

//	Initializations.
if dw_filter.GetChild ( "column_name", ldwc_Columns ) = -1 then
	return
end if

//	Build the table list.
ll_Count = UpperBound ( as_Tables )
for ll_Counter = 1 to ll_Count - 1
	ls_TableList += "'" + as_Tables [ ll_Counter ] + "', "
next

ls_TableList += "'" + as_Tables [ ll_Count ] + "'"
is_tablename = ls_tablelist

//	Depending on platform, set the column list retrieval.
ldwc_Columns.SetTransObject ( SQLCA )
ldwc_Columns.SetSQLSelect ( "select sysColumns.name, systypes.name, sysobjects.name from syscolumns, sysobjects, systypes where sysColumns.id = sysobjects.id and sysColumns.usertype = systypes.usertype and sysobjects.name in ( " + ls_TableList + " ) order by sysColumns.name" )
ldwc_Columns.Retrieve ( )
end subroutine

event open;
//	Declarations.
boolean	lb_UsePrimary = true

integer	ll_Count
integer	ll_Counter

long	ll_Row
long	ll_DWChildRows

string	ls_PrimaryColumn
string	ls_Column
string	ls_Operator

datawindowchild	ldwc_Child

str_generic_search	l_str_parm

//	Initialization.
l_str_parm = Message.Powerobjectparm

//	Get the list of tables being queried and the window title.
is_Tables = l_str_parm.s_Tables
is_parent_title = l_str_parm.parent_title

//	Check if "Retrieve All" is permitted.
cb_4.Visible = ( l_str_parm.b_allow_retrieve_all )

//	Populate column drop downs.
wf_populate_columns ( is_Tables )
ll_Count = sn_query.of_upperbound()

//	Loop through previous query and set columns and operators.
dw_filter.GetChild ( "column_name", ldwc_Child )
ll_DWChildRows = ldwc_Child.RowCount ( )
for ll_Counter = 1 to ll_Count 
	
	//	Get the column and operator for current row.
	ls_Column = String ( sn_query.of_GetItem ( is_parent_title + "-column" + String ( ll_Counter ) ) )
	ls_Operator = String ( sn_query.of_GetItem ( is_parent_title + "-operator" + String ( ll_Counter ) ) )
	
	//	Find the column.
	if ls_column > '' then	
		ll_Row = ldwc_Child.Find ( "cname = '" + ls_column + "'", 1, ll_DWChildRows )
		
		//	If found, add a row and set the column and operator.
		if ll_Row > 0 then
			dw_filter.InsertRow ( 0 )
			dw_filter.object.column_name [ dw_filter.RowCount ( ) ] = ls_column
			dw_filter.object.operator [ dw_filter.RowCount ( ) ] = ls_Operator
			dw_filter.SetColumn ( "value" )
			lb_UsePrimary = false
		end if
	end if
	
next

if l_str_parm.primary_column > '' and lb_UsePrimary then
	dw_filter.InsertRow ( 1 )
	dw_filter.object.column_name [ 1 ] = l_str_parm.primary_column
	dw_filter.object.operator [ 1 ] = l_str_parm.default_operator
	dw_filter.SetColumn ( "value" )
	dw_filter.event ItemFocusChanged ( 1, dw_filter.object.value )
end if
end event

on w_generic_search.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.cbx_livedata=create cbx_livedata
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_savedfilters=create dw_savedfilters
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cbx_livedata
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.sle_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_savedfilters
this.Control[iCurrent+10]=this.dw_filter
end on

on w_generic_search.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.cbx_livedata)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_savedfilters)
destroy(this.dw_filter)
end on

type cbx_1 from checkbox within w_generic_search
integer x = 407
integer y = 1004
integer width = 466
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Get Saved Filters"
boolean righttoleft = true
end type

event clicked;if checked then
	dw_savedfilters.retrieve(is_tables[1])
	if dw_savedfilters.rowcount() <= 0 then 
		Messagebox ( Monsys.msg_title, "No saved filters")
		cbx_1.checked = false
		return
	end if 	
	cb_1.enabled = false
	cb_2.enabled = false
	cb_3.enabled = false
	cb_4.enabled = false
	dw_savedfilters.show()
	dw_savedfilters.bringtotop = true
else
	cb_1.enabled = true
	cb_2.enabled = true
	cb_3.enabled = true
	cb_4.enabled = true
	dw_savedfilters.hide()
end if 
	
end event

type cb_3 from commandbutton within w_generic_search
integer x = 2226
integer y = 992
integer width = 306
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;if dw_filter.Rowcount() > 0 then 
	st_1.show()
	sle_1.show()
	st_1.bringtotop = true
	sle_1.bringtotop = true
	sle_1.setfocus()
else
	return
end if 	



end event

type cbx_livedata from checkbox within w_generic_search
integer x = 27
integer y = 1004
integer width = 306
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Live &Data"
end type

type cb_4 from commandbutton within w_generic_search
integer x = 1422
integer y = 992
integer width = 306
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Display All"
end type

event clicked;CloseWithReturn ( Parent, "all" )
end event

type cb_2 from commandbutton within w_generic_search
integer x = 1824
integer y = 992
integer width = 306
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn ( Parent, "cancel" )
end event

type cb_1 from commandbutton within w_generic_search
integer x = 1019
integer y = 992
integer width = 306
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Search"
boolean default = true
end type

event clicked;CloseWithReturn ( Parent, wf_build_where_clause ( ) )
end event

type sle_1 from singlelineedit within w_generic_search
boolean visible = false
integer x = 969
integer y = 420
integer width = 626
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;int	curnrow
int	totalrow
string	columname
string	roperator
string	svalue
string	loperator
string	operator
string	ltbrackets
string	rtbrackets
string	ls_module
string	ls_filtername
datetime ldt_today

if isnull(sle_1.text) or sle_1.text = '' then return

if upperbound(is_tables) > 0 then 
	ls_module = is_tables[1]
else
	return
end if 

ldt_today = datetime(today(),now())

totalrow = dw_filter.Rowcount()
if totalrow > 0 then 
	ls_filtername = sle_1.text
	for curnrow = 1 to totalrow
		ltbrackets = dw_filter.object.left_parenthesis[curnrow]
		columname = dw_filter.object.column_name[curnrow]
		roperator = dw_filter.object.operator[curnrow]
		svalue = dw_filter.object.value[curnrow]
		loperator = dw_filter.object.logical[curnrow]
		rtbrackets = dw_filter.object.right_parenthesis[curnrow]
		
		if isnull(svalue,'') > '' then 
			insert into filters (
				filtername,
				sequence,
				module,
				filterdate,
				leftparenthesis,
				column_name,
				roperator,
				value,
				loperator,
				operator, 
				rightparenthesis)
			values (:ls_filtername,
				:curnrow,
				:ls_module, 
				:ldt_today, 
				:ltbrackets, 
				:columname, 
				:roperator, 
				:svalue, 
				:loperator, 
				'Mon', 
				:rtbrackets);
				
			if sqlca.sqlcode = 0 then 
				commit;
			else
				rollback;
			end if 	
		end if 	
	next
	st_1.hide()
	sle_1.hide()
end if 	
end event

type st_1 from statictext within w_generic_search
boolean visible = false
integer x = 969
integer y = 344
integer width = 626
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Enter filter name"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_savedfilters from datawindow within w_generic_search
boolean visible = false
integer x = 512
integer y = 268
integer width = 1591
integer height = 688
integer taborder = 30
boolean titlebar = true
string title = "List of Saved Filters"
string dataobject = "d_savedfilters"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then il_clickedrow = row

SelectRow ( 0, false )
SelectRow ( il_clickedrow , true ) 
end event

event buttonclicked;string	columname
string	roperator
string	svalue
string	loperator
string	operator
string	ltbrackets
string	rtbrackets
string	ls_filtername
string	ls_module
long	ll_newrow
cbx_1.checked = false
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true		
choose case dwo.name
	case 'cb_get'
		dw_savedfilters.hide()		
		if dw_savedfilters.rowcount() <= 0 then return 
		dw_filter.reset()		
		ls_filtername = object.filtername[il_clickedrow]
		ls_module = object.module[il_clickedrow]
		DECLARE filterdata CURSOR FOR
		SELECT	leftparenthesis, column_name, roperator, value, loperator, rightparenthesis
		FROM	filters
		WHERE	filtername = :ls_filtername and module = :ls_module;
		
		open	filterdata ;
		fetch	filterdata into	:ltbrackets, :columname, :roperator, :svalue, :loperator, :rtbrackets ;
		
		do while SQLCA.SQLCode = 0
			ll_newrow = dw_filter.insertrow(0)
			dw_filter.setitem(ll_newrow, "left_parenthesis", ltbrackets)
			dw_filter.setitem(ll_newrow, "column_name", columname)
			dw_filter.setitem(ll_newrow, "operator", roperator)
			dw_filter.setitem(ll_newrow, "value", svalue)
			dw_filter.setitem(ll_newrow, "logical", loperator)			
			dw_filter.setitem(ll_newrow, "right_parenthesis", rtbrackets)
			fetch	filterdata into	:ltbrackets, :columname, :roperator, :svalue, :loperator, :rtbrackets ;
		loop			
		close	filterdata ;
		
	case 'cb_cancel'
		dw_savedfilters.hide()
end choose

end event

event constructor;settransobject(sqlca)
end event

type dw_filter from datawindow within w_generic_search
integer x = 18
integer y = 4
integer width = 2523
integer height = 960
integer taborder = 10
string dataobject = "d_external_search"
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

event itemfocuschanged;
//	Declarations.
long	ll_ColumnRow

string	ls_DataType

datawindowchild	ldwc_Child
datawindowchild	ldwc_Column

if row > 0 and cbx_livedata.checked then
	//	Get the datatype for the current column.
	dw_filter.GetChild ( "column_name", ldwc_Column )
	ll_ColumnRow = ldwc_Column.Find ( "cname = '" + object.column_name [ row ] + "'", 1, ldwc_Column.RowCount ( ) )
	if ll_ColumnRow > 0 then
		ls_DataType = ldwc_Column.GetItemString ( ll_ColumnRow, "dtype" )
	end if
	if dwo.name = "value" then
		dw_filter.GetChild ( "value", ldwc_Child )
		ldwc_Child.SetTransObject ( SQLCA )
		if Upper ( ls_DataType ) <> "TEXT" and Upper ( ls_DataType ) <> "IMAGE" then
			if ldwc_Child.SetSQLSelect ( "select distinct convert ( varchar ( 255), " + dw_filter.object.column_name [ row ] + " ), " + dw_filter.object.column_name [ row ] + " from " + is_Tables [ 1 ] + " order by " + dw_filter.object.column_name [ row ] ) = 1 then
				ldwc_Child.Retrieve ( )
			end if
		else
			if ldwc_Child.SetSQLSelect ( "select convert ( varchar ( 255), " + dw_filter.object.column_name [ row ] + " ), " + dw_filter.object.column_name [ row ] + " from " + is_Tables [ 1 ] ) = 1 then
				ldwc_Child.Retrieve ( )
			end if
		end if
	end if
end if
end event

event losefocus;
dw_filter.SetColumn ( 1 )
end event


$PBExportHeader$w_inquiry_ancestor.srw
$PBExportComments$inquiry window ancestor
forward
global type w_inquiry_ancestor from w_sheet_4t
end type
type st_1 from statictext within w_inquiry_ancestor
end type
type dw_inquiry from u_fxdw within w_inquiry_ancestor
end type
end forward

global type w_inquiry_ancestor from w_sheet_4t
integer x = 832
integer y = 360
integer width = 2843
integer height = 1448
string title = "Inquiry Ancestor"
event ue_add pbm_custom01
event ue_delete pbm_custom02
event ue_filter pbm_custom03
event ue_reset pbm_custom04
event ue_sort pbm_custom05
event ue_open pbm_custom06
event ue_cancel ( )
event ue_refresh ( )
event ue_print ( )
st_1 st_1
dw_inquiry dw_inquiry
end type
global w_inquiry_ancestor w_inquiry_ancestor

type variables
string		i_s_original_syntax,&
		i_s_retrieve_all,&
		i_s_title,&
		i_s_primary_column
string		is_default_operator
boolean		i_b_cancel

window	DefaultSheet
string	DefaultSheetName
end variables

event ue_filter;str_generic_search	l_str_parm
string					l_s_whereclause,&
							l_s_firsthalf,&
							l_s_secondhalf,&
							l_s_dummy,&
							l_s_sqlsyntax
long						l_l_count							
int						l_i_pos

l_s_sqlsyntax = i_s_original_syntax

// Setup parm values and open search window
f_get_tables_from_select ( dw_inquiry.object.datawindow.table.select, l_str_parm.s_tables )
l_str_parm.b_allow_retrieve_all = TRUE
l_str_parm.primary_column = i_s_primary_column
l_str_parm.parent_title = this.title
l_str_parm.default_operator = is_default_operator

OpenWithParm ( w_generic_search, l_str_parm )

l_s_whereclause = Message.StringParm

if l_s_whereclause <> 'cancel' then

	if l_s_whereclause <> 'all' and l_s_whereclause > '' then
		
		l_i_pos = PosA ( l_s_sqlsyntax, "ORDER BY" )
	
		If l_i_pos > 0 Then
			l_s_FirstHalf = LeftA ( l_s_sqlsyntax, l_i_pos - 1 )
			l_s_SecondHalf = RightA ( l_s_sqlsyntax, LenA ( l_s_sqlsyntax ) - l_i_pos + 2 )
			l_s_sqlsyntax = l_s_FirstHalf + " WHERE " + l_s_WhereClause + l_s_SecondHalf
		Else
			l_s_sqlsyntax = l_s_sqlsyntax + " WHERE " + l_s_WhereClause
		End if
	
		l_s_dummy = ""
		
		For l_l_count = 1 to LenA ( l_s_sqlsyntax )
			If MidA ( l_s_sqlsyntax, l_l_count, 1 ) <> "~~" Then
				l_s_dummy = l_s_dummy + MidA ( l_s_sqlsyntax, l_l_count, 1 )
			End if
		Next

		dw_inquiry.SetSQLSelect ( l_s_dummy )
	else
		
		l_s_dummy = ""
		
		For l_l_count = 1 to LenA ( l_s_sqlsyntax )
			If MidA ( l_s_sqlsyntax, l_l_count, 1 ) <> "~~" Then
				l_s_dummy = l_s_dummy + MidA ( l_s_sqlsyntax, l_l_count, 1 )
			End if
		Next

		dw_inquiry.SetSQLSelect ( l_s_dummy )

	end if
	SetPointer(HourGlass!)
	dw_inquiry.SetTransObject ( sqlca )
	dw_inquiry.Retrieve ( )

end if

end event

event ue_reset;dw_inquiry.DBCancel()
dw_inquiry.Modify ( "DataWindow.Table.Select='" + i_s_original_syntax + "'" )
SetPointer(HourGlass!)
dw_inquiry.SetTransObject ( sqlca )
dw_inquiry.Retrieve ( )
end event

event ue_sort;//
//  If no row exist yet get out
//

If dw_inquiry.RowCount ( ) < 1 Then Return

//
// Declare Variables
//

str_sort stParm

//
// Initialize Varibles
//

stParm.dw = dw_inquiry
stParm.title = "Define Sort Order"

//
// Open Sort Screen
//

OpenWIthParm ( w_sort, stParm )


end event

event ue_cancel;i_b_cancel = TRUE

end event

event ue_refresh;SetPointer(HourGlass!)
dw_inquiry.Retrieve ( )
end event

event ue_print;dw_inquiry.Print ( )
end event

on w_inquiry_ancestor.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_inquiry=create dw_inquiry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_inquiry
end on

on w_inquiry_ancestor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_inquiry)
end on

event pfc_postopen;call super::pfc_postopen;int		l_i_count

i_s_original_syntax = dw_inquiry.Object.DataWindow.Table.Select

string singleQuote = "'", pbSingleQuote = "~~'"

select
	replace(:i_s_original_syntax, :singleQuote, :pbSingleQuote)
into
	:i_s_original_syntax
from
	(	select dummy=1 ) dummy  ;

SELECT dw_inquiry_files.retrieve_all,
		 dw_inquiry_files.screen_title,
		 dw_inquiry_files.primary_column,
		 dw_inquiry_files.default_operator
  INTO :i_s_retrieve_all,
  		 :i_s_title,
		 :i_s_primary_column,
		 :is_default_operator
  FROM dw_inquiry_files  
 WHERE dw_inquiry_files.screen_title = :OriginalTitle   ;
 
//For l_i_count = 1 to 50 - Len ( i_s_title )
//	i_s_title += ' '
//next

if f_get_string_value ( i_s_retrieve_all ) = 'Y' then
	SetPointer(HourGlass!)
	dw_inquiry.Retrieve ( )
else
	TriggerEvent ( "ue_filter" )
end if
end event

event pfc_preopen;call super::pfc_preopen;
//	Setup resize.
of_SetResize(true)
inv_Resize.of_SetOrigSize(dw_inquiry.X + dw_inquiry.Width, dw_inquiry.Y + dw_inquiry.Height)
inv_Resize.of_Register(dw_inquiry, 0, 0, 100, 100)

end event

type st_1 from statictext within w_inquiry_ancestor
integer x = 18
integer width = 750
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217730
boolean enabled = false
string text = "Total Records = 0"
boolean focusrectangle = false
end type

type dw_inquiry from u_fxdw within w_inquiry_ancestor
integer y = 96
integer width = 2743
integer height = 1056
boolean hscrollbar = true
end type

event constructor;call super::constructor;SetTransObject ( sqlca )

end event

event retrieverow;
if	mod(row, 1000) = 0 then
	st_1.Text = "Total Records = " + String ( row )
end if

if i_b_cancel then 
	i_b_cancel = false
	return 1
end if
SetPointer(HourGlass!)
end event

event retrieveend;call super::retrieveend;
st_1.Text = "Total Records = " + String ( rowcount )

MenuID.dynamic mf_cancel(false)
SetPointer(Arrow!)
end event

event retrievestart;call super::retrievestart;
MenuID.dynamic mf_cancel(true)
st_1.Text = "Total Records = 0"
end event

event doubleclicked;call super::doubleclicked;SetPointer (HourGlass!)
end event


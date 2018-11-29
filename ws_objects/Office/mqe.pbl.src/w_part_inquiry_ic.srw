$PBExportHeader$w_part_inquiry_ic.srw
forward
global type w_part_inquiry_ic from w_inquiry_ancestor
end type
end forward

global type w_part_inquiry_ic from w_inquiry_ancestor
string title = "Part Inquiry"
string menuname = "m_part_inquiry_ic"
end type
global w_part_inquiry_ic w_part_inquiry_ic

on w_part_inquiry_ic.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_part_inquiry_ic" then this.MenuID = create m_part_inquiry_ic
end on

on w_part_inquiry_ic.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

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
l_str_parm.s_tables [ 1 ] = "part"
l_str_parm.b_allow_retrieve_all = TRUE
l_str_parm.primary_column = i_s_primary_column
l_str_parm.parent_title = this.title
l_str_parm.default_operator = is_default_operator

OpenWithParm ( w_generic_search, l_str_parm )

l_s_whereclause = Message.StringParm

if l_s_whereclause <> 'cancel' then

	if l_s_whereclause <> 'all' then
		
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

	end if
	SetPointer(HourGlass!)
	dw_inquiry.SetTransObject ( sqlca )
	dw_inquiry.Retrieve ( )

end if

end event

type st_1 from w_inquiry_ancestor`st_1 within w_part_inquiry_ic
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_part_inquiry_ic
string dataobject = "d_part_inquiry"
boolean hsplitscroll = true
end type

event dw_inquiry::doubleclicked;string	l_s_part

dw_inquiry.DBCancel()

if row < 1 then return

l_s_part = GetItemString ( row, "part" )
message.inv_Parm.of_SetItem("part", l_s_part)

OpenSheet(w_part_qtys_per_location, gnv_App.of_GetFrame(), 3, Original!)

end event

event dw_inquiry::constructor;call super::constructor;
of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.SINGLE)

end event


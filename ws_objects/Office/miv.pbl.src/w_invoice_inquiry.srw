$PBExportHeader$w_invoice_inquiry.srw
forward
global type w_invoice_inquiry from w_sheet_4t
end type
type cb_2 from commandbutton within w_invoice_inquiry
end type
type cb_3 from commandbutton within w_invoice_inquiry
end type
type dw_1 from datawindow within w_invoice_inquiry
end type
type lb_1 from listbox within w_invoice_inquiry
end type
type cb_1 from commandbutton within w_invoice_inquiry
end type
type dw_inquiry from datawindow within w_invoice_inquiry
end type
end forward

global type w_invoice_inquiry from w_sheet_4t
integer x = 214
integer y = 221
string title = "Invoice Inquiry"
string menuname = "m_invoice_inquiry"
event ue_add pbm_custom01
event ue_filter pbm_custom03
event ue_reset pbm_custom04
event ue_sort pbm_custom05
event ue_open pbm_custom06
event ue_cancel ( )
event ue_refresh ( )
event ue_print ( )
event ue_print_update ( string a_s_value )
event show_notes pbm_custom07
event accounts_receivable pbm_custom08
event ue_invcrgstr pbm_custom09
event retrieve_again pbm_custom10
cb_2 cb_2
cb_3 cb_3
dw_1 dw_1
lb_1 lb_1
cb_1 cb_1
dw_inquiry dw_inquiry
end type
global w_invoice_inquiry w_invoice_inquiry

type variables
string		i_s_original_syntax,&
		i_s_retrieve_all,&
		i_s_title,&
		i_s_primary_column,&
                                is_whereclause
boolean		i_b_cancel

Long                        i_l_row
                                
end variables

forward prototypes
public subroutine wf_show_notes ()
public subroutine wf_hide_notes ()
end prototypes

event ue_add;
/*  Declare Variables  */
st_generic_structure stParm

/*  Initialize Variables  */
stParm.Value1 = "ManualInvoice"

/*  Manual Add Invoice  */
OpenSheetWithParm(w_invoice_detail, stParm, gnv_App.of_GetFrame(), 0, Original!)

end event

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
OpenWithParm ( w_search_invoice, l_str_parm )

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
	end if 	// moved this from down below
	l_s_dummy = ""
	
	For l_l_count = 1 to LenA ( l_s_sqlsyntax )
		If MidA ( l_s_sqlsyntax, l_l_count, 1 ) <> "~~" Then
			l_s_dummy = l_s_dummy + MidA ( l_s_sqlsyntax, l_l_count, 1 )
		End if
	Next

	dw_inquiry.SetSQLSelect ( l_s_dummy )

	dw_inquiry.SetTransObject ( sqlca )
	dw_inquiry.Retrieve ( )
	dw_inquiry.Setfilter ( 'invoice_number>0' )
	dw_inquiry.Filter ( )	
   
   Title = i_s_title + "          Total Records = " + string(dw_inquiry.rowcount()) 

	
end if


//str_filter	l_str_parm
//
//l_str_parm.parentwindow = This
//l_str_parm.filterdw		= dw_inquiry
//
//OpenWithParm ( w_filter, l_str_parm )
end event

event ue_reset;dw_inquiry.Modify ( "DataWindow.Table.Select='" + i_s_original_syntax + "'" )
dw_inquiry.SetTransObject ( sqlca )
dw_inquiry.Retrieve ( )
dw_inquiry.Setfilter ( 'invoice_number>0' )
dw_inquiry.Filter ( )
Title = i_s_title + "          Total Records = " + string(dw_inquiry.rowcount()) 
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

OpenWithParm ( w_sort, stParm )


end event

event ue_cancel;i_b_cancel = TRUE

end event

event ue_refresh;dw_inquiry.Retrieve ( )
end event

event ue_print;/*  Declare Variables  */

Long 		lInvoiceNumber
Long 		l_Row
Long 		iCount = 0
Long		l_l_Count
Int		l_i_RtnCode
Int      iRtnCode

st_generic_structure l_str_parm

/*  Initialize Variables  */

lb_1.Reset ( )

/*  Loop through records and see if more than one */

FOR l_Row = 1 TO dw_inquiry.RowCount ( )

	If dw_inquiry.IsSelected ( l_Row ) Then
		If lb_1.FindItem ( String ( dw_inquiry.GetItemNumber ( l_Row, "invoice_number" ) ), 1 ) = -1 Then
			lb_1.AddItem ( String ( dw_inquiry.GetItemNumber ( l_Row, "invoice_number" ) ) )
		End if
	End if	
NEXT

IF lb_1.TotalItems ( ) < 1 THEN

	RETURN

ELSE 

	FOR l_l_count = 1 to lb_1.TotalItems()

		w_report_view  l_w_instance[]
		
		l_str_parm.value1 =  lb_1.Text ( l_l_count )
		l_str_parm.value11 = "Invoice"
		
		if IsValid(gnv_App.of_GetFrame()) then
			OpenSheetWithParm(l_w_instance[l_l_count], l_str_parm, gnv_App.of_GetFrame(), 0, Original!)
		else
			OpenWithParm(l_w_instance[l_l_count], l_str_parm)
		end if
	NEXT
END IF

end event

event ue_print_update;Long 		l_l_Invoice, &
			l_l_count

FOR l_l_count = 1 to lb_1.TotalItems()	
		
		l_l_invoice = Long ( lb_1.text (l_l_count) )
		
		UPDATE shipper  
	   SET invoice_printed = 'Y'  
	 	WHERE invoice_number = :l_l_Invoice   ;

		If SQLCA.SQLCode <> 0 Then
			MessageBox ( monsys.msg_title, "Unable to update print flag~r" + &
										 "for selected invoices!", StopSign! )
			RollBack ;
		Else
			Commit ;
			setmicrohelp ( 'Ready' )
		End if

NEXT

dw_inquiry.Retrieve ( )
dw_inquiry.SetFilter ( "invoice_number>0" )
dw_inquiry.Filter()
end event

event show_notes;/*  Declare Variables  */

Long lShipper

/*  Initialize Variables  */

If dw_inquiry.getselectedrow(0) < 1 Then Return

lShipper = dw_inquiry.GetItemNumber ( dw_inquiry.getselectedrow(0), "id" )

dw_1.SetTransObject ( sqlca )
dw_1.Reset ( )
dw_1.Retrieve ( lShipper )

wf_show_notes ( )
end event

event accounts_receivable;STRING s_InterfaceType

  SELECT	accounting_type
    INTO	:s_InterfaceType
    FROM	parameters  ;

CHOOSE CASE Upper ( s_InterfaceType )
CASE	'PLATINUM'
	OpenSheet(w_ai_ar_platinum, gnv_App.of_GetFrame(), 0, Original!)
CASE ELSE
	Open(w_export_invoices)
END CHOOSE
end event

event ue_invcrgstr;String s_DataWindow

SELECT object_name
  INTO :s_DataWindow
  FROM report_library
 WHERE name = 'Invoice Register'	;

IF s_DataWindow <> "Standard" THEN
	OpenSheet (w_invoice_register_custom, gnv_App.of_GetFrame(), 0, Original! )
ELSE
	OpenSheet (w_invoice_register, gnv_App.of_GetFrame(), 0, Original! )
END IF
end event

event retrieve_again;long		ll_invoice
long		ll_row

ll_row = dw_inquiry.GetRow ( )

if ll_row > 0 then
	if dw_inquiry.IsSelected ( ll_row ) then
		ll_invoice = dw_inquiry.GetItemNumber ( ll_row, "invoice_number" )
	end if
end if

dw_inquiry.Retrieve()
dw_inquiry.Setfilter ( 'invoice_number>0' )
dw_inquiry.Filter ( )

ll_row = dw_inquiry.Find ( "invoice_number = " + String ( ll_invoice ), 1, dw_inquiry.RowCount ( ) )
if ll_row > 0 then
	if ll_invoice = dw_inquiry.GetItemNumber ( ll_row, "invoice_number" ) then
		dw_inquiry.ScrollToRow ( ll_row )
		dw_inquiry.SelectRow ( 0, FALSE )
		dw_inquiry.SelectRow ( ll_row, TRUE )
	end if
end if

end event

public subroutine wf_show_notes ();cb_1.Visible = True
cb_2.Visible = True
cb_3.Visible = True
dw_1.Visible = True
dw_1.SetFocus ()
end subroutine

public subroutine wf_hide_notes ();cb_1.Visible = False
cb_2.Visible = False
cb_3.Visible = False

dw_1.Visible = False
end subroutine

event resize;call super::resize;dw_inquiry.width = width - 100
dw_inquiry.height = height - 150
end event

on w_invoice_inquiry.create
int iCurrent
call super::create
if this.MenuName = "m_invoice_inquiry" then this.MenuID = create m_invoice_inquiry
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_1=create dw_1
this.lb_1=create lb_1
this.cb_1=create cb_1
this.dw_inquiry=create dw_inquiry
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.lb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_inquiry
end on

on w_invoice_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.lb_1)
destroy(this.cb_1)
destroy(this.dw_inquiry)
end on

event pfc_postopen;call super::pfc_postopen;int		l_i_count

i_s_original_syntax = dw_inquiry.Object.DataWindow.Table.Select

SELECT dw_inquiry_files.retrieve_all,
		 dw_inquiry_files.screen_title,
		 dw_inquiry_files.primary_column
  INTO :i_s_retrieve_all,
  		 :i_s_title,
		 :i_s_primary_column
  FROM dw_inquiry_files  
 WHERE dw_inquiry_files.screen_title = :Title   ;
 
Title = i_s_title

For l_i_count = 1 to 50 - LenA ( i_s_title )
	i_s_title += ' '
next

if f_get_string_value ( i_s_retrieve_all ) = 'Y' then
	dw_inquiry.Retrieve ( )
	dw_inquiry.Setfilter ( 'invoice_number>0' )
	dw_inquiry.Filter ( )
else
	TriggerEvent ( "ue_filter" )
end if
end event

type cb_2 from commandbutton within w_invoice_inquiry
boolean visible = false
integer x = 1243
integer y = 904
integer width = 247
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;If dw_1.Update ( ) = -1 Then
	RollBack ;
	Return
Else
	Commit ;
	dw_inquiry.setitem ( dw_inquiry.getselectedrow(0), "notes", dw_1.object.#1[1] )
End if

wf_hide_notes ( )
end event

type cb_3 from commandbutton within w_invoice_inquiry
boolean visible = false
integer x = 1531
integer y = 904
integer width = 247
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;wf_hide_notes()
end event

type dw_1 from datawindow within w_invoice_inquiry
boolean visible = false
integer x = 978
integer y = 180
integer width = 1184
integer height = 708
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_shipper_header_notes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(SQLCA)





end event

type lb_1 from listbox within w_invoice_inquiry
boolean visible = false
integer x = 1586
integer y = 364
integer width = 494
integer height = 360
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_invoice_inquiry
boolean visible = false
integer x = 933
integer y = 152
integer width = 1275
integer height = 876
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type dw_inquiry from datawindow within w_invoice_inquiry
integer x = 14
integer y = 24
integer width = 2990
integer height = 1412
integer taborder = 10
string dataobject = "d_unprinted_invoices"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject ( sqlca )

end event

event clicked;/*  Declare Variables  */
Long	ll_Count
Long	ll_Row
Long  ll_PrevRow

/*  Initialize Variables  */

ll_Row = row
i_l_Row   = ll_Row

If ll_Row < 1 Then Return

If KeyDown ( keyShift! ) Then

   ll_PrevRow = dw_inquiry.GetRow()

	If ll_PrevRow < ll_Row Then

		For ll_Count = ll_PrevRow to ll_Row
			SelectRow ( This, ll_Count, True )
		Next

   Else

		For ll_Count = ll_Row to ll_PrevRow
			SelectRow ( This, ll_Count, True )
		Next
   
	End If 

Elseif KeyDown ( keyControl! ) Then

	If This.IsSelected ( ll_Row ) Then
		SelectRow ( This, ll_Row, False )
	Else
		SelectRow ( This, ll_Row, True )
	End if

Else

	SelectRow ( This, 0, False )
	SelectRow ( This, ll_Row, True )

End if

ll_PrevRow = ll_Row
end event

event retrieverow;Parent.Title = i_s_title + "          Total Records = " + string(rowcount()) 

if i_b_cancel then 
	i_b_cancel = FALSE
	return 1
end if

SetPointer(HourGlass!)
end event

event retrieveend;SetSort ( "#1 A" )
Sort ( )
MenuID.dynamic mf_Cancel(false)
SetPointer(Arrow!)


end event

event retrievestart;Parent.Title = i_s_title + " Total Records = 0"
MenuID.dynamic mf_Cancel(true)

end event

event doubleclicked;/*  Declare Variables  */

st_generic_structure stParm

Long lInvoice

String cType

/*  Initialize Variables  */

IF row > 0 THEN
	
   dw_inquiry.DBcancel()

	lInvoice = f_get_value ( dw_inquiry.GetItemNumber ( Row, "invoice_number" ) )
	cType    = f_get_string_value ( dw_inquiry.GetItemString ( Row, "type" ) )

	If cType = 'M' Then
		stParm.Value1 = "ManualInvoice"
		stParm.Value2 = String ( lInvoice )
	Else
		stParm.Value1 = String(lInvoice)  //Without this line the regular invoice 
	End if										 //will not print (Jim added 07/06/95)

	OpenSheetWithParm ( w_invoice_detail, stParm, gnv_App.of_GetFrame(), 0, Original! )
	
ELSE
	
	SETMICROHELP ( 'Select a row' )
	
END IF
end event


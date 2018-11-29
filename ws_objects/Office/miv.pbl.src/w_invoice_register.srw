$PBExportHeader$w_invoice_register.srw
forward
global type w_invoice_register from w_sheet_4t
end type
type cb_4 from commandbutton within w_invoice_register
end type
type cb_3 from commandbutton within w_invoice_register
end type
type cb_2 from commandbutton within w_invoice_register
end type
type dw_5 from datawindow within w_invoice_register
end type
type cb_1 from commandbutton within w_invoice_register
end type
type cb_5 from commandbutton within w_invoice_register
end type
type dw_4 from datawindow within w_invoice_register
end type
type cb_6 from commandbutton within w_invoice_register
end type
type dw_3 from datawindow within w_invoice_register
end type
type dw_2 from datawindow within w_invoice_register
end type
type st_2 from statictext within w_invoice_register
end type
type em_2 from editmask within w_invoice_register
end type
type st_1 from statictext within w_invoice_register
end type
type em_1 from editmask within w_invoice_register
end type
type dw_1 from datawindow within w_invoice_register
end type
end forward

global type w_invoice_register from w_sheet_4t
integer x = 0
integer y = 0
integer width = 2926
integer height = 1928
string title = "Invoice Register"
string menuname = "m_invoice_register"
long backcolor = 77897888
event generate_report pbm_custom01
event account_summary pbm_custom02
event print_register pbm_custom03
event zoom pbm_custom04
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_5 dw_5
cb_1 cb_1
cb_5 cb_5
dw_4 dw_4
cb_6 cb_6
dw_3 dw_3
dw_2 dw_2
st_2 st_2
em_2 em_2
st_1 st_1
em_1 em_1
dw_1 dw_1
end type
global w_invoice_register w_invoice_register

type variables
String szCompanyName
String szDateRange
String szCustomerCode
String szCustomerName
String szDateFrom
String szDateTo
String szColumnname

Date dInvoiceDate

Dec dInvoiceAmount

Boolean bBlanks
end variables

forward prototypes
public subroutine wf_header ()
public subroutine wf_body ()
public subroutine wf_add_account_code (string sznewcode, decimal dqty)
public subroutine wf_blank_accounts ()
end prototypes

event generate_report;/*  Declare Variables  */
datetime	ldt_start, ldt_end

dw_2.SetTransObject ( sqlca )

/*  Initialize Variables  */

dw_1.Reset ( )

/*  Main  */

wf_header ( )

ldt_start = Datetime ( Date ( em_1.Text ), time('00:00:00') )
ldt_end = Datetime ( Date ( em_2.Text ), time('23:59:59') )

dw_2.Retrieve ( ldt_start, ldt_end)
szDateFrom = em_1.text
szDateTo   = em_2.text

wf_body ( )
end event

on account_summary;cb_6.Visible = True
dw_4.Visible = True
cb_5.Visible = True
cb_3.Visible = True
end on

on print_register;/*  Main  */

dw_1.Print ( )
dw_4.Print ( )
end on

on zoom;OpenWithParm ( w_printzoom, dw_1 )
end on

public subroutine wf_header ();/*  Declare Variables  */

/*  Initialize Variables  */

SELECT parameters.company_name,parameters.inv_reg_col  
  INTO :szCompanyName, :szColumnname
  FROM parameters  ;




end subroutine

public subroutine wf_body ();/*  Declare Variables  */

String 	cPieceUnit          //  Piece, Lot, Thousand
String 	szAccountCode
String 	szCode
String 	szDestination
String 	szPart
String 	cTaxable
String 	szStatus
String 	ls_GLAccountCode
String	ls_InvoicePrinted

Long 		lRow                   //  dw_2 row number
Long 		lShipperNo
Long 		lInvoiceNumber = 0
Long 		lNewRow                //  dw_1 detail row number
Long 		lDetailRow             //  dw_3 row number
Long 		lOrderNo
Long 		lAccountRow
Long 		lCount
Long 		lBlankRow

Int		iPrintedInvoices = 0

//Dec  		{2} dQtyShipped
//Dec  		{2} dQty
//Dec  		{2} dPrice
//Dec  		{2} dAccountQty
Dec  		dQtyShipped
Dec  		dQty
Dec  		dPrice
Dec  		dAccountQty
Dec  		dTaxRate
Dec  		dTaxAmount
Dec  		dTotalTax = 0
Dec  		dFreight
Dec  		dTotalFreight = 0

dw_3.SetTransObject ( sqlca )

/*  Initialize Variables */

/*  Main  */

dw_4.Reset ( )

dw_1.SetItem ( 1, "company_name", szCompanyName )
dw_1.SetItem ( 1, "date_range", "From: " + szDateFrom + "  To: " + szDateTo )

For lRow = 1 to dw_2.RowCount ( )

	szCustomerCode = f_get_string_value ( dw_2.GetItemString ( lRow, "shipper_customer" ) )
	szCustomerName = f_get_string_value ( dw_2.GetItemString ( lRow, "customer_name" ) )
	lShipperNo     = f_get_value ( dw_2.GetItemNumber ( lRow, "id" ) )
	lInvoiceNumber = f_get_value ( dw_2.GetItemNumber ( lRow, "invoice_number" ) )
	dInvoiceDate   = date  ( dw_2.GetItemDatetime ( lRow, "date_shipped" ) )
	szDestination  = f_get_string_value ( dw_2.GetItemString ( lRow, "shipper_destination" ) )
	dFreight       = f_get_value ( dw_2.GetItemDecimal ( lRow, "shipper_freight" ))
	dTotalFreight  = dTotalFreight + dFreight
	dTaxRate 		= f_get_value ( dw_2.GetItemDecimal ( lRow, "tax_rate" ) ) / 100
	szStatus			= dw_2.GetItemString( lRow, "shipper_status")
	ls_InvoicePrinted = f_get_string_value ( dw_2.GetItemString ( lRow, "invoice_printed" ) )

	dw_3.Retrieve ( lShipperNo )

	dInvoiceAmount = 0

	For lDetailRow = 1 to dw_3.RowCount ( )

		lOrderNo      	= f_get_value ( dw_3.GetItemNumber ( lDetailRow, "order_no" ) )

// earlier 		dQtyShipped   	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "alternative_qty" ) )

// included on 01/24/96  
      if UPPER(szColumnname) = "GROSS_WEIGHT" then
	   	dQtyShipped   	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "gross_weight" ) )
      else
    		dQtyShipped   	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "alternative_qty" ) )
      end if
// till here 

		szAccountCode 	= f_get_string_value ( dw_3.GetItemString ( lDetailRow, "account_code" ) )
		dPrice        	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "alternate_price" ) )
		szPart        	= f_get_string_value ( dw_3.GetItemString ( lDetailRow, "part" ) )
		cTaxable			= f_get_string_value ( dw_3.GetItemString ( lDetailRow, "taxable" ) )

		SELECT order_header.price_unit  
		  INTO :cPieceUnit  
		  FROM order_header  
		 WHERE order_header.order_no = :lOrderNo   ;

		If cPieceUnit = 'L' Then

			dQty = 1
			
		Elseif cPieceUnit = 'T' Then

			dQty = Int ( dQtyShipped / 1000 )

		Else

			dQty = dQtyShipped
		
		End if
		
		dTaxAmount = 0

		If cTaxable = 'Y' Then

			dTaxAmount = Round ( dQty * dPrice * dTaxRate, 2 )
			dTotalTax = dTotalTax + dTaxAmount

		End if

		dInvoiceAmount = dInvoiceAmount + Round ( dQty * dPrice, 2 ) + dTaxAmount
		
		If szAccountCode = "" Then

			szAccountCode = "Blank"
			lBlankRow = dw_5.RowCount ( ) + 1
			dw_5.InsertRow ( 0 )
			dw_5.SetItem ( lBlankRow, "invoice_number", lInvoiceNumber )
			dw_5.SetItem ( lBlankRow, "part_number", szPart )

		End if

		dAccountQty = Round ( dQty * dPrice, 2 )

		wf_add_account_code ( szAccountCode, dAccountQty )

	Next 

	dInvoiceAmount = dInvoiceAmount + dFreight

	lNewRow = dw_1.RowCount ( )
	dw_1.InsertRow ( 0 )
	lNewRow++

	dw_1.SetItem ( lNewRow, "invoice_number", String ( lInvoiceNumber ) )
	dw_1.SetItem ( lNewRow, "invoice_date", dInvoiceDate )

	If ls_InvoicePrinted = "Y" Then
      iPrintedInvoices++ 
      dw_1.SetItem ( lNewRow, "invoice_print_status", "Y" )
 	Else
 		dw_1.SetItem ( lNewRow, "invoice_print_status", "N" )
	End if

 	If szStatus <> 'D' then		//if not deleted
		dw_1.SetItem ( lNewRow, "customer_code", szCustomerCode )
		dw_1.SetItem ( lNewRow, "customer_name", szCustomerName )
		dw_1.SetItem ( lNewRow, "invoice_amount", dInvoiceAmount )
	Else
		dw_1.SetItem ( lNewRow, "customer_code", "* Deleted *")
		dw_1.SetItem ( lNewRow, "customer_name", "* Deleted *")
		dw_1.SetItem ( lNewRow, "invoice_amount", 0)
	End If
	dw_1.SetItem ( lNewRow, "shipper", String ( lShipperNo ) )

Next

dw_1.SetItem ( 1, "company_name", szCompanyName )
dw_1.SetItem ( 1, "date_range", "From: " + szDateFrom + "  To: " + szDateTo )
dw_1.SetItem ( dw_1.Rowcount (), "no_of_ptd_invoices", iPrintedInvoices)

wf_add_account_code ( "Freight", dTotalFreight )
wf_add_account_code ( "Sales Tax", dTotalTax )

end subroutine

public subroutine wf_add_account_code (string sznewcode, decimal dqty);/*  Declare Variables  */

Long lCount
Long lAccountRow

Dec dAccountQty
Dec dCheck

String szAccountCode
String ls_GLAcctCode

/*  Add Account Code  */

For lCount = 1 to dw_4.RowCount ( )

	szAccountCode = dw_4.GetItemString ( lCount, "account_code" )
	
	If Trim ( szNewCode ) = Trim ( szAccountCode ) Then
		lAccountRow = lCount
		lCount = dw_4.RowCount ( )
	End if

Next

If lAccountRow > 0 Then

	dAccountQty = dw_4.GetItemNumber ( lAccountRow, "account_total" )
	dAccountQty = dAccountQty + dQty
	dw_4.SetItem ( lAccountRow, "account_total", dAccountQty )

Else

	dw_4.InsertRow ( 1 )
	dw_4.SetItem ( 1, "account_code", szNewCode )
	dw_4.SetItem ( 1, "account_total", dQty )
	ls_GLAcctCode = ""

	If szNewCode = 'Sales Tax' Then
		SELECT sales_tax_account
     	  INTO :ls_GLAcctCode	
     	  FROM parameters	;
	ElseIf szNewCode = 'Freight' Then
		SELECT freight_account
		  INTO :ls_GLAcctCode
		  FROM parameters	;
	End If

	dw_4.SetItem ( 1, "gl_account_code", ls_GLAcctCode )

End if

end subroutine

public subroutine wf_blank_accounts ();cb_1.Visible = True
cb_2.Visible = True
dw_5.Visible = True

end subroutine

on w_invoice_register.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_invoice_register" then this.MenuID = create m_invoice_register
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_5=create dw_5
this.cb_1=create cb_1
this.cb_5=create cb_5
this.dw_4=create dw_4
this.cb_6=create cb_6
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_2=create st_2
this.em_2=create em_2
this.st_1=create st_1
this.em_1=create em_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_5
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.cb_6
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.em_2
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.em_1
this.Control[iCurrent+15]=this.dw_1
end on

on w_invoice_register.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.dw_4)
destroy(this.cb_6)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.dw_1)
end on

on open;em_1.Text = String ( Today ( ) )
em_2.Text = String ( Today ( ) )
end on

event resize;dw_1.width 	= this.width - 60
dw_1.height	= this.height * 0.85

st_1.height	= this.height * 0.075
st_1.x		= dw_1.x
st_1.y		= dw_1.height + 60

st_2.height	= this.height * 0.05
st_2.x		= em_1.x + em_1.width + 25
st_2.y		= st_1.Y

em_1.height	= this.height * 0.05
em_1.x		= st_1.X + st_1.width + 25
em_1.Y		= st_1.Y

em_2.height	= this.height * 0.05
em_2.x		= st_2.X + st_2.width + 25
em_2.Y		= st_1.Y

cb_4.height	= this.height * 0.075
cb_4.Y		= st_1.Y - 14
cb_4.X		= dw_1.Width - cb_4.width

end event

type cb_4 from commandbutton within w_invoice_register
integer x = 2277
integer y = 1304
integer width = 576
integer height = 116
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generate Report"
boolean default = true
end type

on clicked;w_invoice_register.TriggerEvent ( "generate_report" )
end on

type cb_3 from commandbutton within w_invoice_register
boolean visible = false
integer x = 293
integer y = 1024
integer width = 736
integer height = 96
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Show Blank Account Codes"
end type

on clicked;bBlanks = True
wf_blank_accounts ( )


end on

type cb_2 from commandbutton within w_invoice_register
boolean visible = false
integer x = 1865
integer y = 1024
integer width = 146
integer height = 96
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exit"
end type

on clicked;cb_1.Visible = False
cb_2.Visible = False
dw_5.Visible = False

bBlanks = False
end on

type dw_5 from datawindow within w_invoice_register
boolean visible = false
integer x = 1865
integer y = 128
integer width = 914
integer height = 896
integer taborder = 90
string dataobject = "d_list_of_blank_account_codes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type cb_1 from commandbutton within w_invoice_register
boolean visible = false
integer x = 1829
integer y = 96
integer width = 987
integer height = 1056
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

type cb_5 from commandbutton within w_invoice_register
boolean visible = false
integer x = 110
integer y = 1024
integer width = 146
integer height = 96
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exit"
end type

on clicked;cb_5.Visible = False
dw_4.Visible = False
cb_6.Visible = False
cb_3.Visible = False

end on

type dw_4 from datawindow within w_invoice_register
boolean visible = false
integer x = 69
integer y = 120
integer width = 1733
integer height = 896
integer taborder = 80
string dataobject = "d_account_code_totals"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type cb_6 from commandbutton within w_invoice_register
boolean visible = false
integer x = 46
integer y = 96
integer width = 1769
integer height = 1056
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

type dw_3 from datawindow within w_invoice_register
boolean visible = false
integer x = 1618
integer y = 1440
integer width = 1161
integer height = 352
integer taborder = 70
string dataobject = "d_shipper_detail_with_account"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_2 from datawindow within w_invoice_register
boolean visible = false
integer x = 18
integer y = 1440
integer width = 1477
integer height = 352
integer taborder = 60
string dataobject = "d_shippers_within_range"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type st_2 from statictext within w_invoice_register
integer x = 841
integer y = 1312
integer width = 146
integer height = 96
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from editmask within w_invoice_register
integer x = 1024
integer y = 1312
integer width = 293
integer height = 80
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yy"
end type

type st_1 from statictext within w_invoice_register
integer x = 37
integer y = 1312
integer width = 439
integer height = 96
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "Date Range:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_invoice_register
integer x = 512
integer y = 1312
integer width = 293
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yy"
end type

type dw_1 from datawindow within w_invoice_register
integer x = 37
integer y = 40
integer width = 2816
integer height = 1248
string dataobject = "d_invoice_register"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type


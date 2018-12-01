$PBExportHeader$w_invoice_register.srw
forward
global type w_invoice_register from w_sheet_4t
end type
type dw_6 from datawindow within w_invoice_register
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
dw_6 dw_6
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

on generate_report;/*  Declare Variables  */

dw_2.SetTransObject ( sqlca )

/*  Initialize Variables  */

dw_1.Reset ( )

/*  Main  */

wf_header ( )

dw_2.Retrieve ( Date ( em_1.Text ), Date ( em_2.Text ) )
szDateFrom = em_1.text
szDateTo   = em_2.text

wf_body ( )
end on

on account_summary;cb_6.Visible = True
dw_4.Visible = True
cb_5.Visible = True
cb_3.Visible = True
end on

event print_register;/*  Main  */

dw_1.Modify("DataWindow.Print.Orientation = 1") //landscape
dw_1.Print ( )
dw_1.Modify("DataWindow.Print.Orientation = 0") //default to printer
dw_4.Print ( )
end event

on zoom;OpenWithParm ( w_printzoom, dw_1 )
end on

public subroutine wf_header ();/*  Declare Variables  */

/*  Initialize Variables  */

SELECT parameters.company_name,parameters.inv_reg_col  
  INTO :szCompanyName, :szColumnname
  FROM parameters  ;




end subroutine

public subroutine wf_body ();String 	cPieceUnit          //  Piece, Lot, Thousand
String 	szAccountCode
String 	szCode
String 	szDestination
String 	szPart
String 	cTaxable
String 	szStatus
String 	ls_GLAccountCode
String	ls_InvoicePrinted
Long	lRow                   //  dw_2 row number
Long	lShipperNo
Long	lInvoiceNumber = 0
Long	lNewRow                //  dw_1 detail row number
Long	lDetailRow             //  dw_3 row number
Long	lOrderNo
Long	lAccountRow
Long	lCount
Long	lBlankRow

Int	iPrintedInvoices = 0
Dec	dQtyShipped
Dec	dQty
Dec	dPrice
Dec	dAccountQty
Dec	dTaxRate
Dec	dTaxAmount
Dec	dTotalTax = 0
Dec	dFreight
Dec	dTotalFreight = 0

dw_3.SetTransObject ( sqlca )
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
		if UPPER(szColumnname) = "GROSS_WEIGHT" then
			dQtyShipped   	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "gross_weight" ) )
		else
			dQtyShipped   	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "alternative_qty" ) )
		end if
		szAccountCode 	= f_get_string_value ( dw_3.GetItemString ( lDetailRow, "account_code" ) )
		dPrice        	= f_get_value ( dw_3.GetItemDecimal ( lDetailRow, "alternate_price" ) )
		szPart        	= f_get_string_value ( dw_3.GetItemString ( lDetailRow, "part" ) )
		cTaxable			= f_get_string_value ( dw_3.GetItemString ( lDetailRow, "taxable" ) )

		//	specifically for grobbel
		if dQtyshipped = 0 then dQtyshipped = 1

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

	//	Get the other info
	dw_6.retrieve ( lshipperno)
	if dw_6.rowcount() > 0 then
		dw_1.SetItem ( lNewRow, "total_fgsamount", dw_6.object.total_fgsamt[1])
		dw_1.SetItem ( lNewRow, "total_tolamount", dw_6.object.total_tolamt[1])
		dw_1.SetItem ( lNewRow, "total_frtamount", dw_6.object.total_frtamt[1])
		dw_1.SetItem ( lNewRow, "total_misamount", dw_6.object.total_misamt[1])
	end if 	
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

on activate;//If w_main_screen.MenuName <> "m_invoice_register" Then &
//w_main_screen.ChangeMenu ( m_invoice_register )
end on

on w_invoice_register.create
this.dw_6=create dw_6
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
this.Control[]={this.dw_6,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_5,&
this.cb_1,&
this.cb_5,&
this.dw_4,&
this.cb_6,&
this.dw_3,&
this.dw_2,&
this.st_2,&
this.em_2,&
this.st_1,&
this.em_1,&
this.dw_1}
end on

on w_invoice_register.destroy
destroy(this.dw_6)
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

type dw_6 from datawindow within w_invoice_register
int X=82
int Y=1420
int Width=347
int Height=264
int TabOrder=80
boolean Visible=false
string DataObject="d_cdisp_invoiceregistrydata"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(sqlca)
end event

type cb_4 from commandbutton within w_invoice_register
int X=2277
int Y=1304
int Width=576
int Height=116
int TabOrder=50
string Text="Generate Report"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;w_invoice_register.TriggerEvent ( "generate_report" )
end on

type cb_3 from commandbutton within w_invoice_register
int X=293
int Y=1024
int Width=736
int Height=96
int TabOrder=120
boolean Visible=false
string Text="Show Blank Account Codes"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;bBlanks = True
wf_blank_accounts ( )


end on

type cb_2 from commandbutton within w_invoice_register
int X=1865
int Y=1024
int Width=146
int Height=96
int TabOrder=110
boolean Visible=false
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;cb_1.Visible = False
cb_2.Visible = False
dw_5.Visible = False

bBlanks = False
end on

type dw_5 from datawindow within w_invoice_register
int X=1865
int Y=128
int Width=914
int Height=896
int TabOrder=90
boolean Visible=false
string DataObject="d_list_of_blank_account_codes"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type cb_1 from commandbutton within w_invoice_register
int X=1829
int Y=96
int Width=987
int Height=1056
int TabOrder=20
boolean Visible=false
boolean Enabled=false
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_5 from commandbutton within w_invoice_register
int X=110
int Y=1024
int Width=146
int Height=96
int TabOrder=100
boolean Visible=false
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;cb_5.Visible = False
dw_4.Visible = False
cb_6.Visible = False
cb_3.Visible = False

end on

type dw_4 from datawindow within w_invoice_register
int X=69
int Y=120
int Width=1733
int Height=896
int TabOrder=80
boolean Visible=false
string DataObject="d_account_code_totals"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type cb_6 from commandbutton within w_invoice_register
int X=46
int Y=96
int Width=1769
int Height=1056
int TabOrder=10
boolean Visible=false
boolean Enabled=false
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_3 from datawindow within w_invoice_register
int X=1618
int Y=1440
int Width=1161
int Height=352
int TabOrder=70
boolean Visible=false
string DataObject="d_shipper_detail_with_account"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_invoice_register
int X=18
int Y=1440
int Width=1477
int Height=352
int TabOrder=60
boolean Visible=false
string DataObject="d_shippers_within_range"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_2 from statictext within w_invoice_register
int X=841
int Y=1312
int Width=146
int Height=96
boolean Enabled=false
string Text="To"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_2 from editmask within w_invoice_register
int X=1024
int Y=1312
int Width=293
int Height=80
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_invoice_register
int X=37
int Y=1312
int Width=439
int Height=96
boolean Enabled=false
string Text="Date Range:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_invoice_register
int X=512
int Y=1312
int Width=293
int Height=80
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_invoice_register
int X=37
int Y=40
int Width=2816
int Height=1248
string DataObject="d_invoice_register"
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean LiveScroll=true
end type


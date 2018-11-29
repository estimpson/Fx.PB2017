$PBExportHeader$w_invoice_platinum.srw
forward
global type w_invoice_platinum from Window
end type
type dw_detail from datawindow within w_invoice_platinum
end type
type dw_header from datawindow within w_invoice_platinum
end type
end forward

global type w_invoice_platinum from Window
int X=357
int Y=725
int Width=2967
int Height=901
boolean TitleBar=true
string Title="Monitor's AP Invoicing Screen"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_save pbm_custom01
event ue_cancel pbm_custom02
dw_detail dw_detail
dw_header dw_header
end type
global w_invoice_platinum w_invoice_platinum

on ue_save;LONG			l_Row
STRING		s_DocControlNumber
DataWindow	dw_Hist

// Check for required data
dw_header.AcceptText ( )
dw_detail.AcceptText ( )
s_DocControlNumber = dw_header.GetItemString ( 1, 'doc_ctrl_num' )
l_Row = 1

DO WHILE l_Row <= dw_Detail.RowCount ( )
	IF IsNull ( dw_Detail.GetItemString ( l_Row, 'gl_exp_acct' ) ) THEN
		dw_Detail.DeleteRow ( l_Row )
	ELSE
		dw_Detail.SetItem ( l_Row, 'sequence_id', dw_Detail.GetItemNumber ( l_Row, 'row_number' ) )
		l_Row ++
	END IF
LOOP
IF ( NOT ( s_DocControlNumber > '' ) ) OR ( NOT ( dw_Detail.RowCount ( ) > 0 ) ) THEN
	MessageBox ( 'Error', 'Missing Data!' )
	Return
END IF

// Write to exp tables
IF dw_header.Update ( ) = -1 THEN
	MessageBox ( 'Error', 'Unable to save header!' )
	Return
END IF
IF dw_detail.Update ( ) = -1 THEN
	MessageBox ( 'Error', 'Unable to save detail!' )
	Return
END IF

// Write back to history table
dw_Hist = w_account_payable_interface.dw_history
l_Row = 0

DO WHILE dw_Hist.GetSelectedRow ( l_Row ) > 0
	l_Row = dw_Hist.GetSelectedRow ( l_Row )
	dw_Hist.SetItem ( l_Row, 'invoice_number', s_DocControlNumber )
	dw_Hist.Update ( )
LOOP

// exit
Close ( This )
end on

on ue_cancel;// Exit
Close ( This )
end on

on activate;gnv_App.of_GetFrame().ChangeMenu ( m_invoice_platinum )
end on

on resize;This.Resize ( 2943, 1548 )
end on

on open;DATAWINDOW	dw_Hist
LONG			l_Row, &
				l_NumOfRows, &
				l_PONumber, &
				l_NewRow
STRING		s_VendorCode, &
				s_TermsCode, &
				s_PartNo, &
				s_PrevPartNo, &
				s_GLAccountCode, &
				s_PartDescription, &
				s_TrxCtrlNum, &
				s_PONumber
DOUBLE		dbl_TotQuantity, &
				dbl_Quantity, &
				dbl_Price, &
				dbl_PricePerUnit

Randomize ( 0 )
s_TrxCtrlNum = 'NYA' + String ( Rand ( 32767 ) )
// Get available header data.

l_Row = w_account_payable_interface.dw_vendors.GetSelectedRow ( 0 )
s_VendorCode = w_account_payable_interface.dw_vendors.GetItemString ( l_Row, 'code' )

  SELECT "vendor"."terms"  
    INTO :s_TermsCode  
    FROM "vendor"  
   WHERE "vendor"."code" = :s_VendorCode   ;

dw_header.SetItem ( 1, 'trx_ctrl_num', s_TrxCtrlNum )
dw_header.SetItem ( 1, 'trx_type', 4091 )
dw_header.SetItem ( 1, 'vendor_code', s_VendorCode )
dw_header.SetItem ( 1, 'terms_code', s_TermsCode )

//	Get available detail data.

dw_Hist = w_account_payable_interface.dw_history
l_NumOfRows = dw_Hist.RowCount ( )
l_Row = 0
l_NewRow = 1
s_PrevPartNo = ''

DO WHILE dw_Hist.GetSelectedRow ( l_Row ) > 0
	l_Row = dw_Hist.GetSelectedRow ( l_Row )
	s_PartNo = dw_Hist.GetItemString ( l_Row, 'part' )
	IF s_PartNo = s_PrevPartNo OR s_PrevPartNo = '' THEN
		dbl_Quantity = dw_Hist.GetItemNumber ( l_Row, 'quantity' )
		dbl_TotQuantity += dbl_Quantity
		s_PONumber = dw_Hist.GetItemString ( l_Row, 'po_number' )
		l_PONumber = Long ( s_PONumber )
	ELSE

		  SELECT "po_detail"."price"  
		    INTO :dbl_PricePerUnit  
		    FROM "po_detail"  
		   WHERE ( "po_detail"."po_number" = :l_PONumber ) AND  
	 	        	( "po_detail"."part_number" = :s_PrevPartNo )   ;

		dbl_Price = dbl_TotQuantity * dbl_PricePerUnit
		dw_detail.SetItem ( l_NewRow, 'unit_price', dbl_Price )
		dw_detail.SetItem ( l_NewRow, 'po_ctrl_num', s_PONumber )

		  SELECT "part"."name",
					( SELECT	part_purchasing.gl_account_code
					    FROM	part_purchasing
					   WHERE	part_purchasing.part = part.part )
		    INTO :s_PartDescription,
					:s_GLAccountCode  
			 FROM "part"  
		   WHERE ( "part"."part" = :s_PrevPartNo )   ;

		dw_detail.SetItem ( l_NewRow, 'trx_ctrl_num', s_TrxCtrlNum )
		dw_detail.SetItem ( l_NewRow, 'gl_exp_acct', s_GLAccountCode )
		dw_detail.SetItem ( l_NewRow, 'line_description', s_PartDescription )
		dw_detail.SetItem ( l_NewRow, 'trx_type', 4091 )
		l_NewRow = dw_detail.InsertRow ( 0 )
		s_PONumber = dw_Hist.GetItemString ( l_Row, 'po_number' )
		l_PONumber = Long ( s_PONumber )
		dbl_TotQuantity = 0
		dbl_PricePerUnit = 0
		dbl_Quantity = dw_Hist.GetItemNumber ( l_Row, 'quantity' )
		dbl_TotQuantity += dbl_Quantity
	END IF
	s_PrevPartNo = s_PartNo
LOOP

  SELECT "po_detail"."price"  
    INTO :dbl_PricePerUnit  
    FROM "po_detail"  
   WHERE ( "po_detail"."po_number" = :l_PONumber ) AND  
        	( "po_detail"."part_number" = :s_PrevPartNo )   ;

dbl_Price = dbl_TotQuantity * dbl_PricePerUnit
dw_detail.SetItem ( l_NewRow, 'unit_price', dbl_Price )
dw_detail.SetItem ( l_NewRow, 'po_ctrl_num', s_PONumber )

  SELECT "part"."name",
			( SELECT	part_purchasing.gl_account_code
			    FROM	part_purchasing
			   WHERE	part_purchasing.part = part.part )
    INTO :s_PartDescription,
			:s_GLAccountCode  
	 FROM "part"  
   WHERE ( "part"."part" = :s_PrevPartNo )   ;

dw_detail.SetItem ( l_NewRow, 'trx_ctrl_num', s_TrxCtrlNum )
dw_detail.SetItem ( l_NewRow, 'gl_exp_acct', s_GLAccountCode )
dw_detail.SetItem ( l_NewRow, 'line_description', s_PartDescription )
dw_detail.SetItem ( l_NewRow, 'trx_type', 4091 )
dw_detail.InsertRow ( 0 )
end on

on w_invoice_platinum.create
this.dw_detail=create dw_detail
this.dw_header=create dw_header
this.Control[]={ this.dw_detail,&
this.dw_header}
end on

on w_invoice_platinum.destroy
destroy(this.dw_detail)
destroy(this.dw_header)
end on

type dw_detail from datawindow within w_invoice_platinum
int X=23
int Y=461
int Width=2881
int Height=309
int TabOrder=20
string DataObject="d_export_detail"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on editchanged;LONG	l_Row

l_Row = GetRow ( )
IF l_Row = RowCount ( ) THEN
	InsertRow ( 0 )
END IF
end on

on constructor;SetTrans ( SQLCA )
InsertRow ( 0 )
end on

type dw_header from datawindow within w_invoice_platinum
int X=23
int Y=29
int Width=2881
int Height=401
int TabOrder=10
string DataObject="d_export_header"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on editchanged;DATE		d_Date
LONG		l_Date

STRING	s_ColumnName

s_ColumnName = GetColumnName ( )

CHOOSE CASE s_ColumnName
CASE 'date_applied_d'
	AcceptText ( )
	d_Date = GetItemDate ( 1, 'date_applied_d' )
	l_Date = DaysAfter ( 1000-01-01, d_Date ) + 364878
	SetItem ( 1, 'date_applied_j', l_Date )
CASE 'date_doc_d'
	AcceptText ( )
	d_Date = GetItemDate ( 1, 'date_doc_d' )
	l_Date = DaysAfter ( 1000-01-01, d_Date ) + 364878
	SetItem  ( 1, 'date_doc_j', l_Date )
CASE ELSE
	d_Date = GetItemDate ( 1, 'date_applied_d' )
	l_Date = DaysAfter ( 1000-01-01, d_Date ) + 364878
	SetItem ( 1, 'date_applied_j', l_Date )
	d_Date = GetItemDate ( 1, 'date_doc_d' )
	l_Date = DaysAfter ( 1000-01-01, d_Date ) + 364878
	SetItem  ( 1, 'date_doc_j', l_Date )
END CHOOSE
end on

on constructor;DataWindowChild	dwc_Terms

GetChild ( 'terms_code', dwc_Terms )

dwc_Terms.SetTransObject(SQLCA)
dwc_Terms.Retrieve( )

SetTrans ( SQLCA )
InsertRow ( 0 )
end on


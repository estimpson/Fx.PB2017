$PBExportHeader$w_invoice_detail.srw
$PBExportComments$Invoice detail screen
forward
global type w_invoice_detail from w_sheet_4t
end type
type dw_dest from datawindow within w_invoice_detail
end type
type dw_4 from datawindow within w_invoice_detail
end type
type dw_salesrep from datawindow within w_invoice_detail
end type
type cb_5 from commandbutton within w_invoice_detail
end type
type dw_6 from datawindow within w_invoice_detail
end type
type lb_um from listbox within w_invoice_detail
end type
type p_3 from picture within w_invoice_detail
end type
type p_2 from picture within w_invoice_detail
end type
type p_1 from picture within w_invoice_detail
end type
type st_5 from statictext within w_invoice_detail
end type
type st_4 from statictext within w_invoice_detail
end type
type st_3 from statictext within w_invoice_detail
end type
type dw_3 from datawindow within w_invoice_detail
end type
type dw_7 from datawindow within w_invoice_detail
end type
type cb_3 from commandbutton within w_invoice_detail
end type
type dw_5 from datawindow within w_invoice_detail
end type
type st_2 from statictext within w_invoice_detail
end type
type st_6 from statictext within w_invoice_detail
end type
type st_1 from statictext within w_invoice_detail
end type
type cb_2 from commandbutton within w_invoice_detail
end type
type cb_4 from commandbutton within w_invoice_detail
end type
type cb_1 from commandbutton within w_invoice_detail
end type
type dw_1 from datawindow within w_invoice_detail
end type
type dw_2 from datawindow within w_invoice_detail
end type
end forward

global type w_invoice_detail from w_sheet_4t
string title = "Invoice Detail"
string menuname = "m_invoice_detail"
long backcolor = 77633680
event add_item pbm_custom01
event save_invoice_detail pbm_custom02
event delete_invoice_detail pbm_custom03
event edit_notes pbm_custom04
event save_invoice pbm_custom05
event show_header_notes pbm_custom06
dw_dest dw_dest
dw_4 dw_4
dw_salesrep dw_salesrep
cb_5 cb_5
dw_6 dw_6
lb_um lb_um
p_3 p_3
p_2 p_2
p_1 p_1
st_5 st_5
st_4 st_4
st_3 st_3
dw_3 dw_3
dw_7 dw_7
cb_3 cb_3
dw_5 dw_5
st_2 st_2
st_6 st_6
st_1 st_1
cb_2 cb_2
cb_4 cb_4
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_invoice_detail w_invoice_detail

type variables
Long lInvoiceNumber
Long lShipper
Long lDetailRow
Long lPreviousColumn

st_generic_structure stParm

Boolean bChangeUM, &
             bitemchanged = False, &
             bitemchanged_detail = False, &
             bitemchanged_notes = False,&	
	ib_AddingItem = FALSE

DataWindowChild dwcUnit

String  szColumnname,x_szpart1,szcolumn, ls_unit
dec      ldec_unit_weight, &
           ldec_std_pack, & 
           ldec_weight
end variables

forward prototypes
public subroutine wf_build_detail ()
public subroutine wf_disable_screen ()
public subroutine wf_enable_screen ()
public subroutine wf_hide_add_item ()
public subroutine wf_show_add_item ()
public subroutine wf_save_detail_item ()
public subroutine wf_hide_notes ()
public subroutine wf_show_existing_item ()
public subroutine wf_show_notes (string ctype)
public function boolean wf_create_manual_header ()
public function string wf_get_salesrep (long ishipper, string szpart)
public function string wf_get_alternative_unit (long ishipper, string szpart)
public subroutine wf_create_ddlb_salesrep ()
public subroutine wf_create_um_dropdown (string szpart)
public function datetime wf_get_date_shipped (long ishipper)
end prototypes

event add_item;String	ls_InvoiceAdd

If stParm.Value1 = "ManualInvoice" And stParm.Value2 = "" Then Return

  SELECT parameters.invoice_add  
    INTO :ls_InvoiceAdd  
    FROM parameters  ;

If ls_InvoiceAdd = 'Y'  Then

	wf_show_add_item ( )

Else

	MessageBox ( "Error", "You do not have permission to add items to this invoice!", StopSign! )

End if

end event

event save_invoice_detail;If stParm.Value1 = "ManualInvoice" And stParm.Value2 = "" Then
	wf_create_manual_header ( )
	Return
End if

/*  Declare Variables  */

Long lRow

String cType
String szPart

Dec dUnitPrice
Dec dQuantityShipped


/*  Initialize Variables  */


/*  Main  */

For lRow = 1 to dw_4.RowCount ( )

	szPart     = f_get_string_value ( dw_4.GetItemString ( lRow, "supplier_part_number" ) )	
	cType      = f_get_string_value ( dw_4.GetItemString ( lRow, "type" ) )
	dUnitPrice = f_get_value ( dw_4.GetItemNumber ( lRow, "unit_price" ) )
	dQuantityShipped = f_get_value ( dw_4.GetItemNumber ( lRow, "quantity_shipped" ) )

	If cType = 'I' Then

	   UPDATE shipper_detail  
	      SET qty_packed = :dQuantityShipped,   
	          qty_required = :dQuantityShipped,   
	          qty_original = :dQuantityShipped,   
	          accum_shipped = :dQuantityShipped,   
	          alternate_price = :dUnitPrice
     WHERE ( shipper = :lShipper ) AND  
          ( part = :szPart )   ;

	Else

	 	UPDATE shipper_detail  
	      SET alternate_price = :dUnitPrice
	    WHERE ( shipper = :lShipper ) AND  
          ( part = :szPart )   ;

	End if	

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		Return
	Else
		//	Included on 1/22/02
		// 	if payment have been received against this invoice in empower, 
		//	then the invoice won't be re-imported
		update	shipper
		set	posted='N'
		where	id = :lshipper;
		
		If SQLCA.SQLCode = -1 Then
			RollBack ;
			Return
		Else
			Commit ;
			bitemchanged = False
		End if
	End if
		
Next

wf_build_detail ( )
end event

on delete_invoice_detail;If stParm.Value1 = "ManualInvoice" And stParm.Value2 = "" Then Return

/*  Declare Variables  */

String szPart
String cType

Int iRtnCode


/*  Initialize Variables */


/*  Main  */

If lDetailRow < 1 Or lDetailRow > dw_2.RowCount ( ) Then Return

cType = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "type" ) )

If cType <> 'I' Then Return

szPart = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "supplier_part_number" ) )

iRtnCode = MessageBox ( "Delete", "Are you sure you want ~r" + &
							  "to delete part - " + szPart + "?", Question!, YesNo!, 2 )

If iRtnCode = 1 Then

  DELETE FROM shipper_detail  
   WHERE ( shipper = :lShipper ) AND  
         ( part = :szPart )   ;

End if

wf_build_detail ( )
end on

event edit_notes;wf_show_notes ( "detail" )
end event

event save_invoice;//	Declare Variables
Long	lRow
Long	lInvoice
String	szPart
String	cType
String	szTerms
String	szCrossRef
String	szPlant
String	szShipvia
string	ls_currency
string	ls_cust
string	ls_csstatus
Dec	dUnitPrice
Dec	dQuantityShipped
Dec	dFreightAmount
Dec	dTaxRate
Dec	dSalesTax

if dw_1.rowcount() < 1 then Return

//	Initialize Variables
If dw_1.AcceptText ( ) <> 1 Then Return

If stParm.Value1 = "ManualInvoice" And stParm.Value2 = "" Then
	If dw_6.GetItemString (1,1) = '' OR IsNull (dw_6.GetItemstring ( 1,1)) Then
		MessageBox ( "Warning",  "Please Select a destination" )
		dw_6.SetFocus()
		Return
	End If
	if sqlca.of_getnextparmvalue ( "next_invoice", lInvoice ) then
		dw_1.SetItem ( 1, "invoice_number", lInvoice )
	else
		rollback;
		return
	end if
	if sqlca.of_getnextparmvalue ( "shipper", lShipper ) then
		dw_1.SetItem ( 1, "id", lShipper )
	else
		rollback;
		return
	end if
	ls_cust	       = f_get_string_value (dw_1.getitemstring(1,'customer'))
	
	select	cs_status
	into	:ls_csstatus
	from	customer
	where	customer = :ls_cust;
	
	dw_1.SetItem ( 1, "shipper_invoice_printed", 'N' )
	dw_1.SetItem ( 1, "shipper_status", 'C' )
	dw_1.SetItem ( 1, "shipper_cs_status", ls_csstatus )
	dw_1.SetItem ( 1, "type", 'M' )
	dw_1.AcceptText ( )
	dw_1.SetItem ( 1, "ship_via", dw_1.GetItemString ( 1, "ship_via" ) )

	If dw_1.Update ( ) = -1 Then
		RollBack ;
	Else
		Commit ;
		bitemchanged = False
		stParm.Value2 = String ( lInvoice )
		linvoicenumber = lInvoice		
		dw_6.Visible = False
	End if
	Return
End if

If stParm.Value1 = "ManualInvoice" Then
	If dw_1.Update ( ) = -1 Then
		RollBack ;
		Return
	Else
		Commit ;	
	End if
End if

dw_2.AcceptText ( )

/*  Reset the header info and save it to the shipper file  */

dFreightAmount = f_get_value ( dw_1.GetItemNumber ( 1, "freight_charge" ) )
szTerms        = f_get_string_value ( dw_1.GetItemString ( 1, "terms" ) )
dTaxRate       = f_get_value ( dw_1.GetItemNumber ( 1, "tax_rate" ) )
szPlant	       = f_get_string_value ( dw_1.GetItemString ( 1, "plant" ) )
szShipvia      = f_get_string_value ( dw_1.GetItemString ( 1, "ship_via" ) )
ls_currency    = isnull ( dw_1.GetItemString ( 1, "currency_unit" ), '' )
ls_cust	       = f_get_string_value (dw_1.getitemstring(1,'customer'))

select	cs_status
into	:ls_csstatus
from	customer
where	customer = :ls_cust;

UPDATE shipper  
   SET freight = :dFreightAmount,  
		 terms = :szTerms,
		 tax_rate = :dTaxRate,
		 ship_via = :szShipVia,
		 plant    = :szPlant,
		 currency_unit = :ls_currency,
		 posted = 'N',
		 cs_status = :ls_csstatus
 WHERE id = :lShipper   ;

If SQLCA.SQLCode = -1 Then
	RollBack ;
	MessageBox ( "Error", SQLCA.SQLErrText, StopSign! )
	Return
Else
	Commit ;
	bitemchanged = False
End if

if dw_1.rowcount() > 1 then wf_build_detail ( )

For lRow = 1 to dw_2.RowCount ( )

	szPart     = f_get_string_value ( dw_2.GetItemString ( lRow, "supplier_part_number" ) )	
	cType      = f_get_string_value ( dw_2.GetItemString ( lRow, "type" ) )
	dUnitPrice = f_get_value ( dw_2.GetItemNumber ( lRow, "unit_price" ) )
	dQuantityShipped = f_get_value ( dw_2.GetItemNumber ( lRow, "quantity_shipped" ) )
	szCrossRef = f_get_string_value ( dw_2.GetItemString ( lRow, "customer_part_number" ) )

	If cType = 'I' Then

	   UPDATE shipper_detail  
	      SET qty_packed = :dQuantityShipped,   
	          qty_required = :dQuantityShipped,   
	          qty_original = :dQuantityShipped,   
	          accum_shipper = :dQuantityShipped,   
	          alternate_price = :dUnitPrice,
				 customer_part = :szCrossRef,
             part_original = :szPart
	    WHERE ( shipper = :lShipper ) AND  
	          ( part = :szPart )   ;

	Else

	 	UPDATE shipper_detail  
	      SET alternate_price = :dUnitPrice  
	    WHERE ( shipper = :lShipper ) AND  
	          ( part = :szPart )   ;

	End if	

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		Return
	Else
		//	Included on 1/22/02
		// 	if payment have been received against this invoice in empower, 
		//	then the invoice won't be re-imported
		update	shipper
		set	posted='N'
		where	id = :lshipper;
		
		If SQLCA.SQLCode = -1 Then
			RollBack ;
			Return
		Else
			Commit ;
			bitemchanged = False
		End if
	End if
		
Next
dw_1.Retrieve ( lInvoiceNumber )

if dw_1.rowcount() > 1 then wf_build_detail ( )
end event

on show_header_notes;wf_show_notes ( "header" )
end on

public subroutine wf_build_detail ();/*  Declare Variables  */

String szCustomerPart
String szInternalPart
String szUnit
String cPriceUnit
String cType
String szDestination
String szCustomer
String cTaxable
String szNotes
String szAccountCode
string ls_shipper_detail_part
string l_s_description
string	ls_customer_po
string	ls_selectedpart

Dec    dQtyShipped
Dec	 dqtyactual
Dec    dUnitPrice
Dec    dDetailAmount
Dec    dFreight
Dec    dSalesTax
Dec    dSalesTaxRate
Dec    dInvoiceTotal
Dec    dQty
Dec    dTaxRate
Dec    dTotalTax
Dec    dgrsweight

Long   lRow
Long   lNewRow
Long   lOrderNumber
long		ll_row

// getting the field name from the parameter table
SELECT parameters.inv_reg_col  
  INTO :szcolumnname  
  FROM parameters  ;

dw_3.SetTransObject ( sqlca )
if lDetailRow > 0 then
	if dw_2.IsSelected ( lDetailRow ) then
		ls_selectedpart = dw_2.GetItemString ( lDetailRow, "shipper_detail_part" )
	end if
end if

dw_2.Reset ( )


/*  Initialize Variables  */

dw_3.Reset ( )
dw_3.Retrieve ( lShipper )

szDestination = f_get_string_value ( dw_1.GetItemString ( 1, "destination" ) )
szCustomer    = f_get_string_value ( dw_1.GetItemString ( 1, "customer" ) )

dw_dest.retrieve(szcustomer)

dTaxRate = f_get_value ( dw_1.GetItemDecimal ( 1, "tax_rate" ) / 100 )

/*  Main   */

For lRow = 1 to dw_3.RowCount ( )

	szInternalPart    = f_get_string_value ( dw_3.GetItemString ( lRow, "part_original" ) )
	cType             = f_get_string_value ( dw_3.GetItemString ( lRow, "shipper_detail_type" ) )
	szNotes           = f_get_string_value ( dw_3.GetItemString ( lRow, "shipper_detail_note" ) )
	szAccountCode     = f_get_string_value ( dw_3.GetItemString ( lRow, "account_code" ) )
	cTaxable          = f_get_string_value ( dw_3.GetItemString ( lRow, "taxable" ) )
	ls_shipper_detail_part = f_get_string_value ( dw_3.GetItemString ( lRow, "part" ) )
	l_s_description	= f_get_string_value ( dw_3.GetItemString ( lRow, "part_name" ) )

	dUnitPrice        = f_get_value ( dw_3.GetITemDecimal ( lRow, "price" ) )

   dQtyactual			= f_get_value( dw_3.GetItemDecimal( lRow, "shipper_detail_alternative_qty"))

   dgrsweight			= f_get_value( dw_3.GetItemDecimal( lRow, "shipper_detail_gross_weight"))

	ls_customer_po	= f_get_string_value ( dw_3.GetItemString ( lRow, "shipper_detail_customer_po" ) )
	
// included on 01/24/96 by gph

   if upper(szColumnname) = "GROSS_WEIGHT" then
		dQtyShipped			= f_get_value( dw_3.GetItemDecimal( lRow, "shipper_detail_gross_weight"))
   else     
		dQtyShipped			= f_get_value( dw_3.GetItemDecimal( lRow, "shipper_detail_alternative_qty"))
   end if
// till here 

	dFreight          = f_get_value ( dw_3.GetItemDecimal ( lRow, "shipper_freight" ) )

	lOrderNumber      = f_get_value ( dw_3.GetItemNumber ( lRow, "order_no" ) )

	szCustomerPart    = f_get_string_value ( dw_3.GetItemString ( lRow, "shipper_detail_customer_part" ) )

 	szUnit 	= f_get_string_value ( dw_3.GetItemString( lRow, "shipper_detail_alternative_unit") )

	If szUnit	= "" then
	   SELECT order_header.price_unit  
   	  INTO :cPriceUnit  
	     FROM order_header  
	    WHERE order_header.order_no = :lOrderNumber   ;
	End If

	If SQLCA.SQLCode <> 0 Then &
		cPriceUnit = 'P'

	cPriceUnit = f_get_string_value ( cPriceUnit )

	If cPriceUnit = 'L' Then

		dQty = 1
		
	Elseif cPriceUnit = 'T' Then

		dQty = Int ( dQtyShipped / 1000 )

	Else

		dQty = dQtyShipped

	End if

	lNewRow = dw_2.RowCount ( ) + 1
	dw_2.InsertRow ( 0 )

	dw_2.SetItem ( lNewRow, "quantity_shipped", dQtyactual )
	dw_2.SetItem ( lNewRow, "calc_type", lower ( szColumnName ) )
	dw_2.SetItem ( lNewRow, "shipper_detail_gross_weight", dgrsweight)
	dw_2.SetItem ( lNewRow, "customer_part_number", szCustomerPart )
	dw_2.SetItem ( lNewRow, "supplier_part_number", szInternalPart )
	dw_2.SetItem ( lNewRow, "unit_price", dUnitPrice )
	dw_2.SetItem ( lNewRow, "unit", szUnit )
	dw_2.SetItem ( lNewRow, "type", cType )
	dw_2.SetItem ( lNewRow, "note", szNotes )
	dw_2.SetItem ( lNewRow, "tax", cTaxable )
	dw_2.SetItem ( lNewRow, "account_code", szAccountCode )
	dw_2.SetItem ( lNewRow, "shipper_detail_part", ls_shipper_detail_part )	
	dw_2.SetItem ( lNewRow, "part_description", l_s_description )
	dw_2.SetItem ( lNewRow, "customer_po", ls_customer_po )
	dw_2.SetItem ( lNewRow, "freight", dFreight )
	dw_2.SetItem ( lNewRow, "tax_amount", dTaxRate )
Next

//dw_2.SetItem ( lNewRow, "freight", dFreight )
//dw_2.SetItem ( lNewRow, "tax_amount", dTaxRate )

if ls_selectedpart > '' then
	dw_2.SetSort ( "shipper_detail_part A" )
	dw_2.Sort ( )
	ll_row = dw_2.Find ( "shipper_detail_part = '" + ls_selectedpart + "'", 1, dw_2.RowCount ( ) )
	if ll_row > 0 then
		dw_2.ScrollToRow ( ll_row )
		dw_2.SelectRow ( ll_row, TRUE )
	end if
	dw_2.SetSort ( "" )
	dw_2.Sort ( )
end if

end subroutine

public subroutine wf_disable_screen ();cb_2.Visible = False
cb_3.Visible = False

dw_4.Visible = False

st_1.Visible = False

cb_1.Visible = False
end subroutine

public subroutine wf_enable_screen ();cb_2.Visible = True
cb_3.Visible = True

dw_4.Visible = True

st_1.Visible = True

cb_1.Visible = True
end subroutine

public subroutine wf_hide_add_item ();cb_2.Visible = False
cb_3.Visible = False

dw_4.Visible = False

st_1.Visible = False
st_6.Visible = False

cb_1.Visible = False

dw_1.Enabled = True
dw_2.Enabled = True

end subroutine

public subroutine wf_show_add_item ();DataWindowChild dwcParts
DataWindowChild dwcSalesRep
//DataWindowChild dwcUnit
Integer 	iCount
String	szUM
string	ls_symbol

lPreviousColumn = 0

cb_1.Visible = True

st_1.Visible = True

dw_4.getchild ( "supplier_part_number", dwcParts )
dwcParts.SetTransObject ( sqlca )
dwcParts.Retrieve ( )

dw_4.getchild ( "sales_rep", dwcSalesRep )

dwcSalesRep.SetTransObject ( sqlca )
dwcSalesRep.Retrieve ( )

dw_4.getchild ( "unit_measure", dwcUnit )
dwcUnit.SetTransObject ( sqlca )
dwcUnit.Reset ( )

dw_4.Visible = True

dw_4.Reset()
dw_4.InsertRow ( 1 )

sqlca.of_get_currency_display_symbol ( dw_1.GetItemString ( 1, "currency_unit" ), ls_symbol )
dw_4.SetItem ( 1, "currency_display_symbol", ls_symbol )

cb_2.BringToTop			= True
cb_3.BringToTop			= True


lb_um.reset()
lb_um = f_get_units_for_part("", dw_4.GetItemString ( 1, "supplier_part_number" ), &
							lb_um)

For iCount	= 1 to lb_um.TotalItems()
	lb_um.SelectItem(iCount)
	szUM	= lb_um.SelectedItem()
	If szUM = "" Then szUM = "EA"
	dwcUnit.InsertRow ( 1 )
	dwcUnit.SetItem ( 1, "unit", szUM )
Next

If dwcUnit.RowCount ( ) < 1 Then 
	dwcUnit.InsertRow ( 1 )
	dwcUnit.SetItem ( 1, "unit", 'EA' )
	dw_4.SetItem ( 1, "unit_measure", 'EA' )
End if

ib_addingitem = TRUE

cb_2.Visible = True
cb_3.Visible = True
dw_1.Enabled = False
dw_2.Enabled = False
dw_4.SetTabOrder ( "supplier_part_number", 10 )
dw_4.SetTabOrder ( "quantity_shipped", 30 )
dw_4.modify ( "supplier_part_number.Color = " + String ( f_get_color_value ( "black" ) ) )
dw_4.modify ( "quantity_shipped.Color = " + String ( f_get_color_value ( "black" ) ) )
dw_4.SetColumn ( "supplier_part_number" )
dw_4.SetFocus ( )

end subroutine

public subroutine wf_save_detail_item ();/*  Declare Variables  */

String szPart
String szCustomerPart
String szAccountCode
String cTaxable
String szSalesrep
String szAlternativeUnit
String ls_Name
String szPartPlus
string ls_message
string ls_customer_po

Dec dQtyShipped
Dec dUnitPrice
Dec dAmount
Dec dgrsweight
int	li_count
Datetime dDate

Long lTemp

/*  Initialize Variables  */

dw_4.AcceptText ( )

dQtyShipped    = f_get_value ( dw_4.GetItemDecimal ( 1, "quantity_shipped" ) )
szPart         = f_get_string_value ( dw_4.GetItemString ( 1, "supplier_part_number" ) )
szCustomerPart = f_get_string_value ( dw_4.GetItemString ( 1, "customer_part_number" ) )
szAccountCode  = f_get_string_value ( dw_4.GetItemString ( 1, "account_code" ) )
dUnitPrice     = f_get_value ( dw_4.GetItemDecimal ( 1, "unit_price" ) )
cTaxable       = f_get_string_value ( dw_4.GetItemString ( 1, "taxable" ) )
dDate          = wf_get_date_shipped(lShipper)
szSalesrep		= f_get_string_value ( dw_4.GetItemString ( 1, "sales_rep" ) )
szAlternativeUnit	= f_get_string_value ( dw_4.GetItemString ( 1, "unit_measure" ) )
dgrsweight     = f_get_value ( dw_4.GetItemDecimal ( 1, "shipper_detail_gross_weight" ) )
ls_name			= f_get_string_value ( dw_4.GetITemString ( 1, "part_description" ) )
szPartPlus	= f_get_string_value ( dw_4.GetItemString ( 1, "shipper_detail_part" ) )
ls_customer_po = f_get_string_value ( dw_4.GetItemString ( 1, "customer_po" ) )

if ls_name = "" then

	SELECT	part.name  
	INTO	:ls_Name  
	FROM	part  
	WHERE	part.part = :szPart   ;

end if

SELECT	shipper_detail.shipper  
INTO	:lTemp  
FROM	shipper_detail  
WHERE	( shipper_detail.shipper = :lShipper ) AND  
	( shipper_detail.part = :szPart )   ;

If ib_addingitem or SQLCA.SQLCode <> 0 Then

	if ib_addingitem and sqlca.sqlcode = 0 then
		SELECT	count ( shipper_detail.shipper )
		INTO	:li_count  
		FROM	shipper_detail  
		WHERE	( shipper_detail.part_original = :szPart ) AND  
			( shipper_detail.shipper = :lshipper )   ;
		if f_get_value ( li_count ) > 0 then
			szPartPlus = szPart + String ( li_count + 1 )
		end if
	end if

	if ib_addingitem then 

		ib_addingitem = FALSE
	
		INSERT INTO shipper_detail  
			( shipper,   
			part,   

			qty_required,   
			qty_packed,   
			qty_original,   
			accum_shipped,   
			order_no,   
			customer_po,   
			release_no,   
			release_date,   
			type,   
			alternate_price,   
			account_code,   
			salesman,   
			tare_weight,   
			gross_weight,   
			net_weight,   
			date_shipped,   
			assigned,   
			packaging_job,   
			note,   
			operator,   
			boxes_staged,   
			pack_line_qty,
			alternative_qty,
			alternative_unit,
			taxable,
			customer_part,
			part_original,
			total_cost,
			part_name )  
		VALUES ( :lShipper,   
			:szPart,   
			:dQtyShipped,   
			:dQtyShipped,   
			:dQtyShipped,   
			:dQtyShipped,   
			0,   
			:ls_customer_po,   
			null,   
			null,   
			'I',   
			:dUnitPrice,   
			:szAccountCode,   
			:szSalesrep,   
			:dgrsweight,   
			:dgrsweight,   
			null,   
			:dDate,   
			null,   
			null,   
			null,   
			null,   
			null,   
			null,
			:dQtyShipped,
			:szAlternativeUnit,
			:cTaxable,
			:szCustomerPart,
			:szPart,
			0,
			:ls_Name )  ;
	Else
		ib_addingitem = FALSE
		
		UPDATE shipper_detail  
		SET	part = :szPartPlus,   
			qty_required = :dQtyShipped,   
			qty_packed = :dQtyShipped,   
			qty_original = :dQtyShipped,   
			account_code = :szAccountCode,
			alternate_price = :dUnitPrice,
			taxable = :cTaxable,
			alternative_qty = :dQtyShipped,
			alternative_unit = :szAlternativeUnit,
			customer_part = :szCustomerPart,
			salesman	= :szSalesrep,
			part_original	= :szPart,
			tare_weight  = :dgrsweight,
			gross_weight  = :dgrsweight,
			customer_po = :ls_customer_po
		WHERE	( shipper = :lShipper ) AND  
			( part = :szPartPlus )   ;
	end if 	
Else
	UPDATE shipper_detail  
	SET	part = :szPartPlus,   
		qty_required = :dQtyShipped,   
		qty_packed = :dQtyShipped,   
		qty_original = :dQtyShipped,   
		account_code = :szAccountCode,
		alternate_price = :dUnitPrice,
		taxable = :cTaxable,
		alternative_qty = :dQtyShipped,
		alternative_unit = :szAlternativeUnit,
		customer_part = :szCustomerPart,
		salesman	= :szSalesrep,
		part_original	= :szPart,
		tare_weight  = :dgrsweight,
		gross_weight  = :dgrsweight,
		customer_po = :ls_customer_po
	WHERE	( shipper = :lShipper ) AND  
		( part = :szPartPlus )   ;
End if

If SQLCA.SQLCode = -1 Then
	ls_message = SQLCA.SQLErrText
	RollBack;
	MessageBox ( "SQL Error", ls_message, StopSign! )
	Return
Else
	Commit ;
	bitemchanged_detail= False

End if
end subroutine

public subroutine wf_hide_notes ();cb_4.Visible = False
cb_5.Visible = False

dw_5.Visible = False

st_2.Visible = False

cb_1.Visible = False
end subroutine

public subroutine wf_show_existing_item ();/*  Declare Variables  */

String szOurPart
String szCustPart
String szAccountCode
String cType
String cTaxable
String szGreyed
String szPartColor
String szQtyColor
String szAlternativeUnit
String szUM
string ls_shipper_detail_part
string l_s_description
string	ls_symbol
string	ls_customer_po

Long   iCount

Dec    dUnitPrice
Dec    dQtyShipped
Dec    dgrsweight

DataWindowChild dwcParts
//DataWindowChild dwcUnit
DataWindowChild dwcSalesRep

/*  Initialize Variables  */

ib_addingitem = FALSE
dw_4.getchild ( "supplier_part_number", dwcParts )
dwcParts.SetTransObject ( sqlca )
dwcParts.Retrieve ( )

dw_4.getchild ( "sales_rep", dwcSalesRep )
dwcSalesRep.SetTransObject ( sqlca )
dwcSalesRep.Retrieve ( )

dw_4.getchild ( "unit_measure", dwcUnit )
dwcUnit.SetTransObject ( sqlca )
dwcUnit.Reset ( )

lPreviousColumn = 0

/*  Main  */

cb_1.Visible = True
cb_2.Visible = True
cb_3.Visible = True
st_6.Visible = True

dw_4.InsertRow ( 1 )

If lDetailRow > 0 Then
	dQtyShipped   = f_get_value ( dw_2.GetItemNumber ( lDetailRow, "quantity_shipped" ) )
	dUnitPrice    = f_get_value ( dw_2.GetItemNumber ( lDetailRow, "unit_price" ) )
	szAccountCode = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "account_code" ) )
	szOurPart     = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "supplier_part_number" ) )
	szCustPart    = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "customer_part_number" ) )
	cType         = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "type" ) )
	cTaxable      = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "tax" ) )
	szAlternativeUnit	= wf_get_alternative_unit(lShipper, szOurPart)
	dgrsweight    = f_get_value ( dw_2.GetItemNumber ( lDetailRow, "shipper_Detail_gross_weight" ))
	ls_shipper_detail_part = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "shipper_detail_part" ) )
	l_s_description	= f_get_string_value ( dw_2.GetItemString ( lDetailRow, "part_description" ) )
	ls_customer_po = f_get_string_value ( dw_2.GetItemString ( lDetailRow, "customer_po" ) )
End if

dw_4.SetItem ( 1, "customer_part_number", szCustPart )
dw_4.SetItem ( 1, "supplier_part_number", szOurPart )
dw_4.SetItem ( 1, "quantity_shipped", dQtyShipped )
dw_4.SetItem ( 1, "unit_price", dUnitPrice )
dw_4.SetItem ( 1, "account_code", szAccountCode )
dw_4.SetItem ( 1, "taxable", cTaxable )
dw_4.SetItem ( 1, "sales_rep", wf_get_salesrep(lShipper, szOurPart) )
dw_4.SetItem ( 1, "unit_measure", szAlternativeUnit )
dw_4.SetItem ( 1, "Shipper_detail_gross_weight", dgrsweight )
dw_4.SetItem ( 1, "shipper_detail_part", ls_shipper_detail_part )
dw_4.SetItem ( 1, "part_description", l_s_description )
dw_4.SetItem ( 1, "customer_po", ls_customer_po )

sqlca.of_get_currency_display_symbol ( dw_1.GetItemString ( 1, "currency_unit" ), ls_symbol )
dw_4.SetItem ( 1, "currency_display_symbol", ls_symbol )
lb_um.reset()
lb_um = f_get_units_for_part("", dw_4.GetItemString ( 1, "supplier_part_number" ), &
							lb_um)

For iCount	= 1 to lb_um.TotalItems()
	lb_um.SelectItem(iCount)
	szUM	= lb_um.SelectedItem()
	If szUM = "" Then szUM = "EA"
	dwcUnit.InsertRow ( 1 )
	dwcUnit.SetItem ( 1, "unit", szUM )
Next

If dwcUnit.RowCount ( ) < 1 Then 
	dwcUnit.InsertRow ( 1 )
	dwcUnit.SetItem ( 1, "unit", 'EA' )
	dw_4.SetItem ( 1, "unit_measure", 'EA' )
End if

If cType <> 'I' Then

	dw_4.SetTabOrder ( "supplier_part_number", 0 )
	dw_4.SetTabOrder ( "quantity_shipped", 0 )
	if szColumnName = "gross_weight" then
		dw_4.SetTabOrder ( "shipper_detail_gross_weight", 0 )
		dw_4.modify ( "shipper_detail_gross_weight.Color = " + String ( f_get_color_value ( "darkgray" ) ) )
	else
		dw_4.SetTabOrder ( "shipper_detail_gross_weight", 30 )
		dw_4.modify ( "shipper_detail_gross_weight.Color = " + String ( f_get_color_value ( "black" ) ) )
	end if
	dw_4.modify ( "supplier_part_number.Color = " + String ( f_get_color_value ( "darkgray" ) ) )
	dw_4.modify ( "quantity_shipped.Color = " + String ( f_get_color_value ( "darkgray" ) ) )

Else

	dw_4.SetTabOrder ( "supplier_part_number", 20 )
	dw_4.SetTabOrder ( "quantity_shipped", 10 )
	dw_4.SetTabOrder ( "shipper_detail_gross_weight", 30 )
	dw_4.modify ( "supplier_part_number.Color = " + String ( f_get_color_value ( "black" ) ) )
	dw_4.modify ( "quantity_shipped.Color = " + String ( f_get_color_value ( "black" ) ) )
	dw_4.modify ( "shipper_detail_gross_weight.Color = " + String ( f_get_color_value ( "black" ) ) )

End if


dw_4.Visible = True

cb_2.BringToTop			= True
cb_3.BringToTop			= True

dw_4.SetColumn ( "supplier_part_number" )
dw_4.SetFocus ( )


end subroutine

public subroutine wf_show_notes (string ctype);/*  Declare Variables  */

String szPart

If cType = "header" Then
	st_2.Text = "Invoice Header Notes"
	dw_5.DataObject = "d_shipper_header_notes"
	dw_5.SetTransObject ( sqlca )
	dw_5.Retrieve ( lShipper )
Elseif cType = "detail" Then
	If lDetailRow < 1 Then
		MessageBox ( monsys.msg_title, "You must select a detail item to continue." )
		Return
	end if
	st_2.Text = "Invoice Detail Notes"
	szPart = dw_2.GetItemString ( lDetailRow, "shipper_detail_part" )
	dw_5.DataObject = "d_invoice_detail_notes"
	dw_5.SetTransObject ( sqlca )
	dw_5.Retrieve ( lShipper, szPart )
End if


/*  Main  */

cb_1.Visible = True
cb_4.Visible = True
cb_5.Visible = True

dw_5.Visible = True

st_2.Visible = True

dw_5.Setfocus ( )
end subroutine

public function boolean wf_create_manual_header ();/*  Declare Variables  */

//Long lInvoiceNumber

/*  Initialize Variables  */

SELECT parameters.next_invoice, parameters.inv_reg_col  
  INTO :lInvoiceNumber, :szcolumnname  
  FROM parameters  ;

UPDATE parameters  
   SET next_invoice = :lInvoiceNumber + 1  ;

dw_1.SetItem ( 1, "invoice_number", lInvoiceNumber )

Return True
end function

public function string wf_get_salesrep (long ishipper, string szpart);String szSalesman

  SELECT shipper_detail.salesman  
    INTO :szSalesman  
    FROM shipper_detail  
   WHERE ( shipper_detail.shipper = :iShipper ) AND  
         ( shipper_detail.part = :szPart )   ;

Return szSalesman
end function

public function string wf_get_alternative_unit (long ishipper, string szpart);String szUnit

  SELECT shipper_detail.alternative_unit  
    INTO :szUnit
    FROM shipper_detail  
   WHERE ( shipper_detail.shipper = :iShipper ) AND  
         ( shipper_detail.part = :szPart )   ;


Return szUnit
end function

public subroutine wf_create_ddlb_salesrep ();DataWindowChild dwcSalesRep

dw_4.GetChild ( "sales_rep", dwcSalesRep )
dwcSalesRep.SetTransObject ( sqlca )
dwcSalesRep.Retrieve ( )

//Long iRow
//
//ddlb_salesrep.Reset()
//
//For iRow	= 1 to dw_salesrep.RowCount()
//	ddlb_salesrep.AddItem(dw_salesrep.GetItemString(iRow, "salesrep"))
//Next
end subroutine

public subroutine wf_create_um_dropdown (string szpart);Integer 	iCount
String	szUM

dw_4.GetChild ( "unit_measure", dwcUnit )
dwcUnit.SetTransObject ( sqlca )
dwcUnit.Reset ( )
lb_um.reset()
lb_um = f_get_units_for_part("", szPart, &
							lb_um)

For iCount	= 1 to lb_um.TotalItems()
	lb_um.SelectItem(iCount)
	szUM	= lb_um.SelectedItem()
	dwcUnit.InsertRow ( 1 )
	dwcUnit.SetItem ( 1, "unit", szUM )
Next

If dwcUnit.RowCount ( ) < 1 Then 
	dwcUnit.InsertRow ( 1 )
	dwcUnit.SetItem ( 1, "unit", 'EA' )
	dw_4.SetItem ( 1, "unit_measure", 'EA' )
End if
end subroutine

public function datetime wf_get_date_shipped (long ishipper);Datetime dDate

  SELECT shipper.date_shipped  
    INTO :dDate  
    FROM shipper  
   WHERE shipper.id = :iShipper   ;

Return dDate

end function

event open;call super::open;/*  Declare Variables  */

String szTerms
String szCustomer
String szDestination

dw_1.SetTransObject ( sqlca )
dw_salesrep.SetTransObject( sqlca )


/*  Initialize Variables  */

stParm = Message.PowerObjectParm


If stParm.Value1 = "ManualInvoice" Then

	dw_1.DataObject = "d_manual_invoice_header"
	dw_1.SetTransObject ( sqlca )
	If stParm.Value2 = "" Then
		dw_6.Show ( )
		dw_2.Enabled = False
		dw_1.InsertRow ( 1 )
		dw_1.SetItem ( 1, "date_stamp", Today ( ) )
		dw_1.SetItem ( 1, "date_shipped", Today ( ) )
	Else
		dw_1.Retrieve ( Long ( stParm.Value2 ) )
		lInvoiceNumber = Long ( stParm.Value2 )		
		If dw_1.RowCount ( ) < 1 Then 
			MessageBox ( "Error", "No row  " + stParm.Value2 )
			Return
		End if
		lShipper = dw_1.GetItemNumber ( 1, "id" )
		wf_build_detail ( )
	End if

Else

	lInvoiceNumber = Long ( stParm.Value1 )
 
	dw_1.Retrieve ( lInvoiceNumber )

	If dw_1.RowCount ( ) < 1 Then 
		MessageBox ( "monsys.msg_title", "Missing Data in Table Shipper!~rCheck for completeness", Information! )
		Close ( This )
		Return
	End if

	szTerms = f_get_string_value ( dw_1.GetItemString ( 1, "terms" ) )

	If szTerms = "" Then

		szCustomer = f_get_string_value ( dw_1.GetItemString ( 1, "customer" ) )
	
	   SELECT customer.terms  
	     INTO :szTerms  
	     FROM customer  
	    WHERE customer.customer = :szCustomer   ;
	
		szTerms = f_get_string_value ( szTerms )
	
		dw_1.SetItem ( 1, "terms", szTerms )

	End if

	lShipper = dw_1.GetItemNumber ( 1, "id" )
	
	wf_build_detail ( )

End if

dw_salesrep.Retrieve ( )
end event

event activate;call super::activate;
If stParm.Value1 = "ManualInvoice" And stParm.Value2 = "" Then

	dw_6.SetTransObject ( sqlca )
	dw_6.InsertRow ( 1 )	

End if	
end event

on w_invoice_detail.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_invoice_detail" then this.MenuID = create m_invoice_detail
this.dw_dest=create dw_dest
this.dw_4=create dw_4
this.dw_salesrep=create dw_salesrep
this.cb_5=create cb_5
this.dw_6=create dw_6
this.lb_um=create lb_um
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.dw_3=create dw_3
this.dw_7=create dw_7
this.cb_3=create cb_3
this.dw_5=create dw_5
this.st_2=create st_2
this.st_6=create st_6
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dest
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.dw_salesrep
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.dw_6
this.Control[iCurrent+6]=this.lb_um
this.Control[iCurrent+7]=this.p_3
this.Control[iCurrent+8]=this.p_2
this.Control[iCurrent+9]=this.p_1
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.dw_7
this.Control[iCurrent+15]=this.cb_3
this.Control[iCurrent+16]=this.dw_5
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.cb_2
this.Control[iCurrent+21]=this.cb_4
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.dw_1
this.Control[iCurrent+24]=this.dw_2
end on

on w_invoice_detail.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_dest)
destroy(this.dw_4)
destroy(this.dw_salesrep)
destroy(this.cb_5)
destroy(this.dw_6)
destroy(this.lb_um)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.dw_7)
destroy(this.cb_3)
destroy(this.dw_5)
destroy(this.st_2)
destroy(this.st_6)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event closequery;call super::closequery;Int iRtnCode

If bitemchanged OR bitemchanged_detail	OR bitemchanged_notes Then

	iRtnCode = messagebox( 'Warning', 'Do you want to save the changes?', Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

		Case 1

			If bitemchanged = True Then

				TriggerEvent( "save_invoice" )

			ElseIf bitemchanged_detail = True Then

				cb_2.TriggerEvent( clicked! )

			ElseIf bitemchanged_notes = True Then

				cb_4.TriggerEvent ( clicked! )

			End If

			if bitemchanged or bitemchanged_detail or bitemchanged_notes then
				return 1
			end if
		Case 2 

			if IsValid ( w_invoice_inquiry ) then
				w_invoice_inquiry.TriggerEvent ( "retrieve_again" )
			end if
  
		Case 3

			return 1

	End Choose

Else

	if IsValid ( w_invoice_inquiry ) then
		w_invoice_inquiry.TriggerEvent ( "retrieve_again" )
	end if
	
End If

return 0

end event

type dw_dest from datawindow within w_invoice_detail
integer x = 2912
integer y = 32
integer width = 617
integer height = 1420
integer taborder = 30
string dataobject = "d_dddw_destination_list_customerwise"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	int	li_bol
	string	ls_dest, ls_boldest, ls_type
	if dw_1.object.destination[1] <> object.destination[row] then
		ls_dest = object.destination[row]
		update	shipper
		set	destination = :ls_dest
		where	id = :lshipper;
		if sqlca.sqlcode = 0 then
			commit;
			dw_1.retrieve(linvoicenumber)
			select	isnull(bill_of_lading_number,0) 
			into	:li_bol
			from	shipper 
			where	id = :lshipper;
			
			if li_bol > 0 then 
				select	bol.destination,
					d.type
				into	:ls_boldest,
					:ls_type
				from	bill_of_lading bol
					join destination d on d.destination = bol.destination
				where	bol.bol_number = :li_bol;
				
				if isnull(ls_type,'R') = 'R' then 
					update	bill_of_lading
					set	destination = :ls_dest
					where	bol_number = :li_bol;
					
					if sqlca.sqlcode = 0 then 
						commit;
					else
						rollback;
					end if 	
				end if 	
			end if 	
				
		else
			rollback;
		end if 
	end if
end if 
end event

event constructor;settransobject(sqlca)

end event

type dw_4 from datawindow within w_invoice_detail
boolean visible = false
integer x = 731
integer y = 224
integer width = 1445
integer height = 880
integer taborder = 70
string dataobject = "d_external_invoice_detail_add"
boolean border = false
end type

event itemchanged;dec	ldec_qty_arg
dec {6}	ldec_price
dec	dqty

bitemchanged_detail = True

szcolumn = This.getcolumnname()

if szcolumn = 'supplier_part_number' then
	x_szpart1 = this.gettext()
	dw_4.Setitem (1, "shipper_detail_part", x_szPart1)
	dw_4.Setitem (1, "part_description", f_get_part_info(gettext(),'NAME'))
elseif szcolumn = 'quantity_shipped' then
	x_szpart1 = this.getitemstring(this.getrow(), "supplier_part_number") 
	dQty    = Dec ( This.GetText ( ) )
	ls_Unit	= This.GetItemString ( 1, "unit_measure" )
	dQty    = f_convert_units ( ls_Unit, "", x_szpart1, dQty )
	
	SELECT part_inventory.unit_weight  
	INTO   :ldec_unit_weight  
	FROM part_inventory  
	WHERE part_inventory.part = :x_szpart1 ;
    
	IF SQLCA.SQLCODE <> 0 THEN
		MESSAGEBOX("Error","Invalid part number!",StopSign!)
		This.setitem(1,"supplier_part_number"," ")
		bitemchanged_detail = True
		Return
	else
		ldec_weight = ( dQty * ldec_unit_weight )
		This.SetItem ( This.GetRow ( ), "shipper_detail_gross_weight", ldec_weight )
		
		if szColumnName = "alternative_qty" then
			ldec_qty_arg = dQty
		else
			ldec_qty_arg = ldec_weight
		end if
			
		ldec_price = f_calculate_customer_price ( x_szpart1, dw_1.GetItemString ( 1, "customer" ), ldec_qty_arg )
		sqlca.of_calculate_multicurrency_price ( '', dw_1.GetItemString ( 1, "currency_unit" ), &
		ldec_price, ldec_price )
		
		SetItem ( getrow(), "unit_price", ldec_price )
		
	end if 
elseif szColumn = "shipper_detail_gross_weight" then
	if GetItemNumber ( 1, "quantity_shipped" ) <= 0 then
		x_szpart1 = this.getitemstring(this.getrow(), "supplier_part_number") 
		ldec_weight = Dec ( This.GetText ( ) )
		SELECT part_inventory.unit_weight  
		INTO   :ldec_unit_weight  
		FROM   part_inventory  
		WHERE part_inventory.part = :x_szPart1 ;
		if sqlca.sqlcode <> 0 then
			 MESSAGEBOX("Error","Invalid part number!",StopSign!)
			 This.setitem(1,"supplier_part_number"," ")
			 bitemchanged_detail = True
			 Return
		else 
			dQty = ( ldec_weight / ldec_unit_weight )
			This.SetItem ( This.GetRow ( ), "quantity_shipped", dQty )
			if szColumnName = "alternative_qty" then
				ldec_qty_arg = dQty
			else
				ldec_qty_arg = ldec_weight
			end if
			ldec_price = f_calculate_customer_price ( x_szpart1, dw_1.GetItemString ( 1, "customer" ), ldec_qty_arg )
			sqlca.of_calculate_multicurrency_price ( '', dw_1.GetItemString ( 1, "currency_unit" ), &
				ldec_price, ldec_price )
			SetItem ( getrow(), "unit_price", ldec_price )
		end if  
	end if
END IF     

end event

event itemfocuschanged;/*  Declare Variables  */
String szCustomer
String szPart
String szCustomerPart
String szAccountCode
String szSalesRep
String cType
String szStdUnit
Long lColumn
Long lRow
Dec {6} dPrice
Dec dQty

/*  Initialize Variables  */
lColumn = dw_4.GetColumn ( )
If lPreviousColumn = 3 Then
	szPart = dw_4.GetItemString ( 1, "supplier_part_number" )
	szCustomer = dw_1.GetItemString ( 1, "customer" )

	SELECT	part_customer.customer_part  
	INTO	:szCustomerPart  
	FROM	part_customer  
	WHERE	( part_customer.part 		= :szPart ) AND  
		( part_customer.customer 	= :szCustomer )   ;

	If SQLCA.SQLCode = 0 Then
		dw_4.SetItem ( 1, "customer_part_number", szCustomerPart )
	Else
		szCustomerPart = ""
	End if

	SELECT part.class  
	INTO :cType  
	FROM part  
	WHERE part.part = :szPart   ;

	If SQLCA.SQLCode = 0 Then
		If cType = 'M' Then
			SELECT part_mfg.gl_account_code  
			INTO :szAccountCode  
			FROM part_mfg  
			WHERE part_mfg.part = :szPart   ;
			dw_4.SetItem ( 1, "account_code", szAccountCode )
		Elseif cType = 'P' Then
			szAccountCode	= dw_4.GetItemString(1, "account_code")
			If IsNull(szAccountCode) or szAccountCode = '' then
				SELECT part_purchasing.gl_account_code  
				INTO :szAccountCode  
				FROM part_purchasing  
				WHERE part_purchasing.part = :szPart   ;
				dw_4.SetItem ( 1, "account_code", szAccountCode )
			End If
		End If
	End if
	szSalesRep	= dw_4.GetItemString( 1, "sales_rep")
	If szSalesRep = '' or IsNull(szSalesRep) then
		SELECT customer.salesrep  
		INTO :szSalesRep  
		FROM 	 customer  
		WHERE  customer.customer = :szCustomer   ;

		If SQLCA.SQLCode = 0 Then
			dw_4.SetItem ( 1, "sales_rep", szSalesRep )
		End if
	End If

	szStdUnit	= dw_4.GetItemString(1, "unit_measure")
	If IsNull(szStdUnit) or szStdUnit = '' then
		SELECT part_inventory.standard_unit  
		INTO :szStdUnit  
		FROM part_inventory  
		WHERE part_inventory.part = :szPart   ;

		If SQLCA.SQLCode = 0 Then
			dw_4.SetItem ( 1, "unit_measure", szStdUnit )
		End if
	End If

	dPrice	= dw_4.GetItemNumber( 1, "unit_price")

	If IsNull(dPrice) then
		SELECT part_standard.price  
		INTO :dPrice  
		FROM part_standard  
		WHERE part_standard.part = :szPart   ;
		
		If SQLCA.SQLCode = 0 Then

			If f_get_value ( dPrice ) > 0 Then
				sqlca.of_calculate_multicurrency_price ( '', dw_1.GetItemString ( 1, "currency_unit" ), dPrice, dPrice )
				dw_4.SetItem ( 1, "unit_price", dPrice )
			end if
		End if
	End If

	wf_create_um_dropdown( szPart )

Elseif lPreviousColumn = 1 Then

	szPart = dw_4.GetItemString ( 1, "supplier_part_number" )
	szCustomer = dw_1.GetItemString ( 1, "customer" )
	dQty = dw_4.GetItemNumber ( 1, "quantity_shipped" )

	dw_7.SetTransObject ( sqlca )
	dw_7.Retrieve ( szPart, szCustomer )

	If dw_7.RowCount ( ) < 1 Then Return

	dw_7.SetSort ( "qty_break A" )
	dw_7.Sort ( )

	lRow = dw_7.Find ( "qty_break > " + String ( dQty ), 1, dw_7.RowCount ( ) )
	If lRow > 0 Then
		dPrice = dw_7.GetItemNumber ( lRow, "price" )

		sqlca.of_calculate_multicurrency_price ( '', dw_1.GetItemString ( 1, "currency_unit" ), dPrice, dPrice )
		dw_4.SetItem ( 1, "unit_price", dPrice )
	End if

End if

lPreviousColumn = lColumn

end event

on editchanged;bitemchanged_detail = True
end on

type dw_salesrep from datawindow within w_invoice_detail
boolean visible = false
integer x = 2057
integer y = 832
integer width = 288
integer height = 80
integer taborder = 90
string dataobject = "dw_salesman_list"
boolean livescroll = true
end type

type cb_5 from commandbutton within w_invoice_detail
boolean visible = false
integer x = 905
integer y = 832
integer width = 256
integer height = 128
integer taborder = 170
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

on clicked;wf_hide_notes ( )
end on

type dw_6 from datawindow within w_invoice_detail
integer x = 1362
integer y = 4
integer width = 576
integer height = 80
integer taborder = 10
string dataobject = "d_destination_ddlist_customers"
boolean border = false
boolean livescroll = true
end type

event itemchanged;/*  Declare Variables  */

String szData
String szDestination
String szDestName
String szDestAddress1
String szDestAddress2
String szDestAddress3
String szCustomer
String szCustName
String szCustAddress1
String szCustAddress2
String szCustAddress3
String szSupplier
String szFOB
String szShipVia
String szFreight
String szTerms
string	ls_currency_unit
int		li_show_euro_amount
Dec    dTaxRate


/*  Initialize Variables  */


/*  Main  */

//dw_6.AcceptText ( )

szDestination = dw_6.GetText ( )  //ItemString ( 1, "destination" )

SELECT destination.name,   
       destination.address_1,   
       destination.address_2,   
       destination.address_3,   
       destination.customer,
		 destination.salestax_rate,
		 destination.default_currency_unit,
		 destination.show_euro_amount
  INTO :szDestName,   
       :szDestAddress1,   
       :szDestAddress2,   
       :szDestAddress3,   
       :szCustomer,
		 :dTaxRate,
		 :ls_currency_unit,
		 :li_show_euro_amount
  FROM destination  
 WHERE destination.destination = :szDestination   ;

If SQLCA.SQLCode = 0 Then

   SELECT destination_shipping.scac_code,   
          destination_shipping.fob,   
          destination_shipping.freight_type  
     INTO :szShipVia,   
          :szFOB,   
          :szFreight  
     FROM destination_shipping  
    WHERE destination_shipping.destination = :szDestination   ;

	If SQLCA.SQLCode = 0 Then
		dw_1.SetItem ( 1, "ship_via", szShipVia )
		dw_1.SetItem ( 1, "fob", szFOB )
		dw_1.SetITem ( 1, "freight_type", szFreight )
	End if

   SELECT edi_setups.supplier_code  
     INTO :szSupplier  
     FROM edi_setups  
    WHERE edi_setups.destination = :szDestination   ;

	If SQLCA.SQLCode = 0 Then
		dw_1.SetItem ( 1, "supplier_code", szSupplier )
	End if

	dw_1.SetItem ( 1, "destination", szDestination )
	dw_1.SetItem ( 1, "destination_name", szDestName )
	dw_1.SetItem ( 1, "destination_address_1", szDestAddress1 )
	dw_1.SetItem ( 1, "destination_address_2", szDestAddress2 )
	dw_1.SetItem ( 1, "destination_address_3", szDestAddress3 )
	dw_1.SetItem ( 1, "tax_rate", dTaxRate )
	
	if isnull(ls_currency_unit,'') = '' then
		SELECT customer.name,   
				 customer.address_1,   
				 customer.address_2,   
				 customer.address_3,
				 customer.terms,
				 customer.default_currency_unit,
				 customer.show_euro_amount
		  INTO :szCustName,   
				 :szCustAddress1,   
				 :szCustAddress2,   
				 :szCustAddress3,
				 :szTerms,
				 :ls_currency_unit,
				 :li_show_euro_amount
		  FROM customer  
		 WHERE customer.customer = :szCustomer   ;
	else
		SELECT customer.name,   
				 customer.address_1,   
				 customer.address_2,   
				 customer.address_3,
				 customer.terms
		  INTO :szCustName,   
				 :szCustAddress1,   
				 :szCustAddress2,   
				 :szCustAddress3,
				 :szTerms
		  FROM customer  
		 WHERE customer.customer = :szCustomer   ;
	end if
	
	If SQLCA.SQLCode = 0 Then
		dw_1.SetItem ( 1, "customer", szCustomer )
		dw_1.SetItem ( 1, "customer_name", szCustName )
		dw_1.SetItem ( 1, "customer_address_1", szCustAddress1 )
		dw_1.SetItem ( 1, "customer_address_2", szCustAddress2 )
		dw_1.SetItem ( 1, "customer_address_3", szCustAddress3 )
		dw_1.SetItem ( 1, "terms", szTerms )
		dw_1.SetItem ( 1, "currency_unit", ls_currency_unit )
		dw_1.SetItem ( 1, "show_euro_amount", li_show_euro_amount )
	End if

End if

end event

type lb_um from listbox within w_invoice_detail
boolean visible = false
integer x = 562
integer y = 1476
integer width = 485
integer height = 356
integer taborder = 190
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type p_3 from picture within w_invoice_detail
integer x = 2377
integer y = 732
integer width = 64
integer height = 64
integer taborder = 120
boolean enabled = false
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_invoice_detail
integer x = 1984
integer y = 732
integer width = 64
integer height = 64
integer taborder = 80
boolean enabled = false
string picturename = "taxable.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_invoice_detail
integer x = 1504
integer y = 732
integer width = 64
integer height = 64
integer taborder = 30
boolean enabled = false
string picturename = "noteyesw.bmp"
boolean focusrectangle = false
end type

type st_5 from statictext within w_invoice_detail
integer x = 2496
integer y = 732
integer width = 357
integer height = 64
integer taborder = 130
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77633680
boolean enabled = false
string text = "No Acct. Code"
boolean focusrectangle = false
end type

type st_4 from statictext within w_invoice_detail
integer x = 2085
integer y = 732
integer width = 210
integer height = 64
integer taborder = 100
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77633680
boolean enabled = false
string text = "Taxable"
boolean focusrectangle = false
end type

type st_3 from statictext within w_invoice_detail
integer x = 1614
integer y = 732
integer width = 210
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77633680
boolean enabled = false
string text = "Notes"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_invoice_detail
boolean visible = false
integer x = 32
integer y = 1472
integer width = 485
integer height = 356
integer taborder = 180
string dataobject = "d_invoice_detail_btdb"
boolean livescroll = true
end type

type dw_7 from datawindow within w_invoice_detail
boolean visible = false
integer x = 101
integer y = 16
integer width = 485
integer height = 356
integer taborder = 200
string dataobject = "d_customer_price_list"
boolean livescroll = true
end type

type cb_3 from commandbutton within w_invoice_detail
boolean visible = false
integer x = 914
integer y = 1136
integer width = 256
integer height = 128
integer taborder = 140
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

on clicked;bitemchanged_detail = False

wf_hide_add_item ( )
end on

type dw_5 from datawindow within w_invoice_detail
boolean visible = false
integer x = 722
integer y = 228
integer width = 1536
integer height = 572
integer taborder = 60
string dataobject = "d_invoice_detail_notes"
end type

on itemchanged;bitemchanged_notes = True
end on

on editchanged;bitemchanged_notes = True
end on

type st_2 from statictext within w_invoice_detail
boolean visible = false
integer x = 613
integer y = 164
integer width = 1746
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77633680
boolean enabled = false
string text = "Invoice Detail Notes"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_invoice_detail
boolean visible = false
integer x = 594
integer y = 140
integer width = 1746
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77633680
boolean enabled = false
string text = "Edit Detail Item"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_invoice_detail
boolean visible = false
integer x = 581
integer y = 140
integer width = 1746
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77633680
boolean enabled = false
string text = "Add Detail Item"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_invoice_detail
boolean visible = false
integer x = 622
integer y = 1136
integer width = 256
integer height = 128
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
end type

event clicked;If bChangeUm then
	If f_get_string_value ( dw_4.GetItemString ( 1, "unit_measure" ) ) = "" Then
		MessageBox("Warning", "You must specify a unit", StopSign!)
		Return
	End If
End If

wf_save_detail_item ( )

wf_build_detail ( )

wf_hide_add_item ( )
end event

type cb_4 from commandbutton within w_invoice_detail
boolean visible = false
integer x = 622
integer y = 832
integer width = 256
integer height = 128
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
end type

on clicked;If dw_5.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
	bitemchanged_notes = False
End if

wf_hide_notes ( )

wf_build_detail ( )
end on

type cb_1 from commandbutton within w_invoice_detail
boolean visible = false
integer x = 535
integer y = 128
integer width = 1847
integer height = 1168
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type dw_1 from datawindow within w_invoice_detail
integer x = 14
integer y = 20
integer width = 2848
integer height = 692
integer taborder = 20
string dataobject = "d_invoice_header"
boolean border = false
end type

on itemchanged;bitemchanged = True
end on

on editchanged;bitemchanged = True
end on

type dw_2 from datawindow within w_invoice_detail
integer x = 37
integer y = 816
integer width = 2816
integer height = 644
integer taborder = 150
string dataobject = "d_external_invoice_detail"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;/*  Declare Variables  */

String cType


/*  Initialize Variables  */

lDetailRow = row
SelectRow ( 0, False )
If lDetailRow < 1 Then Return

SelectRow ( lDetailRow, True )

cType = dw_2.GetItemString ( lDetailRow, "type" )

If IsNull ( cType ) Or cType <> 'I' Then

	dw_2.SetTabOrder ( "supplier_part_number", 0 )
	dw_2.SetTabOrder ( "quantity_shipped", 0 )

Else

	dw_2.SetTabOrder ( "quantity_shipped", 10 )
	dw_2.SetTabOrder ( "supplier_part_number", 30 )
	
End if
end event

event doubleclicked;/*  Main  */

lDetailRow = dw_2.GetClickedRow ( )
SelectRow ( dw_2, 0, FALSE )
SelectRow ( dw_2, lDetailRow, True )
wf_show_existing_item ( )
end event


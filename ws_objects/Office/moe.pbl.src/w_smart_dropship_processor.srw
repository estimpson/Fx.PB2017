$PBExportHeader$w_smart_dropship_processor.srw
forward
global type w_smart_dropship_processor from Window
end type
type uo_eligible_po from u_list_of_eligible_po_for_dropship within w_smart_dropship_processor
end type
type st_trash from statictext within w_smart_dropship_processor
end type
type sle_po from singlelineedit within w_smart_dropship_processor
end type
type sle_order from singlelineedit within w_smart_dropship_processor
end type
type sle_invoice from singlelineedit within w_smart_dropship_processor
end type
type st_message from statictext within w_smart_dropship_processor
end type
type uo_vendors from u_create_po_header_for_dropship within w_smart_dropship_processor
end type
type dw_order_detail from datawindow within w_smart_dropship_processor
end type
type dw_po_detail from datawindow within w_smart_dropship_processor
end type
type dw_invoice_detail from datawindow within w_smart_dropship_processor
end type
type dw_invoice_header from datawindow within w_smart_dropship_processor
end type
type gb_4 from groupbox within w_smart_dropship_processor
end type
type gb_3 from groupbox within w_smart_dropship_processor
end type
type gb_2 from groupbox within w_smart_dropship_processor
end type
type gb_1 from groupbox within w_smart_dropship_processor
end type
end forward

global type w_smart_dropship_processor from Window
int X=0
int Y=0
int Width=2926
int Height=1928
boolean TitleBar=true
string Title="Drop Shipment Processor"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event create_po_header pbm_custom01
event close_uo pbm_custom02
event reconcile pbm_custom03
event create_invoice_detail ( long a_s_qty,  date a_s_date,  string a_s_operator )
event create_po pbm_custom06
event cancel_po_creation pbm_custom07
uo_eligible_po uo_eligible_po
st_trash st_trash
sle_po sle_po
sle_order sle_order
sle_invoice sle_invoice
st_message st_message
uo_vendors uo_vendors
dw_order_detail dw_order_detail
dw_po_detail dw_po_detail
dw_invoice_detail dw_invoice_detail
dw_invoice_header dw_invoice_header
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_smart_dropship_processor w_smart_dropship_processor

type variables
String	szDestination	//Ship to destination
String	szPart		//Ship to part number
String	szUM		//Unit of measurement
String	szTerms		//Terms
String	szVendor		//Vendor
String	szPriceUnit	//Price Unit
String	szPlant		//Plant code
String	szCustomerPart	//Customer part
String	szSalesman	//Salesman
String	szOperator	//Operator
String	szShipToDest	//Ship to destination
String	szShipType	//Ship type
String	szPOPlant	//Plant code in PO header


Decimal	nQty		//Quantity
Decimal	nPrice		//Price
Decimal	nTotalCum	//To keep the cum value

Date	dDate		//To keep the date

Long	iOrder		//To keep the sales order
Long	iPO		//To keep the P.O.
Long	iOERowId	//The row id for order
Long	iPORowId	//The row id for PO
Long	iShipper		//The shipper number
Long	iInvoice		//The invoice number
Long	iInvoiceRow	//The invoice detail row number
Long	iSuffix		//The suffix

Boolean	bDragOrder	//Whether dragging Order
Boolean	bDragPO		//Whether dragging PO
Boolean	bDragInvoice	//Whether dragging Invoice
Boolean	bDragInvHeader	//Whether dragging Invoice header


end variables

forward prototypes
public function string wf_get_terms (string szcustomer)
public function boolean wf_any_invoice_highlighted ()
public function boolean wf_create_audit_trail (string as_type, string as_value1, string as_value2, string as_value3, string as_value4, string as_value5, string as_value6, string as_value7, string as_value8, string as_value9, string as_value10, string as_value11, string as_value12, string as_value13, string as_value14, string as_value15, string as_value16)
public function boolean wf_delete_audit_trail (long al_shipper, string as_part)
public function boolean wf_different_plants (long al_Order, long al_PO)
public function long wf_create_po_header (string a_s_vendor, string a_s_terms, string a_s_destination)
public subroutine wf_find_po_header (string a_s_vendor, string a_s_destination, string a_s_part, long a_l_order)
public function boolean wf_update_oe_detail (long a_l_order, string a_s_part, long a_l_rowid, long a_l_po, long a_l_porowid, decimal a_n_qty)
public function long wf_locate_po (long a_l_order, long a_l_rowid)
public subroutine wf_get_vendor_terms (long a_l_po)
public function long wf_locate_oe (long a_l_order, long a_l_rowid)
public function long wf_search_invoice (string a_s_destination, time a_s_part, long a_l_invoice)
public function long wf_find_shipper_header (string a_s_destination, string a_s_part, long a_l_order)
public function long wf_create_shipper_header (string a_s_destination, string a_s_customer)
public function decimal wf_get_tax_rate (string a_s_destination)
public function string wf_get_customer (string a_s_destination)
public function boolean wf_create_po_detail (long a_l_po, string a_s_part, date a_d_duedate, decimal a_n_qty, string a_s_unit, string a_s_destination, long a_l_oe_row_id, long a_l_order, string a_s_terms, string a_s_vendor)
public function boolean wf_update_po_detail (long a_l_po, long a_l_porow_id, decimal a_n_qty, string a_s_flag)
public function boolean wf_reconcile_oe (long a_l_order, long a_l_oerowid)
public function boolean wf_reconcile_po_and_oe (long a_l_shipper)
public function boolean wf_reconcile_po (long a_l_po, long a_l_porowid)
public function boolean wf_identical_po_item_exists (long a_l_order, long a_l_oerowid)
public function boolean wf_add_to_po_detail (long a_l_order, long a_l_oerowid, decimal a_n_qty, string a_s_um, string a_s_part)
public function boolean wf_identical_shipper_detail_item_exists (long a_l_po, long a_l_porowid, long a_l_order, long a_l_oerowid, string a_s_part)
public function boolean wf_add_to_shipper_item (long a_l_po, long a_l_porowid, long a_l_order, long a_l_oerowid, decimal a_n_qty, string a_s_um, string a_s_part)
public function string wf_get_customer_part (long a_l_order, long a_l_oerowid)
public function boolean wf_ok_for_dragdrog (long a_l_po, long a_l_porowid)
public function boolean wf_update_cum (long a_l_order, string a_s_part, decimal a_n_qty, string a_s_um, string a_s_flag)
public subroutine wf_get_po_info (long a_l_po)
public function integer wf_total_vendors (string a_s_part)
public function string wf_get_shipping_info (string a_s_destination, string a_s_type)
public function decimal wf_get_price (long a_l_order, long a_l_oerowid, long a_l_po, long a_l_porowid)
public function boolean wf_create_invoice_detail (long a_l_shipper, string a_s_part, decimal a_n_qty, string a_s_unit, decimal a_n_price, string a_s_priceunit, long a_l_dropship_po, long a_l_dropship_po_row_id, long a_l_dropship_oe_row_id, long a_l_order)
public function decimal wf_get_order_price (long a_l_order, long a_l_oerowid)
public function decimal wf_get_po_price (long a_l_order, long a_l_oerowid, long a_l_po, long a_l_porowid)
end prototypes

on create_po_header;szVendor	= uo_vendors.szVendor
szTerms	= uo_vendors.szTerms
nQty		= Dec(uo_vendors.sle_qty.text)
nPrice	= Dec(uo_vendors.sle_price.text)

uo_vendors.visible	= FALSE

wf_find_po_header ( szVendor, szDestination, szPart, iOrder )

end on

on close_uo;uo_vendors.visible	= FALSE
end on

event reconcile;Long		iRow		= 1
Boolean	lb_Success = TRUE

If Not bDragInvHeader then
	Return
End If

bDragInvHeader	= TRUE

Do while lb_Success AND (iRow <= dw_invoice_header.RowCount())

	If dw_invoice_header.IsSelected(iRow) then
		iShipper	= dw_invoice_header.GetItemNumber(iRow, "id")
		lb_Success	= wf_reconcile_po_and_oe(iShipper)

		If lb_Success then
			Update shipper  
     		Set dropship_reconciled = 'Y'  
   		Where id = :iShipper   ;

			If SQLCA.SQLCode = 0 then
				lb_Success	= TRUE
			Else
				lb_Success	= FALSE
			End If

		End If
		
	End If

	iRow ++

Loop

If lb_Success then
	Commit;
	dw_po_detail.Retrieve()
	dw_order_detail.Retrieve()
	dw_invoice_header.Retrieve()
	dw_invoice_detail.Reset()
	MessageBox(monsys.msg_title, "Reconcilation has been successful.", StopSign!)
Else
	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
	Rollback;
End If			

end event

event create_invoice_detail;/* 01-28-2000 KAZ Modified to place the rollbacks before the message boxes to release the 
						database to avoid deadlocks.     */

dDate			= a_s_date
nQty			= a_s_qty
szOperator	= a_s_operator

if isvalid ( w_prompt_for_invoice_detail_dropship ) then close ( w_prompt_for_invoice_detail_dropship )

bDragOrder		= FALSE

nPrice			= wf_get_order_price ( iOrder, iOERowId )

IF wf_identical_shipper_detail_item_exists ( iPO, iPORowId, iOrder, iOERowId, szPart ) THEN

	IF wf_update_cum ( iOrder, szPart, nQty, szUM, "+" ) THEN
		IF wf_add_to_shipper_item ( iPO, iPORowId, iOrder, iOERowId, nQty, szUm, szPart ) THEN
			IF wf_update_po_detail ( iPO, iPORowId, nQty, "+" ) THEN
				Commit;
				dw_po_detail.Retrieve ( )
				dw_invoice_detail.Retrieve ( iShipper )
			ELSE
				Rollback;																								// CHG 01-28-2000 KAZ
				MessageBox ( monsys.msg_title, SQLCA.SQLCode, StopSign! )
//				Rollback;																								-  CHG 01-28-2000 KAZ
			END IF
		ELSE
			Rollback;																									// CHG 01-28-2000 KAZ
			MessageBox ( monsys.msg_title, SQLCA.SQLCode, StopSign! )
//			Rollback;																									-  CHG 01-28-2000 KAZ
		END IF
	ELSE
		Rollback;																										// CHG 01-28-2000 KAZ
		MessageBox ( monsys.msg_title, SQLCA.SQLCode, StopSign! )
//		Rollback;																										-  CHG 01-28-2000 KAZ
	END IF

ELSE	
	iShipper	= wf_find_shipper_header ( szDestination, szPart, iOrder )

	IF iShipper = 0 THEN					//If no available SHIPPER found
		iShipper	= wf_create_shipper_header ( szDestination, wf_get_customer ( szDestination ) )
	END IF

	IF iShipper > 0 THEN					//available SHIPPER found

		If wf_update_cum ( iOrder, szPart, nQty, szUM, "+" ) AND &
			wf_create_invoice_detail ( iShipper, szPart, nQty, szUM, nPrice, &
										 szPriceUnit, iPO, iPORowId, iOERowId, iOrder ) THEN
			IF wf_update_po_detail ( iPO, iPORowId, nQty, "+" ) THEN
				Commit;
				dw_invoice_header.Retrieve ( )
				dw_invoice_detail.Retrieve ( iShipper )
				dw_po_detail.Retrieve ( )
			ELSE
				Rollback;																								// CHG 01-28-2000 KAZ
				MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
//				Rollback;																								-  CHG 01-28-2000 KAZ
			END IF
		ELSE
			Rollback;																									// CHG 01-28-2000 KAZ
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
//			Rollback;																									-  CHG 01-28-2000 KAZ
		END IF
	ELSE
		ROllback;																										// CHG 01-28-2000 KAz
		MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
//		Rollback;																										-  CHG 01-28-2000 KAZ
	END IF
END IF

nPrice = wf_get_po_price ( iOrder, iOERowId, iPO, iPORowId )

IF wf_create_audit_trail ( 'R', szPart, String ( nQty ),&
                           String ( nPrice ), szVendor, String ( iPO ),&
                           szOperator, szDestination, szUM, szPlant,&
                           String ( iOrder ), String ( iPORowId ),&
                           String ( iOERowId ), String ( iShipper ),&
								   '0', '0', '0' ) THEN
Commit;
ELSE
	Rollback;																											// CHG 01-28-2000 KAZ
	MessageBox ( monsys.msg_title, "Update of receiving event in Audit Trail failed!  However, the Invoice Detail was updated successfully.", StopSign!, OK! )
//	Rollback;																											-  CHG 01-28-2000 KAZ
	Return 
END IF

nPrice = wf_get_order_price ( iOrder, iOERowId )

IF wf_create_audit_trail ( 'S', szPart, String ( nQty ), String ( nPrice ), &
                           szSalesMan, szOperator, szVendor, szDestination, &
                           String ( iShipper ), szUM, szPlant, &
                           String ( iInvoice ), String ( iOrder ), &
                           String ( iPORowId ), String ( iOERowId ), &
                           String ( iPO ), '0' ) THEN
	Commit;
ELSE
	Rollback;																											// CHG 01-28-2000 KAZ
	MessageBox ( monsys.msg_title, "Update of shipping event in Audit Trail failed!  However, the Invoice Detail was updated successfully.", StopSign!, OK! )
//	Rollback;																											-  CHG 01-28-2000 KAz
	Return 
END IF
end event

event create_po;/* 01-27-2000 KAZ Modified to place the rollbacks before the message boxes to release the 
						database to avoid deadlocks, and added one after a message box if user quits. */


iPO							= uo_eligible_po.iPO
uo_eligible_po.Visible	= FALSE

IF iPO > 0 THEN					//available PO found
	IF wf_different_plants ( iOrder, iPO ) THEN
		IF MessageBox ( monsys.msg_title, "You are trying to schedule to a " + &
							 "different plant on the Purchase Order than the " + &
							 "Order specifies.  Do you still want to continue?", &
							 Question!, YesNo! ) = 2 THEN
			Return
		END IF  
	END IF
	szPlant	= uo_eligible_po.szPlant
	wf_get_vendor_terms ( iPO )	//Get terms & vendor

	IF wf_create_po_detail ( iPO, szPart, dDate, nQty, szUM, szDestination, &
						  iOeRowId, iOrder, szTerms, szVendor ) THEN
		IF wf_update_oe_detail ( iOrder, szPart, iOERowId, iPO, iPORowId, nQty ) THEN
			Commit;
			dw_po_detail.Retrieve ( )
			dw_order_detail.Retrieve ( )
		ELSE
			Rollback;																		// CHG 01-27-2000 KAZ
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
//			Rollback;																		-  CHG 01-27-2000 KAZ
		END IF
	ELSE
		Rollback;																			// CHG 01-27-2000 KAZ
		MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
//		Rollback;																			-  CHG 01-27-2000 KAZ
	END IF

ELSE

	iPO	= wf_create_po_header ( szVendor, szTerms, szDestination )
	IF iPO > 0 THEN
		IF wf_different_plants ( iOrder, iPO ) THEN
			IF MessageBox ( monsys.msg_title, "You are trying to schedule to a " + &
								 "different plant on the Purchase Order than the " + &
								 "Order specifies.  Do you still want to continue?", &
								 Question!, YesNo! ) = 2 THEN
				Rollback;																	// ADD 01-27-2000 KAZ
				Return
			END IF  
		END IF
		IF wf_create_po_detail ( iPO, szPart, dDate, nQty, szUM, szDestination, &
								iOErowid, iOrder, szTerms, szVendor ) THEN
			IF wf_update_oe_detail ( iOrder, szPart, iOERowId, iPO, iPORowId, nQty ) THEN
				Commit;
				dw_po_detail.Retrieve ( )
				dw_order_detail.Retrieve ( )
			ELSE
				Rollback;																	// CHG 01-27-2000 KAZ
				MessageBox ( monsys.msg_title, SQLCA.SQLErrtext, StopSign! )
//				Rollback;																	-  CHG 01-27-2000 KAZ
			END IF
		ELSE
			Rollback;																		// CHG 01-27-2000 KAZ
			MessageBox ( monsys.msg_title, SQLCA.SQLErrtext, StopSign! )  
//			Rollback;																		-  CHG 01-27-2000 KAZ
		END IF
	ELSE
		Rollback;																			// CHG 01-27-2000 KAZ
		MessageBox ( monsys.msg_title, SQLCA.SQLErrtext, StopSign! )
//		Rollback;																			-  CHG 01-27-2000 KAZ
	END IF
END IF

nPrice = wf_get_po_price ( iOrder, iOERowId, iPO, iPORowId )


end event

on cancel_po_creation;uo_eligible_po.visible	= FALSE
end on

public function string wf_get_terms (string szcustomer);Select customer.terms  
  Into :szTerms  
  From customer  
 Where customer.customer = :szCustomer;

Return szTerms
end function

public function boolean wf_any_invoice_highlighted ();Long 		iRow
Boolean 	bSelected = FALSE

iRow	= 1

Do while (Not bSelected) AND (iRow <= dw_invoice_header.RowCount())
	bSelected = dw_invoice_header.IsSelected(iRow)
	iRow ++
Loop

Return bSelected


end function

public function boolean wf_create_audit_trail (string as_type, string as_value1, string as_value2, string as_value3, string as_value4, string as_value5, string as_value6, string as_value7, string as_value8, string as_value9, string as_value10, string as_value11, string as_value12, string as_value13, string as_value14, string as_value15, string as_value16);Long   	ll_Serial, &
   		ll_Order, &
         ll_PO, &
         ll_Shipper, &
         ll_PORowId, &
         ll_OERowId

Decimal	ldec_Weight, &
         ldec_Quantity, &
         ldec_StdQuantity, &
         ldec_OnHand, &
         ldec_Price, &
      	ldec_Cost

String 	ls_Part, &
      	ls_Location, &
         ls_From, &
         ls_To, &
         ls_UM, &
      	ls_Operator, &
         ls_Activity, &
         ls_Vendor, &
         ls_Customer, &
         ls_Flag, &
         ls_Status, &
         ls_Salesman, &
         ls_Lot, &
         ls_Remark, &
         ls_ControlNumber, &
         ls_Plant, &
         ls_Custom1, &
      	ls_Note, &
         ls_PackageType, &
         ls_Account, &
			ls_Notes, &
			ls_GroupNo, &
         ls_Invoice, &
         ls_Release

DateTime	ldt_DateTime
Date		ld_DueDate

ldt_DateTime = DateTime ( Today ( ), Now ( ) ) 
ls_Status    = "A"	
ld_DueDate   = Today ( )
OpenWithParm ( w_get_parm_value, "next_serial" ) 
ll_Serial = Message.DoubleParm


IF as_Type = 'R' THEN
	ls_Part       = as_Value1
	ldec_Quantity = Dec ( as_Value2 )
	ldec_Price    = Dec ( as_Value3 )
	ls_Vendor     = as_Value4
   ll_PO         = Long ( as_Value5 )
	ls_Operator   = as_Value6
	ls_To         = as_Value7
	ls_UM         = as_Value8
	ldec_Cost     = ldec_Price * ldec_Quantity
	ls_Plant      = as_Value9
	ll_Order      = Long ( as_Value10 )
	ll_PORowId    = Long ( as_Value11 )
	ll_OERowId    = Long ( as_Value12 )
	ll_Shipper    = Long ( as_Value13 )

	SELECT std_qty,
			 due_date,
			 notes,
			 group_no
	  INTO :ldec_StdQuantity,
          :ld_DueDate,
			 :ls_Notes,
			 :ls_GroupNo
	  FROM order_detail
	 WHERE ( order_no = :ll_Order ) AND 
			 ( part_number = :ls_Part )	;

	SELECT convert(varchar,release_no)
	  INTO :ls_Release
	  FROM po_detail
	 WHERE ( po_number = :ll_PO ) AND
		    ( row_id    = :ll_PORowId ) AND
			 ( dropship_oe_row_id = :ll_OERowId )		;

	IF IsNull ( ls_Release, '' ) = '' THEN
		SELECT convert(varchar,release_no)
		  INTO :ls_Release
		  FROM po_header
		 WHERE po_number = :ll_PO	;
	END IF

	SELECT account_code
	  INTO :ls_Account
	  FROM po_detail
	 WHERE ( po_number = :ll_PO ) AND
		    ( row_id    = :ll_PORowId ) AND
			 ( dropship_oe_row_id = :ll_OERowId )		;

	INSERT INTO audit_trail ( serial,
									  date_stamp,
                             type,
                             part,
									  quantity,
                             remarks,
                             price,
                             salesman,
                             customer,
                             vendor,
                             po_number,
                             operator,
                             from_loc,
                             to_loc,
                             on_hand,
                             lot,
                             weight,
                             status,
                             shipper,
                             flag,
                             activity,
                             unit,
                             workorder,
                             std_quantity,
                             cost,
                             control_number,
                             custom1,
                             custom2,
                             custom3,
                             custom4,
                             custom5,
                             plant,
                             invoice_number,
                             gl_account,
                             notes,
                             package_type,
                             suffix,
                             due_date,
                             group_no,
                             sales_order,
                             release_no,
									  dropship_shipper )
                    VALUES ( :ll_Serial,
                             :ldt_DateTime,
                             :as_Type,
                             :ls_Part,
                             :ldec_Quantity,
                             'Receiving',
                             null,
                             null,
                             null,
                             :ls_Vendor,
                             :as_value5,
                             :ls_Operator,
                             :ls_Vendor,
                             :ls_To,
                             0,
                             null,
                             0,
                             :ls_Status,
                             null,
                             null,
                             null,
                             :ls_UM,
                             null,
                             :ldec_StdQuantity,
                             :ldec_Price,
                             null,
                             null,
                             null,
                             null,
                             null,
                             null,
                             :ls_Plant,
                             null,
                             :ls_Account,
                             :ls_Notes,
                             null,
                             null,
                             :ld_DueDate,
                             :ls_GroupNo,
                             :as_value10,
                             :ls_Release,
									  :ll_Shipper )	;

	UPDATE shipper_detail
	   SET dropship_po_serial = :ll_Serial
	 WHERE ( shipper       = :ll_Shipper ) AND
			 ( part_original = :ls_Part )	;

ELSEIF as_Type = 'S' THEN

	ls_Part          = as_Value1
	ldec_Quantity    = Dec ( as_Value2 )
	ldec_Price       = Dec ( as_Value3 )
	ls_SalesMan      = as_Value4 
	ls_Operator      = as_Value5
	ls_Vendor        = as_Value6
	ls_To            = as_Value7
	ll_Shipper       = Long ( as_Value8 )
	ls_UM            = as_Value9
	ls_Plant         = as_Value10
	ls_Invoice       = as_Value11
	ll_Order         = Long ( as_Value12 )
	ll_PORowId       = Long ( as_Value13 )	
	ll_OERowId       = Long ( as_Value14 )
	ll_PO            = Long ( as_Value15 )

	SELECT std_qty,
			 due_date,
			 notes,
			 group_no,
			 release_no
	  INTO :ldec_StdQuantity,
          :ld_DueDate,
			 :ls_Notes,
			 :ls_GroupNo,
			 :ls_Release
	  FROM order_detail
	 WHERE ( order_no = :ll_Order ) AND 
			 ( part_number = :ls_Part )	;

	SELECT customer
	  INTO :ls_Customer
	  FROM order_header
	 WHERE order_no = :ll_Order	;

	SELECT price
	  INTO :ldec_Cost
	  FROM po_detail	 WHERE ( po_number = :ll_PO ) AND
		    ( row_id    = :ll_PORowId ) AND
			 ( dropship_oe_row_id = :ll_OERowId )		;

	SELECT account_code
	  INTO :ls_Account
	  FROM po_detail
	 WHERE ( po_number = :ll_PO ) AND
		    ( row_id    = :ll_PORowId ) AND
			 ( dropship_oe_row_id = :ll_OERowId )		;

	IF IsNull ( ls_Invoice, '' ) = '' THEN
		SELECT convert(varchar,invoice_number)
		  INTO :ls_Invoice
        FROM shipper
       WHERE id = :ll_Shipper		;
	END IF

	INSERT INTO audit_trail ( serial,
									  date_stamp,
                             type,
                             part,
                             quantity,
                             remarks,
                             price,
                             salesman,
                             customer,
                             vendor,
                             po_number,
                             operator,
                             from_loc,
                             to_loc,
                             on_hand,
                             lot,
                             weight,
                             status,
                             shipper,
                             flag,
                             activity,
                             unit,
                             workorder,
                             std_quantity,
                             cost,
                             control_number,
                             custom1,
                             custom2,
                             custom3,
                             custom4,
                             custom5,
                             plant,
                             invoice_number,
                             gl_account,
                             notes,
                             package_type,
                             suffix,
                             due_date,
                             group_no,
                             sales_order,
                             release_no,
									  dropship_shipper )
                    VALUES ( :ll_Serial,
                             :ldt_DateTime,
                             :as_Type,
                             :ls_Part,
                             :ldec_Quantity,
                             'Shipping',
                             :ldec_Price,
                             :ls_SalesMan,
                             :ls_Customer,
                             null,
                             :as_value15,
                             :ls_Operator,
                             :ls_Vendor,
                             :ls_To,
                             0,
                             null,
                             0,
                             :ls_Status,
                             null,
                             null,
                             null,
                             :ls_UM,
                             null,
                             :ldec_StdQuantity,
                             :ldec_Cost,
                             null,
                             null,
                             null,
                             null,
                             null,
                             null,
                             :ls_Plant,
                             :ls_Invoice,
                             :ls_Account,
                             :ls_Notes,
                             null,
                             null,
                             :ld_DueDate,
                             :ls_GroupNo,
                             :as_value12,
                             :ls_Release,
									  :ll_Shipper )	;

	UPDATE shipper_detail
	   SET dropship_invoice_serial = :ll_Serial
	 WHERE ( shipper       = :ll_Shipper ) AND
			 ( part_original = :ls_Part ) 	;

ELSE
	Return FALSE
END IF

IF SQLCA.SQLCode = 0 THEN
	Return TRUE
ELSE
	Return FALSE
END IF
end function

public function boolean wf_delete_audit_trail (long al_shipper, string as_part);Long l_POSerial, &
	  l_InvoiceSerial

SELECT dropship_po_serial,
       dropship_invoice_serial
  INTO :l_POSerial,
       :l_InvoiceSerial
  FROM shipper_detail
 WHERE ( shipper = :al_Shipper ) AND
	    ( part_original = :as_Part ) 	;

DELETE FROM audit_trail
	   WHERE ( serial = :l_POSerial ) OR
            ( serial = :l_InvoiceSerial )	;

IF SQLCA.SQLCode = 0 THEN
	Return TRUE
ELSE
	Return FALSE
END IF
end function

public function boolean wf_different_plants (long al_Order, long al_PO);String s_OrderPlant, &
		 s_POPlant

SELECT plant
  INTO :s_OrderPlant
  FROM order_header
 WHERE order_no = :al_Order	;

SELECT plant
  INTO :s_POPlant
  FROM po_header
 WHERE po_number = :al_PO	 ;

IF s_OrderPlant <> s_POPlant THEN
	Return TRUE
ELSE
	Return FALSE
END IF
end function

public function long wf_create_po_header (string a_s_vendor, string a_s_terms, string a_s_destination);/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'l_l_PO' (next PO number), added rollbacks for DB errors.  */

Long 	l_l_PO

Date	l_d_Date

//bFinish	= FALSE																								-  CHG 01-26-2000 KAZ
//OpenWithParm(w_get_parm_value, "purchase_order")														-  CHG 01-26-2000 KAZ
//
//Do while Not bFinish																							-  CHG 01-26-2000 KAZ
//Loop																												-  CHG 01-26-2000 KAZ
//
//l_l_po	= Message.DoubleParm																					-  CHG 01-26-2000 KAZ
//
//If l_l_po > 0 then																								-  CHG 01-26-2000 KAZ

if sqlca.of_getnextparmvalue ( "purchase_order", l_l_PO ) then    // Get current value 	-  ADD 01-26-2000 KAZ

	l_d_date	= Today()

  	Insert Into po_header  
         ( po_number,   
           vendor_code,   
           po_date,   
           date_due,   
           terms,   
           fob,   
           ship_via,   
           ship_to_destination,   
           status,   
           type,   
           description,   
           plant,   
           freight_type,   
           buyer,   
           printed,   
           notes,   
           total_amount,   
           shipping_fee,   
           sales_tax,   
           blanket_orderded_qty,   
           blanket_frequency,   
           blanket_duration,   
           blanket_qty_per_release,   
           blanket_part,   
           blanket_vendor_part,   
           price,   
           std_unit,   
           ship_type,   
           flag )  
  	VALUES ( :l_l_po,   
           :a_s_vendor,   
           :l_d_date,   
           null,   
           :a_s_terms,   
           null,   
           null,   
           :szDestination,   
           'A',   
           null,   
           null,   
           :szPlant,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           'DropShip',   
           null )  ;

	If SQLCA.SQLCode = -1 then
		Rollback;																									// ADD 01-26-2000 KAZ
		MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
		l_l_po	= 0
	End If

else																													// ADD 01-26-2000 KAZ
	l_l_PO = 0																										// ADD 01-26-2000 KAZ
End If

Return l_l_po			
end function

public subroutine wf_find_po_header (string a_s_vendor, string a_s_destination, string a_s_part, long a_l_order);Long  l_l_PO
Long iReturnVal
Long iPOList[]
Long iEligiblePOList[]
Long iCount = 0
Long iEligibleCount = 0

DECLARE curPOheader CURSOR FOR  
 SELECT po_number  
   FROM po_header  
  WHERE ( ship_to_destination = :a_s_destination ) AND  
        ( status <> 'C' ) AND  
        ( ship_type 		= 'DropShip' ) AND
		  ( vendor_code 	= :a_s_vendor) ;

Open curPOHeader;

Fetch curPOHeader Into :l_l_PO;

Do while SQLCA.SQLCode = 0
	iCount ++
	iPOList[iCount]	= l_l_PO

	Fetch curPOHeader Into :l_l_PO;
Loop

Close curPOHeader;


//-----------------------------------------------------------------------
// Now try to find the first PO which has the non-conflicting detail items
// (1) Same part not found in PO 
//	or
// (2) Same part from the same Sales Order found in PO	
//-----------------------------------------------------------------------

l_l_PO				= 0
iEligibleCount = 0

Do while ( iCount > 0 )

	iPO	= iPOList[iCount]

	Select 	po_number  
   Into 		:iReturnVal  
   From 		po_detail  
   Where 	( part_number 	= :szPart ) And
         	( sales_order <> :iOrder ) And  
         	( po_number 	= :iPO ) ;

	If SQLCA.SQLCode = 0 then		//If system does find a detail item which
		iPO	= 0						//has different sales order#, then check next
	Else
		iEligibleCount ++
		iEligiblePOList[iEligibleCount]	= iPO		
	End If

	iCount --
	
Loop

If iEligibleCount = 0 then
	iPO	= 0
End If

If UpperBound ( iEligiblePOList ) = 0 then
	MessageBox(monsys.msg_title, "System has not found any available P.O. for the part. Therefore, it will create a new one.", Information!)
	this.TriggerEvent("create_po")
Else
	uo_eligible_po.visible	= TRUE
	uo_eligible_po.uf_setup(w_smart_dropship_processor)
	uo_eligible_po.dw_list_of_po.Reset()

	For iCount = 1 to iEligibleCount

		iPO	= iEligiblePoList[iCount]

		If uo_eligible_po.dw_list_of_po.Find("po_number = " + String(iPO), 1, 99999) = 0 then
			wf_get_po_info(iPO)
			uo_eligible_po.dw_list_of_po.InsertRow(1)
			uo_eligible_po.dw_list_of_po.SetItem(1, "po_number", iPO)
			uo_eligible_po.dw_list_of_po.SetItem(1, "plant", szPOPlant)
			uo_eligible_po.dw_list_of_po.SetItem(1, "ship_to_destination", szShipToDest)
			uo_eligible_po.dw_list_of_po.SetItem(1, "ship_type", szShipType)
		End If

	Next

End If
end subroutine

public function boolean wf_update_oe_detail (long a_l_order, string a_s_part, long a_l_rowid, long a_l_po, long a_l_porowid, decimal a_n_qty);  UPDATE order_detail  
     SET dropship_po 			= :a_l_PO,   
         dropship_po_row_id 	= :a_l_PORowId
   WHERE ( order_no = :a_l_Order ) AND  
         ( part_number = :a_s_Part ) AND  
         ( row_id = :a_l_RowId )   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
	Return FALSE
End If

end function

public function long wf_locate_po (long a_l_order, long a_l_rowid);Long l_l_Row

l_l_Row	= dw_po_detail.Find("(sales_order = " + String(a_l_Order) + &
									 ") AND (dropship_oe_row_id =" + String(a_l_RowId) + ")", 1, 999999)

Return l_l_Row
end function

public subroutine wf_get_vendor_terms (long a_l_po);SELECT po_header.vendor_code,   
       po_header.terms  
  INTO :szVendor,   
       :szTerms  
  FROM po_header  
 WHERE po_header.po_number = :a_l_PO   ;

end subroutine

public function long wf_locate_oe (long a_l_order, long a_l_rowid);Long l_l_Row

l_l_Row	= dw_order_detail.Find("(order_no = " + String(a_l_Order) + &
									 ") AND (row_id =" + String(a_l_RowId) + ")", 1, 999999)

Return l_l_Row
end function

public function long wf_search_invoice (string a_s_destination, time a_s_part, long a_l_invoice);Return 0

end function

public function long wf_find_shipper_header (string a_s_destination, string a_s_part, long a_l_order);Long l_l_Shipper
Long iReturnVal
Long iShipperList[]
Long iCount = 0

Declare curShipperheader Cursor For  
SELECT shipper.id  
  FROM shipper  
 WHERE ( shipper.destination = :a_s_Destination ) AND  
       (shipper.status = 'C' OR  
       shipper.ship_via = 'Z') AND  
       shipper.type = 'D' AND  
       shipper.invoice_printed = 'N'   ;

Open curShipperHeader;

Fetch curShipperHeader Into :l_l_shipper;

Do while SQLCA.SQLCode = 0
	iCount ++
	iShipperList[iCount]	= l_l_shipper

	Fetch curShipperHeader Into :l_l_shipper;
Loop

Close curShipperHeader;

//-----------------------------------------------------------------------
// Now try to find the first Shipper which has the non-conflicting detail items
// (1) Same part not found in Shipper 
//-----------------------------------------------------------------------

l_l_shipper	= 0

Do while (l_l_shipper = 0) AND ( iCount > 0 )

	l_l_shipper	= iShipperList[iCount]

  	SELECT shipper_detail.shipper  
    INTO :iReturnVal
    FROM shipper_detail  
   WHERE ( shipper_detail.shipper = :l_l_shipper ) AND  
         ( shipper_detail.part = :a_s_part )   ;

	If SQLCA.SQLCode = 0 then		//If system does find an identical detail item which
		l_l_shipper	= 0		
		iCount --				
	End If

Loop

If iCount = 0 then
	l_l_shipper = 0
End If

Return l_l_shipper
end function

public function long wf_create_shipper_header (string a_s_destination, string a_s_customer);/* 01-27-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'l_l_Shipper' (next Shipper number), and l_l_Invoice
						(next Invoice number).  */

Long		l_l_Invoice
Long		l_l_Shipper

Decimal	nTaxRate

String	l_s_Terms
String	szShipVia
String	szFreightType
String	szTransMode

nTaxRate			= wf_get_tax_rate(a_s_Destination)
l_s_Terms		= wf_get_terms(a_s_customer)
szShipVia		= wf_get_shipping_info(a_s_Destination, "SHIP VIA")
szFreightType	= wf_get_shipping_info(a_s_Destination, "FREIGHT TYPE")
szTransMode		= wf_get_shipping_info(a_s_Destination, "TRANS MODE")

//bFinish	= FALSE																														-  CHG 01-27-2000 KAZ
//OpenWithParm(w_get_parm_value, "shipper")																						-  CHG 01-27-2000 KAZ
//Do while Not bFinish																													-  CHG 01-27-2000 KAZ
//Loop																																		-  CHG 01-27-2000 KAZ
//
//l_l_shipper	= message.DoubleParm																									-  CHG 01-27-2000 KAZ
//

if not sqlca.of_getnextparmvalue ( "shipper", l_l_shipper ) then     	// Fail to get current value  		-  ADD 01-27-2000 KAZ
		Rollback;																															// ADD 01-27-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new Shipper number, Please try again", Exclamation! )	// ADD 01-27-2000 KAZ
		l_l_shipper	= 0																													// ADD 01-27-2000 KAZ
		Return 0																																// ADD 01-27-2000 KAZ
end if																																		// ADD 01-27-2000 KAZ

//bFinish	= FALSE																														-  CHG 01-27-2000 KAZ
//OpenWithParm(w_get_parm_value, "next_invoice")																				-  CHG 01-27-2000 KAZ
//Do while Not bFinish																													-  CHG 01-27-2000 KAZ
//Loop																																		-  CHG 01-27-2000 KAZ
//
//l_l_invoice	= Message.DoubleParm																									-  CHG 01-27-2000 KAZ

if not sqlca.of_getnextparmvalue ( "next_invoice", l_l_invoice ) then   // Fail to get current value 			-  ADD 01-27-2000 KAZ
		Rollback;																															// ADD 01-27-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new Invoice number, Please try again", Exclamation! )	// ADD 01-27-2000 KAZ
		l_l_invoice	= 0																													// ADD 01-27-2000 KAZ
		Return 0																																// ADD 01-27-2000 KAZ
end if																																		// ADD 01-27-2000 KAZ

  INSERT INTO shipper  
         ( id,   
           destination,   
           date_stamp,   
           shipping_dock,   
           ship_via,   
           status,   
           date_shipped,   
           aetc_number,   
           freight_type,   
           printed,   
           bill_of_lading_number,   
           model_year_desc,   
           model_year,   
           customer,   
           location,   
           staged_objs,   
           plant,   
           type,   
           invoiced,   
           invoice_number,   
           freight,   
           tax_percentage,   
           total_amount,   
           gross_weight,   
           net_weight,   
           tare_weight,   
           responsibility_code,   
           trans_mode,   
           pro_number,   
           notes,   
           time_shipped,   
           truck_number,   
           invoice_printed,   
           seal_number,   
           terms,   
           tax_rate,   
           staged_pallets,   
           container_message,   
           picklist_printed,
			  dropship_reconciled)  
  VALUES ( :l_l_shipper,   
           :a_s_Destination,   
           :dDate,   
           null,   
           :szShipVia,   
           'C',   
           :dDate,   
           null,   
           :szFreightType,   
           null,   
           null,   
           null,   
           null,   
           :a_s_customer,   
           null,   
           null,   
           :szPlant,   
           'D',   
           'N',   
           :l_l_invoice,   
           0.00,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :szTransMode,   
           null,   
           null,   
           null,   
           null,   
           'N',   
           null,   
           :l_s_Terms,   
           :nTaxRate,   
           null,   
           null,   
           null,
			  'N' )  ;

	If SQLCA.SQLCode = 0 then
		Return l_l_shipper
	Else
		Return 0
	End If

end function

public function decimal wf_get_tax_rate (string a_s_destination);Decimal nTaxRate

Select destination.salestax_rate   
  Into :nTaxRate
  From destination ;

Return f_get_value(nTaxRate)
end function

public function string wf_get_customer (string a_s_destination);String	l_s_Customer

Select destination.customer  
  Into :l_s_Customer  
  From destination  
 Where destination.destination = :a_s_Destination   ;

Return l_s_Customer

end function

public function boolean wf_create_po_detail (long a_l_po, string a_s_part, date a_d_duedate, decimal a_n_qty, string a_s_unit, string a_s_destination, long a_l_oe_row_id, long a_l_order, string a_s_terms, string a_s_vendor);Decimal 	nBalance
Decimal	nStdQty

Long		iWeekNo

String	szPartName
String	szRelease
String	szGLAccount

nStdQty		= f_convert_units(a_s_unit, "", a_s_Part, a_n_Qty)
szPartName	= f_get_part_info(a_s_part, "NAME")
szGLAccount	= f_get_part_info(a_s_part, "GL ACCOUNT")

select isnull ( max ( row_id ), 0 ) + 1
into   :iPORowId
from 	 po_detail
where  po_number = :a_l_PO ;

//iPORowId		= f_get_random_number()

SELECT release_no
  INTO :szRelease
  FROM po_header
 WHERE po_number = :a_l_PO		;

  INSERT INTO po_detail  
         ( po_number,   
           vendor_code,   
           part_number,   
           description,   
           unit_of_measure,   
           date_due,   
           requisition_number,   
           status,   
           type,   
           last_recvd_date,   
           last_recvd_amount,   
           cross_reference_part,   
           account_code,   
           notes,   
           quantity,   
           received,   
           balance,   
           active_release_cum,   
           received_cum,   
           alternate_price,   
           row_id,   
           invoice_status,   
           invoice_date,   
           invoice_qty,   
           invoice_unit_price,   
           release_no,   
           ship_to_destination,   
           terms,   
           week_no,   
           plant,   
           invoice_number,   
           standard_qty,   
           sales_order,   
           dropship_oe_row_id,   
           ship_type,
			  dropship_shipper,
			  price_unit )  
  VALUES ( :a_l_PO,   
           :a_s_vendor,   
           :a_s_part,   
           :szPartName,   
           :a_s_unit,   
           :a_d_duedate,   
           null,   
           'A',   
           null,   
           null,   
           null,   
           null,   
           :szGLAccount,   
           null,   
           :a_n_Qty,   
           0,   
           :a_n_Qty,   
           null,   
           null,   
           :nPrice,   
           :iPORowId,   
           null,   
           null,   
           null,   
           null,   
           :szRelease,   
           :a_s_Destination,   
           :a_s_terms,   
           :iWeekNo,   
           :szPlant,   
           null,   
           :nStdQty,   
           :iOrder,   
           :a_l_OE_row_id,   
           'D',
			  null,
			  :szPriceUnit )  ;

If SQLCA.SQLCode = 0 then
  INSERT INTO po_detail_history  
         ( po_number,   
           vendor_code,   
           part_number,   
           description,   
           unit_of_measure,   
           date_due,   
           requisition_number,   
           status,   
           type,   
           last_recvd_date,   
           last_recvd_amount,   
           cross_reference_part,   
           account_code,   
           notes,   
           quantity,   
           received,   
           balance,   
           active_release_cum,   
           received_cum,   
           alternate_price,   
           row_id,   
           invoice_status,   
           invoice_date,   
           invoice_qty,   
           invoice_unit_price,   
           release_no,   
           ship_to_destination,   
           terms,   
           week_no,   
           plant,   
           invoice_number,   
           standard_qty,   
           sales_order,   
           dropship_oe_row_id,   
           ship_type,
			  dropship_shipper,
			  price_unit,
			  price )  
  select		po_number,   
           vendor_code,   
           part_number,   
           description,   
           unit_of_measure,   
           date_due,   
           requisition_number,   
           status,   
           type,   
           last_recvd_date,   
           last_recvd_amount,   
           cross_reference_part,   
           account_code,   
           notes,   
           quantity,   
           received,   
           balance,   
           active_release_cum,   
           received_cum,   
           alternate_price,   
           row_id,   
           invoice_status,   
           invoice_date,   
           invoice_qty,   
           invoice_unit_price,   
           release_no,   
           ship_to_destination,   
           terms,   
           week_no,   
           plant,   
           invoice_number,   
           standard_qty,   
           sales_order,   
           dropship_oe_row_id,   
           ship_type,
			  dropship_shipper,
			  price_unit,
			  price
	from		po_detail
	where		po_number = :a_l_po and
				part_number = :a_s_Part and
				date_due = :a_d_duedate and
				row_id = :iPORowId ;
	
	If  SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	Return FALSE
End If
end function

public function boolean wf_update_po_detail (long a_l_po, long a_l_porow_id, decimal a_n_qty, string a_s_flag);If a_s_flag = '+' then
	UPDATE po_detail  
	   SET received = received + :a_n_qty,   
   	    balance = balance - :a_n_qty  
 	WHERE ( po_number = :a_l_PO ) AND  
       	( row_id = :a_l_porow_id )   ;
Else
	UPDATE po_detail  
	   SET received = received - :a_n_qty,   
   	    balance = balance + :a_n_qty  
 	WHERE ( po_number = :a_l_PO ) AND  
       	( row_id = :a_l_porow_id )   ;
End If

If SQLCA.SQLCode = 0 then
	If a_s_flag = '+' then
		UPDATE po_detail_history  
		   SET received = received + :a_n_qty,   
	   	    balance = balance - :a_n_qty  
	 	WHERE ( po_number = :a_l_PO ) AND  
	       	( row_id = :a_l_porow_id )   ;
	Else
		UPDATE po_detail_history  
		   SET received = received - :a_n_qty,   
	   	    balance = balance + :a_n_qty  
	 	WHERE ( po_number = :a_l_PO ) AND  
	       	( row_id = :a_l_porow_id )   ;
	End If

	If SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	Return FALSE
End If
end function

public function boolean wf_reconcile_oe (long a_l_order, long a_l_oerowid);DELETE FROM order_detail  
 WHERE ( order_no = :a_l_Order ) AND  
       ( row_id 	= :a_l_OERowId )   ;

If SQLCA.SQLCode = 0 then
	Return TRUE;
Else
	Return FALSE
End If
end function

public function boolean wf_reconcile_po_and_oe (long a_l_shipper);Boolean l_b_Success = TRUE

Long	l_l_Row = 1

dw_invoice_detail.Retrieve(a_l_Shipper)

Do while l_b_Success AND (l_l_Row <= dw_invoice_detail.RowCount())
	iPO		= dw_invoice_detail.GetItemNumber(l_l_Row, "dropship_po")
	iPORowId	= dw_invoice_detail.GetItemNumber(l_l_Row, "dropship_po_row_id")
	iOrder	= dw_invoice_detail.GetItemNumber(l_l_Row, "order_no")
	iOERowId	= dw_invoice_detail.GetItemNumber(l_l_Row, "dropship_oe_row_id")
	nQty		= dw_invoice_detail.GetItemNumber(l_l_Row, "alternative_qty")
	l_b_Success	= wf_reconcile_po(iPO, iPORowId)
	If l_b_Success then
		l_b_Success = wf_reconcile_oe(iOrder, iOERowId)
	End If
	l_l_Row ++
Loop

Return l_b_Success
end function

public function boolean wf_reconcile_po (long a_l_po, long a_l_porowid);Delete From po_detail  
Where ( po_number = :a_l_PO ) And  
      ( row_id = :a_l_PORowId );

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public function boolean wf_identical_po_item_exists (long a_l_order, long a_l_oerowid);Long l_l_PO
Long l_l_Shipper


SELECT po_detail.po_number  
  INTO :l_l_PO  
  FROM po_detail  
 WHERE ( po_detail.sales_order = :a_l_Order ) AND  
       ( po_detail.dropship_oe_row_id = :a_l_OERowId )   ;

If SQLCA.SQLCode = 0 then			//If found in po detail
	SELECT shipper_detail.shipper  
   INTO :l_l_Shipper  
   FROM shipper_detail  
   WHERE ( shipper_detail.order_no = :a_l_Order ) AND  
         ( shipper_detail.dropship_oe_row_id = :a_l_OERowId )   ;

	If SQLCA.SQLCode = 0 then		//If found in invoice detail
		Return FALSE
	Else
		Return TRUE
	End If
Else
	Return FALSE
End If
end function

public function boolean wf_add_to_po_detail (long a_l_order, long a_l_oerowid, decimal a_n_qty, string a_s_um, string a_s_part);Decimal nQuantity, nBalance, nStdQty

SELECT po_detail.quantity,   
       po_detail.balance  
  INTO :nQuantity,   
       :nBalance  
  FROM po_detail  
 WHERE ( po_detail.sales_order = :a_l_Order ) AND  
       ( po_detail.dropship_oe_row_id = :a_l_oerowid )   ;

nBalance	= f_get_value(nBalance) + a_n_qty

nStdQty	= f_convert_units(a_s_um, "", a_s_part, nBalance)

UPDATE po_detail  
   SET quantity 		= quantity 	+ :a_n_qty,   
  	    balance			= balance 	+ :a_n_qty,
		 standard_qty 	= :nStdQty
WHERE ( sales_order 	= :iOrder ) AND  
     	( dropship_oe_row_id = :a_l_oerowid )   ;

If SQLCA.SQLCode = 0 then
	UPDATE po_detail_history
	   SET quantity 		= quantity 	+ :a_n_qty,   
	  	    balance			= balance 	+ :a_n_qty,
			 standard_qty 	= :nStdQty
	WHERE ( sales_order 	= :a_l_Order ) AND  
	     	( dropship_oe_row_id = :a_l_oerowid )   ;
	If SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	Return FALSE
End If
end function

public function boolean wf_identical_shipper_detail_item_exists (long a_l_po, long a_l_porowid, long a_l_order, long a_l_oerowid, string a_s_part);SELECT shipper_detail.shipper  
  INTO :iShipper  
  FROM shipper,   
       shipper_detail  
 WHERE ( shipper.id = shipper_detail.shipper ) and  
       ( ( shipper.invoice_printed = 'N' ) AND  
       ( shipper_detail.part = :a_s_Part ) AND  
       ( shipper_detail.order_no = :a_l_Order ) AND  
       ( shipper_detail.dropship_oe_row_id = :a_l_OERowId ) AND  
       ( shipper_detail.dropship_po = :a_l_PO ) AND  
       ( shipper_detail.dropship_po_row_id = :a_l_PORowId ) )   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public function boolean wf_add_to_shipper_item (long a_l_po, long a_l_porowid, long a_l_order, long a_l_oerowid, decimal a_n_qty, string a_s_um, string a_s_part);Decimal	nStdQty

nStdQty	= f_convert_units(a_s_UM, "", a_s_Part, a_n_Qty)

UPDATE shipper_detail  
   SET qty_required    = qty_required + :nStdQty,
		 qty_packed 	  = qty_packed + :nStdQty,
		 qty_original    = qty_original + :nStdQty,   
       alternative_qty = alternative_qty + :a_n_Qty,
		 accum_shipped   = :nTotalCum
 WHERE ( order_no = :a_l_Order ) AND  
       ( dropship_oe_row_id = :a_l_OERowId ) AND  
       ( dropship_po = :a_l_PO ) AND  
       ( dropship_po_row_id = :a_l_PORowId ) AND  
       ( part = :a_s_Part )   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public function string wf_get_customer_part (long a_l_order, long a_l_oerowid);String l_s_CustomerPart
String szOrderType

Select order_header.order_type,  
		 order_header.customer_part,
		 order_header.salesman
  Into :szOrderType,
		 :l_s_CustomerPart,
		 :szSalesman
  From order_header  
 Where order_header.order_no = :a_l_Order   ;

If szOrderType = 'N' then		//Blanket order
	  SELECT order_detail.customer_part  
    INTO :l_s_CustomerPart  
    FROM order_detail  
   WHERE ( order_detail.order_no = :a_l_Order ) AND  
         ( order_detail.row_id = :a_l_OERowId )   ;
End If

Return l_s_CustomerPart		
end function

public function boolean wf_ok_for_dragdrog (long a_l_po, long a_l_porowid);Long l_l_Shipper

  SELECT shipper_detail.shipper  
    INTO :l_l_Shipper  
    FROM shipper,   
         shipper_detail  
   WHERE ( shipper.id = shipper_detail.shipper ) and  
         ( ( shipper.dropship_reconciled = 'N' ) AND  
         ( shipper_detail.dropship_po = :a_l_PO ) AND  
         ( shipper_detail.dropship_po_row_id = :a_l_PORowId ) )   ;

If SQLCA.SQLCode = 0 then
	Return FALSE
Else
	Return TRUE
End If

end function

public function boolean wf_update_cum (long a_l_order, string a_s_part, decimal a_n_qty, string a_s_um, string a_s_flag);String szOrderType
String szOrderUM

Decimal nCum

SetNull(nTotalCum)

Select order_header.order_type,
		 order_header.unit,
		 order_header.our_cum
  Into :szOrderType,
		 :szOrderUM,
		 :nCum
  From order_header  
 Where order_header.order_no = :a_l_Order   ;

If szOrderType = "N" then
	Return TRUE
End If

a_n_qty	= f_convert_units(a_s_UM, szOrderUM, a_s_part, a_n_qty)

If a_s_flag = "+" then
	UPDATE order_header
	   SET our_cum = our_cum + :a_n_qty  
	 WHERE order_no = :a_l_Order   ;

	nTotalCum	= f_get_value(nCum) + a_n_Qty

Else
	UPDATE order_header  
   SET our_cum = our_cum - :a_n_qty  
 	WHERE order_no = :a_l_Order   ;
End If

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If




end function

public subroutine wf_get_po_info (long a_l_po);SELECT plant,   
       ship_to_destination,   
       ship_type  
  INTO :szPOPlant,   
       :szShipToDest,   
       :szShipType  
  FROM po_header  
 WHERE po_number = :a_l_PO   ;



end subroutine

public function integer wf_total_vendors (string a_s_part);Long liTotal

SELECT count(vendor)  
  INTO :liTotal  
  FROM part_vendor  
 WHERE part = :a_s_Part   ;

Return f_get_value(liTotal)

end function

public function string wf_get_shipping_info (string a_s_destination, string a_s_type);String 	szShipVia
String	szTransMode
String	szFreightType

SELECT destination_shipping.scac_code,   
       destination_shipping.trans_mode,   
       destination_shipping.freight_type  
  INTO :szShipVia,   
       :szTransMode,   
       :szFreightType  
  FROM destination_shipping
 WHERE destination = :a_s_Destination   ;

Choose Case a_s_type

	Case "SHIP VIA"
		Return szShipVia

	Case "FREIGHT TYPE"
		Return szFreightType

	Case "TRANS MODE"
		Return szTransMode

End Choose

end function

public function decimal wf_get_price (long a_l_order, long a_l_oerowid, long a_l_po, long a_l_porowid);String szOrderType

SELECT price
  INTO :nPrice
  FROM po_header
 WHERE po_number = :a_l_PO 	;

If IsNull ( nPrice ) OR nPrice = 0 Then
	SELECT order_header.price,
			 order_header.price_unit,  
   	    order_header.order_type  
  	  INTO :nPrice,
			 :szPriceUnit,             
     	    :szOrderType  
  	  FROM order_header  
 	 WHERE order_header.order_no = :a_l_Order   ;
Else
	SELECT order_header.price_unit,    
   	    order_header.order_type  
  	  INTO :szPriceUnit,             
     	    :szOrderType  
  	  FROM order_header  
 	 WHERE order_header.order_no = :a_l_Order   ;
End If

If szOrderType = 'N' then	//If this is a normal order, get price from detail

	SELECT price
	  INTO :nPrice
	  FROM po_detail
	 WHERE ( po_number = :a_l_PO ) AND
	       ( row_id    = :a_l_PORowId )		;

If IsNull ( nPrice ) OR nPrice = 0 Then
  	SELECT order_detail.price  
  	  INTO :nPrice  
  	  FROM order_detail  
  	 WHERE ( order_detail.order_no = :a_l_Order ) AND  
          ( order_detail.row_id = :a_l_OERowId )   ;
End If

	szPriceUnit	= 'P'			// Price for 'Piece'

End If

Return nPrice
end function

public function boolean wf_create_invoice_detail (long a_l_shipper, string a_s_part, decimal a_n_qty, string a_s_unit, decimal a_n_price, string a_s_priceunit, long a_l_dropship_po, long a_l_dropship_po_row_id, long a_l_dropship_oe_row_id, long a_l_order);Decimal 	a_n_qtyPacked
Decimal	nTotalCost

String	szGLAccount
String	a_s_partName
String	a_s_partOriginal
String	szCustomerPO

Long		iWeekNo

String	ls_releaseno
datetime	ldt_releasedt

iWeekNo			= f_get_week_no(Today())
szGLAccount		= f_get_part_info(a_s_part, "MFG GL ACCOUNT")
a_n_qtyPacked		= f_convert_units(a_s_unit, "", a_s_part, a_n_qty)
szCustomerPart	= wf_get_customer_part(a_l_order, a_l_Dropship_OE_Row_Id)
a_s_partName		= f_get_part_info(a_s_part, "NAME")
a_s_partOriginal	= a_s_part
szCustomerPO	= f_get_order_info(a_l_order, "CUSTOMER PO")
nTotalCost		= wf_get_po_price ( a_l_order, iOERowId, iPO, iPORowId ) * a_n_qtyPacked

select	release_no,
	due_date
into	:ls_releaseno,
	:ldt_releasedt
from	order_detail
where	order_no = :a_l_order and
	row_id = :a_l_dropship_oe_row_id ;

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
           week_no,   
           taxable,   
           price_type,   
           cross_reference,   
           customer_part,   
           dropship_po,   
           dropship_po_row_id,   
           dropship_oe_row_id,
			  part_name,
			  part_original,
			  total_cost )  
  VALUES ( :a_l_shipper,   
           :a_s_part,   
           :a_n_qtyPacked,   
           :a_n_qtyPacked,   
           :a_n_qtyPacked,   
           :nTotalCum,   
           :a_l_order,   
           :szCustomerPO,   
           :ls_releaseno,   
           :ldt_releasedt,   
           null,   
           :a_n_Price,   
           :szGLAccount,   
           :szSalesman,   
           null,   
           null,   
           null,   
           :dDate,   
           null,   
           null,   
           null,   
           :szOperator,   
           null,   
           null,   
           :a_n_qty,   
           :a_s_unit,   
           :iWeekNo,   
           null,   
           :a_s_PriceUnit,   
           null,   
           :szCustomerPart,   
           :a_l_Dropship_po,   
           :a_l_Dropship_po_row_id,   
           :a_l_Dropship_oe_row_id,
			  :a_s_partName,
			  :a_s_partOriginal,
			  :nTotalCost )  ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public function decimal wf_get_order_price (long a_l_order, long a_l_oerowid);String szOrderType

SELECT order_header.price,
		 order_header.price_unit,  
  	    order_header.order_type  
  INTO :nPrice,
    	 :szPriceUnit,             
       :szOrderType  
  FROM order_header  
 WHERE order_header.order_no = :a_l_Order   ;

If szOrderType = 'N' then	//If this is a normal order, get price from detail

  	SELECT order_detail.price  
  	  INTO :nPrice  
  	  FROM order_detail  
  	 WHERE ( order_detail.order_no = :a_l_Order ) AND  
          ( order_detail.row_id = :a_l_OERowId )   ;

	szPriceUnit	= 'P'			// Price for 'Piece'

End If

Return nPrice
end function

public function decimal wf_get_po_price (long a_l_order, long a_l_oerowid, long a_l_po, long a_l_porowid);String szOrderType

nPrice = 0

SELECT price
  INTO :nPrice
  FROM po_detail
 WHERE ( po_number = :a_l_PO ) AND
	    ( row_id    = :a_l_PORowId ) AND
		 ( dropship_oe_row_id = : a_l_OERowId )		;

If IsNull ( nPrice ) OR nPrice = 0 Then
	SELECT order_header.price,
			 order_header.price_unit,  
   	    order_header.order_type  
  	  INTO :nPrice,
			 :szPriceUnit,             
     	    :szOrderType  
  	  FROM order_header  
 	 WHERE order_header.order_no = :a_l_order   ;
Else
	SELECT order_header.price_unit,    
   	    order_header.order_type  
  	  INTO :szPriceUnit,             
     	    :szOrderType  
  	  FROM order_header  
 	 WHERE order_header.order_no = :a_l_order   ;
End If

If szOrderType = 'N' then	//If this is a normal order, get price from detail

	SELECT price
	  INTO :nPrice
	  FROM po_detail
	 WHERE ( po_number = :a_l_PO ) AND
	   	 ( row_id    = :a_l_PORowId ) AND
			 ( dropship_oe_row_id = : a_l_OERowId )		;

If IsNull ( nPrice ) OR nPrice = 0 Then
  	SELECT order_detail.price  
  	  INTO :nPrice  
  	  FROM order_detail  
  	 WHERE ( order_detail.order_no = :a_l_order ) AND  
          ( order_detail.row_id = :a_l_OERowId )   ;
End If

	szPriceUnit	= 'P'			// Price for 'Piece'

End If

Return nPrice
end function

on timer;If bDragOrder then
	sle_po.visible	= Not sle_po.visible
Else
	If bDragPO then
		sle_po.visible			= FALSE
		sle_order.visible		= Not sle_order.visible
		sle_invoice.visible	= Not sle_invoice.visible
	Else
		If bDragInvoice then
			sle_order.visible		= FALSE
			sle_invoice.visible	= FALSE
			sle_po.visible			= Not sle_po.visible
		Else
			sle_order.visible		= FALSE
			sle_invoice.visible	= FALSE
			sle_po.visible			= FALSE
		End If
	End If
End If
			


end on

event activate;if gnv_App.of_GetFrame().menuname <> 'm_drop_ship' then &
	gnv_App.of_GetFrame().ChangeMenu(m_drop_ship)
end event

event open;dw_order_detail.SetTransObject(sqlca)
dw_po_detail.SetTransObject(sqlca)
dw_invoice_header.SetTransObject(sqlca)
dw_invoice_detail.SetTransObject(sqlca)

dw_order_detail.Modify("order_no.color='0~t if(dropship_po_row_id > 0 ,255,0)'")
dw_order_detail.Modify("part_number.color='0~t if(dropship_po_row_id > 0 ,255,0)'")
dw_order_detail.Modify("due_date.color='0~t if(dropship_po_row_id > 0 ,255,0)'")
dw_order_detail.Modify("quantity.color='0~t if(dropship_po_row_id > 0 ,255,0)'")
dw_order_detail.Modify("unit.color='0~t if(dropship_po_row_id > 0 ,255,0)'")
dw_order_detail.Modify("std_qty.color='0~t if(dropship_po_row_id > 0 ,255,0)'")

dw_order_detail.Retrieve()
dw_po_detail.Retrieve()
dw_invoice_header.Retrieve()

Timer(0.5)
end event

on w_smart_dropship_processor.create
this.uo_eligible_po=create uo_eligible_po
this.st_trash=create st_trash
this.sle_po=create sle_po
this.sle_order=create sle_order
this.sle_invoice=create sle_invoice
this.st_message=create st_message
this.uo_vendors=create uo_vendors
this.dw_order_detail=create dw_order_detail
this.dw_po_detail=create dw_po_detail
this.dw_invoice_detail=create dw_invoice_detail
this.dw_invoice_header=create dw_invoice_header
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.uo_eligible_po,&
this.st_trash,&
this.sle_po,&
this.sle_order,&
this.sle_invoice,&
this.st_message,&
this.uo_vendors,&
this.dw_order_detail,&
this.dw_po_detail,&
this.dw_invoice_detail,&
this.dw_invoice_header,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_smart_dropship_processor.destroy
destroy(this.uo_eligible_po)
destroy(this.st_trash)
destroy(this.sle_po)
destroy(this.sle_order)
destroy(this.sle_invoice)
destroy(this.st_message)
destroy(this.uo_vendors)
destroy(this.dw_order_detail)
destroy(this.dw_po_detail)
destroy(this.dw_invoice_detail)
destroy(this.dw_invoice_header)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type uo_eligible_po from u_list_of_eligible_po_for_dropship within w_smart_dropship_processor
int X=731
int Y=352
boolean Visible=false
end type

on uo_eligible_po.destroy
call u_list_of_eligible_po_for_dropship::destroy
end on

type st_trash from statictext within w_smart_dropship_processor
int X=475
int Y=816
int Width=823
int Height=64
boolean Enabled=false
string Text="Dbl click to highlight for reconcilation"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_po from singlelineedit within w_smart_dropship_processor
int X=2798
int Y=32
int Width=37
int Height=32
int TabOrder=50
boolean Visible=false
boolean AutoHScroll=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_order from singlelineedit within w_smart_dropship_processor
int X=1335
int Y=32
int Width=37
int Height=32
int TabOrder=90
boolean Visible=false
boolean AutoHScroll=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_invoice from singlelineedit within w_smart_dropship_processor
int X=1335
int Y=848
int Width=37
int Height=32
int TabOrder=100
boolean Visible=false
boolean AutoHScroll=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_message from statictext within w_smart_dropship_processor
int X=439
int Width=878
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="Dropship PO has been set for this item"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_vendors from u_create_po_header_for_dropship within w_smart_dropship_processor
int X=841
int Y=208
boolean Visible=false
end type

on uo_vendors.destroy
call u_create_po_header_for_dropship::destroy
end on

type dw_order_detail from datawindow within w_smart_dropship_processor
int X=37
int Y=64
int Width=1335
int Height=736
int TabOrder=40
string DragIcon="MONITOR.ICO"
string DataObject="d_order_details_for_dropship"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;bDragOrder	= FALSE

If bDragPO then					//If dragging a PO

	If wf_ok_for_dragdrog(iPO, iPORowId) then
		bDragPO	= FALSE				//Reset the flag for dragdrop

		UPDATE order_detail  
	   SET dropship_po = null,   
	       dropship_po_row_id = null
	   WHERE ( order_no = :iOrder ) AND  
	         ( row_id = :iOERowId )   ;

	  	DELETE po_detail  
	   WHERE ( po_number = :iPO ) AND  
	         ( row_id = :iPORowId )   ;
		
		If SQLCA.SQLCode = 0 then
		  	DELETE po_detail_history
		   WHERE ( po_number = :iPO ) AND  
		         ( row_id = :iPORowId )   ;
			If SQLCA.SQLCode = 0 then
				Commit;
				dw_order_detail.Retrieve()
				dw_po_detail.Retrieve()
			Else
				Rollback;
			End If
		Else
			Rollback;
		End If

	Else
		MessageBox(monsys.msg_title, "You can not dragdrop po item committed in invoice.", StopSign!)
		bDragPO	= FALSE	

	End If
End If
end event

event clicked;Long	iRow
Long	iPORow

iRow			= this.GetClickedRow()

bDragOrder	= FALSE
bDragPO		= FALSE

If iRow > 0 then
	szPart			= this.GetItemString(iRow, "part_number")
	szDestination	= this.GetItemString(iRow, "destination")
	nQty				= this.GetItemNumber(iRow, "quantity") - this.GetItemNumber(iRow, "committed_qty")
	szUM				= this.GetItemString(iRow, "unit")
	dDate				= date ( this.GetItemDatetime (iRow, "due_date") )
	iOrder			= this.GetItemNumber(iRow, "order_no")
	iPO				= this.GetItemNumber(iRow, "dropship_po")
	iOERowId			= this.GetItemNumber(iRow, "row_id")
	iPORowId			= this.GetItemNumber(iRow, "dropship_po_row_id")
	szPlant			= this.GetItemString(iRow, "plant")
	iPORow			= wf_locate_po(iOrder, iOERowId)
	nPrice			= wf_get_order_price ( iOrder, iOERowId )
	iSuffix			= this.GetItemNumber(iRow, "suffix")

	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)

	st_message.visible	= FALSE
	bDragOrder				= TRUE
	this.Drag(begin!)
	dw_po_detail.SelectRow(0, FALSE)

	If iPORow > 0 then
		dw_po_detail.ScrollToRow(iPORow)
		dw_po_detail.SelectRow(iPORow, TRUE)
	End If

End If
	
end event

type dw_po_detail from datawindow within w_smart_dropship_processor
int X=1408
int Y=64
int Width=1426
int Height=736
int TabOrder=30
string DragIcon="MONITOR.ICO"
string DataObject="d_po_details_for_dropship"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;bDragPO		= FALSE

IF bDragOrder THEN			//Create the po detail from the order detail
	bDragOrder	= FALSE

	IF IsNull ( szUM ) THEN
		MessageBox ( monsys.msg_title, "You must specify the unit of measurement first.", StopSign! )
		Return 
	END IF

	IF wf_total_vendors ( szPart ) = 0 THEN
		MessageBox ( monsys.msg_title, "You must setup vendor/part profile for part:" + szPart + " first.", StopSign! )
		Return
	END IF

	IF iSuffix > 0 THEN
		MessageBox ( monsys.msg_title, "Dropship system can not process demands with a suffix attached.", StopSign! )
		Return
	END IF

	IF wf_identical_po_item_exists ( iOrder, iOERowId ) THEN
		IF wf_add_to_po_detail ( iOrder, iOERowId, nQty, szUM, szPart ) THEN
			IF wf_different_plants ( iOrder, iPO ) THEN
				IF MessageBox ( monsys.msg_title, "You are trying to schedule to a " + &
						 "different plant on the Purchase Order than the " + &
						 "Order specifies.  Do you still want to continue?", &
						 Question!, YesNo! ) = 2 THEN
					Return
				END IF  
			END IF
			Commit;
			dw_order_detail.Retrieve ( )
			dw_po_detail.Retrieve ( )
			MessageBox ( monsys.msg_title, "System successfully added the quantity to a partial PO release with same sales order origin.", Information! )
		ELSE
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
			Rollback;
		END IF
	ELSE
		uo_vendors.Visible	= TRUE
		uo_vendors.uf_setup ( w_smart_dropship_processor, szPart, nQty, szUM )
	END IF
ELSE
	IF bDragInvoice THEN			//Undo the shipper/invoice detail
		bDragInvoice	= FALSE

		IF wf_update_po_detail ( iPO, iPORowId, nQty, "-" ) AND &
			wf_update_cum ( iOrder, szPart, nQty, szUM, "-" ) AND &
			wf_delete_audit_trail ( iShipper, szPart ) THEN
			dw_invoice_detail.DeleteRow ( iInvoiceRow )

			IF dw_invoice_detail.Update ( ) > 0 THEN	

				IF dw_invoice_detail.RowCount ( ) = 0 THEN
					UPDATE shipper  
					SET Status = 'D'
					WHERE id = :iShipper   ;
					IF SQLCA.SQLCode = 0 THEN				
						Commit;
						dw_po_detail.Retrieve ( )
						dw_invoice_header.Retrieve ( )
					ELSE
						MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
						Rollback;
					END IF
				ELSE
					UPDATE shipper
					SET invoiced = 'N',
						 invoice_printed = 'N'
					WHERE id = :iShipper ;
					IF SQLCA.SQLCode = 0 THEN
						Commit;
						dw_po_detail.Retrieve ( )
						dw_invoice_header.Retrieve ( )
					ELSE
						MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
					END IF
				END IF

			ELSE
				MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
				Rollback;
			END IF

		ELSE
			MessageBox ( monsys.msg_title, SQLCA.SQLErrText, StopSign! )
			Rollback;
		END IF

	END IF

END IF
end event

event clicked;Long	iOERow

bDragOrder	= FALSE
bDragPO		= FALSE

If row > 0 then

	szPart			= this.GetItemString(row, "part_number")
	nQty				= this.GetItemNumber(row, "balance")
	szUM				= this.GetItemString(row, "unit_of_measure")
	dDate				= date ( this.GetItemDatetime (row, "date_due") )
	iOrder			= this.GetItemNumber(row, "sales_order")
	iPO				= this.GetItemNumber(row, "po_number")
	iPORowId			= this.GetItemNumber(row, "row_id")
	iOERowId			= this.GetItemNumber(row, "dropship_oe_row_id")
	szDestination	= this.GetItemString(row, "ship_to_destination")
	nPrice			= this.GetItemNumber(row, "price")
	szPriceUnit		= this.GetItemString(row, "price_unit")
	szPlant			= this.GetItemString(row, "plant")

	dw_order_detail.SelectRow(0, FALSE)
	bDragPO		= TRUE
	this.Drag(begin!)

	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)

End If
	
end event

type dw_invoice_detail from datawindow within w_smart_dropship_processor
int X=1408
int Y=880
int Width=1426
int Height=544
int TabOrder=80
string DragIcon="MONITOR.ICO"
string DataObject="d_list_of_invoice_detail_for_dropship"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;iInvoiceRow		= this.GetClickedRow()
bDragPO			= FALSE
bDragOrder		= FALSE
bDragInvoice	= FALSE

If iInvoiceRow > 0 then
	bDragInvoice	= TRUE
	iPO				= this.GetItemNumber(iInvoiceRow, "dropship_po")
	iPORowId			= this.GetItemNumber(iInvoiceRow, "dropship_po_row_id")
	nQty				= this.GetItemNumber(iInvoiceRow, "alternative_qty")
	szUM				= this.GetItemString(iInvoiceRow, "alternative_unit")
	iShipper			= this.GetItemNumber(iInvoiceRow, "shipper")
	szPart			= this.GetItemString(iInvoiceRow, "part")
	iOrder			= this.GetItemNumber(iInvoiceRow, "order_no")
	this.Drag(begin!)
End If
	
end on

type dw_invoice_header from datawindow within w_smart_dropship_processor
int X=37
int Y=880
int Width=1335
int Height=544
int TabOrder=60
string DragIcon="MONITOR.ICO"
string DataObject="d_list_of_invoices_for_dropship"
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="MONITOR.ICO"
end type

event dragdrop;Long ll_Row

bDragOrder		= FALSE

st_generic_structure   l_st_parm

ll_Row   = dw_po_detail.GetRow ( )

IF ll_row > 0 THEN
	szVendor = dw_po_detail.GetItemString ( ll_Row, "vendor_code" )
END IF

IF bDragPO then
	bDragPO	= FALSE
	l_st_parm.value1 = string ( w_smart_dropship_processor )
	l_St_parm.value2 = string ( nQty )
	l_st_parm.value3 =  szUM 	
	Openwithparm ( w_prompt_for_invoice_detail_dropship, l_st_parm )
END IF
end event

event doubleclicked;Long 	iRow

iRow	= this.GetClickedRow()

If iRow > 0 then

	If Not this.IsSelected(iRow) then
		If this.GetItemString(iRow, "invoice_printed") <> "Y" then
			MessageBox(monsys.msg_title, "You can only select printed invoices.", StopSign!)
			Return
		End If
	End If

	this.SelectRow(iRow, Not this.IsSelected(iRow))
	If wf_any_invoice_highlighted() then
		bDragInvHeader	= TRUE
	Else
		bDragInvHeader	= FALSE
	End If

End If
end event

on clicked;Long		iRow

iRow	= this.GetClickedRow()

bDragOrder		= FALSE
bDragPO			= FALSE
bDragInvoice	= FALSE

If iRow > 0 then
	iShipper				= this.GetItemNumber(iRow, "id")
	dw_invoice_detail.Retrieve(iShipper)
	If bDragInvHeader	then
		this.Drag(begin!)
	End If
End If
end on

type gb_4 from groupbox within w_smart_dropship_processor
int X=1390
int Y=816
int Width=1463
int Height=624
int TabOrder=70
string Text="Invoice Detail"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_smart_dropship_processor
int X=18
int Y=816
int Width=1371
int Height=624
int TabOrder=110
string Text="Invoice Header"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_smart_dropship_processor
int X=1390
int Width=1463
int Height=816
int TabOrder=20
string Text="P.O.   Detail"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_smart_dropship_processor
int X=18
int Width=1371
int Height=816
int TabOrder=10
string Text="Order Detail"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


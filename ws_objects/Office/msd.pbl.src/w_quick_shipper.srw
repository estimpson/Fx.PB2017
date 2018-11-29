$PBExportHeader$w_quick_shipper.srw
$PBExportComments$Create a shipper by scanning objects
forward
global type w_quick_shipper from window
end type
type p_trash from picture within w_quick_shipper
end type
type dw_objects from datawindow within w_quick_shipper
end type
type dw_objects_per_shipper from datawindow within w_quick_shipper
end type
type dw_pallets from datawindow within w_quick_shipper
end type
type dw_object_info from datawindow within w_quick_shipper
end type
type mle_scan_out from multilineedit within w_quick_shipper
end type
type cb_scan_out from commandbutton within w_quick_shipper
end type
type dw_view_boxes_on_pallet from datawindow within w_quick_shipper
end type
type mle_message from multilineedit within w_quick_shipper
end type
type st_reason from statictext within w_quick_shipper
end type
type st_6 from statictext within w_quick_shipper
end type
type p_5 from picture within w_quick_shipper
end type
type st_5 from statictext within w_quick_shipper
end type
type p_4 from picture within w_quick_shipper
end type
type sle_percentage from singlelineedit within w_quick_shipper
end type
type sle_base from singlelineedit within w_quick_shipper
end type
type st_success from statictext within w_quick_shipper
end type
type sle_serial from singlelineedit within w_quick_shipper
end type
type st_shipper from statictext within w_quick_shipper
end type
type dw_shipper_detail from datawindow within w_quick_shipper
end type
type uo_for_note from uo_note within w_quick_shipper
end type
type dw_destination from datawindow within w_quick_shipper
end type
type st_destination from statictext within w_quick_shipper
end type
type st_3 from statictext within w_quick_shipper
end type
type st_2 from statictext within w_quick_shipper
end type
type p_3 from picture within w_quick_shipper
end type
type p_2 from picture within w_quick_shipper
end type
type st_1 from statictext within w_quick_shipper
end type
type p_1 from picture within w_quick_shipper
end type
type dw_shipper_header from datawindow within w_quick_shipper
end type
type gb_3 from groupbox within w_quick_shipper
end type
type gb_2 from groupbox within w_quick_shipper
end type
type sle_reason from multilineedit within w_quick_shipper
end type
type dw_object from datawindow within w_quick_shipper
end type
type gb_1 from groupbox within w_quick_shipper
end type
type uo_shipper from u_create_shipper_header within w_quick_shipper
end type
end forward

global type w_quick_shipper from window
integer y = 8
integer width = 2917
integer height = 1976
boolean titlebar = true
string title = "Quick Shipper Processor"
string menuname = "m_quick_shipper"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 77897888
event create_shipper pbm_custom03
event create_shipper_header pbm_custom01
event close_shipper_uo pbm_custom02
event exit_system pbm_custom04
event save_note pbm_custom05
event close_uo_note pbm_custom06
event ue_print pbm_custom07
event ue_scan_to_truck pbm_custom08
event ue_update_print_status pbm_custom09
event ue_print_update ( string a_b_form_type )
event ue_print_certs ( )
event ue_custom_form ( )
event ue_dest_label ( )
p_trash p_trash
dw_objects dw_objects
dw_objects_per_shipper dw_objects_per_shipper
dw_pallets dw_pallets
dw_object_info dw_object_info
mle_scan_out mle_scan_out
cb_scan_out cb_scan_out
dw_view_boxes_on_pallet dw_view_boxes_on_pallet
mle_message mle_message
st_reason st_reason
st_6 st_6
p_5 p_5
st_5 st_5
p_4 p_4
sle_percentage sle_percentage
sle_base sle_base
st_success st_success
sle_serial sle_serial
st_shipper st_shipper
dw_shipper_detail dw_shipper_detail
uo_for_note uo_for_note
dw_destination dw_destination
st_destination st_destination
st_3 st_3
st_2 st_2
p_3 p_3
p_2 p_2
st_1 st_1
p_1 p_1
dw_shipper_header dw_shipper_header
gb_3 gb_3
gb_2 gb_2
sle_reason sle_reason
dw_object dw_object
gb_1 gb_1
uo_shipper uo_shipper
end type
global w_quick_shipper w_quick_shipper

type variables
string 	is_status,&
	is_status_type
String szPart
String szVendor
String szUnit
String szVendorPart
String szDescription
String szLot
String szStatus
String szPoNumber
String szDestination
String szPlant
String szCustomer
String szHeadNote
String szFootNote
String szMode
String szProNumber
string  is_MLE_Line1, is_MLE_Line2, is_MLE_Line3
string  szShipperType
string  is_vendor
string  is_operator
string  szsalesman
string  szpartnote
string  szgroupno
string  i_s_calc_type
string is_TruckNumber

Long  lPoNumber
Long  lSerial
Long  iShipper
Long  iShipperRow = 0
Long  iSuffix
long   iserialfileno
long   isalesorder

Dec   dQuantity
Dec   nUnitWeight
Dec   nTareWeight
Dec   nStdQty

DataWindowChild dwcDest
DataWindowChild dwcDestList

Boolean bValidSerial = FALSE  //Whether a valid serial# scanned
Boolean bValidDestination = FALSE
Boolean i_b_sucess = False
boolean	ib_serial_focus
boolean   b_retrieve
boolean   btype
boolean	i_b_will_call
boolean	i_b_manual

datetime	idt_dateshipped
end variables

forward prototypes
public subroutine disable_entry ()
public subroutine enable_entry ()
public function boolean wf_check_data (long iserial)
public subroutine wf_delay ()
public function boolean wf_ready_for_scan ()
public subroutine wf_enter_operation_data ()
public function boolean wf_reset_total_cost ()
public function boolean wf_scan_objects_to_truck ()
public function boolean wf_set_shipped_datetime ()
public function boolean wf_set_bol_status ()
public function long wf_get_next_invoice ()
public function boolean wf_update_onhand ()
public subroutine wf_reset_printed_flag ()
public function boolean wf_set_status (integer iboxes)
public function boolean wf_set_pro_number ()
public function decimal wf_get_price (string a_s_customer, string a_s_part, decimal a_dec_qty)
public function decimal wf_recalc_prices (string ls_part, string ls_customer)
public function boolean wf_undo_serial (long a_l_serial, string a_s_part, decimal a_dec_qty, string a_s_unit)
public function boolean wf_update_cost (string a_s_part, long a_l_suffix, decimal a_n_cost)
public subroutine wf_update_shipper_detail (long a_l_shipper)
public function boolean wf_update_shipper_header (long a_l_shipper)
public function boolean wf_part_exists_in_shipper (long a_l_shipper, string a_s_part)
public function boolean wf_create_shipper_detail (long a_l_shipper, string a_s_part, decimal a_n_qtypacked, string a_s_unit, decimal a_n_tareweight, decimal a_n_netweight, decimal a_n_grossweight)
public function boolean wf_select_vendor_part (string a_s_vendor, string a_s_part)
public function string wf_get_vendor_code (long a_l_po)
public function string wf_get_customer (string a_s_destination)
public function string wf_get_vendor (string a_s_destination)
public subroutine wf_retrieve_object_info (long a_l_serial)
public function boolean wf_verify_destination (string a_s_vendor, string a_s_destination)
public subroutine wf_set_mode (string a_s_mode)
public function string wf_get_salesman (string a_s_customer)
public function boolean wf_ship_out_box (long iserial)
public function decimal wf_get_part_price (string a_s_part, long a_l_suffix)
public function boolean wf_add_part_to_shipper_detail (long a_l_shipper, string a_s_part, decimal a_n_qty, string a_s_unit, boolean a_b_mode)
public subroutine wf_print_invoice (long l_l_invoice, long l_l_shipper)
end prototypes

event create_shipper;If Not bValidDestination then
	MessageBox(monsys.msg_title, "Please select destination first.", StopSign!)
	Return 
End If

szHeadNote				= ''
uo_shipper.visible	= TRUE
uo_shipper.uf_setup(w_quick_shipper, szDestination, szCustomer, szPlant)

end event

event create_shipper_header;/* 01-31-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iShipper' (next Shipper number).  */

//bFinish	= FALSE																													-  CHG 01-31-2000 KAZ
//OpenWithParm(w_get_parm_value, "shipper")																					-  CHG 01-31-2000 KAZ
//Do while Not bFinish																												-  CHG 01-31-2000 KAZ
//Loop																																	-  CHG 01-31-2000 KAZ
//
//iShipper	= Message.DoubleParm																									-  CHG 01-31-2000 KAZ

if not sqlca.of_getnextparmvalue ( "shipper", iShipper ) then    // Failed to get current value 			-  ADD 01-31-2000 KAZ
	Rollback;																															// ADD 01-31-2000 KAZ
	MessageBox(monsys.msg_title, "Failed to get a new Shipper number, Please try again", Exclamation! )	// ADD 01-31-2000 KAZ
	Return																																// ADD 01-31-2000 KAZ
end if																																	// ADD 01-31-2000 KAZ


If iShipper > 0 then

	uo_shipper.dw_shipper_header.SetItem(1, "id", iShipper)
	uo_shipper.dw_shipper_header.SetItem(1, "notes", szHeadNote)

	If szMode	= "Return to Vendor" then
		uo_shipper.dw_shipper_header.SetItem(1, "type", 'V')
		uo_shipper.dw_shipper_header.SetItem(1, "customer", szVendor)
	Else
		If szMode = "Outside Process" then
			uo_shipper.dw_shipper_header.SetItem(1, "type", "O")
		Elseif szMode = "Quick Shipper" Then
			uo_shipper.dw_shipper_header.SetItem(1, "type", "Q")
		End If
	End If

	If uo_shipper.dw_shipper_header.Update() > 0 then
		Commit;
		dw_shipper_header.Retrieve(szDestination)
		If szMode = "Return to Vendor" then
			wf_delay()
			wf_update_shipper_detail(iShipper)
		End If
		If dw_shipper_header.RowCount ( ) > 0 Then
			dw_shipper_header.SetRow ( dw_shipper_header.RowCount ( ) )
			SelectRow ( dw_shipper_header, 0, False )
			SelectRow ( dw_shipper_header, dw_shipper_header.RowCount ( ), True )
			dw_object_info.Retrieve ( ishipper )
			dw_shipper_header.TriggerEvent ( clicked! )
		End if
	Else
		Rollback;
	End If

Else
	MessageBox(monsys.msg_title, "Failed to create a new shipper, please try again.", StopSign!)
End If

uo_shipper.visible	= FALSE
bValidSerial			= FALSE
bValidDestination		= FALSE

dw_object.Reset()
dw_object.InsertRow(1)

mle_message.visible	= FALSE

end event

on close_shipper_uo;uo_shipper.visible	= FALSE

end on

on exit_system;SetPointer ( Hourglass! )
w_shipping_mdi_screen.ChangeMenu(m_list_of_shippers)
Close(w_quick_shipper)
end on

on save_note;szHeadNote	= uo_shipper.uo_header_note.mle_note.text
uo_shipper.uo_header_note.visible	= FALSE
uo_shipper.cb_save.visible				= TRUE
uo_shipper.cb_exit.visible				= TRUE
uo_shipper.p_note.PictureName			= "noteyes.bmp"
uo_shipper.szHeadNote					= szHeadNote
end on

on close_uo_note;uo_shipper.uo_header_note.visible	= FALSE
uo_shipper.cb_save.visible				= TRUE
uo_shipper.cb_exit.visible				= TRUE
uo_shipper.p_note.PictureName			= "noteyes.bmp"
end on

event ue_print;
st_print_preview_generic stParm

If iShipper < 1 Then Return

If szMode = "Outside Process" Then
	stParm.Form_type 			= "Outside Process"
ElseIf szMode = "Return to Vendor" Then	
	stParm.Form_type 			= "Packlist Ret Vendor"
Else
	stParm.Form_type 			= "Quick Shipper"
End if
stParm.Calling_window	= This
stParm.Document_number	= iShipper

OpenSheetWithParm ( w_form_print_preview, stParm, gnv_App.of_GetFrame(), 3, Original! )


end event

event ue_scan_to_truck;Long	l_i_Row			//To keep the current row number
Long	l_l_TotalObjects	//To keep the total objects
Long	l_l_TotalItems		//To keep the total shipper detail items
Long	l_l_Invoice
Decimal l_n_Qty			//To keep the quantity
Decimal l_n_OurCum		//To keep the our cum
String  l_s_Part		//To keep the part number
String  l_s_OrderType		//To keep the type of the sales order
Boolean l_b_OK = TRUE

//	Check that this shipper is staged.
if sqlca.of_CheckShipper ( iShipper ) = 0 then
	
	//	Open w_pro_window for accecpting pro number & operator.
	OpenWithParm(w_enter_opertor_code, "w_quick_shipper")
	
	//	Check that operator code is valid.
	if IsNull ( is_Operator, '' ) > '' then
		
		//	Perform shipout of shipper with pro number, truck numbe, & operator as arguments.
		SetMicroHelp ( "Processing shipper " + String ( iShipper ) + ".  Please wait..." )
		SetPointer ( HourGlass! )
		
		if sqlca.of_ShipOut ( ishipper, szpronumber, is_TruckNumber, is_operator, l_l_Invoice, idt_dateshipped ) = 0 then
			
			//	Update KANBAN info.
			sqlca.of_UpdateKanbanInfo ( ishipper )
			
			//	Commit transaction
			sqlca.uf_Commit ( )
			
			//	Report invoice number.
			SetMicroHelp ( "Successfully processed shipper " + String ( iShipper ) + "." )
			
			If btype Then
				wf_print_invoice ( l_l_Invoice, iShipper )
			End If
			Close ( w_shipping_dock )
			
		else
			sqlca.uf_RollBack ( )
			
			//	Report errors.
			MessageBox ( monsys.msg_title, sqlca.MONErrText )
		end if
	else
		Messagebox ( monsys.msg_title, 'Invalid operator code.', StopSign! )
	end if
else
	sqlca.uf_Rollback ( )
end if

SetPointer ( Arrow! )

end event

event ue_update_print_status;UPDATE shipper  
   SET printed = 'Y'  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

end event

event ue_print_update;STRING l_s_type

a_b_form_type = string (Message.LongParm, "address")

MessageBox(monsys.msg_title, a_b_form_type + " has been printed")

UPDATE shipper  
  	SET printed = 'Y'  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If





end event

event ue_print_certs();
st_print_preview_generic stParm
stParm.Form_type			= "Engineering Certs - Quick"
stParm.Document_number	= iShipper
stParm.Calling_window		= w_quick_shipper

OpenSheetWithParm (w_form_print_preview, stParm, gnv_App.of_GetFrame(), 3, Original!)
end event

event ue_custom_form();
st_print_preview_generic  l_st_Parm

l_st_Parm.document_number = iShipper
l_st_Parm.form_type		  = 'Canadian Custom - Quick'

OpenSheetwithParm (w_form_print_preview,  l_st_Parm, gnv_App.of_GetFrame(), 3, Original! )

this.SetMicroHelp("Ready") 


end event

event ue_dest_label;OpenWithParm(w_std_ship_label, szDestination)
end event

public subroutine disable_entry ();dw_object.SetTabOrder ( "quantity", 0 )
dw_object.SetTabOrder ( "unit", 0 )
dw_object.SetTabOrder ( "destination", 0 )
end subroutine

public subroutine enable_entry ();//dw_object.SetTabOrder ( "quantity", 20 )
//dw_object.SetTabOrder ( "unit", 30 )
//If ddlb_mode.text = "Return to Vendor" then
//	dw_object.SetTabOrder ( "destination", 40 )
//End If
end subroutine

public function boolean wf_check_data (long iserial);Long		iTemp
Long		iCurrentShipper
String	l_s_po
string	ls_part
string	ls_status
int		li_found

If szMode <> "Return to Vendor" then
	If IsNull(szDestination) then
		MessageBox(monsys.msg_title, "Please select a destination first.", StopSign!)
		Return FALSE
	End If

	If iShipper = 0 or IsNull(iShipper) then
		MessageBox(monsys.msg_title, "Please create shipper or select from shipper list first.", StopSign!)
		Return FALSE
	End If
End If

SetNull(iTemp)

SELECT serial, shipper, po_number, part, status
  INTO :iTemp, :iCurrentShipper, :l_s_po, :ls_part, :ls_status
  FROM object  
 WHERE serial = :iSerial   ;

if ls_status <> 'A' then
	MessageBox(monsys.msg_title, "This object's status is other than approved!", StopSign!)
	Return FALSE
end if

If IsNull(iTemp) then
	MessageBox(monsys.msg_title, "Serial number is not found.", StopSign!)
	Return FALSE
Else
	If iCurrentShipper > 0 then
		MessageBox(monsys.msg_title, "The object is already staged on shipper " + String(iCurrentShipper), StopSign!)
		Return FALSE
	Else
		If szMode = 'Return to Vendor' then
			If Long ( l_s_po ) > 0 then
				//iShipper			= 0
				SetNull(szDestination)
				szVendor	= wf_get_vendor_code(Long ( l_s_po ))
				dwcDestList.SetFilter("vendor = '" + szVendor + "'")
				dwcDestList.Filter()
			Else
				MessageBox(monsys.msg_title, "PO number is not found.", StopSign!)
				Return FALSE
			End If
		Elseif szMode = "Outside Process" then
			select	1
			into		:li_found
			from		part_vendor
			where		part = :ls_part and
						vendor = :szvendor ;
						
			if IsNull(li_found,0) = 0 then
				MessageBox(monsys.msg_title, "Part / Vendor relationship was not found.  Please verify that this was setup correctly.", StopSign!)
				Return FALSE
			end if
		elseIf szMode = 'Quick Shipper' then	
			select	isnull(count (1),0)
			into	:li_found
			from 	part_customer
			where	part = :ls_part and 
				customer = :szcustomer;
				
			if IsNull(li_found,0) = 0 then
				MessageBox(monsys.msg_title, "Part / Customer relationship is not defined for this part.  Please verify that this was setup correctly.", Exclamation!)
//				Return FALSE
			end if
		End If
	End If
End If

Return TRUE

end function

public subroutine wf_delay ();Long	iCount

sle_percentage.visible	= FALSE
sle_percentage.width		= 0
sle_base.visible			= TRUE
sle_percentage.visible	= TRUE

For iCount = 1 to	50
	sle_percentage.width	= sle_base.width * iCount / 50
Next

sle_base.visible			= FALSE
sle_percentage.visible	= FALSE		


end subroutine

public function boolean wf_ready_for_scan ();string	l_s_printed

//If wf_shipper_is_closed(iShipper) then
//	MessageBox("Warning", "This shipper is already closed by another user!", StopSign!)
//	Close(w_shipping_dock)
//End If

if i_b_will_call Then

	wf_reset_printed_flag()

else

	SELECT 	shipper.printed
	INTO 		:l_s_printed  
	FROM 		shipper
	WHERE		shipper.id = :ishipper   ;

	If Upper ( l_s_printed ) <> 'Y' then
		MessageBox(monsys.msg_title, "Document has not been printed", StopSign! )
		Return FALSE
	End If

end If

Return TRUE


end function

public subroutine wf_enter_operation_data ();OpenWithParm(w_enter_opertor_code, "w_quick_shipper" )
end subroutine

public function boolean wf_reset_total_cost ();UPDATE shipper_detail  
   SET total_cost = 0  
 WHERE shipper = :iShipper   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If	
end function

public function boolean wf_scan_objects_to_truck ();Long iRow
Long iTotalObjects

Boolean bOK

dw_objects_per_shipper.Retrieve ( ishipper )

iTotalObjects	= dw_objects_per_shipper.RowCount()
iRow				= 1
bOK				= True

//Scan objects to truck

Do while bOK AND (iRow <= iTotalObjects) 
	is_MLE_Line2 = 'Object ' + String ( iRow ) + ' of ' + String ( iTotalObjects ) + '.'
	mle_scan_out.Text = is_MLE_Line1 + '~r~n' + is_MLE_Line2 + '~r~n' + is_MLE_Line3
	bOK	= wf_ship_out_box(dw_objects_per_shipper.GetItemNumber(iRow, "serial"))
	iRow ++
Loop

Return bOK
end function

public function boolean wf_set_shipped_datetime ();long	ll_row
long	ll_rowcount


ll_row = dw_shipper_header.GetRow ( )

If ll_row > 0 then

	dw_shipper_header.SetItem(ll_row, "date_shipped", idt_dateshipped)
	dw_shipper_header.SetItem(ll_row, "time_shipped", idt_dateshipped)
	
	If dw_shipper_header.Update () > 0 then
		
		ll_rowcount = dw_shipper_detail.RowCount ( )
		for ll_row = 1 to ll_rowcount
			dw_shipper_detail.SetITem ( ll_row, "date_shipped", idt_dateshipped)
		next
		
		if dw_shipper_detail.Update ( ) = 1 then
			return TRUE
		else
			return FALSE
		end if
	Else
		Return FALSE
	End If
Else
	Return False
End If

end function

public function boolean wf_set_bol_status ();return TRUE
end function

public function long wf_get_next_invoice ();Long		l_Invoice
Int		i_Count, &
			i_Loop = 1
Boolean	b_Done

Do
	SELECT next_invoice INTO :l_Invoice FROM parameters ;
	If SQLCA.SQLCode <> 0 Then Return -1
	UPDATE parameters SET next_invoice = :l_Invoice + 1 ;
	If SQLCA.SQLCode <> 0 Then 
		RollBack ;
	Else
		Commit ;
	End if
	SELECT Count ( * ) INTO :i_Count FROM SHIPPER WHERE INVOICE_NUMBER = :l_Invoice ;
	If f_get_value ( i_Count ) < 1 Then b_Done = True
	i_Loop++
Loop While Not b_Done And i_Loop < 10

If b_Done Then 
	Return l_Invoice
Else
	Return -1
End if
end function

public function boolean wf_update_onhand ();//	Update Onhand
//	boolean wf_update_onhand ( )
//	October 2, 1996
//	Eric E Stimpson

// Declarations...
STRING	s_Part
LONG		l_OnHand, &
			l_StdQtyPacked

IF szShipperType = 'O' THEN
	Return TRUE
END IF

 DECLARE	shipdetail CURSOR FOR  
  SELECT	part_original,
			qty_packed
    FROM	shipper_detail
   WHERE	shipper = :iShipper  ;

    OPEN	shipdetail  ;

   Fetch shipdetail Into :s_Part, :l_StdQtyPacked  ;

IF SQLCA.SQLCode = 0 THEN
	DO
		SetNull ( l_OnHand)

		  SELECT	on_hand
		    INTO	:l_OnHand
		    FROM	part_online
		   WHERE	part = :s_Part  ;

		IF IsNull ( l_OnHand ) THEN
			MessageBox ( monsys.msg_title, "Part_Online table entry expected for " + s_Part + " but not found!" )

			   Close	shipdetail  ;

			Return FALSE
		END IF
		l_OnHand -= l_StdQtyPacked
		IF l_OnHand < 0 THEN
			MessageBox ( monsys.msg_title, "Part_Online table shows less of " + s_Part + " than expected!" )

			   Close	shipdetail  ;

			Return FALSE
		END IF

		  UPDATE	part_online
		     SET	on_hand = :l_OnHand
		   WHERE	part = :s_Part  ;

		IF SQLCA.SQLCode <> 0 THEN
			MessageBox ( monsys.msg_title, "Unable to update Part_Online table for part " + s_Part + "!" )

			   Close	shipdetail  ;

			Return FALSE
		END IF

	      Fetch shipdetail Into :s_Part, :l_StdQtyPacked  ;

	LOOP WHILE (SQLCA.SQLCode = 0)
END IF

   Close	shipdetail  ;
	commit  ;

Return TRUE
end function

public subroutine wf_reset_printed_flag ();UPDATE shipper
SET printed = 'Y'
WHERE id = :ishipper ;	


end subroutine

public function boolean wf_set_status (integer iboxes);w_list_of_active_shippers.bStaged	= FALSE
w_list_of_active_shippers.bPrinted  = FALSE

UPDATE shipper  
   SET status 				= 'C',   
       staged_objs 		= :w_list_of_active_shippers.iBoxes
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	MessageBox ( monsys.msg_title, SQLCA.SQLErrText )
	Return FALSE
Else
	b_Retrieve = TRUE
	Return TRUE
End If

end function

public function boolean wf_set_pro_number ();UPDATE shipper  
   SET pro_number = :szPronumber  
WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	return FALSE
Else
	return TRUE
End If

end function

public function decimal wf_get_price (string a_s_customer, string a_s_part, decimal a_dec_qty);int		li_row
string	l_s_price_type
dec		l_dec_qty_break,&
			ldec_price

SELECT part_customer.type  
  INTO :l_s_price_type  
  FROM part_customer  
 WHERE ( part_customer.part = :a_s_part ) AND  
       ( part_customer.customer = :a_s_customer )   ;

if l_s_price_type = "B" then
	SELECT max(qty_break)
	  INTO :l_dec_qty_break
	  FROM part_customer_price_matrix  
	 WHERE ( part = :a_s_part ) AND  
	       ( customer = :a_s_customer ) AND  
	       ( qty_break < :a_dec_qty )   ;
	if sqlca.sqlcode = 0 then
	  	SELECT price
	     INTO :ldec_price  
	     FROM part_customer_price_matrix  
	    WHERE ( part = :a_s_part ) AND  
	          ( customer = :a_s_customer ) AND  
	          ( qty_break = :l_dec_qty_break )   ;
	end if
	if f_get_value ( ldec_price ) = 0 then
  		SELECT part_standard.price  
    	  INTO :ldec_price  
    	  FROM part_standard  
   	 WHERE part_standard.part = :a_s_part   ;
	end if
else

  	SELECT price
     INTO :ldec_price  
     FROM part_customer_price_matrix  
    WHERE ( part = :a_s_part ) AND  
          ( customer = :a_s_customer ) ;
	
	ldec_price = f_get_value ( ldec_price )

	If ldec_price <= 0 and l_s_price_type = 'C' then
		ldec_price =  wf_recalc_prices(a_s_part, a_s_customer)
	End If

	if ldec_price = 0 then
  		SELECT part_standard.price  
    	  INTO :ldec_price  
    	  FROM part_standard  
   	 WHERE part_standard.part = :a_s_part   ;
	end if
end if

return f_get_value ( ldec_price )

end function

public function decimal wf_recalc_prices (string ls_part, string ls_customer);long				ll_current_row,&
					ll_count
boolean			lb_done
string			ls_category, &
					ls_premium,&
					ls_type
dec				ldec_markup,&
					ldec_premium,&
					ldec_price,&
					ldec_std_price,&
					ldec_new_premium


SELECT category
INTO 	 :ls_category
FROM   customer
WHERE  customer = :ls_customer ;

If SQLCA.SQLCODE = 0 then

	SELECT code,
      	 markup,
   	    premium,
	       multiplier
	INTO	:ls_category,		
			:ldec_markup,		
			:ldec_premium,	
			:ls_type	
	FROM  category
	WHERE code = :ls_category ;
      
	SELECT price, premium
	  INTO :ldec_std_price,
			 :ls_premium  
	  FROM part_standard  
	 WHERE part_standard.part = :ls_part   ;

		if f_get_string_value ( upper ( ls_premium ) ) <> "Y" then
			ldec_new_premium = 0
		end if

			Choose Case ls_type
					Case "+"
						ldec_price = ldec_std_price + ldec_markup + ldec_new_premium
					Case "-"
						ldec_price = ldec_std_price - ldec_markup + ldec_new_premium
					Case "%"
						ldec_price = ldec_std_price + ( ldec_std_price * ldec_markup ) + ldec_new_premium
					Case "x"
						ldec_price = ldec_std_price * ldec_markup + ldec_new_premium
			End Choose

End If

If ldec_price > 0 then
	Return ldec_price
else
   Return 0
End If
end function

public function boolean wf_undo_serial (long a_l_serial, string a_s_part, decimal a_dec_qty, string a_s_unit);long		l_l_shipper

wf_add_part_to_shipper_detail(iShipper, a_s_part, a_dec_qty, a_s_unit, FALSE)
SetNull ( l_l_shipper )

UPDATE	object
SET		shipper = :l_l_shipper
WHERE 	serial = :a_l_serial ;

if sqlca.sqlcode <> 0 then
	rollback;
else
	commit;
end if

return TRUE
end function

public function boolean wf_update_cost (string a_s_part, long a_l_suffix, decimal a_n_cost);If iSuffix > 0 then
  Update shipper_detail
  Set 	total_cost = :a_n_Cost  //total_cost + :nCost  
  Where 	( shipper = :iShipper ) And 
         ( part_original = :a_s_Part) And  
         ( suffix = :a_l_Suffix )   ;
Else
  Update shipper_detail  
  Set 	total_cost = :a_n_Cost  //total_cost + :nCost  
  Where 	( shipper = :iShipper ) And 
         ( part = :a_s_Part );
End If

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public subroutine wf_update_shipper_detail (long a_l_shipper);/* Included this check not to add invalid rows to ship.detail table - mb - 1/21/99 */
/* 01-31-2000 KAZ Modified to place the rollbacks before the message boxes to release 
						the database to avoid deadlocks.     */

	
IF szPart > '' AND a_l_shipper > 0 THEN 
	
	If wf_part_exists_in_shipper(a_l_Shipper, szPart) then
		If wf_add_part_to_shipper_detail(a_l_Shipper, szPart, dQuantity, szUnit, TRUE) then
			Commit;
			f_beep(1)
			dw_shipper_detail.Retrieve(a_l_Shipper)
			dw_object.Reset()
			dw_object.InsertRow(1)
			bValidSerial	= FALSE
		Else
			Rollback;																								// CHG 01-31-2000 KAZ
			f_beep(3)
			MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
//			Rollback;																								-  CHG 01-31-2000 KAZ
		End If
	Else
		If wf_create_shipper_detail(a_l_Shipper, szPart, dQuantity, szUnit, 0, 0, 0) then
			f_beep(1)
			Commit;
			dw_shipper_detail.Retrieve(a_l_Shipper)
		Else
			Rollback;																								// CHG 01-31-2000 KAZ
			MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
//			Rollback;																								-  CHG 01-31-2000 KAZ
		End If
	End If

END IF

dw_shipper_detail.SelectRow ( 0, FALSE )
dw_shipper_detail.SelectRow ( dw_shipper_detail.Find ( "part='" + szPart + "'", 1, dw_shipper_detail.RowCount ( ) ), TRUE )
end subroutine

public function boolean wf_update_shipper_header (long a_l_shipper);/* 01-31-2000 KAZ Modified to place the rollback before the message box to release the 
						database to avoid deadlocks.     */

UPDATE	Shipper
SET		Printed = 'N'
WHERE		Id = :a_l_Shipper;

If SQLCA.SQLCode = 0 then
	dw_shipper_header.SetItem(iShipperRow, "printed", 'N')
	Return TRUE
Else
	Rollback;																			// CHG 01-31-2000 KAZ
	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
//	ROLLBACK;																			-  CHG 01-31-2000 KAZ
	Return FALSE
End If
end function

public function boolean wf_part_exists_in_shipper (long a_l_shipper, string a_s_part);Long l_i_CurrentShipper

Select shipper_detail.shipper  
  Into :l_i_CurrentShipper  
  From shipper_detail  
 Where ( shipper_detail.shipper 	= :a_l_Shipper ) AND  
       ( shipper_detail.part 		= :a_s_Part ) ;


If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public function boolean wf_create_shipper_detail (long a_l_shipper, string a_s_part, decimal a_n_qtypacked, string a_s_unit, decimal a_n_tareweight, decimal a_n_netweight, decimal a_n_grossweight);Decimal 	a_n_StdQtyPacked
Decimal	nStdPrice
dec		l_dec_calc_qty

String	l_s_PartNote
String	l_s_PartName
String	l_s_GLAccount
String	l_s_Salesman
String	l_s_CrossRef
string	ls_taxable

l_s_PartNote		= sle_reason.text
l_s_PartName		= f_get_part_info(a_s_part, "NAME")
l_s_GLAccount		= f_get_part_info(a_s_part, "MFG GL ACCOUNT")

if isnull(l_s_GLAccount,'') = '' then
	l_s_GLAccount = f_get_part_info(a_s_part, "GL ACCOUNT")
end if

//nStdPrice		= Dec(f_get_part_info(a_s_part, "STANDARD PRICE"))
l_s_Salesman		= wf_get_salesman(szCustomer)
l_s_CrossRef		= f_get_part_info(a_s_part, "CROSS REF")

a_n_StdQtyPacked	= f_convert_units(a_s_unit, "", a_s_part, a_n_QtyPacked) 

if f_get_calc_type ( ) = "alternative_qty" then
	l_dec_calc_qty = a_n_StdQtyPacked
else
	l_dec_calc_qty = a_n_NetWeight
end if
nStdPrice		= f_calculate_customer_price ( a_s_part, szCustomer, l_dec_calc_qty )

select	taxable
into		:ls_taxable
from		part_customer
where		customer = :szCustomer and
			part = :a_s_part ;
			
  Insert Into shipper_detail  
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
           price,   
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
			  part_original)  
  Values ( :a_l_shipper,   
           :a_s_part,   
           :a_n_QtyPacked,   
           :a_n_StdQtyPacked,   
           :a_n_QtyPacked,   
           null,   
           0,   
           null,   
           null,   
           null,   
           null,   
           :nStdPrice,   
           :l_s_GLAccount,   
           :l_s_Salesman,   
           :a_n_TareWeight,   
           :nUnitWeight,   
           :a_n_NetWeight,   
           null,   
           null,   
           null,   
           :l_s_PartNote,   
           null,   
           1,   
           null,   
           :a_n_QtyPacked,   
           :a_s_unit,   
           null,   
           :ls_taxable,   
           null,   
           null,   
           :l_s_CrossRef,   
           null,   
           null,   
           null,
			  :l_s_PartName,
			  :a_s_part )  ;

If SQLCA.SQLCode = 0 then

	update	shipper
	set		status = 'S'
	where		id = :a_l_shipper ;
	
	if sqlca.sqlcode = 0 then
		
		Update object  
		Set shipper 			= :a_l_shipper,
			 show_on_shipper 	= 'Y' 
		Where serial 	= :lSerial   ;
	
		If SQLCA.SQLCode = 0 then
			Return TRUE
		Else
			Return FALSE		
		End If
	else
		return FALSE
	end if

Else
	Return FALSE
End If

end function

public function boolean wf_select_vendor_part (string a_s_vendor, string a_s_part);SELECT part_vendor.vendor_part  
  INTO :szVendorPart  
  FROM part_vendor  
 WHERE ( part_vendor.part = :a_s_Part ) AND  
       ( part_vendor.vendor = :a_s_Vendor )   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public function string wf_get_vendor_code (long a_l_po);String l_s_Vendor

SELECT vendor_code  
  INTO :l_s_Vendor  
  FROM po_header  
 WHERE po_number = :a_l_PO   ;

Return l_s_Vendor
end function

public function string wf_get_customer (string a_s_destination);String l_s_Customer

SELECT customer  
  INTO :l_s_Customer  
  FROM destination  
 WHERE destination = :a_s_Destination   ;

Return l_s_Customer
end function

public function string wf_get_vendor (string a_s_destination);String l_s_Vendor

SELECT customer  
  INTO :l_s_Vendor 
  FROM destination  
 WHERE destination = :a_s_Destination   ;

Return l_s_Vendor
end function

public subroutine wf_retrieve_object_info (long a_l_serial);Long	l_l_Shipper

l_l_Shipper = 0

SELECT 	serial,   
       	part,   
       	unit_measure,   
       	po_number,   
       	quantity,
			lot,
			status,
			tare_weight,
			weight,
			std_quantity, 
			shipper			
  INTO 	:lSerial,   
         :szPart,   
         :szUnit,   
         :szPoNumber,   
         :dQuantity,
			:szLot,
			:szStatus,
			:nTareWeight,
			:nUnitWeight,
			:nStdQty,
			:l_l_Shipper
    FROM object  
    WHERE serial = :lSerial   ;
	

	szPart     		= f_get_string_value ( szPart )
	szUnit     		= f_get_string_value ( szUnit )
	szPoNumber 		= f_get_string_value ( szPoNumber )
	dQuantity  		= f_get_value ( dQuantity )
	szLot      		= f_get_string_value ( szLot )
	szStatus   		= f_get_string_value ( szStatus )
	szDescription 	= f_get_part_info(szPart, "NAME")


end subroutine

public function boolean wf_verify_destination (string a_s_vendor, string a_s_destination);String	l_s_Temp

SetNull(l_s_Temp)

SELECT destination  
  INTO :l_s_Temp  
  FROM destination  
 WHERE ( vendor 			= :a_s_Vendor ) AND  
       ( destination 	= :a_s_Destination );

If IsNull(l_s_Temp) then
	Return FALSE
Else
	Return TRUE
End If
end function

public subroutine wf_set_mode (string a_s_mode);szDestination		= ''
bValidDestination	= FALSE
iShipper				= 0

If a_s_mode = "Outside Process" then
	dw_destination.DataObject	= "d_external_destination_list_outside"
Else
	dw_destination.DataObject	= "d_external_destination_list"
End If

dwcDestList.Reset()
dwcDestList.Retrieve()

dw_destination.InsertRow(1)
st_destination.visible	= TRUE

If dw_destination.GetChild("destination", dwcDestList) > 0 then
	dwcDestList.SetTransObject(SQLCA)
	dwcDestList.Retrieve()
End If

If a_s_mode	= "Quick Shipper" then
	dwcDestList.SetFilter("customer > '  '")
Else
	dwcDestList.SetFilter("vendor > '  '")
End If

dwcDestList.Filter()

w_quick_shipper.Title	= a_s_mode

sle_serial.SetFocus()

SetNull(szDestination)
dw_shipper_header.Reset()
dw_destination.visible	= TRUE

If a_s_mode = "Return to Vendor" then
	st_reason.text	= "Reason for Return:"

Else
	st_reason.text	= "Part Note:"
End If

end subroutine

public function string wf_get_salesman (string a_s_customer);String	l_s_Salesman

SELECT customer.salesrep  
  INTO :l_s_Salesman  
  FROM customer  
 WHERE customer = :a_s_Customer   ;

Return l_s_Salesman
end function

public function boolean wf_ship_out_box (long iserial);String  	l_s_Part								//Part number

Decimal 	nQty
Decimal	nPrice
Decimal	nCost
dec		l_dec_weight

Boolean	bOk	= TRUE

dw_object_info.Retrieve(iSerial)

If dw_object_info.RowCount() > 0 then

	is_MLE_Line1 		= 'Processing Serial ' + String ( dw_object_info.GetItemNumber ( 1, 'serial' ) ) + '...'
	mle_scan_out.text	= is_MLE_Line1 + '~r~n' + is_MLE_Line2 + '~r~n' + is_MLE_Line3
	l_s_Part      		= dw_object_info.GetItemString(1, "part")
	nQty					= dw_object_info.GetItemNumber(1, "std_quantity")
	iSuffix				= dw_object_info.GetItemNumber(1, "suffix")
	nPrice				= wf_get_part_price(l_s_Part, iSuffix)
	if i_s_calc_type = "alternative_qty" then
		nCost					= f_get_value(dw_object_info.GetItemNumber(1, "cost")) * nQty
	else
		l_dec_weight		= f_get_value ( dw_object_info.GetItemNumber ( 1, "weight" ) )
		nCost					= f_get_value(dw_object_info.GetItemNumber(1, "cost")) * l_dec_weight
	end if
	bOK					= wf_update_cost(l_s_Part, iSuffix, nCost)

	If bOK then
		
		bOk = f_create_audit_trail(iSerial, "S" , String(iShipper), szDestination, szCustomer, is_operator, String(nPrice), szSalesman, szPartNote, szGroupNo, "", "No Commit")
		dw_object_info.DeleteRow(1)

		bOK	= ( dw_object_info.Update() > 0 )

	End If

End If

Return bOk






end function

public function decimal wf_get_part_price (string a_s_part, long a_l_suffix);Decimal nPrice

If a_l_Suffix > 0 then
	Select shipper_detail.price,
			 shipper_detail.salesman,
			 shipper_detail.note,
			 shipper_detail.group_no,
			 shipper_detail.order_no
	  Into :nPrice,
			 :szSalesman,
			 :szPartNote,
			 :szGroupNo,
			 :iSalesOrder 
	  From shipper_detail 
	 Where ( shipper_detail.shipper 	= :iShipper ) AND  
	       ( shipper_detail.part 		= :a_s_Part ) AND  
	       ( shipper_detail.suffix 	= :a_l_Suffix )   ;
Else
	Select shipper_detail.price,  
			 shipper_detail.salesman,
			 shipper_detail.note,
			 shipper_detail.group_no,
			 shipper_detail.order_no
	  Into :nPrice,
			 :szSalesman,
			 :szPartNote,
			 :szGroupNo,
			 :iSalesOrder
	  From shipper_detail  
	 Where ( shipper_detail.shipper 	= :iShipper ) AND  
	       ( shipper_detail.part 		= :a_s_Part ) ; 
End If

Return nPrice

end function

public function boolean wf_add_part_to_shipper_detail (long a_l_shipper, string a_s_part, decimal a_n_qty, string a_s_unit, boolean a_b_mode);Decimal	nQtyPacked
Decimal	nQtyRequired
Decimal	nStdQtyPacked
Decimal	nQtyConverted
dec		l_dec_weight
long		l_i_boxes_staged

String 	szUMPacked
String	a_s_PartNote

Select alternative_qty,   
       alternative_unit,   
       qty_required,   
       qty_packed,  
		 boxes_staged
  Into :nQtyPacked,   
       :szUMPacked,   
       :nQtyRequired,   
       :nStdQtyPacked,
		 :l_i_boxes_staged
  From shipper_detail  
 Where ( shipper 	= :a_l_shipper ) And
       ( part 		= :a_s_part )   ;

nQtyConverted	= f_convert_units(szUnit, f_get_string_value(szUMPacked), a_s_part, a_n_Qty) 
if a_b_mode then
	nQtyPacked		= f_get_value(nQtyPacked) + nQtyConverted
	nQtyRequired	= f_get_value(nQtyRequired) + nQtyConverted
else
	nQtyPacked		= f_get_value(nQtyPacked) - nQtyConverted
	nQtyRequired	= f_get_value(nQtyRequired) - nQtyConverted
end if

nQtyConverted	= f_convert_units(szUnit, "", a_s_part, a_n_Qty)
if a_b_mode then
	nStdQtyPacked	= f_get_value(nStdQtyPacked) + nQtyConverted
	l_i_boxes_staged++
else
	nStdQtyPacked	= f_get_value(nStdQtyPacked) - nQtyConverted
	l_i_boxes_staged --
end if

a_s_PartNote		= sle_reason.text

if l_i_boxes_staged <= 0 then
	delete from shipper_detail
	where shipper = :a_l_shipper and
			part = :a_s_part ;
else
	Update shipper_detail  
		Set qty_packed 		= :nStdQtyPacked,
			 qty_required 		= :nQtyRequired,   
			 alternative_qty	= :nQtyPacked,  
			 note					= :a_s_PartNote,
			 boxes_staged		= :l_i_boxes_staged
	 Where ( shipper = :a_l_shipper ) AND  
			 ( part = :a_s_part );
end if
		
If SQLCA.SQLCode = 0 then

	Update object  
  	Set shipper 			= :a_l_shipper,
		 show_on_shipper 	= 'Y' 
   Where serial 	= :lSerial   ;

	If SQLCA.SQLCode = 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	Return FALSE
End If
end function

public subroutine wf_print_invoice (long l_l_invoice, long l_l_shipper);st_print_preview_generic  l_st_Parm
l_st_Parm.Form_type			= "Invoice"
l_st_Parm.Document_number	= l_l_Invoice
l_st_Parm.Calling_window		= w_quick_shipper

OpenSheetWithParm(w_print_preview, l_st_Parm, gnv_App.of_GetFrame() , 4, Original!)

end subroutine

event open;string	l_s_destination
long		l_l_shipper,&
			l_l_row

SELECT parameters.inv_reg_col  
  INTO :i_s_calc_type  
  FROM parameters  ;

szMode	= Message.StringParm

gnv_App.of_GetFrame().ChangeMenu ( m_quick_shipper )

if szMode <> "Quick Shipper" then
	m_quick_shipper.m_file.m_shipout.Visible = FALSE
	m_quick_shipper.m_file.m_shipout.ToolBarItemVisible = FALSE
	m_quick_shipper.m_file.m_print.Visible = FALSE
	m_quick_shipper.m_file.m_print.ToolBarItemVisible = FALSE
end if

wf_set_mode(szMode)

if szMode = "Quick Shipper" then
	if w_list_of_active_shippers.szReturnedString = "" then // gph prefixed window name on 6/17/98 at 12.12pm
		disable_entry ( )
		SetNull(szDestination)
	else
		l_l_shipper = Long ( w_list_of_active_shippers.szReturnedString ) // gph prefixed window name on 6/17/98 at 12.12pm
		SELECT	shipper.destination  
		INTO 		:l_s_destination  
		FROM 		shipper  
		WHERE 	shipper.id = :l_l_shipper   ;
		dw_destination.SetItem ( 1, "destination", l_s_destination )
		dw_destination.AcceptText ( )
		dw_destination.Trigger Event itemchanged ( 1, dw_destination.object.destination, l_s_destination )
		dw_shipper_header.Retrieve ( l_s_destination )
		l_l_row = dw_shipper_header.Find ( "id = " + String ( l_l_shipper ), 1, dw_shipper_header.RowCount ( ) )
		if l_l_row > 0 then
			if dw_shipper_header.GetItemNumber ( l_l_row, "id" ) = l_l_shipper then
				dw_shipper_header.SetRow ( l_l_row )
				i_b_manual = TRUE
				dw_shipper_header.TriggerEvent ( clicked! )
			end if
		end if
	end if
else

	disable_entry ( )

	SetNull(szDestination)

end if

dw_object.InsertRow ( 1 )

Timer(0.5)

sle_serial.BringToTop	= TRUE
sle_serial.SetFocus()
end event

event activate;if gnv_App.of_GetFrame().MenuName <> "m_quick_shipper" then
	gnv_App.of_GetFrame().ChangeMenu ( m_quick_shipper )
	if szMode <> "Quick Shipper" then
		m_quick_shipper.m_file.m_shipout.Visible = FALSE
		m_quick_shipper.m_file.m_shipout.ToolBarItemVisible = FALSE
		m_quick_shipper.m_file.m_print.Visible = FALSE
		m_quick_shipper.m_file.m_print.ToolBarItemVisible = FALSE
	end if
end if


end event

on timer;If i_b_sucess then
	st_success.visible	= Not st_success.visible
Else
	st_success.visible	= FALSE
End If
end on

on w_quick_shipper.create
if this.MenuName = "m_quick_shipper" then this.MenuID = create m_quick_shipper
this.p_trash=create p_trash
this.dw_objects=create dw_objects
this.dw_objects_per_shipper=create dw_objects_per_shipper
this.dw_pallets=create dw_pallets
this.dw_object_info=create dw_object_info
this.mle_scan_out=create mle_scan_out
this.cb_scan_out=create cb_scan_out
this.dw_view_boxes_on_pallet=create dw_view_boxes_on_pallet
this.mle_message=create mle_message
this.st_reason=create st_reason
this.st_6=create st_6
this.p_5=create p_5
this.st_5=create st_5
this.p_4=create p_4
this.sle_percentage=create sle_percentage
this.sle_base=create sle_base
this.st_success=create st_success
this.sle_serial=create sle_serial
this.st_shipper=create st_shipper
this.dw_shipper_detail=create dw_shipper_detail
this.uo_for_note=create uo_for_note
this.dw_destination=create dw_destination
this.st_destination=create st_destination
this.st_3=create st_3
this.st_2=create st_2
this.p_3=create p_3
this.p_2=create p_2
this.st_1=create st_1
this.p_1=create p_1
this.dw_shipper_header=create dw_shipper_header
this.gb_3=create gb_3
this.gb_2=create gb_2
this.sle_reason=create sle_reason
this.dw_object=create dw_object
this.gb_1=create gb_1
this.uo_shipper=create uo_shipper
this.Control[]={this.p_trash,&
this.dw_objects,&
this.dw_objects_per_shipper,&
this.dw_pallets,&
this.dw_object_info,&
this.mle_scan_out,&
this.cb_scan_out,&
this.dw_view_boxes_on_pallet,&
this.mle_message,&
this.st_reason,&
this.st_6,&
this.p_5,&
this.st_5,&
this.p_4,&
this.sle_percentage,&
this.sle_base,&
this.st_success,&
this.sle_serial,&
this.st_shipper,&
this.dw_shipper_detail,&
this.uo_for_note,&
this.dw_destination,&
this.st_destination,&
this.st_3,&
this.st_2,&
this.p_3,&
this.p_2,&
this.st_1,&
this.p_1,&
this.dw_shipper_header,&
this.gb_3,&
this.gb_2,&
this.sle_reason,&
this.dw_object,&
this.gb_1,&
this.uo_shipper}
end on

on w_quick_shipper.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_trash)
destroy(this.dw_objects)
destroy(this.dw_objects_per_shipper)
destroy(this.dw_pallets)
destroy(this.dw_object_info)
destroy(this.mle_scan_out)
destroy(this.cb_scan_out)
destroy(this.dw_view_boxes_on_pallet)
destroy(this.mle_message)
destroy(this.st_reason)
destroy(this.st_6)
destroy(this.p_5)
destroy(this.st_5)
destroy(this.p_4)
destroy(this.sle_percentage)
destroy(this.sle_base)
destroy(this.st_success)
destroy(this.sle_serial)
destroy(this.st_shipper)
destroy(this.dw_shipper_detail)
destroy(this.uo_for_note)
destroy(this.dw_destination)
destroy(this.st_destination)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_shipper_header)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.sle_reason)
destroy(this.dw_object)
destroy(this.gb_1)
destroy(this.uo_shipper)
end on

type p_trash from picture within w_quick_shipper
event ue_posted_drag ( )
integer x = 2651
integer y = 528
integer width = 183
integer height = 144
string picturename = "trash.bmp"
boolean focusrectangle = false
end type

event ue_posted_drag;long		l_l_count,&
			l_l_row,&
			l_l_serial

For l_l_count = 1 to dw_objects.RowCount ( )
	if dw_objects.IsSelected ( l_l_count ) then l_l_row = l_l_count
next 

if l_l_row < 1 then return

l_l_serial = dw_objects.GetItemNumber ( l_l_row, "serial" )
if MessageBox ( monsys.msg_title, "Are you sure about deleting object " + String ( l_l_serial ) + " from shipper?", Question!, YesNo!, 2 ) = 1 then
	wf_undo_serial ( l_l_serial, dw_objects.GetItemString ( l_l_row, "part" ), &
		dw_objects.GetItemNumber ( l_l_row, "objqty" ), &
		dw_objects.GetItemString ( l_l_row, "unit_measure" ) )
	dw_shipper_detail.Retrieve ( ishipper )
	dw_objects.Retrieve ( iShipper, dw_objects.GetItemString ( l_l_row, "part" ) )
end if
end event

event dragdrop;Post Event ue_posted_drag ( )
end event

type dw_objects from datawindow within w_quick_shipper
event ue_retrieve ( )
integer x = 1810
integer y = 1084
integer width = 1024
integer height = 320
integer taborder = 140
string dragicon = "Application!"
string dataobject = "d_quick_ship_objects"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_retrieve;LONG		ll_row

ll_row = dw_shipper_detail.GetRow ( )

if ll_row > 0 then
	if dw_shipper_detail.IsSelected ( ll_row ) then
		Retrieve ( iShipper, dw_shipper_detail.GetItemString ( ll_row, "part" ) )
	end if
end if


	
end event

event clicked;long	l_l_row

l_l_row = row

SelectRow ( 0, FALSE )

if l_l_row < 1 then return

SelectRow ( l_l_row, TRUE )

Drag ( BEGIN! )
end event

event constructor;settransobject ( sqlca )
end event

type dw_objects_per_shipper from datawindow within w_quick_shipper
boolean visible = false
integer x = 869
integer y = 1440
integer width = 485
integer height = 360
integer taborder = 150
string dataobject = "dw_objects_per_shipper"
boolean livescroll = true
end type

event constructor;this.settransobject ( sqlca )
end event

type dw_pallets from datawindow within w_quick_shipper
boolean visible = false
integer x = 960
integer y = 112
integer width = 485
integer height = 360
integer taborder = 100
string dataobject = "dw_pallets"
boolean livescroll = true
end type

event constructor;this.settransobject ( sqlca )
end event

type dw_object_info from datawindow within w_quick_shipper
boolean visible = false
integer x = 640
integer y = 912
integer width = 485
integer height = 360
integer taborder = 130
string dataobject = "dw_object_info"
boolean livescroll = true
end type

event constructor;this.settransobject ( sqlca )
end event

type mle_scan_out from multilineedit within w_quick_shipper
boolean visible = false
integer x = 1033
integer y = 512
integer width = 896
integer height = 400
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
boolean displayonly = true
end type

type cb_scan_out from commandbutton within w_quick_shipper
boolean visible = false
integer x = 997
integer y = 480
integer width = 960
integer height = 464
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type dw_view_boxes_on_pallet from datawindow within w_quick_shipper
boolean visible = false
integer x = 1330
integer y = 96
integer width = 485
integer height = 360
integer taborder = 90
string dataobject = "dw_view_boxes_on_pallet"
boolean livescroll = true
end type

event constructor;this.settransobject ( sqlca )
end event

type mle_message from multilineedit within w_quick_shipper
boolean visible = false
integer x = 640
integer y = 16
integer width = 1742
integer height = 144
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "To create a new shipper use the CrtShip tool bar option and to append parts to on an existing shipper double click on the shipper."
boolean border = false
end type

type st_reason from statictext within w_quick_shipper
integer x = 41
integer y = 576
integer width = 512
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "Part Note:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_quick_shipper
integer x = 1541
integer y = 688
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Out Proc"
boolean focusrectangle = false
end type

type p_5 from picture within w_quick_shipper
integer x = 1449
integer y = 688
integer width = 64
integer height = 64
string picturename = "outside.bmp"
boolean focusrectangle = false
end type

type st_5 from statictext within w_quick_shipper
integer x = 1166
integer y = 688
integer width = 293
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Ret to Vend"
boolean focusrectangle = false
end type

type p_4 from picture within w_quick_shipper
integer x = 1088
integer y = 688
integer width = 64
integer height = 64
string picturename = "rtnvend.bmp"
boolean focusrectangle = false
end type

type sle_percentage from singlelineedit within w_quick_shipper
boolean visible = false
integer x = 2441
integer y = 76
integer width = 32
integer height = 32
integer taborder = 80
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_base from singlelineedit within w_quick_shipper
boolean visible = false
integer x = 2446
integer y = 76
integer width = 416
integer height = 32
integer taborder = 70
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_success from statictext within w_quick_shipper
boolean visible = false
integer x = 2459
integer y = 8
integer width = 384
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 77897888
boolean enabled = false
string text = "SUCCESS"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_serial from singlelineedit within w_quick_shipper
integer x = 590
integer y = 248
integer width = 613
integer height = 64
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
boolean autohscroll = false
end type

event modified;Long	iTemp

string s_text, s_value

long l_start

i_b_sucess = False
bValidSerial	= FALSE

// This is to trim the 's' from the serial number to scan
s_text = LeftA(this.text, 1)

If s_Text = 'S'  or s_text = 's' Then
 s_value = MidA(this.Text, 2, (LenA(this.text) - 1 ))
Else
 s_value = This.text
End if

// main routine
lSerial 			= f_get_value ( Long ( s_Value ) )

If iShipper < 1 Then
   MessageBox (monsys.msg_title,"You must select a shipper first!", StopSign!)
	sle_serial.Text = ''
	dw_shipper_header.SetFocus()
	Return
End If

If wf_check_data(lSerial) then

	wf_retrieve_object_info(lSerial)
			
	dw_object.SetItem ( 1, "quantity", dQuantity )
	dw_object.SetItem ( 1, "unit", szUnit )
	dw_object.SetItem ( 1, "part", szPart )
	dw_object.SetItem ( 1, "description", szDescription )
	dw_object.SetItem ( 1, "status", szStatus )

	If iShipper > 0 then
		If wf_update_shipper_header(iShipper) then
			wf_delay()
			wf_update_shipper_detail(iShipper)
			dw_objects.SetTransObject ( sqlca )
			dw_objects.Retrieve ( iShipper, szPart )
			i_b_sucess	= TRUE
		End If
		dw_object.Reset()
		dw_object.InsertRow(1)
		sle_serial.Text	= ''
		sle_serial.SetFocus()
	End If
Else
	sle_serial.Text	= ''
	ib_serial_focus = TRUE
	sle_serial.SetFocus()
	i_b_sucess			= FALSE
End if





end event

type st_shipper from statictext within w_quick_shipper
boolean visible = false
integer x = 672
integer y = 160
integer width = 718
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "Current Shipper:"
boolean focusrectangle = false
end type

type dw_shipper_detail from datawindow within w_quick_shipper
integer x = 1810
integer y = 752
integer width = 1024
integer height = 320
integer taborder = 120
string dataobject = "dw_shipper_detail_mst"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long	l_l_row

l_l_row = row

SelectRow ( 0, FALSE )

if l_l_row < 1 then return

SelectRow ( l_l_row, TRUE )

dw_objects.SetTransObject ( sqlca )
dw_objects.Retrieve ( iShipper, GetItemString ( l_l_row, "part" ) )
end event

event constructor;this.SetTransObject ( sqlca )
end event

event retrieveend;long	ll_row

if rowcount <= 0 then
	update shipper
	set status = 'O'
	where id = :iShipper ;
	
	if sqlca.sqlcode = 0 then
		dw_shipper_header.Retrieve ( dw_destination.GetItemString ( 1, "destination" ) )
		ll_row = dw_shipper_header.Find ( "id = " + String ( iShipper ), 1, dw_shipper_header.RowCount ( ) )
		if ll_row > 0 then
			if dw_shipper_header.GetItemNumber ( ll_row, "id" ) = iShipper then
				dw_shipper_header.ScrollToRow ( iShipper )
				dw_shipper_header.SelectRow ( ll_row, TRUE )
			end if
		end if
		commit;
	else
		rollback;
	end if
end if
end event

type uo_for_note from uo_note within w_quick_shipper
boolean visible = false
integer x = 832
integer y = 320
integer width = 1193
integer height = 796
end type

on uo_for_note.destroy
call uo_note::destroy
end on

type dw_destination from datawindow within w_quick_shipper
event ue_unapproved_message ( )
integer x = 32
integer y = 68
integer width = 590
integer height = 96
integer taborder = 60
string dataobject = "d_external_destination_list"
boolean border = false
boolean livescroll = true
end type

event ue_unapproved_message;MessageBox ( monsys.msg_title, "This destination's status is " + is_status + ".  You will be able to do everything except physically ship out the order.", Information! )

end event

event itemchanged;String 	szDBDestination,&
			l_s_will_call
			
datawindowchild l_dwc_dest
this.getchild( "destination", l_dwc_dest )

szDestination		= data
i_b_sucess = False

SetNull(szDBDestination)
	
SELECT destination, plant, status_type, cs_status 
  INTO :szDBDestination,
		 :szPlant,
		 :is_status_type,
		 :is_status
  FROM destination,
  		 customer_service_status
 WHERE destination = :szDestination  and
 		 customer_service_status.status_name = destination.cs_status ;

SELECT	will_call_customer 
INTO		:l_s_will_call
FROM		destination_shipping
WHERE		destination = :szDestination ;

if f_get_string_value ( l_s_will_call ) <> 'Y' then
	i_b_will_call = FALSE
else
	i_b_will_call = TRUE
	m_quick_shipper.m_file.m_print.Visible = FALSE
	m_quick_shipper.m_file.m_print.ToolBarItemVisible = FALSE
end if

If IsNull(szDBDestination) then
	MessageBox( monsys.msg_title, "Invalid destination.", StopSign!)
	SetNull(szDestination)
	bValidDestination	= FALSE
	Return
End If

bValidDestination	= TRUE
dw_shipper_header.Retrieve ( szDestination )

If szMode	= "Outside Process" then
	szCustomer	= wf_get_customer(szDestination)
	szvendor		= l_dwc_dest.getitemstring ( l_dwc_dest.getrow(), "Vendor" )
	dw_shipper_header.SetFilter("type = 'O'")
	dw_shipper_header.Filter()
Else
	If szMode = "Return to Vendor" then
		dw_shipper_header.SetFilter("type = 'V'")
		dw_shipper_header.Filter()
		mle_message.visible	= TRUE
	Elseif szMode = 'Quick Shipper' then
		szCustomer	= wf_get_vendor(szDestination)
		//	Included on 10/17/01
		dw_shipper_header.SetFilter("type = 'Q'")
		dw_shipper_header.Filter()
	End If
End If

dw_shipper_detail.Reset()
dw_objects.reset()

//Post Event ue_unapproved_message ( )

end event

event constructor;settransobject ( sqlca )
end event

type st_destination from statictext within w_quick_shipper
integer x = 41
integer y = 12
integer width = 288
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "Destination:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_quick_shipper
integer x = 928
integer y = 688
integer width = 133
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Printed"
boolean focusrectangle = false
end type

type st_2 from statictext within w_quick_shipper
integer x = 645
integer y = 688
integer width = 160
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Staged"
boolean focusrectangle = false
end type

type p_3 from picture within w_quick_shipper
integer x = 832
integer y = 688
integer width = 64
integer height = 64
string picturename = "printer.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_quick_shipper
integer x = 553
integer y = 688
integer width = 64
integer height = 64
string picturename = "logo2.bmp"
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_quick_shipper
integer x = 443
integer y = 688
integer width = 105
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Note"
boolean focusrectangle = false
end type

type p_1 from picture within w_quick_shipper
integer x = 357
integer y = 688
integer width = 64
integer height = 64
string picturename = "noteyes.bmp"
boolean border = true
boolean focusrectangle = false
end type

type dw_shipper_header from datawindow within w_quick_shipper
integer x = 55
integer y = 752
integer width = 1682
integer height = 656
integer taborder = 110
string dataobject = "dw_list_of_shippers"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Long lRow

iShipperRow	= 0
i_b_sucess = False

If szDestination = ' ' then
	
	MessageBox(monsys.msg_title, "You must select destination first.", StopSign!)
	
Else
	
	if i_b_manual = TRUE then
		i_b_manual = FALSE
		lRow = GetRow ( )
	else
		lRow = row
	end if
	
	If lRow < 1 Then
		lRow = dw_shipper_header.GetRow ( )
		If lRow > 0 Then
			If Not dw_shipper_header.IsSelected ( lRow ) Then lRow = 0
		End if
	End if

	If lRow < 1 Then Return

	iShipperRow	= lRow
	SelectRow ( dw_shipper_header, 0, False )
	SelectRow ( dw_shipper_header, lRow, True )
	iShipper					= this.GetItemNumber(lRow, "id")
	st_shipper.visible	= TRUE
	st_shipper.text		= "Ready for shipper:" + String(iShipper)

	dw_shipper_detail.Retrieve ( ishipper )
	dw_object_info.Retrieve ( ishipper )
	dw_objects.reset ()
	sle_serial.SetFocus ( )
	
End If


end event

event doubleclicked;Long lRow

iShipperRow	= 0

If f_get_string_value(sle_serial.text) = '' then
	MessageBox(monsys.msg_title, "You must scan the serial number first.", StopSign!)
	Return
End If

If szDestination = ' ' then
	MessageBox(monsys.msg_title, "You must select destination first.", StopSign!)
	Return
Else
	lRow = dw_shipper_header.GetClickedRow ( )

	If lRow < 1 Then Return

	iShipperRow	= lRow
	SelectRow ( dw_shipper_header, 0, False )
	SelectRow ( dw_shipper_header, lRow, True )
	iShipper					= this.GetItemNumber(lRow, "id")
	st_shipper.visible	= TRUE
	st_shipper.text		= "Ready for shipper:" + String(iShipper)

	dw_shipper_detail.Retrieve(iShipper)
End If

If szMode = "Return to Vendor" then
	If iShipper > 0 then
		If wf_update_shipper_header(iShipper) then
			wf_delay()
			wf_update_shipper_detail(iShipper)
			i_b_sucess = True
		End If
		dw_object.Reset()
		dw_object.InsertRow(1)
		sle_serial.Text	= ''
		sle_serial.SetFocus()
      sle_reason.Text   = ''
		dwcDestList.SetFilter("vendor > ''")
		dwcDestList.Filter()
	End If
End If

mle_message.visible	= FALSE

end event

event constructor;settransobject ( sqlca )
end event

type gb_3 from groupbox within w_quick_shipper
integer x = 1792
integer y = 688
integer width = 1056
integer height = 736
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "Shipper Detail / Objects:"
end type

type gb_2 from groupbox within w_quick_shipper
integer x = 32
integer y = 688
integer width = 1728
integer height = 736
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "Shippers:"
end type

type sle_reason from multilineedit within w_quick_shipper
integer x = 581
integer y = 528
integer width = 1920
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
end type

type dw_object from datawindow within w_quick_shipper
integer x = 169
integer y = 208
integer width = 2368
integer height = 368
string dataobject = "d_outside_process_object_info"
boolean border = false
end type

on itemchanged;//Long 		lColumn
//
//lColumn = dw_object.GetColumn ( )
//
//If lColumn = 1 Then
//
//	If ddlb_mode.text <> "Return to Vendor" then
//		If IsNull(szDestination) then
//			MessageBox("Warning", "Please select a destination first.", StopSign!)
//			Return
//		End If
//	End If
//
//	If ddlb_mode.text <> "Return to Vendor" then
//		If iShipper = 0 or IsNull(iShipper) then
//			MessageBox("Warning", "Please create shipper or select from shipper list first.", StopSign!)
//			Return
//		End If
//	End If
//		
//	bValidSerial	= FALSE
//	lSerial 			= f_get_value ( Long ( dw_object.GetText ( ) ) )
//
//	If lSerial = 0 then 
//		bValidSerial	= FALSE
//		Return
//	End If
//
//	If wf_retrieve_object_info(lSerial) then 	
//		szPart     		= f_get_string_value ( szPart )
//		szUnit     		= f_get_string_value ( szUnit )
//		szPoNumber 		= f_get_string_value ( szPoNumber )
//		dQuantity  		= f_get_value ( dQuantity )
//		szLot      		= f_get_string_value ( szLot )
//		szStatus   		= f_get_string_value ( szStatus )
//		szDescription 	= f_get_part_info(szPart, "NAME")
//		
//		If ddlb_mode.text= "Return to Vendor" then
//			lPoNumber = f_get_value ( Long ( szPoNumber ) )
//
//			SELECT "po_header"."vendor_code",
//			  INTO :szVendor  
//	        FROM "po_header"  
//	       WHERE "po_header"."po_number" = :lPoNumber   ;
//
//			If SQLCA.SQLCode = 0 Then
//
//				bValidSerial	= TRUE
//				szVendor 		= f_get_string_value ( szVendor )
//
//				dw_shipper_header.Retrieve ( szVendor )
//
//				dw_object.dwGetChild ( "destination", dwcDest )
//				dwcDest.SetTransObject ( sqlca )
//				dwcDest.Retrieve ( szVendor )
//
//				wf_select_vendor_part(szVendor, szPart)
//
//				dw_object.SetItem ( 1, "po_number", lPoNumber )
//				dw_object.SetItem ( 1, "vendor_part", szVendorPart )
//				dw_object.SetItem ( 1, "vendor", szVendor )
//	
//			Else
//
//				bValidSerial	= FALSE
//				MessageBox ( "Error", "Unable to find~rPurchase Order!", StopSign! )
//			End if
//		End if
//
//		dw_object.SetItem ( 1, "quantity", dQuantity )
//		dw_object.SetItem ( 1, "unit", szUnit )
//		dw_object.SetItem ( 1, "part", szPart )
//		dw_object.SetItem ( 1, "description", szDescription )
//		dw_object.SetItem ( 1, "status", szStatus )
//
//		Enable_entry ( )
//
//		If iShipper > 0 then
//			wf_update_shipper_detail(iShipper)
//			w_quick_shipper.SetFocus()
//			dw_object.Reset()
//			dw_object.InsertRow(1)
//			dw_object.SetColumn(1)	
//			dw_object.SetFocus()
//		End If
//	Else
//		dw_object.Reset()
//		dw_object.InsertRow(1)
//		dw_object.SetColumn("serial")
//		dw_object.SetFocus()
//	End If
//
//Else
//
//	If lColumn = 11 Then
//
//		bValidDestination		= FALSE
//	
//		szDestination 			= dw_object.GetText ( )
//		szCustomer				= wf_get_vendor(szDestination)
//
//		bValidDestination 	= (szDestination > " ")
//		If bValidDestination	then
//			dw_shipper_header.SetTransObject ( sqlca )
//			dw_shipper_header.Retrieve ( szDestination )
//		End If
//	End If
//End if
//
//
//
end on

event constructor;this.settransobject ( sqlca )
end event

type gb_1 from groupbox within w_quick_shipper
integer x = 32
integer y = 160
integer width = 2816
integer height = 532
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "Object Information:"
end type

type uo_shipper from u_create_shipper_header within w_quick_shipper
boolean visible = false
integer x = 613
integer y = 416
end type

on uo_shipper.destroy
call u_create_shipper_header::destroy
end on


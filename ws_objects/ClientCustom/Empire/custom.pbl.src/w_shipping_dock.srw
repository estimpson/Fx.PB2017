$PBExportHeader$w_shipping_dock.srw
forward
global type w_shipping_dock from window
end type
type sle_1 from singlelineedit within w_shipping_dock
end type
type st_14 from statictext within w_shipping_dock
end type
type st_11 from statictext within w_shipping_dock
end type
type mle_1 from multilineedit within w_shipping_dock
end type
type dw_destination_scf from datawindow within w_shipping_dock
end type
type dw_dest from datawindow within w_shipping_dock
end type
type em_verifyscan from editmask within w_shipping_dock
end type
type p_1 from picture within w_shipping_dock
end type
type sle_document from statictext within w_shipping_dock
end type
type sle_status from statictext within w_shipping_dock
end type
type st_black from statictext within w_shipping_dock
end type
type st_blue from statictext within w_shipping_dock
end type
type cb_note_exit from commandbutton within w_shipping_dock
end type
type st_13 from statictext within w_shipping_dock
end type
type p_5 from picture within w_shipping_dock
end type
type st_12 from statictext within w_shipping_dock
end type
type p_4 from picture within w_shipping_dock
end type
type st_red from statictext within w_shipping_dock
end type
type st_10 from statictext within w_shipping_dock
end type
type p_3 from picture within w_shipping_dock
end type
type st_9 from statictext within w_shipping_dock
end type
type p_2 from picture within w_shipping_dock
end type
type st_8 from statictext within w_shipping_dock
end type
type st_7 from statictext within w_shipping_dock
end type
type st_5 from statictext within w_shipping_dock
end type
type st_4 from statictext within w_shipping_dock
end type
type dw_objects from datawindow within w_shipping_dock
end type
type sle_orig_pallet_tare from editmask within w_shipping_dock
end type
type st_pallet from statictext within w_shipping_dock
end type
type st_6 from statictext within w_shipping_dock
end type
type sle_destination from singlelineedit within w_shipping_dock
end type
type sle_shipper from singlelineedit within w_shipping_dock
end type
type st_1 from statictext within w_shipping_dock
end type
type gb_1 from groupbox within w_shipping_dock
end type
type st_3 from statictext within w_shipping_dock
end type
type st_2 from statictext within w_shipping_dock
end type
type dw_verifyscan from datawindow within w_shipping_dock
end type
type uo_dw_scan from u_serial_scan within w_shipping_dock
end type
type dw_pallets from datawindow within w_shipping_dock
end type
type dw_view_boxes_on_pallet from datawindow within w_shipping_dock
end type
type dw_shipper_detail from datawindow within w_shipping_dock
end type
type dw_pallet_info from datawindow within w_shipping_dock
end type
type cb_note from commandbutton within w_shipping_dock
end type
type mle_note from multilineedit within w_shipping_dock
end type
type cb_scan_out from commandbutton within w_shipping_dock
end type
type mle_scan_out from multilineedit within w_shipping_dock
end type
type gb_vscan from groupbox within w_shipping_dock
end type
type st_vscanserial from statictext within w_shipping_dock
end type
type dw_printscanexception from datawindow within w_shipping_dock
end type
type str_oe_detail from structure within w_shipping_dock
end type
end forward

type str_oe_detail from structure
    long irowid
    string szum
end type

global type w_shipping_dock from window
integer width = 5234
integer height = 3036
boolean titlebar = true
string title = "Monitor Shipping Dock"
string menuname = "m_shipping_dock"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 79216776
event create_new_pallet pbm_custom01
event manul_scan pbm_custom02
event reconcile pbm_custom03
event scan_to_truck pbm_custom04
event print_shipper pbm_custom05
event print_picklist pbm_custom06
event edit_qty pbm_custom07
event change_menu pbm_custom09
event show_note pbm_custom10
event print_custom_form pbm_custom11
event print_pallet_label pbm_custom12
event edit_shipper_header pbm_custom13
event print_certs pbm_custom14
event relabel pbm_custom15
event ue_print_update ( string a_b_form_type )
event ue_open ( )
event ue_unapproved_message ( )
event ue_verifyscan ( )
sle_1 sle_1
st_14 st_14
st_11 st_11
mle_1 mle_1
dw_destination_scf dw_destination_scf
dw_dest dw_dest
em_verifyscan em_verifyscan
p_1 p_1
sle_document sle_document
sle_status sle_status
st_black st_black
st_blue st_blue
cb_note_exit cb_note_exit
st_13 st_13
p_5 p_5
st_12 st_12
p_4 p_4
st_red st_red
st_10 st_10
p_3 p_3
st_9 st_9
p_2 p_2
st_8 st_8
st_7 st_7
st_5 st_5
st_4 st_4
dw_objects dw_objects
sle_orig_pallet_tare sle_orig_pallet_tare
st_pallet st_pallet
st_6 st_6
sle_destination sle_destination
sle_shipper sle_shipper
st_1 st_1
gb_1 gb_1
st_3 st_3
st_2 st_2
dw_verifyscan dw_verifyscan
uo_dw_scan uo_dw_scan
dw_pallets dw_pallets
dw_view_boxes_on_pallet dw_view_boxes_on_pallet
dw_shipper_detail dw_shipper_detail
dw_pallet_info dw_pallet_info
cb_note cb_note
mle_note mle_note
cb_scan_out cb_scan_out
mle_scan_out mle_scan_out
gb_vscan gb_vscan
st_vscanserial st_vscanserial
dw_printscanexception dw_printscanexception
end type
global w_shipping_dock w_shipping_dock

type variables
boolean  bDragInvObj       //Currently draging inv object
boolean  bDragStagedObj  //Currently draging staged obj 
boolean  bManualScanObj = FALSE //Scan Mode: Manual
boolean  bDragPalletBox   //Draging box on pallet
boolean  bPalletVisible      //Where the pallet is visible
boolean  bScanPallet        //Scanning pallet
boolean  bRed                  //Dragging staged object
boolean  bBlue                  //Dragging on pallet object
boolean  bBlack                //Dragging black object    
boolean  b_Retrieve          //Whether or not to re-retrieve
		           //    the datawindow in the 
		           //    w_list_of_active_shippers
boolean	ib_InvoiceReturntoVendor
boolean  bType                 //will_call_customer

Long      iShipper              //Current shipper number
Long      iSerial                 //Current serial number 
Long      iShipperRow        //The row for shipper
Long      iStagedRow         //Current staged row
Long      iPalletSerial         //Current Pallet Serial
Long      iPalletBoxRow     //Current box row on pallet
Long      lRedColor            //Red color
Long      lBlueColor           //Blue color
Long      lGreenColor         //Green color
Long      lWhiteColor         //White color
Long      iDetailRow          //Shipper detail row
Long      iObjectRow         //Row number for object
Long      iTimerCount = 1   //Counter
Long      iSalesOrder         //Sales Order Number
Long      iSuffix	          //Suffix Number
Long      iDelArray[500]
Long      iDelCount
Long      iInvoice

String     szPart                //Part number
String     cObjectType       //Object type 

String     szCustomerPart   //Customer part number
String     szSalesOrder      //Sales Order
String     szCustomer         //Customer Code
STRING	is_Vendor, &
	is_MLE_Line1, &
	is_MLE_Line2, &
	is_MLE_Line3, &
	is_operator
String     szDestination      //Destination Code
String     szOverlay           //EDI Overlay group code
String     szOrderPackage  //Original package type
String     szProNumber      //Pro Number
String     szShipperType    //Shipper type 0:Outside 
                                      //                   R:Return Vend
string	is_SelectedPart
String     szDockCode       //Dock code
String     szLineFeedCode  //Line feed code
String     szSalesman         //Salesman
String     szPartNote          //To keep the part note
String     szGroupNo          //To keep the group number
String     szCustomerPO     //To keep the customer po#
String     szZoneCode        //To keep the zone code
string	is_trucknumber

Decimal  nQty                  //Qty for current object
Decimal  nWeight             //Unit Weight for current object
Decimal  nPalletTare        //To keep the pallet tare weight	

st_generic_structure stParm

Boolean bUpdate               //Whether to update detail qty
Boolean bClosed   = FALSE //Whether the shipper is closed

Integer iSerialFileNo
Integer iOrderFileNo
Integer iShipperHeaderFileNo
Integer iShipperDetailFileNo

st_print_preview_generic stPrintParm

//  Datastores to replace non-visible datawindows
u_ds_dw_shipper_shipping_info	dw_shipper_header
u_ds_dw_view_release_detail		dw_view_release
u_ds_dw_boxes_on_pallet		dw_boxes_on_pallet
u_ds_dw_object_info		dw_object_info
u_ds_dw_list_of_releases_sd		dw_order_detail
u_ds_sd_order_header		dw_order_header
u_ds_d_shipping_kanban		dw_kanban
u_ds_d_update_onhand		dw_onhand

string	is_shipday='Any_Day'
boolean	ib_displaymessage = True
string	is_lastpart
datetime	idt_dateshipped

end variables

forward prototypes
public subroutine updt_qty_on_pallet (long irow)
public function boolean check_parts_on_pallet (long iserial)
public function boolean shipper_is_staged ()
public subroutine unstage_whole_pallet ()
public function string status_of_shipper (long ishipper)
public subroutine generate_asn ()
public function long get_sales_order (string szpart)
public function boolean isblankorder (long isalesorder)
public function boolean need_asn (string szdestination)
public function boolean wf_need_to_check_object_package ()
public function long row_of_part_in_detail (string szpart)
public function boolean wf_check_object_package (string szpart, string szpackage)
public function string wf_get_string_value (string szValue)
public function string wf_get_customer (string szdestination)
public function boolean wf_valid_parts_on_pallet (long ipalletserial)
public subroutine wf_show_note (boolean bflag)
public subroutine unstage_box (long iserial)
public function boolean box_exist (long iserial)
public subroutine wf_set_detail_qty (decimal nqty)
public function boolean wf_bol_printed (long ishipper)
public function decimal wf_get_price (long isalesorder)
public function string wf_shipper_type (long ishipper)
public subroutine wf_reset_mps (long ishipper)
public subroutine wf_update_pallet_numbers (string cflag, int iqty)
public subroutine wf_assign_shipper_to_boxes (long ipalletserial)
public function string wf_get_label_window (string szlabel)
public function string wf_get_supplier_code (string szdestination)
public subroutine wf_reset_staged_pallets ()
public function boolean wf_shipper_is_closed (long ishipper)
public subroutine wf_calculate_pallet_weight (long ipalletserial, decimal norigpallettare)
public function boolean wf_update_quantity_in_normal_order (long iorder, string szpart, decimal nqty, long isuffix)
public function boolean wf_ready_for_scan ()
public function boolean wf_scan_objects_to_truck ()
public function boolean wf_update_orders ()
public function boolean wf_set_shipped_datetime ()
public function decimal wf_get_part_price (string szpart, decimal isuffix)
public function boolean wf_update_cost (string szpart, long isuffix, decimal ncost)
public function boolean wf_reset_total_cost ()
public function boolean change_qty_for_part (string szpart, decimal nqty, string csign)
public function boolean change_weight_for_part (string szpart, decimal nunitweight, decimal ntareweight, string csign)
public function boolean wf_recalc_total_boxes_and_weight ()
public subroutine wf_calc_boxes_and_weight ()
public function boolean wf_refresh_shipper_status ()
public function boolean wf_set_shipper_status (string szStatus)
public subroutine check_shipper_status ()
public subroutine wf_update_release_in_blanket_order (long iorder)
public subroutine wf_update_releases (long iorder, decimal nourcum)
public subroutine wf_calculate_dropship ()
public function string wf_strip_off_suffix (string szpart, long isuffix)
public function boolean wf_set_bol_status (string szstatus)
public function boolean wf_set_status ()
public function long wf_get_next_invoice ()
public subroutine wf_print_label (string szpart, long iserial, long iorder, string szLabel)
public subroutine wf_get_vendor ()
public function string wf_stage_using_wgt_qty ()
public subroutine wf_print_invoice (integer iinvoice, long ishipper)
public function boolean wf_get_dest_type (long ishipper)
public subroutine wf_reset_printed_flag (string sflag, long ishipper)
public function boolean wf_update_onhand_old ()
public function boolean wf_update_onhand ()
public function string wf_get_kanban_number (integer ishipper)
public subroutine wf_update_kanban (long iserial)
public function boolean wf_printed_kanban (long ishipper)
public subroutine create_pallet (long ipalletserial, string a_s_package_type)
public function long wf_get_current_row (string as_part)
public function boolean wf_validate_pallet_against_shipper (long al_serial, long al_shipper)
public function integer wf_stage_object (long al_serial)
public subroutine wf_print_pallet_label (long a_l_serial, long a_l_shipper)
public subroutine add_qty_to_part (string a_s_part, decimal a_n_qty)
public function boolean wf_valid_part_for_stage (string a_s_part, long icurrentshipper, long icurrentpallet, string szobjectstatus)
public function boolean ship_out_pallet (long al_serial)
public function boolean ship_out_box (long al_serial)
public subroutine updt_order_detail (long al_salesorder, string as_part, decimal adec_qty)
public subroutine updt_inventory (long al_serial)
public function integer wf_get_order_release_date (long al_order, string as_part, long al_suffix, ref datetime adt_release_date, ref string as_release_number)
public function boolean wf_checkforoverstage (long al_serial)
public function boolean update_kanban (long ai_salesorder)
public subroutine wf_write_releases ()
public subroutine sendemail (string _message)
public function boolean checkpartstatus ()
public function boolean checkshipperstatus ()
public subroutine wf_set_detail_qty (string operator, decimal newqtyrequired)
end prototypes

event create_new_pallet;/* 01-31-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iPalletSerial' (next Pallet number).  */

STRING	l_s_package_type

IF IsNull ( iShipper ) THEN
	MessageBox ( monsys.msg_title, "No Shipper Specified", StopSign! )
	this.SetMicroHelp ( "Ready" )
	Return
END IF

SELECT	parameters.pallet_package_type  
  INTO	:l_s_package_type  
  FROM	parameters  ;

IF isnull(l_s_package_type,'N') = 'Y' THEN
	Open ( w_pallet_package_type )
	l_s_package_type = Message.StringParm
	IF (l_s_package_type = "-1" OR l_s_package_type = "0") THEN 
		l_s_package_type = ""
		dw_pallet_info.hide()
		dw_view_boxes_on_pallet.hide()
		st_pallet.hide()
		w_shipping_mdi_screen.ChangeMenu(m_shipping_dock)
		return
	end if 	
END IF

this.SetMicroHelp ( "Getting next serial for new pallet..." )

if not sqlca.of_getnextparmvalue ( "next_serial", iPalletSerial ) then    // Failed to get current value 	-  ADD 01-31-2000 KAZ
	Rollback;																																// ADD 01-31-2000 KAZ
	MessageBox(monsys.msg_title, "Failed to get a new Pallet number, Please try again", Exclamation! )			// ADD 01-31-2000 KAZ
	this.SetMicroHelp ( "Ready" )					// ADD 01-31-2000 KAZ
	w_shipping_mdi_screen.ChangeMenu(m_shipping_dock)		
	Return																																	// ADD 01-31-2000 KAZ
end if																																		// ADD 01-31-2000 KAZ

IF isnull(iPalletSerial,0) > 0 THEN
	create_pallet ( iPalletSerial, l_s_package_type )
	sle_orig_pallet_tare.visible = TRUE
ELSE
	MessageBox ( monsys.msg_title, "Failed to create pallet, please try again", StopSign! )
END IF

this.SetMicroHelp ( "Ready" )

end event

event manul_scan;IF Not bManualScanObj THEN
	uo_dw_scan.SetItem ( 1, "scan", '' )
	uo_dw_scan.SetItem ( 1, "boxserial", 0 )
	uo_dw_scan.SetItem ( 1, "palletserial", 0 )
	dw_objects.Visible = FALSE
	dw_pallets.Visible = FALSE
	uo_dw_scan.Visible = TRUE
	uo_dw_scan.SetFocus ( )
	bManualScanObj = TRUE  //Enter into the Manual Scan Mode  
ELSE
	dw_objects.Visible = TRUE
	dw_pallets.Visible = TRUE
	uo_dw_scan.Visible = FALSE
	bManualScanObj = FALSE  //Stop Manual Scan Mode  
	this.SetMicroHelp ( "Ready" )
END IF

end event

event reconcile;/* 01-31-2000 KAZ Modified to place the rollbacks before the message boxes to release the 
						database to avoid deadlocks.     */

Long      iRow			//To keep the current row number
Long		 iBoxRow		//To keep the box row on detail screen

Long		 iPallets 	//To keep the total pallets

Decimal	 nTareWeight//To keep the tare weight of the object

String    l_s_Part		//To keep the current shipper detail part number
String	 szObjectPackage
String    s_StageFlag

str_progress st_progress

If wf_shipper_is_closed(iShipper) then
	MessageBox(monsys.msg_title, "This shipper is already closed by another user!", StopSign!)
	Close(w_shipping_dock)
End If

//w_list_of_active_shippers.TriggerEvent("reset_gross_weight")
wf_reset_staged_pallets()

For iRow = 1 to dw_shipper_detail.RowCount()

	dw_shipper_detail.SetItem(iRow, "shipper_detail_qty_packed", 0)	//Reset the qty
	dw_shipper_detail.SetItem(iRow, "shipper_detail_alternative_qty", 0)
	dw_shipper_detail.SetItem(iRow, "shipper_detail_boxes_staged", 0) //Reset the box number

Next

If dw_shipper_detail.Update() > 0 then
	Commit;
Else
	Rollback;																											// CHG 01-31-2000 KAZ
	MessageBox(monsys.msg_title, "Can't save data in [W_SHIPPING_DOCK(reconcile)]")
//	Rollback;																											-  CHG 01-31-2000 KAZ
	Return		
End If

DELETE FROM shipper_container  
WHERE shipper = :iShipper   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;																											// CHG 01-31-2000 KAZ
	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
//	Rollback;																											-  CHG 01-31-2000 KAZ
	Return
End If

st_progress.title	= "Reconciling Shipping Detail Info"
OpenWithParm(w_progress, st_progress)
w_progress.cb_cancel.visible	= FALSE

For iRow = 1 to dw_pallets.RowCount()

	If dw_pallets.GetItemString(iRow, "type") = "S" then 	//This is pallet

		w_progress.wf_progress(iRow / dw_pallets.RowCount(), "Processing pallet")
      
      // included the if statement to prevent staging pallets which has parts from a different requirement

      If wf_validate_pallet_against_shipper(dw_pallets.GetItemnumber(iRow, "serial"), ishipper) then
			Updt_qty_on_pallet(iRow)									//Update the quantity for pallet
			wf_update_pallet_numbers("+", 1)							//Update # of pallets in shipper
	  	else
	       close(w_progress)
    	    return
 		End If

	Else

		l_s_Part 			 = dw_pallets.GetItemString(iRow, "part")
		nQty   			 = f_get_value(dw_pallets.GetItemNumber(iRow, "std_quantity"))
		szObjectPackage = dw_pallets.GetItemString(iRow, "package_type")
		iSuffix			 = dw_pallets.GetItemNumber(iRow, "suffix")

		If iSuffix > 0 then
			l_s_Part	= l_s_Part + "-" + String(iSuffix)
		End If

		w_progress.wf_progress(iRow / dw_pallets.RowCount(), "Processing part " + l_s_Part)

		Change_qty_for_part(l_s_Part, nQty, "+")
		f_update_shipper_container(iShipper, szObjectPackage, "+")

	End If
Next

If dw_shipper_detail.Update() > 0 then
	Commit;
	s_StageFlag = wf_stage_using_wgt_qty ( )
	dw_shipper_detail.Retrieve ( iShipper )
	Check_shipper_status()
Else
	Rollback;																											// CHG 01-31-2000 KAZ
	MessageBox(monsys.msg_title, "Can't save data in [W_SHIPPING_DOCK]")
//	Rollback;																											-  CHG 01-31-2000 KAZ
End If

//---------- Calculate the total number of pallets ----------
Select count(object.serial )  
  Into :iPallets  
  From object  
 Where ( object.shipper = :iShipper ) AND  
       ( object.type 	= 'S' )   ;

wf_update_pallet_numbers("*", iPallets)	//Update the current pallet number

this.SetMicroHelp("Ready")

Close(w_progress)
end event

event scan_to_truck;Long	l_i_Row			//To keep the current row number
Long	l_l_TotalObjects	//To keep the total objects
Long	l_l_TotalItems		//To keep the total shipper detail items
Long	l_l_Invoice
long holdBoxCount
Decimal l_n_Qty			//To keep the quantity
Decimal l_n_OurCum		//To keep the our cum
String  l_s_Part		//To keep the part number
String  l_s_OrderType		//To keep the type of the sales order
Boolean l_b_OK = TRUE

if dw_shipper_header.GetItemString ( 1, "customer_service_status_status_type" ) <> 'A' then
	MessageBox ( "Shipping Dock", "This shipper's status is " + dw_shipper_header.GetItemString ( 1, "customer_service_status_status_type" ) + ".  You can not ship this out until it is approved.", Information! )
	return
end if

if	CheckShipperStatus() then 
	msgbox ("Certain part(s) on this shipper are set to non ship status, can't proceed with ship out routine")
	return
end if 

// MB check if objects on pallet have approved qc status 09/28/04 
select
	count(*)
into
	:holdBoxCount
from
	object 
where
	shipper = :ishipper
	and
		status <> 'A'
	and
		parent_serial in
		(	select
				serial
			from
				object
			where
				shipper = :ishipper
				and
					type = 'S'
		)   ;

if	holdBoxCount > 0 then
	messagebox ( monsys.msg_title, "Cannot Ship Pallet, it contains objects ON HOLD", StopSign! )
	return
end if

//	Check that this shipper is staged.
if sqlca.of_CheckShipper ( iShipper ) = 0 then
	
	//	Open w_pro_window for accecpting pro number & operator.
	Open(w_enter_opertor_code)
	
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
			
			If Need_ASN(szDestination) then					//Need ASN
				w_list_of_active_shippers.TriggerEvent("generate_asn")
			End If
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

event print_shipper;INTEGER  l_i_job

STRING  szDataWindowName, &
	szFormName, &
        l_s_type
string formName

st_print_preview_generic l_st_Parm

if CheckPartStatus() = true then 
	messagebox (monsys.msg_title, "Certain part(s) on this shipper are set to non ship status, can't proceed with packing list printing")
	return
end if 

SELECT type
  INTO :l_s_Type  
  FROM shipper  
 WHERE id = :iShipper   ;

CHOOSE CASE  l_s_type

	CASE "V" 
		l_st_Parm.form_type = "Packlist Ret Vendor"

	CASE "Q" 
		l_st_Parm.form_type = "Quick Shipper"

	CASE "O" 
		l_st_Parm.form_type = "Outside Process"

	CASE ELSE
		l_st_Parm.form_type = "Packing List"
		
		wf_write_releases() //Writes to additional table, if enabled at destination

END CHOOSE

select
	min(isnull(form_name,''))
into
	:formName
from
	dbo.product_line pl
	join dbo.part p on
		pl.id = p.product_line
	join dbo.shipper_detail sd on
		p.part = sd.part_original
where
	sd.shipper = :iShipper  ;

l_st_Parm.document_number = iShipper
l_st_Parm.additional_formname= formName

IF shipper_is_staged() THEN
	OpenSheetwithParm ( w_form_print_preview,  l_st_Parm, gnv_App.of_GetFrame(), 0, Original! )
ELSE
	MessageBox(monsys.msg_title, "Can't print document for unstaged shipper", StopSign!)
	sle_document.text	= "Not Prted"
END IF

THIS.SetMicroHelp("Ready")

gf_get_info ( 'w_shipping_dock', 0 )

end event

event print_picklist;st_print_preview_generic l_st_Parm
l_st_Parm.document_number = iShipper
l_st_Parm.form_type		 = 'Pick list'

OpenSheetwithParm ( w_form_print_preview,  l_st_Parm,  gnv_App.of_GetFrame(), 3, Original! )

this.SetMicroHelp("Ready")

gf_get_info ( 'w_shipping_dock', 1 )
end event

event edit_qty;If iDetailRow > 0 then
	If (sle_status.text	= "Staged") AND (sle_document.text = "Printed") then
		If MessageBox(monsys.msg_title, "Shipper is staged and packing slip has been printed. " + &
							"~rAre you sure to change quantity now", Stopsign!, OkCancel!) = 2 then
			Return
		End If
	End If
	OpenWithParm(w_update_detail_qty, iDetailRow)
Else
	MessageBox(monsys.msg_title, "Click shipper detail line item first", StopSign!)
End If

this.SetMicroHelp("Ready")

end event

event show_note;If iDetailRow > 0 then
	wf_show_note(TRUE)
	mle_note.text	= " "	
	mle_note.text	= dw_shipper_detail.GetItemString(iDetailrow, "shipper_detail_note")
Else
	MessageBox(monsys.msg_title, "Please select detail line item first", Stopsign!)
End If

this.SetMicroHelp("Ready")
end event

event print_custom_form;st_print_preview_generic  l_st_Parm

l_st_Parm.document_number = iShipper


l_st_Parm.form_type		  = 'Canadian Custom'

OpenSheetwithParm ( w_form_print_preview,  l_st_Parm, gnv_App.of_GetFrame(), 3, Original! )

this.SetMicroHelp("Ready") 


end event

event print_pallet_label;Long l_l_Serial
Long l_l_Number
String l_s_WinName
String l_s_NumberOfLabels
Window lw_WinName
if isnull(iStagedRow) then iStagedRow=0
IF isnull(iStagedRow,0) > 0 THEN
	IF dw_pallets.GetItemString ( iStagedRow, "type" ) = "S" THEN //Pallet 
		l_l_Serial	= dw_pallets.GetItemNumber ( iStagedRow, "serial" )
		wf_print_pallet_label ( l_l_Serial, iShipper )
	ELSE
		Messagebox ( monsys.msg_title, "This is not a pallet", Stopsign! )
	END IF
ELSE
	MessageBox ( monsys.msg_title, "Please click pallet first", Stopsign! )
END IF
this.SetMicroHelp ( "Ready" )

end event

event edit_shipper_header;OpenWithParm ( w_edit_shipper_shipping_info, iShipper )
this.SetMicroHelp ( "Ready" )
end event

event print_certs;stPrintParm.Form_type			= "Engineering Certs"
stPrintParm.Document_number	= iShipper
stPrintParm.Calling_window		= w_shipping_dock

OpenSheetWithParm ( w_form_print_preview, stPrintParm, gnv_App.of_GetFrame(), 3, Original!)
end event

event relabel;String 	l_s_Type
String 	l_s_Part
String	l_s_label
String	l_s_PrevPart

Long  	l_l_Row
Long		l_l_PalletBoxRow
Long		l_l_ShipperDetailRow
Long		l_l_TotalRows
Long		l_l_Serial
Long		l_l_Order

Boolean 	l_b_Print

datastore	lds_labels

str_progress l_st_Parm

lds_labels = CREATE datastore
lds_labels.DataObject = "d_msp_labelsfromorder"
lds_labels.SetTransObject ( sqlca )

if dw_view_boxes_on_pallet.Visible then

	l_l_TotalRows		= dw_view_boxes_on_pallet.RowCount()
	
	For l_l_Row = 1 to l_l_TotalRows
	
		If dw_view_boxes_on_pallet.IsSelected(l_l_Row) then

			l_s_Part					= dw_view_boxes_on_pallet.GetItemString(l_l_Row, "part")
			l_l_Serial	= dw_view_boxes_on_pallet.GetItemNumber(l_l_Row, "serial")
			iSuffix	= dw_view_boxes_on_pallet.GetItemNumber(l_l_Row, "suffix")
			l_l_ShipperDetailRow		= 0
			l_l_ShipperDetailRow		= dw_shipper_detail.find("part='" + l_s_Part + "'", 1, 9999)

			If l_l_ShipperDetailRow > 0 then
				if lds_labels.Retrieve ( dw_shipper_detail.GetItemNumber(l_l_ShipperDetailRow, "shipper_detail_order_no"), l_s_part ) > 0 then
					l_s_label = IsNull ( lds_labels.GetItemString ( 1, "box_label" ), "NOLABEL" )
				else
					l_s_label = 'NO LABEL'
				end if
				szDockCode		= f_get_order_info(l_l_Order, "DOCK CODE")
				szLineFeedCode	= f_get_order_info(l_l_Order, "LINE FEED")
				szCustomerPart	= f_get_order_info(l_l_Order, "CUSTOMER PART")
				szCustomerPO	= f_get_order_info(l_l_Order, "CUSTOMER PO")
				szZoneCode		= f_get_order_info(l_l_Order, "ZONE CODE")
				l_b_Print			= (l_s_label <> "NO LABEL")

				If l_b_Print then
					wf_print_label(szCustomerPart, l_l_Serial, l_l_Order, l_s_label)
				End If

			Else
				MessageBox(monsys.msg_title, "Part can not be found in shipper detail.", StopSign!)
			End If
			
		end if
		
	next
	
else
	
	l_l_TotalRows		= dw_pallets.RowCount()
	
	
	For l_l_Row = 1 to l_l_TotalRows
	
		If dw_pallets.IsSelected(l_l_Row) then
	
			l_s_Type	= dw_pallets.GetItemString(l_l_Row, "type")
			l_l_Serial	= dw_pallets.GetItemNumber(l_l_Row, "serial")
			iSuffix	= dw_pallets.GetItemNumber(l_l_Row, "suffix")
	
			If iSuffix > 0 then
				MessageBox(monsys.msg_title, "System can not generate labels for objects with suffix.", StopSign!)
				Return
			End If
		
			If l_s_Type = "S" then
	
				dw_boxes_on_pallet.Retrieve(l_l_Serial)	
				l_s_PrevPart	= ""
				l_b_Print	= TRUE
	
				For l_l_PalletBoxRow = 1 to dw_boxes_on_pallet.RowCount()
		
					l_l_Serial	= dw_boxes_on_pallet.GetItemNumber(l_l_PalletBoxRow, "serial")
					l_s_Part	= dw_boxes_on_pallet.GetItemString(l_l_PalletBoxRow, "part")
					iSuffix	= dw_boxes_on_pallet.getItemNumber(l_l_PalletBoxRow, "suffix")
	
					If iSuffix > 0 then
						MessageBox(monsys.msg_title, "System can not generate label for object " + String(l_l_Serial) + " with suffix.", StopSign!)
						l_b_Print	= FALSE
					Else 
						If l_s_Part <> l_s_PrevPart then	//New part number
							l_b_Print					= TRUE
							l_l_ShipperDetailRow		= 0
							l_l_ShipperDetailRow		= dw_shipper_detail.find("part='" + l_s_Part + "'", 1, 9999)
							l_l_Order					= dw_shipper_detail.GetItemNumber(l_l_ShipperDetailRow, "shipper_detail_order_no")
							if lds_labels.Retrieve ( l_l_order, l_s_part ) > 0 then
								l_s_label = IsNull ( lds_labels.GetItemString ( 1, "box_label" ), "NOLABEL" )
							else
								l_s_label = 'NO LABEL'
							end if
							szDockCode				= f_get_order_info(l_l_Order, "DOCK CODE")
							szLineFeedCode			= f_get_order_info(l_l_Order, "LINE FEED")
							szCustomerPart			= f_get_order_info(l_l_Order, "CUSTOMER PART")
							szCustomerPO			= f_get_order_info(l_l_Order, "CUSTOMER PO")
							szZoneCode				= f_get_order_info(l_l_Order, "ZONE CODE")
	
							l_b_Print	= (l_s_label <> "NOLABEL")  or (l_s_label <> "NO LABEL")
							
						End If			
					End If
	
					If l_b_Print then
						wf_print_label(szCustomerPart, l_l_Serial, l_l_Order, l_s_label)
					End If
	
					l_s_PrevPart	= l_s_Part
	
				Next					
	
			Else
	
				l_s_Part					= dw_pallets.GetItemString(l_l_Row, "part")
				l_l_ShipperDetailRow		= 0
				l_l_ShipperDetailRow		= dw_shipper_detail.find("part='" + l_s_Part + "'", 1, 9999)
	
				If l_l_ShipperDetailRow > 0 then
					l_l_Order			= dw_shipper_detail.GetItemNumber(l_l_ShipperDetailRow, "shipper_detail_order_no")
					if lds_labels.Retrieve ( l_l_order, l_s_part ) > 0 then
						l_s_label = IsNull ( lds_labels.GetItemString ( 1, "box_label" ), "NOLABEL" )
					else
						l_s_label = 'NO LABEL'
					end if
					szDockCode		= f_get_order_info(l_l_Order, "DOCK CODE")
					szLineFeedCode	= f_get_order_info(l_l_Order, "LINE FEED")
					szCustomerPart	= f_get_order_info(l_l_Order, "CUSTOMER PART")
					szCustomerPO	= f_get_order_info(l_l_Order, "CUSTOMER PO")
					szZoneCode		= f_get_order_info(l_l_Order, "ZONE CODE")
					l_b_Print			= (l_s_label <> "NO LABEL")
	
					If l_b_Print then
						wf_print_label(szCustomerPart, l_l_Serial, l_l_Order, l_s_label)
					End If
	
				Else
					MessageBox(monsys.msg_title, "Part can not be found in shipper detail.", StopSign!)
				End If
			End If
		dw_pallets.SelectRow(l_l_Row, FALSE)
		End If
	
	Next
end if

DESTROY lds_labels

this.SetMicroHelp("Ready")
end event

event ue_print_update(string a_b_form_type);STRING l_s_type
a_b_form_type = string (Message.LongParm, "address")
CHOOSE CASE a_b_form_type
	CASE 'Pick list'
			MessageBox(monsys.msg_title, "Pick List has been printed")
			w_list_of_active_shippers.wf_picklist_print_status()		
	CASE 'Canadian Custom'
			MessageBox(monsys.msg_title,"Canadian custom form has been printed")								
	CASE 'Engineering Certs'
			MessageBox(monsys.msg_title,"Engineering Certs form has been printed")								
	CASE ELSE //'Packing List'
			msgbox(a_b_form_type + " has been printed")
			w_list_of_active_shippers.wf_set_print_status("Y")
			sle_document.text		= "Printed"
			sle_document.textcolor = f_get_color_value ( "green" )	
			w_list_of_active_shippers.bPrinted		= TRUE
			w_list_of_active_shippers.bStaged		= TRUE
			if dw_destination_scf.retrieve(sle_destination.text,ishipper) > 0 then 
				dw_destination_scf.print()
			end if 	
END CHOOSE

end event

event ue_open;dw_objects.SetTransObject ( sqlca )
dw_objects.Retrieve ( iShipper )
end event

event ue_unapproved_message;MessageBox ( "Shipping Dock", "This shipper's status is " + dw_shipper_header.GetItemString ( 1, "cs_status" ) + ".  You will be able to do everything except physically ship out the order.", Information! )

end event

event ue_verifyscan;if gb_vscan.visible = false then 
	dw_verifyscan.show()
	gb_vscan.show()
	st_vscanserial.show()
	em_verifyscan.show()
	em_verifyscan.text = ""
	gb_vscan.bringtotop = true
	st_vscanserial.bringtotop = true
	em_verifyscan.bringtotop = true
	em_verifyscan.setfocus()
else
	dw_verifyscan.hide()	
	gb_vscan.hide()
	st_vscanserial.hide()
	em_verifyscan.hide()
end if 	
end event

public subroutine updt_qty_on_pallet (long irow);Decimal 	nTareWeight

Long 		iBoxRow

String 	szObjectPackage

iPalletSerial 	= dw_pallets.GetItemNumber(iRow, "serial")
//nPalletTare		= dec(dw_pallets.GetItemString(iRow, "custom1"))

dw_boxes_on_pallet.Retrieve(iPalletSerial)

For iBoxRow = 1 to dw_boxes_on_pallet.RowCount()

	szPart 			= dw_boxes_on_pallet.GetItemString(iBoxRow, "part")
	nQty   			= f_get_value(dw_boxes_on_pallet.GetItemNumber(iBoxRow, "std_quantity"))
//	nWeight			= f_get_value(dw_boxes_on_pallet.GetItemNumber(iBoxRow, "weight"))
	szObjectPackage= dw_boxes_on_pallet.GetItemString(iBoxRow, "package_type")
//	nTareWeight		= f_get_value(dw_boxes_on_pallet.GetItemNumber(iBoxRow, "tare_weight"))
	iSuffix			= dw_boxes_on_pallet.GetItemNumber(iBoxRow, "suffix")

	If iSuffix > 0 then
		szPart	= szPart + "-" + String(iSuffix)
	End If

	Change_qty_for_part(szPart, nQty, "+")			//Add the qty
//	Change_weight_for_part(szPart, nWeight, nTareWeight, "+")	//Add the weight
	f_update_shipper_container(iShipper, szObjectPackage, "+")

Next

//wf_calculate_pallet_weight(iPalletSerial, nPalletTare) 
end subroutine

public function boolean check_parts_on_pallet (long iserial);Long li_Row

string ls_part

dw_boxes_on_pallet.Retrieve(iSerial)

For li_Row = 1 to dw_boxes_on_pallet.RowCount()

  ls_part = dw_boxes_on_pallet.getitemstring(li_Row, "part")



		
Next 

Return TRUE
end function

public function boolean shipper_is_staged ();String 	s_Unit, &
		 	s_UM, &
		 	s_StageFlag, &
		 	s_Part, &
		 	s_PartOriginal, &
			s_PackageType, &
			s_OrderType

Long     l_SalesOrder

Boolean bStaged		 //Whether the shipper is staged
Decimal nQtyStaged	 //The qty staged
Decimal dec_WgtStaged //The Weight of staged objects
Decimal nQtyRequired  //The qty required

Long    iRow			 //Current row number
Long    l_Suffix

iRow = 1   

bStaged = TRUE

DO WHILE bStaged AND (iRow <= dw_shipper_detail.RowCount())

	s_Part 		  	= f_get_string_value ( dw_shipper_detail.GetItemString ( iRow, "part" ) )
	l_Suffix      	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_suffix" ) )
	s_PartOriginal	= wf_strip_off_suffix ( s_Part, l_Suffix )
	s_Unit        	= f_get_string_value ( dw_shipper_detail.GetItemString ( iRow, "shipper_detail_alternative_unit" ) )
	dec_WgtStaged 	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_gross_weight" ) )
	nQtyStaged	  	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_qty_required" ) )
	nQtyRequired  	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_alternative_qty" ) )

	SELECT order_no  
     INTO :l_SalesOrder  
     FROM shipper_detail  
    WHERE ( shipper = :iShipper ) AND  
          ( part = :s_Part )   ;

	s_OrderType		= f_get_order_info ( l_SalesOrder, "ORDER TYPE" )

	If s_OrderType = "B" Then
		s_PackageType = f_get_order_info ( l_SalesOrder, "PACKAGE TYPE" )
	Else
		If l_Suffix <> 0 AND NOT IsNull ( l_Suffix ) Then
	  		SELECT 	packaging_type
	    	INTO 		:s_PackageType  
	    	FROM 		order_detail  
	   	WHERE 	( order_no = :l_SalesOrder ) AND  
	 	        		( part_number = :s_PartOriginal ) AND
						( suffix = :l_Suffix )  ;
		Else
	  		SELECT 	packaging_type
	    	INTO 		:s_PackageType  
	    	FROM 		order_detail  
	   	WHERE 	( order_no = :l_SalesOrder ) AND  
	 	        		( part_number = :s_PartOriginal ) ;
		End If
	End if

	SELECT unit,
			 stage_using_weight
	  INTO :s_UM,
			 :s_StageFlag
	  FROM part_packaging
	 WHERE part = :s_PartOriginal	and
			 code = :s_PackageType ;

	IF SQLCA.SQLCode = 0 THEN
		IF s_UM = s_Unit AND s_StageFlag = "Y" THEN
			IF nQtyStaged > dec_WgtStaged THEN
				bStaged = FALSE
			END IF
		ELSE
			IF nQtyStaged > nQtyRequired THEN
				bStaged = FALSE
			END IF
		END IF
	ELSE
		IF nQtyStaged > nQtyRequired THEN
			bStaged = FALSE
		END IF
	END IF

	iRow = iRow + 1

LOOP 

IF bStaged THEN
	sle_status.text	= "Staged"
	sle_status.textcolor	= f_get_color_value ( "green" )		//65280
	Timer ( 0 )
ELSEIF dw_pallets.RowCount ( ) > 0 THEN
	sle_status.text   = "In Process"
	sle_status.textcolor	= sle_shipper.textcolor
	Timer ( 0.5 )
ELSE
	sle_status.text	= "Not ready"
	sle_status.textcolor	= sle_shipper.textcolor
END IF

Return bStaged

end function

public subroutine unstage_whole_pallet ();Decimal 	nTareWeight

Long 		iCurrentPallet
Long 		iNullValue
Long 		iRow
Long		iTotalRows
LONG		ll_row
LONG		ll_serial

String 	szObjectPackage
String   s_StageFlag
String   s_kanban
String	ls_dest

Boolean	bOk

SetNull(iNullValue)
SetNull(ls_dest)
iCurrentPallet = iSerial

UPDATE	object  
SET	shipper = :iNullValue, 
	destination = :ls_dest,
	show_on_shipper = 'N' 
WHERE	parent_serial = :iCurrentPallet;

UPDATE	object
SET	shipper = :iNullValue,
	destination = :ls_dest,
	kanban_number = '',
	show_on_shipper = 'N'
WHERE 	serial = :iserial;

bOk	= (SQLCA.SQLCode = 0) 

If bOk then				
	dw_boxes_on_pallet.Retrieve(iCurrentPallet)
	iRow		= 1
	iTotalRows	= dw_boxes_on_pallet.RowCount()
	
	If iTotalRows > 0 then
	
		Do while bOk AND (iRow <= iTotalRows)
		
			ll_serial 	= dw_boxes_on_pallet.GetitemNumber(irow, "serial" )
			szPart  	= dw_boxes_on_pallet.GetItemString(iRow, "part")
			nQty    	= dw_boxes_on_pallet.GetItemNumber(iRow, "std_quantity")
			nWeight		= dw_boxes_on_pallet.GetItemNumber(iRow, "weight")
			szObjectPackage	= dw_boxes_on_pallet.GetItemString(iRow, "package_type")
			nTareWeight	= dw_boxes_on_pallet.GetItemNumber(iRow, "tare_weight")
			iSuffix		= dw_boxes_on_pallet.GetItemNumber(iRow, "suffix")
			
			bOk	= f_update_shipper_container(iShipper, szObjectPackage, "-*")
			If bOk then
				If iSuffix > 0 then
					szPart	= szPart + "-" + String(iSuffix)
				End If
			
				bOk	= Change_qty_for_part(szPart, nQty, "-*")
			
				If bOk then
					bOk	= Change_weight_for_part(szPart, nWeight, nTareWeight, "-*")
				End If
			
				If bOk then
					bOk	= (dw_shipper_detail.Update() > 0) 
					If bOk then
						dw_shipper_detail.Retrieve ( iShipper )
						bOk = wf_refresh_shipper_status() //Check and change status
						IF bOk THEN
							ll_row = dw_objects.Find ( "serial = " + String ( ll_serial ), 1, dw_objects.RowCount ( ) )
							IF ll_row > 0 AND dw_objects.GetItemNumber ( ll_row, "serial" ) = ll_serial THEN
								dw_objects.object.shipper[ll_row] = 0
								dw_objects.object.origin[ll_row] = ''
							END IF
						END IF
					End If
				End If
			End If
			iRow ++
		Loop
		
		Update	object  
		Set	shipper = :iNullValue,
			destination = :ls_dest
		Where	serial 	= :iCurrentPallet   ;
		
		bOk	= (SQLCA.SQLCode = 0)
		
		ll_row	= dw_objects.Find ( "serial = " + String ( iCurrentPallet ), 1, dw_objects.RowCount ( ) )
		IF ll_row > 0 then
			if dw_objects.GetItemNumber ( ll_row, "serial" ) = iCurrentPallet THEN
				dw_objects.object.shipper[ll_row] = 0
				dw_objects.object.origin[ll_row] = ''
			end if
		END IF
	Else
		//  Create audit trail
		If Not f_create_audit_trail ( iCurrentPallet, "D", "", '0', '', "", '', '0', "", "", "", "No Commit" ) Then
			f_beep ( 5 )
			MessageBox ( "Error", "Unable to create audit trail!", StopSign! )
			bOk	= (SQLCA.SQLCode = 0)			
		else	
			//Delete Empty Pallet 
			DELETE FROM object  
			WHERE serial = :iCurrentPallet   ;
			
			bOk	= (SQLCA.SQLCode = 0)
		End if		
	End If
End If

If bOk then
	if sqlca.of_setbolprintedstatus ( iShipper, 'N' ) = 0 then
		Commit;
		wf_update_kanban(iserial)
		wf_update_pallet_numbers("-", 1)
	else
		Rollback;
	end if
Else
	Rollback;
End If
end subroutine

public function string status_of_shipper (long ishipper);If w_list_of_active_shippers.bStaged AND w_list_of_active_shippers.bPrinted then
	Return "READY"
Else
	Return "NOT STAGED"
End If
end function

public subroutine generate_asn ();OpenWithParm(w_asn_file_generator, iShipper)
end subroutine

public function long get_sales_order (string szpart);Long iRow
Long iSalesOrder

Boolean bDone

iRow = 1
bDone = FALSE

Do While (Not bDone) and (iRow <= dw_shipper_detail.RowCount())

	If	dw_shipper_detail.GetItemString(iRow, "part") = szPart then
		bDone = TRUE
		iSalesOrder = dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_order_no")
	End If

	iRow = iRow + 1
Loop

Return iSalesOrder  
end function

public function boolean isblankorder (long isalesorder);String szOrderType

 SELECT order_header.order_type  
   INTO :szOrderType  
   FROM order_header  
 WHERE  order_header.order_no = :iSalesOrder   ;

Return (szOrderType="B")
end function

public function boolean need_asn (string szdestination);String szCreateASN

SELECT 	edi_setups.auto_create_asn,
    		edi_setups.asn_overlay_group  
  INTO 	:szCreateASN, :szOverlay  
  FROM 	edi_setups  
 WHERE 	edi_setups.destination = :szDestination   ;

Return	(szCreateASN = "Y")


end function

public function boolean wf_need_to_check_object_package ();String szCheckPackage

SELECT parameters.verify_packaging  
INTO :szCheckPackage  
FROM parameters  ;


Return (szCheckPackage	= "Y")

end function

public function long row_of_part_in_detail (string szpart);Long 		iRow
Boolean 	bDone


iRow		= 1
bDone		= FALSE

String   ls_Part
string	ls_sdpart

Do while (Not bDone) AND (iRow <= dw_shipper_detail.RowCount())
	if dw_shipper_detail.GetItemString ( iRow, "configurable" ) = 'Y' then
		ls_sdpart = dw_shipper_detail.GetItemString(iRow, "part")
	else
		ls_sdpart = dw_shipper_detail.GetItemString(iRow, "part_original")
	end if
	If szPart	= ls_sdpart then
		bDone	= TRUE
	Else
		iRow ++
	End If
Loop

If iRow > dw_shipper_detail.RowCount() then
	iRow	= 0
End If

Return iRow


end function

public function boolean wf_check_object_package (string szpart, string szpackage);Long 		iSalesOrder
Long 		iRow
Boolean 	bRightPackage
string	ls_ordertype
datetime	ldt_datedue

iRow	= row_of_part_in_detail(szPart)

If iRow > 0 then
	iSalesOrder	= dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_order_no")
	
  	SELECT	order_header.order_type  
   INTO		:ls_ordertype
   FROM		order_header  
   WHERE		order_header.order_no = :iSalesOrder   ;

	choose case ls_ordertype
		case "B"
			select	min(due_date)
			into		:ldt_datedue
			from		order_detail
			where		order_no = :iSalesOrder ;
			
		case "N"
			select	min(due_date)
			into		:ldt_datedue
			from		order_detail
			where		order_no = :iSalesOrder and
						part_number = :szPart ;

	end choose
	
	select	min(packaging_type)
	into		:szOrderPackage
	from		order_detail
	where		order_no = :iSalesOrder and
				due_date = :ldt_datedue ;
End If

If Trim ( f_get_string_value ( szOrderPackage ) ) = Trim ( f_get_string_value ( szPackage ) ) Then Return True

bRightPackage	= (wf_get_string_value(szOrderPackage)	= &
						wf_get_string_value(szPackage))

If IsNull(bRightPackage) then
	bRightPackage	= FALSE
End If

Return bRightPackage		

end function

public function string wf_get_string_value (string szValue);If IsNull(szValue) then
	Return " "
Else
	Return szValue
End If
end function

public function string wf_get_customer (string szdestination);  SELECT destination.customer  
    INTO :szCustomer  
    FROM destination  
   WHERE destination.destination = :szDestination   ;

Return szCustomer

end function

public function boolean wf_valid_parts_on_pallet (long ipalletserial);Long 		iRow
Boolean	bValid

iRow		= 1
bValid	= TRUE

dw_view_boxes_on_pallet.Retrieve(iPalletSerial)

Do While bValid and (iRow <= dw_view_boxes_on_pallet.RowCount())
	szPart	= dw_view_boxes_on_pallet.GetItemString(iRow, "part")
	iSuffix	= dw_view_boxes_on_pallet.GetItemNumber(iRow, "suffix") 
	if iSuffix > 0 then
		bValid	= (row_of_part_in_detail(szPart + "-" + String(iSuffix)) > 0)
	Else
		bValid	= (row_of_part_in_detail(szPart) > 0 )
	End If
	iRow ++
Loop
	
Return bValid
end function

public subroutine wf_show_note (boolean bflag);cb_note.visible		= bFlag
cb_note_exit.visible	= bFlag
mle_note.visible		= bFlag
end subroutine

public subroutine unstage_box (long iserial);Decimal nTareWeight

Integer iCurrentShipper
Integer iCurrentPallet

Long    lsuffix
LONG		ll_row

String  szObjectPackage
String	ls_destination

dw_object_info.Retrieve(iSerial)				//Retrieve the object info

If dw_object_info.RowCount() > 0 then		//If the object exists

	szObjectPackage	= dw_object_info.GetItemString(1, "package_type")
	SetNull(iCurrentShipper)
	SetNull(iCurrentPallet)
	SetNull(ls_destination)

	dw_object_info.SetItem(1, "shipper", iCurrentShipper) 		//Reset shipper
	dw_object_info.SetItem(1, "parent_serial", iCurrentPallet)  //Reset pallet		
	dw_object_info.SetItem(1, "show_on_shipper", "N")
	dw_object_info.SetItem(1, "kanban_number", '') 
	dw_object_info.SetItem(1, "destination", ls_destination)

	szPart 		= dw_object_info.GetItemString(1, "part")
	nQty   		= f_get_value(dw_object_info.GetItemNumber(1, "std_quantity"))
	iSuffix		= dw_object_info.GetItemNumber(1, "suffix")  // for 'consider suffix option'

	// removed code using bneedsuffix
	
	If dw_object_info.Update() >0 then
		if sqlca.of_setbolprintedstatus ( iShipper, 'N' ) = 0 then
			Commit;
			
			f_update_shipper_container(iShipper, szObjectPackage, "-")
	
			If iSuffix > 0 then
				szPart	= szPart + "-" + String(iSuffix)
			End If
	
			Change_qty_for_part(szPart, nQty, "-")			//Delete qty for detail
	
	//		ll_row = dw_objects.Find ( "serial = " + String ( iSerial ), 1, dw_objects.RowCount ( ) )
	//		IF ll_row > 0 AND dw_objects.GetItemNumber ( ll_row, "serial" ) = iSerial THEN
	//			dw_objects.object.shipper[ll_row] = 0
	//			dw_objects.object.origin[ll_row] = ''
	//			dw_objects.object.parent_serial[ll_row] = 0
	//		END IF
	
			dw_objects.Retrieve ( iShipper )
		
		Else
			Rollback;
		End If
	Else
		Rollback;
	End If
ELSE
	ll_row = dw_objects.Find ( "serial = " + String ( iSerial ), 1, dw_objects.RowCount ( ) )
	IF ll_row > 0 AND dw_objects.GetItemNumber ( ll_row, "serial" ) = iSerial THEN
		dw_objects.DeleteRow ( ll_row )
	END IF
End If

end subroutine

public function boolean box_exist (long iserial);Return (dw_object_info.Retrieve(iserial) > 0)
end function

public subroutine wf_set_detail_qty (decimal nqty);
String szWorkOrder
nQty = f_get_value(nQty)


If nQty > 0 then
	dw_shipper_detail.SetItem(iDetailRow, "shipper_detail_qty_required", nQty)
Else
	If dw_shipper_detail.GetItemNumber(iDetailRow, "shipper_detail_qty_packed") > 0 then
		MessageBox("Warning", "You must unstage the selected part", StopSign!)
		Return
	Else
		dw_shipper_detail.DeleteRow(iDetailRow)
		iDetailRow	= 0
		dw_objects.Reset()
	End If
End If


If dw_shipper_detail.Update() > 0 then
	Commit;
	if	nqty = 0 then 
		SendEMail("Quantity for part "+szpart+" was set to zero, on shipper "+string(ishipper))
	else
		SendEMail("Quantity for part "+szpart+" was modified to "+string(nqty)+ ", on shipper "+string(ishipper))
	end if 
	
	If iDetailRow = 0 then
		SetNull(szPart)
	End If
Else
	Rollback;
End If

If dw_shipper_detail.RowCount() > 0 then
	shipper_is_staged()			//Check whether shipper now is staged or not
End If

If dw_shipper_detail.RowCount() > 0 then
	Check_shipper_status()
Else

	w_list_of_active_shippers.wf_set_status("E")
	MessageBox("Warning", "This is an empty shipper~r therefore system will automatically void it", StopSign!)
	w_shipping_mdi_screen.ChangeMenu(m_list_of_shippers)
	Close(w_shipping_dock)
End If


end subroutine

public function boolean wf_bol_printed (long ishipper);Long 		iBOL			//To keep the true BOL number
String 	szPrint		//Whether BOL has been printed

SELECT shipper.bill_of_lading_number  	//Grab BOL#
  INTO :iBOL  
  FROM shipper  
 WHERE shipper.id = :iShipper   ;

If IsNull ( iBOL, 0 ) > 0 then
  SELECT bill_of_lading.printed  
    INTO :szPrint  
    FROM bill_of_lading  
   WHERE bill_of_lading.bol_number = :iBOL   ;

	If szPrint = "Y" then
		Return TRUE			//Yes, BOL has been printed
	Else
		Return FALSE		//No, BOL has NOT been printed
	End If
Else
	Return TRUE				//No Bill of Lading required
End If
end function

public function decimal wf_get_price (long isalesorder);Decimal nPrice

  SELECT order_header.price  
    INTO :nPrice  
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

Return f_get_value(nPrice)
end function

public function string wf_shipper_type (long ishipper);String szType

  SELECT shipper.type  
    INTO :szType  
    FROM shipper  
   WHERE shipper.id = :iShipper   ;

If IsNull(szType) or szType = '' then
	szType	= 'S'
End If

Return szType
end function

public subroutine wf_reset_mps (long ishipper);String szWorkOrder

szWorkOrder	= "O" + String(iShipper)

UPDATE master_prod_sched  
   SET qty_assigned = 0  
 WHERE workcenter = :szWorkOrder   ;


end subroutine

public subroutine wf_update_pallet_numbers (string cflag, int iqty);Integer iCurrentQty

Select shipper.staged_pallets  
  Into :iCurrentQty  
  From shipper  

 Where shipper.id = :iShipper;

If cFlag	= "+" then
	iCurrentQty	= f_get_value(iCurrentQty) + iQty
Else
	If cFlag = "-" then
		iCurrentQty	= f_get_value(iCurrentQty) - iQty
	Else
		iCurrentQty	= iQty
	End If
End If

Update shipper  
   Set staged_pallets = :iCurrentQty
 Where id = :iShipper;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

end subroutine

public subroutine wf_assign_shipper_to_boxes (long ipalletserial);Update object  
   Set shipper = :iShipper  
 Where parent_serial = :iPalletSerial   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If
end subroutine

public function string wf_get_label_window (string szlabel);String l_s_window

  SELECT object_name  
    INTO :l_s_window  
    FROM report_library  
   WHERE report_library.name = :szLabel   ;

Return l_s_window

end function

public function string wf_get_supplier_code (string szdestination);String szSupplier

  SELECT edi_setups.supplier_code  
    INTO :szSupplier  
    FROM edi_setups  
   WHERE edi_setups.destination = :szDestination   ;

Return f_get_string_value(szSupplier)
end function

public subroutine wf_reset_staged_pallets ();UPDATE shipper  
   SET staged_pallets = 0  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If
end subroutine

public function boolean wf_shipper_is_closed (long ishipper);String szStatus

SELECT shipper.status  
  INTO :szStatus  
  FROM shipper  
 WHERE shipper.id = :iShipper   ;

Return (szStatus	= "C") or (szStatus = "Z")
end function

public subroutine wf_calculate_pallet_weight (long ipalletserial, decimal norigpallettare);Decimal nTareWeight
Decimal nNetWeight


//Calculate the total tareweight and Net weight for boxes on pallet

Select sum(package_materials.weight)
  Into :nTareWeight
  From object,
		 package_materials  
 Where object.package_type = package_materials.code and
		 object.parent_serial = :iPalletSerial;

Select sum(object.weight)  
  Into :nNetWeight  
  From object  
 Where object.parent_serial = :iPalletSerial;

nTareWeight	= f_get_value(nTareWeight) + nOrigPalletTare
nNetWeight	= f_get_value(nNetWeight)  

//Update object  
//   Set weight 			= :nNetWeight,   
//       tare_weight 	= :nTareWeight  
// Where serial = :iPalletSerial   ;
//
//If SQLCA.SQLCode = 0 then
//  	Commit;
	If dw_pallet_info.RowCount() > 0 then
		dw_pallet_info.SetItem(1, "tare_weight", f_get_value(nTareWeight))
		dw_pallet_info.SetItem(1, "net_weight", f_get_value(nNetWeight))
		dw_pallet_info.SetItem(1, "gross_weight", f_get_value(nTareWeight) + &
																f_get_value(nNetWeight))
	End If
//Else
//	Rollback;
//End If
//

end subroutine

public function boolean wf_update_quantity_in_normal_order (long iorder, string szpart, decimal nqty, long isuffix);int		l_i_count
integer	li_sequence
Decimal 	ldec_orderqty
Decimal	ldec_qtyleft
decimal	ldec_modqty
decimal	ldec_stdmodqty
boolean	lb_return
long		ll_row
long		ll_rowcount
string	ls_unit

ldec_qtyleft = nQty

Do
	If iSuffix > 0 then
	
		Select	order_detail.quantity,
					order_detail.sequence,
					order_detail.unit
		Into 		:ldec_orderqty,
					:li_sequence,
					:ls_unit
		From 		order_detail  
		Where 	( order_detail.order_no = :iOrder ) AND  
					( order_detail.part_number = :szPart ) AND   
					( order_detail.suffix = :iSuffix);
	
	Else
	
		select	min ( sequence )
		into		:li_sequence
		from		order_detail
		where		order_no = :iOrder and
					part_number = :szPart ;
					
		Select	order_detail.quantity,
					order_detail.unit
		Into 		:ldec_orderqty,
					:ls_unit
		From 		order_detail  
		Where 	( order_detail.order_no 		= :iOrder ) AND  
					( order_detail.part_number 	= :szPart ) and
					( sequence = :li_sequence ) ;
	
	End If

	If SQLCA.SQLCode = 0 then	//If the detail item still exists
	
		if ldec_orderqty < ldec_qtyleft then
			ldec_qtyleft = ldec_qtyleft - ldec_orderqty
			ldec_modqty = ldec_orderqty
			ldec_orderqty = 0
		else
			ldec_orderqty = ldec_orderqty - ldec_qtyleft
			ldec_modqty = ldec_qtyleft
			ldec_qtyleft = 0
		end if

		ldec_stdmodqty = f_convert_units ( ls_unit, "", szPart, ldec_modqty )
		
		If iSuffix > 0 then		//
			If ldec_orderqty > 0 then
				Update 	order_detail  
				Set 		quantity = quantity - :ldec_modqty,
							std_qty = std_qty - :ldec_stdmodqty
				Where 	( order_no = :iOrder ) And
							( part_number = :szPart ) And
							( suffix = :iSuffix);
			Else
				Delete FROM order_detail  
				Where ( order_no 		= :iOrder ) AND  
						( part_number 	= :szPart ) AND
						( suffix			= :iSuffix)  ;

				update	order_detail
				set		sequence = sequence - 1
				where		order_no = :iOrder and
							sequence > :li_sequence ;
			End If
		Else
			If ldec_orderqty > 0 then
				Update 	order_detail  
				Set 		quantity = quantity - :ldec_modqty,
							std_qty = std_qty - :ldec_stdmodqty
				Where 	( order_no = :iOrder ) And
							( part_number = :szPart ) and
							( sequence = :li_sequence ) ;
			Else
				Delete FROM order_detail  
				Where ( order_no 		= :iOrder ) AND  
						( part_number 	= :szPart )  and
						( sequence = :li_sequence ) ;

				update	order_detail
				set		sequence = sequence - 1
				where		order_no = :iOrder and
							sequence > :li_sequence ;
			End If
		End If
	
		If SQLCA.SQLCode = 0 then
			SELECT	count(*)
			INTO		:l_i_count
			FROM		order_detail
			WHERE		order_no = :iOrder ;
		
			if l_i_count <= 0 then
				UPDATE	order_header
				SET		status = 'C'
				WHERE		order_header.order_no = :iOrder ;
				if sqlca.sqlcode = 0 then
					lb_return = TRUE
				else
					lb_return = FALSE
				end if
			else
				lb_return = TRUE
			end if
		Else
			lb_return = FALSE
		End If
	
	Else
		
		ldec_qtyleft = 0
	
		SELECT	count(*)
		INTO		:l_i_count
		FROM		order_detail
		WHERE		order_no = :iOrder ;
	
		if l_i_count <= 0 then
			UPDATE	order_header
			SET		status = 'C'
			WHERE		order_header.order_no = :iOrder ;
			if sqlca.sqlcode = 0 then
				lb_return = TRUE
			else
				lb_return = FALSE
			end if
		else
			lb_return = TRUE
		end if
	
	
	End If
Loop While ldec_qtyleft > 0

//if lb_return then
//	dw_order_detail.Retrieve ( iOrder )
//	dw_order_detail.SetSort ( "sequence A" )
//	dw_order_detail.Sort ( )
//	
//	for ll_row = 1 to ll_rowcount
//		dw_order_detail.SetItem ( ll_row, "sequence", ll_row )
//	next
//	
//	if dw_order_detail.Update ( ) = -1 then
//		lb_return = FALSE
//	end if
//end if

return lb_return
end function

public function boolean wf_ready_for_scan ();Boolean bOk

If wf_shipper_is_closed(iShipper) then
	MessageBox("Warning", "This shipper is already closed by another user!", StopSign!)
	Close(w_shipping_dock)
End If

If (Not wf_bol_printed(iShipper)) then
	MessageBox("Warning", "Bill of Lading has not been printed", StopSign!)
	bOK	=  FALSE
Else
	If sle_status.text<> "Staged" then
		MessageBox("Warning", "Shipper is not staged", Stopsign!)
		bOk	= FALSE
	Else
		If bType Then
			wf_reset_printed_flag('Y', ishipper)
		End If

		If sle_document.text <> "Printed" then
			MessageBox("Warning", "Document has not been printed", StopSign! )
			bOk	= FALSE
		Else
			bOk	= TRUE
		End If
	End If
End If

Return bOk	

end function

public function boolean wf_scan_objects_to_truck ();Long iRow
Long iTotalObjects

Boolean bOK

iTotalObjects	= dw_pallets.RowCount()
iRow				= 1
bOK				= True

//Scan objects to truck

Do while bOK AND (iRow <= iTotalObjects) 
	is_MLE_Line2 = 'Object ' + String ( iRow ) + ' of ' + String ( iTotalObjects ) + '.'
	mle_scan_out.Text = is_MLE_Line1 + '~r~n' + is_MLE_Line2 + '~r~n' + is_MLE_Line3
	If dw_pallets.GetItemString(iRow, "type") = "S" then
		bOk	= Ship_out_pallet(dw_pallets.GetItemNumber(iRow, "serial"))
	Else
		bOK	= Ship_out_box(dw_pallets.GetItemNumber(iRow, "serial"))
	End If
	iRow ++
Loop

Return bOK
end function

public function boolean wf_update_orders ();Long iRow
Long iTotalItems

String 	szOrderType
string	ls_release_no

Decimal nOurCum

Boolean bOK

DateTime	ldt_release_date

iRow			= 1
iTotalItems	= dw_shipper_detail.RowCount()
bOk			= TRUE

//Do while bOk AND (iRow <= iTotalItems)
for iRow = 1 to iTotalItems
	
	iSalesOrder 		= dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_order_no")
	nQty					= dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_alternative_qty")
	szPart				= dw_shipper_detail.GetItemString(iRow, "part")
	iSuffix				= dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_suffix")

	mle_scan_out.text	= "Processing sales order " + String(iSalesOrder) + " for part " + szPart

	If szShipperType = "O" then		//If this is outside process

		bOK	= f_update_part_vendor_cum(szPart, sle_destination.text, nQty)	

	Else										//This is a non outside process

		dw_order_header.Retrieve(iSalesOrder)
		If dw_order_header.RowCount() > 0 then	//Make sure that the order is still there

			szOrderType		=	dw_order_header.GetItemString(1, "order_type") 

			dw_shipper_detail.SetItem(iRow, "shipper_detail_operator", is_operator)
			dw_shipper_detail.SetItem(iRow, "shipper_detail_date_shipped", Today())
			dw_shipper_detail.SetItem(iRow, "shipper_detail_week_no", f_get_week_no(Today()))

			If szOrderType = 'B' then

				nOurCum		=  f_get_value(dw_order_header.GetItemNumber(1, "our_cum")) + nQty
				dw_shipper_detail.SetItem(iRow, "shipper_detail_accum_shipped", nOurCum)
				if wf_get_order_release_date ( iSalesOrder, '', 0, ldt_release_date, ls_release_no ) = 1 then
					dw_shipper_detail.SetItem ( iRow, "release_date", ldt_release_date )
					dw_shipper_detail.SetItem ( iRow, "release_no", ls_release_no )
				end if
				
				SetMicroHelp ( "dw_shipper_detail update" )
				If dw_shipper_detail.Update() > 0 then
					dw_order_header.SetItem(1, "our_cum", nOurCum)
					SetMicroHelp ( "dw_order_header update" )
					If dw_order_header.Update() > 0 then

						bNoCommit	= TRUE
						bFinish		= FALSE

						wf_update_release_in_blanket_order ( iSalesOrder )

						bOk	= bSuccess

					Else

						bOK	= FALSE

					End If

				Else
						bOk	= FALSE
				End If

			Else		//Normal order

				if wf_get_order_release_date ( iSalesOrder, szPart, iSuffix, ldt_release_date, ls_release_no ) = 1 then
					dw_shipper_detail.SetItem ( iRow, "release_date", ldt_release_date )
					dw_shipper_detail.SetItem ( iRow, "release_no", ls_release_no )
				end if

				If dw_shipper_detail.Update() > 0 then
					If iSuffix > 0 then
						szPart = wf_strip_off_suffix(szPart, iSuffix)
					End If
	
					bOK = wf_update_quantity_in_normal_order(iSalesOrder, szPart, nQty, iSuffix) 
				Else
					bOK = FALSE
				End If

			End If
		End If
	End If

//	iRow ++
Next	
//Loop

Return bOK
end function

public function boolean wf_set_shipped_datetime ();dw_shipper_header.Retrieve(iShipper)

If dw_shipper_header.RowCount() > 0 then
	dw_shipper_header.SetItem(1, "date_shipped", Today())
	dw_shipper_header.SetItem(1, "time_shipped", Now())
	
	If dw_shipper_header.Update () > 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	Return False
End If

end function

public function decimal wf_get_part_price (string szpart, decimal isuffix);Decimal nPrice

If iSuffix > 0 then
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
	       ( shipper_detail.part 		= :szPart ) AND  
	       ( shipper_detail.suffix 	= :iSuffix )   ;
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
	       ( shipper_detail.part 		= :szPart ) ; 
End If

Return nPrice

end function

public function boolean wf_update_cost (string szpart, long isuffix, decimal ncost);If iSuffix > 0 then
  Update "shipper_detail"
  Set 	"total_cost" = :nCost  //total_cost + :nCost  
  Where 	( shipper = :iShipper ) And 
         ( part_original = :szPart) And  
         ( suffix = :iSuffix )   ;
Else
  Update "shipper_detail"  
  Set 	"total_cost" = :nCost  //total_cost + :nCost  
  Where 	( shipper = :iShipper ) And 
         ( part = :szPart );
End If

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public function boolean wf_reset_total_cost ();UPDATE "shipper_detail"  
   SET "total_cost" = 0  
 WHERE shipper = :iShipper   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If	
end function

public function boolean change_qty_for_part (string szpart, decimal nqty, string csign);//***********************************************************************
//* Declaration
//***********************************************************************
Decimal nCurrentQty		//to keep the current qty for the detail part
Decimal nAlternativeQty	//to keep the alternative quantity 

Long	  iTotalBoxes 		//to keep the total boxes number
Long    iRow				//Current row number

Boolean bDone				//to exit the loop
Boolean bNoCommit	= FALSE

String  szAlternativeUM	//to keep the alternative unit of measurement
	
//***********************************************************************
//* Initialization
//***********************************************************************

If Right(cSign, 1) = '*' then
	bNoCommit	= TRUE
Else
	bNoCommit	= FALSE
End If

iRow 	= 1   
bDone = FALSE

//***********************************************************************
//* Declaration
//***********************************************************************

Do while (Not bDone) and (iRow <= dw_shipper_detail.RowCount())

	If szPart = dw_shipper_detail.GetItemString(iRow, "part") then
		nCurrentQty = f_get_value(dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_qty_packed"))
		iTotalBoxes	= f_get_value(dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_boxes_staged"))
	
		If cSign = "+" then
			nCurrentQty	= nCurrentQty + nQty

			iTotalBoxes	++	
		Else
			nCurrentQty	= nCurrentQty - nQty
			iTotalBoxes --
		End If
		dw_shipper_detail.SetItem(iRow, "shipper_detail_qty_packed", nCurrentQty)
		dw_shipper_detail.SetItem(iRow, "pack_line_qty", nCurrentQty)
		dw_shipper_detail.SetItem(iRow, "shipper_detail_boxes_staged", iTotalBoxes)

		szAlternativeUM	= dw_shipper_detail.GetItemString(iRow, "shipper_detail_alternative_unit")
		If IsNull(szAlternativeUM) then		//If AlternativeUM not defined, consider it as std unit
			nAlternativeQty	= nCurrentQty
		Else	
			nAlternativeQty	= f_convert_units("", szAlternativeUM, szPart, nCurrentQty)
		End If

		dw_shipper_detail.SetItem(iRow, "shipper_detail_alternative_qty", Round(nAlternativeQty , 2))

		iRow = dw_shipper_detail.RowCount()

	End If

	iRow = iRow + 1

Loop 

If dw_shipper_detail.Update() > 0 then
	If Not bNoCommit then
		Commit;
	End If
	Return TRUE
Else
	If Not bNoCommit then
		Rollback;
	End If
	Return TRUE
End If




end function

public function boolean change_weight_for_part (string szpart, decimal nunitweight, decimal ntareweight, string csign);Return TRUE
end function

public function boolean wf_recalc_total_boxes_and_weight ();Decimal 	nGrossWeight
Long 		iBoxes
Long 		iRow

iBoxes			= 0

For iRow = 1 to dw_shipper_detail.RowCount()
	iBoxes		= iBoxes + dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_boxes_staged")
Next

w_list_of_active_shippers.iBoxes			= iBoxes
w_list_of_active_shippers.nGrossWeight	= nGrossWeight


UPDATE "shipper"  
   SET "staged_objs" = :iBoxes
 WHERE id = :iShipper   ;

w_list_of_active_shippers.dw_shipping_dock.SetItem(&
						w_list_of_active_shippers.iSelectedRow, "Staged_objs", iBoxes)

If SQLCA.SQLCode = -1 then
	Return FALSE
Else
	Return TRUE
End If




end function

public subroutine wf_calc_boxes_and_weight ();Decimal 	nGrossWeight
Long 		iBoxes
Long 		iRow

iBoxes			= 0

For iRow = 1 to dw_shipper_detail.RowCount()
	iBoxes			= iBoxes + dw_shipper_detail.GetItemNumber(iRow, "shipper_detail_boxes_staged")
Next

w_list_of_active_shippers.iBoxes			= iBoxes
w_list_of_active_shippers.nGrossWeight	= nGrossWeight

UPDATE "shipper"  
   SET "staged_objs" = :iBoxes
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

w_list_of_active_shippers.dw_shipping_dock.SetItem(&
						w_list_of_active_shippers.iSelectedRow, "Staged_objs", iBoxes)


end subroutine

public function boolean wf_refresh_shipper_status ();String szStatus

If shipper_is_staged() then
	szStatus	= 'S'
Else
	szStatus	= 'O'
	sle_document.text	= "Not Printed"
End If

if wf_set_shipper_status(szStatus) then
	commit;
	return true
else
	rollback;
	return false
end if

end function

public function boolean wf_set_shipper_status (string szStatus);UPDATE "shipper"  
   SET "status" = :szStatus  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public subroutine check_shipper_status ();wf_calc_boxes_and_weight() 

If shipper_is_staged() then
	w_list_of_active_shippers.wf_set_status("S")
Else
	w_list_of_active_shippers.wf_set_status("O")

	sle_document.text	= "Not Printed"
End If

end subroutine

public subroutine wf_update_release_in_blanket_order (long iorder);Decimal	nOurCum

Select order_header.our_cum  
Into   :nOurCum  
From   order_header  
Where  order_header.order_no = :iOrder   ;

dw_order_detail.Retrieve(iOrder)

wf_update_releases(iOrder,nOurCum)

end subroutine

public subroutine wf_update_releases (long iorder, decimal nourcum);//************************************************************************
//* Declaration
//************************************************************************
Long iTotalRow
Long iRow
Long iReleaseRow
Long iRowId

Boolean 	bDelete
Boolean 	bConvert

Decimal 	nTheCum
Decimal 	nNetQty
Decimal 	nStdQty
Decimal 	nRatio
Decimal	nOrigQty

String  szPart
String  szShippingUnit

//************************************************************************
//* Initialization
//************************************************************************

For iRow = 1 to iDelCount
	iDelArray[iRow] = 0
Next 

iDelCount 	= 0

szPart			= f_get_order_info(iOrder, 'BLANKET PART')
szShippingUnit	= f_get_order_info(iOrder, "SHIPPING UNIT")

bConvert	= (Not IsNull(szShippingUnit)) AND &
			  (f_get_string_value(szShippingUnit) <> f_get_part_info(szPart, "STANDARD UNIT"))

If bConvert then
	nRatio	= f_convert_units(szShippingUnit, "", szPart, 1)
Else
	nRatio	= 1
End If

//************************************************************************
//* Main Routine
//************************************************************************

iTotalRow = dw_order_detail.RowCount()

dw_order_detail.SelectRow(0, FALSE)
dw_order_detail.SetSort("1a")
dw_order_detail.Sort()

For iRow = 1 to dw_order_detail.RowCount()

	nOrigQty	= dw_order_detail.GetItemNumber(iRow, "quantity")

	If iRow = 1 then
		nOurCum 	= f_get_value(nOurCum)
	Else
		nOurCum	= nTheCum
	End If

	nTheCum = f_get_value(dw_order_detail.GetItemNumber(iRow, "the_cum"))
	nNetQty = nTheCum - nOurCum

	If nNetQty <= 0 then				//Send to DelArray
		nTheCum							= nOurCum
		iDelArray[iDelCount + 1]	= iRow
		iDelCount						= iDelCount + 1
	Else

		nStdQty		= nNetQty * nRatio
		dw_order_detail.SetItem(iRow, "std_qty", nStdQty)

	End If

	If nNetQty <> nOrigQty then
		iRowId			= dw_order_detail.GetItemNumber(iRow, "row_id")
		Delete From master_prod_sched  
		Where ( origin = :iOrder ) AND
		  		( source = :iRowId );
		dw_order_detail.SetItem(iRow, "flag", 1)
	End If

	dw_order_detail.SetItem(iRow, "quantity", nNetQty)
	dw_order_detail.SetItem(iRow, "our_cum",	 nOurCum)
	dw_order_detail.SetItem(iRow, "the_cum",  nTheCum)
	
Next 

For iRow = iDelCount to 1 Step -1
	iReleaseRow	= iDelArray[iRow]
	iRowId		= dw_order_detail.GetItemNumber(iReleaseRow, "row_id")

	Delete From master_prod_sched  
	Where ( origin = :iOrder ) And
	  		( source = :iRowId )   ;

	dw_order_detail.DeleteRow(iReleaseRow)
Next	

//For iRow	= 1 to dw_order_detail.RowCount()
//	dw_order_detail.SetItem(iRow, "sequence", iRow)
//Next

If bNoCommit then
	If dw_order_detail.Update() > 0 then
		bSuccess	= TRUE
	Else
		bSuccess	= FALSE
	End If
Else
	If dw_order_detail.Update() > 0 then
		Commit;
	Else
		RollBack;
	End If
End If

bFinish		= TRUE
bNoCommit	= FALSE




end subroutine

public subroutine wf_calculate_dropship ();Date 		dLastDate

Decimal	nTotalPOQty
Decimal	nQty
Decimal	nQtyCommited

Integer  iRow
Integer	iCount

Long		iRowId

str_oe_detail	iRowIdArray[]

String	szUM

Declare curOEDetail Cursor For  
 Select order_detail.row_id,
		  order_detail.unit
   From order_detail  
  Where ( order_detail.order_no 		= :iSalesOrder ) And
        ( order_detail.part_number 	= :szPart ) And  
        ( order_detail.ship_type 	= 'D' )   ;
Open curOEDetail;

Fetch curOEDetail into :iRowId, :szUM;
iCount	= 0

Do while SQLCA.SQLCode = 0 
	iCount ++
	iRowIdArray[iCount].iRowId	= iRowId
	iRowIdArray[iCount].szUM	= szUM

	Fetch curOEDetail into :iRowId, :szUM;
Loop		

Close curOEDetail;

Do while iCount > 0 
	iRowId	= iRowIdArray[iCount].iRowId
	szUM		= f_get_string_value(iRowIdArray[iCount].szUM)

	Select sum(po_detail.standard_qty )  
  	Into :nTotalPOQty  
  	From po_detail  
 	Where ( po_detail.sales_order = :iSalesOrder ) AND  
       	( po_detail.dropship_oe_row_id = :iRowId )   ;

	nTotalPOQty	= f_convert_units(szUM, "", szPart, f_get_value(nTotalPOQty))
	
	UPDATE order_detail  
   	SET committed_qty = nTotalPOQty  
 	WHERE ( order_no = :iSalesOrder ) AND  
       ( row_id = :iRowId )   ;

	iCount --
	
Loop

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

							
					


end subroutine

public function string wf_strip_off_suffix (string szpart, long isuffix);Long iPos

iPos	= Pos(szPart, "-" + String(iSuffix))
If iPos > 1 then
	szPart	= Left(szPart, iPos - 1)
End If

Return szPart
end function

public function boolean wf_set_bol_status (string szstatus);Long 		iBOL			//To keep the true BOL number
String 	szPrint		//Whether BOL has been printed

SELECT shipper.bill_of_lading_number  	//Grab BOL#
  INTO :iBOL  
  FROM shipper  
 WHERE shipper.id = :iShipper   ;

If IsNull ( iBOL, 0 ) > 0 then
  UPDATE bill_of_lading  
     SET status = :szStatus  
   WHERE bol_number = :iBOL   ;

	If SQLCA.SQLCode = -1 then
		Return FALSE
	Else
		Return TRUE
	End If
End If

Return TRUE
end function

public function boolean wf_set_status ();gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6a" )

gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6b" )
w_list_of_active_shippers.bStaged	= FALSE
w_list_of_active_shippers.bPrinted  = FALSE

gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6c" )

UPDATE shipper  
   SET status 				= 'C',   
       staged_objs 		= :w_list_of_active_shippers.iBoxes
 WHERE id = :iShipper   ;

gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6d" )
If SQLCA.SQLCode = -1 then
	MessageBox ( "Error", SQLCA.SQLErrText )
	Return FALSE
Else
	b_Retrieve = TRUE
	Return TRUE
End If

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

public subroutine wf_print_label (string szpart, long iserial, long iorder, string szLabel);Window wLabel

stParm.value1	= String(iSerial)
stParm.value2	= szCustomerPart
stParm.value3	= wf_get_supplier_code(szDestination)
stParm.value4	= szLineFeedCode

dw_object_info.Retrieve(iSerial)
If dw_object_info.RowCount() > 0 then
	stParm.value5	= dw_object_info.GetItemString(1, "field1")
End If

stParm.value6	= szDockCode	
stParm.value7	= szDestination
//stParm.value8 :Reserved for SalesOrder#
stParm.value9	= szCustomerPO
stParm.value10	= szZoneCode
stParm.Value12 = szLabel

w_shipping_dock.SetMicroHelp("Printing label for serial# " + String(iSerial))

f_print_label ( stParm ) 


end subroutine

public subroutine wf_get_vendor ();  SELECT	vendor
    INTO	:is_Vendor
    FROM	destination
   WHERE	destination = :szDestination  ;
end subroutine

public function string wf_stage_using_wgt_qty ();String 	s_Unit, &
		 	s_UM, &
		 	s_StageFlag, &
		 	s_Part, &
		 	s_PartOriginal, &
			s_PackageType, &
			s_OrderType

Long     l_SalesOrder, &
			l_Counter

Boolean bStaged		 //Whether the shipper is staged
Decimal nQtyStaged	 //The qty staged
Decimal dec_WgtStaged //The Weight of staged objects
Decimal nQtyRequired  //The qty required

Long    iRow			 //Current row number
Long    l_Suffix

l_Counter = dw_shipper_detail.RowCount ( )   

bStaged = TRUE

FOR iRow = 1 TO l_Counter

	s_Part 		  	= f_get_string_value ( dw_shipper_detail.GetItemString ( iRow, "part" ) )
	l_Suffix      	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_suffix" ) )
	s_PartOriginal	= wf_strip_off_suffix ( s_Part, l_Suffix )
	s_Unit        	= f_get_string_value ( dw_shipper_detail.GetItemString ( iRow, "shipper_detail_alternative_unit" ) )
	dec_WgtStaged 	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_gross_weight" ) )
	nQtyStaged	  	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_qty_required" ) )
	nQtyRequired  	= f_get_value ( dw_shipper_detail.GetItemNumber ( iRow, "shipper_detail_alternative_qty" ) )

	SELECT order_no  
	  INTO :l_SalesOrder  
	  FROM shipper_detail  
	 WHERE ( shipper = :iShipper ) AND  
	       ( part = :s_Part )   ;

	s_OrderType		= f_get_order_info ( l_SalesOrder, "ORDER TYPE" )

	If s_OrderType = "B" Then
		s_PackageType = f_get_order_info ( l_SalesOrder, "PACKAGE TYPE" )
	Else
		If l_Suffix <> 0 AND NOT IsNull ( l_Suffix ) Then
  			SELECT 	packaging_type
    		INTO 		:s_PackageType  
    		FROM 		order_detail  
   		WHERE 	( order_no = :l_SalesOrder ) AND  
 	      	  		( part_number = :s_PartOriginal ) AND
						( suffix = :l_Suffix )  ;
		Else
	  		SELECT 	packaging_type
	    	INTO 		:s_PackageType  
	    	FROM 		order_detail  
	   	WHERE 	( order_no = :l_SalesOrder ) AND  
	 	        		( part_number = :s_PartOriginal ) ;
		End If
	End if
	
		SELECT stage_using_weight
	     INTO :s_StageFlag
	     FROM part_packaging
	    WHERE part = :s_PartOriginal	and
		   	 code = :s_PackageType ;
Next

Return s_StageFlag

end function

public subroutine wf_print_invoice (integer iinvoice, long ishipper);stPrintParm.Form_type			= "Invoice"
stPrintParm.Document_number	= iInvoice
stPrintParm.Calling_window		= w_shipping_dock

OpenSheetWithParm(w_form_print_preview, stPrintParm, gnv_App.of_GetFrame() , 4, Original!)
w_form_print_preview.ib_missingdata = True


end subroutine

public function boolean wf_get_dest_type (long ishipper);String s_type

SELECT	destination_shipping.will_call_customer,
	isnull(destination_shipping.ship_day,'Any_Day')
INTO	:s_type,
	:is_shipday
FROM	destination_shipping, shipper  
WHERE	destination_shipping.destination = shipper.destination AND
	shipper.id = :ishipper;

Return ( s_type = 'Y' )
end function

public subroutine wf_reset_printed_flag (string sflag, long ishipper);UPDATE shipper
SET printed = 'Y'
WHERE id = ishipper ;	


end subroutine

public function boolean wf_update_onhand_old ();//	Update Onhand
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
			MessageBox ( "Error", "Part_Online table entry expected for " + s_Part + " but not found!" )

			   Close	shipdetail  ;

			Return FALSE
		END IF
		l_OnHand -= l_StdQtyPacked
		IF l_OnHand < 0 THEN
			MessageBox ( "Error", "Part_Online table shows less of " + s_Part + " than expected!" )

			   Close	shipdetail  ;

			Return FALSE
		END IF

		  UPDATE	part_online
		     SET	on_hand = :l_OnHand
		   WHERE	part = :s_Part  ;

		IF SQLCA.SQLCode <> 0 THEN
			MessageBox ( "Error", "Unable to update Part_Online table for part " + s_Part + "!" )

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

public function boolean wf_update_onhand ();STRING	s_Part
LONG		l_OnHand, &
			l_StdQtyPacked, &
			l_row

dw_onhand.Retrieve(ishipper)

IF dw_onhand.rowcount() > 0 THEN

	For l_row = 1 to dw_onhand.rowcount() 

       s_part				= dw_onhand.GetItemstring(l_row, "shipper_detail_part_original")


		SELECT	Sum ( std_quantity )
		  INTO	:l_onhand
		  FROM	object
		 WHERE part = :s_part AND
				status = 'A';

	      dw_onhand.SetItem (l_row , "part_online_on_hand", l_onHand )
	next

End if

If  dw_onhand.update() = 1 then
	return TRUE
else
	Return FALSE
end if

end function

public function string wf_get_kanban_number (integer ishipper);STRING s_kanban, &
		 s_status

Boolean bs_kanban = false

Long l_row

l_row =  dw_shipper_detail.GetSelectedRow(0)

If l_row > 0 Then

	iSalesOrder	= dw_shipper_detail.GetItemNumber(l_row, "shipper_detail_order_no")
End If

DECLARE kanban_cursor CURSOR FOR  
SELECT kanban_number, status
FROM kanban  
WHERE status = 'A' and order_no = :isalesorder 
ORDER BY  kanban_number ASC ;

Open kanban_cursor ;

FETCH kanban_cursor INTO  :s_kanban, :s_status ;	

If s_kanban > '' then
	  bs_kanban = True
End If

close kanban_cursor ;

If bs_kanban then

	update kanban
	set status = 'U'
	where kanban_number= :s_kanban ;
	
	commit ;

End If

Return s_kanban ;


			 
end function

public subroutine wf_update_kanban (long iserial);STRING ls_status, ls_kanban

SELECT kanban_number
INTO   :ls_kanban
FROM   object
WHERE  serial = :iserial ;

SELECT status
INTO   :ls_status
FROM   kanban
WHERE  kanban_number = :ls_kanban ;

IF ls_status > '' and ls_status <> 'A' THEN

	UPDATE kanban
	SET    status = 'A'
	WHERE  kanban_number = :ls_kanban ;

	If sqlca.sqlcode = 0 then
		commit ;
	End If

End if
end subroutine

public function boolean wf_printed_kanban (long ishipper);Long ll_Serial
String ls_kanban 



return true
end function

public subroutine create_pallet (long ipalletserial, string a_s_package_type);DECIMAL	ldec_weight

dw_pallet_info.Visible = TRUE
dw_view_boxes_on_pallet.Visible = TRUE
st_pallet.visible = TRUE
p_1.visible       = TRUE

dw_pallet_info.Reset()
dw_pallet_info.Title = "Build Pallet " + String(iPalletSerial)
dw_pallet_info.InsertRow ( 1 )
dw_pallet_info.SetItem ( 1, "serial", iPalletSerial )
dw_pallet_info.SetItem ( 1, "total_objects", 0 )
dw_pallet_info.SetItem ( 1, "net_weight", 0 )
dw_pallet_info.SetItem ( 1, "tare_weight", 0 )
dw_pallet_info.SetItem ( 1, "gross_weight", 0 )
dw_view_boxes_on_pallet.Retrieve ( iPalletSerial )

SELECT	package_materials.weight
  INTO 		:ldec_weight
  FROM 		package_materials
 WHERE 	package_materials.code = :a_s_package_type  ;

dw_object_info.Reset ( )
dw_object_info.InsertRow ( 1 )

dw_object_info.SetItem ( 1, "serial", iPalletSerial )	//Create super obj
dw_object_info.SetItem ( 1, "type",   "S" )				//Set "SUPER OBJ"
dw_object_info.SetItem ( 1, "part",   "PALLET" )   	
dw_object_info.SetItem ( 1, "last_date", Today (  ) )
dw_object_info.SetItem ( 1, "operator", "NONE" )
dw_object_info.SetItem ( 1, "location", "SHIPDOCK" )
dw_object_info.SetItem ( 1, "status", "A" )	
dw_object_info.SetItem ( 1, "shipper", iShipper )
dw_object_info.SetItem ( 1, "show_on_shipper", "Y" )
dw_object_info.SetItem ( 1, "kanban_number", wf_get_kanban_number ( ishipper ) )
dw_object_info.SetItem ( 1, "package_type", a_s_package_type  )
dw_object_info.SetItem ( 1, "tare_weight", ldec_weight  )

IF dw_object_info.Update (  ) > 0 THEN
	IF f_create_audit_trail ( iPalletSerial, "P" , '', '', '', '', '', '', '', '', "", "No Commit" ) THEN
		Commit;
		dw_pallets.Retrieve ( iShipper )
		wf_update_pallet_numbers ( "+", 1 )	//Update # of pallets in shipper
	ELSE
		Rollback;
		MessageBox  (  "Error", "Unable to create pallet!", StopSign!  )
	END IF
ELSE
	Rollback;
	MessageBox  (  "Error", "Unable to create pallet!", StopSign!  )
END IF

bPalletVisible = TRUE
end subroutine

public function long wf_get_current_row (string as_part);Long	l_row, &
	l_prev_row, &
	l_Count, &
	l_suffix
String	ls_part
Dec	n_required
Dec	n_packed
Boolean b_found = false
For l_count = 1 to dw_shipper_Detail.Rowcount()
	l_suffix= dw_shipper_Detail.Getitemnumber( l_count, "shipper_detail_suffix" )
	ls_part	= wf_strip_off_suffix ( dw_shipper_Detail.GetitemString( l_count, "part" ), l_suffix )
	If as_part = ls_part  then
		n_required = dw_shipper_Detail.Getitemnumber( l_count, "shipper_detail_qty_required" )	
		n_packed   = dw_shipper_Detail.Getitemnumber( l_count, "shipper_detail_alternative_qty" )
		l_prev_row = l_count
		If n_required > n_packed then
			idetailrow = l_count
			b_found = true			
			return l_count    
		End If
		If l_Count = dw_shipper_Detail.Rowcount() then
			idetailrow = l_prev_row
			return l_prev_row
		End If
	End If
Next
If b_found = false Then
	return -1
End If

end function

public function boolean wf_validate_pallet_against_shipper (long al_serial, long al_shipper);long		ll_Shipper
long		ll_Count
long		ll_Row
long		ll_suffix

integer	li_count=0

string	ls_part


IF dw_boxes_on_pallet.Retrieve (al_Serial) > 0 THEN
	IF dw_shipper_detail.Rowcount() > 0 THEN
		For ll_Count = 1 to dw_boxes_on_pallet.RowCount ( )
			ls_part = dw_boxes_on_pallet.GetItemString ( ll_count, "part" )
			ll_suffix = dw_boxes_on_pallet.GetItemNumber ( ll_count, "suffix" )
			if ll_suffix > 0 then
				ls_part += "-" + String ( ll_suffix )
			end if
			IF row_of_part_in_detail ( ls_part ) = 0 THEN
					MessageBox ( monsys.msg_title, "This pallet has parts on it " + &
						"which are not part of the requirements for shipper: " + &
						String ( al_Shipper ) + ".", StopSign! )
               li_count = 0
         Else
               li_count++
			END IF
		Next
	END IF
else
	li_count = 1
END IF

Return ( li_count > 0 )
end function

public function integer wf_stage_object (long al_serial);LONG	ll_currentpallet, &
	ll_currentshipper, &
	ll_count, &
	ll_row
BOOLEAN	bRightPackage
STRING	ls_objectpackage, &
	ls_objectpart
DECIMAL	ldec_tareweight

IF box_exist ( al_serial ) THEN
	/////////////////////////////////////////////////////
	// check to see if destination allows for overstaging
	//		if it doesn't make sure object won't go over
	//			if it does, get out.
	/////////////////////////////////////////////////////

	ls_objectpart	= dw_object_info.GetItemString ( 1, "part" )

	// Reset display for overstage when part number changes
	if ls_objectpart <> is_lastpart then
		ib_displaymessage = true
		is_lastpart = ls_objectpart
	end if
	
	if dw_shipper_header.GetItemString ( 1, "allow_overstage" ) = 'N' then
		if wf_checkforoverstage ( al_serial ) then
			MessageBox ( monsys.msg_title, "Overstaging is not allowed for this destination!", StopSign! )
			return -1
		end if
	else
		if wf_checkforoverstage ( al_serial ) and ib_displaymessage then
			ib_displaymessage = false
			MessageBox ( monsys.msg_title, "You are overstaging objects against part: "+ls_objectpart, Information!  )
		end if
	end if
	/////////////////////////////////////////////////////

	iSerial = al_serial
	// removed "AND ( NOT bneedsuffix )" from below if
	IF IsNull ( iSuffix ) THEN
		idetailrow = wf_get_current_row ( ls_objectpart )
		IF idetailrow > 0 THEN
			isuffix = dw_shipper_detail.GetItemNumber ( idetailRow, "shipper_detail_suffix" )
		END IF
	END IF

	IF dw_object_info.GetItemString  ( 1, "type" ) = "S" THEN

		bScanPallet = TRUE
		IF NOT wf_valid_parts_on_pallet ( al_serial ) THEN

			iSuffix			= dw_object_info.GetItemNumber ( 1, "suffix" )

			// removed "AND ( NOT bneedsuffix )" from below if
			IF IsNull ( iSuffix ) THEN   // for 'consider suffix option'
				IF idetailRow > 0 THEN
					 iSuffix = dw_shipper_Detail.GetItemNumber ( iDetailRow, "shipper_Detail_suffix" )
				END IF
			END IF

			IF iSuffix > 0 THEN
				ls_objectpart	= ls_objectpart + "-" + String ( iSuffix )
			END IF

			f_beep ( 3 )
			MessageBox ( monsys.msg_title, "There are parts on this pallet not scheduled for this shipper!", StopSign!)
			Return -1
		END IF

	ELSE

		iSuffix			= dw_object_info.GetItemNumber ( 1, "suffix" )

		// removed "AND ( NOT bneedsuffix )" from below if
		IF IsNull ( iSuffix ) THEN   // for 'consider suffix option'
			 IF iDetailRow > 0 THEN
				 iSuffix = dw_shipper_Detail.GetItemNumber ( iDetailRow, "shipper_Detail_suffix" )
			 END IF
		END IF

		IF iSuffix > 0 THEN
			ls_objectpart	= ls_objectpart + "-" + String ( iSuffix )
		END IF

		IF row_of_part_in_detail ( ls_objectpart ) = 0 THEN
			f_beep ( 3 )
			MessageBox ( monsys.msg_title, "Part:" + ls_objectpart + " is not scheduled for this shipper!", StopSign!)
			Return -1
		END IF		

		IF dw_object_info.GetItemString ( 1, "status" ) <> "A" THEN
			f_beep ( 3 )
			MessageBox ( monsys.msg_title, "The object is not QC approved!", StopSign!)
			Return -1
		END IF			
	
		bScanPallet = FALSE

	END IF

	IF sle_document.text = "Printed" THEN
		IF MessageBox ( monsys.msg_title, "This shipper is already staged and the packing list printed.  Do you want to continue staging?", StopSign!, OkCancel! ) = 2 THEN
			Return -1
		ELSE
			w_list_of_active_shippers.wf_set_print_status ( "N" )
			sle_document.text = "Unprinted"
		END IF
	END IF

	check_shipper_status ( )	
	
	bRightPackage = TRUE
	iSuffix	= dw_object_info.GetItemNumber ( 1, "suffix" )

	IF NOT bScanPallet THEN					//Only check the box NOT pallet for pack mat
		ls_objectpackage = dw_object_info.GetItemString(1, "package_type")
		
		IF wf_need_to_check_object_package ( ) THEN	
			bRightPackage = wf_check_object_package( dw_object_info.GetItemString(1, "part"), dw_object_info.GetItemString ( 1, "package_type" ) )
		END IF

		ls_objectpackage = wf_get_string_value ( ls_objectpackage )
		szOrderPackage = wf_get_string_value ( szOrderPackage )

		IF ( NOT bRightPackage ) THEN
			bRightPackage	= ( MessageBox ( monsys.msg_title, "Incompatible Package Type~rRequired Type:" + szOrderPackage + "~rCurrent Type:"+ ls_objectpackage +"~r~rOk to stage it", question!, YesNo! ) = 1 )
		END IF
	END IF

	IF bRightPackage THEN

		ll_currentpallet = dw_object_info.GetItemNumber ( 1, "parent_serial" )
		ll_currentshipper = dw_object_info.GetItemNumber ( 1, "shipper" )
				
		IF NOT IsNull ( ll_currentshipper ) AND ll_currentshipper <> 0 THEN
			Beep ( 5 )
			MessageBox ( monsys.msg_title, "Object already staged to shipper# " + String ( ll_currentshipper ), StopSign! )
		ELSE
			IF ( NOT bScanPallet ) THEN	//IF only scan individual boxes
				f_update_shipper_container ( iShipper, ls_objectpackage, "+" )
			END IF
			IF bPalletVisible AND ( NOT bScanPallet ) THEN  //Stage box to pallet

				iPalletSerial = dw_pallet_info.GetItemNumber ( 1, "serial" )
				nPalletTare = Dec ( sle_orig_pallet_tare.text )

				dw_object_info.SetItem ( 1, "parent_serial", iPalletSerial )
				dw_object_info.SetItem ( 1, "shipper", iShipper )
				dw_object_info.SetItem ( 1, "destination", szdestination ) 
				// removed "AND ( NOT bneedsuffix )" from below if
				IF IsNull(iSuffix) THEN   // for 'consider suffix option'
					 idetailrow = wf_get_current_row ( ls_objectpart )				
					 if idetailrow > 0 then 
					 	iSuffix = dw_shipper_Detail.GetItemNumber ( iDetailRow, "shipper_Detail_suffix" )
					 	dw_object_info.Setitem ( 1, "suffix", isuffix )
						 
					 end if 	
				END IF
			ELSE
				dw_object_info.SetItem(1, "shipper", iShipper)
				dw_object_info.SetItem(1, "show_on_shipper", "Y")
				dw_object_info.SetItem ( 1, "destination", szdestination ) 
				// removed "AND ( NOT bneedsuffix )" from below if
				IF IsNull(iSuffix) THEN   // for 'consider suffix option'
					idetailrow = wf_get_current_row ( ls_objectpart )				
					IF idetailrow > 0 THEN
						 iSuffix = dw_shipper_Detail.GetItemNumber ( iDetailRow, "shipper_Detail_suffix" )
						 dw_object_info.setitem( 1, "suffix", isuffix )
					END IF
				END IF

				IF bScanPallet THEN					//IF staging a pallet now
					wf_update_pallet_numbers ( "+", 1 )		//Update # of pallets in shipper
					wf_assign_shipper_to_boxes ( al_serial )	//Assign shipper # to
																	//all boxes on pallet
					dw_boxes_on_pallet.Retrieve ( al_serial )

					FOR ll_count = 1 TO dw_boxes_on_pallet.RowCount ( )
						szPart = dw_boxes_on_pallet.GetItemString ( ll_count, "part" )
						nQty = f_get_value(dw_boxes_on_pallet.GetItemNumber ( ll_count, "std_quantity" ) )
						nWeight	= f_get_value(dw_boxes_on_pallet.GetItemNumber ( ll_count, "weight" ) )
						ls_objectpackage = dw_boxes_on_pallet.GetItemString ( ll_count, "package_type" )
						ldec_tareweight = f_get_value(dw_boxes_on_pallet.GetItemNumber ( ll_count, "tare_weight" ) ) 
						f_update_shipper_container ( iShipper, ls_objectpackage, "+" )
						iSuffix	= dw_boxes_on_pallet.GetItemNumber ( ll_count, "suffix" )

						// removed "AND ( NOT bneedsuffix )" from below if
						IF IsNull(iSuffix) THEN   // for 'consider suffix option'
							 IF idetailrow > 0 THEN
								 iSuffix = dw_shipper_Detail.GetItemNumber ( iDetailRow, "shipper_Detail_suffix" )
							 END IF
						END IF

						IF iSuffix > 0 THEN
							szPart	= szPart + "-" + String ( iSuffix )
						END IF									

						Change_qty_for_part ( szPart, nQty, "+" )
						Change_weight_for_part ( szPart, nWeight, ldec_tareweight, "+" )

//						ll_row = dw_objects.Find ( "serial = " + String ( dw_boxes_on_pallet.GetItemNumber ( ll_count, "serial" ) ), 1, dw_objects.RowCount ( ) )
//						IF ll_row > 0 THEN
//							IF dw_objects.GetItemNumber ( ll_row, "serial" ) = dw_boxes_on_pallet.GetItemNumber ( ll_count, "serial" ) THEN
//								dw_objects.object.status [ ll_row ] = dw_object_info.object.status [ 1 ]
//								dw_objects.object.quantity [ ll_row ] = dw_object_info.object.quantity [ 1 ]
//								dw_objects.object.unit_measure [ ll_row ] = dw_object_info.object.unit_measure [ 1 ]
//								dw_objects.object.std_quantity [ ll_row ] = dw_object_info.object.std_quantity [ 1 ]
//								dw_objects.object.parent_serial [ ll_row ] = dw_object_info.object.parent_serial [ 1 ]
//								dw_objects.object.shipper [ ll_row ] = dw_object_info.object.shipper [ 1 ]
//								dw_objects.object.location [ ll_row ] = dw_object_info.object.location [ 1 ]
//								dw_objects.object.origin [ ll_row ] = dw_object_info.object.origin [ 1 ]
//							END IF
//						END IF	
					Next

					IF dw_shipper_detail.Update ( ) > 0 THEN
						Commit;
					ELSE
						Rollback;
					END IF 										
				END IF
			END IF

			IF dw_object_info.Update ( ) > 0 THEN
				
				if sqlca.of_setbolprintedstatus ( iShipper, 'N' ) = 0 then
					Commit;

					szPart = dw_object_info.GetItemString ( 1, "part" )
					nQty = dw_object_info.GetItemNumber ( 1, "std_quantity" )
					nWeight	= f_get_value ( dw_object_info.GetItemNumber ( 1, "weight" ) )
					ldec_tareweight = dw_object_info.GetItemNumber ( 1, "tare_weight" )
					iSuffix	= dw_object_info.GetItemNumber ( 1, "suffix" )
	
	//				ll_row = dw_objects.Find ( "serial = " + String ( al_serial ), 1, dw_objects.RowCount ( ) )
	//				IF ll_row > 0 then
	//					if dw_objects.GetItemNumber ( ll_row, "serial" ) = al_serial THEN
	//						dw_objects.object.status [ ll_row ] = dw_object_info.object.status [ 1 ]
	//						dw_objects.object.quantity [ ll_row ] = dw_object_info.object.quantity [ 1 ]
	//						dw_objects.object.unit_measure [ ll_row ] = dw_object_info.object.unit_measure [ 1 ]
	//						dw_objects.object.parent_serial [ ll_row ] = dw_object_info.object.parent_serial [ 1 ]
	//						dw_objects.object.parent_serial [ ll_row ] = dw_object_info.object.parent_serial [ 1 ]
	//						dw_objects.object.shipper [ ll_row ] = dw_object_info.object.shipper [ 1 ]
	//						dw_objects.object.location [ ll_row ] = dw_object_info.object.location [ 1 ]
	//						dw_objects.object.origin [ ll_row ] = dw_object_info.object.origin [ 1 ]
	//					end if
	//				END IF
	
					IF iSuffix > 0 THEN
						szPart	= szPart + "-" + String ( iSuffix )
					END IF
	
					change_qty_for_part ( szPart, nQty, "+" )
	
					IF dw_shipper_detail.Update ( ) > 0 THEN
						Commit;
					ELSE
						Rollback;
					END IF
	
					Beep ( 1 )
					IF bPalletVisible AND ( NOT bScanPallet ) THEN		//Retrieve boxes detail on pallet
						dw_view_boxes_on_pallet.Retrieve ( iPalletSerial )
						dw_pallet_info.SetItem ( 1, "total_objects", dw_view_boxes_on_pallet.RowCount ( ) )
					END IF
	
					dw_pallets.Retrieve ( iShipper )
				else
					Rollback;
					MessageBox ( monsys.msg_title, "Unable to update bol printed status!", StopSign! )
				end if
			ELSE
				Rollback;
			END IF
		END IF		
	END IF
	bScanPallet = FALSE
	wf_calc_boxes_AND_weight ( )
ELSE
	f_beep ( 3 )
	MessageBox ( monsys.msg_title, "Serial# :" + String(al_serial) + " not Found", StopSign!)
	ll_row = dw_object_info.Find ( "serial = " + String ( al_serial ), 1, dw_object_info.RowCount ( ) )
	IF ll_row > 0 then
		if dw_object_info.GetItemNumber ( ll_row, "serial" ) = al_serial THEN &
			dw_object_info.DeleteRow ( ll_row )
	END IF
	Return -1
END IF

dw_objects.Retrieve ( iShipper )

Return 0
end function

public subroutine wf_print_pallet_label (long a_l_serial, long a_l_shipper);String szPalletLabel

SetNull(szPalletLabel)

SELECT object_name  
  INTO :szPalletLabel  
  FROM report_library  
 WHERE name = 'PALLET' ;

stParm.Value1  = String ( a_l_Serial )
StParm.Value10 = String ( a_l_Shipper )

If IsNull(szPalletLabel) then
	stparm.value12 = 'NOLABEL'
Else
	stparm.value12 = 'PALLET'
End If

f_print_label ( stparm )
end subroutine

public subroutine add_qty_to_part (string a_s_part, decimal a_n_qty);Long    l_l_Row			//to keep the current row
Decimal l_n_CurrentQty	//to keep the current qty
Boolean l_b_Done			//to exit the loop
String  l_s_StageFlag

l_l_Row = 1   
l_b_Done = FALSE

Do while (Not l_b_Done) and (l_l_Row <= dw_shipper_detail.RowCount())

	If a_s_part = dw_shipper_detail.GetItemString(l_l_Row, "part") then
		l_n_CurrentQty = dw_shipper_detail.GetItemNumber(l_l_Row, "shipper_detail_qty_packed")
		dw_shipper_detail.SetItem(l_l_Row, "qty_packed", l_n_CurrentQty + a_n_Qty)
		l_l_Row = dw_shipper_detail.RowCount()
		If dw_shipper_detail.Update() > 0 then
			Commit;
		Else
			MessageBox(monsys.msg_title, "Can't save data in [W_SHIPPING_DOCK(add_qty_to_part)]")
			Rollback;
		End If
	End If

	l_l_Row = l_l_Row + 1

Loop 

dw_shipper_detail.Retrieve ( iShipper )

end subroutine

public function boolean wf_valid_part_for_stage (string a_s_part, long icurrentshipper, long icurrentpallet, string szobjectstatus);Boolean bValid	= TRUE

If Row_of_Part_in_Detail(a_s_Part) = 0 then
	f_beep(3)
	MessageBox(monsys.msg_title, "Part " + a_s_Part + "(Suffix:" + &
					String(iSuffix) + ") is not scheduled on current shipper", StopSign!)
	bValid	=  FALSE
Else 
	If Not (IsNull(iCurrentShipper)) AND iCurrentShipper <> 0 then
		f_beep(3)
		MessageBox(monsys.msg_title, "The object is currently staged on shipper " + String(iCurrentShipper) + " already", StopSign!)
		bValid	=  FALSE
	Else
		If Not (IsNull(iCurrentPallet)) then
			f_beep(3)
			If MessageBox(monsys.msg_title, "The object is currently staged on pallet " + String(iCurrentPallet) + " already, " + &
							  "Do you want to continue with your request", Question!, OkCancel!) = 2 then
				bValid = FALSE
			End If
		End If

		If bValid then
			If szObjectStatus <> "A" then
				f_beep(3)
				MessageBox(monsys.msg_title, "The object is not QC approved", StopSign!)
				bValid	= FALSE
			End If			
		End If
	End If
End If

Return bValid
end function

public function boolean ship_out_pallet (long al_serial);Long 		iRow
Long		iTotalBoxes

Boolean 	bOk	 = TRUE

dw_view_boxes_on_pallet.Retrieve(al_serial)

iRow 			= 1
iTotalBoxes	= dw_view_boxes_on_pallet.RowCount()

Do while bOk AND (iRow <= iTotalBoxes)
	is_MLE_Line3 = 'Box' + String ( iRow ) + ' of ' + String ( iTotalBoxes ) + ' on Pallet.'
	mle_scan_out.Text = is_MLE_Line1 + '~r~n' + is_MLE_Line2 + '~r~n' + is_MLE_Line3
	bOk = ship_out_box(dw_view_boxes_on_pallet.GetItemNumber(iRow, "serial"))
	iRow ++
Loop

is_MLE_Line3 = ''
mle_scan_out.Text = is_MLE_Line1 + '~r~n' + is_MLE_Line2

If bOk then 
	bOk = f_create_audit_trail(al_serial, szShipperType , String(iShipper), szDestination, szCustomer, is_operator, '', '', '', '', "", "No Commit")
	if bOk then
	//Delete the pallet object
		DELETE FROM object  		
		WHERE serial = :al_serial   ;

		If SQLCA.SQLCode = -1 then
			bOk	= FALSE;
		End If
	end if
End If	

Return bOk



end function

public function boolean ship_out_box (long al_serial);STRING 	ls_part								//Part number

DECIMAL	ldec_qty, &
	ldec_price, &
	ldec_cost

BOOLEAN	lb_ok	= TRUE

dw_object_info.Retrieve ( al_serial )

IF dw_object_info.RowCount ( ) > 0 THEN
	is_MLE_Line1 = 'Processing Serial ' + String ( dw_object_info.GetItemNumber ( 1, 'serial' ) ) + '...'
	mle_scan_out.text = is_MLE_Line1 + '~r~n' + is_MLE_Line2 + '~r~n' + is_MLE_Line3
	ls_part = dw_object_info.GetItemString ( 1, "part" )
	ldec_qty = dw_object_info.GetItemNumber ( 1, "std_quantity" )
	iSuffix = dw_object_info.GetItemNumber ( 1, "suffix" )
	ldec_price = wf_get_part_price ( ls_part, iSuffix )
	ldec_cost = f_get_value ( dw_object_info.GetItemNumber ( 1, "cost" ) ) * ldec_qty
	
	lb_ok	= wf_update_cost ( ls_part, iSuffix, ldec_cost )

	IF lb_ok THEN
		IF szShipperType = "O" THEN	//Don't delete for outside process
			lb_ok = f_create_audit_trail ( al_serial, szShipperType , String ( iShipper ), szDestination, is_Vendor, is_operator, String(ldec_price), szSalesman, szPartNote, szGroupNo, "", "No Commit" )
			dw_object_info.SetItem ( 1, "location", sle_destination.text )
			dw_object_info.SetItem ( 1, "destination", sle_destination.text )
			dw_object_info.SetItem ( 1, "status", 'P' )
		ELSE
			lb_ok = f_create_audit_trail ( al_serial, szShipperType , String ( iShipper ), szDestination, szCustomer, is_operator, String(ldec_price), szSalesman, szPartNote, szGroupNo, "", "No Commit" )
			dw_object_info.DeleteRow ( 1 )
		END IF
		lb_ok = ( dw_object_info.Update ( ) > 0 )
		IF lb_ok THEN
			FileWrite ( iSerialFileNo, String ( al_serial ) )
		END IF
	END IF
END IF

Return lb_ok



end function

public subroutine updt_order_detail (long al_salesorder, string as_part, decimal adec_qty);Decimal adec_qtyLeft
Decimal nCurrentQty
Decimal adec_qtyAssigned
Decimal adec_qtyShipped

Long iRow
Boolean bDone
Boolean bIsBlankOrder

dw_view_release.Retrieve ( al_salesorder, as_part )

adec_qtyLeft = adec_qty
bDone    = FALSE
iRow     = 1

If dw_view_release.RowCount() > 0 then
	
	Do while (Not bDone)
		
		nCurrentQty  = dw_view_release.GetItemNumber(iRow, "quantity")
		adec_qtyAssigned = Dec(dw_view_release.GetItemString(iRow, "assigned"))
		adec_qtyShipped  = dw_view_release.GetItemNumber(iRow, "shipped")

		If IsNull(nCurrentQty) then
			nCurrentQty = 0
		End If

		If IsNUll(adec_qtyAssigned) then
			adec_qtyAssigned = 0
		End If

		If IsNull(adec_qtyShipped) then
			adec_qtyShipped = 0
		End If

		bIsBlankOrder = IsBlankOrder(al_salesorder)

		If bIsBlankOrder then
			If adec_qtyLeft > nCurrentQty then
				adec_qtyLeft = (adec_qtyLeft - nCurrentQty)
				adec_qtyShipped = nCurrentQty		//Shipped the whole amount
			Else
				adec_qtyShipped = adec_qtyLeft
				adec_qtyLeft    = 0
			End If
		Else
			adec_qtyShipped = adec_qtyShipped + adec_qtyLeft
			adec_qtyLeft    = 0
		End if

		If adec_qtyLeft = 0 then
			bDone = TRUE
		End If

		iRow = iRow + 1

		If iRow > dw_view_release.RowCount() then
			bDone = TRUE
		End If
	Loop

End If

dw_view_release.SetItem(iRow, "shipped", adec_qtyShipped)
dw_view_release.Update ( )
If bIsBlankOrder then
	For iRow = 1 to dw_view_release.RowCount()
		If dw_view_release.GetItemNumber(iRow, "qty_required") <= &
			dw_view_release.GetItemNumber(iRow, "qty_shipped") then
			dw_view_release.DeleteRow(iRow)
		End If
	Next
	dw_view_release.Update ( )
End If
end subroutine

public subroutine updt_inventory (long al_serial);dw_object_info.Retrieve ( al_serial )

IF dw_object_info.RowCount() > 0 THEN
	IF szShipperType <> "O" THEN	//If not a outside process
		dw_object_info.DeleteRow ( 1 )
		dw_object_info.Update ( )
	END IF
END IF
end subroutine

public function integer wf_get_order_release_date (long al_order, string as_part, long al_suffix, ref datetime adt_release_date, ref string as_release_number);int	li_return = 0

dw_order_detail.Retrieve ( al_order )

if as_part > '' then		// normal order
	if isnull ( al_suffix, 0 ) > 0 then
		dw_order_detail.SetFilter ( "part = '" + as_part + "' and suffix = " + string ( al_suffix ) )
	else
		dw_order_detail.SetFilter ( "part = '" + as_part + "'" )
	end if
	dw_order_detail.Filter ( )
end if

if dw_order_detail.RowCount ( ) > 0 then
	adt_release_date = DateTime ( dw_order_detail.GetItemDate ( 1, "due_date" ), Time ( "00:00:00" ) )
	as_release_number = dw_order_detail.GetItemString ( 1, "release_no" )
	li_return = 1
end if

return li_return
end function

public function boolean wf_checkforoverstage (long al_serial);datastore	lds_overstage
long			ll_rowcount
long			ll_row
decimal		ldec_qtyrequired
decimal		ldec_qtypacked
decimal		ldec_objectqty
boolean		lb_return = FALSE

lds_overstage = CREATE datastore
lds_overstage.DataObject = "d_overstage"

lds_overstage.SetTransObject ( sqlca )
if lds_overstage.Retrieve ( al_serial, iShipper ) > 0 then
	ll_rowcount = lds_overstage.RowCount ( )
	
	for ll_row = 1 to ll_rowcount
		ldec_qtyrequired = lds_overstage.GetItemDecimal ( ll_row, "qty_required" )
		ldec_qtypacked = lds_overstage.GetItemDecimal ( ll_row, "alternative_qty" )
		ldec_objectqty = f_convert_units ( '', lds_overstage.GetItemString ( ll_row, "alternative_unit" ), lds_overstage.GetItemString ( ll_row, "part" ), lds_overstage.GetItemDecimal ( ll_row, "total_qty" ) )
		if ldec_objectqty + ldec_qtypacked > ldec_qtyrequired then
			lb_return = TRUE
			exit
		end if
	next
end if

return lb_return
end function

public function boolean update_kanban (long ai_salesorder);string 	s_status
string 	s_kanban

Integer 	li_rtn_code
Long		ll_serial
Long 		l_row

st_generic_structure  st_print_parm  

If dw_kanban.Retrieve(ai_salesorder) > 0 Then

	For l_row = 1 to dw_kanban.rowcount() 

	  s_kanban = dw_kanban.GetItemstring ( l_row, "kanban_kanban_number" )
	  s_status = dw_kanban.GetItemstring ( l_row, "kanban_status" )
     ll_Serial= dw_kanban.GetItemNumber ( l_row, "object_serial" )

	  If s_status = 'U' then 

		  li_rtn_code = MessageBox ( "System Message", "The kanban label for the kanban number  ~r" + &
													s_kanban + "has not been printed.  ~rWould you" + &
												   "like to print it now?", Question!, YesNo! , 2 )


		  If li_rtn_code = 1 then

            st_print_parm.value1 = string(ll_serial)
				f_print_label ( st_print_parm ) 
 				li_rtn_Code = 2
				
		  End If

     End if

	  If s_status = 'X' or  ( s_status = 'U' and li_Rtn_Code = 2 ) then
	
   	  dw_kanban.DeleteRow ( l_row )    
	  
	  End If

	Next

End If

IF dw_kanban.Update()  = 1 THEN
	return true
ELSE
	return false
END IF

end function

public subroutine wf_write_releases ();string	ls_custom10
string	ls_part
dec	ld_sdqty
long	ll_order
datetime ldt_reldate
int	li_cnt=0
dec	ld_odqty
string	ls_release
boolean	lb_inserted=false

select	custom10 
into	:ls_custom10
from	destination 
where	destination = :szdestination and
	customer = :szcustomer;
	
if isnull(ls_custom10,'N') = 'Y' then // if enabled
	// declare a cursor to get all the order #s, part, quantity from shipper detail 
	// for the current shipper. 
	// for each of those shipper, part
	// for each of those orders
	
	delete	multireleases where id = :ishipper;
	
	declare sdcur cursor for 
	select	part_original, qty_packed, order_no, release_date 
	from	shipper_detail
	where	shipper = :ishipper;
	
	open	sdcur;
	
	fetch	sdcur into :ls_part, :ld_sdqty, :ll_order, :ldt_reldate;
	
	do while sqlca.sqlcode = 0
		
		declare odcur cursor for 
		select	quantity, release_no, due_date
		from	order_detail
		where	order_no = :ll_order and 
			part_number = :ls_part
		order by due_date;	
		
		open	odcur;
		
		fetch	odcur into :ld_odqty, :ls_release, :ldt_reldate;
		
		do while sqlca.sqlcode = 0 and ld_sdqty > 0 
			
			if ld_odqty < ld_sdqty then 
				insert	into multireleases
				values	(:ishipper, :ls_part, :ls_release, :ld_odqty, :ldt_reldate) ;
				ld_sdqty = ld_sdqty - ld_odqty
				lb_inserted = true
			else
				insert	into multireleases
				values	(:ishipper, :ls_part, :ls_release, :ld_sdqty, :ldt_reldate) ;
				ld_sdqty = 0 
				lb_inserted = true				
			end if 	

			fetch	odcur into :ld_odqty, :ls_release, :ldt_reldate;
			
		loop
		
		close	odcur;
		
		fetch	sdcur into :ls_part, :ld_sdqty, :ll_order, :ldt_reldate;		
	loop
	
	close	sdcur;
	if lb_inserted then 
		commit;
	else	
		rollback;
	end if 	
end if

end subroutine

public subroutine sendemail (string _message);
mailSession mSes
mailReturnCode mRet
mailMessage mMsg
// Create a mail session
mSes = create mailSession
// Log on to the session
mRet = mSes.mailLogon("useralert","empua5903")
// Populate the mailMessage structure
mMsg.Subject = 'Quantity edit alter'
mMsg.NoteText = _message
mMsg.Recipient[1].name = 'useralert'
// Send the mail
mRet = mSes.mailSend(mMsg)
mSes.mailLogoff()
DESTROY mSes
Return

end subroutine

public function boolean checkpartstatus ();
integer rowShipperDetail
rowShipperDetail = dw_shipper_detail.GetRow()
if	dw_shipper_detail.object.non_ship[rowShipperDetail] = "Y" and &
	isnull(dw_shipper_detail.object.group_no[rowShipperDetail],"Y") = "Y" then
	return true
end if 	
return false

end function

public function boolean checkshipperstatus ();
integer rowShipperDetail
for	rowShipperDetail = 1 to dw_shipper_detail.rowcount()
	if	dw_shipper_detail.object.non_ship[rowShipperDetail] = "Y" and &
		isnull(dw_shipper_detail.object.group_no[rowShipperDetail],"Y") = "Y" then
		return true
	end if 	
next
return false

end function

public subroutine wf_set_detail_qty (string operator, decimal newqtyrequired);
long shipperDetailRow
shipperDetailRow = dw_shipper_detail.GetRow()
if	shipperDetailRow <= 0 then
	return
end if

//	Change quantity required...
n_cst_shippingtrans_qrcl shippingTrans_QRCL
shippingTrans_QRCL = create n_cst_shippingtrans_qrcl
string partCode
partCode = dw_shipper_detail.Object.part[shipperDetailRow]

if	shippingTrans_QRCL.ChangeQtyRequired(operator, iShipper, partCode, newQtyRequired) <> shippingTrans_QRCL.SUCCESS then
	destroy shippingTrans_QRCL
	return
end if

SetNull(szPart)
dw_shipper_detail.Retrieve(iShipper)
If dw_shipper_detail.RowCount() > 0 then
	shipper_is_staged()			//Check whether shipper now is staged or not
End If

If dw_shipper_detail.RowCount() > 0 then
	Check_shipper_status()
Else

	w_list_of_active_shippers.wf_set_status("E")
	MessageBox("Warning", "This is an empty shipper~r therefore system will automatically void it", StopSign!)
	w_shipping_mdi_screen.ChangeMenu(m_list_of_shippers)
	Close(w_shipping_dock)
End If


end subroutine

event open;
//************************************************************************
//* Declaration
//************************************************************************
Integer iRow
String  szMod_string
String  s_StageFlag

//************************************************************************
//* Initialization
//************************************************************************
dw_pallets.SetTransObject(sqlca)
dw_shipper_detail.SetTransObject(sqlca)
dw_view_boxes_on_pallet.SetTransObject(sqlca)

//  Create DataStores
dw_order_detail = CREATE u_ds_dw_list_of_releases_sd
dw_object_info = CREATE u_ds_dw_object_info
dw_boxes_on_pallet = CREATE u_ds_dw_boxes_on_pallet
dw_view_release = CREATE u_ds_dw_view_release_detail
dw_order_header = CREATE u_ds_sd_order_header
dw_shipper_header = CREATE u_ds_dw_shipper_shipping_info
dw_kanban = CREATE u_ds_d_shipping_kanban
dw_onhand = CREATE u_ds_d_update_onhand

iShipper	= Message.DoubleParm

If bPalletvisible then
	Return
End If

if dw_shipper_header.Retrieve ( iShipper ) > 0 then
	if dw_shipper_header.GetItemString ( 1, "customer_service_status_status_type" ) <> 'A' then
//		Post Event ue_unapproved_message ( )
	end if
end if

dw_shipper_detail.Retrieve ( iShipper )
dw_pallets.Retrieve(iShipper)

iSuffix = dw_shipper_detail.GetItemNumber ( 1, "shipper_detail_suffix" )

If dw_shipper_detail.RowCount() > 0 then
	iDetailRow = 1
	sle_1.text = dw_shipper_detail.object.non_ship_operator[1]
	mle_1.text = dw_shipper_detail.object.non_ship_note[1]
End If

dw_pallet_info.Reset()

sle_shipper.text		= String(iShipper)
sle_destination.text	= w_list_of_active_shippers.szDestination
szDestination = sle_destination.text

dw_dest.retrieve(wf_get_customer(sle_destination.text))

If w_list_of_active_shippers.bStaged then
	sle_status.text	= "Staged"
Else
	sle_status.text	= "Not Ready"
End If

If sle_status.text	= "Staged" then
	sle_status.textcolor	= f_get_color_value ( "green" )		//65280
	Timer ( 0 )
Else
	sle_status.textcolor	= sle_shipper.textcolor
End If

If w_list_of_active_shippers.bPrinted then
	sle_document.text	= "Printed"
Else
	sle_document.text	= "Not Printed"
End If

If sle_document.text	= "Printed" then
	sle_document.textcolor	= f_get_color_value ( "green" )		
Else
	sle_document.textcolor	= sle_shipper.textcolor
End If

szShipperType	= wf_shipper_type(iShipper)

If wf_shipper_is_closed(iShipper) then
	MessageBox(monsys.msg_title, "This shipper is already closed by another user!", StopSign!)
	Return
End If

btype  = wf_get_dest_type( iShipper )   //check if this is a will_call_customer

If bType Then
	sle_document.Text = "Printed"
	sle_document.Textcolor = f_get_color_value( "green" )
	w_list_of_active_shippers.bPrinted      =  TRUE

	w_list_of_active_shippers.bStaged		= TRUE
End If

// for 'consider suffix option'

Post Event ue_open ( )
end event

event activate;If Not bManualScanObj then
	if w_shipping_mdi_screen.MenuName <> "m_shipping_dock" then
		w_shipping_mdi_screen.ChangeMenu(m_shipping_dock)
	end if
	If bType Then
		m_shipping_dock.m_operation.m_print.m_packlist.Enabled = False
	Else 
		m_shipping_dock.m_operation.m_print.m_packlist.Enabled = True	
	End If
End If

end event

event close;wf_calc_boxes_and_weight()

//  Destroy DataStores
DESTROY dw_order_detail
DESTROY dw_object_info
DESTROY dw_boxes_on_pallet
DESTROY dw_view_release
DESTROY dw_order_header
DESTROY dw_shipper_header
DESTROY dw_kanban
DESTROY dw_onhand

If b_Retrieve Then w_list_of_active_shippers.dw_shipping_dock.Retrieve ( )
end event

event timer;If iTimerCount	> 600 then	//Every five minute go check the status
	iTimerCount	= 1
	If wf_shipper_is_closed(iShipper) then
		Timer(0)
		MessageBox(monsys.msg_title, "This shipper is already closed by another user!", StopSign!)
		Close(w_shipping_dock)
	End If
Else
	iTimerCount ++
End If

IF dw_pallets.RowCount ( ) > 0 AND sle_status.text <> "Not Ready" THEN
	IF sle_status.textcolor = f_get_color_value ( "darkgray" ) THEN
		sle_status.textcolor = f_get_color_value ( "white" )
	ELSE
		sle_status.textcolor = f_get_color_value ( "darkgray" )
	END IF
END IF
end event

on w_shipping_dock.create
if this.MenuName = "m_shipping_dock" then this.MenuID = create m_shipping_dock
this.sle_1=create sle_1
this.st_14=create st_14
this.st_11=create st_11
this.mle_1=create mle_1
this.dw_destination_scf=create dw_destination_scf
this.dw_dest=create dw_dest
this.em_verifyscan=create em_verifyscan
this.p_1=create p_1
this.sle_document=create sle_document
this.sle_status=create sle_status
this.st_black=create st_black
this.st_blue=create st_blue
this.cb_note_exit=create cb_note_exit
this.st_13=create st_13
this.p_5=create p_5
this.st_12=create st_12
this.p_4=create p_4
this.st_red=create st_red
this.st_10=create st_10
this.p_3=create p_3
this.st_9=create st_9
this.p_2=create p_2
this.st_8=create st_8
this.st_7=create st_7
this.st_5=create st_5
this.st_4=create st_4
this.dw_objects=create dw_objects
this.sle_orig_pallet_tare=create sle_orig_pallet_tare
this.st_pallet=create st_pallet
this.st_6=create st_6
this.sle_destination=create sle_destination
this.sle_shipper=create sle_shipper
this.st_1=create st_1
this.gb_1=create gb_1
this.st_3=create st_3
this.st_2=create st_2
this.dw_verifyscan=create dw_verifyscan
this.uo_dw_scan=create uo_dw_scan
this.dw_pallets=create dw_pallets
this.dw_view_boxes_on_pallet=create dw_view_boxes_on_pallet
this.dw_shipper_detail=create dw_shipper_detail
this.dw_pallet_info=create dw_pallet_info
this.cb_note=create cb_note
this.mle_note=create mle_note
this.cb_scan_out=create cb_scan_out
this.mle_scan_out=create mle_scan_out
this.gb_vscan=create gb_vscan
this.st_vscanserial=create st_vscanserial
this.dw_printscanexception=create dw_printscanexception
this.Control[]={this.sle_1,&
this.st_14,&
this.st_11,&
this.mle_1,&
this.dw_destination_scf,&
this.dw_dest,&
this.em_verifyscan,&
this.p_1,&
this.sle_document,&
this.sle_status,&
this.st_black,&
this.st_blue,&
this.cb_note_exit,&
this.st_13,&
this.p_5,&
this.st_12,&
this.p_4,&
this.st_red,&
this.st_10,&
this.p_3,&
this.st_9,&
this.p_2,&
this.st_8,&
this.st_7,&
this.st_5,&
this.st_4,&
this.dw_objects,&
this.sle_orig_pallet_tare,&
this.st_pallet,&
this.st_6,&
this.sle_destination,&
this.sle_shipper,&
this.st_1,&
this.gb_1,&
this.st_3,&
this.st_2,&
this.dw_verifyscan,&
this.uo_dw_scan,&
this.dw_pallets,&
this.dw_view_boxes_on_pallet,&
this.dw_shipper_detail,&
this.dw_pallet_info,&
this.cb_note,&
this.mle_note,&
this.cb_scan_out,&
this.mle_scan_out,&
this.gb_vscan,&
this.st_vscanserial,&
this.dw_printscanexception}
end on

on w_shipping_dock.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_1)
destroy(this.st_14)
destroy(this.st_11)
destroy(this.mle_1)
destroy(this.dw_destination_scf)
destroy(this.dw_dest)
destroy(this.em_verifyscan)
destroy(this.p_1)
destroy(this.sle_document)
destroy(this.sle_status)
destroy(this.st_black)
destroy(this.st_blue)
destroy(this.cb_note_exit)
destroy(this.st_13)
destroy(this.p_5)
destroy(this.st_12)
destroy(this.p_4)
destroy(this.st_red)
destroy(this.st_10)
destroy(this.p_3)
destroy(this.st_9)
destroy(this.p_2)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_objects)
destroy(this.sle_orig_pallet_tare)
destroy(this.st_pallet)
destroy(this.st_6)
destroy(this.sle_destination)
destroy(this.sle_shipper)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_verifyscan)
destroy(this.uo_dw_scan)
destroy(this.dw_pallets)
destroy(this.dw_view_boxes_on_pallet)
destroy(this.dw_shipper_detail)
destroy(this.dw_pallet_info)
destroy(this.cb_note)
destroy(this.mle_note)
destroy(this.cb_scan_out)
destroy(this.mle_scan_out)
destroy(this.gb_vscan)
destroy(this.st_vscanserial)
destroy(this.dw_printscanexception)
end on

type sle_1 from singlelineedit within w_shipping_dock
integer x = 3209
integer y = 164
integer width = 215
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79216776
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_14 from statictext within w_shipping_dock
integer x = 2880
integer y = 256
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "NSS Note:"
boolean focusrectangle = false
end type

type st_11 from statictext within w_shipping_dock
integer x = 2880
integer y = 164
integer width = 325
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "NSS Operator:"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_shipping_dock
integer x = 2880
integer y = 324
integer width = 544
integer height = 1096
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type dw_destination_scf from datawindow within w_shipping_dock
boolean visible = false
integer x = 14
integer y = 1432
integer width = 2830
integer height = 432
integer taborder = 70
string title = "none"
string dataobject = "d_destination_scf"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_dest from datawindow within w_shipping_dock
integer x = 2894
integer y = 32
integer width = 617
integer height = 1384
integer taborder = 10
string dataobject = "d_dddw_destination_list_customerwise"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

event clicked;if row > 0 then 
	int	li_bol
	string	ls_boldest, ls_type
	if sle_destination.text <> object.destination[row] then
		sle_destination.text = object.destination[row]
		szdestination = object.destination[row]
		update	shipper
		set	destination = :szdestination
		where	id = :ishipper;
		if sqlca.sqlcode = 0 then
			commit;
			select	isnull(bill_of_lading_number,0) 
			into	:li_bol
			from	shipper 
			where	id = :ishipper;
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
					set	destination = :szdestination
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

type em_verifyscan from editmask within w_shipping_dock
boolean visible = false
integer x = 1385
integer y = 568
integer width = 462
integer height = 88
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!"
end type

event modified;long	ll_row, ll_foundrow, ll_curnrow, ll_totalrows
long	ll_serial, ll_objectserial, ll_len, ll_char, ll_idx
if text > '' then 
	ll_len = len(trim(text))
	for ll_idx = 1 to ll_len
		if asc(mid(text,ll_idx,1)) > 64 and asc(mid(text,ll_idx,1)) < 91 then   
			exit
		end if 	
	next
	if ll_idx >= ll_len then ll_idx = 0 
	ll_serial = Long ( Right ( text, ( ll_len - ll_idx)))
	if ll_serial > 0 then 
		if dw_verifyscan.find("serial="+string(ll_serial),1,dw_verifyscan.rowcount()) <= 0 then
			ll_row = dw_verifyscan.insertrow(0)
			if ll_row > 0 then 
				dw_verifyscan.setitem(ll_row, "serial", ll_serial)
				ll_totalrows = dw_view_boxes_on_pallet.retrieve(ll_serial)
				if ll_totalrows > 0 then
					for ll_curnrow = 1 to ll_totalrows
						ll_objectserial= dw_view_boxes_on_pallet.object.serial[ll_curnrow]
						ll_row = dw_verifyscan.insertrow(0)
						dw_verifyscan.setitem(ll_row, "serial", ll_objectserial)
						dw_verifyscan.setitem(ll_row, "parent_serial", ll_serial)
					next
				end if 	
			end if
		end if 	
		text = ""	
	end if
end if 
end event

type p_1 from picture within w_shipping_dock
boolean visible = false
integer x = 14
integer y = 176
integer width = 73
integer height = 64
string picturename = "exit2.bmp"
boolean focusrectangle = false
end type

event clicked;p_1.visible 						  = FALSE
st_pallet.Visible 				  = FALSE
dw_view_boxes_on_pallet.visible = FALSE
dw_pallet_info.visible 			  = FALSE
bPalletVisible 					  = FALSE
sle_orig_pallet_tare.visible	  = FALSE

w_shipping_mdi_screen.ChangeMenu(m_shipping_dock)	
end event

type sle_document from statictext within w_shipping_dock
integer x = 2446
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type sle_status from statictext within w_shipping_dock
integer x = 1673
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_black from statictext within w_shipping_dock
integer x = 2487
integer y = 796
integer width = 334
integer height = 44
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Black = Available"
boolean focusrectangle = false
end type

type st_blue from statictext within w_shipping_dock
integer x = 2153
integer y = 796
integer width = 311
integer height = 44
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16777215
boolean enabled = false
string text = "Blue = On Pallet"
boolean focusrectangle = false
end type

type cb_note_exit from commandbutton within w_shipping_dock
boolean visible = false
integer x = 1920
integer y = 716
integer width = 247
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

on clicked;wf_show_note(FALSE)
end on

type st_13 from statictext within w_shipping_dock
integer x = 2432
integer y = 176
integer width = 165
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Staged"
long bordercolor = 16777215
boolean focusrectangle = false
end type

type p_5 from picture within w_shipping_dock
integer x = 2345
integer y = 176
integer width = 73
integer height = 60
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_12 from statictext within w_shipping_dock
integer x = 2107
integer y = 176
integer width = 210
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Part Note"
long bordercolor = 16777215
boolean focusrectangle = false
end type

type p_4 from picture within w_shipping_dock
integer x = 2021
integer y = 172
integer width = 73
integer height = 60
string picturename = "noteyes.bmp"
boolean focusrectangle = false
end type

on clicked;w_shipping_dock.TriggerEvent("show_note")
end on

type st_red from statictext within w_shipping_dock
integer x = 1842
integer y = 796
integer width = 306
integer height = 44
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Red = Staged"
boolean focusrectangle = false
end type

type st_10 from statictext within w_shipping_dock
integer x = 1353
integer y = 784
integer width = 110
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Box"
boolean focusrectangle = false
end type

type p_3 from picture within w_shipping_dock
integer x = 1280
integer y = 788
integer width = 55
integer height = 48
string picturename = "box.bmp"
boolean focusrectangle = false
end type

type st_9 from statictext within w_shipping_dock
integer x = 1152
integer y = 784
integer width = 128
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Pallet"
boolean focusrectangle = false
end type

type p_2 from picture within w_shipping_dock
integer x = 1079
integer y = 796
integer width = 64
integer height = 44
string picturename = "pallet.bmp"
boolean focusrectangle = false
end type

type st_8 from statictext within w_shipping_dock
integer x = 2066
integer y = 48
integer width = 366
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79216776
boolean enabled = false
string text = "Packing List"
boolean focusrectangle = false
end type

type st_7 from statictext within w_shipping_dock
integer x = 1467
integer y = 48
integer width = 201
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79216776
boolean enabled = false
string text = "Status"
boolean focusrectangle = false
end type

type st_5 from statictext within w_shipping_dock
integer x = 1504
integer y = 780
integer width = 1353
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "   Objects"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_shipping_dock
integer x = 9
integer y = 780
integer width = 1463
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "             Staged Pallets/Objects"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_objects from datawindow within w_shipping_dock
event ue_dragdrop ( )
integer x = 1504
integer y = 860
integer width = 1353
integer height = 564
integer taborder = 170
string dragicon = "MONITOR.ICO"
string dataobject = "dw_available_objects"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dragdrop;Integer iCurrentShipper
Integer iCurrentPallet
Integer iRow

wf_update_kanban(iserial)

If bDragStagedObj then		  //Send back to inventory from DW_PALLETS
	bDragStagedObj = FALSE

	If sle_document.text	= "Printed" then
	
		If MessageBox("Warning", "This shipper is already staged and the " + &
						"packing list has been printed. Do you want to continue " + &
						"with your request?", StopSign!, OkCancel!) = 2 then
			Return
		Else
			w_list_of_active_shippers.wf_set_print_status("N")
			sle_document.text	= "Not Printed"
		End If
	
	End If

	If cObjectType = 'S' then 	//Unstage the whole pallet
		Unstage_whole_pallet()
	Else 								//Unstage individual box
		Unstage_box(iSerial)	
		Check_shipper_status()	//Check shipper status
	End If						

Else
	If bDragPalletBox then 		//Unstage individual box from pallet
		bDragPalletBox = FALSE
		Unstage_box(iSerial)
		dw_view_boxes_on_pallet.Retrieve(iPalletSerial)
		dw_pallet_info.SetItem(1, "total_objects", dw_view_boxes_on_pallet.RowCount())
		check_shipper_status()	//Check shipper status
		wf_calculate_pallet_weight(iPalletSerial, f_get_value(dec(sle_orig_pallet_tare.text)))			
	End If

End If

dw_pallets.Retrieve(iShipper)

dw_shipper_detail.Retrieve ( iShipper )

wf_refresh_shipper_status ( )

end event

event clicked;IF row < 1 THEN
	SetSort ( Left ( String ( dwo.Name ), len ( String ( dwo.name ) ) - 2 ) )
	Sort ( )
ELSE
	string	ls_part
	string	ls_nonship
	string	ls_nonshipnote
	string	ls_nonshipoperator
	long	ll_rowfnd
	if checkpartstatus() then
		ls_part = dw_objects.object.part[row]
		ll_rowfnd = dw_shipper_detail.find("part_original='"+ls_part+"'",1,dw_shipper_detail.rowcount())
		if ll_rowfnd > 0 then 
			ls_nonship = dw_shipper_detail.object.non_ship[ll_rowfnd]
			ls_nonshipnote = dw_shipper_detail.object.non_ship_note[ll_rowfnd]
			ls_nonshipoperator = dw_shipper_detail.object.non_ship_operator[ll_rowfnd]
			if isnull(ls_nonship,'N') = 'Y' then 
				if messagebox(monsys.msg_title, 'Part '+ls_part+' is set to a non ship status.  REASON: '+ls_nonshipnote+'.  Would you like to continue with staging (Y/N)?',Question!, Yesno!, 2) = 2 then
					return
				end if 	
			end if
		end if 
	end if 

	bDragInvObj 	= FALSE
	bDragStagedObj = FALSE
	bDragInvObj    = TRUE
	dw_objects.drag(begin!)
	iSerial = dw_objects.object.serial[row]
	Timer(0.5)
END IF
end event

event retrieveend;long		ll_row

Sort ( )

if iSerial > 0 then
	ll_row = Find ( "serial = " + String ( iSerial ), 1, RowCount ( ) )
	if ll_row > 0 then
		if iSerial = GetItemNumber ( ll_row, "serial" ) then
			ScrollToRow ( ll_row )
		end if
	end if
end if
end event

event dragdrop;Post Event ue_dragdrop ( )
end event

type sle_orig_pallet_tare from editmask within w_shipping_dock
boolean visible = false
integer x = 357
integer y = 476
integer width = 224
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421376
boolean border = false
alignment alignment = right!
string mask = "###,###.00"
end type

on modified;Decimal nTareWeight
Decimal nGrossWeight

Long    iSerial

iSerial			= dw_pallet_info.GetItemNumber(1, "serial")
nTareWeight 	= dw_pallet_info.GetItemNumber(1, "tare_weight")
nGrossWeight	= dw_pallet_info.GetItemNumber(1, "gross_weight")

nTareWeight		= f_get_value(nTareWeight)  - f_get_value(nPalletTare) + dec(this.text)
nGrossWeight	= f_get_value(nGrossWeight) - f_get_value(nPalletTare) + dec(this.text)

nPalletTare		= f_get_value(dec(this.text))

dw_pallet_info.SetItem(1, "tare_weight",  nTareWeight)
dw_pallet_info.SetItem(1, "gross_weight", nGrossWeight)

wf_calculate_pallet_weight(iSerial, nPalletTare)
end on

type st_pallet from statictext within w_shipping_dock
boolean visible = false
integer x = 5
integer y = 172
integer width = 1467
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Pallet"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_shipping_dock
integer x = 713
integer y = 48
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79216776
boolean enabled = false
string text = "Destination"
boolean focusrectangle = false
end type

type sle_destination from singlelineedit within w_shipping_dock
integer x = 1065
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80269524
boolean autohscroll = false
end type

type sle_shipper from singlelineedit within w_shipping_dock
integer x = 293
integer y = 48
integer width = 347
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
boolean enabled = false
boolean autohscroll = false
end type

type st_1 from statictext within w_shipping_dock
integer x = 41
integer y = 48
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79216776
boolean enabled = false
string text = "Shipper"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_shipping_dock
integer x = 5
integer width = 2866
integer height = 144
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79216776
end type

type st_3 from statictext within w_shipping_dock
integer x = 9
integer y = 164
integer width = 2853
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Shipper Detail Item"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_shipping_dock
boolean visible = false
integer x = 37
integer y = 176
integer width = 1463
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Shipping Dock"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_verifyscan from datawindow within w_shipping_dock
boolean visible = false
integer x = 1513
integer y = 788
integer width = 855
integer height = 636
integer taborder = 110
boolean titlebar = true
string title = "Verify Scan Data"
string dataobject = "d_verifyscan"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;long	ll_curnrow, ll_totalrows, ll_foundrow, ll_insertrow, ll_trows
long	ll_serial, ll_parentserial

if dwo.name = 'cb_compare' then 
	//	compare the staged object dw & this scanned dw. Any discrepencies 
	//	write to another external dw & display the same 
	dw_printscanexception.reset()	
	ll_totalrows = dw_verifyscan.rowcount()
	for ll_curnrow = 1 to ll_totalrows
		ll_serial = dw_verifyscan.object.serial[ll_curnrow]
		ll_parentserial = dw_verifyscan.object.parent_serial[ll_curnrow]		
		ll_foundrow = dw_pallets.find("serial="+string(ll_serial),1,dw_pallets.rowcount())
		if isnull(ll_foundrow,0) <= 0 then
			ll_trows = dw_view_boxes_on_pallet.retrieve(ll_parentserial)
			ll_foundrow = dw_view_boxes_on_pallet.find("serial="+string(ll_serial),1,dw_view_boxes_on_pallet.rowcount())
			if isnull(ll_foundrow,0) <= 0 then
				ll_insertrow = dw_printscanexception.insertrow(0)
				dw_printscanexception.setitem(ll_insertrow,"scanned_serial", ll_serial)
				dw_printscanexception.setitem(ll_insertrow,"Discrepency", "Serial# "+string(ll_serial)+" is not staged to shipper# "+string(ishipper))
			end if			
		end if 	
	next
	ll_totalrows = dw_pallets.rowcount()
	for ll_curnrow = 1 to ll_totalrows
		ll_serial = dw_pallets.object.serial[ll_curnrow]
		ll_parentserial = dw_pallets.object.parent_serial[ll_curnrow]		
		ll_foundrow = dw_verifyscan.find("serial="+string(ll_serial),1,dw_verifyscan.rowcount())
		if isnull(ll_foundrow,0) <= 0 then
			ll_trows = dw_view_boxes_on_pallet.retrieve(ll_parentserial)
			ll_foundrow = dw_verifyscan.find("serial="+string(ll_serial),1,dw_verifyscan.rowcount())
			if isnull(ll_foundrow,0) <= 0 then
				ll_insertrow = dw_printscanexception.insertrow(0)
				dw_printscanexception.setitem(ll_insertrow,"scanned_serial", ll_serial)
				dw_printscanexception.setitem(ll_insertrow,"Discrepency", "Serial# "+string(ll_serial)+" staged to shipper# "+string(ishipper)+" but no in the scanned objects list")
			end if			
		end if 	
	next
	
	dw_printscanexception.show()
	dw_verifyscan.reset()
	dw_verifyscan.hide()	
	gb_vscan.hide()
	st_vscanserial.hide()
	em_verifyscan.hide()
end if 	

end event

type uo_dw_scan from u_serial_scan within w_shipping_dock
boolean visible = false
integer x = 640
integer y = 944
integer width = 1787
integer taborder = 80
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;LONG	ll_boxserial, &
	ll_palletserial

Choose Case dwo.name
	Case "scan"
		if isnull(object.scan[1],'') > '' then
			ll_boxserial = IsNull ( object.boxserial [ 1 ], 0 )
			ll_palletserial = IsNull ( object.palletserial [ 1 ], 0 )
			
			if object.type[1] = 'S' then  // stage
				IF ll_boxserial > 0 THEN
					wf_stage_object ( ll_boxserial )
				ELSEIF ll_palletserial > 0 then
					wf_stage_object ( ll_palletserial )
				END IF
			else  // unstage
				if ll_boxserial > 0 then
					iSerial = ll_boxserial
					if dw_object_info.Retrieve ( ll_boxserial ) > 0 then
						wf_update_kanban(iSerial)
						if dw_object_info.object.type[1] = 'S' then
							unstage_whole_pallet ( )
						else
							unstage_box ( iSerial )
						end if
					end if
				elseif ll_palletserial > 0 then
					iSerial = ll_palletserial
					unstage_whole_pallet ( )
				end if
				dw_pallets.Retrieve(iShipper)
				dw_shipper_detail.Retrieve ( iShipper )
			end if
		end if
		
		wf_refresh_shipper_status ( )
End Choose

SetItem ( 1, "scan", '' )
AcceptText ( )
SetColumn ( "scan" )
SetFocus ( )


end event

type dw_pallets from datawindow within w_shipping_dock
integer x = 9
integer y = 860
integer width = 1463
integer height = 564
integer taborder = 160
string dragicon = "MONITOR.ICO"
string dataobject = "dw_pallets"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragdrop;Long iCurrentPallet
Long iCurrentShipper
Long    lBackColor				//Backgroud color
Long	  ll_PackLineQty
Long	  ll_Origin
LONG		ll_row
String  szObjectStatus			//QC status
String  szMod_string				//String used in modify
String  szObjectPackage			//Object's package type
String  szPartOriginal
String  s_kanban
Decimal nTareWeight				//To keep the tare weight info
Boolean bRightPackage			//Whether the current package is right or not
Timer( 1 )
If bPalletvisible then
	Return
End If
lBackColor = w_shipping_dock.BackColor

If bDragInvObj then						//Drop an inventory object
	bDragInvObj = FALSE
	wf_stage_object ( iSerial )
End If
dw_shipper_detail.Retrieve ( iShipper )			
wf_refresh_shipper_status ( )

end event

event doubleclicked;Decimal nGrossWeight
Decimal nNetWeight
Decimal nTareWeight
Decimal nOrigPalletTare
Decimal nBoxesTareWeight

Integer iRow

If bPalletvisible then
	Return
End If

bDragStagedObj = FALSE
iRow 				= This.GetClickedRow()

If iRow > 0 then

	iStagedRow	= iRow
	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)

	If dw_pallets.GetItemString(iRow, "type") = "S" then
		dw_pallet_info.Visible 				= TRUE
		dw_view_boxes_on_pallet.Visible 	= TRUE
		st_pallet.Visible      				= TRUE
	
		p_1.Visible            	= TRUE
		iPalletSerial          	= dw_pallets.GetItemNumber(iRow, "serial")
		dw_view_boxes_on_pallet.Retrieve(iPalletSerial)
	
		dw_object_info.Retrieve(iPalletSerial)
		nNetWeight			= dw_object_info.GetItemNumber(1, "weight")
		nBoxesTareWeight	= dw_object_info.GetItemNumber(1, "tare_weight")
		nOrigPalletTare	= Dec(dw_object_info.GetItemString(1, "custom1"))
		nGrossWeight		= f_get_value(nNetWeight) + f_get_value(nBoxesTareWeight) + f_get_value(nOrigPalletTare)
		nPalletTare			= f_get_value(nOrigPalletTare)

		dw_pallet_info.Reset()
		dw_pallet_info.Title 	= "Build Pallet " + String(iPalletSerial)
		dw_pallet_info.InsertRow(1)
		dw_pallet_info.SetItem(1, "serial", iPalletSerial)
		dw_pallet_info.SetItem(1, "total_objects", 	dw_view_boxes_on_pallet.RowCount())
		dw_pallet_info.SetItem(1, "net_weight", 		nNetWeight)
		dw_pallet_info.SetItem(1, "tare_weight", 		f_get_value(nBoxesTareWeight) + f_get_value(nOrigPalletTare))
		dw_pallet_info.SetItem(1, "gross_weight", 	nGrossWeight)
		dw_pallet_info.SetItem(1, "value1", String(f_get_value(nOrigPalletTare)))

//		wf_calculate_pallet_weight(iPalletSerial, nPalletTare) 		
		sle_orig_pallet_tare.text		= String(Truncate(f_get_value(nOrigPalletTare), 2))
		bPalletVisible 					= TRUE
		sle_orig_pallet_tare.visible	= TRUE
	Else
		MessageBox("Warning", "No detail on box", StopSign!)
	End If

End If


end event

on rbuttondown;//Integer iRow
//
//If bPalletvisible then
//	Return
//End If
//
//bDragStagedObj = FALSE
//iRow = iStagedRow 
//
//If iRow > 0 then
//	If dw_pallets.GetItemString(iRow, "type") = "S" then
//		dw_pallet_info.Visible = TRUE
//		dw_view_boxes_on_pallet.Visible = TRUE
//		st_pallet.Visible      = TRUE
//		dw_view_boxes_on_pallet.Retrieve(iPalletSerial)
//		p_1.Visible            = TRUE
//		iPalletSerial          = dw_pallets.GetItemNumber(iRow, "serial")
//		
//		dw_pallet_info.Reset()
//		dw_pallet_info.Title = "Build Pallet " + String(iPalletSerial)
//		dw_pallet_info.InsertRow(1)
//		dw_pallet_info.SetItem(1, "serial", iPalletSerial)
//		dw_pallet_info.SetItem(1, "total_objects", dw_view_boxes_on_pallet.RowCount())
//		dw_pallet_info.SetItem(1, "net_weight", 0)
//		dw_pallet_info.SetItem(1, "tare_weight", 0)
//		dw_pallet_info.SetItem(1, "gross_weight", 0)
//		dw_view_boxes_on_pallet.Retrieve(iPalletSerial)
//		bPalletVisible = TRUE
//	Else
//		MessageBox("Operator Error", "You can not view detail on box")
//	End If
//End If

Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)
End If


end on

on clicked;Integer iRow
String  cTemp

If bPalletvisible then
	Return
End If

iRow = dw_pallets.GetClickedRow()

bDragStagedObj = FALSE
bDragInvObj 	= FALSE
iStagedRow		= 0

If iRow > 0 then
	iStagedRow     = iRow
	bDragStagedObj = TRUE
	dw_pallets.Drag(begin!)
	iSerial 		= dw_pallets.GetItemNumber(iRow, "serial")
	cObjectType	= dw_pallets.GetItemString(iRow, "type")
	iSuffix		= dw_pallets.GetItemNumber(iRow, "suffix")
	dw_pallets.SelectRow(iRow, Not this.IsSelected(iRow))
End If
	
end on

type dw_view_boxes_on_pallet from datawindow within w_shipping_dock
boolean visible = false
integer y = 576
integer width = 1463
integer height = 512
integer taborder = 60
string dragicon = "MONITOR.ICO"
boolean titlebar = true
string title = "Detail Information on Pallet"
string dataobject = "dw_view_boxes_on_pallet"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;bDragPalletBox = FALSE

iPalletBoxRow  = row

If iPalletBoxRow > 0 then
	dw_view_boxes_on_pallet.Drag(begin!)
	iSerial = dw_view_boxes_on_pallet.GetItemNumber(iPalletBoxRow, "serial")
	bDragPalletBox = TRUE
	SelectRow(Row, Not IsSelected(Row))
End If
end event

event dragdrop;Long iCurrentPallet 		//to keep the current pallet serial number
Long iCurrentshipper    //to keep the current shipper number
Long lsuffix				//to get the suffix
Long lrow
LONG	ll_row

String szObjectPackage	//Package type 
String szMod_string
Long   lBackColor

Decimal nTareWeight		//Tare weight
Decimal nNetWeight		//Net weight
Decimal nGrossWeight		//Gross weight

If bDragInvObj then								//If dragging a single box
	bDragInvObj	= FALSE
	wf_stage_object ( iSerial )
End If

dw_shipper_detail.Retrieve ( iShipper )	
end event

type dw_shipper_detail from datawindow within w_shipping_dock
integer x = 9
integer y = 256
integer width = 2853
integer height = 496
integer taborder = 30
string dataobject = "dw_shipper_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If bPalletvisible then
	Return
End If

SetNull(iSuffix)

If row > 0 then
	iDetailRow	= row
	szPart 		= dw_shipper_detail.GetItemString(row, "part")
	iSuffix		= dw_shipper_detail.GetItemNumber(row, "shipper_detail_suffix")
	If iSuffix > 0 then		//Strip off the Suffix
		szPart	= wf_strip_off_suffix(szPart, iSuffix)
	End If
	iSalesOrder	= dw_shipper_detail.GetItemNumber(row, "shipper_detail_order_no")
	dw_shipper_detail.SelectRow(0, FALSE)
	dw_shipper_detail.SelectRow(row, TRUE)
	is_SelectedPart = szPart
	sle_1.text = dw_shipper_detail.object.non_ship_operator[row]
	mle_1.text = dw_shipper_detail.object.non_ship_note[row]
End If

end event

event retrieveend;// declare local variables
long	ll_row

// if a part was previously selected, re-select it
if is_SelectedPart > '' then
	// find part again (sorted by part)
	ll_row = Find ( "part='" + is_SelectedPart + "'", 1, rowcount )
	if ll_row > 0 then
		// if it's found, make sure it's the right part
		if object.part[ll_row] = is_SelectedPart then
			// select and scroll to the row found
			ScrollToRow ( ll_row )
			SelectRow ( ll_row, TRUE )
		else
			// reset if no part is found
			is_SelectedPart = ''
		end if
	else
		// reset if no part is found
		is_SelectedPart = ''
	end if
else
	// reset if no part is found
	is_SelectedPart = ''
end if

end event

type dw_pallet_info from datawindow within w_shipping_dock
boolean visible = false
integer x = 14
integer y = 256
integer width = 1463
integer height = 320
integer taborder = 40
string dataobject = "dw_pallet_info"
boolean livescroll = true
end type

event dragdrop;Long iCurrentPallet 		//to keep the current pallet serial number
Long iCurrentshipper    //to keep the current shipper number
Long lsuffix				//to get the suffix
Long lrow
LONG	ll_row

String szObjectPackage	//Package type 
String szMod_string
Long   lBackColor

Decimal nTareWeight		//Tare weight
Decimal nNetWeight		//Net weight
Decimal nGrossWeight		//Gross weight

If bDragInvObj then								//If dragging a single box
	bDragInvObj	= FALSE
	wf_stage_object ( iSerial )
End If

dw_shipper_detail.Retrieve ( iShipper )	
end event

type cb_note from commandbutton within w_shipping_dock
boolean visible = false
integer x = 1074
integer y = 240
integer width = 1170
integer height = 608
integer taborder = 130
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type mle_note from multilineedit within w_shipping_dock
boolean visible = false
integer x = 1138
integer y = 284
integer width = 1029
integer height = 416
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
boolean enabled = false
end type

type cb_scan_out from commandbutton within w_shipping_dock
boolean visible = false
integer x = 1147
integer y = 348
integer width = 859
integer height = 412
integer taborder = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type mle_scan_out from multilineedit within w_shipping_dock
boolean visible = false
integer x = 1230
integer y = 384
integer width = 713
integer height = 348
integer taborder = 150
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
end type

type gb_vscan from groupbox within w_shipping_dock
boolean visible = false
integer x = 1024
integer y = 488
integer width = 850
integer height = 220
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_vscanserial from statictext within w_shipping_dock
boolean visible = false
integer x = 1042
integer y = 576
integer width = 338
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
string text = "Scan Serial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_printscanexception from datawindow within w_shipping_dock
boolean visible = false
integer x = 14
integer y = 172
integer width = 2848
integer height = 1252
integer taborder = 90
boolean titlebar = true
string title = "Staged Vs. Scanned Exceptions"
string dataobject = "d_printscanexception"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
end type

event buttonclicked;if dwo.name = 'cb_close' then 
	hide()
elseif dwo.name = 'cb_print' then 
	print()
end if 	
end event


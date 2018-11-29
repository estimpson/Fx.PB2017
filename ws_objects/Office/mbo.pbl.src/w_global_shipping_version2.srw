$PBExportHeader$w_global_shipping_version2.srw
forward
global type w_global_shipping_version2 from w_sheet_4t
end type
type st_um from statictext within w_global_shipping_version2
end type
type dw_range from datawindow within w_global_shipping_version2
end type
type cb_1 from commandbutton within w_global_shipping_version2
end type
type mle_selected from multilineedit within w_global_shipping_version2
end type
type dw_demand from datawindow within w_global_shipping_version2
end type
type cbx_active_demand from checkbox within w_global_shipping_version2
end type
type st_16 from statictext within w_global_shipping_version2
end type
type p_6 from picture within w_global_shipping_version2
end type
type st_10 from statictext within w_global_shipping_version2
end type
type ddlb_date_selection from dropdownlistbox within w_global_shipping_version2
end type
type st_detail_title from statictext within w_global_shipping_version2
end type
type dw_3 from datawindow within w_global_shipping_version2
end type
type st_list_by from statictext within w_global_shipping_version2
end type
type st_warning from statictext within w_global_shipping_version2
end type
type st_accum from statictext within w_global_shipping_version2
end type
type cbx_add from checkbox within w_global_shipping_version2
end type
type dw_parts_per_dest from datawindow within w_global_shipping_version2
end type
type st_drag2 from statictext within w_global_shipping_version2
end type
type ddlb_2 from dropdownlistbox within w_global_shipping_version2
end type
type st_11 from statictext within w_global_shipping_version2
end type
type p_2 from picture within w_global_shipping_version2
end type
type dw_qty_assigned from datawindow within w_global_shipping_version2
end type
type dw_4 from datawindow within w_global_shipping_version2
end type
type sle_search from singlelineedit within w_global_shipping_version2
end type
type dw_dest from datawindow within w_global_shipping_version2
end type
type ddlb_1 from dropdownlistbox within w_global_shipping_version2
end type
type cbx_past_due from checkbox within w_global_shipping_version2
end type
type dw_2 from datawindow within w_global_shipping_version2
end type
type dw_range_weights from datawindow within w_global_shipping_version2
end type
type cb_note_save from commandbutton within w_global_shipping_version2
end type
type mle_note from multilineedit within w_global_shipping_version2
end type
type cb_note from commandbutton within w_global_shipping_version2
end type
type mle_message from multilineedit within w_global_shipping_version2
end type
type st_message from statictext within w_global_shipping_version2
end type
type st_drag from statictext within w_global_shipping_version2
end type
type dw_crosstab from u_dw_crosstab_gss within w_global_shipping_version2
end type
end forward

global type w_global_shipping_version2 from w_sheet_4t
string title = "Shipping Scheduler"
string menuname = "m_global_shipping_scheduler"
event create_shipper pbm_custom01
event rebuild_crosstab pbm_custom02
event updt_detail_qty pbm_custom03
event refresh_shipper_window pbm_custom04
event view_date pbm_custom05
event save_releases pbm_custom06
event ue_part_dest ( character a_s_mode )
event ue_active_demand pbm_custom08
event ue_past_due pbm_custom09
event ue_addedit_rel pbm_custom10
st_um st_um
dw_range dw_range
cb_1 cb_1
mle_selected mle_selected
dw_demand dw_demand
cbx_active_demand cbx_active_demand
st_16 st_16
p_6 p_6
st_10 st_10
ddlb_date_selection ddlb_date_selection
st_detail_title st_detail_title
dw_3 dw_3
st_list_by st_list_by
st_warning st_warning
st_accum st_accum
cbx_add cbx_add
dw_parts_per_dest dw_parts_per_dest
st_drag2 st_drag2
ddlb_2 ddlb_2
st_11 st_11
p_2 p_2
dw_qty_assigned dw_qty_assigned
dw_4 dw_4
sle_search sle_search
dw_dest dw_dest
ddlb_1 ddlb_1
cbx_past_due cbx_past_due
dw_2 dw_2
dw_range_weights dw_range_weights
cb_note_save cb_note_save
mle_note mle_note
cb_note cb_note
mle_message mle_message
st_message st_message
st_drag st_drag
dw_crosstab dw_crosstab
end type
global w_global_shipping_version2 w_global_shipping_version2

type variables
Boolean bCancel           //Whether cancel the operation
Boolean bNewShipper    //Whether create new shipper
Boolean bCrossTab        //Dragdrop from Crosstab
Boolean bShipperDetail  //Dragdrop from shipper detail
Boolean bPastDue = FALSE
Boolean bPartMode = FALSE //Whether list part number
Boolean bProcessDetail        //Whether able to process detail
Boolean bFirstTime = TRUE 
Decimal nQty                //Quantity
Decimal nCrossTabQtyLeft
Decimal nPrice              //SalesPrice
Decimal nNormalPrice    //Price to keep the normal order

String     szPart              	//Part number
String     szDestination   	//Destination
String     szNote             	//Note
String     szSalesMan      	//Keep the salesman info
String     szCustomerPO  	//Customer PO number
String     szAccountCode	//Account code
String     szPriceUnit      	//Price Unit
String     szShippingUnit 	//Shipping Unit of Measurement
String     szShipVia        	//Ship via code
String     szRelease        	//Release number 
String     szOrderType	//Order type
String	i_s_unit

Long     iCrossTabCol    //Crosstable col
Long     iShipper           //To keep the current shipper #
Long     iSalesOrder      //To keep the sales order
Long     iChoice            //To keep the choice
Long     iCurrentRow     //To keep the current row
Long     iCrossTabRow  //Crosstable row
Long     iPackaging_job //Packaging job number
Long     iDestRow         //Row # for destination
Long     iShipperRow     //Shipper row 
Long     iShipperDetailRow
Long     iSuffix

Date      dDate1, dDate2, dDate3, dDate4, dDate5
Date      dDate6, dDate7
Date      dDueDate
Date      dShipperDate  //Date for shippment

st_generic_structure stParm

boolean ib_control_key=false
string      is_dataarray[500,8]
int           ii_idx_elem=0

u_ds_range	i_ds_range
end variables

forward prototypes
public function date next_day (date today)
public subroutine display_dates ()
public subroutine updt_qty_assigned ()
public function decimal updt_crosstab_qty (decimal nqtyrequired)
public subroutine undo_qty_assigned (integer isalesorder, string szpart, decimal nqty)
public function date get_date (integer iCol)
public subroutine wf_flag_destination ()
public subroutine wf_get_customers ()
public subroutine wf_get_plants ()
public function date wf_get_date (int icol)
public function boolean wf_pack_line (string szPart)
public subroutine wf_get_order_info (long isalesorder)
public function string wf_get_account_code (string szpart)
public subroutine create_shipper_detail (long ishipper, string szpart, decimal nqty)
public subroutine wf_adjust_grid (string szpart, long isalesorder)
public subroutine wf_add_blanket_parts_to_crosstab ()
public subroutine wf_save_releases ()
public subroutine wf_update_release (long isalesorder, string szpart, date ddate, decimal nqty)
public function decimal wf_our_cum (long isalesorder)
public function boolean wf_accum (long isalesorder)
public function string wf_get_salesman (long isalesorder)
public subroutine wf_get_scheduler ()
public function string wf_get_release (long isalesorder, date ddate)
public subroutine wf_flag_current_dest (string szvalue, long irow)
public subroutine create_crosstab (string szvalue, date ddate)
public subroutine wf_get_product_line ()
public subroutine wf_show_note (boolean bFlag)
public function string wf_get_customer_part (long iorder, string szpart)
public function string wf_get_ship_type (long iorder)
public function string wf_get_order_type (long iorder)
public function boolean wf_reset_flag (long ishipper)
public function string wf_get_note (long iorder, string szpart, long isuffix)
public function string wf_strip_off_suffix (string szpart, long isuffix)
public subroutine wf_get_demands ()
public function boolean wf_check_type (integer orderno)
public function decimal wf_on_hand (string szpart)
end prototypes

event create_shipper;//***********************************************************************
//* Declaration
//***********************************************************************

Date dDue_date		//Due date for the shipper

//***********************************************************************
//* Initialization
//***********************************************************************


//***********************************************************************
//* Main program
//***********************************************************************

	If bNewShipper then		//need to generate a new shippper

		dDue_date = get_date(iCrossTabCol)

		Select parameters.shipper  
		Into   :iShipper  
		From   parameters  ;

		Update parameters  
		Set shipper = shipper + 1  ;

		dw_2.SelectRow(0, FALSE)
		dw_2.InsertRow(1)
		dw_2.SetItem(1, "id", iShipper)
		dw_2.SetItem(1, "date_stamp", dDue_date)
		dw_2.SetItem(1, "status", "O")
		dw_2.SetItem(1, "destination", szDestination)
		
		If dw_2.Update() > 0 then
			commit;
		Else
			rollback;
		End if
	End If

 	create_shipper_detail(iShipper, szPart, nQty)	//create shipper detail items		

	dw_2.Retrieve(szDestination)

end event

on rebuild_crosstab;display_dates()			//Display the new dates
create_crosstab(szDestination, dDate7)
end on

event updt_detail_qty;Decimal nOrigQty

If iChoice = 1 then
	nOrigQty = dw_4.GetItemNumber(iCurrentRow, "qty_required")
	dw_4.SetItem(iCurrentRow, "qty_required", nQty + nOrigQty)
	nOrigQty = dw_4.GetItemNumber(iCurrentRow, "qty_original")
	dw_4.SetItem(iCurrentRow, "qty_original", nOrigQty + nQty)
Else
	dw_4.SetItem(iCurrentRow, "qty_required", nQty)
	dw_4.SetItem(iCurrentRow, "qty_original", nQty)
End If

dw_4.SetItem(iCurrentRow, "alternative_unit", i_s_unit )
dw_4.SetItem(iCurrentRow, "release_no", szRelease)

//iPackaging_job	= dw_4.GetItemNumber(iCurrentRow, "packaging_job")

If dw_4.Update() > 0 then
	Commit;
	updt_qty_assigned()
	//wf_updt_unscheduled_mps(nQty, dDueDate)			//Update MPS
	dw_3.Title = "Line Items for " + String(iShipper)
	dw_3.Retrieve(iShipper)
Else
	Rollback;
End If	
end event

event refresh_shipper_window;dw_2.SetItem(iShipperRow, "date_stamp", dShipperDate)
dw_2.SetItem(iShipperRow, "ship_via", szShipVia)
dw_2.SetItem(iShipperRow, "notes", szNote)
end event

event view_date;
//	Open window to select date (refactor to onscreen control).
SetMicroHelp("Change view date for the schedule...")
OpenWithParm(w_selectdate,String(dDate1))

//	Check for return value.
if	Message.StringParm > "" then
	dDate1 = Date(Message.StringParm)
	TriggerEvent("rebuild_crosstab")
	wf_flag_destination()
end if

end event

event save_releases;wf_save_releases()
end event

event ue_part_dest;IF a_s_mode = 'P' THEN
	bPartMode	= TRUE
ELSE
	bPartMode	= FALSE
END IF

ddlb_1.Reset()
ddlb_1.AddItem("All")
dw_crosstab.reset ( )
ddlb_2.Reset()

If bPartMode then
	dw_dest.DataObject	= "dw_list_of_parts_for_demand_search"
	dw_demand.DataObject	= "dw_select_demand_per_part"	
	dw_2.DataObject		= "dw_list_of_shippers_per_part"
	st_list_by.text		= "Part"
	// included this to modify the column heading - mb 08/11/99
	dw_crosstab.object.part_t.text = 'Destination' 
	ddlb_1.AddItem("Product Line")
Else
	dw_dest.DataObject	= "dw_destinations"
	dw_demand.DataObject	= "dw_select_demand"
	dw_2.DataObject		= "dw_list_of_shippers"
	st_list_by.text		= "Dest"
	// included this to modify the column heading - mb 08/11/99
	dw_crosstab.object.part_t.text = 'Part'
	ddlb_1.AddItem("Customer")
	ddlb_1.AddItem("Plant")
	ddlb_1.AddItem("Scheduler")
End If

dw_dest.SetTransObject(sqlca)
dw_demand.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)

end event

event ue_active_demand;if cbx_active_demand.checked=false then
	cbx_active_demand.checked=true
else
	cbx_active_demand.checked=false
end if 
cbx_active_demand.triggerevent('clicked')
end event

event ue_past_due;if cbx_past_due.checked=false then
	cbx_past_due.checked=true
else
	cbx_past_due.checked=false
end if 
cbx_past_due.triggerevent('clicked')
end event

event ue_addedit_rel;if cbx_add.checked=false then
	cbx_add.checked=true
else
	cbx_add.checked=false
end if 
cbx_add.triggerevent('clicked')
end event

public function date next_day (date today);Integer iMonth				//Number of month
Integer iYear				//Number of year
Integer iDay				//Number of day
Integer iDaysInMonth		//Total days in month

iDay   = day(today)
iMonth = month(today)
iYear  = year(today)

If iDay = days_in_month(iMonth, iYear) then
	iDay = 1
	If iMonth = 12 then
		iMonth = 1
		iYear  = iYear + 1
	Else
		iMonth = iMonth + 1
	End If
Else
	iDay = iDay + 1
End If

Return Date(iYear, iMonth, iDay) 




end function

public subroutine display_dates ();dDate2 = next_day(dDate1)
dDate3 = next_day(dDate2)
dDate4 = next_day(dDate3)
dDate5 = next_day(dDate4)
dDate6 = next_day(dDate5)
dDate7 = next_day(dDate6)


end subroutine

public subroutine updt_qty_assigned ();Integer iRow			//Current row number

Decimal nQtyLeft		//Qty left to be assigned
Decimal nQtyAssigned	//Qty assigned 
Decimal nQtyRequired	//Qty required
Decimal nQtyAllocated//Qty allocated

Date    dCurrentDate	//Current date for the demand

dw_qty_assigned.Retrieve(iSalesOrder, szPart)	//Retreive all demand 
																//for the part in order

If iSuffix > 0 then
	dw_qty_assigned.SetFilter("suffix = " + String(iSuffix))
	dw_qty_assigned.Filter()	
ELSE
	dw_qty_assigned.SetFilter ( "IsNull ( suffix ) " )
	dw_qty_assigned.Filter ( )
END IF

nQtyLeft = nQty

For iRow = 1 to dw_qty_assigned.RowCount()

	nQtyAssigned = dw_qty_assigned.GetItemNumber(iRow, "committed_qty")
	If isNull(nQtyAssigned) then
		nQtyAssigned = 0
	End If	

	nQtyRequired = dw_qty_assigned.GetItemNumber(iRow, "quantity")
	If isNull(nQtyRequired) then
		nQtyRequired = 0
	End If

	dCurrentDate = dw_qty_assigned.GetItemDate(iRow, "due_date")

	If nQtyRequired >  nQtyAssigned then	//Check whether need to allocate qty
		If nQtyLeft >= (nQtyRequired - nQtyAssigned) then //Yes, assign full 
			nQtyAllocated = (nQtyRequired - nQtyAssigned)
			nQtyLeft      = nQtyLeft - (nQtyRequired - nQtyAssigned)
			nQtyAssigned  = nQtyRequired
	
		Else 
			nQtyAllocated = nQtyLeft
			nQtyAssigned  = nQtyAssigned + nQtyLeft
			nQtyLeft      = 0
		End If

		If dw_qty_assigned.Update()>0 then
			commit;
		Else
			rollback;
		End If

	End If

	If nQtyLeft = 0 then		//Set the iRow to end the loop
		iRow = dw_qty_assigned.RowCount() + 1
	End If

Next 



//Update crosstab

nCrossTabQtyLeft     = nQty

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_past_due"))
dw_crosstab.SetItem(iCrossTabRow, "qty_past_due", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date1"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date1", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date2"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date2", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date3"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date3", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date4"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date4", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date5"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date5", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date6"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date6", nQtyRequired)

nQtyRequired = updt_crosstab_qty(dw_crosstab.GetItemNumber(iCrossTabRow, "qty_date7"))
dw_crosstab.SetItem(iCrossTabRow, "qty_date7", nQtyRequired)











	
	
end subroutine

public function decimal updt_crosstab_qty (decimal nqtyrequired);Decimal iQuantity

If IsNull(nQtyRequired) then 
	nQtyRequired = 0
End If

If nCrossTAbQtyLeft > nQtyRequired then
	nCrossTabQtyLeft     = nCrossTabQtyLeft - nQtyRequired
	nQtyRequired = 0
Else
	nQtyRequired = nQtyRequired - nCrossTabQtyLeft
	nCrossTabQtyLeft    = 0
End If

If nQtyRequired = 0 then
	SetNull(nQtyRequired)
End If

iQuantity = nQtyRequired

Return Truncate(iQuantity,0)
end function

public subroutine undo_qty_assigned (integer isalesorder, string szpart, decimal nqty);If bPartMode then
	create_crosstab(szPart, dDate7)		
	dw_2.Retrieve(szPart)
	dw_3.Reset()		
Else
	create_crosstab(szDestination, dDate7)
	dw_2.Retrieve(szDestination)			//List all open shippers for the destination
	dw_3.Reset()
	If cbx_add.checked then
		wf_add_blanket_parts_to_crosstab()
	End If
End If









	
	
end subroutine

public function date get_date (integer iCol);If iCol = 2 then
	Return dDate1
End If

If iCol = 3 then
	Return dDate2
End If

If iCol = 4 then
	Return dDate3
End If

If iCol = 5 then
	Return dDate4
End If

If iCol = 6 then
	Return dDate5
End If

If iCol = 7 then
	Return dDate6
End If

If iCol = 8 then
	Return dDate7
End If



end function

public subroutine wf_flag_destination ();Str_progress	sParm				//Parameters for progress bar
Long 				iRow				//Current row number

String			szDestination	//Current destination
String			szPart			//Current part number
String			szPrompt

sParm.Title	= "Set up demand flags"
OpenWithParm(w_progress, sParm)
w_progress.cb_cancel.visible	= FALSE

SetMicroHelp("Setup demand flags")
For iRow = 1 to dw_dest.RowCount()
	If bPartMode then
		szPart		= dw_dest.GetItemString(iRow, "part")
		szPrompt		= "Checking part " + szPart
		wf_flag_current_dest(szPart, iRow)
	Else
		szDestination	= dw_dest.GetItemString(iRow, "destination")
		szPrompt		= "Checking destination " + szDestination
		wf_flag_current_dest(szDestination, iRow)
	End If

	w_progress.wf_progress(iRow / dw_dest.RowCount(), szPrompt )

Next	

//If cbx_past_due.Checked then
//	dw_dest.SetFilter("flag = 1")
//Else
//	dw_dest.SetFilter("flag >= 0")
//End If
//dw_dest.Filter()	

dw_demand.SetFilter("quantity > 0")
dw_demand.Filter()

Close(w_progress)

SetMicroHelp("Ready")



end subroutine

public subroutine wf_get_customers ();//Str_progress sParm
//String 	szCurrentCustomer
//Integer 	iTotalCustomers
//Integer	iCount
//
//SetMicroHelp("Fetching customer list")
//
//ddlb_2.Reset()
//
//SELECT count(customer.customer )  
//  INTO :iTotalCustomers  
//  FROM customer  ;
//
//Declare CustomerCur Cursor for Select Customer From Customer Using sqlca;
//
//Open CustomerCur;
//
//Fetch CustomerCur into :szCurrentCustomer;
//
//iCount = 1
//sParm.Title = "Fetching customer list"
//OpenWithParm(w_progress, sParm)
//w_progress.cb_cancel.visible	= FALSE
//
//Do while sqlca.sqlcode = 0
//	w_progress.wf_progress(iCount / iTotalCustomers, "Add customer:" + szCurrentCustomer)
//	ddlb_2.AddItem(szCurrentCustomer)
//	Fetch CustomerCur into :szCurrentCustomer;
//	iCount ++
//Loop
//
//Close CustomerCur;
//Close(w_progress)
//
//SetMicroHelp("Ready")	
//
Str_progress sParm

String l_s_Customer, &
	    l_s_Name, &
		 l_s_Temp
		 
SetMicroHelp("Fetching customer list")

ddlb_2.Reset()

Declare CustomerCur Cursor for Select Customer, Name From Customer, customer_service_status where customer.cs_status = customer_service_status.status_name and customer_service_status.status_type <> 'C' Using sqlca;

Open CustomerCur;

Fetch CustomerCur into :l_s_Customer, :l_s_name;

Do while sqlca.sqlcode = 0
	
	l_s_Temp = l_s_Customer + Space (11 - LenA(l_s_Customer) ) + l_s_name
	ddlb_2.AddItem(l_s_temp)
	Fetch CustomerCur into :l_s_Customer , :l_s_Name;                      
Loop

Close CustomerCur;
Close(w_progress)

SetMicroHelp("Ready")	
end subroutine

public subroutine wf_get_plants ();Str_progress sParm
String szCurrentPlant

Integer iTotalPlants
Integer iCount

SetMicroHelp("Fetching Plant List")

ddlb_2.Reset()

Select Count(Distinct Plant) into :iTotalPlants From Destination;

Declare PlantCur Cursor for Select Distinct Plant From Destination Using sqlca;

Open PlantCur;

Fetch PlantCur into :szCurrentPlant;

iCount = 1
sParm.title	= "Fetching Plant List"
OpenWithParm(w_progress, sParm)

Do while sqlca.sqlcode = 0
	w_progress.wf_progress(iCount / iTotalPlants, "Add plant:" + szCurrentPlant)
	ddlb_2.AddItem(szCurrentPlant)
	Fetch PlantCur into :szCurrentPlant;
	iCount ++
Loop

Close PlantCur;
Close(w_progress)

SetMicroHelp("Ready")
	
end subroutine

public function date wf_get_date (int icol);If iCol = 2 then
	Return dDate1
End If

If iCol = 3 then
	Return dDate1
End If

If iCol = 4 then
	Return dDate2
End If

If iCol = 5 then
	Return dDate3
End If

If iCol = 6 then
	Return dDate4
End If

If iCol = 7 then
	Return dDate5
End If

If iCol = 8 then
	Return dDate6
End If

If iCol = 9 then
	Return dDate7 
End if



end function

public function boolean wf_pack_line (string szPart);Return FALSE
end function

public subroutine wf_get_order_info (long isalesorder);  SELECT order_header.customer_po,   
         order_header.alternate_price,   
         order_header.price_unit,   
         order_header.salesman,
			order_header.shipping_unit 
    INTO :szCustomerPO,   
         :nPrice,   
         :szPriceUnit,   
         :szSalesman, 
			:szShippingUnit
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

end subroutine

public function string wf_get_account_code (string szpart);string	ls_gl_account

ls_gl_account = f_get_part_info(szPart, "MFG GL ACCOUNT")
if isnull(ls_gl_account,'') = '' then
	ls_gl_account = f_get_part_info(szPart, "GL ACCOUNT")
end if

return ls_gl_account
end function

public subroutine create_shipper_detail (long ishipper, string szpart, decimal nqty);//************************************************************************
//* Declaration
//************************************************************************
Integer iRow

Decimal nOrigQty

Boolean bFound		//Add a new part

String  	szShipperPart
String	ls_Taxable
String	ls_GroupNo
String	s_Notes

//************************************************************************
//* Initialization
//************************************************************************

wf_get_order_info(iSalesOrder)

dw_4.Retrieve(iShipper)

iRow   = 1
bFound = FALSE

If iSuffix > 0 then
	szShipperPart	= szPart + "-" + String(iSuffix)
Else
	szShipperPart	= szPart
End If

Do While iRow <= dw_4.RowCount() AND (Not bFound)

	If Trim(dw_4.GetItemString(iRow, "part")) = Trim(szShipperPart) then
		bFound = TRUE
	Else
		iRow = iRow + 1
	End If

Loop

If bFound then

	iCurrentRow = iRow

	iChoice		= 1
	TriggerEvent("updt_detail_qty")

Else

	szSalesMan	= wf_get_salesman(iSalesOrder)  //Also get nPrice, szPriceUnit

	dw_4.InsertRow(1)
	
	dw_4.SetItem ( 1, "part_name", f_get_part_info ( szPart, "NAME" ) )
	dw_4.SetItem ( 1, "part", szShipperPart )
	dw_4.SetItem ( 1, "note", szNote )
	dw_4.SetItem ( 1, "qty_required", nQty )
	dw_4.SetItem ( 1, "order_no", iSalesOrder )
	dw_4.SetItem ( 1, "qty_original", nQty ) 
	dw_4.SetItem ( 1, "shipper", iShipper )
	dw_4.SetItem ( 1, "customer_po", szCustomerPO )
	dw_4.SetItem ( 1, "price", nPrice )
	dw_4.SetItem ( 1, "account_code", wf_get_account_code ( szPart ) )
	dw_4.SetItem ( 1, "salesman", szSalesman )
	dw_4.SetItem ( 1, "pack_line_qty", 0 )
	dw_4.SetItem ( 1, "alternative_unit", i_s_unit )
	dw_4.SetItem ( 1, "price_type", szPriceUnit )
	dw_4.SetItem ( 1, "release_no", szRelease )
	dw_4.SetItem ( 1, "suffix", iSuffix )
	dw_4.SetItem ( 1, "part_original", szPart )
	dw_4.SetItem ( 1, "stage_using_weight", f_get_staging_info ( iSalesOrder, szPart ) )
	dw_4.SetItem ( 1, "release_date", dDueDate )
	
	If f_get_order_info(iSalesOrder, "ORDER TYPE") = 'B' then
		dw_4.SetItem(1, "customer_part", f_get_order_info(iSalesOrder, "CUSTOMER PART"))	
	Else
		SELECT order_detail.group_no,
				 order_detail.notes  
		  INTO :ls_GroupNo,
				 :s_Notes
		  FROM order_detail  
		 WHERE ( order_detail.order_no = :iSalesOrder ) AND  
		       ( order_detail.part_number = :szPart ) and
				 ( IsNull ( suffix, 0 ) = IsNull ( :iSuffix, 0 ) )  ;

		If SQLCA.SQLCode = 0 Then
			dw_4.SetItem ( 1, "group_no", ls_GroupNo )
			If Trim ( s_Notes ) > " " then
				dw_4.SetItem ( 1, "note", s_Notes )
			End If
		End if
		dw_4.SetItem ( 1, "customer_part", wf_get_customer_part ( iSalesOrder, szPart ) )		
	End If


   SELECT part_customer.taxable  
     INTO :ls_Taxable  
     FROM destination,   
          part_customer  
    WHERE ( destination.customer = part_customer.customer ) and  
          ( ( destination.destination = :szDestination ) AND  
          ( part_customer.part = :szPart ) )   ;

	If SQLCA.SQLCode = 0 Then

		dw_4.SetItem ( 1, "taxable", ls_Taxable )

	End If

	If dw_4.Update() > 0 then
		commit;
		dw_3.Title = "Line Items for " + String(iShipper)
		dw_3.Retrieve(iShipper)
		updt_qty_assigned()
	Else
		rollback;
	End If	

End If

szNote	= ""

dw_3.Reset()

If bPartMode then
	wf_flag_current_dest(szPart, iDestRow)
	dw_2.Retrieve(szPart)	
Else
	wf_flag_current_dest(szDestination, iDestRow)
	dw_2.Retrieve(szDestination)
End If





end subroutine

public subroutine wf_adjust_grid (string szpart, long isalesorder);Long 		iRow
Boolean 	bFound

bFound	= FALSE
iRow		= 1

Do While (Not bFound) AND (iRow	<= dw_crosstab.RowCount())

	If (dw_crosstab.GetItemString(iRow, "part") = szPart) AND &
		(dw_crosstab.GetItemNumber(iRow, "Sales_Order") =	iSalesOrder) then
		bFound	= TRUE
	Else
		iRow ++
	End If
Loop

If (Not bFound) then
	dw_crosstab.InsertRow(1)
	dw_crosstab.SetItem(1, "part", szPart)
	dw_crosstab.SetItem(1, "sales_order", iSalesOrder)
	dw_crosstab.SetItem(1, "start_date", dDate1)
End If	
end subroutine

public subroutine wf_add_blanket_parts_to_crosstab ();Long		iRow
Long		iSalesOrder
String 	szPart

dw_parts_per_dest.Retrieve(szDestination)

For iRow	= 1 to dw_parts_per_dest.RowCount()
	iSalesOrder	= dw_parts_per_dest.GetItemNumber(iRow, "order_no")
	szPart		= dw_parts_per_dest.GetItemString(iRow, "blanket_part")
	wf_adjust_grid(szPart, iSalesOrder)
Next

dw_crosstab.SetSort("1a")
dw_crosstab.Sort()
end subroutine

public subroutine wf_save_releases ();Long 		l_l_Row
Long		l_l_Col			
Long 		l_i_SalesOrder

dwItemStatus	szStatus

Date		l_d_Date
Decimal	l_n_Qty

String 	l_s_Part

For l_l_Row	= 1 to dw_crosstab.RowCount()
	l_s_Part		= dw_crosstab.GetItemString(l_l_Row, "part")
	l_i_SalesOrder	= dw_crosstab.GetItemNumber(l_l_Row, "sales_order")

		// To Not allow update on Normal Order	

			SELECT	Order_header.Order_Type
			INTO		:szOrderType
			FROM		Order_Header
			WHERE		order_header.order_no = :l_i_SalesOrder;

			IF	szOrderType = "N"  THEN
				szStatus = dw_crosstab.GetItemStatus(l_l_Row,0,Primary!)
				IF szStatus = DataModified! THEN
					MessageBox (monsys.msg_title, "Cannot Add to a Normal Order")
					dw_crosstab.SetItemStatus(l_l_Row, l_l_Col,primary!,notmodified!)
				END IF
			Continue
			END IF
	
	If Not f_accum_control(l_i_SalesOrder) then //Only process NET
		For l_l_Col = 3 to 9 
		
			dw_crosstab.SetRow(l_l_Row)
			dw_crosstab.SetColumn(l_l_Col)
			l_n_Qty	= Dec(dw_crosstab.GetText())
			l_d_Date	= get_date(l_l_Col - 1) 
	
			If l_n_Qty > 0 then
				wf_update_release(l_i_SalesOrder, l_s_Part, l_d_Date, l_n_Qty)
			End If

		Next 

		OpenWithParm(w_recalc_release_in_blanket_order, l_i_SalesOrder)	
	End If
Next		

create_crosstab(szDestination, dDate7)
wf_add_blanket_parts_to_crosstab()
m_global_shipping_scheduler.m_file.m_savereleases.ToolbarItemVisible	= False

end subroutine

public subroutine wf_update_release (long isalesorder, string szpart, date ddate, decimal nqty);Long iRow
Long iSequence
integer	iseq

dw_qty_assigned.Retrieve(iSalesOrder , szPart)

SetNull(iRow)


SELECT order_header.shipping_unit  
INTO   :szShippingUnit  
FROM 	 order_header  
WHERE  order_header.order_no = :iSalesOrder ;
   
  
SELECT order_detail.Sequence  
INTO   :iSequence  
FROM 	 order_detail  
WHERE  ( order_detail.order_no = :iSalesOrder ) AND  
       ( order_detail.due_date = :dDate )   ;


If iSequence > 0 then		//Existing release
	iRow	 = dw_qty_assigned.Find("sequence = " + String(iSequence), 1, 99999)
	dw_qty_assigned.SetItem(iRow, "quantity", nQty)
	dw_qty_assigned.SetItem(1, "the_cum", nQty)
Else								//Brand new release
	dw_qty_assigned.InsertRow(1)
	dw_qty_assigned.SetItem(1, "order_no", iSalesOrder)
	dw_qty_assigned.SetItem(1, "part_number", szPart)
	dw_qty_assigned.SetItem(1,	"due_date", dDate)
	dw_qty_assigned.SetItem(1, "quantity", nQty)
	dw_qty_assigned.SetItem(1, "Unit", szShippingUnit)
	dw_qty_assigned.SetItem(1, "committed_qty", 0)
	dw_qty_assigned.SetItem(1, "the_cum", nQty)
	dw_qty_assigned.SetItem(1, "destination", szDestination)
	dw_qty_assigned.SetItem(1, "type", 'F')
	dw_qty_assigned.SetItem(1, "flag", 1)
	dw_qty_assigned.SetItem(1, "week_no", f_get_week_no(dDate))
	Randomize(0)
	dw_qty_assigned.SetItem(1, "row_id", Rand(37000))
	dw_qty_assigned.SetItem(1, "sequence", Rand(3700))
	dw_qty_assigned.SetItem(1, "ship_type", wf_get_ship_type(iSalesOrder))

End If

If dw_qty_assigned.Update() > 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public function decimal wf_our_cum (long isalesorder);Decimal nOurCum

  SELECT order_header.our_cum  
    INTO :nOurCum  
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

Return f_get_value(nOurCum)
end function

public function boolean wf_accum (long isalesorder);String szType

  SELECT order_header.artificial_cum  
    INTO :szType  
    FROM order_header  
   WHERE order_header.order_no = :iSalesOrder   ;

szType	= f_get_string_value(szType)

Return (szType = "A")
end function

public function string wf_get_salesman (long isalesorder);String szSalesman
String szOrderType

Decimal nUnitPrice

SELECT order_header.salesman,   
       order_header.alternate_price,   
       order_header.price_unit,
		 order_header.order_type
  INTO :szSalesman,   
       :nUnitPrice,   
       :szPriceUnit,
		 :szOrderType  
  FROM order_header 
 WHERE order_header.order_no = :iSalesOrder   ;

If szOrderType = 'B' then		//If this is a normal order
	nPrice	= nUnitPrice
Else
	nPrice	= nNormalPrice
End If

Return TRIM(szSalesman)
end function

public subroutine wf_get_scheduler ();Str_progress sParm
String szCurrentScheduler

Integer iTotalSchedulers
Integer iCount

SetMicroHelp("Fetching Scheduler List")

ddlb_2.Reset()

Select Count(Distinct Scheduler) 
Into :iTotalSchedulers 
from Destination;

If iTotalSchedulers > 0 then // check to see if there are schedulers in the system - mb
	
	Declare SchedulerCur Cursor for Select Distinct Scheduler From Destination Using sqlca;

	Open SchedulerCur;

	Fetch SchedulerCur into :szCurrentScheduler;

	iCount 		= 1
	sParm.Title = "Fetch Scheduler List"
	OpenWithParm(w_progress, sParm)

	Do while sqlca.sqlcode = 0
		w_progress.wf_progress(iCount / iTotalSchedulers, "Add Scheduler:" + szCurrentScheduler)
		ddlb_2.AddItem(szCurrentScheduler)
		Fetch SchedulerCur into :szCurrentScheduler;
		iCount ++
	Loop

	Close SchedulerCur;
	Close (w_progress)

End if

SetMicroHelp("Ready")
end subroutine

public function string wf_get_release (long isalesorder, date ddate);String szRelease

SELECT order_detail.release_no  
  INTO :szRelease  
  FROM order_detail  
 WHERE ( order_detail.order_no = :iSalesOrder ) AND  
       ( order_detail.due_date = :dDate )   ;

Return szRelease
end function

public subroutine wf_flag_current_dest (string szvalue, long irow);Long iCount

If bPartMode then
	If (Not bPastDue) then
		SELECT count(order_no)  
	  	INTO :iCount
	  	FROM order_detail  
	 	WHERE ( order_detail.part_number = :szValue ) AND  
	         ( order_detail.due_date 	<= :dDate7 ) AND  
	         ( order_detail.quantity 	> order_detail.committed_qty ) AND
				( order_detail.ship_type 	= 'N')  ;
	Else
		SELECT count(order_no)  
	  	INTO :iCount
	  	FROM order_detail  
	 	WHERE ( order_detail.part_number = :szValue ) AND  
	         ( order_detail.due_date 	< :dDate1 ) AND  
	         ( order_detail.quantity 	> order_detail.committed_qty )  AND
				( order_detail.ship_type 	= 'N')  ;
	End If

Else
	If (Not bPastDue) then
		SELECT count(order_no)  
  		INTO :iCount
	  	FROM order_detail  
	 	WHERE ( order_detail.destination = :szValue ) AND  
	         ( order_detail.due_date <= :dDate7 ) AND  
	         ( order_detail.quantity > order_detail.committed_qty ) AND
				( order_detail.ship_type = 'N');
	Else
		SELECT count(order_no)  
	  	INTO :iCount
	  	FROM  order_detail  
	 	WHERE ( order_detail.destination = :szValue ) AND  
	         ( order_detail.due_date 	< :dDate1 ) AND  
	         ( order_detail.quantity 	> order_detail.committed_qty ) AND
				( order_detail.ship_type	= 'N');
	End If

End If

If iCount > 0 then
	dw_dest.SetItem(iRow, "flag", 1)
Else
	dw_dest.SetItem(iRow, "flag", 0)
End If
end subroutine

public subroutine create_crosstab (string szvalue, date ddate);Integer iRow			//Current row# for dw_demand
Integer l_i_CrossTabRow	//Current row# for dw_crosstab
Integer l_i_CrossTabCol //Current col# for dw_crosstab
Integer iTotalRows  	//Total rows in dw_demand
Integer iDays			//The difference between current date and selected date
Boolean bCreateNew   //Whether to create new row
String  ls_TempString
Long	  ll_TempNumber1, &
		  ll_TempNumber2

Decimal l_n_Qty			//Current demand
Decimal ncommitted   //Qty committed

If bPartMode then
	szPart			= szValue
Else
	szDestination	= szValue
End If

dw_crosstab.Reset()
l_i_CrossTabRow = 0
dw_demand.Retrieve(szValue, dDate)

iTotalRows = dw_demand.RowCount()

For iRow = 1 to iTotalRows

	bCreateNew = FALSE

	iSuffix		= dw_demand.GetItemNumber(iRow, "suffix")
	szRelease	= dw_demand.GetItemString(iRow, "release_no")
	nPrice		= dw_demand.GetItemNumber(iRow, "price")

	If l_i_CrossTabRow = 0 then
		bCreateNew = TRUE
	Else		

		If (Not bPartMode) then
			szValue 	= dw_demand.GetItemString(iRow, "part_number") 
		Else
			szValue	= dw_demand.GetItemString(iRow, "destination")	
		End If
			
		ls_TempString = dw_crosstab.GetItemString(l_i_CrossTabRow, 1)
		If szValue <> ls_TempString then
			bCreateNew = TRUE
		Else 

			ll_TempNumber1 = dw_demand.GetItemNumber(iRow, "order_no")
			ll_TempNumber2 = dw_crosstab.GetItemNumber(l_i_CrossTabRow, "sales_order")
			If ll_TempNumber1 <> ll_TempNumber2 then
				bCreateNew = TRUE
			Else
				ll_TempNumber1 = f_get_value(dw_crosstab.GetItemNumber(l_i_CrossTabRow, "suffix"))
				If IsNull ( iSuffix, 0 ) <> ll_TempNumber1 then
					bCreateNew = TRUE
					If wf_check_type(dw_demand.GetItemNumber(iRow, "order_no")) Then
						bCreateNew = False
				   End If
				End If
			End If
		End If

	End If

	If bCreateNew then
		dw_crosstab.InsertRow(0)
		l_i_CrossTabRow = l_i_CrossTabRow + 1

		If bPartMode then	//Select destinations for part
			dw_crosstab.SetItem(l_i_CrossTabRow, 1, dw_demand.GetItemString(iRow, "destination"))
		Else
			dw_crosstab.SetItem(l_i_CrossTabRow, 1, dw_demand.GetItemString(iRow, "part_number"))
		End If

		dw_crosstab.SetItem(l_i_CrossTabRow, "sales_order", dw_demand.GetItemNumber(iRow, "order_no"))
		dw_crosstab.SetItem(l_i_CrossTabRow, "suffix", iSuffix)
		dw_crosstab.SetItem(l_i_CrossTabRow, "value1", szRelease)
		dw_crosstab.SetItem(l_i_CrossTabRow, "value2", String(nPrice))
		dw_crosstab.SetItem(l_i_CrossTabRow, "start_date", dDate1)
	End If

	iDays = DaysAfter(dDate, dw_demand.GetItemDate(iRow, "due_date"))

	If iDays < -6 then 	//Past due
		l_i_CrossTabCol = 2
	Else
		l_i_CrossTabCol = 9 + iDays
	End If

	l_n_Qty      = f_get_value(dw_crosstab.GetItemNumber(l_i_CrossTabRow, l_i_CrossTabCol))
	l_n_Qty      = l_n_Qty + dw_demand.GetItemNumber(iRow, "quantity") 
	ncommitted = dw_demand.GetItemNumber(iRow, "committed_qty")

	If Not isNull(ncommitted) then
		l_n_Qty = l_n_Qty - ncommitted
	End If

	dw_crosstab.SetItem(l_i_CrossTabRow, l_i_CrossTabCol, Long(String(l_n_Qty))) 

Next


end subroutine

public subroutine wf_get_product_line ();Str_progress sParm
String szCurrentLine

Integer iTotalProductLines
Integer iCount

ddlb_2.Reset()

SELECT count(product_line.id )  
  INTO :iTotalProductLines  
  FROM product_line  ;

Declare LineCur Cursor for Select Id From Product_line Using sqlca;

Open LineCur;

Fetch LineCur into :szCurrentLine;

iCount 		= 1
sParm.Title	= "Fetching Product Line"

OpenWithParm(w_progress, sParm)

Do while sqlca.sqlcode = 0
	w_progress.wf_progress(iCount / iTotalProductLines, "Add product line:" + szCurrentLine)
	ddlb_2.AddItem(szCurrentLine)
	Fetch LineCur into :szCurrentLine;
	iCount ++
Loop

Close LineCur;
Close (w_progress)
	
end subroutine

public subroutine wf_show_note (boolean bFlag);cb_note.visible		= bFlag
mle_note.visible		= bFlag
cb_note_save.visible	= bFlag
end subroutine

public function string wf_get_customer_part (long iorder, string szpart);String szCustomerPart

if isnull(isuffix) then 
	SELECT	order_detail.customer_part  
	INTO	:szCustomerPart  
	FROM	order_detail  
	WHERE	( order_detail.order_no = :iOrder ) AND  
		( order_detail.part_number = :szPart );
else
	SELECT	order_detail.customer_part  
	INTO	:szCustomerPart  
	FROM	order_detail  
	WHERE	( order_detail.order_no = :iOrder ) AND  
		( order_detail.part_number = :szPart ) AND
		( order_detail.suffix = :isuffix ) ;
end if 		

Return szCustomerPart
end function

public function string wf_get_ship_type (long iorder);String szShipType

Select order_header.ship_type  
  Into :szShipType  
  From order_header  
 Where order_header.order_no = :iOrder   ;

If IsNull(szShipType) or (szShipType = '') then
	szShipType	= "N"
End If

Return szShipType
end function

public function string wf_get_order_type (long iorder);String szOrderType

SELECT order_header.order_type  
  INTO :szOrderType  
  FROM order_header  
 WHERE order_header.order_no = :iOrder   ;

Return szOrderType
end function

public function boolean wf_reset_flag (long ishipper);UPDATE shipper  
   SET picklist_printed = 'N'  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public function string wf_get_note (long iorder, string szpart, long isuffix);String szNote

If iSuffix > 0 then
	Select order_detail.notes  
	  Into :szNote  
	  From order_detail  
	 Where ( order_detail.order_no 		= :iOrder  ) And  
	       ( order_detail.part_number 	= :szPart  ) And  
	       ( order_detail.suffix 			= :iSuffix );
Else
	Select order_detail.notes  
	  Into :szNote  
	  From order_detail  
	 Where ( order_detail.order_no 		= :iOrder  ) And  
	       ( order_detail.part_number 	= :szPart  ) And  





	       ( order_detail.suffix 			is Null );
End If

Return szNote
end function

public function string wf_strip_off_suffix (string szpart, long isuffix);Long iPos, iPos2

iPos	= PosA(szPart, "-" + String(iSuffix))
iPos2 = PosA ( szPart, "-" + String ( iSuffix ), iPos + 1 )
If iPos2 > 1 then
	szPart	= LeftA(szPart, iPos2 - 1)
ELSEIF iPos > 1 THEN
	szPart = LeftA ( szPart, iPos - 1 )
End If

Return szPart

end function

public subroutine wf_get_demands ();Str_progress	sParm				
Long 				iRow				

String			szDestination	
String			szPart			
String			szPrompt

SetMicroHelp("Fetching Demand List")

ddlb_2.Reset()

sParm.Title	= "Set up demand flags"
OpenWithParm(w_progress, sParm)
w_progress.cb_cancel.visible	= FALSE

dw_dest.DataObject	= "dw_destinations_per_demand"
dw_dest.SetTransObject(sqlca)
dw_dest.Retrieve()

For iRow = 1 to dw_dest.RowCount()
	If bPartMode then
		szPart		= dw_dest.GetItemString(iRow, "part")
		szPrompt		= "Checking part " + szPart
		wf_flag_current_dest(szPart, iRow)
	Else
		szDestination	= dw_dest.GetItemString(iRow, "destination")
		szPrompt		= "Checking destination " + szDestination
		wf_flag_current_dest(szDestination, iRow)
	End If

	w_progress.wf_progress(iRow / dw_dest.RowCount(), szPrompt )

Next	

dw_dest.SetFilter ( "flag = 1" )
dw_dest.Filter()

Close(w_progress)

SetMicroHelp("Ready")






	


end subroutine

public function boolean wf_check_type (integer orderno);String s_type

Select order_type
Into   :s_type
From   order_header
Where  order_no = :orderno ;

Return (s_type = 'B')
end function

public function decimal wf_on_hand (string szpart);Decimal nOnHand

  SELECT part_online.on_hand  
    INTO :nOnHand  
    FROM part_online  
   WHERE part_online.part = :szPart   ;

Return f_get_value(nOnHand)
end function

event open;call super::open;//************************************************************************
//* Declaration
//***********************************************************************
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)
dw_dest.SetTransObject(sqlca)
dw_demand.SetTransObject(sqlca)
dw_crosstab.SetTransObject(sqlca)
dw_qty_assigned.SetTransObject(sqlca)
dw_parts_per_dest.SetTransObject(sqlca)			//List of all parts per destination


//***********************************************************************
//* Main Routine
//***********************************************************************

dDate1 = today()
display_dates()			//Display all dates on screen
Timer(0.5)

ddlb_date_selection.text	= "Today"






end event

event activate;call super::activate;
m_global_shipping_scheduler.m_file.m_savereleases.ToolbarItemVisible = cbx_add.checked

end event

on w_global_shipping_version2.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_global_shipping_scheduler" then this.MenuID = create m_global_shipping_scheduler
this.st_um=create st_um
this.dw_range=create dw_range
this.cb_1=create cb_1
this.mle_selected=create mle_selected
this.dw_demand=create dw_demand
this.cbx_active_demand=create cbx_active_demand
this.st_16=create st_16
this.p_6=create p_6
this.st_10=create st_10
this.ddlb_date_selection=create ddlb_date_selection
this.st_detail_title=create st_detail_title
this.dw_3=create dw_3
this.st_list_by=create st_list_by
this.st_warning=create st_warning
this.st_accum=create st_accum
this.cbx_add=create cbx_add
this.dw_parts_per_dest=create dw_parts_per_dest
this.st_drag2=create st_drag2
this.ddlb_2=create ddlb_2
this.st_11=create st_11
this.p_2=create p_2
this.dw_qty_assigned=create dw_qty_assigned
this.dw_4=create dw_4
this.sle_search=create sle_search
this.dw_dest=create dw_dest
this.ddlb_1=create ddlb_1
this.cbx_past_due=create cbx_past_due
this.dw_2=create dw_2
this.dw_range_weights=create dw_range_weights
this.cb_note_save=create cb_note_save
this.mle_note=create mle_note
this.cb_note=create cb_note
this.mle_message=create mle_message
this.st_message=create st_message
this.st_drag=create st_drag
this.dw_crosstab=create dw_crosstab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_um
this.Control[iCurrent+2]=this.dw_range
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.mle_selected
this.Control[iCurrent+5]=this.dw_demand
this.Control[iCurrent+6]=this.cbx_active_demand
this.Control[iCurrent+7]=this.st_16
this.Control[iCurrent+8]=this.p_6
this.Control[iCurrent+9]=this.st_10
this.Control[iCurrent+10]=this.ddlb_date_selection
this.Control[iCurrent+11]=this.st_detail_title
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.st_list_by
this.Control[iCurrent+14]=this.st_warning
this.Control[iCurrent+15]=this.st_accum
this.Control[iCurrent+16]=this.cbx_add
this.Control[iCurrent+17]=this.dw_parts_per_dest
this.Control[iCurrent+18]=this.st_drag2
this.Control[iCurrent+19]=this.ddlb_2
this.Control[iCurrent+20]=this.st_11
this.Control[iCurrent+21]=this.p_2
this.Control[iCurrent+22]=this.dw_qty_assigned
this.Control[iCurrent+23]=this.dw_4
this.Control[iCurrent+24]=this.sle_search
this.Control[iCurrent+25]=this.dw_dest
this.Control[iCurrent+26]=this.ddlb_1
this.Control[iCurrent+27]=this.cbx_past_due
this.Control[iCurrent+28]=this.dw_2
this.Control[iCurrent+29]=this.dw_range_weights
this.Control[iCurrent+30]=this.cb_note_save
this.Control[iCurrent+31]=this.mle_note
this.Control[iCurrent+32]=this.cb_note
this.Control[iCurrent+33]=this.mle_message
this.Control[iCurrent+34]=this.st_message
this.Control[iCurrent+35]=this.st_drag
this.Control[iCurrent+36]=this.dw_crosstab
end on

on w_global_shipping_version2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_um)
destroy(this.dw_range)
destroy(this.cb_1)
destroy(this.mle_selected)
destroy(this.dw_demand)
destroy(this.cbx_active_demand)
destroy(this.st_16)
destroy(this.p_6)
destroy(this.st_10)
destroy(this.ddlb_date_selection)
destroy(this.st_detail_title)
destroy(this.dw_3)
destroy(this.st_list_by)
destroy(this.st_warning)
destroy(this.st_accum)
destroy(this.cbx_add)
destroy(this.dw_parts_per_dest)
destroy(this.st_drag2)
destroy(this.ddlb_2)
destroy(this.st_11)
destroy(this.p_2)
destroy(this.dw_qty_assigned)
destroy(this.dw_4)
destroy(this.sle_search)
destroy(this.dw_dest)
destroy(this.ddlb_1)
destroy(this.cbx_past_due)
destroy(this.dw_2)
destroy(this.dw_range_weights)
destroy(this.cb_note_save)
destroy(this.mle_note)
destroy(this.cb_note)
destroy(this.mle_message)
destroy(this.st_message)
destroy(this.st_drag)
destroy(this.dw_crosstab)
end on

type st_um from statictext within w_global_shipping_version2
boolean visible = false
integer x = 3118
integer y = 92
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type dw_range from datawindow within w_global_shipping_version2
boolean visible = false
integer x = 3035
integer y = 100
integer width = 731
integer height = 432
integer taborder = 70
string dataobject = "d_range"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_global_shipping_version2
boolean visible = false
integer x = 3785
integer y = 104
integer width = 247
integer height = 88
integer taborder = 180
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;LONG	l_l_print

l_l_print = PrintOpen ( "pb" )
mle_selected.Print ( l_l_print, 100, 100 )
PrintClose ( l_l_print )
end event

type mle_selected from multilineedit within w_global_shipping_version2
boolean visible = false
integer x = 2949
integer y = 60
integer width = 1061
integer height = 568
integer taborder = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 78682240
alignment alignment = right!
end type

event modified;//STRING	l_s_range, &
//			l_s_sub_range
//
//INTEGER	l_i_next
//
//LONG	l_l_begin_row, &
//		l_l_end_row, &
//		l_l_column
//
//dw_range.Reset ( )
//l_s_range = text
//
//DO
//	l_i_next = Pos ( l_s_range, ';' )
//	IF l_i_next > 0 THEN
//		l_s_sub_range = Left ( l_s_range, l_i_next - 1 )
//		l_s_range = Right ( l_s_range, Len ( l_s_range ) - l_i_next )
//	ELSE
//		l_s_sub_range = l_s_range
//		l_s_range = ""
//	END IF
//	l_i_next = Pos ( l_s_sub_range, '/' )
//	l_l_begin_row = Long ( Left ( l_s_sub_range, l_i_next - 1 ) )
//	l_s_sub_range = Right ( l_s_sub_range, Len ( l_s_sub_range ) - l_i_next )
//
//	l_i_next = Pos ( l_s_sub_range, '/' )
//	l_l_end_row = Long ( Left ( l_s_sub_range, l_i_next - 1 ) )
//	l_s_sub_range = Right ( l_s_sub_range, Len ( l_s_sub_range ) - l_i_next )
//
//	DO
//		l_i_next = Pos ( l_s_sub_range, '/' )
//		IF l_i_next > 0 THEN
//			l_l_column = Long ( dw_crosstab.Describe ( Left ( l_s_sub_range, l_i_next - 1 ) + ".ID" ) )
//			l_s_sub_range = Right ( l_s_sub_range, Len ( l_s_sub_range ) - l_i_next )
//		ELSE
//			l_l_column = Long ( dw_crosstab.Describe ( l_s_sub_range + ".ID" ) )
//			l_s_sub_range = ""
//		END IF
////		dw_range.InsertRow ( 1 )
////		dw_range.object.begin_row [ 1 ] = l_l_begin_row
////		dw_range.object.end_row [ 1 ] = l_l_end_row
////		dw_range.object.col [ 1 ] = l_l_column
//		dw_range.InsertRow ( 1 )
//		dw_range.object.begin_row [ 1 ] = l_l_begin_row
//		dw_range.object.end_row [ 1 ] = l_l_end_row
//		dw_range.object.col [ 1 ] = l_l_column
//	LOOP WHILE l_s_sub_range > ""
//
//LOOP WHILE l_s_range > ""
STRING	l_s_range, &
			l_s_sub_range

INTEGER	l_i_next

LONG	l_l_begin_row, &
		l_l_end_row, &
		l_l_row, &
		l_l_column

dw_range.Reset ( )
l_s_range = text

DO
	l_i_next = PosA ( l_s_range, ';' )
	IF l_i_next > 0 THEN
		l_s_sub_range = LeftA ( l_s_range, l_i_next - 1 )
		l_s_range = RightA ( l_s_range, LenA ( l_s_range ) - l_i_next )
	ELSE
		l_s_sub_range = l_s_range
		l_s_range = ""
	END IF
	l_i_next = PosA ( l_s_sub_range, '/' )
	l_l_begin_row = Long ( LeftA ( l_s_sub_range, l_i_next - 1 ) )
	l_s_sub_range = RightA ( l_s_sub_range, LenA ( l_s_sub_range ) - l_i_next )

	l_i_next = PosA ( l_s_sub_range, '/' )
	l_l_end_row = Long ( LeftA ( l_s_sub_range, l_i_next - 1 ) )
	l_s_sub_range = RightA ( l_s_sub_range, LenA ( l_s_sub_range ) - l_i_next )

	DO
		l_i_next = PosA ( l_s_sub_range, '/' )
		IF l_i_next > 0 THEN
			l_l_column = Long ( dw_crosstab.Describe ( LeftA ( l_s_sub_range, l_i_next - 1 ) + ".ID" ) )
			l_s_sub_range = RightA ( l_s_sub_range, LenA ( l_s_sub_range ) - l_i_next )
		ELSE
			l_l_column = Long ( dw_crosstab.Describe ( l_s_sub_range + ".ID" ) )
			l_s_sub_range = ""
		END IF
		IF l_l_begin_row < l_l_end_row THEN
			FOR l_l_row = l_l_begin_row TO l_l_end_row
				dw_range.InsertRow ( 1 )
				dw_range.object.range_row [ 1 ] = l_l_row
				dw_range.object.range_col [ 1 ] = l_l_column
			NEXT
		ELSE
			FOR l_l_row = l_l_end_row TO l_l_begin_row
				dw_range.InsertRow ( 1 )
				dw_range.object.range_row [ 1 ] = l_l_row
				dw_range.object.range_col [ 1 ] = l_l_column
			NEXT
		END IF
//		InsertRow ( 1 )
//		object.range_row [ 1 ] = l_l_end_row
//		object.range_col [ 1 ] = l_l_column
	LOOP WHILE l_s_sub_range > ""

LOOP WHILE l_s_range > ""
dw_range.Sort ( )
dw_range.GroupCalc ( )
//dw_range.Filter ( )
end event

event constructor;//i_ds_range = CREATE DataStore
//i_ds_range.DataObject = "d_range"
end event

type dw_demand from datawindow within w_global_shipping_version2
boolean visible = false
integer x = 27
integer y = 1628
integer width = 4325
integer height = 520
integer taborder = 10
string dataobject = "dw_select_demand"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cbx_active_demand from checkbox within w_global_shipping_version2
boolean visible = false
integer x = 603
integer y = 108
integer width = 475
integer height = 48
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Active Demand Only"
end type

on clicked;If this.checked then
	dw_dest.SetFilter("flag = 1")
Else
	dw_dest.SetFilter("flag >= 0")
End If

dw_dest.Filter()
end on

type st_16 from statictext within w_global_shipping_version2
integer x = 2597
integer y = 988
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Part Note"
boolean focusrectangle = false
end type

type p_6 from picture within w_global_shipping_version2
integer x = 2510
integer y = 988
integer width = 73
integer height = 60
string picturename = "noteyes.bmp"
boolean border = true
boolean focusrectangle = false
end type

event clicked;If iShipperDetailRow > 0 then
	mle_note.text	= dw_3.GetItemString(iShipperDetailRow, "note")
	wf_show_note(TRUE)
	mle_note.SetFocus()
Else
	MessageBox(monsys.msg_title, "Please click the shipper detail line item first", StopSign!)
End If
end event

type st_10 from statictext within w_global_shipping_version2
integer x = 2286
integer y = 892
integer width = 274
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Date Mode"
boolean focusrectangle = false
end type

type ddlb_date_selection from dropdownlistbox within w_global_shipping_version2
integer x = 2574
integer y = 884
integer width = 306
integer height = 252
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Today","Tomorrow","Release Date","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
borderstyle borderstyle = stylelowered!
end type

on losefocus;SetMicroHelp("Ready")
end on

on getfocus;SetMicroHelp("Select default shipper date mode")
end on

type st_detail_title from statictext within w_global_shipping_version2
integer x = 1769
integer y = 988
integer width = 695
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Detail Items for"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_global_shipping_version2
integer x = 1678
integer y = 1052
integer width = 1202
integer height = 380
integer taborder = 160
string dragicon = "DRAG1PG.ICO"
string dataobject = "dw_shipper_detail2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Boolean bChoiceable

Timer(0.5)

Parent.SetMicroHelp("Drag item for unschedule")

iShipperDetailRow = dw_3.GetClickedRow()
bProcessDetail		= FALSE

If iShipperDetailRow <=0 then
	Return
End If

If IsNull(dw_3.GetItemNumber(iShipperDetailRow, "Alternative_qty")) Or (dw_3.GetItemNumber(iShipperDetailRow, "Alternative_qty") = 0) then

	bProcessDetail	= TRUE

Else
	
	bProcessDetail	= FALSE

End If

bShipperDetail = TRUE

If dw_3.IsSelected(iShipperDetailRow) then
	dw_3.SelectRow(iShipperDetailRow, FALSE)
Else
	dw_3.SelectRow(0, FALSE )
	dw_3.SelectRow(iShipperDetailRow, TRUE)
End If

dw_3.Drag(begin!)


end event

on doubleclicked;iShipperDetailRow	= this.GetClickedRow()
mle_note.text	=""
If iShipperDetailRow > 0 then
	mle_note.text	= this.GetItemString(iShipperDetailRow, "note")
	wf_show_note(TRUE)
	mle_note.SetFocus()
End If

end on

event dragdrop;bShipperDetail				= FALSE
bProcessDetail				= FALSE

end event

type st_list_by from statictext within w_global_shipping_version2
integer x = 5
integer y = 188
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Dest"
boolean focusrectangle = false
end type

on clicked;sle_search.visible	= TRUE
sle_search.text		= ""
sle_search.SetFocus()
end on

type st_warning from statictext within w_global_shipping_version2
boolean visible = false
integer x = 805
integer y = 896
integer width = 613
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Data Entry only  for NET control"
boolean focusrectangle = false
end type

type st_accum from statictext within w_global_shipping_version2
boolean visible = false
integer x = 567
integer y = 896
integer width = 206
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Accum:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_add from checkbox within w_global_shipping_version2
boolean visible = false
integer y = 896
integer width = 503
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Add/Edit Release "
end type

event clicked;If bPartMode then
	MessageBox(monsys.msg_title, "Quick data entry is only for Dest Mode", StopSign!)
	this.checked		= FALSE
	Return
End If

m_global_shipping_scheduler.m_file.m_savereleases.ToolbarItemVisible	= this.checked
st_warning.Visible	= this.checked

If this.checked then
	wf_add_blanket_parts_to_crosstab()
End If


end event

type dw_parts_per_dest from datawindow within w_global_shipping_version2
boolean visible = false
integer x = 3840
integer y = 676
integer width = 494
integer height = 364
integer taborder = 200
string dataobject = "dw_list_of_all_blanket_parts_per_dest"
boolean livescroll = true
end type

type st_drag2 from statictext within w_global_shipping_version2
boolean visible = false
integer x = 1307
integer y = 540
integer width = 1065
integer height = 60
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_global_shipping_version2
boolean visible = false
integer x = 5
integer y = 96
integer width = 567
integer height = 384
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean allowedit = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;If Not bPartMode then		//If list by destination
	If ddlb_1.text = "Customer" then
		dw_dest.DataObject="dw_destinations_per_customer"
		dw_dest.SetTransObject(sqlca)
		this.text = TRIM ( LeftA ( this.text, 10 ) )
		dw_dest.Retrieve(this.text)
	End If 

	If ddlb_1.text	= "Plant" then
		dw_dest.DataObject	= "dw_destinations_per_plant"
		dw_dest.SetTransObject(sqlca)
		dw_dest.Retrieve(this.text)
	End If

	If ddlb_1.text	= "Scheduler" then
		dw_dest.DataObject	= "dw_destinations_per_scheduler"
		dw_dest.SetTransObject(sqlca)
		dw_dest.Retrieve(this.text)
	End If

Else
	If ddlb_1.text = "Product Line" then
		dw_dest.DataObject	= "dw_list_of_parts_per_product_line"
		dw_dest.SetTransObject(sqlca)
		dw_dest.Retrieve(this.text)
	End If
End If

wf_flag_destination()
end event

type st_11 from statictext within w_global_shipping_version2
integer x = 265
integer y = 188
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Demand"
boolean focusrectangle = false
end type

type p_2 from picture within w_global_shipping_version2
integer x = 192
integer y = 188
integer width = 78
integer height = 64
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type dw_qty_assigned from datawindow within w_global_shipping_version2
boolean visible = false
integer x = 352
integer y = 1184
integer width = 3771
integer height = 424
integer taborder = 190
string dataobject = "dw_updt_qty_assigned"
boolean livescroll = true
end type

type dw_4 from datawindow within w_global_shipping_version2
boolean visible = false
integer x = 3045
integer y = 680
integer width = 622
integer height = 448
integer taborder = 170
string dataobject = "dw_add_part_to_shipper_detail"
boolean livescroll = true
end type

type sle_search from singlelineedit within w_global_shipping_version2
boolean visible = false
integer y = 172
integer width = 462
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;Integer 	iRow

String	ls_Part
String	ls_Destination

If bPartMode then
	iRow	= dw_dest.Find("number = '" + this.text + "'", 1, 99999)
Else
	iRow	= dw_dest.Find("destination = '" + this.text + "'", 1, 99999)
End If

If iRow > 0 then
	dw_dest.ScrollToRow(iRow)
	dw_dest.SelectRow(0,  FALSE)
	dw_dest.SelectRow(iRow, TRUE)

	If bPartMode then
		ls_part			= dw_dest.GetItemString(iRow, "part")
		create_crosstab(ls_part, dDate7)		
		dw_2.Retrieve(ls_part)
		dw_3.Reset()		
	Else
		szDestination 	= dw_dest.GetItemString(iRow, "destination")
		create_crosstab(szDestination, dDate7)
		dw_2.Retrieve(szDestination)			//List all open shippers for the destination
		dw_3.Reset()
		If cbx_add.checked then
			wf_add_blanket_parts_to_crosstab()
		End If
	End If
End If

this.visible	= FALSE
end event

type dw_dest from datawindow within w_global_shipping_version2
event ue_unapproved_message ( )
integer x = 5
integer y = 244
integer width = 567
integer height = 632
integer taborder = 40
string dataobject = "dw_destinations"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_unapproved_message;MessageBox ( "Existing Order", "This destination's status is " + dw_dest.GetItemString ( dw_dest.GetRow ( ), "cs_status" ) + ".  You will be able to do everything except physically ship out the order.", Information! )

end event

event clicked;Integer iRow
String s_ShipDay
iRow = dw_dest.GetClickedRow()

iDestRow	= 0

If iRow > 0 then
	iDestRow	= iRow
	dw_dest.SelectRow(0,FALSE)
	dw_dest.SelectRow(iRow, TRUE)
	Parent.SetMicroHelp("Creating crosstab")

	If bPartMode then
		szPart = dw_dest.GetItemString(iRow, "part")
		create_crosstab(szPart, dDate7)		
		dw_2.Retrieve(szPart)
		dw_3.Reset()		
	Else
		szDestination 	= dw_dest.GetItemString(iRow, "destination")

		SELECT	destination_shipping.ship_day
		INTO		:s_ShipDay
		FROM		destination_shipping
		WHERE		destination_shipping.destination = :szdestination;

		IF	s_ShipDay = "AnyDay" OR IsNull(s_ShipDay) THEN
			ddlb_date_selection.SelectItem("Today",1)
		ELSEIF s_ShipDay = "Release" then
			ddlb_date_selection.SelectItem("Release Date",1)
		ELSE
			ddlb_date_selection.SelectItem(s_ShipDay,1)
		END IF

		create_crosstab(szDestination, dDate7)
		dw_2.Retrieve(szDestination)			//List all open shippers for the destination
		dw_3.Reset()
		If cbx_add.checked then
			wf_add_blanket_parts_to_crosstab()
		End If
		if GetItemString ( iRow, "status_type" ) <> 'A' then
			Post Event ue_unapproved_message ( )
		end if
	End If

End If	

Parent.SetMicroHelp("Ready")
end event

type ddlb_1 from dropdownlistbox within w_global_shipping_version2
integer width = 567
integer height = 384
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean vscrollbar = true
string item[] = {"All","Customer","Demand","Plant","Scheduler"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;bFirstTime	= FALSE
mle_message.visible	= FALSE
ddlb_1.backcolor		= ddlb_2.backcolor

dw_dest.Reset()

If this.text = "All" then
	ddlb_2.visible	= FALSE
	If (Not bPartMode) then
		dw_dest.DataObject	= "dw_destinations"
	Else
		dw_dest.DataObject	= "dw_list_of_parts_for_demand_search"
	End If
	dw_dest.SetTransObject(sqlca)
	dw_dest.Retrieve()

//	below 5 lines inc on 8/16/01
	bpastdue=false	
	cbx_active_demand.checked = false
	cbx_past_due.checked = false
	dw_dest.setfilter("")
	dw_dest.filter()
	
	wf_flag_destination()	//Flag destination for requirements

ElseIf this.Text = "Demand" Then

  	ddlb_2.visible	= FALSE
   cbx_active_demand.checked = True
	wf_get_demands()

Else

	ddlb_2.visible	= TRUE

	If Not bPartMode then			//List by destination
		If this.text = "Customer" then
			wf_get_customers()
		End If

		If this.text = "Plant" then
			wf_get_plants()
		End If

		If this.text = "Scheduler" then
			wf_get_scheduler()
		End If
 
	Else

		If this.text = "Product Line" then
			wf_get_product_line()
		End If		
	End If

End If

dw_dest.setfocus()

//
//If this.text <> "All" then
//	ddlb_2.visible	= TRUE
//
//	If Not bPartMode then			//List by destination
//		If this.text = "Customer" then
//			wf_get_customers()
//		End If
//
//		If this.text = "Plant" then
//			wf_get_plants()
//		End If
//
//		If this.text = "Scheduler" then
//			wf_get_scheduler()
//		End If
// 
//      If this.text = "Demands" then
//         wf_get_demands()
//      End If
//
//	Else
//
//		If this.text = "Product Line" then
//			wf_get_product_line()
//		End If		
//	End If
//
//Else
//
//	ddlb_2.visible	= FALSE
//	If (Not bPartMode) then
//		dw_dest.DataObject	= "dw_destinations"
//	Else
//		dw_dest.DataObject	= "dw_list_of_parts_for_demand_search"
//	End If
//	dw_dest.SetTransObject(sqlca)
//	dw_dest.Retrieve()
//	wf_flag_destination()	//Flag destination for requirements
//
//End If
end event

type cbx_past_due from checkbox within w_global_shipping_version2
boolean visible = false
integer x = 2469
integer y = 120
integer width = 439
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
string text = "Flag past due only"
end type

on losefocus;SetMicroHelp("Ready")
end on

event clicked;bPastDue	= this.checked

dw_dest.SetFilter("")
dw_dest.Filter()		

If dw_dest.RowCount() > 0 then
	wf_flag_destination()
End If

If cbx_past_due.Checked then
	dw_dest.SetFilter("flag = 1")
	dw_dest.Filter()		
End If

end event

on getfocus;SetMicroHelp("Set up flag to only flag past due demand")
end on

type dw_2 from datawindow within w_global_shipping_version2
integer x = 5
integer y = 888
integer width = 1664
integer height = 540
integer taborder = 130
string dataobject = "dw_open_shippers"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragdrop;char	lc_orderstatus

select	order_status
into	:lc_orderstatus
from	order_header
where	order_no = :isalesorder;

if isnull(lc_orderstatus,'A') = 'H' then
	messagebox(monsys.msg_title, "Sorry you can't proceed as order is on hold")
	Return
end if 	

If bCrossTab then		//Only process drop from crosstab
	bCrossTab = FALSE
   	OpenWithParm(w_check_same_destination_version2, szDestination, parent)
End If

SetMicroHelp("Ready")

end event

event clicked;dw_range_weights.Visible = FALSE
iShipperRow = row

If iShipperRow > 0 then
	iShipper	= dw_2.GetItemNumber(iShipperRow, "id")
	dw_2.SelectRow(0,FALSE)
	dw_2.SelectRow(iShipperRow, TRUE)
	st_detail_title.text = "Detail Items for " + String(dw_2.GetItemNumber(iShipperRow, "id"))
	dw_3.Retrieve(dw_2.GetItemNumber(iShipperRow, "id"))
End If
end event

on doubleclicked;Long iRow

iRow	= this.GetClickedRow()

SetMicroHelp("Update shipper header information")

If iRow > 0 then
	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)
	OpenWithParm ( w_shipper_header_info, this.GetItemNumber( iRow, "id"))
End If
SetMicroHelp("Ready")


end on

event dragenter;choose case source.ClassName ( )
	case "dw_crosstab"
		source.DragIcon = "AppRectangle!"
end choose

end event

event dragleave;choose case source.ClassName ( )
	case "dw_crosstab"
		source.DragIcon = "not.ico"
end choose

end event

type dw_range_weights from datawindow within w_global_shipping_version2
event hittest pbm_nchittest
boolean visible = false
integer x = 5
integer y = 892
integer width = 1664
integer height = 540
integer taborder = 150
boolean enabled = false
string dataobject = "d_range_weights"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;BringToTop = TRUE
end event

type cb_note_save from commandbutton within w_global_shipping_version2
boolean visible = false
integer x = 1870
integer y = 704
integer width = 247
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

on clicked;dw_3.SetItem(iShipperDetailRow, "note", mle_note.text)


If dw_3.Update() > 0 then
	Commit;
Else
	Rollback;
End If

wf_show_note(FALSE)
end on

type mle_note from multilineedit within w_global_shipping_version2
boolean visible = false
integer x = 1321
integer y = 232
integer width = 951
integer height = 364
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
end type

type cb_note from commandbutton within w_global_shipping_version2
boolean visible = false
integer x = 1061
integer y = 256
integer width = 1134
integer height = 604
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type mle_message from multilineedit within w_global_shipping_version2
integer x = 1216
integer y = 416
integer width = 1134
integer height = 224
integer taborder = 50
string dragicon = "AppRectangle!"
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "Please use dropdown list to make your selection."
alignment alignment = center!
end type

type st_message from statictext within w_global_shipping_version2
boolean visible = false
integer x = 1298
integer y = 112
integer width = 919
integer height = 64
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "Can not view detail for normal order"
boolean focusrectangle = false
end type

type st_drag from statictext within w_global_shipping_version2
boolean visible = false
integer x = 2926
integer y = 24
integer width = 1243
integer height = 372
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "This is for test only"
boolean border = true
boolean focusrectangle = false
end type

type dw_crosstab from u_dw_crosstab_gss within w_global_shipping_version2
integer x = 590
integer y = 4
integer width = 2290
integer height = 880
integer taborder = 100
string dragicon = "not.ico"
boolean bringtotop = true
boolean vscrollbar = true
end type

event doubleclicked;Timer(0)

If row > 0 then
	If Not bPartMode then
		szPart = dw_crosstab.GetItemString(row, 1)
	Else
		szDestination	= dw_crosstab.GetItemString(row, 1)
	End If
	iSalesOrder = dw_crosstab.GetItemNumber(row, "sales_order")
	If wf_get_order_type(iSalesOrder) = 'B' then
		Open(w_detail_info_of_demand)
	Else
		MessageBox(monsys.msg_title, "Cannot view detail information for normal order.", StopSign!)
	End If
End If
end event

event dragdrop;st_drag.visible			= FALSE
bCrosstab					= FALSE

If bShipperDetail then    //If come from shipper detail

	bShipperDetail	= FALSE

	If Not bProcessDetail then	//Check whether there is qty packed for item line
		MessageBox(monsys.msg_title, "You can not process staged line item", StopSign!)
		Return
	End If


	If dw_3.IsSelected(ishipperdetailrow) then
		szPart 		= dw_3.GetItemString(ishipperdetailrow,"part")
		nQty   		= dw_3.GetItemNumber(ishipperdetailrow, "qty_required")
		iSalesOrder = dw_3.GetItemNumber(ishipperdetailrow, "order_no")
		iSuffix		= dw_3.GetItemNumber(ishipperdetailrow, "suffix")

		If iSuffix > 0 then
			szPart	= wf_strip_off_suffix(szPart, iSuffix)
		End If

   	dw_3.DeleteRow(ishipperdetailrow)
		If dw_3.Update() > 0 then
			Commit;
		Else
			Rollback;
		End If
	End If

	If wf_reset_flag(iShipper) then
		Commit;
	Else
		MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
		Rollback;
	End If

	If bPartMode then
		Create_crosstab(szPart, dDate7)
	Else
		create_crosstab(szDestination, dDate7)
	End If

	dw_3.Retrieve(iShipper)

	If dw_3.RowCount() = 0 then  	//No more detail lines, then set shipper to be
											//status "empty"
		Update shipper  
     	Set status = 'E'  
   	Where id = :iShipper;

		If SQLCA.SQLCode = -1 then
			Rollback;
		Else
			Commit;
		End If


	End If
	
	bShipperDetail = FALSE


End If

If bPartMode then
	wf_flag_current_dest(szPart, iDestRow)
	dw_2.Retrieve(szPart)
Else
	wf_flag_current_dest(szDestination, iDestRow)
	dw_2.Retrieve(szDestination)				//Retrieve shipping dock information
End If

SetMicroHelp("Ready")
end event

event ue_range_change;LONG	l_l_row

INTEGER	l_i_count

STRING	l_s_part, &
			l_s_last_part
			
Date     l_d_date			

DataStore	l_ds_part_unit_weight
l_ds_part_unit_weight = CREATE DataStore
l_ds_part_unit_weight.DataObject = "d_part_unit_weight"
l_ds_part_unit_weight.SetTransObject ( SQLCA )
l_d_date=today()

dw_range_weights.Reset ( )
dw_range_weights.Visible = TRUE
i_ds_range.uf_import_range ( range )
FOR l_l_row = 1 TO i_ds_range.RowCount ( )
	IF i_ds_range.object.range_row [ l_l_row ] > 0 THEN
		IF bPartMode THEN
			l_s_part	= szPart
		ELSE
			l_s_part = dw_crosstab.object.data [ i_ds_range.object.range_row  [ l_l_row ], 1 ]
		END IF
		IF l_s_part <> l_s_last_part THEN
				nQty = 0
				FOR l_i_count = 2 TO i_ds_range.object.max_column  [ l_l_row ]
					IF NOT ( IsNull(dw_crosstab.object.data [ i_ds_range.object.range_row  [ l_l_row ], l_i_count ] ) ) THEN
						nQty = nQty + dw_crosstab.object.data [ i_ds_range.object.range_row  [ l_l_row ], l_i_count ]
					END IF
				NEXT
				dw_range_weights.InsertRow ( 1 )
				dw_range_weights.object.part [ 1 ] = l_s_part
				dw_range_weights.object.part_qty [ 1 ] = nQty
   			dw_range_weights.object.sales_order [ 1 ] = dw_crosstab.object.sales_order [ i_ds_range.object.range_row  [ l_l_row ]]				
				IF l_l_row = 1 THEN
					Choose Case i_ds_range.object.max_column [l_l_row]
						case 2
							  l_d_date=today()
						case 3
							  l_d_date=ddate1
						case 4
							  l_d_date=ddate2
						case 5
							  l_d_date=ddate3
						case 6	  
							  l_d_date=ddate4
						case 7	  
							  l_d_date=ddate5
						case 8	  
							  l_d_date=ddate6
						case 9	  
							  l_d_date=ddate7
					end choose  
				END IF 				
			   dw_range_weights.object.due_date [ 1 ] = l_d_date
				l_ds_part_unit_weight.Retrieve ( l_s_part )
				dw_range_weights.object.unit_weight [ 1 ] = l_ds_part_unit_weight.object.unit_weight [ 1 ]
			END IF
			l_s_last_part = l_s_part
		END IF
NEXT

dw_range_weights.InsertRow ( 1 )
dw_range_weights.DeleteRow ( 1 )
dw_range_weights.ScrollToRow ( dw_range_weights.RowCount ( ) )

DESTROY l_ds_part_unit_weight


end event

event ue_object_change;CONSTANT CHAR	c_CR = CharA (10)
STRING	l_s_note, &
	l_s_customer_part,&
	ls_customerpo
string	ls_due
INTEGER	l_i_column, &
	l_i_count, &
	l_i_current
BOOLEAN	l_b_present
string	ls_rel, ls_releases

l_i_column = newcolumn
iCrossTabCol = l_i_column
iCrossTabRow = newrow
st_message.visible	= FALSE
st_drag.text = ""
st_drag.visible	= FALSE

IF l_i_column > 9 THEN Return

IF newrow > 0 AND l_i_column > 1 THEN
	IF bPartMode THEN
		szDestination	= dw_crosstab.object.data [ newrow, 1 ]
	ELSE
		szPart = dw_crosstab.object.data [ newrow, 1 ]
	END IF
	
	nQty = 0
	dDueDate	= wf_get_date ( l_i_column )

	FOR l_i_count = 2 TO l_i_column
		IF NOT ( IsNull(dw_crosstab.object.data [ newrow, l_i_count ] ) ) THEN
			nQty = nQty + dw_crosstab.object.data [newrow, l_i_count ]
		END IF
	NEXT
	iSalesOrder 		= dw_crosstab.object.sales_order [ newrow ]
	//szRelease		= dw_crosstab.object.value1 [ newrow ]
	iSuffix			= dw_crosstab.object.suffix [ newrow ]
	nNormalPrice		= Dec ( dw_crosstab.object.value2 [ newrow ] )
	
	ls_due = string(dduedate,'mm-dd-yyyy')
	szrelease = ""
	
	select	release_no
	into	:szRelease
	from	cdivw_getreleaseno
	where	order_no = :isalesorder and
		due_date = :ls_due and
		part = :szpart;

	ls_releases = ''
	if l_i_column = 2 then 
		Declare relcur Cursor for 
		Select	release_no 
		from	cdivw_getreleases
		where	order_no = :isalesorder and
			due_date < :ls_due and
			part = :szpart;
		
		Open relcur;
		
		Fetch relcur into :ls_rel;
		
		Do while sqlca.sqlcode = 0
			if isnull(ls_releases,'') = '' then 
				ls_releases = ls_rel 
			else	
				ls_releases = ls_releases +', '+ ls_rel
			end if 	
			Fetch relcur into :ls_rel;
		Loop
		
		Close relcur;
	else
		Declare relcur1 Cursor for 
		Select	release_no 
		from	cdivw_getreleases
		where	order_no = :isalesorder and
			due_date = :ls_due and
			part = :szpart;
		
		Open relcur1;
		
		Fetch relcur1 into :ls_rel;
		
		Do while sqlca.sqlcode = 0
			if isnull(ls_releases,'') = '' then 
				ls_releases = ls_rel 
			else	
				ls_releases = ls_releases +', '+ ls_rel
			end if 	
			Fetch relcur1 into :ls_rel;
		Loop
		
		Close relcur1;
	end if
	
	SELECT	customer_part,
		customer_po,
		order_type
	INTO	:l_s_customer_part,
		:ls_customerpo,
		:szOrderType
	FROM	order_header
	WHERE	order_no = :iSalesOrder  ;

//	IF newcolumn > 5 THEN
//		st_drag.x				= X + PointerX () - 840
//	ELSE
//		st_drag.x				= X + PointerX () + 60
//	END IF
//	IF LONG ( dw_crosstab.object.DataWindow.FirstRowOnPage ) + 5  > newrow THEN
//		st_drag.y			= PointerY() + 60
//	ELSE
//		st_drag.y			= PointerY() - 310
//	END IF

	st_drag.visible	= TRUE
	
	SELECT	unit
	INTO	:i_s_unit
	FROM	order_detail
	WHERE	order_no = :iSalesOrder AND
		part_number = :szPart AND
		IsNull ( suffix, 0 ) = IsNull ( :iSuffix, 0 )  ;
		
	IF IsNull ( i_s_unit, "" ) = "" THEN
		i_s_unit = f_get_part_info ( szPart, "STANDARD UNIT" )
	END IF

	IF bPartMode THEN

		IF szOrdertype = 'B' THEN
			st_drag.text		=	"Destination:  " + szDestination + c_CR + &
										"OrderNo:  " + String ( iSalesOrder ) + c_CR + &
										"Customer Part:  " + IsNull ( l_s_customer_part, "" ) + "    UM:  " + i_s_unit + c_CR + &
										"Customer PO#:  " + IsNull ( ls_customerpo, '' ) + c_CR + &
										"On Hand Qty:  " + String ( Truncate( wf_on_hand ( szPart ), 0 ) ) + c_CR + &
										"Release:  " + IsNull ( szRelease, "" ) + c_CR + &
										"Multiple Releases:  " + IsNull ( ls_releases, "" )
		ELSE
			l_s_note				=	Trim ( IsNull ( wf_get_note ( iSalesOrder, szPart, iSuffix ), "" ) )
			st_drag.text		=	"Destination:  " + szDestination + c_CR + &
										"OrderNo:  " + String ( iSalesOrder ) + c_CR + &
										"Customer Part:  " + IsNull ( l_s_customer_part, "" ) + "    UM:  " + i_s_unit + c_CR + &
										"Customer PO#:  " + IsNull ( ls_customerpo, '' ) + c_CR + &
										"On Hand Qty:  " + String ( Truncate(wf_on_hand(szPart), 0)) + c_CR + &
										"Suffix:  " + IsNull ( String ( iSuffix ), "" ) + c_CR + &
										"Note:  " + l_s_note
		END IF
	ELSE
		IF szOrderType = 'B' THEN
			st_drag.text		=	"Part:  " + szPart + c_CR + &
										"OrderNo:  " + String ( iSalesOrder ) + c_CR + &
										"Customer Part:  " + IsNull ( l_s_customer_part, "" ) + "    UM:  " + i_s_unit + c_CR + &
										"Customer PO#:  " + IsNull ( ls_customerpo, '' ) + c_CR + &
										"Release:  " + IsNull ( szRelease, "" ) + c_CR + &
										"Multiple Releases:  " + IsNull ( ls_releases, "" )+ c_CR + &
										"On Hand Qty:  " + String ( Truncate ( wf_on_hand ( szPart ), 0 ) )
		ELSE
			l_s_note				=	Trim ( IsNull ( wf_get_note ( iSalesOrder, szPart, iSuffix ), "" ) )
			st_drag.text		=	"Destination:  " + szDestination + c_CR + &
										"OrderNo:  " + String ( iSalesOrder ) + c_CR + &
										"Customer Part:  " + IsNull ( l_s_customer_part, "" ) + "    UM:  " + i_s_unit + c_CR + &
										"Customer PO#:  " + IsNull ( ls_customerpo, '' ) + c_CR + &
										"On Hand Qty:  " + String ( Truncate ( wf_on_hand ( szPart ), 0 ) ) + c_CR + &
										"Suffix:  " + IsNull ( String ( iSuffix ), "" ) + c_CR + &
										"Note:  " + l_s_note
		END IF
	END IF
	st_drag.visible = TRUE
	st_accum.visible	= wf_accum ( iSalesOrder )

	bCrossTab = TRUE
	Parent.SetMicroHelp ( "Drag an order to the shipping dock to schedule" )

END IF
end event

event dragwithin;call super::dragwithin;st_drag.visible	= FALSE
end event

event constructor;i_ds_range = CREATE u_ds_range
i_ds_range.uf_set_source ( DataObject )
end event

event destructor;call super::destructor;DESTROY i_ds_range
end event

event itemchanged;Long l_i_Salesorder

l_i_SalesOrder	= dw_crosstab.GetItemNumber(row, "sales_order")

// To Not allow update on Normal Order	

SELECT	Order_header.Order_Type
INTO		:szOrderType
FROM		Order_Header
WHERE		order_header.order_no = :l_i_SalesOrder;

IF	szOrderType = "N"  THEN
 	MessageBox (monsys.msg_title, "Cannot add releases to a Normal Order!")
   RETURN 2
END IF

m_global_shipping_scheduler.m_file.m_savereleases.ToolbarItemVisible	= TRUE

end event


$PBExportHeader$w_visual_receiving_dock_version2.srw
forward
global type w_visual_receiving_dock_version2 from w_sheet_4t
end type
type dw_vendors from datawindow within w_visual_receiving_dock_version2
end type
type dw_release_display from datawindow within w_visual_receiving_dock_version2
end type
type cbx_line_item from checkbox within w_visual_receiving_dock_version2
end type
type st_po_plant from statictext within w_visual_receiving_dock_version2
end type
type st_5 from statictext within w_visual_receiving_dock_version2
end type
type cbx_retrieve from checkbox within w_visual_receiving_dock_version2
end type
type dw_objects from datawindow within w_visual_receiving_dock_version2
end type
type dw_objects_on_pallet from datawindow within w_visual_receiving_dock_version2
end type
type sle_pallet from singlelineedit within w_visual_receiving_dock_version2
end type
type sle_shipper from singlelineedit within w_visual_receiving_dock_version2
end type
type st_4 from statictext within w_visual_receiving_dock_version2
end type
type st_3 from statictext within w_visual_receiving_dock_version2
end type
type sle_password from singlelineedit within w_visual_receiving_dock_version2
end type
type p_pallet from picture within w_visual_receiving_dock_version2
end type
type st_2 from statictext within w_visual_receiving_dock_version2
end type
type sle_po from singlelineedit within w_visual_receiving_dock_version2
end type
type st_1 from statictext within w_visual_receiving_dock_version2
end type
type cbx_pallet from checkbox within w_visual_receiving_dock_version2
end type
type gb_2 from groupbox within w_visual_receiving_dock_version2
end type
type gb_pallet from groupbox within w_visual_receiving_dock_version2
end type
type gb_po from groupbox within w_visual_receiving_dock_version2
end type
type dw_pallet_object_info from datawindow within w_visual_receiving_dock_version2
end type
type gb_5 from groupbox within w_visual_receiving_dock_version2
end type
type dw_range_weights from datawindow within w_visual_receiving_dock_version2
end type
type dw_active_po_per_vendor from datawindow within w_visual_receiving_dock_version2
end type
type st_part from statictext within w_visual_receiving_dock_version2
end type
type dw_recvd_objects from datawindow within w_visual_receiving_dock_version2
end type
type gb_7 from groupbox within w_visual_receiving_dock_version2
end type
type dw_crosstab from u_dw_crosstab_gss within w_visual_receiving_dock_version2
end type
type gb_3 from groupbox within w_visual_receiving_dock_version2
end type
type st_object_array from structure within w_visual_receiving_dock_version2
end type
end forward

type st_object_array from structure
	double		serial
	double		row
	decimal {6}	qty
	string		um
	string		part
	decimal {6}	price
	string		project
	string		gl_account
	string		part_name
	string		object_type
end type

global type w_visual_receiving_dock_version2 from w_sheet_4t
integer x = 0
integer y = 0
integer width = 2958
integer height = 1552
string title = "Quick Receiving Dock"
string menuname = "m_receiving_dock"
long backcolor = 77897888
event inquiry pbm_custom01
event new_pallet pbm_custom02
event exit_screen pbm_custom03
event reset_focus pbm_custom04
event ue_quick_receive pbm_custom05
event ue_scan ( ref n_cst_associative_array auo_items )
event ue_close_uo_scan pbm_custom07
event ue_receive ( )
event ue_show_grid ( )
event ue_recv_popup ( )
event ue_reverse_receipt ( )
event ue_receivetrans ( )
dw_vendors dw_vendors
dw_release_display dw_release_display
cbx_line_item cbx_line_item
st_po_plant st_po_plant
st_5 st_5
cbx_retrieve cbx_retrieve
dw_objects dw_objects
dw_objects_on_pallet dw_objects_on_pallet
sle_pallet sle_pallet
sle_shipper sle_shipper
st_4 st_4
st_3 st_3
sle_password sle_password
p_pallet p_pallet
st_2 st_2
sle_po sle_po
st_1 st_1
cbx_pallet cbx_pallet
gb_2 gb_2
gb_pallet gb_pallet
gb_po gb_po
dw_pallet_object_info dw_pallet_object_info
gb_5 gb_5
dw_range_weights dw_range_weights
dw_active_po_per_vendor dw_active_po_per_vendor
st_part st_part
dw_recvd_objects dw_recvd_objects
gb_7 gb_7
dw_crosstab dw_crosstab
gb_3 gb_3
end type
global w_visual_receiving_dock_version2 w_visual_receiving_dock_version2

type prototypes

end prototypes

type variables
SingleLineEdit sDoor[4,2]

Picture pWarehouse[]

Boolean bDoorOpen[]
Boolean bPalletMode = false
Boolean bDragObject  	//Drag from pallet
Boolean bDragPO       	//Drag from po detail
Boolean bDragList      	//Drag from audi trail
Boolean bRecalc        	//Recalc the smart po grid
Boolean bReoccuringItem  	//Whether this is a reoccuring item
Boolean bfromMRD	
Boolean bRightPassword = false
Boolean bDetailInfo = false
Boolean bScanexternal = false //Scan external serial
Boolean ib_Trash = false //Whether delete event is occurring
Boolean	ib_line_item_selected,&
	ib_close_release
boolean  ib_check_location=false
boolean  i_b_shipper_required
boolean	ib_dropshippart

Long i_l_objarray[]
Long iDoorWidth 
Long iPO                   //Current PO number
Long iPallet    = 0       //Current pallet serial number
Long iPalletRow        //Current pallet row number
Long iPalletCol          //Current pallet col number
Long iObjectsProcessed
Long itotalBoxes       //total number of boxes generated
Long iPartRow           //Part number row
Long iObjectRow        //Object row
Long iObjectsOnPallet //total # of objects on pallet
Long itotalObjDel       //total # of objects to delete
Long iRelease	    //Release Number
Long  iSerial
Long il_row_id, &
         iCrosstabCol, &
         iCrosstabRow, &
         i_l_release_row_line_item
String szVendor          //Current vendor code
String szPart              //Current part number
String szUM               //Current unit of measure
String szLocationto    //Location code
String szLocationfrom //Location from code
String szPlant             //Plant code
String szLot                //Lot number
String szPartClass       //Part class code
String szCustom1        //Custom label1
String szCustom2        //Custom label2
String szCustom3        //Custom label3
String szCustom4        //Custom label4
String szCustom5        //Custom label5
String szShipper         //Shipper number
String is_Operator        //Operator
String szStatus           //Status for the object
String szPONumber     //PO number
String szPOUnit          //Unit in PO
String szQA                //Quantity alert
String szPalletLocation //Location for pallet
String szRecalc           //Whether to recalc po screen
String szControlNumber//to keep the Project # / Requisition_number #
String szGLAccount     //to keep the GL account code
String szPartName	     //to keep the part name	
String szProject           //to keep the project number
String sznotes          // to keep notes field
String i_s_Destination  //to keep the destination	
string is_UserStatus
string is_line_item_part
String is_package_type

Date   dDate              //Date
Date   dFirstPODate    //First PO date

Decimal 	   nQty 		//Quantity of object
Decimal {6} nUnitPrice 	//Unit Price 6 Decimal Places to prevent rounding KAZ
Decimal {6} nCost 		//Unit cost for object 6 Decimal Places to prevent rounding KAZ
Decimal      nStdQty		 //Std quantity
Decimal      nWeight 	//Weight for the object
Decimal {6} nTotalQty

Time        tTime

Private:
st_object_array stDelObj[] 

st_drag_array    i_st_drag_array[]

DataWindowChild dwUM
DataWindowChild dwcPack
DataWindowChild iwChild

str_progress stParm
st_generic_structure sParm

u_ds_range     i_ds_range

end variables

forward prototypes
public subroutine wf_delay (integer iUnit)
public subroutine wf_open_door (int iwarehouseno)
public subroutine wf_close_door (int iwarehouseno)
public subroutine wf_get_vendors ()
public subroutine wf_enable_screen (boolean bflag)
public subroutine wf_create_obj_array ()
public subroutine wf_auto_display_info ()
public subroutine wf_line_item ()
public function boolean wf_reverse_rec_event (string as_um, string as_part, decimal adec_qty)
public function boolean wf_reverse_line_item (string as_um, string as_part, decimal adec_qty)
public function string wf_location (string arg_spart)
public subroutine wf_add_object_to_pallet (long aiserial)
public function boolean wf_update_po_history (long a_l_po, string a_s_part, decimal a_n_qty, string a_s_um)
public function boolean wf_update_po (string a_s_um, string a_s_pounit, string a_s_part, decimal a_n_qty)
public subroutine wf_get_values_op_part (long a_l_serial, string a_s_part)
public function boolean wf_create_object (long aiserial)
public subroutine wf_draw_objects_on_pallet (long a_l_pallet)
public function string wf_get_active_vendor (long a_l_po)
public function boolean wf_have_requirement (long a_l_po, string a_s_part)
public function long wf_get_active_po (string a_s_vendor)
public subroutine wf_create_pallet (long a_l_palletserial, string a_s_location, date a_d_date, string a_s_operator)
public function string wf_get_plant (string a_s_location)
public function boolean wf_same_location (string a_s_location)
public function long wf_get_po_number (long a_l_serial)
public function boolean wf_create_audit_trail (long a_l_serial)
public function decimal wf_get_qty (long a_l_serial)
public function string wf_get_um (long a_l_serial)
public function string wf_get_part_name (long a_l_po, string a_s_part)
public function string wf_get_part (long a_l_serial)
public function string wf_get_status (long a_l_serial)
public function decimal wf_get_price (long a_l_serial)
public subroutine wf_get_audit_trail_info (long a_l_serial)
public function string wf_get_po_plant_code (long a_l_po)
public function boolean wf_delete_po_detail (long a_l_po, string a_s_part)
public function boolean wf_create_release (long a_l_po, string a_s_part, string a_s_partname, decimal a_n_qty, date a_d_date, decimal a_n_price, string a_s_project, string a_s_glaccount)
public function boolean wf_undo_history (long a_l_po, string a_s_part, decimal a_n_qty, string a_s_um)
public function boolean wf_check_for_notes (long a_l_po, string a_s_part)
public function date wf_get_po_due_date (string a_s_part)
public function boolean wf_recreate_release (long al_row_id, string as_part)
public function boolean wf_recalc_line_item (long a_i_ponumber, string a_s_part, long a_i_row_id, decimal a_n_dec_qty, string a_s_um)
public function boolean wf_recalc_line_item_op_part (long a_i_ponumber, string a_s_part, long a_i_row_id, decimal a_n_dec_qty, string a_s_um)
public subroutine wf_shipper_required ()
public function boolean wf_get_values (long a_l_partrow)
public function boolean wf_create_object_custom (long al_serial, decimal a_n_qty, decimal a_n_net_weight, decimal a_n_tare_weight, string a_s_package, string a_s_unit)
public function boolean wf_update_line_item_po_history (long a_l_po, string a_s_part, decimal a_n_qty, string a_s_um, long a_l_row_id)
public function boolean wf_outside_serial (long a_l_serial)
public function boolean wf_create_op_audit_trail (long a_l_serial)
public function integer wf_update_part_vendor (string as_part, string as_vendor, string as_um, decimal adec_quantity)
end prototypes

event inquiry;opensheet ( w_receiving_dock_inquiry, gnv_App.of_GetFrame(), 0, Original! )


end event

event new_pallet;/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iPallet' (next Serial number).  */

//bFinish	= false																											-  CHG 01-26-2000 KAZ
//
//// get the new serial number for pallet																				-  CHG 01-26-2000 KAZ
////iPallet		= f_next_parm_value ( "SERIAL", true )																-  CHG 01-26-2000 KAZ
//OpenWithParm ( w_get_parm_value, "next_serial" ) 																-  CHG 01-26-2000 KAZ
//
//iPallet = Message.DoubleParm																							-  CHG 01-26-2000 KAZ
//
//// create the new pallet object																						-  CHG 01-26-2000 KAZ
//if iPallet 	= 0 then																										-  CHG 01-26-2000 KAZ
//	MessageBox(monsys.msg_title, "Cannot get a new pallet serial#, Please try again!", StopSign!)

/* Create the new pallet object */

if not sqlca.of_getnextparmvalue ( "next_serial", iPallet ) then  // Failed to get next serial 		-  ADD 01-26-2000 KAZ
	Rollback;																													// ADD 01-26-2000 KAZ		
	MessageBox(monsys.msg_title, "Cannot get a new pallet serial#, Please try again!", StopSign!)	// ADD 01-26-2000 KAZ
	Return																														// ADD 01-26-2000 KAZ
else
	dw_objects.Reset()
	sle_pallet.text	= String(iPallet)
	wf_create_pallet(iPallet, '', today(), sle_password.text)
end if


end event

event exit_screen;if not bfromMRD then
	close ( w_visual_receiving_dock_version2 )
else
	close ( w_receiving_mdi_screen ) 
end if
end event

event ue_quick_receive;n_cst_associative_array	luo_items

if i_b_shipper_required then
	if ISNULL( sle_shipper.text ) OR sle_shipper.text = '' then
		MESSAGEBOX ( monsys.msg_title, "You must enter a valid shipper number!", StopSign!) 
		sle_shipper.Setfocus()
		return
	end if
end if

//if cbx_line_item.checked then						// ZZ
//	dw_release_display.Visible = true				// ZZ
//	dw_release_display.enabled = true				// ZZ
//	dw_release_display.SetTabOrder(1,150)			// ZZ
//end if														// ZZ

bScanexternal	= true

Open ( w_scan_outserial )
luo_items = Message.PowerObjectParm

if isnull ( String ( luo_items.of_getitem ( "canceled" ) ), '' ) = '' then
	Event ue_scan ( luo_items ) 
end if

end event

event ue_scan;/* 04-07-2000 KAZ Modified to populate unit of measure DDDW in outside process window.
						Issue # 13328. */
/* 03-22-2000 KAZ Added check of line-item or accum release control for PO detail history.  */

/* Declaration */
LONG		li_Row, &				
			li_Serial

DEC			ldec_accum_rec,&
			ldec_accum_ship, &
			ld_quantity, &
			ld_net_weight, &
			ld_tare_weight
dec			ldec_stdqty

st_generic_structure lstParm

BOOLEAN 	lb_Ok				

string	ls_destvendor
String 	l_s_SQLErrorText																							// ADD 03-09-2000 KAZ

if not bscanexternal then return

/* Initilization */
li_Serial			= long ( auo_items.of_getitem ( "serial" ) )
ld_net_weight 		= dec ( auo_items.of_getitem ( "net_weight" ) )
ld_tare_weight 	= dec ( auo_items.of_getitem ( "tare_weight" ) )
nQty 					= dec ( auo_items.of_getitem ( "quantity" ) )
ntotalqty			= dec ( auo_items.of_getitem ( "quantity" ) )										// ADD 04-11-2000 KAZ
szPart				= String ( auo_items.of_getitem ( "part" ) )
szum					= String ( auo_items.of_getitem ( "unit_measure" ) )								// ADD 04-07-2000 KAZ

szlot					= String ( auo_items.of_getitem ( "lot" ) )
szcustom1			= String ( auo_items.of_getitem ( "custom1" ) )
szcustom2			= String ( auo_items.of_getitem ( "custom2" ) )
szcustom3			= String ( auo_items.of_getitem ( "custom3" ) )
szcustom4			= String ( auo_items.of_getitem ( "custom4" ) )
szcustom5			= String ( auo_items.of_getitem ( "custom5" ) )
If cbx_line_item.checked then																						// ZZ
	il_row_id		= Dec ( auo_items.of_getitem ( "row_id" ) )											// ZZ
End If																													// ZZ

// included this argument and initialization from the user object
szLocationto		= String ( auo_items.of_getitem ( "location" ) )

// check if part is present on po_detail
li_Row		= dw_crosstab.Find ("part = '" + Trim(szPart) + "'" , 1, 99999)

if li_Row <= 0 then
	MessageBox(monsys.msg_title, "Part:" + szPart + " is not found in list.", StopSign!)
	return
end if

select	vendor
into		:ls_destvendor 
from		destination
where		destination = :i_s_destination ;

if ls_destvendor <> szVendor then
	MessageBox(monsys.msg_title, "Object " + String(li_Serial) + &
	" is not at vendor " + szVendor + " for outside process.", StopSign!)
	return
end if

// get values of the po release for the line item receiving part

// Modify for new DataWindow!!!-------------

if cbx_line_item.checked then
//	if not dw_release_display.Visible then dw_release_display.Visible = true
	if	dw_release_display.Visible then dw_release_display.Visible = false
//	if dw_release_display.GetselectedRow ( 0 ) <= 0 then
	dw_release_display.retrieve ( ipo, szPart )
//		MESSAGEBOX ( monsys.msg_title, "You must select a release against which you would like to receive the object!" )
//		dw_release_display.SetFocus()
//		return
//	else
//		dw_release_display.Visible = false
//	end if
end if

// get values for the part
wf_get_values_op_part ( li_serial, szPart ) 

//lb_OK	= wf_update_po_history(iPO, szPart, nQty, szUM) 									-  CHG 03-22-2000 KAZ

// Line item receiving or accum?..																	// ADD 03-22-2000 KAZ
If cbx_line_item.Checked then																			// ADD 03-22-2000 KAZ
	lb_OK = wf_update_line_item_po_history ( iPO, szPart, nQty, szUM, il_row_id ) 	// ADD 03-22-2000 KAZ
Else																											// ADD 03-22-2000 KAZ
	lb_OK	= wf_update_po_history ( iPO, szPart, nQty, szUM ) 								// ADD 03-22-2000 KAZ
End If																										// ADD 03-22-2000 KAZ
	
if not lb_Ok then MessageBox ( monsys.msg_title, "Update PO History has Failed!", Information! )

if lb_OK then		

	//Modified to Call Custom Version Of wf_create_object 
	lb_OK 		= wf_create_object_custom( li_Serial, nQty, ld_net_weight, ld_tare_weight, String ( auo_items.of_getitem ( "package_type" ) ), szUm )	

if not lb_Ok then MessageBox ( monsys.msg_title, "Create Object Custom has Failed!", Information! )

	if lb_Ok then
		wf_create_op_audit_trail(li_Serial) 														// CHG 04-03-2000 KAZ
	end if

				if not lb_Ok then MessageBox ( monsys.msg_title, "Audit Trail has Failed!", Information! )
				
	if lb_Ok then

		lb_Ok = ( wf_update_part_vendor ( szpart, szvendor, szum, nQty ) = 0 )

		if lb_ok and bPalletMode then
			w_progress.wf_progress(iObjectsProcessed / itotalBoxes, "Add Object " + String(iSerial) + " to pallet")
			wf_add_object_to_pallet(iSerial)
		end if
	
		if lb_Ok then
			Commit;
			lstParm.value1 = String(li_Serial)
			f_print_label(lstParm)
		else
			l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 03-09-2000 KAZ
			Rollback;																									// CHG 03-09-2000 KAZ
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 03-09-2000 KAZ
		end if

		if cbx_line_item.checked then
			lb_OK = wf_recalc_line_item_op_part ( iPO, szPart, il_row_id, nQty, szUM )
			if dw_release_display.getselectedrow ( 0 ) > 0 then &
				dw_release_display.selectrow ( 0, false )
		end if
	
		if lb_Ok then
			If Not cbx_line_item.checked then
				if breoccuringitem then		//if this is a reoccuring item
					bNoCommit	= false
					lb_OK		= f_recalc_po_detail_per_part(iPO, szPart, w_visual_receiving_dock_version2)
					bNoCommit	= true
				else								//if this is a non-reoccuring item
					lb_OK		= wf_delete_po_detail(iPO, szPart)		
				end if
			End If
		end if

		if lb_Ok then
			Commit;
		else
			l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 03-09-2000 KAZ
			Rollback;																									// CHG 03-09-2000 KAZ
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 03-09-2000 KAZ
//			MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)									-  CHG 03-09-2000 KAZ
		end if	

	end if

end if

if bRecalc then
	w_smart_po.wf_retrieve_vendor_parts()
	if w_smart_po.bVendorMode then
		w_smart_po.wf_build_crosstab()
	else
		w_smart_po.wf_build_crosstab_in_part_mode()
	end if
end if

if not IsNull(iPO) then
//	sle_shipper.text = ''
	dw_crosstab.Reset ( )
	dw_crosstab.Retrieve ( iPO, datetime ( today() ) )
end if
	
if lb_Ok then
	MessageBox ( monsys.msg_title, "Serial " + String(li_Serial) + " has been succesfully received!", Information! )	// ADD 04-10-2000 KAZ
end if		
	
SetMicroHelp ( "Ready" )												// ADD 04-10-2000 KAZ

end event

event ue_close_uo_scan;bScanexternal	= false

// close the release datawindow and user object
if dw_release_display.visible then dw_release_display.visible = false

end event

event ue_receive;//	Declarations
LONG	l_i_Row, &
	l_i_count, &
	l_i_labelarray[]
POINTER	pOldPointer
INTEGER	l_i_Boxes, &
	l_i_totalLabels
BOOLEAN	l_b_OK
STRING	l_s_POPlant, &
	l_s_LocationPlant
String 	l_s_SQLErrorText																// ADD 01-19-2000 KAZ
DEC	l_n_rowid, &
	l_n_TotalQty
st_generic_structure stParm2

//	Validate password
if LenA(trim(sle_password.text)) = 0 then
	Messagebox ( monsys.msg_title, "Invalid Operator Password, Please enter that and then proceed further")
	Return
end if 	

//	Check if the object is received against a pallet
if bPalletMode and (iPallet = 0) then
	MessageBox(monsys.msg_title, "Pallet number can not be NULL", StopSign!)
	bDragPO		= false
	bDragObject	= false
	return
end if

bDragPO		= false
bDragObject	= false

//	Check if the location is the correct one
if bPalletMode then 
	if MessageBox(monsys.msg_title, "You are trying to receive to a location that is in a different plant than the purchase order specifies. Do you still want to continue?", Question!, YesNo!) = 2 then
		return
	end if
end if

l_s_POPlant	= f_get_string_value(st_po_plant.text)
l_n_TotalQty	= 0																									// ADD 04-11-2000 KAZ
itotalBoxes	= 0																									// ADD 04-11-2000 KAZ
l_i_count	= 1

//	Check if the popup user object is valid
if ISVALID ( u_new_recv_dock ) then
	//	Get the number of rows to be processed on the popup user object
	do while (l_i_count <= u_new_recv_dock.dw_main.RowCount()	) 
		szUm	= u_new_recv_dock.dw_main.object.unit[l_i_count]
		l_n_TotalQty	= l_n_TotalQty + u_new_recv_dock.dw_main.object.quantity[l_i_count]		// ADD 04-11-2000 KAZ
		itotalBoxes	= itotalBoxes + u_new_recv_dock.dw_main.object.boxes[l_i_count] 	// CHG 04-06-2000 KAZ
		l_i_count ++
	loop
	l_n_TotalQty	= l_n_TotalQty * itotalboxes															// ADD 04-11-2000 KAZ
	ntotalqty	= l_n_TotalQty 																			// ADD 04-11-2000 KAZ
	pOldPointer	= SetPointer(HourGlass!)
	iObjectsProcessed	= 0
	l_b_OK		= true
	l_i_row		= 1
	l_i_totalLabels	= 0
	stParm.title	= "Receiving Objects"
	OpenWithParm(w_progress, stParm)
	w_progress.cb_cancel.visible = false

	//	Reset the list view
	dw_recvd_objects.Reset() 

	//	Start looping through the rows if boolean is true and the rows are more than 1
	do while l_b_OK and ( l_i_row <= u_new_recv_dock.dw_main.RowCount() )
		dw_pallet_object_info.Reset()
		szPart	= u_new_recv_dock.dw_main.object.part_number[l_i_row]
		nQty	= u_new_recv_dock.dw_main.object.quantity[l_i_row]
		is_package_type = u_new_recv_dock.dw_main.object.package_type[l_i_row]
		szLocationTo	= u_new_recv_dock.dw_main.object.location[l_i_row]
		l_n_rowid	= u_new_recv_dock.dw_main.object.row_id[l_i_row]
		l_i_Boxes	= u_new_recv_dock.dw_main.object.boxes[l_i_row]
		ib_dropshippart = ( IsNull ( u_new_recv_dock.dw_main.object.drop_ship_part[l_i_row], 'N' ) = 'Y' )
		
		//	Get the number of boxes and the quantity and continue with the process
		if ( nQty > 0 ) and (l_i_Boxes > 0) then
			//	Get the values for the po and make sure they are all valid
			l_b_OK = wf_get_values ( l_i_row )
			l_i_count = 1
			//	Loop through the number of boxes for the selected row
			do while l_b_OK and ( l_i_count <= l_i_Boxes )
				w_progress.wf_progress ( iObjectsProcessed / itotalBoxes, "Updating history for part "  + szPart )		
				//	Line item receiving or accum?..
				If cbx_line_item.Checked then
					l_b_OK = wf_update_line_item_po_history ( iPO, szPart, nQty, szUM, il_row_id )
				Else
					l_b_OK = wf_update_po_history ( iPO, szPart, nQty, szUM )
				End If
				If NOT l_b_ok then MessageBox(monsys.msg_title, "Update of PO History~rFor Part: " + szPart + " Failed!", StopSign!)
				l_b_Ok = ( wf_update_part_vendor ( szpart, szvendor, szum, nQty ) = 0 )
				if l_b_OK then	// if successfully updated the PO history table	
					iObjectsProcessed ++
					if not sqlca.of_getnextparmvalue ( "next_serial", iSerial ) then
						Rollback;																															// ADD 01-26-2000 KAZ
						MessageBox(monsys.msg_title, "Failed to get a next Serial number, Please try again", Exclamation! )
						Return																																// ADD 01-26-2000 KAZ
					end if																																	// ADD 01-26-2000 KAZ
					w_progress.wf_progress(iObjectsProcessed / itotalBoxes, "Create object " + String(iSerial) + " for part "  + szPart)
					l_b_OK = wf_create_object(iSerial)	
					if l_b_OK then // if successfully created the object	
						w_progress.wf_progress(iObjectsProcessed / itotalBoxes, "Create audit trail for object " + String(iSerial))
						l_b_Ok = wf_create_audit_trail(iSerial)  
					else
						MessageBox(monsys.msg_title, "Failed to Create Object!", StopSign!)
					end if
					if l_b_OK then // if successfully created audit_trail row
						if  bPalletMode then
							w_progress.wf_progress(iObjectsProcessed / itotalBoxes, "Add Object " + String(iSerial) + " to pallet")
							wf_add_object_to_pallet(iSerial)
						end if
						l_i_totalLabels ++
						l_i_LabelArray[l_i_totalLabels]	= iSerial
					else
						MessageBox(monsys.msg_title, "Failed to Create Audit Trail!", StopSign!)
					end if
				else
					rollback;
					MessageBox ( monsys.msg_title, "Failed to update accum received!", StopSign! )
				end if
		
				//	If successful in doing all above then commit 
				if l_b_OK then
					commit;
					if szPartClass <> 'N' and szPartClass <> 'n' then
						w_progress.wf_progress ( iObjectsProcessed / itotalBoxes, "Printing label for serial " + String(iSerial) )
						stParm2.value1 = STRING ( iSerial )
						f_print_label ( stParm2 )  // print label
					end if
				else
					l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 01-19-2000 KAZ
					Rollback ;																									// CHG 01-19-2000 KAZ
					If l_s_SQLErrorText = '' Then																																// ADD 02-24-2000 KAZ
						MessageBox ( monsys.msg_title, "The Creation of the Object and Audit~rTrail Failed With No Error Message!", StopSign!)
					Else																																								// ADD 02-24-2000 KAZ
						MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)
					End If
				end if
				l_i_count ++
				if cbx_line_item.Checked then
					w_progress.wf_progress(iObjectsProcessed / itotalBoxes, "Recalculate PO Detail for Part: "  + szPart)
					l_b_OK = wf_recalc_line_item ( iPO, szPart, u_new_recv_dock.dw_main.object.row_id [l_i_row], nQty, szUM )
					if NOT l_b_ok then MessageBox(monsys.msg_title, "Failed to Recalculate PO Detail for Part: " + szPart, StopSign!)
				end if
			loop
			if l_b_OK then
				if not cbx_line_item.Checked then
					w_progress.wf_progress(iObjectsProcessed / itotalBoxes, "Recalculate PO detail for part "  + szPart)
					if bReOccuringItem then		// If this is a reoccuring item
						if (nQty > 0) and (l_i_Boxes > 0 ) then
							bNocommit	= false
							l_b_OK		= f_recalc_po_detail_per_part (iPO, szPart, w_visual_receiving_dock_version2)
							bNocommit	= true
						end if
					else	// if this is a non-reoccuring item
						if (nQty > 0) and (l_i_Boxes > 0) then
							l_b_OK	= wf_delete_po_detail ( iPO, szPart )		
						end if
					end if
				elseif ib_close_release  then
					ib_close_release = false
					if MessageBox(monsys.msg_title,"Would you like to close this release?", Exclamation!, YesNo!, 2) = 1 then
						u_new_recv_dock.dw_releases.DeleteRow (i_l_release_row_line_item)
						l_b_OK = ( u_new_recv_dock.dw_releases.update ( ) <> -1 )
					end if
				end if
			end if
			if l_b_OK then
				commit;
			else
				l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 01-19-2000 KAZ
				Rollback ;																									// CHG 01-19-2000 KAZ
				If l_s_SQLErrorText = '' Then																																// ADD 02-24-2000 KAZ
					MessageBox(monsys.msg_title, "The Receiving Event Failed~rWith No Error Message!", StopSign!)
				Else																																								// ADD 02-24-2000 KAZ
					MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)
				End If
			end if	
		end if
		l_i_row ++
		l_b_OK = true
	loop
//	u_new_recv_dock.dw_main.Retrieve ( iPO, dw_range_weights.object.part.primary)				
	l_i_row -- 
	for l_i_count = l_i_row to 1 step -1
		u_new_recv_dock.dw_main.object.quantity[l_i_count] = 0
	next	
end if
if bRecalc then
	w_smart_po.wf_retrieve_vendor_parts()
	if w_smart_po.bVendorMode then
		w_smart_po.wf_build_crosstab()
	else
		w_smart_po.wf_build_crosstab_in_part_mode()
	end if
end if
Close(w_progress)
SetPointer ( pOldPointer )
IF iObjectsProcessed <= 0 Then																																			// ADD 02-24-2000 KAZ
	MessageBox ( monsys.msg_title, "No Objects Were Processed!~rTotal Processed Objects: " + String(iObjectsProcessed), Information! )	// ADD 02-24-2000 KAZ
else																																												// ADD 02-24-2000 KAZ
	MessageBox ( monsys.msg_title, "Receiving event has been completed succesfully!~rTotal Processed Objects: " + String(iObjectsProcessed), Information! )	// CHG 02-24-2000 KAZ
End IF																																											// ADD 02-24-2000 KAZ
dw_crosstab.Reset ( )
if not IsNull(iPO) then
	sle_po.text	= STRING ( iPO )
	dw_crosstab.Retrieve ( iPO, datetime ( today() ) )
	if dw_crosstab.RowCount() = 0 then
		MessageBox(monsys.msg_title, "All releases for current PO have been received!", StopSign!)
	end if
else
	MessageBox(monsys.msg_title, "No active P.O. for vendor :" + szvendor, StopSign!)
end if
if cbx_retrieve.checked = true then cbx_retrieve.triggerevent ( Clicked! ) 
SetMicroHelp ( "Ready" )																							// ADD 04-11-2000 KAZ
end event

event ue_show_grid;// disable the receive and show grid menu buttons
m_receiving_dock.mf_display (false)

//	Close receiving popup.
CloseUserObject ( u_new_recv_dock )


end event

event ue_recv_popup;//	Check for shipper (if required).
if i_b_shipper_required then
	if isnull ( sle_shipper.text , '' ) = '' then
		MessageBox ( monsys.msg_title, "You must enter a valid shipper number!", StopSign! ) 
		sle_shipper.Setfocus ( )
		return
	end if
end if

//	Open receiving popup.
w_visual_receiving_dock_version2.openuserobject ( u_new_recv_dock, dw_crosstab.x, dw_crosstab.y )


if isvalid ( u_new_recv_dock ) then
	u_new_recv_dock.Bringtotop = true
end if
end event

event ue_reverse_receipt;//	Declarations
Long	l_i_ObjectPO, &
	l_i_Count 
String	l_s_List, &
	l_s_PartName, &
	l_s_Project, &
	l_s_Gl_account, &
	l_s_Status, &
	l_s_part, &
	l_s_objecttype, &
	l_s_ChildPart, &
	l_s_Location
string	ls_unit
Decimal	l_n_Qty, &
	l_n_StdQty, &
	l_n_Price
dec	ldec_quantity
dec	ldec_stdquantity
Boolean	l_B_Ok

SetPointer ( HourGlass! )

// check for selected rows in the datawindow
if dw_recvd_objects.getselectedrow(0) > 0  then
	wf_create_obj_array()
	l_s_List	= "" 
	for l_i_Count = 1 to itotalObjDel
		l_s_List	= l_s_List + String(stDelObj[l_i_Count].serial) + " "
	next
	if MessageBox ( monsys.msg_title, "Are you sure you want to delete object(s) " + l_s_List + " from inventory?", Question!, YesNo! ) = 1 then
		l_B_Ok		= true
		l_i_Count	= itotalObjDel
		Do while l_B_Ok and ( l_i_Count > 0 )
			iSerial		= stDelObj[l_i_Count].serial
			iObjectRow	= stDelObj[l_i_Count].row
			l_n_Qty		= stDelObj[l_i_Count].qty
			szUM		= stDelObj[l_i_Count].um
			l_s_part	= stDelObj[l_i_Count].Part
			l_n_Price	= stDelObj[l_i_Count].Price
			l_s_Project	= stDelObj[l_i_Count].Project
			szGLAccount	= stDelObj[l_i_Count].gl_account
			l_s_PartName	= stDelObj[l_i_Count].part_name
			l_s_objecttype	= stDelObj[l_i_Count].object_type				// CHG 03-30-2000 KAZ
			if l_s_objecttype <> 'R' then
				messagebox ( monsys.msg_title, string ( iSerial) + ' cannot be deleted as it has been used for other Inventory transactions!', Information! )
			else
				l_i_ObjectPO	= iPO
				l_s_Status	= wf_get_status(iSerial) 
				If wf_outside_serial (iSerial) Then								// ADD 03-30-2000 KAZ
					Select	isnull (part, ''),									// ADD 03-30-2000 KAZ
						isnull (to_loc, ''),
						unit,
						quantity,
						std_quantity
					Into	:l_s_ChildPart,										// ADD 03-30-2000 KAZ
						:l_s_Location,
						:ls_unit,
						:ldec_quantity,
						:ldec_stdquantity
					From	audit_trail												// ADD 03-30-2000 KAZ
					Where	serial	= :iSerial								// ADD 03-30-2000 KAZ
						And type = 'O' ;									// ADD 03-30-2000 KAZ
	
					Update	Object													// ADD 03-30-2000 KAZ
					Set	part		= :l_s_ChildPart,						// ADD 03-30-2000 KAZ
						location	= :l_s_Location,						// ADD 03-30-2000 KAZ
						destination	= :l_s_Location,						// ADD 03-30-2000 KAZ
						po_number 	= '',										// ADD 03-30-2000 KAZ
						status		= 'O',
						unit_measure	= :ls_unit,
						quantity	= :ldec_quantity,
						std_quantity	= :ldec_stdquantity
					Where	serial = :iSerial ;							// ADD 03-30-2000 KAZ
				Else																		// ADD 03-30-2000 KAZ
					Delete from object  
					where serial = :iSerial ;
				End If																	// ADD 03-30-2000 KAZ
	
				l_B_Ok	= (SQLCA.SQLCode = 0)
	
				if l_B_Ok then
					Delete	from audit_trail
					from	audit_trail at1
					where	serial = :iSerial  and
						type = 'R' and date_stamp = ( select max(date_stamp) from audit_trail at2 where at1.serial = at2.serial and at2.type = 'R' );
	
					l_B_Ok = (SQLCA.SQLCode = 0)
		
					if l_B_Ok then
						l_b_Ok = ( wf_update_part_vendor ( l_s_part, szvendor, szum, -(l_n_Qty) ) = 0 )
	
						if l_B_Ok then
							if l_s_Status = 'A' then
								l_n_StdQty	= f_calc_Std_qty ( szUM, l_s_part, l_n_Qty )
								l_B_Ok	= ( f_update_onhand ( l_s_part, l_n_StdQty, "-*" ) <> -1 )
							end if
			
							if l_B_Ok then
								dw_recvd_objects.deleterow ( iObjectrow )
		
								if not cbx_line_item.Checked then
									l_B_Ok	= 	wf_reverse_rec_event ( szUM, l_s_part, l_n_Qty )
									if l_B_Ok then
										bNoCommit	= true
										l_B_Ok	= f_recalc_po_detail_per_part(l_i_ObjectPO, l_s_part, w_visual_receiving_dock_version2)
									end if
								else
									l_B_Ok = wf_reverse_line_item ( szUM, l_s_part, l_n_Qty )
								end if
							end if	
						end if
					end if
				end if
			end if
			l_i_Count --
	
		loop		
	
		if l_B_Ok then
			Commit;
			SetMicroHelp ( "Releases have been reversed!" )
		else
			SetMicroHelp ( "Unable to reverse the transaction!" )
			Rollback;			
		end if
	
	end if
	
	if bDragObject then
		wf_draw_objects_on_pallet(iPallet)
	end if
	
	bDragObject	= false
	bDragPO		= false
	
	dw_crosstab.Retrieve ( iPO, datetime ( today() ) )
	
	if bRecalc then
		w_smart_po.wf_retrieve_vendor_parts()
		if w_smart_po.bVendorMode then
			w_smart_po.wf_build_crosstab()
		else
			w_smart_po.wf_build_crosstab_in_part_mode()
		end if
	end if

else

	MessageBox(monsys.msg_title, "select objects for deletion!", StopSign!)

end if

//SetMicroHelp ( "Ready" )


end event

event ue_receivetrans;//	Trigger receive event in receiving popup.
u_new_recv_dock.event ue_Receive ( )
end event

public subroutine wf_delay (integer iUnit);Integer iCount

for iCount	= 1 to (1000 * iUnit)
next
end subroutine

public subroutine wf_open_door (int iwarehouseno);Integer iCount

sDoor[iWareHouseNo, 1].width		= 0
sDoor[iWareHouseNo, 1].visible	= true

sDoor[iWareHouseNo, 2].width		= 0
sDoor[iWareHouseNo, 2].visible	= true

for iCount	= 1 to 10
	sDoor[iWareHouseNo, 1].Bringtotop	= true
	sDoor[iWareHouseNo, 1].width	= iDoorWidth * (iCount) / 10
	sDoor[iWareHouseNo, 2].Bringtotop	= true
	sDoor[iWareHouseNo, 2].width	= iDoorWidth * (iCount) / 10
	wf_delay(1)
next

bDoorOpen[iWareHouseNo]	= true
end subroutine

public subroutine wf_close_door (int iwarehouseno);Integer iCount

for iCount	= 1 to 10
	sDoor[iWareHouseNo, 1].Bringtotop	= true
	sDoor[iWareHouseNo, 1].width	= iDoorWidth * (10 - iCount) / 10
	sDoor[iWareHouseNo, 2].Bringtotop	= true
	sDoor[iWareHouseNo, 2].width	= iDoorWidth * (10 - iCount) / 10
	wf_delay(1)
next

sDoor[iWareHouseNo, 1].width		= 0
sDoor[iWareHouseNo, 1].visible	= false

sDoor[iWareHouseNo, 2].width		= 0
sDoor[iWareHouseNo, 2].visible	= false

bDoorOpen[iWareHouseNo]	= false
end subroutine

public subroutine wf_get_vendors ();dw_vendors.SetTransObject ( sqlca )
dw_vendors.Reset ( )
dw_vendors.insertRow ( 1 )

end subroutine

public subroutine wf_enable_screen (boolean bflag);dw_crosstab.enabled		= bFlag
sle_shipper.enabled		= bFlag
sle_po.enabled				= bFlag
dw_vendors.enabled		= bFlag
st_po_plant.visible		= bFlag

end subroutine

public subroutine wf_create_obj_array ();Long	l_i_row
Long	iCol
Long	iCount
Long	l_i_Serial
String  ls_objecttype
itotalObjDel	= 0
iCol	= 1
for l_i_row	= 1 to dw_recvd_objects.Rowcount() 
	if dw_recvd_objects.isselected ( l_i_row ) then		
		l_i_Serial	= dw_recvd_objects.object.serial [ l_i_row ]
		ls_objecttype	= dw_recvd_objects.object.type [ l_i_row ]
		itotalObjDel ++
		wf_get_audit_trail_info ( l_i_Serial )
		stDelObj[itotalObjDel].serial	= l_i_Serial
		stDelObj[itotalObjDel].row	= l_i_row
		stDelObj[itotalObjDel].qty	= nQty
		stDelObj[itotalObjDel].um	= szUM
		stDelObj[itotalObjDel].part	= szPart
		stDelObj[itotalObjDel].price	= nUnitPrice
		stDelObj[itotalObjDel].project	= szProject
		stDelObj[itotalObjDel].part_name= szPartName
		stDelObj[itotalObjDel].gl_account= szGlAccount
		stDelObj[itotalObjDel].object_type = ls_objecttype
	end if
next

end subroutine

public subroutine wf_auto_display_info ();szVendor		= wf_get_active_vendor(iPO)

sle_po.text	= String(iPO)

if IsNull(szVendor) then
	MessageBox(monsys.msg_title, "Purchase order " + String(iPO) + " does not exist!", StopSign!)
else
	dw_vendors.object.code[1] = szVendor
   dw_crosstab.Retrieve ( iPO, datetime ( today() ) )
end if
end subroutine

public subroutine wf_line_item ();STRING s_release

select release_control 
into	:s_release
from   po_header
where  po_number = :iPO ;

if s_release = 'L' then
	cbx_line_item.checked = true
else
	cbx_line_item.checked = false
end if
	
end subroutine

public function boolean wf_reverse_rec_event (string as_um, string as_part, decimal adec_qty);BOOLEAN	lb_ok,&
			lb_converted
boolean		lb_return

DATE		ld_date_due

LONG		ll_row_id

DEC		ldec_received,&
			ldec_balance,&
			ldec_quantity,&
			ldec_qty_remaining
			
STRING	ls_po_unit

DATAStoRE dw_po_history_undo
dw_po_history_undo 	=	CREATE DATAStoRE
dw_po_history_undo.Dataobject = "dw_po_history_undo"
dw_po_history_undo.SetTransObject ( SQLCA )
dw_po_history_undo.Retrieve ( iPO, as_part )

DATAStoRE dw_po_detail
dw_po_detail 	=	CREATE DATAStoRE
dw_po_detail.Dataobject = "dw_smart_po_detail_entry_nv"
dw_po_detail.SetTransObject ( SQLCA )
dw_po_detail.Retrieve ( iPO, as_part )

ldec_qty_remaining = adec_qty
lb_converted = false

Do While ldec_qty_remaining > 0

	Yield ( )

	if dw_po_detail.RowCount ( ) <= 0 then

		if dw_po_history_undo.rowcount() > 0 then 
			ll_row_id = dw_po_history_undo.GetItemNumber ( 1, "row_id" )
			wf_recreate_release ( ll_row_id , as_part )
			dw_po_detail.Retrieve ( iPO, as_part )
		else
			setmicrohelp ( 'Unable to find the PO history record!' )
			destroy 	dw_po_history_undo
			destroy 	dw_po_detail
			return false
		end if
	
	else

		ls_po_unit		= dw_po_detail.GetItemString ( 1, "unit_of_measure" )
		ldec_quantity	= dw_po_detail.GetItemNumber ( 1, "quantity" )
		ldec_received	= dw_po_detail.GetItemNumber ( 1, "received" )
		ldec_balance 	= dw_po_detail.GetItemNumber ( 1, "balance" )

		if not lb_converted then
			ldec_qty_remaining = f_convert_units ( as_um, ls_po_unit, as_part, ldec_qty_remaining )
			lb_converted = true
		end if

		if ldec_qty_remaining >= ldec_received then

			dw_po_detail.SetItem ( 1, "received", 0 )				
			dw_po_detail.SetItem ( 1, "balance", ldec_quantity )
			dw_po_detail.update ( )

			if ldec_qty_remaining > ldec_received then
		
				wf_undo_history (iPO, as_part, ldec_received, as_um)
				ldec_qty_remaining = ldec_qty_remaining - ldec_received
				if dw_po_history_undo.Retrieve ( iPO, as_part ) > 0 then &
					ll_row_id = dw_po_history_undo.GetItemNumber ( 1, "row_id" )
				wf_recreate_release ( ll_row_id, as_part )
				dw_po_detail.Retrieve ( iPO, as_part )

			else

				ldec_qty_remaining = 0
				wf_undo_history(iPO, as_part, ldec_received, as_um)
				dw_po_history_undo.Retrieve ( iPO, as_part )

			end if

		else

			dw_po_detail.SetItem ( 1, "received", ldec_received - ldec_qty_remaining )				
			dw_po_detail.SetItem ( 1, "balance", ldec_balance + ldec_qty_remaining )
			dw_po_detail.update ( )

			wf_undo_history(iPO, as_part, ldec_qty_remaining, as_um)
			dw_po_history_undo.Retrieve ( iPO, as_part )
			ldec_qty_remaining = 0

		end if
	end if
loop

if dw_po_detail.update ( ) = -1 then
	lb_return = false
else
	lb_return = true
end if					

destroy 	dw_po_history_undo
destroy 	dw_po_detail

return lb_return
end function

public function boolean wf_reverse_line_item (string as_um, string as_part, decimal adec_qty);dec	ldec_quantity,&
	ldec_received,&
	ldec_balance,&
	ldec_qty,&
	ldec_undo_qty
string	ls_po_unit
boolean	lb_detail

long	ll_row_id

if ISNULL ( f_get_part_info ( as_part, 'NAME' ) ) OR f_get_part_info ( as_part, 'NAME' ) = '' then
	ll_row_id = 0
else
	ll_row_id = il_row_id
end if

select	quantity,   
	received,   
	balance,
	unit_of_measure  
into	:ldec_quantity,   

	:ldec_received,   
	:ldec_balance,
	:ls_po_unit  
from	po_detail  
where	( po_number = :iPO ) and 
 	( part_number = :as_part ) and
	( row_id = :ll_row_id )   ;

if sqlca.sqlcode <> 0 then
	select	quantity,   
		received,   
		balance,  
		unit_of_measure  
	into	:ldec_quantity,   
		:ldec_received,   
		:ldec_balance,  
		:ls_po_unit  
	from	po_detail_history  
	where	( po_number = :iPO ) and
		( part_number = :as_part ) and
		( row_id = :ll_row_id )   ;
	lb_detail = false
else
	lb_detail = true
end if

ldec_qty = f_convert_units ( as_um, ls_po_unit, as_part, adec_qty )

// The below if condition wasn't updating the po_history table, due the failure of the above
// select statement, which doesn't find the row in po_detail, if full qty is received & 
// trying to reverse fully or partially. So commented out the if condition 

//if ldec_balance > 0 then
	if ldec_qty > ldec_quantity then
		ldec_undo_qty = ldec_quantity
	else
		ldec_undo_qty = ldec_qty
	end if
//else
//	ldec_undo_qty = 0
//end if

if not lb_detail then
	wf_recreate_release ( ll_row_id, as_Part )
end if

ldec_received = ldec_received - ldec_qty
if ldec_received < 0 then &
	ldec_received = 0
ldec_balance  = ldec_quantity - ldec_received

update po_detail  
   SET received = :ldec_received,   
       balance = :ldec_balance  
 where ( po_detail.po_number = :iPO ) and  
		 ( part_number = :as_part ) and
       ( po_detail.row_id = :ll_row_id ) ;

wf_undo_history ( iPO, as_part, ldec_undo_qty, as_um )

return true
end function

public function string wf_location (string arg_spart);string s_location
s_location = ""

select primary_location 
  into :s_location
  from part_inventory
 where part = :arg_spart ;

if sqlca.sqlcode < 0 then
	MESSAGEBOX ( monsys.msg_title, "Database Error", Stopsign! )
elseif sqlca.sqlcode = 100 then
   MESSAGEBOX ( monsys.msg_title,"Location for part selected not found", Exclamation! )
end if


return s_location

end function

public subroutine wf_add_object_to_pallet (long aiserial);if dw_objects.RowCount()	= 0 then
	dw_objects.insertRow(1)
	iPalletCol	= 1
end if

if iPalletCol > 5 then
	iPalletCol	= 1
	dw_objects.insertRow(1)
end if
	
dw_objects.SetItem(1, iPalletCol, aiSerial)

iPalletCol ++
iObjectsOnPallet ++
gb_pallet.text	= "Objects on Pallet:" + String(iObjectsOnPallet)
end subroutine

public function boolean wf_update_po_history (long a_l_po, string a_s_part, decimal a_n_qty, string a_s_um);/* 04-10-2000 KAZ Modified to populate last_recvd_date and last_recvd_amount.  Issue # 13216. */

LONG 		l_i_Row, &
			l_i_totalRows, &
			l_i_RowId, &
			l_i_WeekNo, &
			l_i_Release, &
			l_l_sales_order,&
			l_l_dropship_oe_row_id,&
			l_l_dropship_shipper

DECIMAL	l_n_Balance, &
       	l_n_StdQty, &
       	l_n_Price, &
       	l_n_Quantity, &
       	l_n_Received, &
       	l_n_HistQuantity, &
       	l_n_HistReceived, &
       	l_n_HistBalance, &
       	l_n_qtyIncreased, &
			ldec_last_rec_amt,&
			ldec_active_rel_cum,&
			ldec_rec_cum,&
			ldec_invoice_qty,&
			ldec_invoice_unit_price

Date		dDueDate, &
			ldt_today,&
			ld_invoice_date

Datetime dt_dduedate, & 
			dt_ldt_today,	&
			dt_ld_invoice_date

STRING	l_s_Terms, &
			l_s_Description, &
			l_s_Requisition, &
			l_s_Account, &
			l_s_plant, &
			ls_type,&
			ls_cross_ref_part,&
			ls_notes,&
			ls_invoice_status,&
			ls_ship_to_dest,&
			ls_invoice_number,&
			ls_ship_type,&
			ls_price_unit,&
			ls_ship_via,&
			ls_release_type

BOOLEAN	bOK = true

ldec_last_rec_amt 	= a_n_qty																// ADD 04-10-2000 KAZ

ldt_today				= today()
dt_ldt_today			= datetime ( today(), now() )
DATAStoRE				  dw_po_detail
dw_po_detail 			= CREATE DATAStoRE

dw_po_detail.Dataobject = 'dw_smart_po_detail_entry'
dw_po_detail.getchild ( "unit_of_measure",  iwchild )									// ADD 04-10-2000 KAZ
iwchild.settransobject ( sqlca )																// ADD 04-10-2000 KAZ
iwchild.retrieve ( a_s_part )																	// ADD 04-10-2000 KAZ
dw_po_detail.SetTransObject ( SQLCA )
dw_po_detail.Retrieve(a_l_PO, a_s_part)



l_i_totalRows	= dw_po_detail.RowCount()
a_n_qty			= f_convert_units(a_s_UM, szPOUnit, a_s_part, a_n_qty)

l_i_Row = 1

for l_i_Row = l_i_totalRows to 1 STEP -1
	if dw_po_detail.GetItemString(l_i_Row, "deleted") = "Y" then
		dw_po_detail.DeleteRow(l_i_Row)
	end if
next

l_i_Row			= 1
l_i_totalRows	= dw_po_detail.RowCount()

DO WHILE bOk and (l_i_Row <= l_i_totalRows) and (a_n_qty > 0)

	l_n_Balance		= f_get_value(dw_po_detail.GetItemNumber(l_i_Row, "balance"))
	l_n_Received	= f_get_value(dw_po_detail.GetItemNumber(l_i_Row, "received"))
	l_n_Quantity	= f_get_value(dw_po_detail.GetItemNumber(l_i_Row, "quantity"))
	l_i_RowId		= dw_po_detail.GetItemNumber(l_i_Row, "row_id")

	if l_n_Balance <= a_n_qty then
		l_n_StdQty			= 0

		if l_i_Row < l_i_totalRows then
			l_n_Received		= l_n_Quantity
			a_n_qty				= a_n_qty - l_n_Balance
		else	//if this is the last row in release then system over received.
			l_n_Received		= l_n_Received + a_n_qty
			a_n_qty				= 0
		end if

		l_n_Balance			= 0
	else
		a_s_UM			= dw_po_detail.GetItemString(l_i_Row, "unit_of_measure")
		l_n_Balance		= l_n_Balance - a_n_qty
		l_n_StdQty		= f_calc_std_qty (a_s_UM, a_s_part, l_n_Balance)
		l_n_Received	= l_n_Received + a_n_qty
		a_n_qty			= 0
	end if

	SetNull(l_n_HistQuantity)

	select po_detail_history.quantity,
			 po_detail_history.received,
			 po_detail_history.balance 
   into   :l_n_HistQuantity,
			 :l_n_HistReceived,
			 :l_n_HistBalance
	from  po_detail_history  
   where  ( po_detail_history.po_number = :a_l_PO ) and  
          ( po_detail_history.part_number = :a_s_part ) and  
          ( po_detail_history.row_id = :l_i_RowId )   ;
	
	if l_n_HistQuantity > 0 then

  		update po_detail_history  
     	SET 	 received 				= :l_n_Received,   
      	    balance 				= :l_n_Balance,
				 standard_qty 			= :l_n_StdQty,
				 last_recvd_date 		= :dt_ldt_today,										// ADD 04-10-2000 KAZ
				 last_recvd_amount 	= :ldec_last_rec_amt									// ADD 04-10-2000 KAZ
   	where  ( po_number 			= :a_l_PO ) and  
         	 ( part_number 		= :a_s_part ) and  
         	 ( row_id 				= :l_i_RowId )   ;
				 
	else		

		dDueDate						= date ( dw_po_detail.GetItemDatetime(l_i_Row, "date_due") )
		l_n_Quantity				= dw_po_detail.GetItemNumber(l_i_Row, "quantity")
		a_s_UM						= dw_po_detail.GetItemString(l_i_Row, "unit_of_measure")
		l_n_Price					= dw_po_detail.GetItemNumber(l_i_Row, "price")
		l_i_Release					= dw_po_detail.GetItemNumber(l_i_Row, "release_no")
		l_s_Terms					= dw_po_detail.GetItemString(l_i_Row, "terms")
		l_s_Description			= dw_po_detail.GetItemString(l_i_Row, "description")
		l_i_WeekNo					= f_get_week_no(today())
		l_s_Requisition			= dw_po_detail.GetItemString(l_i_Row, "requisition_number")
		l_s_Account					= dw_po_detail.GetItemString(l_i_Row, "account_code")
		l_s_plant					= dw_po_detail.GetItemString(l_i_Row, "plant")
		ls_type						= dw_po_detail.GetItemString ( l_i_Row, "type" )
//		ldec_last_rec_amt			= dw_po_detail.GetItemNumber ( l_i_Row, "last_recvd_amount" )	// CHG 04-10-2000 KAZ
		ls_cross_ref_part			= dw_po_detail.GetItemString ( l_i_Row, "cross_reference_part" )
		ls_notes						= dw_po_detail.GetItemString ( l_i_Row, "notes" )
      ldec_active_rel_cum 		= dw_po_detail.GetItemNumber ( l_i_Row, "active_release_cum" )
		ldec_rec_cum 				= dw_po_detail.GetItemNumber ( l_i_Row, "received_cum" )
     	ls_invoice_status			= dw_po_detail.GetItemString ( l_i_Row, "invoice_status" )   
     	ld_invoice_date   		= date ( dw_po_detail.GetItemDatetime  ( l_i_Row, "invoice_date" ) )
     	ldec_invoice_qty   		= dw_po_detail.GetItemNumber ( l_i_Row, "invoice_qty" )
     	ldec_invoice_unit_price	= dw_po_detail.GetItemNumber ( l_i_Row, "invoice_unit_price" )   
		ls_ship_to_dest			= dw_po_detail.GetItemString ( l_i_Row, "ship_to_destination" )
		ls_invoice_number			= dw_po_detail.GetItemString ( l_i_Row, "invoice_number" )
     	l_l_sales_order   		= dw_po_detail.GetItemNumber ( l_i_Row, "sales_order" )
		l_l_dropship_oe_row_id	= dw_po_detail.GetItemNumber ( l_i_Row, "dropship_oe_row_id" )
		ls_ship_type				= dw_po_detail.GetItemString ( l_i_Row, "ship_type" )
		l_l_dropship_shipper		= dw_po_detail.GetItemNumber ( l_i_Row, "dropship_shipper" )
		ls_price_unit				= dw_po_detail.GetItemString ( l_i_Row, "price_unit" )
		ls_ship_via					= dw_po_detail.GetItemString ( l_i_Row, "ship_via" )	
		ls_release_type			= dw_po_detail.GetItemString ( l_i_Row, "release_type" )
		
      dt_dduedate             = datetime(dduedate)
   
		insert into po_detail_history  
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
		        price,   
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
		        printed,   
		        selected_for_print,   
		        deleted,
				  ship_via,
				  release_type,
				  alternate_price)  
		VALUES ( :a_l_PO,   
		         :szVendor,   
		         :a_s_part,   
		         :l_s_Description,   
		         :a_s_UM,   
		         :dt_dDueDate,   
		         :l_s_Requisition,   
		         'C',   
		         :ls_type,   
		         :dt_ldt_today,   
		         :ldec_last_rec_amt,   
		         :ls_cross_ref_part,   
		         :l_s_Account,   
		         :ls_notes,   
		         :l_n_Quantity,   
		         :l_n_Received,   
		         :l_n_Balance,   
		         :ldec_active_rel_cum,   
		         :ldec_rec_cum,   
		         :l_n_Price,   
		         :l_i_RowId,   
		        	:ls_invoice_status,   
		        	:ld_invoice_date,   
		        	:ldec_invoice_qty,   
		        	:ldec_invoice_unit_price,   
		         :l_i_Release,   
		        	:ls_ship_to_dest,   
		         :l_s_Terms,   
		         :l_i_WeekNo,   
		         :l_s_plant,   
		         :ls_invoice_number,   
		         :l_n_StdQty,   
		        	:l_l_sales_order,   
		        	:l_l_dropship_oe_row_id,   
		        	:ls_ship_type,   
		        	:l_l_dropship_shipper,   
		        	:ls_price_unit,   
					null,
					null,
					null,
					:ls_ship_via,
					:ls_release_type,
					:l_n_price) ;

	end if
	
	bOK	= (SQLCA.SQLCode = 0)

	l_i_Row ++
	
loop

destroy dw_po_detail

return  bOk

end function

public function boolean wf_update_po (string a_s_um, string a_s_pounit, string a_s_part, decimal a_n_qty);/* 04-11-2000 KAZ Modified to populate last_recvd_date and last_recvd_amount.  Issue # 13216. */

Decimal nPOQuantity

Boolean l_b_true

DATAStoRE		dw_po_detail
dw_po_detail 	=	CREATE DATAStoRE

dw_po_detail.Dataobject = 'dw_smart_po_detail_entry'
dw_po_detail.getchild ( "unit_of_measure",  iwchild )							// ADD 04-10-2000 KAZ
iwchild.settransobject ( sqlca )														// ADD 04-10-2000 KAZ
iwchild.retrieve ( a_s_part )															// ADD 04-10-2000 KAZ
dw_po_detail.SetTransObject ( SQLCA )
dw_po_detail.Retrieve(ipo, a_s_part)

if dw_po_detail.Rowcount() > 0 then
	nPoQuantity = f_convert_units ( a_s_UM, a_s_POUnit, a_s_Part, a_n_Qty )

	dw_po_detail.SetItem ( 1, "received", dw_po_detail.GetItemNumber ( 1, "received" ) +nPoQuantity )				
	dw_po_detail.SetItem ( 1, "balance", dw_po_detail.GetItemNumber ( 1, "balance" ) - nPoQuantity )
	dw_po_detail.SetItem ( 1, "last_recvd_date", today() )					// ADD 04-11-2000 KAZ
	dw_po_detail.SetItem ( 1, "last_recvd_amount", ntotalqty )				// ADD 04-11-2000 KAZ
				
	if dw_po_detail.update ( ) = -1 then
		l_b_true = false
	else
		l_b_true = true
	end if					
else
	l_b_true = false
end if	

destroy dw_po_detail

return l_b_true
end function

public subroutine wf_get_values_op_part (long a_l_serial, string a_s_part);/* 03-09-2000 KAZ Modified to allow user to access and edit custom fields 1-5 and access
						lot # on outside receiving.  Issue # 13136 */

DECIMAL	l_n_row_id

LONG 		l_l_row, &
			l_l_PO																	// ADD 03-09-2000 KAZ

Datetime		l_d_date																// ADD 03-09-2000 KAZ

l_l_PO			= dec ( sle_po.text )										// ADD 03-09-2000 KAZ
dFirstPODate	= wf_get_po_due_date(a_s_part)
szLocationfrom = szVendor
is_operator    = sle_password.text
szShipper		= sle_shipper.text
szpartClass		= f_get_part_info(a_s_part, "CLASS")
breoccuringitem= f_valid_part_number(a_s_part)

// select the row that the user has to receive against..

if cbx_line_item.checked then
	
//	l_l_row 		= dw_release_display.GetselectedRow( 0 )

//---------------------------------------
	w_visual_receiving_dock_version2.dw_release_display.Retrieve ( l_l_PO, a_s_part )				
	l_l_row 	= w_visual_receiving_dock_version2.dw_release_display.Find ( "row_id="+STRING(il_row_id), 0, w_visual_receiving_dock_version2.dw_release_display.Rowcount() )
	if l_l_row < 1 and w_visual_receiving_dock_version2.dw_Release_display.Rowcount() > 0 then 
		l_l_row = 1 	// if no row id is selected
	end if
//---------------------------------------

	if l_l_row > 0 then

//		 il_row_id			= dw_release_display.Object.row_id [l_l_row] 
		 iRelease			= dw_release_display.Object.release_no[l_l_row]
		 nUnitPrice			= dw_release_display.object.price[l_l_row]
		 szPOUnit			= dw_release_display.Object.unit_of_measure[l_l_row]
		 szControlNumber	= dw_release_display.Object.requisition_number[l_l_row]
		 szglaccount		= dw_release_display.Object.account_code[l_l_row]
		 
	end if

else																				// ADD 03-09-2000 KAZ

	Select 	min (date_due) 												// ADD 03-09-2000 KAZ
	Into		:l_d_date														// ADD 03-09-2000 KAZ
	From 		po_detail														// ADD 03-09-2000 KAZ
	Where		po_number 	= :l_l_PO										// ADD 03-09-2000 KAZ
	And		part_number = :a_s_part;									// ADD 03-09-2000 KAZ

	Select	account_code, price											// ADD 03-09-2000 KAZ
	Into		:szglaccount, :nunitprice									// ADD 03-09-2000 KAZ
	From 		po_detail														// ADD 03-09-2000 KAZ
	Where		po_number 	= :l_l_PO										// ADD 03-09-2000 KAZ
	And		part_number = :a_s_part										// ADD 03-09-2000 KAZ
	And		date_due		= :l_d_date;									// ADD 03-09-2000 KAZ

end if

nStdQty	= f_calc_std_qty ( szUM, a_s_part, nQty)

if f_get_value(nStdQty) = 0 then
	nStdQty		= nQty
	nCost			= nUnitPrice
else
	nCost			= (nQty * nUnitPrice / nStdQty)
end if

szPONumber		= String(iPO)
setnull ( nWeight	) //	= Dec ( f_get_part_info ( a_s_part, "UNIT WEIGHT") )  - mb changed on 05/21/99

end subroutine

public function boolean wf_create_object (long aiserial);String	l_s_status,&
			l_s_status_desc
			
Long 		iParentSerial, &
			li_row

Date		dtoday

Time		tNow

Dec	ld_stdcost


dtoday = today ( )
tNow   = Now ( )

dDate	= today()
tTime	= Now()

SetNull(iParentSerial)

if bPalletMode then
	if iPallet > 0 then
		iParentSerial	= iPallet
	end if
end if

if szPartClass = 'N' then
	if bPalletMode then
		dw_pallet_object_info.Reset()
		dw_pallet_object_info.Retrieve(aiserial)
	else
		li_row = dw_recvd_objects.insertrow (0)
		dw_recvd_objects.object.serial[li_row] = aiserial
		dw_recvd_objects.object.qnty [li_row] = nQty
		dw_recvd_objects.object.unit [li_row] = szUM
		dw_recvd_objects.object.type [li_row] = 'R'
	end if
	st_part.text	= szPart
	return true						//Do not create objects for NON-INVENtoRY part
end if

if not bReoccuringItem	then	//This is a non-reoccuring item 
	if bPalletMode then
		dw_pallet_object_info.Reset()
		dw_pallet_object_info.Retrieve(aiserial)
	else
		li_row = dw_recvd_objects.insertrow (0)
		dw_recvd_objects.object.serial[li_row] = aiserial
		dw_recvd_objects.object.qnty [li_row] = nQty
		dw_recvd_objects.object.unit [li_row] = szUM
		dw_recvd_objects.object.type [li_row] = 'R'
	end if
	st_part.text	= szPart
	return true
end if

if not bScanexternal then		//if not scan external serial number
	select	isnull(cost_cum,0)
	into	:ld_stdcost
	from	part_standard
	where	part = :szpart;
	
	insert into object  
		          ( serial,   
			         part,   
		   	      lot,   
			         location,   
			         last_date,   
			         unit_measure,   
			         operator,   
			         status,   
			         destination,   
			         station,   
			         origin,   
			         cost,   
			         weight,   
			         parent_serial,   
			         note,   
			         po_number,  
						plant, 
			         quantity,   
			         last_time,   
			         date_due,   
			         customer,
						package_type,
						std_quantity,   
			         sequence,
						custom1,
						custom2,
						custom3,
						custom4,
						custom5,
						user_defined_status,
						std_cost )  
			VALUES ( :aiserial,   
		    	      :szPart,   
			         :szLot,   
			         :szLocationto,   
			         :dtoday,   
			         :szUM,   
			         :is_Operator,   
			         :szStatus,   
			         null,   
			         null,   
			         :szShipper,   
			         :nCost,   
			         :nWeight,   
			         :iParentSerial,   
			         :sznotes,   
			         :szPoNumber,   
						:szPlant,
			         :nQty,   
			         :tNow,   
			         null,   
			         null,
						:is_package_type,
						:nStdQty,   
			         null,
						:szCustom1,
						:szCustom2,
						:szCustom3,
						:szCustom4,
						:szCustom5,
						:is_UserStatus,
						:ld_stdCost)  ;
else

	if ib_dropshippart then
		l_s_status = 'P'
		szLocationTo = szVendor
	else
		if szQA = 'Y' then
			l_s_status 			= 'H'
			l_s_status_desc 	= "On Hold"
		else
			l_s_status 			= 'A'
			l_s_status_desc	= "Approved"
		end if
	end if

	update 	object  
   SET 		part = :szPart,
				destination = '',
				location = :szLocationto,
				show_on_shipper = null,
			   shipper = null,
				status = :l_s_status,
				user_defined_status = :l_s_status_desc				 
   where 	object.serial = :aiserial   ;

end if

if SQLCA.SQLCode = 0 then
	if bPalletMode then
		dw_pallet_object_info.Reset()
		dw_pallet_object_info.Retrieve(aiserial)
	else
		li_row = dw_recvd_objects.insertrow (0)
		dw_recvd_objects.object.serial[li_row] = aiserial
		dw_recvd_objects.object.qnty [li_row] = nQty
		dw_recvd_objects.object.unit [li_row] = szUM
		dw_recvd_objects.object.type [li_row] = 'R'
	end if
	st_part.text	= szPart
	return true
else
	return false
end if


end function

public subroutine wf_draw_objects_on_pallet (long a_l_pallet);Long l_l_Row

dw_objects_on_pallet.Retrieve(a_l_pallet)
dw_objects.Reset()
dw_objects.insertRow(1)

iPalletCol	= 1

for l_l_Row = 1 to dw_objects_on_pallet.RowCount()

	if iPalletCol > 5 then
		iPalletCol = 1
		dw_objects.insertRow(1)
	end if

	dw_objects.SetItem(1, iPalletCol, dw_objects_on_pallet.GetItemNumber(l_l_Row, 1))

	iPalletCol ++

next

dw_objects.Bringtotop	= true
iObjectsOnPallet			= ((dw_objects.RowCount() - 1) * 5) + iPalletCol - 1
gb_pallet.text	= "Objects on Pallet:" + String(iObjectsOnPallet)

end subroutine

public function string wf_get_active_vendor (long a_l_po);String l_s_Vendor

SetNull(l_s_Vendor)
 
 select po_header.vendor_code  
    into :l_s_Vendor  
    from po_header  
   where (po_header.po_number = :a_l_po) and
			(po_header.status = 'A')   ;

return l_s_Vendor

end function

public function boolean wf_have_requirement (long a_l_po, string a_s_part);Long l_l_Count, l_l_deleted

SetNull(l_l_Count)

select count(po_detail.po_number ),
    	 count(po_detail.deleted)   
  into :l_l_Count,
		 :l_l_deleted  
  from po_detail  
 where ( po_detail.po_number = :a_l_po ) and  
       ( po_detail.part_number = :a_s_part ) and  
       ( po_detail.status = 'A' )   ;

return (l_l_Count <> l_l_deleted) 
end function

public function long wf_get_active_po (string a_s_vendor);Long l_l_PO

SetNull(l_l_PO)

select po_header.po_number  
  into :l_l_PO  
  from po_header  
 where ( po_header.vendor_code = :a_s_vendor ) and  
       ( po_header.status = 'A' )   ;

return l_l_PO
end function

public subroutine wf_create_pallet (long a_l_palletserial, string a_s_location, date a_d_date, string a_s_operator);datetime dt_ddate
 
dt_ddate = datetime(a_d_date)

 insert into object  
         ( serial,   
           part,   
           location,   
           last_date,   
           unit_measure,   
           operator,   
           status,   
           destination,   
           station,   
           origin,   
           cost,   
           weight,   
           parent_serial,   
           note,   
           quantity,   
           last_time,   
           date_due,   
           customer,   
           sequence,   
           shipper,   
           lot,   
           type,   
           po_number,   
           name,   
           plant,   
           start_date,   
           std_quantity,   
           package_type,   
           field1,   
           field2,   
           custom1,   
           custom2,   
           custom3,   
           custom4,   
           custom5,   
           show_on_shipper )  
  VALUES ( :a_l_palletserial,   
           'PALLET',   
           :a_s_location,   
           :dt_dDate,   
           null,   
           :a_s_operator,   
           'A',   
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
           'S',   
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
           'Y' )  ;

if SQLCA.SQLCode = 0 then
	if f_create_audit_trail ( a_l_palletserial, "P", "", '', '', "", '', '', "", "", "", "No Commit" ) then
		COMMIT;
		bPalletMode	= true
	else
		ROLLBACK;
	end if
else
	ROLLBACK;
end if

end subroutine

public function string wf_get_plant (string a_s_location);String l_s_plant

select location.plant  
  into :l_s_plant  
  from location  
 where location.code = :a_s_location   ;

return l_s_plant
end function

public function boolean wf_same_location (string a_s_location);Long 		l_l_Serial

String	l_s_ObjectLocation

if dw_objects_on_pallet.RowCount() > 0 then

	l_l_Serial	= dw_objects_on_pallet.GetItemNumber(1, "serial")
  	select object.location  
    into :l_s_ObjectLocation  
    from object  
   where object.serial = :l_l_Serial   ;
	
	szPalletLocation	= l_s_ObjectLocation
	return (l_s_ObjectLocation = a_s_location)

else
	return true
end if		
end function

public function long wf_get_po_number (long a_l_serial);String l_s_PONumber

select audit_trail.po_number,
		 audit_trail.part, 
		 audit_trail.quantity,
		 audit_trail.unit

  into :l_s_PONumber,
		 :szPart,
		 :nQty,
		 :szUM
		  
  from audit_trail  
 where ( audit_trail.serial = :a_l_Serial ) and  
       ( audit_trail.type = 'R' )   ;

return f_get_value(Long(l_s_PONumber))
end function

public function boolean wf_create_audit_trail (long a_l_serial);BOOLEAN	 l_b_Process

DATAStoRE	dw_serial
dw_serial	= CREATE DATAStoRE
dw_serial.dataobject 		= 'd_audit_trail_last_rec_outside'
dw_serial.Settransobject ( SQLCA )

// Modified the if condition to not update part online table if the object has a quality alert. 
// if not a non-inventory item
if (not szPartClass = 'N') and bReoccuringItem and isnull(szqa,'N') <> 'Y' then	
	f_update_onhand(szPart, nStdQty, "*") // "+" ) // changed this so that the objects are not committed before audit trail is committed.. 
end if

stTransParm.value1	= szGLAccount
stTransParm.value2	= szPartName
stTransParm.value3	= is_operator
stTransParm.value4	= szPlant
stTransParm.value5	= String(nUnitPrice)
stTransParm.value6	= String(dFirstPODate)
stTransParm.value7	= String(nStdQty)
stTransParm.value8	= String(iRelease)

if f_create_audit_trail(a_l_serial, "R", &
	String(iPo), &
	szVendor, &
	szControlNumber, &
	szShipper, &
	szPart, &
	String(nQty), & 
	String(nCost), &
	szLocationto, &
	szUM, &
	'No Commit') then

	if dw_serial.Retrieve ( a_l_Serial ) > 0 then

		// check if the part vendor is an outside process  - mb 08/6/99 
		if dw_serial.object.outside_process[1] = 'Y' then
			// if outserial is used then reconcile the object immediately
			if bscanexternal then
				dw_serial.SetItem ( 1, "status", 'C' )
			else
				dw_serial.SetItem ( 1, "status", 'P' )
			end if
		end if

		// inc by gph on 5/13/98 as these columns weren't getting populated,
		// also added the columns in the datawindow
	
		dw_serial.SetItem ( 1, "custom1", szcustom1 )
		dw_serial.SetItem ( 1, "custom2", szcustom2 )
		dw_serial.SetItem ( 1, "custom3", szcustom3 )
		dw_serial.SetItem ( 1, "custom4", szcustom4 )		
		dw_serial.SetItem ( 1, "custom5", szcustom5 )		
	
		if  dw_serial.update ( ) = -1 then
			destroy dw_Serial
			return false
		end if
	end if

	destroy dw_Serial

	if not cbx_line_item.Checked then
		if wf_update_po(szUM, szPOUnit, szPart, nQty) then
			return true
		else
			return false
		end if
	else
		return true
	end if
else
	return false
end if
end function

public function decimal wf_get_qty (long a_l_serial);Decimal l_n_Qty

select audit_trail.quantity  
  into :l_n_Qty  
  from audit_trail  
 where ( audit_trail.serial = :a_l_Serial ) and  
       ( audit_trail.type = 'R' )   ;

return l_n_Qty
end function

public function string wf_get_um (long a_l_serial);String l_s_UM

select object.unit_measure  
  into :l_s_UM 
  from object  
 where object.serial = :a_l_Serial   ;

return l_s_UM
end function

public function string wf_get_part_name (long a_l_po, string a_s_part);String a_s_PartName

select po_detail.description  
  into :a_s_PartName  
  from po_detail  
 where ( po_detail.po_number = :a_l_po ) and  
       ( po_detail.part_number = :a_s_part )   ;

return a_s_PartName
end function

public function string wf_get_part (long a_l_serial);String l_s_part

select audit_trail.part  
  into :l_s_part 
  from audit_trail  
 where ( audit_trail.serial = :a_l_Serial ) and  
       ( audit_trail.type = 'R' )   ;

return l_s_part
end function

public function string wf_get_status (long a_l_serial);String l_s_Status

select object.status  

  into :l_s_Status
  from object  
 where object.serial = :a_l_Serial   ;

return l_s_Status
end function

public function decimal wf_get_price (long a_l_serial);Decimal l_n_Price

select audit_trail.price  
  into :l_n_Price  
  from audit_trail  
 where ( audit_trail.serial = :a_l_Serial ) and  
       ( audit_trail.type = 'R' )   ;


return l_n_Price

end function

public subroutine wf_get_audit_trail_info (long a_l_serial);select	at1.part,   
	at1.quantity,   
	at1.price,   
	at1.control_number,   
	at1.notes,  
	at1.unit, 
	at1.gl_account  
into	:szPart,   
	:nQty,   
	:nUnitPrice,   
	:szProject,   
	:szPartName,   
	:szUM,
	:szGlAccount  
from	audit_trail  at1
where	serial = :a_l_Serial and
	type   = 'R' and 
	date_stamp = ( select	max(date_stamp) 
			from	audit_trail at2 
			where	at1.serial = at2.serial and type = 'R' );


end subroutine

public function string wf_get_po_plant_code (long a_l_po);String l_s_Plant

select po_header.plant  
  into :l_s_Plant  
  from po_header  
 where po_header.po_number = :a_l_PO   ;

return l_s_Plant
end function

public function boolean wf_delete_po_detail (long a_l_po, string a_s_part);String 	l_s_Vendor

Decimal 	l_n_Qty, &
			l_n_Received

l_s_Vendor	= dw_vendors.object.code[1]

// included the select statement and the check to see if the qty is partial or complete..mb : 05/03/99 

select quantity,
		 received
into	 :l_n_Qty,
		 :l_n_received
  from po_detail
 where ( po_number = :a_l_po ) and  
  	    ( part_number = :a_s_Part )   ;
			
if l_n_received >= l_n_qty and l_n_Qty > 0 then

	DELETE from po_detail  
	 where ( po_number = :a_l_po ) and  
   	    ( part_number = :a_s_Part )   ;

	if SQLCA.SQLCode = 0 then
		DELETE from part_vendor  
		 where ( part = :a_s_Part ) and  
   		    ( vendor = :l_s_Vendor )   ;

		if SQLCA.SQLCode = 0 then
			DELETE from part_vendor_price_matrix  
			 where ( part = :a_s_Part ) and  
		   	    ( vendor = :l_s_Vendor )   ;

			if SQLCA.SQLCode = 0 then
				return true
			else
				return false
			end if
		else
			return false
		end if
	else
		return false
	end if

else
	return true
end if
end function

public function boolean wf_create_release (long a_l_po, string a_s_part, string a_s_partname, decimal a_n_qty, date a_d_date, decimal a_n_price, string a_s_project, string a_s_glaccount);String l_s_Terms
String l_s_Plant
String l_s_Shipto

Long	l_l_WeekNo
Long	l_l_RowId

Decimal l_l_QtyOverReceived

Datetime l_dt_ddate_ttime

l_dt_ddate_ttime = datetime(ddate)

select po_header.terms,   
       po_header.ship_to_destination,   
       po_header.plant  
  into :l_s_Terms,   
       :l_s_Shipto,   
       :l_s_Plant  
  from po_header  
 where po_header.po_number = :a_l_po   ;

select part_vendor.qty_over_received  
  into :l_l_QtyOverReceived  
  from part_vendor  
 where ( part_vendor.part = :a_s_Part ) and  
       ( part_vendor.vendor = :szVendor )   ;

l_l_QtyOverReceived	= f_get_value(l_l_QtyOverReceived)
l_l_WeekNo				= f_get_week_no(a_d_Date)
l_l_RowId				= f_get_random_number()

a_n_Qty					= a_n_Qty - l_l_QtyOverReceived

  insert into po_detail  
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
           price,   
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
           invoice_number )  
  VALUES ( :a_l_PO,   
           :szVendor,   
           :a_s_Part,   
           :a_s_PartName,   
           :szUM,   
           :l_dt_ddate_ttime,   
           :a_s_Project,   
           'A',   
           'A',   
           null,   
           null,   
           null,   
           :a_s_GLAccount,   
           null,   
           :nQty,   
           0,   
           :nQty,   
           0,   
           0,   
           :a_n_Price,   
           :l_l_RowId,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :l_s_Shipto,   
           :l_s_Terms,   
           :l_l_WeekNo,   
           :l_s_Plant,   
           null )  ;

  update part_vendor  
     SET qty_over_received = 0  
   where ( part = :a_s_part ) and  
         ( vendor = :szVendor )   ;


	if SQLCA.SQLCode = 0 then
		return true;
	else
		return false;
	end if

end function

public function boolean wf_undo_history (long a_l_po, string a_s_part, decimal a_n_qty, string a_s_um);LONG 		l_l_Row, &
			l_l_totalRows, &
			l_l_RowId, &
			l_l_WeekNo

DECIMAL	l_n_Balance, &
			l_n_StdQty, &
       	l_n_Price, &
        	l_n_Quantity, &
        	l_n_Received, &
        	l_n_HistQuantity, &
        	l_n_HistReceived, &
        	l_n_HistBalance, &
        	l_n_QtyIncreased, &
			l_n_qty

DATE		l_d_DueDate

STRING	l_s_Release, &
			l_s_Terms, &
			l_s_Description, &
			l_s_Requisition, &
			l_s_Account, &
			l_s_Plant

BOOLEAN	l_b_OK = true

DATAStoRE		dw_po_history
dw_po_history 	=	CREATE DATAStoRE

dw_po_history.Dataobject = 'dw_po_history_per_po'
dw_po_history.SetTransObject ( SQLCA )
dw_po_history.Retrieve(a_l_PO, a_s_Part)

l_l_totalRows	= dw_po_history.RowCount()

l_l_Row = l_l_totalRows

if l_l_Row > 0 then
	szPOUnit		= dw_po_history.GetItemString ( l_l_Row, "unit_of_measure" )
	l_n_Qty =  f_convert_units ( a_s_UM, szPOUnit, a_s_Part, a_n_Qty )
	a_n_Qty = l_n_qty
end if

DO WHILE l_b_OK and (l_l_Row > 0) and (a_n_qty > 0)

	l_n_Balance		= f_get_value( dw_po_history.GetItemNumber(l_l_Row, "balance") )
	l_n_Received	= f_get_value( dw_po_history.GetItemNumber(l_l_Row, "received") )
	l_n_Quantity	= f_get_value( dw_po_history.GetItemNumber(l_l_Row, "quantity") )
	l_l_RowId		= dw_po_history.GetItemNumber( l_l_Row, "row_id" )

	if l_n_Received <= a_n_qty then
		l_n_StdQty			= f_calc_std_qty ( szPOUnit, a_s_part, l_n_Quantity)
		l_n_Balance			= l_n_Quantity
		a_n_qty				= a_n_qty - l_n_Received
		l_n_Received		= 0
	else
		l_n_Received= l_n_Received - a_n_qty
		l_n_Balance	= l_n_Balance + a_n_qty
		l_n_StdQty	= f_calc_std_qty ( szPOUnit, a_s_part, l_n_Balance)
		a_n_qty		= 0
	end if

	if (l_l_Row = 1) and (a_n_qty > 0) then		//if this the first row,
		l_n_Received	= l_n_Received - a_n_qty		//we have adjust received	
		l_n_Balance		= l_n_Balance  + a_n_qty
	end if

	if l_n_Received = 0 then
		Delete from po_detail_history
	  	where  ( po_number = :iPO ) and  
	     		 ( part_number = :a_s_part ) and  
	        	 ( row_id = :l_l_RowId )   ;
	else
		update po_detail_history  
	  	Set 	 received = :l_n_Received,   
	    	    balance = :l_n_Balance,  
				 standard_qty = :l_n_StdQty
	  	where  ( po_number = :iPO ) and  
	        	 ( part_number = :a_s_part ) and  
	        	 ( row_id = :l_l_RowId )   ;
	end if

	l_b_OK	= (SQLCA.SQLCode = 0)
	
	l_l_Row --
	
loop

destroy dw_po_history

return l_b_OK
end function

public function boolean wf_check_for_notes (long a_l_po, string a_s_part);String ls_notes

Long ll_Counter

	DECLARE check_for_notes CURSOR for
	 select notes
	   from po_detail
	  where part_number = :a_s_Part and po_number = :a_l_PO	;

Open check_for_notes	;

Do

	Fetch check_for_notes into :ls_notes	;
 
	if IsNull ( ls_notes ) OR ls_notes = "" then
		ll_Counter = ll_Counter + 0
	else
		ll_Counter = ll_Counter + 1
	end if

loop While SQLCA.SQLCode = 0

Close check_for_notes	;

if ll_Counter > 0 then 
	return true
else
	return false
end if


end function

public function date wf_get_po_due_date (string a_s_part);Date l_d_Date
datetime l_dt_l_d_Date

Declare 	curPODetail CURSOR for  
select 	po_detail.date_due  
from 		po_detail  
where 	(po_detail.po_number = :iPO ) and
        	(po_detail.part_number = :a_s_Part )   
Order By po_detail.date_due Asc  ;

Open  curPODetail;
Fetch curPODetail into: l_dt_l_d_Date;
Close curPODetail;

l_d_Date = date(l_dt_l_d_Date)

if SQLCA.SQLCode = 0 then		//Found at least one release
	return l_d_Date
else
	SetNull(l_d_Date)
	return l_d_Date
end if	
end function

public function boolean wf_recreate_release (long al_row_id, string as_part);insert into po_detail  
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
         price,   
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
         printed,   
         selected_for_print,   
         deleted,   
         ship_via,   
         release_type,
			alternate_price)
	select po_number,   
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
         price,   
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
         printed,   
         selected_for_print,   
         deleted,  
         ship_via,   
         release_type,
			alternate_price
    from po_detail_history  
   where ( po_number = :iPO ) and  
			( part_number = :as_part ) and
         ( po_detail_history.row_id = :al_row_id )   ;

	update 	po_detail
	   SET 	status = 'A'
	 where ( po_number = :iPO ) and
			 ( part_number = :as_part ) and
			 ( row_id	 = :al_row_id ) ;

return ( sqlca.sqlcode = 0 )
end function

public function boolean wf_recalc_line_item (long a_i_ponumber, string a_s_part, long a_i_row_id, decimal a_n_dec_qty, string a_s_um);/* 04-11-2000 KAZ Modified to populate last_recvd_date and last_recvd_amount.  Issue # 13216. */

Long 	l_l_RowCount,&
		l_l_row

Dec  l_d_quantity
Dec  l_d_Received
Dec  l_d_Balance
Dec  l_d_QtyOverReceived
Dec  l_d_TotalQty																										// ADD 04-11-2000 KAZ

STRING l_s_Temp

if not ISVALID ( u_new_recv_dock ) then return false

l_d_TotalQty = a_n_dec_qty

u_new_recv_dock.dw_releases.Retrieve ( a_i_ponumber, a_s_part )

l_s_Temp = "row_id=" + STRING(a_i_row_id) + " and part_number = '"+a_s_part+ "'"// look for part number also

l_l_row 	=  u_new_recv_dock.dw_releases.Find ( l_s_temp , 1, u_new_recv_dock.dw_releases.rowcount() )

if ( l_l_row <= 0 OR ISNULL ( l_l_row ) )  and u_new_recv_dock.dw_releases.rowcount() > 0 then 
	l_l_row = 1 
end if

i_l_release_row_line_item = l_l_row
a_n_dec_qty	 = f_convert_units(a_s_um, szPOUnit, a_s_Part, a_n_dec_qty)

l_d_Received = f_get_value ( u_new_recv_dock.dw_releases.object.received[l_l_row] ) + a_n_dec_qty
l_d_quantity = f_get_value ( u_new_recv_dock.dw_releases.object.quantity[l_l_row] ) 

l_d_Balance	= l_d_quantity - l_d_Received
u_new_recv_dock.dw_releases.object.quantity[l_l_row] 				= l_d_quantity
u_new_recv_dock.dw_releases.object.balance[l_l_row]	 			= l_d_Balance
u_new_recv_dock.dw_releases.object.received[l_l_row]				= l_d_Received
u_new_recv_dock.dw_releases.object.standard_qty[l_l_row]			=	f_calc_std_qty ( a_s_UM, a_s_Part, l_d_Balance)
u_new_recv_dock.dw_releases.object.last_recvd_date[l_l_row]		= today()							// ADD 04-11-2000 KAZ
u_new_recv_dock.dw_releases.object.last_recvd_amount[l_l_row]	= l_d_TotalQty						// ADD 04-11-2000 KAZ

if l_d_Balance <= 0 then
	ib_close_release = true
else
	ib_close_release = false
end if

if u_new_recv_dock.dw_releases.update ( ) = -1 then
	Rollback ;
	return false
else
	Commit;
	return true
end if


end function

public function boolean wf_recalc_line_item_op_part (long a_i_ponumber, string a_s_part, long a_i_row_id, decimal a_n_dec_qty, string a_s_um);/* 04-10-2000 KAZ Modified to populate last_recvd_date and last_recvd_amount.  Issue # 13216. */

Long 	l_l_RowCount,&
		l_l_row

Dec  l_d_quantity
Dec  l_d_Received
Dec  l_d_Balance
Dec  l_d_QtyOverReceived

STRING l_s_Temp

l_s_Temp = "row_id=" + STRING(a_i_row_id)

l_l_row 		 =  dw_release_display.Find ( l_s_temp , 1, dw_release_display.rowcount() )

a_n_dec_qty	 = f_convert_units(a_s_um, szPOUnit, a_s_Part, a_n_dec_qty)

l_d_Received = f_get_value ( dw_release_display.object.received[l_l_row] ) + a_n_dec_qty
l_d_quantity = f_get_value ( dw_release_display.object.quantity[l_l_row] ) 

l_d_Balance	= l_d_quantity - l_d_Received
dw_release_display.object.quantity[l_l_row] 				= l_d_quantity
dw_release_display.object.balance[l_l_row] 				= l_d_Balance
dw_release_display.object.received[l_l_row]				= l_d_Received
dw_release_display.object.standard_qty[l_l_row]			= f_calc_std_qty (szUM, a_s_Part, l_d_Balance)
dw_release_display.object.last_recvd_date[l_l_row] 	= today()					// ADD 04-10-2000 KAZ
dw_release_display.object.last_recvd_amount[l_l_row] 	= a_n_dec_qty				// ADD 04-10-2000 KAZ

if l_d_Balance <= 0 then
	ib_close_release = true
else
	ib_close_release = false
end if

if dw_release_display.update ( ) = -1 then
	Rollback ;
	return false
else
	Commit;
	return true
end if


end function

public subroutine wf_shipper_required ();string l_s_shipper

select shipper_required
into	 :l_s_shipper
from parameters ;

if l_s_shipper = 'Y' then
	i_b_shipper_required = true
else
	i_b_shipper_required = false
end if

end subroutine

public function boolean wf_get_values (long a_l_partrow);INTEGER 	l_i_Row

STRING	l_s_part

DECIMAL	l_n_row_id, &
			l_n_qty

l_s_Part				= u_new_recv_dock.dw_main.Object.part_number [a_l_partRow]
szUM					= u_new_recv_dock.dw_main.Object.unit [a_l_partRow]
szLot					= u_new_recv_dock.dw_main.Object.lot [a_l_partRow]
szPartName			= u_new_recv_dock.dw_main.Object.name [a_l_partRow]
dFirstPODate		= wf_get_po_due_date(l_s_Part)
l_n_Qty				= u_new_recv_dock.dw_main.Object.quantity[a_l_partRow]
szcustom1			= u_new_recv_dock.dw_main.Object.value1 [a_l_partRow]
szcustom2			= u_new_recv_dock.dw_main.Object.value2 [a_l_partRow]
szcustom3			= u_new_recv_dock.dw_main.Object.value3 [a_l_partRow]
szcustom4			= u_new_recv_dock.dw_main.Object.value4 [a_l_partRow]
szcustom5			= u_new_recv_dock.dw_main.Object.value5 [a_l_partRow]
sznotes				= u_new_recv_dock.dw_main.Object.notes [a_l_partRow]
//szLocationto   	= ddlb_locations.Text
szPlant				= wf_get_plant(szLocationto)
szLocationfrom 	= szVendor
is_operator     	= sle_password.text
szShipper			= sle_shipper.text
szPartClass			= f_get_part_info(szPart, "CLASS")
breoccuringitem	= f_valid_part_number(szPart)
is_package_type 	= u_new_recv_dock.dw_main.object.package_type[a_l_partrow]
il_row_id			= u_new_recv_dock.dw_main.Object.row_id [a_l_partRow]

if cbx_line_item.Checked then
	u_new_recv_dock.dw_releases.Retrieve ( iPO, l_s_Part )
	l_i_row 	= u_new_recv_dock.dw_releases.Find ( "row_id="+STRING(il_row_id), 0, u_new_recv_dock.dw_releases.Rowcount())
	if l_i_row < 1 and u_new_recv_dock.dw_Releases.Rowcount() > 0 then 
		l_i_row = 1 	// if no row id is selected
	elseif u_new_recv_dock.dw_Releases.Rowcount() <= 0  then
		Messagebox ( monsys.msg_title, "Unable to find release for part: " + l_s_Part + &
					" Contact your systems adminstrator!", StopSign! )
		return false
	end if
else
	u_new_recv_dock.dw_releases.Retrieve(iPO, l_s_Part)
	l_i_row	= 1		
end if

iRelease				= u_new_recv_dock.dw_releases.GetItemNumber(l_i_row, "release_no")
nUnitPrice			= u_new_recv_dock.dw_releases.GetItemNumber(l_i_row, "price")
szPOUnit				= u_new_recv_dock.dw_releases.GetItemString(l_i_row, "unit_of_measure")
szControlNumber	= u_new_recv_dock.dw_releases.GetItemString(l_i_row, "requisition_number")

if bReoccuringItem then
	szGLAccount		= f_get_part_info(l_s_Part, "GL ACCOUNT")
else
	szGLAccount		= u_new_recv_dock.dw_releases.GetItemString(l_i_row, "account_code")
end if

nStdQty					= f_calc_std_qty ( szUM, l_s_Part, l_n_qty)

if f_get_value(nStdQty) = 0 then
	nStdQty		= l_n_qty
	nCost			= nUnitPrice
else
	nCost			= (l_n_qty * nUnitPrice / nStdQty)  //Unit Cost is for std_qty
end if

szPONumber		= String(iPO)

select part.quality_alert  
	  into :szQA  
	  from part  
	 where part.part = :l_s_Part   ;
	
if szQA = 'Y' then
	szStatus = 'H'
	is_UserStatus = "On Hold"
else
	szStatus = 'A'
	is_UserStatus = "Approved"
end if

//nWeight		= Dec ( f_get_part_info ( l_s_Part, "UNIT WEIGHT") ) 

setnull ( nweight ) // weight is recalculated by trigger on object table and hence we don't need to set a value here. mb 05/21/99
nQty			= l_n_qty

return true


end function

public function boolean wf_create_object_custom (long al_serial, decimal a_n_qty, decimal a_n_net_weight, decimal a_n_tare_weight, string a_s_package, string a_s_unit);/* 03-09-2000 KAZ Modified to allow user to access and edit custom fields 1-5 and access
						lot # on outside receiving.  Issue # 13136 */

String	l_s_status,&
			l_s_status_desc
			
Long 		iParentSerial, &
			li_row

Date		dtoday

Time		tNow

dtoday = today ( )
tNow   = Now ( )

dDate	= today()
tTime	= Now()

SetNull(iParentSerial)

if bPalletMode then
	if iPallet > 0 then
		iParentSerial	= iPallet
	end if
end if

if szPartClass = 'N' then
	if bPalletMode then
		dw_pallet_object_info.Reset()
		dw_pallet_object_info.Retrieve(al_Serial)
	else
		li_row = dw_recvd_objects.insertrow (0)
		dw_recvd_objects.object.serial[li_row] = al_Serial
		dw_recvd_objects.object.qnty [li_row] = nQty
		dw_recvd_objects.object.unit [li_row] = szUM
		dw_recvd_objects.object.type [li_row] = 'R'
	end if
	st_part.text	= szPart
	return true						//Do not create objects for NON-INVENtoRY part
end if

if not bReoccuringItem	then	//This is a non-reoccuring item 
	if bPalletMode then
		dw_pallet_object_info.Reset()
		dw_pallet_object_info.Retrieve(al_Serial)
	else
		li_row = dw_recvd_objects.insertrow (0)
		dw_recvd_objects.object.serial[li_row] = al_Serial
		dw_recvd_objects.object.qnty [li_row] = nQty
		dw_recvd_objects.object.unit [li_row] = szUM
		dw_recvd_objects.object.type [li_row] = 'R'
	end if
	st_part.text	= szPart
	return true
end if

if szQA = 'Y' then
	l_s_status 			= 'H'
	l_s_status_desc 	= "On Hold"
else
	l_s_status 			= 'A'
	l_s_status_desc	= "Approved"
end if

update 	object  
  SET 	weight 					= null, // set the value to null, so that it could get re-calculated 4/14/01
			quantity 				= :a_n_qty,
			std_quantity 			= :nStdQty,
			package_type			= :a_s_package,
			unit_measure			= :a_s_unit,
			tare_weight 			= :a_n_tare_weight,
			part 						= :szPart,
			destination 			= '',
			location 				= :szLocationto,
			show_on_shipper		= null,
		   shipper 					= null,
			status 					= :l_s_status,
			operator 				= :is_Operator,
			user_defined_status 	= :l_s_status_desc,
			po_number				= :szponumber,
			lot						= isnull ( :szlot, '' ),					// ADD 03-09-2000 KAZ
			custom1					= isnull ( :szcustom1, '' ),				// ADD 03-09-2000 KAZ
			custom2					= isnull ( :szcustom2, '' ),				// ADD 03-09-2000 KAZ
			custom3					= isnull ( :szcustom3, '' ),				// ADD 03-09-2000 KAZ
			custom4					= isnull ( :szcustom4, '' ),				// ADD 03-09-2000 KAZ
			custom5					= isnull ( :szcustom5, '' ),				// ADD 03-09-2000 KAZ
			cost					= :nCost,
			last_date				= :dtoday,										// ZZ
			last_time				= :tNow	 // ZZ
  where 	object.serial 			= :al_Serial   ;

if SQLCA.SQLCode = 0 then

	if bPalletMode then
		dw_pallet_object_info.Reset()
		dw_pallet_object_info.Retrieve(al_Serial)
	else
		li_row = dw_recvd_objects.insertrow (0)
		dw_recvd_objects.object.serial[li_row] = al_Serial
		dw_recvd_objects.object.qnty [li_row] = nQty
		dw_recvd_objects.object.unit [li_row] = szUM
		dw_recvd_objects.object.type [li_row] = 'R'
	end if
	st_part.text	= szPart
	return true

else

	return false

end if


end function

public function boolean wf_update_line_item_po_history (long a_l_po, string a_s_part, decimal a_n_qty, string a_s_um, long a_l_row_id);/* 04-10-2000 KAZ Modified to populate last_recvd_date and last_recvd_amount.  Issue # 13216. */

LONG 		l_i_Row, &
			l_i_totalRows, &
			l_i_RowId, &
			l_i_WeekNo, &
			l_i_Release, &
			l_l_sales_order,&
			l_l_dropship_oe_row_id,&
			l_l_dropship_shipper

DECIMAL	l_n_Balance, &
       	l_n_StdQty, &
       	l_n_Price, &
       	l_n_Quantity, &
       	l_n_Received, &
       	l_n_HistQuantity, &
       	l_n_HistReceived, &
       	l_n_HistBalance, &
       	l_n_qtyIncreased, &
			ldec_last_rec_amt,&
			ldec_active_rel_cum,&
			ldec_rec_cum,&
			ldec_invoice_qty,&
			ldec_invoice_unit_price

Date		dDueDate, &
			ldt_today,&
			ld_invoice_date

Datetime dt_dduedate, & 
			dt_ldt_today,	&
			dt_ld_invoice_date

STRING	l_s_Terms, &
			l_s_Description, &
			l_s_Requisition, &
			l_s_Account, &
			l_s_plant, &
			ls_type,&
			ls_cross_ref_part,&
			ls_notes,&
			ls_invoice_status,&
			ls_ship_to_dest,&
			ls_invoice_number,&
			ls_ship_type,&
			ls_price_unit,&
			ls_ship_via,&
			ls_release_type

BOOLEAN	bOK 			= true

ldt_today				= today()
dt_ldt_today 			= datetime ( today(), now() )

ldec_last_rec_amt 	= a_n_qty																// ADD 04-10-2000 KAZ

a_n_qty					= f_convert_units(a_s_UM, szPOUnit, a_s_part, a_n_qty)

If isvalid ( u_new_recv_dock ) Then
	
	u_new_recv_dock.dw_releases.Retrieve ( a_l_po, a_s_part )				
	l_i_row 	= u_new_recv_dock.dw_releases.Find ( "row_id="+STRING(a_l_row_id), 0, u_new_recv_dock.dw_releases.Rowcount() )
	if l_i_row < 1 and u_new_recv_dock.dw_Releases.Rowcount() > 0 then 
		l_i_row = 1 	// if no row id is selected
	elseif u_new_recv_dock.dw_Releases.Rowcount() <= 0  then
		Messagebox ( monsys.msg_title, "Unable to find release for part: " + a_s_part + &
					" Contact your systems adminstrator!", StopSign! )
		return false
	end if

	l_n_Balance		= f_get_value(u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "balance"))
	l_n_Received	= f_get_value(u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "received"))
	l_n_Quantity	= f_get_value(u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "quantity"))
	//l_i_RowId		= u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "row_id")

	a_s_UM			= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "unit_of_measure")
	l_n_Balance		= l_n_Balance - a_n_qty
	l_n_StdQty		= f_calc_std_qty (a_s_UM, a_s_part, l_n_Balance)
	l_n_Received	= l_n_Received + a_n_qty
	//a_n_qty			= 0

Else
	
	dw_release_display.Retrieve ( a_l_po, a_s_part )				
	l_i_row 	= dw_release_display.Find ( "row_id="+STRING(a_l_row_id), 0, dw_release_display.Rowcount() )
	if l_i_row < 1 and dw_Release_display.Rowcount() > 0 then 
		l_i_row = 1 	// if no row id is selected
	elseif dw_Release_display.Rowcount() <= 0  then
		Messagebox ( monsys.msg_title, "Unable to find release for part: " + a_s_part + &
					" Contact your systems adminstrator!", StopSign! )
		return false
	end if

	l_n_Balance		= f_get_value(dw_release_display.GetItemNumber(l_i_Row, "balance"))
	l_n_Received	= f_get_value(dw_release_display.GetItemNumber(l_i_Row, "received"))
	l_n_Quantity	= f_get_value(dw_release_display.GetItemNumber(l_i_Row, "quantity"))
	//l_i_RowId		= u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "row_id")

	a_s_UM			= dw_release_display.GetItemString(l_i_Row, "unit_of_measure")
	l_n_Balance		= l_n_Balance - a_n_qty
	l_n_StdQty		= f_calc_std_qty (a_s_UM, a_s_part, l_n_Balance)
	l_n_Received	= l_n_Received + a_n_qty
	//a_n_qty			= 0
	
End If

SetNull(l_n_HistQuantity)

select po_detail_history.quantity,
		 po_detail_history.received,
		 po_detail_history.balance 
into   :l_n_HistQuantity,
		 :l_n_HistReceived,
		 :l_n_HistBalance
from   po_detail_history  
where  ( po_detail_history.po_number = :a_l_PO ) and  
  	    ( po_detail_history.part_number = :a_s_part ) and  
     	 ( po_detail_history.row_id = :a_l_row_id )   ;

if l_n_HistQuantity > 0 then

	update po_detail_history  
	SET 	 received 				= :l_n_Received,   
     	    balance 				= :l_n_Balance,
			 standard_qty 			= :l_n_StdQty,
			 last_recvd_date 		= :dt_ldt_today,											// ADD 04-10-2000 KAZ
			 last_recvd_amount 	= :ldec_last_rec_amt										// ADD 04-10-2000 KAZ
  	where  ( po_number 		= :a_l_PO ) and  
  	     	 ( part_number 	= :a_s_part ) and  
     	  	 ( row_id = :a_l_row_id )   ;
				 
else		
		
	if isvalid ( u_new_recv_dock ) then

		dDueDate						= date ( u_new_recv_dock.dw_releases.GetItemDatetime(l_i_Row, "date_due") )
		l_n_Quantity				= u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "quantity")
		a_s_UM						= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "unit_of_measure")
		l_n_Price					= u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "price")
		l_i_Release					= u_new_recv_dock.dw_releases.GetItemNumber(l_i_Row, "release_no")
		l_s_Terms					= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "terms")
		l_s_Description			= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "description")
		l_i_WeekNo					= f_get_week_no(today())
		l_s_Requisition			= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "requisition_number")
		l_s_Account					= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "account_code")
		l_s_plant					= u_new_recv_dock.dw_releases.GetItemString(l_i_Row, "plant")
		ls_type						= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "type" )
//		ldec_last_rec_amt			= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "last_recvd_amount" )	// CHG 04-10-2000 KAZ
		ls_cross_ref_part			= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "cross_reference_part" )
		ls_notes						= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "notes" )
		ldec_active_rel_cum 		= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "active_release_cum" )
		ldec_rec_cum 				= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "received_cum" )
		ls_invoice_status			= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "invoice_status" )   
	  	ld_invoice_date   		= date ( u_new_recv_dock.dw_releases.GetItemDatetime  ( l_i_Row, "invoice_date" ) )
		ldec_invoice_qty   		= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "invoice_qty" )
  		ldec_invoice_unit_price	= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "invoice_unit_price" )   
		ls_ship_to_dest			= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "ship_to_destination" )
		ls_invoice_number			= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "invoice_number" )
		l_l_sales_order   		= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "sales_order" )

		l_l_dropship_oe_row_id	= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "dropship_oe_row_id" )
		ls_ship_type				= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "ship_type" )
		l_l_dropship_shipper		= u_new_recv_dock.dw_releases.GetItemNumber ( l_i_Row, "dropship_shipper" )
		ls_price_unit				= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "price_unit" )
		ls_ship_via					= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "ship_via" )	
		ls_release_type			= u_new_recv_dock.dw_releases.GetItemString ( l_i_Row, "release_type" )
		
	Else
		
		dDueDate						= date ( dw_release_display.GetItemDatetime(l_i_Row, "date_due") )
		l_n_Quantity				= dw_release_display.GetItemNumber(l_i_Row, "quantity")
		a_s_UM						= dw_release_display.GetItemString(l_i_Row, "unit_of_measure")
		l_n_Price					= dw_release_display.GetItemNumber(l_i_Row, "price")
		l_i_Release					= dw_release_display.GetItemNumber(l_i_Row, "release_no")
		l_s_Terms					= dw_release_display.GetItemString(l_i_Row, "terms")
		l_s_Description			= dw_release_display.GetItemString(l_i_Row, "description")
		l_i_WeekNo					= f_get_week_no(today())
		l_s_Requisition			= dw_release_display.GetItemString(l_i_Row, "requisition_number")
		l_s_Account					= dw_release_display.GetItemString(l_i_Row, "account_code")
		l_s_plant					= dw_release_display.GetItemString(l_i_Row, "plant")
		ls_type						= dw_release_display.GetItemString ( l_i_Row, "type" )
//		ldec_last_rec_amt			= dw_release_display.GetItemNumber ( l_i_Row, "last_recvd_amount" )	// CHG 04-10-2000 KAZ
		ls_cross_ref_part			= dw_release_display.GetItemString ( l_i_Row, "cross_reference_part" )
		ls_notes						= dw_release_display.GetItemString ( l_i_Row, "notes" )
		ldec_active_rel_cum 		= dw_release_display.GetItemNumber ( l_i_Row, "active_release_cum" )
		ldec_rec_cum 				= dw_release_display.GetItemNumber ( l_i_Row, "received_cum" )
		ls_invoice_status			= dw_release_display.GetItemString ( l_i_Row, "invoice_status" )   
	  	ld_invoice_date   		= date ( dw_release_display.GetItemDatetime  ( l_i_Row, "invoice_date" ) )
		ldec_invoice_qty   		= dw_release_display.GetItemNumber ( l_i_Row, "invoice_qty" )
  		ldec_invoice_unit_price	= dw_release_display.GetItemNumber ( l_i_Row, "invoice_unit_price" )   
		ls_ship_to_dest			= dw_release_display.GetItemString ( l_i_Row, "ship_to_destination" )
		ls_invoice_number			= dw_release_display.GetItemString ( l_i_Row, "invoice_number" )
		l_l_sales_order   		= dw_release_display.GetItemNumber ( l_i_Row, "sales_order" )
		l_l_dropship_oe_row_id	= dw_release_display.GetItemNumber ( l_i_Row, "dropship_oe_row_id" )
		ls_ship_type				= dw_release_display.GetItemString ( l_i_Row, "ship_type" )
		l_l_dropship_shipper		= dw_release_display.GetItemNumber ( l_i_Row, "dropship_shipper" )
		ls_price_unit				= dw_release_display.GetItemString ( l_i_Row, "price_unit" )
		ls_ship_via					= dw_release_display.GetItemString ( l_i_Row, "ship_via" )	
		ls_release_type			= dw_release_display.GetItemString ( l_i_Row, "release_type" )
		
	End If
	
   dt_dduedate             = datetime(dduedate)

	insert into po_detail_history  
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
	        price,   
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
	        printed,   
	        selected_for_print,   
	        deleted,
			  ship_via,
			  release_type,
			  alternate_price)  
	VALUES ( :a_l_PO,   
	         :szVendor,   
	         :a_s_part,   
	         :l_s_Description,   
	         :a_s_UM,   
	         :dt_dDueDate,   
	         :l_s_Requisition,   
	         'C',   
	         :ls_type,   
	         :dt_ldt_today,   
	         :ldec_last_rec_amt,   
	         :ls_cross_ref_part,   
	         :l_s_Account,   
	         :ls_notes,   
	         :l_n_Quantity,   
	         :l_n_Received,   
	         :l_n_Balance,   
	         :ldec_active_rel_cum,   
	         :ldec_rec_cum,   
	         :l_n_Price,   
	         :a_l_row_id,   
	        	:ls_invoice_status,   
	        	:ld_invoice_date,   
	        	:ldec_invoice_qty,   
	        	:ldec_invoice_unit_price,   
	         :l_i_Release,   
	        	:ls_ship_to_dest,   
	         :l_s_Terms,   
	         :l_i_WeekNo,   
	         :l_s_plant,   
	         :ls_invoice_number,   
	         :l_n_StdQty,   
	        	:l_l_sales_order,   
	        	:l_l_dropship_oe_row_id,   
	        	:ls_ship_type,   
	        	:l_l_dropship_shipper,   
	        	:ls_price_unit,   
				null,
				null,
				null,
				:ls_ship_via,
				:ls_release_type,
				:l_n_price) ;

end if
	
bOK	= (SQLCA.SQLCode = 0)

return  bOk

end function

public function boolean wf_outside_serial (long a_l_serial);/* 03-30-2000 KAZ Created to determine whether serial was an outside process.  Issue # 13232 */

String	i_s_remarks

Select	remarks
Into		:i_s_remarks
From		audit_trail
Where		serial 	= :a_l_serial
And		type		= 'O';

If SQLCA.SQLCode <> 0 then Return False

If i_s_remarks = 'Out Proc' Then 
	Return True
ELse
	Return False
End IF


end function

public function boolean wf_create_op_audit_trail (long a_l_serial);BOOLEAN	 l_b_Process

DATAStoRE	dw_serial
dw_serial	= CREATE DATAStoRE
dw_serial.dataobject 		= 'd_audit_trail_last_rec_outside'
dw_serial.Settransobject ( SQLCA )

// Modified the if condition to not update part online table if the object has a quality alert. 
// if not a non-inventory item
if (not szPartClass = 'N') and bReoccuringItem and szqa <> 'Y' then	
	f_update_onhand(szPart, nStdQty, "*") // "+" ) // changed this so that the objects are not committed before audit trail is committed.. 
end if

stTransParm.value1	= szGLAccount
stTransParm.value2	= szPartName
stTransParm.value3	= is_operator
stTransParm.value4	= szPlant
stTransParm.value5	= String(nUnitPrice)
stTransParm.value6	= String(dFirstPODate)
stTransParm.value7	= String(nStdQty)
stTransParm.value8	= String(iRelease)

//	String(nCost), & - szValue7 

if f_create_audit_trail(a_l_serial, "R", &
	String(iPo), &
	szVendor, &
	szControlNumber, &
	szShipper, &
	szPart, &
	String(nQty), & 
	String(nUnitPrice), &
	szLocationto, &
	szUM, &
	'No Commit') then

	if dw_serial.Retrieve ( a_l_Serial ) > 0 then

		// check if the part vendor is an outside process  - mb 08/6/99 
		if dw_serial.object.outside_process[1] = 'Y' then
			// if outserial is used then reconcile the object immediately
			if bscanexternal then
				dw_serial.SetItem ( 1, "status", 'C' )
			else
				dw_serial.SetItem ( 1, "status", 'P' )
			end if
		end if

		// inc by gph on 5/13/98 as these columns weren't getting populated,
		// also added the columns in the datawindow
	
		dw_serial.SetItem ( 1, "custom1", szcustom1 )
		dw_serial.SetItem ( 1, "custom2", szcustom2 )
		dw_serial.SetItem ( 1, "custom3", szcustom3 )
		dw_serial.SetItem ( 1, "custom4", szcustom4 )		
		dw_serial.SetItem ( 1, "custom5", szcustom5 )		
	
		if  dw_serial.update ( ) = -1 then
			destroy dw_Serial
			return false
		end if
	end if

	destroy dw_Serial

	if not cbx_line_item.Checked then
		if wf_update_po(szUM, szPOUnit, szPart, nQty) then
			return true
		else
			return false
		end if
	else
		return true
	end if
else
	return false
end if
end function

public function integer wf_update_part_vendor (string as_part, string as_vendor, string as_um, decimal adec_quantity);dec		ldec_stdqty

ldec_stdqty = f_convert_units ( as_um, '', as_part, adec_quantity )

update 	part_vendor  
SET 	accum_received = isnull(accum_received,0) + isnull(:ldec_stdqty,0)
where 	( part_vendor.part = :as_part ) and  
		( part_vendor.vendor = :as_vendor )   ;

return sqlca.sqlcode
end function

event activate;
m_receiving_dock.m_file.m_newpallet.toolbarItemVisible	= cbx_pallet.checked

// enable/disable receive and show grid buttons depending on user object's validity
if not isvalid(u_new_recv_dock) then
	m_receiving_dock.mf_display (false)
else
	m_receiving_dock.mf_display (true)
end if


end event

event open;sParm		= Message.PowerObjectParm

// get values from purchasing if the screen is opened from purchasing
iPO						= Long(sParm.value1)
st_po_plant.text		= sParm.value2
st_po_plant.visible	= false

bRecalc	= (iPO > 0)

bfromMRD	= (iPO = -1)

// get vendor list
wf_get_vendors()

// set up the screen
wf_enable_screen(false)

// check if the shipper is required
wf_shipper_required() 

gf_get_info ( 'w_visual_receiving_dock_version2', 0 )





end event

on w_visual_receiving_dock_version2.create
int iCurrent
call super::create
if this.MenuName = "m_receiving_dock" then this.MenuID = create m_receiving_dock
this.dw_vendors=create dw_vendors
this.dw_release_display=create dw_release_display
this.cbx_line_item=create cbx_line_item
this.st_po_plant=create st_po_plant
this.st_5=create st_5
this.cbx_retrieve=create cbx_retrieve
this.dw_objects=create dw_objects
this.dw_objects_on_pallet=create dw_objects_on_pallet
this.sle_pallet=create sle_pallet
this.sle_shipper=create sle_shipper
this.st_4=create st_4
this.st_3=create st_3
this.sle_password=create sle_password
this.p_pallet=create p_pallet
this.st_2=create st_2
this.sle_po=create sle_po
this.st_1=create st_1
this.cbx_pallet=create cbx_pallet
this.gb_2=create gb_2
this.gb_pallet=create gb_pallet
this.gb_po=create gb_po
this.dw_pallet_object_info=create dw_pallet_object_info
this.gb_5=create gb_5
this.dw_range_weights=create dw_range_weights
this.dw_active_po_per_vendor=create dw_active_po_per_vendor
this.st_part=create st_part
this.dw_recvd_objects=create dw_recvd_objects
this.gb_7=create gb_7
this.dw_crosstab=create dw_crosstab
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_vendors
this.Control[iCurrent+2]=this.dw_release_display
this.Control[iCurrent+3]=this.cbx_line_item
this.Control[iCurrent+4]=this.st_po_plant
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.cbx_retrieve
this.Control[iCurrent+7]=this.dw_objects
this.Control[iCurrent+8]=this.dw_objects_on_pallet
this.Control[iCurrent+9]=this.sle_pallet
this.Control[iCurrent+10]=this.sle_shipper
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.sle_password
this.Control[iCurrent+14]=this.p_pallet
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.sle_po
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.cbx_pallet
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.gb_pallet
this.Control[iCurrent+21]=this.gb_po
this.Control[iCurrent+22]=this.dw_pallet_object_info
this.Control[iCurrent+23]=this.gb_5
this.Control[iCurrent+24]=this.dw_range_weights
this.Control[iCurrent+25]=this.dw_active_po_per_vendor
this.Control[iCurrent+26]=this.st_part
this.Control[iCurrent+27]=this.dw_recvd_objects
this.Control[iCurrent+28]=this.gb_7
this.Control[iCurrent+29]=this.dw_crosstab
this.Control[iCurrent+30]=this.gb_3
end on

on w_visual_receiving_dock_version2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_vendors)
destroy(this.dw_release_display)
destroy(this.cbx_line_item)
destroy(this.st_po_plant)
destroy(this.st_5)
destroy(this.cbx_retrieve)
destroy(this.dw_objects)
destroy(this.dw_objects_on_pallet)
destroy(this.sle_pallet)
destroy(this.sle_shipper)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_password)
destroy(this.p_pallet)
destroy(this.st_2)
destroy(this.sle_po)
destroy(this.st_1)
destroy(this.cbx_pallet)
destroy(this.gb_2)
destroy(this.gb_pallet)
destroy(this.gb_po)
destroy(this.dw_pallet_object_info)
destroy(this.gb_5)
destroy(this.dw_range_weights)
destroy(this.dw_active_po_per_vendor)
destroy(this.st_part)
destroy(this.dw_recvd_objects)
destroy(this.gb_7)
destroy(this.dw_crosstab)
destroy(this.gb_3)
end on

type dw_vendors from datawindow within w_visual_receiving_dock_version2
integer x = 617
integer y = 84
integer width = 453
integer height = 96
integer taborder = 20
string dataobject = "d_vendor_drop_down"
boolean border = false
boolean livescroll = true
end type

event rbuttondown;MessageBox(monsys.msg_title, "Click on the pull down arrow to access your list of " + &
				"vendors. Use the up and down arrows to scroll through the list. " + &
				"Click on the appropriate vendor to select. The system will search " + &
				"for active purchase orders.")
end event

event itemchanged;int	li_count=0
dw_active_po_per_vendor.visible = false
sle_shipper.Text = ''
dw_vendors.AcceptText ( )
szVendor	= object.code[1]

// Inc on 7/24/02 
select	isnull(count(1),0)
into	:li_count
from	po_header
where	vendor_code = :szvendor and po_number = :ipo ;
if li_count = 0 and ipo > 0 then 
	Messagebox ( monsys.msg_title, "Invalid po number for the specified vendor, Please select the right PO for this vendor")
	ipo = 0
	sle_po.text = ''	
end if 	
// Inc on 7/24/02 issue no 13623

dw_active_po_per_vendor.Retrieve(szVendor)
dw_active_po_per_vendor.visible	= true
sle_shipper.text = ''



end event

event doubleclicked;/* 02-10-2000 KAZ Added code to redisplay active POs for the vendor if user wants to 
						select a different one than previously selected.  Issue # 13143 */

dw_active_po_per_vendor.visible = false																		// ADD 02-10-2000 KAZ

if dw_Vendors.textline () <> ' ' then dw_active_po_per_vendor.Retrieve(szVendor)					// ADD 02-10-2000 KAZ
if dw_Vendors.textline () <> ' ' then dw_active_po_per_vendor.visible	= true					// ADD 02-10-2000 KAZ
if dw_Vendors.textline () <> ' ' then sle_shipper.Text = ''												// ADD 02-10-2000 KAZ

end event

event clicked;If dw_active_po_per_vendor.visible Then dw_active_po_per_vendor.visible = false	
 
end event

event getfocus;dw_active_po_per_vendor.visible = false
end event

event editchanged;dw_active_po_per_vendor.visible = false	
sle_shipper.text = ''
end event

type dw_release_display from datawindow within w_visual_receiving_dock_version2
boolean visible = false
integer x = 23
integer y = 1008
integer width = 2304
integer height = 388
integer taborder = 140
boolean titlebar = true
string title = "PO Detail Releases"
string dataobject = "dw_line_item_release_display"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;selectRow ( This, 0, false )
selectRow ( This, row, true )


end event

event constructor;settransobject ( sqlca )
end event

type cbx_line_item from checkbox within w_visual_receiving_dock_version2
integer x = 27
integer y = 324
integer width = 549
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Line Item receiving "
end type

type st_po_plant from statictext within w_visual_receiving_dock_version2
integer x = 777
integer y = 324
integer width = 283
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
boolean focusrectangle = false
end type

type st_5 from statictext within w_visual_receiving_dock_version2
integer x = 654
integer y = 324
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
string text = "Plant"
boolean focusrectangle = false
end type

type cbx_retrieve from checkbox within w_visual_receiving_dock_version2
integer x = 2386
integer y = 52
integer width = 311
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Show all"
end type

event rbuttondown;MessageBox(monsys.msg_title, "Click on this box to activate the retrieve object " + &
				"by part functionality. When activated this option allows " + &
				"you to click on a part in the grid and the system will " + &
				"display the objects that have been received in the Object " + &
				"Info Window. You must also specify a shipper number for the search.")


end event

event clicked;STRING  	ls_part, &
			ls_unit, &
			ls_type

LONG		ll_count, &
			ll_Serial, &
			ll_row
			
DEC 		l_n_qty
		
DATAStoRE l_ds_objects

l_ds_objects = CREATE DATAStoRE

if not bPalletMode then

	choose CASE dw_range_weights.Rowcount()

		CASE 1
			
			if this.checked = true then 
				gnv_App.of_GetFrame().SetMicroHelp ( 'Retreiving Objects...' )
				dw_recvd_objects.reset()
				l_ds_objects.dataobject = 'dw_audit_trail_per_po_and_per_shipper'
				l_ds_objects.SetTransObject ( SQLCA )
				st_part.text = dw_range_weights.object.#1[1]
				l_ds_objects.Retrieve ( String(iPO), sle_shipper.text, dw_range_weights.object.#1[1] )
			
				for ll_count = 1 to l_ds_objects.Rowcount() 
						ll_serial 	= l_ds_objects.object.#1 [ll_count]
						l_n_qty 		= l_ds_objects.object.#2 [ll_count]
						ls_unit		= l_ds_objects.object.#3 [ll_count]
						ls_type		= l_ds_objects.object.#4 [ll_count]
						ll_row = dw_recvd_objects.insertrow (0)
						dw_recvd_objects.object.serial[ll_row] = ll_serial
						dw_recvd_objects.object.qnty [ll_row] = l_n_Qty
						dw_recvd_objects.object.unit [ll_row] = ls_unit
						dw_recvd_objects.object.type [ll_row] = ls_type
					next
	
				destroy l_ds_objects ;
			else
				dw_recvd_objects.reset()				
			end if 
				
		
		case else
			if this.checked = true then this.checked = false
			Messagebox ( monsys.msg_title, "You have to click on the part you want to view objects for!" )
		
	end choose

end if

//if this.checked = false then 
//	this.checked = true
//else
//	this.checked = false
//end if 

gnv_App.of_GetFrame().SetMicroHelp ( 'Ready' )

end event

type dw_objects from datawindow within w_visual_receiving_dock_version2
integer x = 1586
integer y = 64
integer width = 741
integer height = 320
integer taborder = 90
string dragicon = "BOX.ICO"
string dataobject = "dw_visual_objects"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;LONG 	l_i_Col

l_i_Col	= THIS.GetClickedColumn()

bDragObject	= false

if (Row > 0) and (l_i_Col > 0) then

	iSerial	= THIS.GetItemNumber ( Row, l_i_Col )		
	dw_pallet_object_info.Retrieve ( iSerial )
	if dw_pallet_object_info.RowCount() > 0 then
		st_part.text	= dw_pallet_object_info.GetItemString(1, "part")
	end if 
	if GetItemNumber(Row, "flag" + String(l_i_Col)) = 1 then
		bDragObject	= true
		dw_objects.Drag(begin!)
	end if
end if
end event

event rbuttondown;MessageBox(monsys.msg_title, "This resizable area shows a visual representation " + &
			  	"of objects received on a pallet. if you want to delete an " + & 
				"object simply double click on the serial number to highlight. " + &
				"After you highlight the object you want to delete simply click, " + &
				"hold and drag box to the trash can.")

end event

event doubleclicked;Long 	l_i_Col

Integer l_i_Flag

l_i_Col	= this.GetClickedColumn()

if (Row > 0)  and (l_i_Col > 0) then
	
	l_i_Flag	= f_get_value(this.GetItemNumber(Row, "flag" + String(l_i_Col)))
	if l_i_Flag	= 0 then
		l_i_Flag	= 1
	else
		l_i_Flag	= 0
	end if
	this.SetItem(Row, "flag" + String(l_i_Col), l_i_Flag)

end if
end event

event constructor;settransobject ( sqlca )
end event

type dw_objects_on_pallet from datawindow within w_visual_receiving_dock_version2
boolean visible = false
integer x = 1563
integer y = 1472
integer width = 357
integer height = 288
integer taborder = 170
string dataobject = "dw_objects_on_pallet_mpo"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type sle_pallet from singlelineedit within w_visual_receiving_dock_version2
boolean visible = false
integer x = 1221
integer y = 220
integer width = 229
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean hideselection = false
end type

event modified;Long l_l_Serial
Long l_l_ObjectSerial

l_l_Serial	= Long(this.text)

SetNull(l_l_ObjectSerial)

select object.serial  
  into :l_l_ObjectSerial  
  from object  
 where ( object.serial = :l_l_Serial ) and  
       ( object.type = 'S' )   ;

if IsNull(l_l_ObjectSerial) then
	bPalletMode					= false
	MessageBox(monsys.msg_title, "No such pallet in system!", StopSign!)
	return
else
	iPallet						= l_l_ObjectSerial
	sle_pallet.text			= String(iPallet)
	sle_pallet.bringtotop	= true
	bPalletMode					= true
	wf_draw_objects_on_pallet(iPallet)
end if

end event

event rbuttondown;MessageBox(monsys.msg_title, "if you want to receive objects to an existing pallet, please enter the pallet # here")

end event

type sle_shipper from singlelineedit within w_visual_receiving_dock_version2
integer x = 32
integer y = 228
integer width = 544
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
integer limit = 20
end type

event rbuttondown;MessageBox(monsys.msg_title, "Here you enter the shipper # from your vendor's packing slip")
end event

event modified;if text = '' or isnull ( text ) then

	if i_b_shipper_required then
		MESSAGEBOX ( monsys.msg_title, "You must enter a valid Shipper Number!" ) 
		return
	end if

else
	
	szShipper = Text

end if


end event

type st_4 from statictext within w_visual_receiving_dock_version2
integer x = 192
integer y = 172
integer width = 229
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Shipper"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_visual_receiving_dock_version2
integer x = 192
integer y = 36
integer width = 247
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Operator"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_visual_receiving_dock_version2
integer x = 32
integer y = 84
integer width = 544
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
end type

event modified;String l_s_Password
String l_s_Operator

SetNull(l_s_Operator)
l_s_Password	= THIS.text

select employee.operator_code  
  into :l_s_Operator  
  from employee  
 where employee.password = :l_s_Password   ;

if IsNull(l_s_Operator) or LenA(trim(l_s_operator)) = 0 then
	MessageBox(monsys.msg_title, "Invalid operator password!", StopSign!)
	THIS.text	= ''
	this.Setfocus ()
	bRightPassword	= false
	return -1
else
	bRightPassword	= true
	THIS.text		= l_s_Operator
	wf_enable_screen(true)
	sle_po.Setfocus ()
	
	if iPO > 0 then
		wf_line_item()
		wf_auto_display_info()
	end if
end if
end event

event rbuttondown;MessageBox(monsys.msg_title, "Enter your operator password")
end event

type p_pallet from picture within w_visual_receiving_dock_version2
boolean visible = false
integer x = 1253
integer y = 124
integer width = 160
integer height = 144
string picturename = "pallet.bmp"
boolean focusrectangle = false
end type

type st_2 from statictext within w_visual_receiving_dock_version2
integer x = 741
integer y = 172
integer width = 229
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "P.O."
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_po from singlelineedit within w_visual_receiving_dock_version2
integer x = 617
integer y = 228
integer width = 453
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
end type

event modified;/* 02-11-2000 KAZ Modified to clear shipper field if user changes the PO number. Issue # 13160. */

iPO			= Long(THIS.text)
szVendor		= wf_get_active_vendor(iPO)




if ISNULL ( szVendor ) then
	MessageBox(monsys.msg_title, "Purchase order " + this.text + " does not exist!", StopSign!)
else
	st_po_plant.text	= wf_get_po_plant_code(iPO)
	dw_vendors.object.code[1] = szVendor
	dw_crosstab.Retrieve ( iPO, datetime ( today() ) )
	wf_line_item()
	// display the releases grid if po is switched
	parent.event ue_show_grid( )

	// clear out shipper number field if PO is switched													-  ADD 02-11-2000 KAZ
	sle_shipper.text = ''																							// ADD 02-11-2000 KAZ

end if

end event

event rbuttondown;MessageBox(monsys.msg_title, "Enter the purchase order number")
end event

event getfocus;dw_active_po_per_vendor.visible = false
end event

type st_1 from statictext within w_visual_receiving_dock_version2
integer x = 750
integer y = 36
integer width = 229
integer height = 44
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Vendors"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_pallet from checkbox within w_visual_receiving_dock_version2
integer x = 1111
integer y = 60
integer width = 434
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Place on Pallet"
end type

event clicked;m_receiving_dock.m_file.m_newpallet.toolbarItemVisible	= this.checked

if this.checked then
	dw_pallet_object_info.reset () 	
	p_pallet.visible				= true
	iPallet							= 0
	sle_pallet.text				= ''
	bPalletMode						= true
	sle_pallet.visible			= true
	dw_recvd_objects.visible		= false
	dw_pallet_object_info.visible		= true
	dw_pallet_object_info.Bringtotop	= true
else
	bPalletMode						= false
	iPallet							= 0
	p_pallet.visible				= false
	sle_pallet.visible			= false
	dw_recvd_objects.visible	= true
	dw_recvd_objects.Bringtotop= true
	dw_recvd_objects.Reset ()
	dw_pallet_object_info.visible = false
	dw_objects.Reset()
end if


end event

event rbuttondown;MessageBox(monsys.msg_title, "if you want to receive objects to a pallet, please check here")
end event

type gb_2 from groupbox within w_visual_receiving_dock_version2
integer x = 1093
integer width = 471
integer height = 416
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Mode"
end type

type gb_pallet from groupbox within w_visual_receiving_dock_version2
integer x = 1559
integer width = 782
integer height = 416
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Pallet"
end type

type gb_po from groupbox within w_visual_receiving_dock_version2
integer x = 599
integer width = 489
integer height = 416
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "P.O."
end type

type dw_pallet_object_info from datawindow within w_visual_receiving_dock_version2
boolean visible = false
integer x = 2373
integer y = 468
integer width = 503
integer height = 932
integer taborder = 150
string dragicon = "BOX.ICO"
string dataobject = "dw_object_info_mpo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject ( sqlca )
end event

type gb_5 from groupbox within w_visual_receiving_dock_version2
integer width = 594
integer height = 416
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Info"
end type

type dw_range_weights from datawindow within w_visual_receiving_dock_version2
boolean visible = false
integer x = 37
integer y = 1460
integer width = 1358
integer height = 292
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_range_weights"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_active_po_per_vendor from datawindow within w_visual_receiving_dock_version2
boolean visible = false
integer x = 622
integer y = 384
integer width = 2071
integer height = 480
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_active_po_per_vendor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Long iRow

iPO	= 0
iRow	= THIS.GetClickedRow()

if (iRow > 0) then

	iPO					= THIS.GetItemNumber(iRow, "po_number")
	st_po_plant.text	= THIS.GetItemString(iRow, "plant")

	if not ISNULL(iPO) then

		sle_po.text	= STRING ( iPO )
		st_po_plant.text	= wf_get_po_plant_code(iPO)
		dw_vendors.object.code[1] = szVendor
		dw_crosstab.Retrieve ( iPO, datetime ( today() ) )

		if dw_crosstab.RowCount() = 0 then
			MessageBox ( monsys.msg_title, "There are no active requirements for vendor " + szVendor, StopSign! )
		end if

		wf_line_item ( )
		parent.event ue_show_grid( )

	end if

	THIS.visible	=  false

end if




end event

event constructor;settransobject ( sqlca )
sle_shipper.text = ''

end event

type st_part from statictext within w_visual_receiving_dock_version2
integer x = 2437
integer y = 100
integer width = 384
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
boolean focusrectangle = false
end type

type dw_recvd_objects from datawindow within w_visual_receiving_dock_version2
integer x = 2377
integer y = 172
integer width = 503
integer height = 1232
integer taborder = 160
string dataobject = "d_objects_received_against_po"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// highlight the row 
if row > 0 then
	
	if isselected ( row ) then 
		selectrow ( row, false )
	else
		selectrow ( row, true )
	end if
	
end if
end event

type gb_7 from groupbox within w_visual_receiving_dock_version2
integer x = 2359
integer width = 544
integer height = 1424
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Object Info"
end type

type dw_crosstab from u_dw_crosstab_gss within w_visual_receiving_dock_version2
integer x = 9
integer y = 468
integer width = 2327
integer height = 940
integer taborder = 60
string dragicon = "Box.ico"
string dataobject = "dw_crosstab_for_receiving_dock"
boolean vscrollbar = true
end type

event constructor;call super::constructor;settransobject ( sqlca )
i_ds_range = CREATE u_ds_range
i_ds_range.uf_set_source ( DataObject )
end event

event rbuttondown;call super::rbuttondown;if cbx_line_item.Checked and not ib_line_item_selected then
	
	MessageBox ( monsys.msg_title, "Choose a part number to display a list of releases for that part." )

elseif cbx_line_item.Checked and ib_line_item_selected then
	
	MessageBox ( monsys.msg_title, "Choose a release to receive objects against." )

else
	
	MessageBox( monsys.msg_title, "Enter in the Quantity per Object, Number of Objects, Lot Number, and all other information field prompts. After you have " + &
				  "entered the necessary information for all parts being received, simply click and hold anywhere on the grid and drag the box to the " + &
				  "location to receive. The system will process your request.")

end if
end event

event destructor;call super::destructor;destroy i_ds_range
end event

event ue_object_change;INTEGER	l_i_column, &
			l_i_count
			
l_i_column = newcolumn

iCrossTabCol = l_i_column
iCrossTabRow = newrow

if newrow > 0 and l_i_column > 1 then

	nQty = 0

	if not ( IsNull(dw_crosstab.object.data [ newrow, l_i_count ] ) ) then
		nQty = nQty + dw_crosstab.object.data [ newrow, l_i_count ]
	end if

	Parent.SetMicroHelp ( "Drag releases to receive objects" )

end if


end event

event ue_range_change;LONG	l_l_row

INTEGER	l_i_count

STRING	l_s_part, &
			l_s_last_part

dw_range_weights.Reset ( )
i_ds_range.uf_import_range ( range )
for l_l_row = 1 to i_ds_range.RowCount ( )
	if i_ds_range.object.range_row [ l_l_row ] > 0 then
		l_s_part = dw_crosstab.object.data [ i_ds_range.object.range_row  [ l_l_row ], 1 ]
		if l_s_part <> l_s_last_part then
			nQty = 0
			for l_i_count = 4 to i_ds_range.object.max_column  [ l_l_row ]
				if not ( IsNull(dw_crosstab.object.data [ i_ds_range.object.range_row  [ l_l_row ], l_i_count ] ) ) then
					nQty = nQty + dw_crosstab.object.data [ i_ds_range.object.range_row  [ l_l_row ], l_i_count ]
				end if
			next
			dw_range_weights.insertRow ( 1 )
			dw_range_weights.object.part [ 1 ] = l_s_part
			dw_range_weights.object.part_qty [ 1 ] = Dec ( nQty )
			end if
		l_s_last_part = l_s_part
	end if
next

dw_range_weights.insertRow ( 1 )
dw_range_weights.DeleteRow ( 1 )

// if row selected then enable the show grid menu button  
if gnv_App.of_GetFrame().menuname = "m_receiving_dock" then
	if dw_range_weights.rowcount() > 0 then
		m_receiving_dock.m_edit.m_showrecvpopup.enabled = true
	else
		m_receiving_dock.m_edit.m_showrecvpopup.enabled = false
	end if
end if
end event

event dragdrop;call super::dragdrop;//bDragObject	= false
//bDragPO		= false
end event

event clicked;// included this code to over ride ancestor script and not initiate drag drop 

if LenA(trim(sle_password.text)) = 0 then
	Messagebox ( monsys.msg_title, "Invalid Operator Password, Please enter that and then proceed further")
	sle_password.setfocus()
	Return -1
end if 	

i_b_lbutton = true

if KeyDown ( KeyControl! ) and not i_b_control then
	trigger event key ( KeyControl!, 0 )
end if
i_b_control = KeyDown ( KeyControl! )
if not i_b_control then
	if Upper ( dwo.type ) = "COLUMN" then
		trigger event ue_range_change ( String ( row ) + "/" + String ( row ) + "/" + dwo.Name )
	else
		trigger event ue_range_change ( "" )
	end if
end if
end event

type gb_3 from groupbox within w_visual_receiving_dock_version2
integer y = 416
integer width = 2345
integer height = 1008
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "PO Releases "
end type


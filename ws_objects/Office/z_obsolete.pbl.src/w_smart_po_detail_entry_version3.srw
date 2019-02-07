$PBExportHeader$w_smart_po_detail_entry_version3.srw
$PBExportComments$The smart po detail data entry window (version3)
forward
global type w_smart_po_detail_entry_version3 from w_sheet_4t
end type
type st_18 from statictext within w_smart_po_detail_entry_version3
end type
type p_3 from picture within w_smart_po_detail_entry_version3
end type
type st_part_name from statictext within w_smart_po_detail_entry_version3
end type
type st_16 from statictext within w_smart_po_detail_entry_version3
end type
type st_vendor_part from statictext within w_smart_po_detail_entry_version3
end type
type st_15 from statictext within w_smart_po_detail_entry_version3
end type
type p_2 from picture within w_smart_po_detail_entry_version3
end type
type st_1 from statictext within w_smart_po_detail_entry_version3
end type
type sle_lead_time from singlelineedit within w_smart_po_detail_entry_version3
end type
type st_14 from statictext within w_smart_po_detail_entry_version3
end type
type st_11 from statictext within w_smart_po_detail_entry_version3
end type
type st_9 from statictext within w_smart_po_detail_entry_version3
end type
type st_8 from statictext within w_smart_po_detail_entry_version3
end type
type st_7 from statictext within w_smart_po_detail_entry_version3
end type
type st_6 from statictext within w_smart_po_detail_entry_version3
end type
type st_5 from statictext within w_smart_po_detail_entry_version3
end type
type sle_min_order_qty from singlelineedit within w_smart_po_detail_entry_version3
end type
type sle_min_on_hand from singlelineedit within w_smart_po_detail_entry_version3
end type
type st_4 from statictext within w_smart_po_detail_entry_version3
end type
type dw_template from datawindow within w_smart_po_detail_entry_version3
end type
type st_2 from statictext within w_smart_po_detail_entry_version3
end type
type sle_mps_uncovered from singlelineedit within w_smart_po_detail_entry_version3
end type
type st_13 from statictext within w_smart_po_detail_entry_version3
end type
type sle_mps_covered from singlelineedit within w_smart_po_detail_entry_version3
end type
type st_10 from statictext within w_smart_po_detail_entry_version3
end type
type dw_price_matrix from datawindow within w_smart_po_detail_entry_version3
end type
type lb_um from listbox within w_smart_po_detail_entry_version3
end type
type st_over_received from statictext within w_smart_po_detail_entry_version3
end type
type sle_1 from singlelineedit within w_smart_po_detail_entry_version3
end type
type st_12 from statictext within w_smart_po_detail_entry_version3
end type
type dw_po_detail from u_smart_po_detail_dw within w_smart_po_detail_entry_version3
end type
type dw_mps_demand from u_monitor_data_entry_dw within w_smart_po_detail_entry_version3
end type
type uo_hard_queue from u_po_detail_hard_queue_coverage within w_smart_po_detail_entry_version3
end type
type st_17 from statictext within w_smart_po_detail_entry_version3
end type
type st_release from statictext within w_smart_po_detail_entry_version3
end type
type p_1 from picture within w_smart_po_detail_entry_version3
end type
type cb_create from commandbutton within w_smart_po_detail_entry_version3
end type
type gb_4 from groupbox within w_smart_po_detail_entry_version3
end type
type gb_1 from groupbox within w_smart_po_detail_entry_version3
end type
type cb_note from commandbutton within w_smart_po_detail_entry_version3
end type
end forward

global type w_smart_po_detail_entry_version3 from w_sheet_4t
integer height = 1560
string title = "PO Detail Entry"
string menuname = "m_smart_po_detail"
event batch pbm_custom01
event print pbm_custom02
event add pbm_custom03
event delete_release pbm_custom04
event save_release pbm_custom05
event exit_release pbm_custom06
event objects pbm_custom07
event history pbm_custom08
event start_to_print_po pbm_custom09
event setup_parts_for_print pbm_custom10
event close_uo_for_print pbm_custom11
event refresh_screen pbm_custom12
event set_release pbm_custom13
event ue_refresh_releases pbm_custom14
event show_notes pbm_custom15
event ue_demand_from_hard_queue pbm_custom16
event ue_print_update pbm_custom17
event ue_save_batch ( datawindow a_dw )
event ue_save_note pbm_custom18
event ue_close_uo_note pbm_custom19
st_18 st_18
p_3 p_3
st_part_name st_part_name
st_16 st_16
st_vendor_part st_vendor_part
st_15 st_15
p_2 p_2
st_1 st_1
sle_lead_time sle_lead_time
st_14 st_14
st_11 st_11
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
sle_min_order_qty sle_min_order_qty
sle_min_on_hand sle_min_on_hand
st_4 st_4
dw_template dw_template
st_2 st_2
sle_mps_uncovered sle_mps_uncovered
st_13 st_13
sle_mps_covered sle_mps_covered
st_10 st_10
dw_price_matrix dw_price_matrix
lb_um lb_um
st_over_received st_over_received
sle_1 sle_1
st_12 st_12
dw_po_detail dw_po_detail
dw_mps_demand dw_mps_demand
uo_hard_queue uo_hard_queue
st_17 st_17
st_release st_release
p_1 p_1
cb_create cb_create
gb_4 gb_4
gb_1 gb_1
cb_note cb_note
end type
global w_smart_po_detail_entry_version3 w_smart_po_detail_entry_version3

type variables
Long iPO                //The current po number
Long iPODetailRow  = 0 //The po detail datawindow row #
Long iMPSRow       //The MPS row
Long iHistoryRow    //The row for history
Long iMPSCovered  //MPS Covered
Long iMPSUnCovered //MPS Uncovered
Long iRelease	 //To keep the release number
Long i_l_next_row_id
Long il_row_add=0
int  il_rowid
Int  i_period


String szPart           //Part number
String szUM            //To keep the unit of measure
String szPlant          //Plant code
String szShipTo       //Ship to destination code
String szTerms        //To keep terms
String szVendor	 //To keep the vendor code
String szGlAccount	 //To keep the GL account
String szShipType	 //To keep the ship type
String szShipVia	 //To keep the ship via

DatawindowChild	dwUM

Boolean bMPS        //Whether dragged MPS
Boolean bQuery      //Whether in query mode
Boolean bCheckMinOnOrder
Boolean bError = False      //Whether there are some errors
Boolean bNoInfo

Decimal nMinOnOrder
Decimal nOverreceived

st_generic_structure stParm

Date dDateDue
Date dDate7
Date dpodate

DataWindowChild    dwShipTo, &
		idw_child

Window wHostWindow

u_smart_po_printing_processor	uo_print

u_generic_note       uo_normal_note

boolean		ib_Marked_Deletion, &
		ib_data_changed





end variables

forward prototypes
public subroutine wf_create_unit_dddw ()
public function string wf_get_um ()
public function date wf_next_day (date dToday, integer iUnits, string szUnit)
public subroutine wf_post_serial (long iserial, string szbatch)
public subroutine wf_create_ship_to ()
public subroutine wf_create_mps_template ()
public subroutine wf_get_host_window (ref window wWin)
public function boolean wf_update_over_recved (string as_vendor, string as_part, decimal ac_over_received)
public function boolean wf_check_min_on_order ()
public function decimal wf_min_on_order ()
public subroutine wf_error (boolean ab_flag)
public function boolean wf_nonreocurring_item (string as_part)
public subroutine wf_delete_profile (string as_vendor, string as_part)
public function boolean wf_mark_deletion (long al_row, string as_part)
public subroutine wf_reset_demand_flywheel ()
public function boolean wf_assign_releases ()
public subroutine wf_reset_overreceived ()
public function boolean wf_partial_update_release (string a_s_vendor)
public function boolean wf_delete_marked_releases ()
public function boolean wf_update_overreceived (string a_s_Vendor, string a_s_part, decimal a_n_Qty)
public subroutine wf_update_release (string a_s_flag)
public function string wf_get_vendor_code (long al_po)
public subroutine wf_display_overreceived (string as_vendor, string as_part)
public subroutine wf_display_mps_covered (string as_part)
public function decimal wf_min_onorder (string as_part, string as_plant)
public function decimal wf_get_min_on_hand (string as_part, string as_plant)
public function decimal wf_get_lead_time (string as_part, string as_vendor)
public function string wf_get_vendor_part (string as_vendor, string as_part)
public function date wf_get_po_date (long al_po)
public subroutine wf_get_unit_of_measurement_part (string a_s_part)
public function decimal wf_get_price (decimal nqty, decimal an_price)
end prototypes

event batch;If IsNull(szUM) then
	MessageBox(monsys.msg_title, "Missing unit of measure, please set it up first.", StopSign!)
	Return
End If

If IsNull(szTerms) then
	MessageBox(monsys.msg_title, "Missing terms, please set them up first.", StopSign!)
	Return
End if

if wf_nonreocurring_item( szPart ) then
	MessageBox(monsys.msg_title, "Can not add release for non-reoccuring item.", Stopsign!)
	Return
else
	Openwithparm ( w_batch_release, this )
end if


end event

event print;Date dStartDate, dEndDate

If dw_po_detail.RowCount() > 0 then
	If iPO > 0 then
		dStartDate	= Date(dw_po_detail.GetItemDateTime(1, "date_due"))
		dEndDate	= Date(dw_po_detail.GetItemDateTime(dw_po_detail.RowCount(), "date_due"))
		OpenUserObject(uo_print, 622, 161)
		uo_print.visible		= TRUE
		uo_print.bringtotop	= TRUE
		uo_print.uf_setup(iPO, szPart, dStartDate, dEndDate )
		uo_print.taborder = 1
		uo_print.em_date_from.setfocus()		
	Else
		MessageBox(monsys.msg_title, "You should select a P.O. first.", StopSign!)
	End If
Else
	MessageBox(monsys.msg_title, "There are no detail items to print.", StopSign!)
End If
end event

event add;If IsNull(szUM) then
	MessageBox(monsys.msg_title, "Missing unit of measure, please set it up first.", StopSign!)
	Return
End If

If IsNull(szTerms) then
	MessageBox(monsys.msg_title, "Missing terms, please set them up first.", StopSign!)
	Return
End if

if wf_nonreocurring_item( szPart ) then
	MessageBox(monsys.msg_title, "Can not add release for non-reoccuring item.", Stopsign!)
	Return
end if

// MB 01/29/04 Included these lines to disable the batch button to avoid user enter incorrect data
if m_smart_po_detail.m_file.m_batchcreate.enabled = true  then &
	m_smart_po_detail.m_file.m_batchcreate.enabled = false
	
dw_po_detail.triggerevent( 'ue_insert' )
end event

event delete_release;If MessageBox(	monsys.msg_title, "System will set deletion mark to all " + &
					"highlighted releases. Continue to process?", StopSign!, &
					YesNo!) = 1 Then
	dw_po_detail.TriggerEvent("ue_delete")
End If







end event

event save_release;dw_po_detail.triggerevent ( "ue_save" )

// MB 01/29/04 Included these lines to enable the batch button after saving the release
if m_smart_po_detail.m_file.m_batchcreate.enabled = false  then &
	m_smart_po_detail.m_file.m_batchcreate.enabled = true

if isvalid( uo_hard_queue ) then
	if uo_hard_queue.visible then
		uo_hard_queue.uf_dw_share( this.dw_po_detail, TRUE )
		uo_hard_queue.dw_hard_queue.uf_retrieve( szPart )
		uo_hard_queue.uf_coverage()
		uo_hard_queue.uf_dw_share( this.dw_po_detail, FALSE )
	end if
end if
end event

event exit_release;boolean	lb_exit

lb_exit	= TRUE

If ib_data_changed then
	lb_exit	= (MessageBox(	monsys.msg_title, "PO detail has been changed and " + &
						"not been saved. Do you still want to exit?", &
						Question!, YesNo!) = 1)
end if

if lb_exit then
	
	w_smart_po.dw_crosstab.Reset()
	If w_smart_po.bVendorMode then
		w_smart_po.wf_build_crosstab()
	Else
		w_smart_po.wf_build_crosstab_in_part_mode()
	End If

	If IsValid( w_smart_po_detail_entry_version3) then
		Close(w_smart_po_detail_entry_version3)
	End If

end if
end event

on objects;OpenWithParm(w_smart_po_objects, szPart)
end on

on history;stParm.value1	= String(iPO)
stParm.value2	= szPart

OpenWithParm(w_smart_po_receiving_history, stParm)
end on

event start_to_print_po;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

n_cst_associative_array	lnv_Parm

If uo_print.ddlb_style.text = 'Release' then
	lnv_Parm.of_SetItem("Report", "PO - Release")
Elseif uo_print.ddlb_style.text = 'Normal PO' then
	lnv_Parm.of_SetItem("Report", "Normal PO")
Elseif uo_print.ddlb_style.text = 'Blanket PO' then
	lnv_Parm.of_SetItem("Report", "Blanket PO")
End If

//IF NOT uo_print.cbx_freeze.checked THEN
//	wf_update_release ( '+' )
//END IF

uo_print.visible	= FALSE

bFinish		= FALSE
Timer(0.5)

lnv_Parm.of_SetItem("Arg1", iPO)

Print (lnv_Parm)

wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
dw_po_detail.Retrieve ( iPO, szPart ) 


end event

on setup_parts_for_print;uo_print.dw_parts.Reset()
uo_print.dw_parts.InsertRow(1)
uo_print.dw_parts.SetItem(1, 1, szPart)
uo_print.dw_parts.SelectRow(0, TRUE)


end on

on close_uo_for_print;If IsValid(uo_print) then
	CloseUserObject(uo_print)
End If
end on

event refresh_screen;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
dw_po_detail.Retrieve(iPO, szPart)
end event

event set_release;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

If Not uo_print.cbx_freeze.checked then
	wHostWindow.PostEvent("set_release")
	wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
	dw_po_detail.Retrieve(iPO, szPart)
	iRelease	++
	st_release.text	= "Current Release:" + String(iRelease)
End If
end event

event ue_refresh_releases;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

If Not uo_print.cbx_freeze.checked then
	w_smart_po.TriggerEvent("ue_refresh_releases")
	wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
	dw_po_detail.Retrieve(iPO, szPart)
	iRelease	++
	st_release.text	= "Current Release:" + String(iRelease)
End If
end event

event show_notes;String ls_PartNotes, &
		 ls_datatype 

Long   l_Row

l_Row = dw_po_detail.GetSelectedRow (0)

If l_Row <= 0 Then 	
	MessageBox ( monsys.msg_title, "You must first click on a release in the PO Releases Window.", Information!, OK! )
Else	
	ls_PartNotes = dw_po_detail.object.notes [ l_row ]
	ls_datatype  = dw_po_detail.object.notes.coltype
	
	openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!
	uo_normal_note.mle_note.text = ls_partnotes
	
End If
end event

on ue_demand_from_hard_queue;uo_hard_queue.visible		= not uo_hard_queue.visible
uo_hard_queue.bringtotop	= uo_hard_queue.visible

if uo_hard_queue.visible then
	uo_hard_queue.uf_dw_share( this.dw_po_detail, TRUE )
	uo_hard_queue.dw_hard_queue.uf_retrieve( szPart )
	uo_hard_queue.uf_coverage()
	uo_hard_queue.uf_dw_share( this.dw_po_detail, FALSE )
end if
end on

event ue_print_update;
String l_s_SQLErrorText																								// ADD 04-05-2000 KAZ

IF NOT uo_print.cbx_freeze.checked THEN wf_update_release ( '+' )

IF wf_delete_marked_releases( ) THEN

		IF IsNull ( szpart ) THEN
			UPDATE po_detail
			SET 	Printed = 'Y'
			WHERE Po_number = :iPO AND
					selected_for_print = 'Y' ;
		ELSE
			UPDATE po_detail 
			SET  	Printed = 'Y' 
			WHERE Po_number = :iPO AND
					selected_for_print = 'Y' AND part_number = :szpart;
		END IF
	
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			TriggerEvent("ue_refresh_releases")
		ELSE
			l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/05/2000 KAZ
			Rollback ;
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/05/2000 KAZ
	   END IF

ELSE
	l_s_SQLErrorText = SQLCA.SQLErrText																			// ADD 04/05/2000 KAZ
	Rollback ;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)											// ADD 04/05/2000 KAZ

END IF

end event

event ue_save_batch;Integer 	l_i_Count, &
			l_i_period
			
Date		l_d_Date

Long		l_l_count

decimal	l_n_price, &
			l_n_other_Charge

string   l_s_account, &
		   l_s_unit

IF a_dw.Rowcount() <= 0 THEN RETURN

l_d_Date			= a_dw.object.#3[1]
l_s_account		= f_get_part_info(a_dw.object.#1[1], "GL ACCOUNT")
l_s_unit			= f_get_part_info(a_dw.object.#1[1], "STANDARD UNIT")
l_n_price    	= a_dw.object.#7[1] 
l_i_period    	= a_dw.object.#4[1]
l_n_other_Charge= a_dw.object.#10[1]

IF a_dw.object.#4[1] > 0 THEN

	For l_i_Count = 1 to  a_dw.object.#4[1]

		dw_po_Detail.InsertRow(1)
		dw_po_Detail.SetItem(1, "part_number", a_dw.object.#1[1] )
		dw_po_Detail.SetItem(1, "description", a_dw.object.#2[1])
		dw_po_Detail.SetItem(1, "po_number", iPO)
		dw_po_Detail.SetItem(1, "status", "A")
		dw_po_Detail.SetItem(1, "vendor_code", szvendor )
		dw_po_Detail.SetItem(1, "unit_of_measure", l_s_unit)	
		dw_po_Detail.SetItem(1, "terms", szterms )
		dw_po_Detail.SetItem(1, "printed", 'N' )
		dw_po_Detail.SetItem(1, "account_code", l_s_account )
		dw_po_Detail.SetItem(1, "ship_via", szshipvia )
		dw_po_Detail.SetItem(1, "week_no", f_get_week_no(l_d_date) )
		dw_po_Detail.SetItem(1, "price", l_n_price )
		dw_po_Detail.SetItem(1, "date_due",  l_d_date)
		dw_po_Detail.SetItem(1, "quantity", a_dw.object.#6[1])
		dw_po_Detail.SetItem(1, "received", 0)
		dw_po_Detail.SetItem(1, "balance", a_dw.object.#6[1])
		dw_po_Detail.SetItem(1, "release_no", irelease )
		dw_po_Detail.SetItem(1, "taxable", a_dw.object.#8[1])
		dw_po_Detail.SetItem(1, "other_charge", l_n_other_charge)
		
  		// MB Modified to set sequential row id from po header 01/28/04
		dw_po_Detail.SetItem(1, "row_id", i_l_next_row_id + il_row_add )
		il_row_add++
		
		l_d_Date	= wf_next_day ( l_d_Date, 1, a_dw.object.#5[1] )

	Next

	dw_po_detail.accepttext()
	
	// Included this check to make sure batch routine works fine.. mb 01/28/04
	bNoInfo = False
	w_smart_po_detail_entry_version3.TriggerEvent("save_release")
	
END IF


end event

event ue_save_note;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

String ls_NewNote

Long ll_Row

Date ld_DateDue

Int i_Rowid

ls_NewNote = uo_normal_note.mle_note.text

ll_Row = dw_po_detail.GetselectedRow (0)

ld_DateDue = Date(dw_po_detail.GetItemDateTime ( ll_Row, 1 ))
i_Rowid    = dw_po_detail.GetItemNumber( ll_Row, "row_id" )

UPDATE po_detail  
   SET notes = :ls_NewNote
 WHERE ( po_number = :iPO ) AND  
       ( part_number = :szPart )AND
       ( row_id = :i_Rowid ) ; 

If SQLCA.SQLCode = 0 Then
   Commit ;
Else
   Rollback ;
End If 

Closeuserobject ( uo_normal_note )

wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
dw_po_detail.Retrieve ( iPO, szPart)


end event

event ue_close_uo_note;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

if isvalid(uo_normal_note) then
  closeuserobject(uo_normal_note)
  wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
  dw_po_detail.Retrieve(iPO, szpart)
end if
end event

public subroutine wf_create_unit_dddw ();Integer 	iCount

String	ls_UM

lb_um.reset()
dwUM.reset()

f_get_units_for_part("", szPart, lb_um)

For iCount	= 1 to lb_um.TotalItems()
	lb_um.SelectItem(iCount)
	ls_UM	= lb_um.SelectedItem()
	dwUM.InsertRow(1)
	dwUM.SetItem(1, "um", ls_UM)
Next	
end subroutine

public function string wf_get_um ();String ls_UM
String ls_Vendor

ls_Vendor	= wf_get_vendor_code(iPO)

  SELECT part_vendor.receiving_um  
    INTO :ls_UM  
    FROM part_vendor  
   WHERE ( part_vendor.part = :szPart ) AND  
         ( part_vendor.vendor = :ls_Vendor )   ;

Return trim(ls_UM)
end function

public function date wf_next_day (date dToday, integer iUnits, string szUnit);Integer iYear
Integer iMonth
Integer iDay

If szUnit	= "Day" then
	Return RelativeDate(dToday, iUnits)
End If

If szUnit	= "Week" then
	Return RelativeDate(dToday, (iUnits * 7))
End If

If szUnit	= "Month" then
	iYear		= Year(dToday)
	iMonth	= Month(dToday)
	iDay		= Day(dToday)
			
	If iMonth	= 12 then
		iYear	++
		iMonth	= 1
	Else
		iMonth	++
	End If

	If iDay > f_days_in_month(Date(iYear, iMonth, 1)) then
		iDay	= f_days_in_month(Date(iYear, iMonth, 1))
	End If

	Return date(iYear, iMonth, iDay)

End If

				

end function

public subroutine wf_post_serial (long iserial, string szbatch);UPDATE audit_trail  
   SET invoice_number = :szBatch  
 WHERE ( serial = :iSerial ) AND  
       ( type = 'R' )   ;


end subroutine

public subroutine wf_create_ship_to ();String szCode
String szName

dwShipTo.Reset()

Declare PlantCur Cursor for Select Distinct plant From Vendor Using sqlca;

Open PlantCur;

Fetch PlantCur into :szCode;

Do while sqlca.sqlcode = 0
	dwShipTo.InsertRow(1)
	dwShipTo.SetItem(1, 1, szCode)
	dwShipTo.SetItem(1, 2, "PLANT")
	Fetch PlantCur into :szCode;
Loop

Close PlantCur;

Declare LocationCur Cursor for Select Code, Name From Location Using sqlca;

Open LocationCur;

Fetch LocationCur into :szCode, :szName;

Do while sqlca.sqlcode = 0
	dwShipTo.InsertRow(1)
	dwShipTo.SetItem(1, 1, szCode)
	dwShipTo.SetItem(1, 2, szName)
	Fetch LocationCur into :szCode, :szName;
Loop

Close LocationCur;

Declare DestinationCur Cursor for Select Destination, Name From Destination Using sqlca;

Open DestinationCur;

Fetch DestinationCur into :szCode, :szName;

Do while sqlca.sqlcode = 0
	dwShipTo.InsertRow(1)
	dwShipTo.SetItem(1, 1, szCode)
	dwShipTo.SetItem(1, 2, szName)
	Fetch DestinationCur into :szCode, :szName;
Loop

Close DestinationCur;



end subroutine

public subroutine wf_create_mps_template ();Long iRow
Long iTotalRows
Long iRowFound

Date	dDate

Decimal nQty
Decimal nQtyInTemplate

dw_template.Reset()

iTotalRows	= dw_mps_demand.RowCount()

For iRow = 1 to iTotalRows

	If dw_mps_demand.IsSelected(iRow) then

		dDate			= date(dw_mps_demand.GetItemDateTime(iRow, "due"))
		iRowFound	= dw_template.Find("value1 = '" + String(dDate) + "'", 1, 99999)	
		If iRowFound > 0 then
			nQtyInTemplate	= Dec(dw_template.GetItemString(iRowFound, "value2"))
		Else
			nQtyInTemplate	= 0									
			iRowFound		= 1
			dw_template.InsertRow(1)	
			dw_template.SetItem(1, "value1", String(dDate))
		End If

		nQtyInTemplate		= nQtyInTemplate + f_get_value(dw_mps_demand.GetItemNumber(iRow, "qnty")) &
								  - f_get_value(dw_mps_demand.GetItemNumber(iRow, "qty_assigned"))

		dw_template.SetItem(iRowFound, "value2", String(nQtyInTemplate))
		
	End If

Next

end subroutine

public subroutine wf_get_host_window (ref window wWin);wHostWindow	= wWin
end subroutine

public function boolean wf_update_over_recved (string as_vendor, string as_part, decimal ac_over_received);/*
Description	:To update the over-received quantity
Author		:Jim Wu
Start Date	:02/18/96
Modification:
*/

/* Declaration */

/* Initialization */

/* Main Process */

UPDATE 	part_vendor  
SET 		qty_over_received = :ac_Over_received
WHERE 	( vendor = :as_vendor ) AND  
         ( part = :as_Part )   ;

noverreceived = ac_over_received

Return ( SQLCA.SQLCode = 0 )

end function

public function boolean wf_check_min_on_order ();return bCheckMinOnOrder
end function

public function decimal wf_min_on_order ();return nMinOnOrder
end function

public subroutine wf_error (boolean ab_flag);bError	= ab_flag
end subroutine

public function boolean wf_nonreocurring_item (string as_part);/*
Description	:	To check whether the part is nonreoccuring (whether in part
					master).
Author		:	Jim Wu
Start Date	:	02/24/96
Modification:
*/


/* Declaration */
string	ls_part

/* Initialization */


/* Main Process */

SELECT part.part  
  INTO :ls_part  
  FROM part  
 WHERE part.part = :as_part   ;

Return (SQLCA.SQLCode <> 0)
end function

public subroutine wf_delete_profile (string as_vendor, string as_part);/*
Description	:	To delete the part/vendor relation from profile.
Author		:	Jim Wu
Start Date	:	02/24/96
Modification:	
*/


/* Declaration */


/* Initialization */


/* Main Process */

DELETE FROM part_vendor  
 WHERE ( part_vendor.vendor = :as_vendor ) AND  
       ( part_vendor.part = :as_part )   ;

if SQLCA.SQLCode = 0 then
	COMMIT;	
	DELETE FROM part_vendor_price_matrix
	WHERE	( part_vendor_price_matrix.vendor = :as_vendor ) AND
			( part_vendor.part = :as_part );
	if SQLCA.SQLCode = 0 then
		COMMIT;
	else
		ROLLBACK;
	end if
else
	ROLLBACK;
end if
end subroutine

public function boolean wf_mark_deletion (long al_row, string as_part);/*
Description	:To mark the deletion of PO release.
Author		:Jim Wu
Start Date	:02/17/96
Modification:
*/


/* Declaration */


/* Initialization */


/* Main Process */

If f_valid_part_number(szPart) AND &
	f_get_part_info(szPart, "CLASS") <> "N" Then

	dw_po_detail.SetItem(al_row, "deleted", "Y")	
	dw_po_detail.SetItem(al_row, "printed", "N")
	dw_po_detail.SetItem(al_row, "quantity", 0)
	dw_po_detail.SetItem(al_row, "received", 0)
	dw_po_detail.SetItem(al_row, "balance",  0)
	dw_po_detail.SetItem(al_row, "standard_qty", 0)
	dw_po_detail.SetItem(al_row, "price", 0)

Else

	dw_po_detail.DeleteRow ( al_Row )

End If

Return TRUE
end function

public subroutine wf_reset_demand_flywheel ();Int i_count, i_delete
Long l_row
String s_value

i_count = 0
i_Delete = 0

Datetime dt_ddate7

Dt_ddate7 = datetime(ddate7)

SELECT count(po_detail.vendor_code ),
		 count(po_detail.deleted)  
INTO 	 :i_count,
		 :i_delete  
FROM 	 po_detail  
WHERE  ( po_detail.part_number = :szPart ) AND
  	    ( po_detail.date_due <= :dt_dDate7 ) AND
		 ( po_detail.status = 'A') ;

If i_delete <> i_count Then
   s_value = 'Y'
Else
   s_value = 'N' 
End If  

w_smart_po.dw_vendors.Triggerevent ( "ue_reset", 0, s_value )

end subroutine

public function boolean wf_assign_releases ();/* Declaration */

long		ll_row, &
			ll_total

date		ld_date		//To keep the current date in the po detail

string 	ls_release 	//To keep the release number

decimal	lc_qty, &
	lc_Price

Boolean	lb_NoErrors

/* Initialization */
lb_NoErrors	= TRUE
ll_row		= 1
ll_total		= dw_po_detail.rowcount()


/* Main Process */

do while lb_NoErrors AND (ll_row <= ll_total)

	ld_Date		= date ( dw_po_detail.GetItemDatetime(ll_row, "date_due") )
	lc_Qty		= dw_po_detail.object.quantity[ll_row]

	If bCheckMinOnOrder And dw_po_detail.GetItemString ( ll_Row, "deleted" ) <> "Y" then
		If lc_Qty < nMinOnOrder then
			MessageBox(monsys.msg_title, "You cannot order less than Minimum On Order Quantity for current plant (Min:" + String(nMinOnOrder) + ")", StopSign!)
			lb_NoErrors	= TRUE 
		End If
	End If

	If lb_NoErrors then
		If dw_po_detail.GetItemString(ll_row, "deleted") <> 'Y' then
			lc_Price	= Dec (dw_po_detail.object.price[ll_row])

			If f_get_value(lc_Price) <= 0 then
				dw_po_detail.SetItem( ll_row, "price", wf_get_price(lc_qty, lc_price))
			End If		

			dw_po_detail.SetItem(ll_row, "week_no", f_get_week_no(ld_Date))			
		End If
	End If

	ll_row ++
Loop

Return lb_NoErrors 
end function

public subroutine wf_reset_overreceived ();Decimal nquantity

If dw_po_detail.Rowcount() = 0 Then Return

nquantity = dw_po_detail.GetItemNumber(1, "quantity")

If i_period > 0 Then
	nquantity = nquantity * i_period
	i_period = 0
Else
	nquantity = nquantity * 1	
End If

If nquantity > noverreceived Then

	st_over_received.Text	= '0'

Else

	st_over_received.Text = String(Truncate((noverreceived - nquantity), 0))

End If
end subroutine

public function boolean wf_partial_update_release (string a_s_vendor);String  l_s_partial_update

SELECT	partial_release_update
INTO     :l_s_partial_update
FROM		vendor
WHERE    code = :a_s_vendor ;

IF  l_s_partial_update = 'Y' THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF

end function

public function boolean wf_delete_marked_releases ();String l_s_CurrentPart
String l_s_PartList[]

Integer 	l_i_Count = 0

Decimal  l_n_TotalReceived

Boolean	l_b_OK	 = TRUE	

If IsNull(szPart) then	//Print for all parts
	Declare curPart1 Cursor For
	Select Distinct po_detail.part_number  
	From  po_detail  
	Where po_detail.po_number = :iPO AND
			po_detail.deleted = 'Y' AND
			po_detail.selected_for_print = 'Y'  ;
Else
	Declare curPart2 Cursor For
	Select Distinct po_detail.part_number  
	From  po_detail  
	Where po_detail.po_number = :iPO AND
			po_detail.deleted = 'Y' AND
			po_detail.selected_for_print = 'Y' AND
			po_detail.part_number = :szPart  ;
End If

If IsNull(szPart) then
	Open curPart1;
	Fetch curPart1 into :l_s_CurrentPart;
Else
	Open curPart2;
	Fetch curPart2 into :l_s_CurrentPart;
End If

Do While SQLCA.SQLCode = 0
	l_i_Count ++
	l_s_PartList[l_i_Count]	= l_s_CurrentPart

	If IsNull(szPart) then
		Fetch curPart1 into :l_s_CurrentPart;		
	Else
		Fetch curPart2 into :l_s_CurrentPart;
	End If

Loop

If IsNull(szPart) then
	Close curPart1;
Else
	Close curPart2;
End If

If l_i_Count > 0 then
	If MessageBox(monsys.msg_title, "Do you want to erase deletion-marked releases?", Question!, YesNo!) = 1 then
		Do while (l_i_Count > 0) AND l_b_OK

			l_s_CurrentPart	= l_s_PartList[l_i_Count]

			Select sum ( po_detail.received )  
		   Into   :l_n_TotalReceived  
		   From   po_detail  
		   Where  (po_detail.po_number = :iPO ) AND  
		          (po_detail.part_number = :l_s_CurrentPart ) AND
					 (po_detail.selected_for_print = 'Y') AND
					 (po_detail.deleted = 'Y')  ;

			l_i_Count --

			If wf_update_overreceived(szvendor, l_s_CurrentPart, l_n_TotalReceived) then
				Delete From PO_detail Where 	po_number = :iPO And
										 	part_number = :l_s_CurrentPart And
											Deleted		= 'Y';

				If SQLCA.SQLCode = 0 then
					l_b_OK	= True
				Else
					l_b_OK	= False
				End If
			Else
				l_b_OK	= FALSE
			End If
				
			Loop	
	End If
End If

Return l_b_OK
end function

public function boolean wf_update_overreceived (string a_s_Vendor, string a_s_part, decimal a_n_Qty);Decimal ln_OverReceived

SELECT part_vendor.qty_over_received  
  INTO :ln_Overreceived  
  FROM part_vendor  
 WHERE ( part_vendor.part = :a_s_part ) AND  
       ( part_vendor.vendor = :a_s_Vendor )   ;

ln_OverReceived	= f_get_value(ln_OverReceived) + a_n_Qty

UPDATE part_vendor  
   SET qty_over_received = :ln_OverReceived  
 WHERE ( part_vendor.part = :a_s_part ) AND  
       ( part_vendor.vendor = :a_s_Vendor )   ;
	
If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If
end function

public subroutine wf_update_release (string a_s_flag);Long		l_l_Release
String	l_s_Release

SELECT release_no 
  INTO :l_l_Release  
  FROM po_header  
 WHERE po_number = :iPO;

l_l_Release	 = f_get_value(l_l_Release)

If a_s_flag = '+' then

	UPDATE  po_header  
  	SET  release_no 	= :l_l_Release + 1  
  	WHERE  po_number	= :iPO;

	l_s_Release	= String(l_l_Release + 1)

	If wf_partial_update_release ( szvendor ) then

		UPDATE po_detail  
	   	SET release_no = :l_s_Release
	 	WHERE po_number 	= :iPO AND selected_for_print = 'Y'  ;

	Else

		UPDATE po_detail  
	   	SET release_no = :l_s_Release
	 	WHERE po_number 	= :iPO   ;

	End If
Else

	UPDATE  po_header  
  	SET  release_no 	= :l_l_Release - 1  
  	WHERE  po_number	= :iPO;

	l_s_Release			= String (l_l_Release - 1)

	If wf_partial_update_release ( szvendor ) then

		UPDATE po_detail  
	   	SET release_no = :l_s_Release
	 	WHERE po_number 	= :iPO AND selected_for_print = 'Y'  ;

	Else

		UPDATE po_detail  
	   	SET release_no = :l_s_Release
	 	WHERE po_number 	= :iPO   ;

	End If

End If

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If

end subroutine

public function string wf_get_vendor_code (long al_po);String szVendorCode

SELECT po_header.vendor_code  
  INTO :szVendorCode  
  FROM po_header  
 WHERE po_header.po_number = :al_PO   ;

Return szVendorCode
end function

public subroutine wf_display_overreceived (string as_vendor, string as_part);Decimal nQtyOverReceived

SELECT part_vendor.qty_over_received  
  INTO :nQtyOverReceived  
  FROM part_vendor  
 WHERE ( part_vendor.part = :as_Part ) AND  
       ( part_vendor.vendor = :as_Vendor )   ;

st_over_received.text	= String(Truncate(nQtyOverReceived, 0))





end subroutine

public subroutine wf_display_mps_covered (string as_part);Long iTotal
Long iCovered

If szPlant > ' ' then
	Select sum(master_prod_sched.qnty ),   
   	    sum(master_prod_sched.qty_assigned )  
	  Into :iTotal,   
	       :iCovered  
	  From master_prod_sched  
	  Where master_prod_sched.part 	=: as_part AND 
			  master_prod_sched.plant	=: szPlant;
Else
	Select sum(master_prod_sched.qnty ),   
   	    sum(master_prod_sched.qty_assigned )  
	  Into :iTotal,   
	       :iCovered  
	  From master_prod_sched  
	  Where master_prod_sched.part =: as_part;
End If

iMPSCovered		= f_get_value(iCovered)
iMPSUnCovered	= f_get_value(iTotal) - iMPSCovered

sle_mps_covered.text		= String(iMPSCovered)
sle_mps_uncovered.text	= String(iMPSUnCovered)

end subroutine

public function decimal wf_min_onorder (string as_part, string as_plant);
Decimal nQty

SELECT part_vendor.min_on_order  
  INTO :nQty  
  FROM part_vendor  
 WHERE ( part_vendor.part = :as_Part ) AND  
       ( part_vendor.vendor = :szVendor )   ;

Return nQty

end function

public function decimal wf_get_min_on_hand (string as_part, string as_plant);Decimal nQty

SELECT plant_part.min_onhand  
  INTO :nQty  
  FROM plant_part  
 WHERE ( plant_part.plant = :as_Plant ) AND  
       ( plant_part.part = :as_Part )   ;

Return f_get_value(nQty)
end function

public function decimal wf_get_lead_time (string as_part, string as_vendor);Decimal nLeadTime

  SELECT part_vendor.lead_time  
    INTO :nLeadTime  
    FROM part_vendor  
   WHERE ( part_vendor.part = :as_Part ) AND  
         ( part_vendor.vendor = :as_vendor ) ;

Return f_get_value(nLeadTime)
end function

public function string wf_get_vendor_part (string as_vendor, string as_part);String szVendorPart

Select part_vendor.vendor_part  
  Into :szVendorPart  
  From part_vendor  
 Where ( part_vendor.part = :as_Part ) AND  
       ( part_vendor.vendor = :as_Vendor );

Return szVendorPart

end function

public function date wf_get_po_date (long al_po);Datetime dt_dpodate

SELECT po_date
INTO   :dt_dpodate
FROM   po_header
WHERE  po_number = :al_po ;

dpodate = date(dt_dpodate)

Return  dpodate 
end function

public subroutine wf_get_unit_of_measurement_part (string a_s_part);/* 04-05-2000 KAZ Created to populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

dw_po_detail.SetTransObject (sqlca)							// ADD 04-05-2000 KAZ
dw_po_detail.GetChild ("unit_of_measure", idw_child)	// ADD 04-05-2000 KAZ
idw_child.SetTransObject (sqlca)								// ADD 04-05-2000 KAZ
idw_child.retrieve ( a_s_part )								// ADD 04-05-2000 KAZ
	
end subroutine

public function decimal wf_get_price (decimal nqty, decimal an_price);Integer iTotalRows
Integer iRow

String  l_s_header_cunit

Decimal nPrice

Boolean bFound
 
bFound		= FALSE
iTotalRows	= dw_price_matrix.RowCount()
iRow			= iTotalRows

Do while (Not bFound) AND (iRow > 0)

	bFound = (nQty >= dw_price_matrix.GetItemNumber(iRow, "break_qty"))

	If Not bFound then
		iRow --
	End If

Loop

If iRow = 0 then
	bFound	= FALSE
End If

select currency_unit
into  :l_s_header_cunit 
from  po_header
where po_number = :ipo ;

If bFound then
	nprice = Truncate(dw_price_matrix.GetItemNumber(iRow, 6 ) + 0.0000009, 6)	
//	sqlca.of_calculate_multicurrency_price ( dw_price_matrix.GetItemString ( irow, 5 ), l_s_header_cunit, &
//		Truncate(dw_price_matrix.GetItemNumber(iRow, 6 ) + 0.0000009, 6), nPrice )
Else
//	sqlca.of_calculate_multicurrency_price ( '', l_s_header_cunit, &
//		Truncate(Dec(f_get_part_info(szpart, "STANDARD COST")) + 0.0000009, 6), nprice )
	nPrice = an_price
	If nQty > 0 then
		nPrice	= f_convert_units(szUM, "", szPart, nQty) * nPrice / nQty
	Else
		nPrice	= f_convert_units(szUm, "", szPart, 1)
	End If
End If

Return nPrice


end function

event open;call super::open;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

//************************************************************************
//* Declaration
//************************************************************************

dw_price_matrix.SetTransObject(sqlca)

Integer iRtnCode

String  szModify, szRtnString
String	ls_release_control

//************************************************************************
//* Initialization
//************************************************************************

stParm			= Message.PowerObjectParm

bNoInfo			= True										// ZZ

iPO				= Long(stParm.value1)
szPart			= stParm.value2
szShipTo			= stParm.value3
szTerms			= stParm.value4
szShipType		= LeftA(stParm.value5, 1)
szPlant			= stParm.value6
szVendor			= stParm.value7
iRelease			= Long(stParm.value8)
szShipVia		= stParm.value9
dDate7         = Date(stParm.Value10)

szGLAccount		= f_get_part_info(szPart, "GL ACCOUNT")
st_release.text= "Current Release:" + String(iRelease)

bCheckMinOnOrder				= (szShipType = "N")
If bCheckMinOnOrder then
	nMinOnOrder					= wf_min_onorder(szPart, szVendor)
	sle_min_order_qty.text	= String(Truncate(nMinOnOrder, 2))
End If

sle_min_on_hand.text			= String(Truncate(wf_get_min_on_hand(szPart, szPlant),2))
sle_lead_time.text			= String(Truncate(wf_get_lead_time(szPart, szVendor), 2))
st_part_name.text				= f_get_part_info(szPart, "NAME")
st_vendor_part.text			= wf_get_vendor_part(szVendor, szPart)

this.Title	= "Release Entry  (Part:" + szPart + " PO:" + String(iPO) + ")"

szUM			= wf_get_um()

wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
dw_po_detail.Retrieve (iPO, szPart)
dw_mps_demand.Retrieve (szPart)

dw_price_matrix.Retrieve (wf_get_vendor_code(iPO), szpart)

SELECT po_header.release_control  
  INTO :ls_release_control  
  FROM po_header  
 WHERE po_header.po_number = :iPO   ;

If f_get_string_value ( ls_release_control ) = 'A' then
	wf_display_overreceived(wf_get_vendor_code(iPO), szPart)
Else
	st_over_received.Text = '0'
End if

wf_display_mps_covered(szPart)

// MB 01/28/04 modified to get next seq no from po header
i_l_next_row_id = f_get_podet_next_seqno ( iPO )

If dw_po_detail.RowCount ( ) > 0 Then
	st_part_name.Text = dw_po_detail.GetItemString ( 1, "description" )
End if

dpodate = wf_get_po_date(ipo)
end event

event timer;call super::timer;/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

If bFinish then
	
	Timer(0)
	bNoCommit	= FALSE
	f_recalc_po_detail_per_part(iPO, szPart, w_smart_po_detail_entry_version3)
	SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + szpart )
	f_update_qty_asgnd_part ( szpart ) 
	dw_mps_demand.Retrieve(szPart)
	wf_get_unit_of_measurement_part ( szpart )					// ADD 04-05-2000 KAZ
	dw_po_detail.Retrieve(iPO, szPart)
	bFinish	= FALSE
	
End If
end event

on close;If IsValid(uo_print) then
	CloseUserObject(uo_print)
End If
end on

on w_smart_po_detail_entry_version3.create
int iCurrent
call super::create
if this.MenuName = "m_smart_po_detail" then this.MenuID = create m_smart_po_detail
this.st_18=create st_18
this.p_3=create p_3
this.st_part_name=create st_part_name
this.st_16=create st_16
this.st_vendor_part=create st_vendor_part
this.st_15=create st_15
this.p_2=create p_2
this.st_1=create st_1
this.sle_lead_time=create sle_lead_time
this.st_14=create st_14
this.st_11=create st_11
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.sle_min_order_qty=create sle_min_order_qty
this.sle_min_on_hand=create sle_min_on_hand
this.st_4=create st_4
this.dw_template=create dw_template
this.st_2=create st_2
this.sle_mps_uncovered=create sle_mps_uncovered
this.st_13=create st_13
this.sle_mps_covered=create sle_mps_covered
this.st_10=create st_10
this.dw_price_matrix=create dw_price_matrix
this.lb_um=create lb_um
this.st_over_received=create st_over_received
this.sle_1=create sle_1
this.st_12=create st_12
this.dw_po_detail=create dw_po_detail
this.dw_mps_demand=create dw_mps_demand
this.uo_hard_queue=create uo_hard_queue
this.st_17=create st_17
this.st_release=create st_release
this.p_1=create p_1
this.cb_create=create cb_create
this.gb_4=create gb_4
this.gb_1=create gb_1
this.cb_note=create cb_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_18
this.Control[iCurrent+2]=this.p_3
this.Control[iCurrent+3]=this.st_part_name
this.Control[iCurrent+4]=this.st_16
this.Control[iCurrent+5]=this.st_vendor_part
this.Control[iCurrent+6]=this.st_15
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_lead_time
this.Control[iCurrent+10]=this.st_14
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.st_8
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.sle_min_order_qty
this.Control[iCurrent+18]=this.sle_min_on_hand
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.dw_template
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.sle_mps_uncovered
this.Control[iCurrent+23]=this.st_13
this.Control[iCurrent+24]=this.sle_mps_covered
this.Control[iCurrent+25]=this.st_10
this.Control[iCurrent+26]=this.dw_price_matrix
this.Control[iCurrent+27]=this.lb_um
this.Control[iCurrent+28]=this.st_over_received
this.Control[iCurrent+29]=this.sle_1
this.Control[iCurrent+30]=this.st_12
this.Control[iCurrent+31]=this.dw_po_detail
this.Control[iCurrent+32]=this.dw_mps_demand
this.Control[iCurrent+33]=this.uo_hard_queue
this.Control[iCurrent+34]=this.st_17
this.Control[iCurrent+35]=this.st_release
this.Control[iCurrent+36]=this.p_1
this.Control[iCurrent+37]=this.cb_create
this.Control[iCurrent+38]=this.gb_4
this.Control[iCurrent+39]=this.gb_1
this.Control[iCurrent+40]=this.cb_note
end on

on w_smart_po_detail_entry_version3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_18)
destroy(this.p_3)
destroy(this.st_part_name)
destroy(this.st_16)
destroy(this.st_vendor_part)
destroy(this.st_15)
destroy(this.p_2)
destroy(this.st_1)
destroy(this.sle_lead_time)
destroy(this.st_14)
destroy(this.st_11)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_min_order_qty)
destroy(this.sle_min_on_hand)
destroy(this.st_4)
destroy(this.dw_template)
destroy(this.st_2)
destroy(this.sle_mps_uncovered)
destroy(this.st_13)
destroy(this.sle_mps_covered)
destroy(this.st_10)
destroy(this.dw_price_matrix)
destroy(this.lb_um)
destroy(this.st_over_received)
destroy(this.sle_1)
destroy(this.st_12)
destroy(this.dw_po_detail)
destroy(this.dw_mps_demand)
destroy(this.uo_hard_queue)
destroy(this.st_17)
destroy(this.st_release)
destroy(this.p_1)
destroy(this.cb_create)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.cb_note)
end on

event closequery;call super::closequery;/* 04-05-2000 KAZ Added to prompt the user to save if the Detail line has been modified
						before continuing processing.  Issue # 13220 */

Int iRtnCode

If Not bNoInfo Then

	iRtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

		Case 1
			dw_po_detail.triggerevent ( "ue_save" )
			w_smart_po.dw_crosstab.Reset()
			If w_smart_po.bVendorMode then
				w_smart_po.wf_build_crosstab()
			Else
				w_smart_po.wf_build_crosstab_in_part_mode()
			End If
			If IsValid( w_smart_po_detail_entry_version3) then
				Close(w_smart_po_detail_entry_version3)
			End If
		Case 2 
         close ( this )
		Case 3
			Message.Returnvalue = 1       
	End Choose
Else
	close ( this )
End If

end event

type st_18 from statictext within w_smart_po_detail_entry_version3
integer x = 2711
integer y = 736
integer width = 128
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Notes"
boolean focusrectangle = false
end type

type p_3 from picture within w_smart_po_detail_entry_version3
integer x = 2638
integer y = 736
integer width = 69
integer height = 60
boolean enabled = false
string picturename = "noteyes.bmp"
boolean focusrectangle = false
end type

type st_part_name from statictext within w_smart_po_detail_entry_version3
integer x = 1806
integer y = 100
integer width = 1001
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
boolean focusrectangle = false
end type

type st_16 from statictext within w_smart_po_detail_entry_version3
integer x = 1445
integer y = 100
integer width = 366
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Part Description:"
boolean focusrectangle = false
end type

type st_vendor_part from statictext within w_smart_po_detail_entry_version3
integer x = 896
integer y = 100
integer width = 512
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
boolean focusrectangle = false
end type

type st_15 from statictext within w_smart_po_detail_entry_version3
integer x = 526
integer y = 100
integer width = 357
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Vendor Part No:"
boolean focusrectangle = false
end type

type p_2 from picture within w_smart_po_detail_entry_version3
integer x = 2272
integer y = 732
integer width = 69
integer height = 64
string picturename = "delbox.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_smart_po_detail_entry_version3
integer x = 2350
integer y = 736
integer width = 288
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Mark Deleted"
boolean focusrectangle = false
end type

type sle_lead_time from singlelineedit within w_smart_po_detail_entry_version3
integer x = 1408
integer y = 4
integer width = 233
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within w_smart_po_detail_entry_version3
integer x = 1184
integer y = 48
integer width = 197
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Time"
alignment alignment = center!
long bordercolor = 8421504
boolean focusrectangle = false
end type

type st_11 from statictext within w_smart_po_detail_entry_version3
integer x = 1239
integer width = 114
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Lead"
boolean focusrectangle = false
end type

type st_9 from statictext within w_smart_po_detail_entry_version3
integer x = 2304
integer y = 48
integer width = 247
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Uncovered"
boolean focusrectangle = false
end type

type st_8 from statictext within w_smart_po_detail_entry_version3
integer x = 1733
integer y = 48
integer width = 192
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Covered"
boolean focusrectangle = false
end type

type st_7 from statictext within w_smart_po_detail_entry_version3
integer x = 640
integer y = 48
integer width = 197
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Qty"
alignment alignment = center!
long bordercolor = 8421504
boolean focusrectangle = false
end type

type st_6 from statictext within w_smart_po_detail_entry_version3
integer x = 50
integer y = 48
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Qty"
alignment alignment = center!
long bordercolor = 8421504
boolean focusrectangle = false
end type

type st_5 from statictext within w_smart_po_detail_entry_version3
integer x = 640
integer width = 215
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Min Order "
long bordercolor = 8421504
boolean focusrectangle = false
end type

type sle_min_order_qty from singlelineedit within w_smart_po_detail_entry_version3
integer x = 873
integer y = 4
integer width = 233
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_min_on_hand from singlelineedit within w_smart_po_detail_entry_version3
integer x = 361
integer y = 4
integer width = 233
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_smart_po_detail_entry_version3
integer x = 69
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Min On Hand"
long bordercolor = 8421504
boolean focusrectangle = false
end type

type dw_template from datawindow within w_smart_po_detail_entry_version3
boolean visible = false
integer x = 855
integer y = 1856
integer width = 489
integer height = 356
integer taborder = 110
string dataobject = "dw_external_template"
boolean livescroll = true
end type

type st_2 from statictext within w_smart_po_detail_entry_version3
integer x = 1861
integer width = 128
integer height = 48
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "(Blue)"
long bordercolor = 65280
boolean focusrectangle = false
end type

type sle_mps_uncovered from singlelineedit within w_smart_po_detail_entry_version3
integer x = 2560
integer y = 4
integer width = 256
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;MessageBox(monsys.msg_title, "Total uncovered MPS quantity for the current part", Information!)
end event

type st_13 from statictext within w_smart_po_detail_entry_version3
integer x = 2304
integer y = 4
integer width = 210
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "MPS"
boolean focusrectangle = false
end type

type sle_mps_covered from singlelineedit within w_smart_po_detail_entry_version3
integer x = 2007
integer y = 4
integer width = 233
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;Messagebox(monsys.msg_title, "Total MPS covered quantity for the current part", Information!)
end event

type st_10 from statictext within w_smart_po_detail_entry_version3
integer x = 1733
integer width = 105
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "MPS"
boolean focusrectangle = false
end type

type dw_price_matrix from datawindow within w_smart_po_detail_entry_version3
boolean visible = false
integer x = 343
integer y = 1856
integer width = 489
integer height = 356
integer taborder = 100
string dataobject = "dw_smart_vendor_part_price_matrix"
boolean livescroll = true
end type

type lb_um from listbox within w_smart_po_detail_entry_version3
boolean visible = false
integer x = 32
integer y = 1856
integer width = 270
integer height = 176
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_over_received from statictext within w_smart_po_detail_entry_version3
integer x = 1321
integer y = 736
integer width = 210
integer height = 56
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_smart_po_detail_entry_version3
integer x = 14
integer width = 2830
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

type st_12 from statictext within w_smart_po_detail_entry_version3
integer x = 2112
integer y = 736
integer width = 160
integer height = 48
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Printed"
boolean focusrectangle = false
end type

type dw_po_detail from u_smart_po_detail_dw within w_smart_po_detail_entry_version3
integer x = 32
integer y = 792
integer width = 2793
integer height = 620
integer taborder = 30
string dragicon = "MONITOR.ICO"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dragdrop;Long iRow
Long iRowId

Decimal nQty

String szStdUM
String szYear, szMonth, szDay
String szName
String l_s_vendor
dec	ld_price

Date	dDate

Integer li_seqno

If Not bMPS then
	Return
End If

//MB 01/29/04 Included this check to see if user was trying to add a release and return if info is not saved yet.
If m_smart_po_detail.m_file.m_batchcreate.enabled = false then
	Return
End if

If IsNull(szUM) then
	MessageBox(monsys.msg_title, "Missing unit of measure, please set it up first", StopSign!)
	Return
End If

If IsNull(szTerms) then
	MessageBox(monsys.msg_title, "Missing terms, please set it up first", StopSign!)
	Return
End If

bMPS			= false
bNoInfo		= false
szStdUm		= f_get_part_info(szPart, "STANDARD UNIT")
szName		= f_get_part_info(szPart, "NAME")
l_s_vendor		= wf_get_vendor_code(iPO)
szGLAccount	= f_get_part_info(szPart, "GL ACCOUNT")

wf_create_mps_template()

For iRow	= 1 to dw_template.RowCount()

	dw_po_detail.InsertRow(1)
	dw_po_detail.SetItem(1, "part_number"	, szPart)
	dw_po_detail.SetItem(1, "description"	, szName)
	dw_po_detail.SetItem(1, "po_number"		, iPO)
	dw_po_detail.SetItem(1, "status", "A")
	dw_po_detail.SetItem(1, "vendor_code", l_s_vendor)
	dw_po_detail.SetItem(1, "terms", szTerms)
	dw_po_detail.SetItem(1, "received", 0)

	nQty		= Dec(dw_template.GetItemString(iRow, "value2"))
	dDate		= Date(dw_template.GetItemString(iRow, "value1"))

	szYear	= RightA(String(Year(dDate)), 2)
	szMonth	= String(Month(dDate))
	szDay		= String(Day(dDate))
	ld_price = dw_po_detail.getitemdecimal(1, "price")
	
	dw_po_detail.SetItem(1, "standard_qty", nQty)
	nQty	= f_convert_units("", szUM, szPart, nQty)
	dw_po_detail.SetItem(1, "quantity", nQty)
	dw_po_detail.SetItem(1, "date_due", dDate)
	dw_po_detail.SetItem(1, "balance", nQty)
	dw_po_detail.SetItem(1, "unit_of_measure", szUM)
	dw_po_detail.SetItem(1, "release_no", iRelease)
	dw_po_detail.SetItem(1, "terms", szTerms)
	dw_po_detail.SetItem(1, "week_no", f_get_week_no(dDate))	
	dw_po_detail.SetItem(1, "plant", szPlant)
	dw_po_detail.SetItem(1, "account_code", szGLAccount)
	dw_po_detail.SetItem(1, "ship_via", szShipVia)
	dw_po_detail.SetItem(1, "week_no", f_get_week_no(dpodate))
	dw_po_detail.SetItem(1, "price", uf_get_price ( nQty, ld_price ) )
	dw_po_detail.SetItem(1, "row_id", i_l_next_row_id + il_row_add )
	
	// Modified to set sequential row id from po header MB 01/28/04
	il_row_add++
	
	iPODetailRow	= 1

Next 

Parent.TriggerEvent("save_release")
end event

event ue_delete;/* Declaration */

long		ll_row, &
			ll_row_deleted, &
			ll_total

date		ld_datedue

boolean	lb_NoDelete

string	ls_message

decimal	lc_received

/* Initialization */
ll_row_deleted	= 0
ll_total			= this.rowcount()

/* Main Process */

For ll_row = ll_total to 1 Step -1
	If this.isselected(ll_row) Then
		ll_row_deleted	++
		If (f_get_string_value(&
				this.getitemstring(ll_row, "deleted")) <> 'Y') then
			ld_DateDue	= Date(this.getitemdatetime( ll_row, "date_due" ))
			lb_NoDelete	= (this.getitemstring( ll_row, "printed") = 'Y' )
	
			lc_received	= 	dec(st_over_received.text) + &
							 	f_get_value(&
									this.GetItemNumber(ll_row, "received"))
			st_over_received.text	= 	String(Truncate(lc_received, 0))

			wf_mark_deletion( ll_row, szPart )
			ib_marked_deletion	= TRUE
			If Update ( ) = -1 Then
					RollBack ;
			Else
					Commit ;
			End If
			ib_data_changed	= TRUE
		End If
	End If
Next

This.TriggerEvent ( "ue_save" )

This.selectrow(0, FALSE)


end event

event ue_save;/* 03-17-2000 KAZ Modified to exit if there is no new or changed data.  Issue # 13221 */
/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

integer li_seqno

If bNoInfo Then												// ADD 03-17-2000 KAZ
	wf_get_unit_of_measurement_part ( szpart )		// ADD 04-05-2000 KAZ
	dw_po_detail.retrieve(iPO, szPart ) 				// ADD 03-17-2000 KAZ
	il_row_add = 0
	return														// ADD 03-17-2000 KAZ
End If															// ADD 03-17-2000 KAZ

If bError Then
   MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity!", StopSign!	)
   dw_po_detail.SetText("")
	Return
End If

/* Routine to remove the printed for the existing po detail */
If dw_po_detail.RowCount() = 0 Then
	If wf_nonreocurring_item( szPart ) Then
		Messagebox( monsys.msg_title, 'Since this is a non-' + &
						'reoccuring item, the system will ' + &
						'automatically delete vendor/part profile.', + &
						StopSign!)
		wf_delete_profile( szVendor, szPart )
		If IsValid( wHostWindow ) Then
			wHostWindow.TriggerEvent( 'ue_delete_profile' )
		End If
	End If
Else
	il_rowid = dw_po_detail.GetItemNumber ( dw_po_detail.GetRow (), "row_id" )

	 UPDATE po_detail  
       SET printed = 'N'  
  	  WHERE po_detail.po_number = :ipo  AND  
     		  po_detail.part_number = :szpart   AND
        	  po_detail.row_id = :il_rowid ;

	dw_po_detail.SetItem ( il_rowid, 'printed', "" )
End If
/* End of Routine */

If ISNULL(st_over_received.text) or st_over_received.text = '' Then 
   st_over_received.text = '0'
End If
 
If Parent.wf_assign_releases() then		//If no errors in assigning release#
	If Parent.wf_update_over_recved(szVendor, szPart, dec(st_over_received.text)) Then
		If (This.Update() > 0)  Then
			li_seqno = i_l_next_row_id + il_row_add
			// MB 01/27/04 update po_header with next seq no 
			Update po_header
			Set  next_seqno = :li_seqno
			Where po_number = :iPO ;
				
			IF sqlca.sqlcode <> 0 THEN
				rollback ;
				messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
			END IF
			
			Commit;
			i_l_next_row_id = li_seqno
			il_row_add = 0
			wf_reset_demand_flywheel()
			wf_reset_overreceived()
			bNoCommit = FALSE
			f_recalc_po_detail_per_part(iPO, szPart, w_smart_po_detail_entry_version3)
			SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + szpart )
		   f_update_qty_asgnd_part ( szpart ) 
			dw_mps_demand.Retrieve(szPart)
			wf_get_unit_of_measurement_part ( szpart )	// ADD 04-05-2000 KAZ
			this.Retrieve(iPO, szPart)
			ib_data_changed	= FALSE
			bNoInfo = True											// ADD 03-17-2000 KAZ

	   Else
			
			Rollback;
			
		End If
	Else
		Rollback;
	End If
		parent.wf_display_mps_covered(szPart)

End If

SetMicroHelp ( 'Ready' )										// ADD 03-17-2000 KAZ
end event

event ue_insert;/* 03-17-2000 KAZ Modified to exit if there is no new or changed data.  Issue # 13221 */
/* 04-05-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to 
						populate unit of measure DDDW in dw_po_detail.  Issue # 13193 */

LONG	l_l_count

bNoInfo = True																				// ADD 03-17-2000 KAZ

wf_get_unit_of_measurement_part ( szPart )										// ADD 04-05-2000 KAZ

dw_po_detail.InsertRow(1)
dw_po_detail.SetItem(1, "date_due",  datetime ( today(), time ( '00:00:00' ) ) )
dw_po_detail.SetItem(1, "part_number", szPart)
dw_po_detail.SetItem(1, "po_number", iPO)
dw_po_detail.SetItem(1, "status", "A")
dw_po_detail.SetItem(1, "vendor_code", wf_get_vendor_code(iPO))
dw_po_detail.SetItem(1, "received", 0)
dw_po_detail.SetItem(1, "unit_of_measure", szUM)	
dw_po_detail.SetItem(1, "description", f_get_part_info(szPart, "NAME"))
dw_po_detail.SetItem(1, "terms", szTerms)
dw_po_detail.SetItem(1, "plant", szPlant)
dw_po_detail.SetItem(1, "printed", "N")
dw_po_detail.SetItem(1, "release_no", iRelease)
dw_po_detail.SetItem(1, "account_code", szGLAccount)
dw_po_detail.SetItem(1, "ship_type", szShipType)
dw_po_detail.SetItem(1, "ship_via", szShipVia)
dw_po_detail.SetItem(1, "week_no", f_get_week_no(dpodate) )
dw_po_detail.SetItem(1, "row_id", i_l_next_row_id + il_row_add )
il_row_add = il_row_add + 1

dw_po_detail.accepttext()

dw_po_detail.SetRow(1)
dw_po_detail.SetColumn(1)
dw_po_detail.SetFocus()


end event

event clicked;Long ll_Row
Long ll_PreviousRow

Int ll_Count

// To select a bunch of rows to mark for deletion

ll_Row = dw_po_detail.GetClickedRow ( )

If ll_Row < 1 Then Return

If ll_Row > 0 then

	this.SelectRow(ll_Row, TRUE)
    
 	If this.GetItemString(ll_Row, "deleted") = 'Y' then
		this.SetTabOrder("date_due", 0)
		this.SetTabOrder("quantity", 0)
		this.SetTabOrder("received", 0)
		this.SetTabOrder("price", 0)
		this.SetTabOrder("terms", 0)
	Else
		this.SetTabOrder("date_due", 10)
		this.SetTabOrder("quantity", 20)
		this.SetTabOrder("received", 0)
		this.SetTabOrder("price", 40)
		this.SetTabOrder("terms", 50)
	End If
End if

If KeyDown ( keyShift! ) Then
   
	ll_PreviousRow = dw_po_Detail.GetRow() 
   SelectRow (this, 0, False) 
   If ll_PreviousRow < ll_Row Then
		For ll_Count = ll_PreviousRow to ll_Row
			SelectRow ( This, ll_Count, True )
		Next
   Else
    	For ll_Count = ll_Row to ll_PreviousRow
			SelectRow ( This, ll_Count, True )
		Next
   End If

Elseif KeyDown ( keyControl! ) Then

	ll_Count = This.GetRow() 
	SelectRow ( dw_po_detail, ll_Count, True )

Else
 
   SelectRow ( this, 0, False )
   SelectRow ( this, ll_Row, True )

End if

ll_PreviousRow = ll_Count

// End of routine to select bunch of rows to mark for deletion




end event

event constructor;dw_po_detail.Modify("quantity.color = '0~tif(status =~~'H~~', 255, 0)'")
dw_po_detail.Modify("date_due.color = '0~tif(status =~~'H~~', 255, 0)'")
dw_po_detail.Modify("received.color = '0~tif(status =~~'H~~', 255, 0)'")
dw_po_detail.Modify("unit_of_measure.color = '0~tif(status =~~'H~~', 255, 0)'")
dw_po_detail.Modify("balance.color = '0~tif(status =~~'H~~', 255, 0)'")

call super::constructor


end event

event doubleclicked;Long	ll_row


ll_row	= this.uf_row_clicked(2)
If this.uf_clicked_value('ship_type') = 'D' then //Do not allow to delete the ship type
	this.SelectRow(ll_row, FALSE)
	MessageBox(monsys.msg_title, "You can not highlight DROP-SHIP releases for deletion.", &
					StopSign!)
Else
	if this.uf_clicked_value('deleted') = 'Y' then
		this.SelectRow(ll_row, FALSE)
		messagebox(monsys.msg_title, "This release has already been marked " + &
						"for deletion.", StopSign!)
	end if
End If
end event

event rbuttondown;MessageBox(monsys.msg_title, "P.O. Releases", Information!)
end event

event itemchanged;call super::itemchanged;/* 03-17-2000 KAZ Modified to exit if there is no new or changed data.  Issue # 13221 */
/* 04-05-2000 KAZ Modified to get price from part_vendor_price_matrix.  Issue # 13323 */

Dec   ln_price	// ADD 04-05-2000 KAZ
Dec	ld_price

IF dwo.name = 'date_due' THEN
	dw_po_detail.SetItem ( row, "week_no", f_get_week_no ( date ( dw_po_detail.object.date_due[row] ) ) )
END IF

IF dwo.name = 'quantity' THEN																// ADD 04-05-2000 KAZ
	ld_price = object.price[row]
  	ln_price		= wf_get_price ( Dec(dw_po_detail.gettext()), ld_price )		// ADD 04-05-2000 KAZ
	dw_po_detail.SetItem ( row, "price", ln_price )									// ADD 04-05-2000 KAZ
End If																							// ADD 04-05-2000 KAZ

bNoInfo = False																				// ADD 03-17-2000 KAZ

end event

event editchanged;/* 03-17-2000 KAZ Modified to exit if there is no new or changed data.  Issue # 13221 */

bNoInfo = False																		// ADD 03-17-2000 KAZ
end event

type dw_mps_demand from u_monitor_data_entry_dw within w_smart_po_detail_entry_version3
integer x = 37
integer y = 164
integer width = 2793
integer height = 528
integer taborder = 50
string dragicon = "MONITOR.ICO"
string dataobject = "dw_smart_mps_demand_query"
boolean vscrollbar = true
end type

on dragdrop;call u_monitor_data_entry_dw::dragdrop;bMPS	= FALSE
end on

event constructor;call super::constructor;dw_mps_demand.Modify("due.color = '0~tif(qnty = qty_assigned, 16711680, 0)'")
dw_mps_demand.Modify("qnty.color = '0~tif(qnty = qty_assigned, 16711680 , 0)'")
dw_mps_demand.Modify("source.color = '0~tif(qnty = qty_assigned, 16711680, 0)'")
dw_mps_demand.Modify("origin.color = '0~tif(qnty = qty_assigned, 16711680, 0)'")
dw_mps_demand.Modify("dead_start.color = '0~tif(qnty = qty_assigned, 16711680, 0)'")
dw_mps_demand.Modify("assigned.color = '0~tif(qnty = qty_assigned, 16711680, 0)'")

call super::constructor
end event

on rbuttondown;call u_monitor_data_entry_dw::rbuttondown;MessageBox("Help", "COP exploded MPS requirements", Information!)
end on

on clicked;iMPSRow	= this.uf_row_clicked(0)

bMPS	= FALSE

If iMPSRow > 0 then
	bMPS	= TRUE
	this.Drag(Begin!)
End If	
end on

event doubleclicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	If this.GetItemNumber(iRow, "qnty") = this.GetItemNumber(iRow, "qty_assigned") then
		MessageBox(monsys.msg_title, "Demand has already been scheduled for receiving!", StopSign!)
	Else		
		this.SelectRow(iRow, Not(this.IsSelected(iRow)))
	End If
End If
end event

type uo_hard_queue from u_po_detail_hard_queue_coverage within w_smart_po_detail_entry_version3
boolean visible = false
integer x = 14
integer y = 100
integer width = 2885
integer taborder = 60
boolean border = false
end type

on uo_hard_queue.destroy
call u_po_detail_hard_queue_coverage::destroy
end on

type st_17 from statictext within w_smart_po_detail_entry_version3
integer x = 978
integer y = 736
integer width = 334
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "OverReceived:"
boolean focusrectangle = false
end type

type st_release from statictext within w_smart_po_detail_entry_version3
integer x = 1536
integer y = 736
integer width = 471
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Current Release:"
boolean focusrectangle = false
end type

type p_1 from picture within w_smart_po_detail_entry_version3
integer x = 2021
integer y = 732
integer width = 69
integer height = 64
string picturename = "printer.bmp"
boolean focusrectangle = false
end type

type cb_create from commandbutton within w_smart_po_detail_entry_version3
boolean visible = false
integer x = 1074
integer y = 444
integer width = 1129
integer height = 704
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type gb_4 from groupbox within w_smart_po_detail_entry_version3
integer x = 14
integer y = 96
integer width = 2830
integer height = 640
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "MPS Demand"
end type

type gb_1 from groupbox within w_smart_po_detail_entry_version3
integer x = 14
integer y = 736
integer width = 2830
integer height = 700
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "PO Releases"
end type

type cb_note from commandbutton within w_smart_po_detail_entry_version3
boolean visible = false
integer x = 526
integer y = 420
integer width = 1833
integer height = 592
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type


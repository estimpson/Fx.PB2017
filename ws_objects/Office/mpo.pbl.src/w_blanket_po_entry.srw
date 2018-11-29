$PBExportHeader$w_blanket_po_entry.srw
$PBExportComments$main blanket po screen.
forward
global type w_blanket_po_entry from w_sheet_4t
end type
type em_over_received from statictext within w_blanket_po_entry
end type
type st_over_received from statictext within w_blanket_po_entry
end type
type dw_detail from datawindow within w_blanket_po_entry
end type
type dw_header from datawindow within w_blanket_po_entry
end type
end forward

global type w_blanket_po_entry from w_sheet_4t
string title = "Blanket PO Entry"
string menuname = "m_blanket_po_entry"
event ue_exit pbm_custom01
event ue_save_header pbm_custom02
event ue_detail_note pbm_custom03
event ue_header_note pbm_custom04
event ue_print pbm_custom05
event ue_history pbm_custom06
event close_uo_for_print pbm_custom07
event start_to_print_po pbm_custom08
event ue_add_release pbm_custom09
event ue_delete_release pbm_custom10
event ue_close_po pbm_custom11
event ue_save_detail pbm_custom12
event ue_save_note pbm_custom13
event ue_close_uo_note pbm_custom14
event setup_parts_for_print pbm_custom15
event ue_refresh_releases pbm_custom16
event ue_objects pbm_custom17
event ue_print_update pbm_custom18
event ue_batch_create pbm_custom19
event ue_save_batch ( datawindow a_dw )
event changevendor ( )
event sendpoemail ( )
event changeshipto ( )
em_over_received em_over_received
st_over_received st_over_received
dw_detail dw_detail
dw_header dw_header
end type
global w_blanket_po_entry w_blanket_po_entry

type variables
Long    il_PO, &
            il_Flag, &
            il_row, &
            il_row_id, &
            il_next_row_id

String    is_vendor, &
             is_part, &
             is_name, &
             is_um, &
             is_GLAccount, &
             is_plant, &
	is_freighttype, &
	is_fob, &
	is_taxrate, &
	is_shipvia

Boolean 	ib_new, &
	ib_saved = false, &
	berrormin, &
	ib_header, &
	ib_detail, &
	ib_HeaderNote, &
	ib_DetailNote, &
	bitemchanged = false

st_generic_structure 	     stParm

s_normal_po                                 s_po

u_smart_po_printing_processor    uo_print

u_generic_note                             uo_normal_note

datetime                                        id_po_date

dec                        in_price, &
                              in_minonorder, &
                              in_minonhand, &
                              in_mps_covered, &
                              in_mps_uncovered, &
                              in_tax_rate

st_dda_parmlist	st_prmlst

DataWindowChild 	i_dw_ShipTo, &
		i_dw_Plant, &
		idw_child


end variables

forward prototypes
public function boolean wf_plant_is_required ()
public function boolean wf_update_vendor_part (string as_part, string as_vendor)
public function boolean wf_delete_marked_releases ()
public function boolean wf_partial_update_release (string a_s_vendor)
public function decimal wf_minon_order (string a_s_part, string a_s_vendor)
public subroutine wf_update_release (string a_s_flag)
public function decimal wf_get_over_received (string a_s_part, string a_s_vendor)
public function boolean wf_update_over_received (string a_s_vendor, string a_s_part, decimal a_n_qty)
public function date wf_next_day (date a_d_date, integer a_i_unit, string a_s_type)
public subroutine wf_create_ship_to (string a_s_ship_type)
public subroutine wf_update_detail_plants (string a_s_plant)
public function string wf_get_terms (string a_s_vendor)
public function boolean wf_accum ()
public function boolean wf_save_changes ()
public subroutine wf_get_unit_of_measurement_part (string a_s_part)
public function boolean wf_closed_po (long a_l_po)
public function decimal wf_get_price (decimal orderqty, decimal an_price)
end prototypes

event ue_exit;close( w_blanket_po_entry)
end event

event ue_save_header;/* 01-25-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'il_po' (next PO number).  Also placed the rollbacks 
						before the message boxes to release the database to avoid deadlocks.     */
/* 03-23-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to populate 
						unit of measure DDDW in dw_smart_blanket_po_detail_entry.  Issue # 13193 */

String szShipType
String szPlant
String ls_ShipDest
String sz_release_control
string ls_vendor
String l_s_SQLErrorText																// ADD 04-03-2000 KAZ


if ib_header then

	dw_header.setitem(1, "type", "B") 

   is_vendor = dw_header.Object.vendor_code[1]
	If IsNull(is_Vendor) then
		MessageBox( monsys.msg_title, "Vendor code cannot be null!", Exclamation! )
		Return
	End If
	
	IF isnull ( dw_header.object.po_date[1] ) then
		MessageBox( monsys.msg_title, "PO date cannot be null!", Exclamation! ) 
		Return
	End If

	sz_release_control = dw_header.Object.Release_control[1]
	If IsNull(sz_release_control) or (sz_release_control = '') then
		MessageBox(monsys.msg_title, "Release Control is required!", Exclamation!) 
		Return
	End If
	
	If IsNull(dw_header.Object.blanket_part[1]) or (dw_header.Object.blanket_part[1] = '') then
		MessageBox(monsys.msg_title, "Part Number cannot be null!", Exclamation!) 
		Return
	End If


	szPlant	= dw_header.Object.plant[1]
	If IsNull(szPlant) or (szPlant = '') then
		If wf_plant_is_required() then
			MessageBox( monsys.msg_title, "Plant code cannot be null!", Exclamation! ) 
			Return
		End If
	End If

	szShipType	= dw_header.Object.ship_type[1]
	If IsNull(szShipType) or (szShipType = '') then
		MessageBox(monsys.msg_title, "Ship Type cannot be null!", Exclamation! ) 
		Return
	End If

	ls_ShipDest	= 	dw_header.Object.ship_to_destination[1]
   If szShipType = "DropShip" Then
		If IsNull(ls_ShipDest) OR (ls_ShipDest = '') Then
			MessageBox(monsys.msg_title, "Ship To Destination cannot be null!", Exclamation! ) 
			Return
		End If
	End If
	
	if ib_new then
  
//		OpenWithParm ( w_get_parm_value, "purchase_order" )																	-  CHG 01-25-2000 KAZ
//		Do while Not bFinish	//Waiting for the new PO number																	-  CHG 01-25-2000 KAZ
//		Loop																																	-  CHG 01-25-2000 KAZ

//		il_po	= Message.DoubleParm																										-  CHG 01-25-2000 KAZ
//		If il_po < 0 then		//Fail to get current value																		-  CHG 01-25-2000 KAZ
//			MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Exclamation! )		-  CHG 01-25-2000 KAZ
//			il_po	= 0																														-  CHG 01-25-2000 KAZ
//			Return																															-  CHG 01-25-2000 KAZ

		if not sqlca.of_getnextparmvalue ( "purchase_order", il_po ) then    // Failed to get current value	-  ADD 01-25-2000 KAZ
			Rollback;																														// ADD 01-25-2000 KAZ
			MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Exclamation! )		// ADD 01-25-2000 KAZ
			il_po	= 0																														// ADD 01-25-2000 KAZ
			Return																															// ADD 01-25-2000 KAZ

		Else
			dw_header.SetItem(1, "po_number", il_po)		
			dw_header.SetItem(1, "status", "A")
			If szShipType = 'Normal' then
				dw_header.SetItem(1, "ship_to_destination", szPlant)
			End If
		End If

	Else			

		If szShipType = 'Normal' Then
			szPlant	= dw_header.Object.plant[1]
			dw_header.SetItem(1, "ship_to_destination", szPlant)
		End If

	End If

	If dw_header.Update() > 0 then

     ls_vendor = dw_header.Object.vendor_code[1]
 	  is_part = dw_header.Object.blanket_part[1]

	  if wf_update_vendor_part(is_part, ls_vendor) then
			Commit;
			il_po   = dw_header.Object.po_number[1]
		   is_plant =  dw_header.object.plant [1]
			in_tax_rate = dw_header.object.tax_Rate [1]
			wf_get_unit_of_measurement_part (is_part)													// ADD 03-23-2000 KAZ
	    	dw_detail.retrieve( il_po , is_part)
		   ib_saved = true
   		bitemchanged = false																				// ADD 03-23-2000 KAZ
	   	ib_new = false
			ib_header = false
			
			IF dw_header.Object.release_control[1] = 'A' THEN
				em_over_received.text =  STRING ( wf_get_over_received ( is_part, is_vendor ) )
			ELSE	
				em_over_received.text = '0' 
			END IF
						
		else
			l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/03/2000 KAZ
			Rollback ;
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/03/2000 KAZ
		end if 
	Else
		l_s_SQLErrorText = SQLCA.SQLErrText																		// ADD 04/03/2000 KAZ
		Rollback ;
		MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)										// ADD 04/03/2000 KAZ
	End If

Elseif ib_detail then
	
   Triggerevent ( "ue_save_detail")
	
End if



end event

event ue_detail_note;/* 03-13-2000 KAZ Modified to properly update the appropriate Header or Detail note field. */
/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

string ls_note, &
		 ls_datatype

long ll_row

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																				// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return													// ADD 03-23-2000 KAZ
End If																								// ADD 03-23-2000 KAZ

ll_row = dw_detail.getselectedrow(0)

If ll_row > 0 then
	
	ls_datatype  = dw_detail.object.notes.coltype
	
	openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!

	ls_note = dw_detail.getitemstring(ll_row, "notes")
   il_Row_id = dw_Detail.getitemnumber(ll_Row, "row_id")
	uo_normal_note.mle_note.text = ls_note
	ib_DetailNote = True																				// ADD 03-13-2000 KAZ

else

   MessageBox (monsys.msg_title, "You have to select a release first!", Information! )
   return
  
end if
end event

event ue_header_note;/* 03-13-2000 KAZ Modified to properly update the appropriate Header or Detail note field. */
/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

string ls_note																								// ADD 03-13-2000 KAZ

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																						// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return															// ADD 03-23-2000 KAZ
End If																										// ADD 03-23-2000 KAZ

Select 	notes 																							// ADD 03-13-2000 KAZ
Into		:ls_note																							// ADD 03-13-2000 KAZ
From 		po_header 																						// ADD 03-13-2000 KAZ
Where 	po_number = :il_po; 																			// ADD 03-13-2000 KAZ

openuserobjectwithparm (uo_normal_note, 'char', 622,161)										// ADD 03-13-2000 KAZ
uo_normal_note.bringtotop = True																		// ADD 03-13-2000 KAZ
uo_normal_note.borderstyle = StyleRaised!															// ADD 03-13-2000 KAZ
uo_normal_note.mle_note.text = ls_note																// ADD 03-13-2000 KAZ
ib_HeaderNote = True																						// ADD 03-13-2000 KAZ


//string ls_note, &																						-  CHG 03-13-2000 KAZ
//		 ls_syntax, &																						-  CHG 03-13-2000 KAZ
//		 ls_error, &																						-  CHG 03-13-2000 KAZ
//		 ls_datatype		 																				-  CHG 03-13-2000 KAZ
//
//datastore  lds_ponote																					-  CHG 03-13-2000 KAZ
//lds_ponote = create datastore 																		-  CHG 03-13-2000 KAZ
//
//ls_syntax  = 'Select notes from po_header where po_number = ' + string ( il_po )	-  CHG 03-13-2000 KAZ
//ls_syntax  = SQLCA.SyntaxFromSQL ( ls_syntax, "style(type=grid)",  ls_error )		-  CHG 03-13-2000 KAZ
//
//If ls_error <= '' or isnull ( ls_error ) then 												-  CHG 03-13-2000 KAZ
//	lds_ponote.create ( ls_syntax, ls_error ) 													-  CHG 03-13-2000 KAZ
//	lds_ponote.settransobject ( sqlca )																-  CHG 03-13-2000 KAZ
//	if lds_ponote.retrieve () > 0 then																-  CHG 03-13-2000 KAZ
//		ls_note = lds_ponote.object.#1 [1] 															-  CHG 03-13-2000 KAZ
//	end if																									-  CHG 03-13-2000 KAZ
//end if																										-  CHG 03-13-2000 KAZ
//
//ls_datatype = lds_ponote.object.#1.coltype														-  CHG 03-13-2000 KAZ
//
//destroy lds_ponote ;																					-  CHG 03-13-2000 KAZ
//
//openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161 )							-  CHG 03-13-2000 KAZ
//uo_normal_note.bringtotop = True																	-  CHG 03-13-2000 KAZ
//uo_normal_note.borderstyle = StyleRaised!														-  CHG 03-13-2000 KAZ
//
//uo_normal_note.mle_note.text = ls_note															-  CHG 03-13-2000 KAZ
//


end event

event ue_print;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

DATE dStartDate, dEndDate

STRING ls_part

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

setnull(ls_part)

IF dw_detail.RowCount() > 0 THEN
	
	IF il_po > 0 THEN
		dStartDate	= date( dw_detail.Object.date_due[1] )
		dEndDate	= date( dw_detail.Object.date_due[dw_detail.RowCount()] )
		OpenUserObject(uo_print, 622, 161)
		uo_print.visible		= TRUE
		uo_print.bringtotop	= TRUE
		uo_print.uf_setup ( il_po, ls_part, dStartDate, dEndDate )
		uo_print.taborder = 1
		uo_print.em_date_from.setfocus()		
	ELSE
		MessageBox(monsys.msg_title, "You should select a P.O. first.", StopSign!)
	END IF

ELSE

	MessageBox(monsys.msg_title, "There are no detail items to print.", StopSign!)

END IF
end event

event ue_history;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

stParm.value1	= String(il_PO)
stParm.value2	= dw_header.Getitemstring(1, "blanket_part")

OpenWithParm(w_smart_po_receiving_history, stParm)
end event

event close_uo_for_print;IF IsValid(uo_print) THEN
   closeuserobject(uo_print)
END IF
end event

event start_to_print_po;/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

n_cst_associative_array	lnv_Parm
IF uo_print.ddlb_style.text = 'Release' THEN
	lnv_Parm.of_SetItem("Report", "PO - Release")
ELSEIF uo_print.ddlb_style.text = 'Blanket PO' THEN
	lnv_Parm.of_SetItem("Report", "Blanket PO")
ELSEIF uo_print.ddlb_style.text = 'Normal PO' THEN
   RETURN
END IF

uo_print.visible	= FALSE
lnv_Parm.of_SetItem("Arg1", il_PO)

Print (lnv_Parm)

end event

event ue_add_release;/* 03-15-2000 KAZ Modified to properly populate the unit of measure field. */
/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 03-23-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to populate 
						unit of measure DDDW in dw_smart_blanket_po_detail_entry.  Issue # 13193 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */


string ls_shipto, &
       ls_terms, &
       ls_plant, &
       ls_ship_type, &
       ls_shipvia, &
       ls_release_control, &
		 ls_part, &
		 ls_StandardUm, &
		 ls_VendorCode

Integer li_seqno
		 
DATETIME ld_scheculed_time

Long   ll_count

Dec    ln_release

ls_VendorCode = dw_header.Object.vendor_code[1]
string vendorStatus
select
	coalesce (status, 'Approved')
into
	:vendorStatus
from
	vendor
where
	code = :ls_VendorCode;

if	isnull(vendorStatus,'') <> 'Approved' then
	Messagebox ( monsys.msg_title, "Sorry can't proceed, as vendor status is not approved")
	ib_header = false
	bitemchanged = false
	return
end if

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																				// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return													// ADD 03-23-2000 KAZ
End If																								// ADD 03-23-2000 KAZ

ls_part  = dw_header.Object.blanket_part[dw_header.getrow()]
ld_scheculed_time = dw_header.Object.scheduled_time[dw_header.getrow()]
//is_Um		= f_get_part_info(ls_Part, "STANDARD UNIT")								// CHG 03-15-2000 KAZ
ls_StandardUM = f_get_part_info(ls_Part, "STANDARD UNIT")
//if isnull(is_um) or is_um = '' then is_um = 'EA' 									// CHG 03-15-2000 KAZ
is_Name		= f_get_part_info(ls_Part, "NAME")
is_GLAccount= f_get_part_info(ls_Part, "GL ACCOUNT")

wf_get_unit_of_measurement_part (ls_part)													// ADD 03-23-2000 KAZ	

dw_detail.insertrow(1)
dw_detail.setrow(1)
dw_detail.setcolumn(1)
dw_detail.setfocus()

select ship_to_Destination,   
       terms,
       plant,
       ship_type,
       release_no,
       ship_via,
		 blanket_part,
		 vendor_code
into   :ls_shipto, 
       :ls_terms, 
       :ls_plant, 
       :ls_ship_type, 
       :ln_release, 
       :ls_shipvia,
		 :is_part,
		 :ls_VendorCode
from 	po_header
where po_number = :il_po ;

if sqlca.sqlcode = 0 then
      
  		dw_detail.setitem(1, "ship_to_destination", ls_shipto )
  		dw_detail.setitem(1, "terms",  ls_terms)
  		dw_detail.setitem(1, "plant", ls_plant)
  		dw_detail.setitem(1, "release_no",  ln_release)
  		dw_detail.setitem(1, "ship_via",  ls_shipvia)
      dw_detail.setitem(1, "part_number", is_part)
 
end if

Select receiving_um
Into   :is_Um																						// ADD 03-15-2000 KAZ
From   part_vendor																				// ADD 03-15-2000 KAZ
Where  part = :is_part																			// ADD 03-15-2000 KAZ
And    vendor = :ls_VendorCode ;																// ADD 03-15-2000 KAZ

is_um = isnull ( is_um, isnull ( ls_standardum, 'EA' ) )

dw_detail.SetItem (1, "po_number", il_po)
dw_detail.SetItem (1, "status", "A")
dw_detail.SetItem (1, "vendor_code", dw_header.Object.vendor_code[dw_header.getrow()] )  
dw_detail.SetItem (1, "received", 0)
dw_detail.SetItem (1, "printed", "N")
dw_detail.setitem (1, "type", "B" )
dw_detail.SetItem (1, "po_detail_scheduled_time", ld_scheculed_time )
dw_detail.SetItem	( 1, "row_id", il_next_row_id )
il_next_row_id  =  il_next_row_id  + 1
dw_detail.SetItem ( 1, "description", is_name )
dw_detail.SetItem ( 1, "account_code", is_glaccount )
dw_detail.SetItem ( 1, "unit_of_measure", is_um )
dw_detail.setitem ( 1, "price", in_price )
dw_detail.setitem ( 1, "date_due", datetime ( today(), time ( '00:00:00' ) ) )





end event

event ue_delete_release;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */


Integer li_rtn_code

Dec     ln_received

string  ls_vendor

long	  ll_row

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

IF MessageBox(	monsys.msg_title, "System will set deletion mark to all " + &
					"highlighted releases. Continue to process?", StopSign!, &
					YesNo!) = 1 Then

	For ll_row = dw_detail.Rowcount() to 1 Step -1

		If dw_detail.isselected(ll_row) Then

		  If dw_detail.getitemstring (ll_row, "deleted") <> 'Y'  or isnull(dw_detail.getitemstring (ll_row, "deleted")) then
		
			ln_Received  = dw_detail.Getitemnumber( ll_row, "received" )
	    	
	       dw_detail.setitem(ll_row, "Deleted", "Y")
          ls_vendor = dw_Detail.getitemstring(ll_row, "vendor_code")

			 IF ln_received > 0 AND dw_header.object.release_control[1] = 'A' THEN
					em_over_received.text = string ( dec ( em_over_received.text ) + ln_received )
 			 END IF
			  
			 dw_detail.SetItem(ll_row, "printed", "N")
			 dw_detail.SetItem(ll_row, "quantity", 0)
			 dw_detail.SetItem(ll_row, "received", 0)
			 dw_detail.SetItem(ll_row, "balance",  0)
			 dw_detail.SetItem(ll_row, "standard_qty", 0)
			 dw_detail.SetItem(ll_row, "price", 0)
   	   
			 If dw_detail.update() = 1 then
      		commit ;
	       else
				rollback ;
      	 end if

		ELSEIF dw_detail.getitemstring (ll_row, "Deleted") = 'Y' THEN
  
	     messagebox(monsys.msg_title, "This item is already marked for deletion!", Information! )
   	  return    

	  END IF

	 END IF
 
	next

END IF
Triggerevent ( 'ue_save_detail' )


end event

event ue_close_po;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

Long iTotalRows

Int  ideleted

String l_s_SQLErrorText																	// ADD 04-03-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

If il_po > 0 then

	SELECT count(po_detail.po_number ),
			 count(deleted)  
   INTO :iTotalRows,
		  :ideleted  
   FROM po_detail  
   WHERE po_detail.po_number = :il_po   ;

	If iTotalRows > 0  and iTotalRows > ideleted then

		MessageBox(monsys.msg_title, "You can not close a P.O. with active releases. " + &
		"You must wait until the order has been received or you must delete the open releases.", StopSign!)

	Else

		If MessageBox(monsys.msg_title, "Sure to close this po?", Question!, YesNo!) = 1 then

		  	UPDATE po_header  
	     	SET status = 'C'  
		  	WHERE po_number = :il_po   ;

			If SQLCA.SQLCode = 0 then
	    		  	UPDATE po_detail 
	   		  	SET status = 'C'  

				  	WHERE po_number = :il_po   ;

            If sqlca.sqlcode = 0 then
					Commit;
      	      Close( w_blanket_po_entry )
				Else
					l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/03/2000 KAZ
					Rollback ;
					MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/03/2000 KAZ
				End If				
			End if      
		End If
	End If
End If	
end event

event ue_save_detail;/* 03-08-2000 KAZ Modified to calculate the week number everytime a detail record is saved.
						Issue # 13214 */
/* 03-23-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to populate 
						unit of measure DDDW in dw_smart_blanket_po_detail_entry.  Issue # 13193 */

Date l_d_DateDue																		// ADD 03-08-2000 KAZ
String l_s_SQLErrorText // ADD 04-03-2000 KAZ
string	ls_unit, &
	ls_part
dec	ld_stdqty, &
	ld_qty
long	ll_row, ll_rowcount

// Calculate the week number..													-  ADD 03-08-2000 KAZ

ll_rowcount = dw_detail.RowCount ( )
for ll_row = 1 to ll_rowcount
	if dw_detail.GetItemStatus ( ll_row, 1, Primary! ) <> NotModified! then
		l_d_DateDue = date ( dw_detail.GetItemDateTime ( ll_row, "date_due" ) )
		dw_detail.SetItem ( ll_row, "week_no", f_get_week_no ( l_d_DateDue ) )
	end if 

//	Included the below code as standard_qty column was not updated, due to which
//	Grids were not reflecting the correct values. GPH 2/27/01

	ls_unit	= dw_detail.object.unit_of_measure[ll_row]
	ls_part = dw_detail.object.part_number[ll_row]
	ld_qty	= dw_detail.object.quantity[ll_row]
	ld_stdqty = f_convert_units ( ls_unit, '', ls_part, ld_qty )
	dw_detail.SetItem ( ll_row, "standard_qty", ld_stdqty ) 
	dw_detail.SetItem ( ll_row, "ship_type", LeftA(dw_header.object.ship_type[1],1))

next

IF wf_Accum() Then
	
	IF wf_update_over_received ( is_vendor, is_part, dec ( em_over_received.text ) ) THEN

		IF dw_Detail.Update() > 0 THEN

			// MB 01/27/04 update po_header with next seq no 
			Update po_header
			Set  next_seqno = :il_next_row_id
			Where po_number = :il_po ;
				
			IF sqlca.sqlcode <> 0 THEN
				rollback ;
				messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
			END IF
			
			Commit ;
			ib_detail = False
			bNoCommit = FALSE
			SetMicroHelp ( 'Recalculating PO detail for part' + is_part )
			f_recalc_po_detail_per_part ( il_PO, is_Part, this )
			SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + is_part )
			f_update_qty_asgnd_part ( is_part ) 
//			IF dw_header.object.release_control [1] = 'A' THEN	
				If ( dw_detail.object.quantity[1] > dec ( em_over_received.text ) ) Then
					em_over_received.Text	= '0'
				Else
					em_over_received.Text = string ( wf_get_over_received ( is_part, is_Vendor ))//String(Truncate((dec ( em_over_received.text ) - dw_detail.object.quantity[1]), 0))
				End If
//			END IF

			wf_get_unit_of_measurement_part (is_part)															// ADD 03-23-2000 KAZ
			dw_detail.Retrieve(il_po, is_Part)
		ELSE
			l_s_SQLErrorText = sqlca.sqlerrtext																	// ADD 04/03/2000 KAZ
			Rollback ;
			MessageBox (monsys.msg_title, l_s_SQLErrorText, StopSign! )												// ADD 04/03/2000 KAZ
		END IF
	END IF
ELSE
	IF dw_Detail.Update() > 0 THEN
			// MB 01/27/04 update po_header with next seq no 
			Update po_header
			Set  next_seqno = :il_next_row_id 
			Where po_number = :il_po ;
				
			IF sqlca.sqlcode <> 0 THEN
				rollback ;
				messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
			END IF
			
		Commit ;
		ib_detail = False
		bNoCommit = FALSE
		SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + is_part )
		f_update_qty_asgnd_part ( is_part ) 
		wf_get_unit_of_measurement_part (is_part)																// ADD 03-23-2000 KAZ
		dw_detail.Retrieve(il_po, is_Part)
	Else
		l_s_SQLErrorText = sqlca.sqlerrtext																		// ADD 04/03/2000 KAZ
		Rollback ;
		MessageBox (monsys.msg_title, l_s_SQLErrorText, StopSign! )										// ADD 04/03/2000 KAZ
	END IF

END IF

SetMicroHelp ( 'Ready' )

end event

event ue_save_note;/* 03-13-2000 KAZ Modified to properly update the appropriate Header or Detail note field. */

string ls_note

ls_note = uo_normal_note.mle_note.text

//if ib_detail then															-  CHG 03-13-2000 KAZ
if ib_DetailNote then														// CHG 03-13-2000 KAZ

	update 	po_detail
	set		notes = :ls_note
	where 	po_number = :il_po and
   	      part_number = :is_part and
      	   row_id      = :il_row_id ;

	if sqlca.sqlcode = 0 then
		commit ;
	   closeuserobject(uo_normal_note)
		dw_detail.retrieve(il_po, is_part)
	else
   	rollback ;
		messagebox ( monsys.msg_title, "Unable to save the note!" )
	end if

end if
//else																			-  CHG 03-13-2000 KAZ
if ib_HeaderNote then														// CHG 03-13-2000 KAZ
	
	update 	po_header
	set		notes = :ls_note
	where 	po_number = :il_po ;

	if sqlca.sqlcode = 0 then
		commit ;
	   closeuserobject(uo_normal_note)
		dw_header.retrieve(il_po)
	else
   	rollback ;
		messagebox ( monsys.msg_title, "Unable to save the note!" )
	end if	
	
end if

ib_HeaderNote = false
ib_DetailNote = false

end event

event ue_close_uo_note;if isvalid(uo_normal_note) then
  closeuserobject(uo_normal_note)
  dw_header.Retrieve(il_PO)
end if

ib_HeaderNote = false															// ADD 03-13-2000 KAZ
ib_DetailNote = false															// ADD 03-13-2000 KAZ
end event

event setup_parts_for_print;Long iRow
Long iTotalRows

String ls_part

iTotalRows	= dw_detail.RowCount()

uo_print.dw_parts.Reset()

FOR iRow = iTotalRows TO 1 STEP -1
	ls_part = dw_detail.Object.part_number[1]
	uo_print.dw_parts.InsertRow(1)
	uo_print.dw_parts.SetItem(1, 1, ls_part)
NEXT

uo_print.dw_parts.SelectRow(0, TRUE)






end event

event ue_refresh_releases;/* 03-23-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to populate 
						unit of measure DDDW in dw_smart_blanket_po_detail_entry.  Issue # 13193 */

dw_header.retrieve(il_po)
wf_get_unit_of_measurement_part (is_part)											// ADD 03-23-2000 KAZ
dw_detail.retrieve(il_po, is_part)
end event

event ue_objects;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

OpenWithParm(w_smart_po_objects, is_Part)
end event

event ue_print_update;String l_s_SQLErrorText																// ADD 04-03-2000 KAZ

If not uo_print.cbx_freeze.checked then wf_update_release ( '+' )

IF wf_delete_marked_releases( ) THEN

		IF IsNull ( is_part ) THEN
			UPDATE po_detail
			SET 	Printed = 'Y'
			WHERE Po_number = :il_po AND
					selected_for_print = 'Y' ;
		ELSE
			UPDATE po_detail 
			SET  	Printed = 'Y' 
			WHERE Po_number = :il_po AND
					selected_for_print = 'Y' AND part_number = :is_part;
		END IF
	
		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			TriggerEvent("ue_refresh_releases")
		ELSE
			l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/03/2000 KAZ
			Rollback ;
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/03/2000 KAZ
		END IF

ELSE

	l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/03/2000 KAZ
	Rollback ;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/03/2000 KAZ
	
END IF

end event

event ue_batch_create;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

If wf_closed_po ( il_po ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(il_po)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

Openwithparm ( w_batch_release, this )
end event

event ue_save_batch;/* 02-23-2000 KAZ Modified to avoid update and commit conflicts that cause PO detail records 
						to be inadvertently deleted.  Issue # 13221 */
/* 03-23-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to populate 
						unit of measure DDDW in dw_smart_blanket_po_detail_entry.  Issue # 13193 */

Integer 	l_i_Count, &
			l_i_period, &
			li_seqno

Date		l_d_Date

Long		l_l_count

decimal	l_n_price		

string   l_s_account, &
		   l_s_unit
String 	l_s_SQLErrorText																// ADD 04-03-2000 KAZ

decimal  l_n_check_price
datawindowchild	ldwc_dddw

IF a_dw.Rowcount() <= 0 THEN RETURN

l_d_Date	= a_dw.object.#3[1]
l_s_account	= f_get_part_info(a_dw.object.#1[1], "GL ACCOUNT")
l_s_unit	= a_dw.object.unit[1] // f_get_part_info(a_dw.object.#1[1], "STANDARD UNIT")
l_n_check_price = a_dw.object.#7[1]
l_n_price    	= l_n_check_price 
l_i_period    	= a_dw.object.#4[1]
li_seqno 		= f_get_podet_next_seqno ( il_po ) 

DATASTORE  l_dw_detail

l_dw_detail = CREATE DATASTORE

l_dw_detail.dataobject = 'dw_smart_po_detail_entry'
l_dw_detail.settransobject ( sqlca )
l_dw_detail.GetChild ( "unit_of_measure", ldwc_dddw )
ldwc_dddw.InsertRow ( 1 )

IF a_dw.object.#4[1] > 0 THEN

	For l_i_Count = 1 to a_dw.object.#4[1]

		l_dw_detail.InsertRow(1)
		l_dw_detail.SetItem(1, "part_number", a_dw.object.#1[1] )
		l_dw_detail.SetItem(1, "description", a_dw.object.#2[1])
		l_dw_detail.SetItem(1, "po_number", il_PO)
		l_dw_detail.SetItem(1, "status", "A")
		l_dw_detail.SetItem(1, "vendor_code", is_vendor )
		l_dw_detail.SetItem(1, "unit_of_measure", l_s_unit)	
		l_dw_detail.SetItem(1, "terms", dw_header.object.terms[1])
		l_dw_detail.SetItem(1, "printed", 'N' )
		l_dw_detail.SetItem(1, "account_code", l_s_account )
		l_dw_detail.SetItem(1, "ship_via", dw_header.object.ship_via[1] )
		l_dw_detail.SetItem(1, "week_no", f_get_week_no(l_d_date) )
		l_dw_detail.SetItem(1, "price", l_n_price )
		l_dw_detail.SetItem(1, "date_due",  l_d_date)
		l_dw_detail.SetItem(1, "quantity", a_dw.object.#6[1])
		l_dw_detail.SetItem(1, "received", 0)
		l_dw_detail.SetItem(1, "balance", a_dw.object.#6[1])
		l_dw_detail.SetItem(1, "release_no", dw_header.object.release_no[1])
		l_dw_detail.SetItem(1, "row_id",  li_seqno  )
		li_Seqno  =  li_seqno  + 1
		l_dw_detail.SetItem(1, "taxable", a_dw.object.#8[1])

		l_l_count++
		l_d_Date	= wf_next_day ( l_d_Date, 1, a_dw.object.#5[1] )

	Next

	l_dw_detail.accepttext()
	
	IF l_dw_detail.Update () > 0 THEN
		
		// MB 01/27/04 update po_header with next seq no 
		Update po_header
		Set  next_seqno = :li_seqno 
		Where po_number = :il_po ;
		
		IF sqlca.sqlcode <> 0 THEN
			rollback ;
			messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
		END IF
		
		COMMIT ;
		il_next_row_id = li_seqno
		SetMicroHelp ( 'Recalculating PO detail for part' + is_part )									// ADD 02/23/2000 KAZ
		f_recalc_po_detail_per_part ( il_PO, is_Part, this )												// ADD 02/23/2000 KAZ
		SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + is_part )					// ADD 02/23/2000 KAZ
		f_update_qty_asgnd_part ( is_part ) 																	// ADD 02/23/2000 KAZ
		wf_get_unit_of_measurement_part (is_part)																// ADD 03-23-2000 KAZ
		dw_detail.Retrieve(il_po, is_Part)																		// ADD 02/23/2000 KAZ
		Setmicrohelp ( 'Ready' )
	ELSE
		l_s_SQLErrorText = SQLCA.SQLErrText																				// ADD 04/03/2000 KAZ
		Rollback ;
		MessageBox(monsys.msg_title, 'Unable to add batch releases. '+ l_s_SQLErrorText, StopSign!)	// ADD 04/03/2000 KAZ
	END IF

END IF

DESTROY l_dw_detail 


end event

event changevendor();
if	dw_header.RowCount() <= 0 then
	return
end if

//	Open dialog to get vendor change...
long	purchaseOrderNumber
purchaseOrderNumber = dw_header.object.po_number[dw_header.getrow()]
message.inv_Parm.of_SetItem("PurchaseOrderNumber", purchaseOrderNumber)
open(w_changepovendor)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the vendor change.
	string newVendor
	newVendor = message.inv_Parm.of_GetItem("NewVendor")
	
	//	Create substitution.
	n_cst_purchasingtrans Purchasing
	Purchasing = create n_cst_purchasingtrans
	Purchasing.ChangePOVendor(purchaseOrderNumber, newVendor)
	destroy Purchasing
	dw_header.object.vendor_code[1] = newVendor
end if

end event

event sendpoemail();
n_cst_associative_array	lnv_Parm
lnv_Parm.of_SetItem("Report", "PO - Release")
lnv_Parm.of_SetItem("Arg1", il_PO)
opensheetwithparm(w_sendporeleases, lnv_Parm, gnv_App.of_GetFrame(), 0, Original!)

end event

event changeshipto();
if	dw_header.RowCount() <= 0 then
	return
end if

//	Open dialog to get ship to change...
long	purchaseOrderNumber
purchaseOrderNumber = dw_header.object.po_number[dw_header.getrow()]
message.inv_Parm.of_SetItem("PurchaseOrderNumber", purchaseOrderNumber)
open(w_changeposhipto)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the vendor change.
	string newShipTo
	newShipTo = message.inv_Parm.of_GetItem("NewShipTo")
	
	//	Create substitution.
	n_cst_purchasingtrans Purchasing
	Purchasing = create n_cst_purchasingtrans
	Purchasing.ChangePOShipTo(purchaseOrderNumber, newShipTo)
	destroy Purchasing
	dw_header.object.ship_to_destination[1] = newShipTo
end if

end event

public function boolean wf_plant_is_required ();String szPlantRequired

SELECT parameters.plant_required  
  INTO :szPlantRequired  
  FROM parameters  ;

Return (szPlantRequired = 'Y')
end function

public function boolean wf_update_vendor_part (string as_part, string as_vendor);string ls_part

select part
into   :ls_part
from	 part_vendor
where  part = :as_part and 
       vendor = :as_vendor ;
		 
if sqlca.sqlcode = 0 then
	
    return true
 
else

   insert into part_vendor
	(part,
	 vendor,
	 receiving_um)
	values
	(:as_part,
	 :as_vendor,
	 :is_Um) ;
	 
	 if sqlca.sqlcode = 0 then
		 commit ;
       return true
    else
	    rollback ;
		 return false
	 end if

end if
end function

public function boolean wf_delete_marked_releases ();String l_s_CurrentPart
String l_s_PartList[]

Integer 	l_i_Count = 0

Decimal  l_n_TotalReceived

Boolean	l_b_OK	 = TRUE	

If IsNull(is_part) then	//Print for all parts
	Declare curPart1 Cursor For
	Select Distinct po_detail.part_number  
	From  po_detail  
	Where po_detail.po_number = :il_PO AND
			po_detail.deleted = 'Y' AND
			po_detail.selected_for_print = 'Y'  ;
Else
	Declare curPart2 Cursor For
	Select Distinct po_detail.part_number  
	From  po_detail  
	Where po_detail.po_number = :il_PO AND
			po_detail.deleted = 'Y' AND
			po_detail.selected_for_print = 'Y' AND
			po_detail.part_number = :is_part  ;
End If

If IsNull(is_part) then
	Open curPart1;
	Fetch curPart1 into :l_s_CurrentPart;
Else
	Open curPart2;
	Fetch curPart2 into :l_s_CurrentPart;
End If

Do While SQLCA.SQLCode = 0
	l_i_Count ++
	l_s_PartList[l_i_Count]	= l_s_CurrentPart

	If IsNull(is_part) then
		Fetch curPart1 into :l_s_CurrentPart;		
	Else
		Fetch curPart2 into :l_s_CurrentPart;
	End If

Loop

If IsNull(is_part) then
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
		   Where  (po_detail.po_number = :il_PO ) AND  
		          (po_detail.part_number = :l_s_CurrentPart ) AND
					 (po_detail.selected_for_print = 'Y') AND
					 (po_detail.deleted = 'Y')  ;

			l_i_Count --

//			If wf_update_overreceived(is_vendor, l_s_CurrentPart, l_n_TotalReceived) then
				Delete From PO_detail Where 	po_number = :il_PO And
										 	part_number = :l_s_CurrentPart And
											Deleted		= 'Y';

				If SQLCA.SQLCode = 0 then
					l_b_OK	= True
				Else
					l_b_OK	= False
				End If
//			Else
//				l_b_OK	= FALSE
//			End If
				
			Loop	
	End If
End If

Return l_b_OK
end function

public function boolean wf_partial_update_release (string a_s_vendor);String l_s_PartialUpdate

SELECT partial_release_update  
  INTO :l_s_PartialUpdate  
  FROM vendor  
 WHERE code = :is_vendor   ;

If l_s_PartialUpdate = 'Y' then
	Return TRUE
Else
	Return FALSE
End If
end function

public function decimal wf_minon_order (string a_s_part, string a_s_vendor);Decimal l_n_Qty

SELECT part_vendor.min_on_order  
  INTO :l_n_Qty  
  FROM part_vendor  
 WHERE ( part_vendor.part = :a_s_Part ) AND  
       ( part_vendor.vendor = :a_s_Vendor )   ;

IF ISNULL(l_n_Qty) THEN
	RETURN 0
ELSE
	RETURN l_n_qty
END IF
end function

public subroutine wf_update_release (string a_s_flag);Long		l_l_Release

SELECT release_no 
  INTO :l_l_Release  
  FROM po_header  
 WHERE po_number = :il_PO;

l_l_Release	 = f_get_value(l_l_Release)

If a_s_flag = '+' then

	l_l_release = l_l_release + 1
	
ELSE
	
	l_l_release = l_l_release - 1 

END IF

UPDATE  po_header  
SET  	 release_no 	= :l_l_Release  
WHERE  po_number	= :il_PO;

IF wf_partial_update_release ( is_vendor ) THEN

		UPDATE po_detail  
	   	SET release_no = :l_l_Release
	 	WHERE po_number 	= :il_PO AND selected_for_print = 'Y'  ;

ELSE

		UPDATE po_detail  
	   	SET release_no = :l_l_Release
	 	WHERE po_number 	= :il_PO   ;

END IF

IF SQLCA.SQLCode = 0 THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF
end subroutine

public function decimal wf_get_over_received (string a_s_part, string a_s_vendor);Decimal l_n_QtyOverReceived

SELECT part_vendor.qty_over_received  
  INTO :l_n_QtyOverReceived  
  FROM part_vendor  
 WHERE ( part_vendor.part = :a_s_Part ) AND  
       ( part_vendor.vendor = :a_s_Vendor )   ;

RETURN ISNULL( TRUNCATE ( l_n_QtyOverReceived , 0 ), 0 )
end function

public function boolean wf_update_over_received (string a_s_vendor, string a_s_part, decimal a_n_qty);UPDATE 	part_vendor  
SET 		qty_over_received = :a_n_qty
WHERE 	( vendor = :a_s_vendor ) AND  
         ( part = :a_s_Part )   ;

Return ( SQLCA.SQLCode = 0 )
end function

public function date wf_next_day (date a_d_date, integer a_i_unit, string a_s_type);Long 	l_l_year, &
		l_l_Month, &
		l_l_Day

If a_s_type	= "Day" then
	Return RelativeDate(a_d_date, a_i_Unit)
End If

If a_s_type	= "Week" then
	Return RelativeDate(a_d_date, (a_i_Unit * 7))
End If

If a_s_type	= "Month" then
	l_l_year		= Year(a_d_date)
	l_l_Month	= Month(a_d_date)
	l_l_Day		= Day(a_d_date)
			
	If l_l_Month	= 12 then
		l_l_year	++
		l_l_Month	= 1
	Else
		l_l_Month	++
	End If

	If l_l_Day > f_days_in_month(Date(l_l_year, l_l_Month, 1)) then
		l_l_Day	= f_days_in_month(Date(l_l_year, l_l_Month, 1))
	End If

	Return Date(l_l_year, l_l_Month, l_l_Day)

End If

				

end function

public subroutine wf_create_ship_to (string a_s_ship_type);dw_header.getchild ( 'ship_to_destination', i_dw_shipto )

If a_s_ship_type ='Normal' then	

	dw_header.object.ship_to_destination.dddw.name='d_dddw_ship_to_normal'
	dw_header.object.ship_to_destination.dddw.displaycolumn='code'
	dw_header.object.ship_to_destination.dddw.datacolumn='code'
	dw_header.getchild ( "ship_to_destination", i_dw_shipto )
	i_dw_ShipTo.settransobject ( sqlca )
	i_dw_ShipTo.Retrieve ( )
		
	IF is_plant > '' THEN
		i_dw_shipto.setfilter ( "plant='"+is_plant+"'" )
		i_dw_shipto.filter ()
	ELSE
		i_dw_shipto.reset()
	END IF
	
Else					

	dw_header.modify ( "ship_to_destination.dddw.name = 'd_dddw_ship_to_dropship'" )
	dw_header.modify ( "ship_to_destination.dddw.displaycolumn='destination'" )
	dw_header.modify ( "ship_to_destination.dddw.datacolumn='destination'" )
	dw_header.getchild ( "ship_to_destination", i_dw_shipto )
	i_dw_ShipTo.settransobject ( sqlca )
	i_dw_ShipTo.Retrieve ( )

End If


end subroutine

public subroutine wf_update_detail_plants (string a_s_plant);UPDATE po_detail  
   SET plant = :a_s_Plant  
 WHERE po_number = :il_po 
 and   deleted <> 'Y' 
 and   received <= 0 ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public function string wf_get_terms (string a_s_vendor);String l_s_Term


SELECT	isnull(fob,''),
	isnull(scac_code,''),
	isnull(freight_type,'')
INTO	:is_fob,
	:is_shipvia,
	:is_freighttype
FROM	destination_shipping
WHERE	destination = :a_s_Vendor   ;


SELECT	vendor.terms
INTO	:l_s_Term
FROM	vendor  
WHERE	vendor.code = :a_s_Vendor   ;

Return l_s_Term
end function

public function boolean wf_accum ();
String	ReleaseControl

Select 	release_control
Into		:ReleaseControl
From		po_header
Where		po_number = :il_po;

If ReleaseControl = 'A' then
	Return True
Else
	Return False
End If
end function

public function boolean wf_save_changes ();/* 03-23-2000 KAZ Created to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

Int iRtnCode

iRtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

CHOOSE Case iRtnCode 

	Case 1

		This.TriggerEvent( 'ue_save_header' )
		Return True

	Case 2 

		bitemchanged = False
		close ( this )
		If Isvalid (w_blanket_po_entry ) then close ( w_blanket_po_entry )
  		Return False

	Case 3

		Return False

End Choose

end function

public subroutine wf_get_unit_of_measurement_part (string a_s_part);/* 03-23-2000 KAZ Created to populate unit of measure DDDW in dw_smart_blanket_po_detail_entry.
						Issue # 13193 */

	dw_detail.SetTransObject (sqlca)							// ADD 03-23-2000 KAZ
	dw_detail.GetChild ("unit_of_measure", idw_child)	// ADD 03-23-2000 KAZ
	idw_child.SetTransObject (sqlca)							// ADD 03-23-2000 KAZ
	idw_child.retrieve ( is_part )							// ADD 03-23-2000 KAZ
	

end subroutine

public function boolean wf_closed_po (long a_l_po);/* 04-06-2000 KAZ Created to check if current PO is closed.  Issue # 13305. */

String	l_s_Status

Select	status
Into		:l_s_Status
From		po_header
Where		po_number = :a_l_po ;

If l_s_Status = 'C' Then 
	Return True
ELse
	Return False
End If


end function

public function decimal wf_get_price (decimal orderqty, decimal an_price);
decimal calcPrice
n_surcharge_trans trans
trans = create n_surcharge_trans
if	trans.GetBlanketPrice(is_vendor, is_part, calcPrice) <> SUCCESS then
	trans.RollbackTrans()
	calcPrice = an_price
else
	trans.CommitTrans()
end if
destroy trans

decimal convertedPrice
if	orderQty > 0 then
	convertedPrice = f_convert_units(is_um, "", is_part, orderQty) * calcPrice / orderQty
else
	convertedPrice = f_convert_units(is_um, "", is_part, an_price)
end if

return convertedPrice

end function

on w_blanket_po_entry.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_blanket_po_entry" then this.MenuID = create m_blanket_po_entry
this.em_over_received=create em_over_received
this.st_over_received=create st_over_received
this.dw_detail=create dw_detail
this.dw_header=create dw_header
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_over_received
this.Control[iCurrent+2]=this.st_over_received
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.dw_header
end on

on w_blanket_po_entry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_over_received)
destroy(this.st_over_received)
destroy(this.dw_detail)
destroy(this.dw_header)
end on

event open;call super::open;/* 03-23-2000 KAZ Modified to call window function wf_get_unit_of_measurement_part to populate 
						unit of measure DDDW in dw_smart_blanket_po_detail_entry.  Issue # 13193 */

datawindowchild ldwc

il_PO = Message.DoubleParm 
	
If il_PO > 0  Then
 
   ib_new = false
	dw_header.Retrieve ( il_po )
   is_part = dw_header.Object.blanket_part[1]
	is_vendor = dw_header.Object.vendor_code[1]
  	in_tax_rate = dw_header.Object.tax_rate[1]
   is_plant =  dw_header.object.plant [1]
	
	wf_get_unit_of_measurement_part (is_part)										// ADD 03-23-2000 KAZ
   dw_detail.Retrieve ( il_po, is_part )
	

	// 01/27/04 MB Modified the function to get next seq no from po header table.
	il_next_row_id = f_get_podet_next_seqno ( il_po ) 
	
	IF dw_header.Object.release_control[1] = 'A' THEN
		em_over_received.text =  STRING ( wf_get_over_received ( is_part, is_vendor ) )
	ELSE	
		em_over_received.text = '0' 
	END IF	
	
Else

	ib_new = true
	
	dw_header.getchild ( "ship_to_destination",  ldwc )
	ldwc.settransobject ( sqlca )
	ldwc.retrieve ( 'None' )

	dw_header.InsertRow ( 1 )
	dw_header.setcolumn("vendor_code")	
	
End if
end event

event closequery;call super::closequery;Int iRtnCode

If bitemchanged Then

	If ib_header Then

		iRtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

		CHOOSE Case iRtnCode 

			Case 1
				This.TriggerEvent( 'ue_save_header' )

          	If ib_header = True AND iRtnCode = 1 Then
					  Message.Returnvalue = 1   
          	Else
		 			  This.TriggerEvent( 'ue_save_header' )
          	End If
			Case 2 
   	      close ( this )
			Case 3
				Message.Returnvalue = 1       
		End Choose
	Else
      close ( this )
	End If

Else
	Close ( This )
End If

If ib_detail Then


	iRtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1
			This.TriggerEvent( 'ue_save_detail' )
          If ib_detail = True AND iRtnCode = 1 Then
				  Message.Returnvalue = 1   
          Else
		 		  This.TriggerEvent( 'ue_save_detail' )
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

event resize;call super::resize;dw_header.width	=	newwidth - 60
dw_header.height	=	0.38 * newheight

st_over_received.y = dw_header.height + 20
st_over_received.x = dw_header.width - em_over_received.width - st_over_received.width - 20
em_over_received.y = st_over_received.y
em_over_received.x = dw_header.width - em_over_received.width 

dw_detail.width	=	newwidth - 60
dw_detail.height	=	0.52 * newheight 
dw_detail.y			=	dw_header.height + em_over_received.height + 25

end event

type em_over_received from statictext within w_blanket_po_entry
integer x = 2770
integer y = 736
integer width = 558
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_over_received from statictext within w_blanket_po_entry
integer x = 2341
integer y = 744
integer width = 411
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77633680
boolean enabled = false
string text = "Over Received :"
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_blanket_po_entry
event ue_keypress pbm_dwnkey
integer x = 18
integer y = 816
integer width = 3310
integer height = 864
integer taborder = 20
string dataobject = "dw_smart_blanket_po_detail_entry"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keypress;//int li_current_row,i_current_column
//
//if (dw_detail.getcolumnname()='quantity') then
//
//	if (keydown(keyTab!) OR keydown(keyEnter!)) then 
//	   li_current_row = dw_detail.getrow()
//   	dw_detail.accepttext()
//		st_prmlst.s_arg_part   = dw_detail.getitemstring(li_current_row,'part_number')
//		st_prmlst.s_arg_module = dw_detail.getitemstring(li_current_row,'unit_of_measure')
//		st_prmlst.s_rtn_qtystr = dw_detail.getitemstring(li_current_row,'dimension_qty_string')
//		st_prmlst.s_rtn_qty    = dw_detail.getitemnumber(li_current_row,'quantity') 
//		Openwithparm(w_dda,st_prmlst)
//		st_prmlst = Message.PowerObjectparm
//		dw_detail.setitem(li_current_row,'quantity',st_prmlst.s_rtn_qty)
//		dw_detail.setitem(li_current_row,'dimension_qty_string',st_prmlst.s_rtn_qtystr)
//		Triggerevent('itemchanged')
//	End if 
//
//End if 
end event

event constructor;settransobject(sqlca)
end event

event clicked;long ll_previousrow, &
	  ll_row, &
	  ll_count

il_row = dw_detail.getClickedRow()

IF row > 0 THEN
	IF this.object.deleted[row] = 'Y' THEN
		this.SetTabOrder("date_due", 0)
		this.SetTabOrder("quantity", 0)
		this.SetTabOrder("price", 0)
		this.SetTabOrder("taxable", 0)
		this.SetTabOrder("release_no", 0)
		this.SetTabOrder("po_detail_scheduled_time", 0)
	Else
		this.SetTabOrder("date_due", 10)
		this.SetTabOrder("quantity", 20)
		this.SetTabOrder("price", 30)
		this.SetTabOrder("taxable", 40)
		this.SetTabOrder("release_no", 50)
		this.SetTabOrder("po_detail_scheduled_time", 60)
	END IF
END IF

If KeyDown ( keyShift! ) Then
   
	ll_PreviousRow = dw_Detail.GetRow() 
   SelectRow (this, 0, False) 
   If ll_PreviousRow < Row Then

		For ll_Count = ll_PreviousRow to Row
			SelectRow ( This, ll_Count, True )

		Next
   Else
    	For ll_Count = ll_Row to ll_PreviousRow
			SelectRow ( This, ll_Count, True )
		Next
   End If

Elseif KeyDown ( keyControl! ) Then

	ll_Count = This.GetRow() 
	SelectRow ( dw_Detail, ll_Count, True )

Else
 
   SelectRow ( this, 0, False )
   SelectRow ( this, Row, True )

End if

ll_PreviousRow = ll_Count
end event

event doubleclicked;il_row = dw_detail.GetClickedRow()

//IF row > 0 THEN
//	dw_Detail.selectrow(0, false)
//	dw_Detail.selectrow(il_row, true)
//END IF
end event

event itemchanged;dec	ln_balance, &
	ln_amount, &
	ln_total, &
	ln_value, & 
	ln_price

ib_detail = TRUE
is_vendor = dw_header.Object.vendor_code[1]
ln_price  = object.price [ row ] 
IF dwo.name = 'quantity' THEN
	in_minonorder	= wf_minon_order ( is_part, is_vendor ) 
	ln_value	= Dec ( data )
	IF  ln_value < in_minonorder THEN		
		MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( in_minonorder , 0 ) ) + " .", StopSign!	)
		berrormin = true
		dw_Detail.SetText("")
		Return 2
	ELSEIF ISNULL ( ln_value ) OR ln_value = 0 THEN
		MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
		berrormin = true
		dw_Detail.SetText("")
		Return 2
	ELSE
		ln_balance =  ln_value - dw_detail.object.received [ row ]
		dw_Detail.setitem(row, "balance", ln_balance)
		dw_detail.setitem(row, "price", wf_get_price ( ln_balance, ln_price ) ) 
		berrormin = false
		RETURN 0
	END IF
ELSEIF dwo.name = 'balance' THEN
	in_minonorder	= wf_minon_order ( is_part, is_vendor ) 
	ln_balance = Dec ( data ) 
	ln_value = Dec ( data ) + object.received [ row ]
	IF  ln_value < in_minonorder THEN		
		MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( in_minonorder , 0 ) ) + " .", StopSign!	)
		berrormin = true
		dw_Detail.SetText("")
		Return 2
	ELSEIF ISNULL ( ln_value ) OR ln_value = 0 THEN
		MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
		berrormin = true
		dw_Detail.SetText("")
		Return 2
	ELSE
		setitem(row, "quantity", ln_value)
		dw_detail.setitem(row, "price", wf_get_price ( ln_balance, ln_price ) ) 
		berrormin = false
		RETURN 0
	END IF
END IF

end event

event editchanged;//dec	ln_balance, &
//	ln_amount, &
//	ln_total, &
//	ln_value, & 
//	ln_price
//
//ib_detail = TRUE
//is_vendor = dw_header.Object.vendor_code[1]
//ln_price  = object.price [ row ] 
//IF dwo.name = 'quantity' THEN
//	in_minonorder	= wf_minon_order ( is_part, is_vendor ) 
//	ln_value	= Dec ( data )
//	IF  ln_value < in_minonorder THEN		
//		MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( in_minonorder , 0 ) ) + " .", StopSign!	)
//		berrormin = true
//		dw_Detail.SetText("")
//		Return 2
//	ELSEIF ISNULL ( ln_value ) OR ln_value = 0 THEN
//		MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
//		berrormin = true
//		dw_Detail.SetText("")
//		Return 2
//	ELSE
//		ln_balance =  ln_value - dw_detail.object.received [ row ]
//		dw_Detail.setitem(row, "balance", ln_balance)
//		dw_detail.setitem(row, "price", wf_get_price ( ln_balance, ln_price ) ) 
//		berrormin = false
//		RETURN 0
//	END IF
//ELSEIF dwo.name = 'balance' THEN
//	in_minonorder	= wf_minon_order ( is_part, is_vendor ) 
//	ln_balance = Dec ( data ) 
//	ln_value = Dec ( data ) + object.received [ row ]
//	IF  ln_value < in_minonorder THEN		
//		MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( in_minonorder , 0 ) ) + " .", StopSign!	)
//		berrormin = true
//		dw_Detail.SetText("")
//		Return 2
//	ELSEIF ISNULL ( ln_value ) OR ln_value = 0 THEN
//		MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
//		berrormin = true
//		dw_Detail.SetText("")
//		Return 2
//	ELSE
//		setitem(row, "quantity", ln_value)
//		dw_detail.setitem(row, "price", wf_get_price ( ln_balance, ln_price ) ) 
//		berrormin = false
//		RETURN 0
//	END IF
//END IF
//
end event

type dw_header from datawindow within w_blanket_po_entry
integer x = 18
integer y = 16
integer width = 3310
integer height = 712
integer taborder = 10
string dataobject = "dw_blanket_po_header"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)



end event

event itemchanged;/* 02-10-2000 KAZ Modified to use 'f_get_part_info' function to verify a valid part has been
                  entered and display a message if part is not valid.  Issue # 13182 */

string   ls_part,&
			ls_default_currency_unit[], &
			ls_value
int		li_show_euro_amount[]

ib_header = true
bitemchanged = True

if row < 1 then return

choose case dwo.name
		
	case "blanket_part"
		ls_part  = dw_header.gettext()
		is_Um		= f_get_part_info(ls_Part, "STANDARD UNIT")
	
		If isnull ( f_get_part_info ( ls_Part , "NAME" ) ) then											// ADD 02-10-2000 KAZ
			messagebox ( monsys.msg_title, "Invalid Part Number!", Exclamation! )					// ADD 02-10-2000 KAZ
			return 1																										// ADD 02-10-2000 KAZ
		End If																											// ADD 02-10-2000 KAZ

		if isnull(is_um) or is_um = '' then is_um = 'EA' 
		
		is_Name		= f_get_part_info(ls_Part, "NAME")
		is_GLAccount= f_get_part_info(ls_Part, "GL ACCOUNT")
	
		dw_header.SetItem ( 1, "description", is_name )
 
	case  "tax_rate"
	 
		in_tax_rate = dec(dw_header.gettext())
		
		if isnull(in_tax_Rate) then in_Tax_rate = 0  

	case "vendor_code"
		string vendorStatus
		select
			coalesce (status, 'Approved')
		into
			:vendorStatus
		from
			vendor
		where
			code = :data;
		
		if	isnull(vendorStatus,'') <> 'Approved' then
			Messagebox ( monsys.msg_title, "Sorry can't proceed, as vendor status is not approved")
			ib_header = false
			bitemchanged = false
			return 1
		end if
		
		setitem ( 1, "terms", wf_get_terms ( data ) )
		setitem ( 1, "freight_type", is_freighttype )
		setitem ( 1, "fob", is_fob )
		setitem ( 1, "ship_via", is_shipvia )
		sqlca.of_get_currency_unit ( '', data, '', 0, 0, 0, ls_default_currency_unit[], li_show_euro_amount[] )
		SetItem ( 1, "currency_unit", ls_default_currency_unit[1] )
		SetItem ( 1, "show_euro_amount", li_show_euro_amount[1] )
		
	case "plant"
		is_plant = data
		wf_update_detail_plants ( is_Plant )
		if this.object.ship_type [1] > '' then wf_create_ship_to ( object.ship_type [1] )			
	
	case "ship_type"
		setnull ( ls_value )
		setitem ( 1, "ship_to_destination", ls_value )
		wf_create_ship_to ( data )
		SetNull(is_Plant)
		wf_update_detail_plants ( is_Plant )
			
end choose



end event

event editchanged;ib_header = TRUE
bitemchanged = True
end event


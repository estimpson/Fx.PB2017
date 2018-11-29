$PBExportHeader$w_normal_po_entry.srw
$PBExportComments$main normal po entry screen
forward
global type w_normal_po_entry from w_sheet_4t
end type
type em_over_received from statictext within w_normal_po_entry
end type
type st_over_received from statictext within w_normal_po_entry
end type
type dw_detail from datawindow within w_normal_po_entry
end type
type dw_header from datawindow within w_normal_po_entry
end type
end forward

global type w_normal_po_entry from w_sheet_4t
string title = "Normal PO Entry"
string menuname = "m_normal_po_entry"
event ue_save_header pbm_custom01
event ue_add_release pbm_custom02
event ue_delete_release pbm_custom03
event ue_exit pbm_custom05
event ue_close_po pbm_custom04
event ue_save_detail pbm_custom06
event ue_header_note pbm_custom07
event ue_detail_note pbm_custom08
event close_uo_for_print pbm_custom11
event ue_save_note pbm_custom12
event ue_close_uo_note pbm_custom13
event start_to_print_po pbm_custom14
event ue_print pbm_custom15
event setup_parts_for_print pbm_custom16
event ue_refresh_releases pbm_custom17
event ue_print_update pbm_custom19
event ue_history pbm_custom20
event ue_objects pbm_custom21
event ue_batch_create pbm_custom22
event ue_save_batch ( datawindow a_dw )
event ue_add_nr_item pbm_custom23
event save_non_reoccuring_item ( st_generic_structure ast_parm )
event changevendor ( )
em_over_received em_over_received
st_over_received st_over_received
dw_detail dw_detail
dw_header dw_header
end type
global w_normal_po_entry w_normal_po_entry

type variables
Long     iPO, &
             il_row, &
             il_row_id

String    is_vendor, &
             is_plant, &
	is_freighttype, &
	is_fob, &
	is_shipvia

Boolean 	ib_new, &
	ib_saved = false, &
	ib_detail, &
	bitemchanged = false, &
	ib_header, &
	ib_HeaderNote, &
	ib_DetailNote

st_generic_structure 	stParm

s_normal_po     s_po

u_smart_po_printing_processor    uo_print

u_generic_note                          uo_normal_note

Dec          in_tax_Rate

Datawindowchild   i_dw_ShipTo

end variables

forward prototypes
public function boolean wf_plant_is_required ()
public function boolean wf_delete_marked_releases ()
public function boolean wf_partial_update_release (string a_s_vendor)
public function boolean wf_update_overreceived (string a_s_vendor, string a_s_part)
public subroutine wf_update_release (string a_s_flag)
public function date wf_next_day (date a_d_date, integer a_i_unit, string a_s_type)
public function boolean wf_update_over_received (string a_s_vendor, string a_s_part, decimal a_n_qty)
public function decimal wf_get_over_received (string a_s_vendor, string a_s_part)
public function boolean wf_nonreocurring_item (string a_s_part)
public function boolean wf_delete_profile (string a_s_vendor, string a_s_part)
public subroutine wf_create_ship_to (string a_s_ship_type)
public subroutine wf_update_detail_plants (string a_s_plant)
public function string wf_get_terms (string a_s_vendor)
public subroutine wf_save_po_detail (st_generic_structure ast_parm)
public function boolean wf_save_changes ()
public function boolean wf_closed_po (long a_l_po)
public function decimal wf_moq (string as_part, string as_vendor)
public function decimal wf_get_price (decimal a_n_qty, string as_part, string as_unit)
end prototypes

event ue_save_header;/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iPO' (next PO number).  */

String l_s_shipType
String l_s_plant

IF NOT bitemchanged THEN RETURN

dw_header.setitem(1, "type", "N") 

is_vENDor = dw_header.Object.vENDor_code[1]

IF IsNull(is_vendor) or is_vendor = '' THEN
	MessageBox(monsys.msg_title, "VENDor code is required!", Exclamation! )
	RETURN
END IF

l_s_plant	= dw_header.Object.plant[1]

IF IsNull(l_s_plant) or (l_s_plant = '') THEN
	IF wf_plant_is_required() THEN
		MessageBox(monsys.msg_title, "Plant code is required!", Exclamation! ) 
		RETURN
	END IF
END IF

IF ib_new THEN

	IF IsNull(dw_header.Object.release_control[1]) or (dw_header.Object.release_control[1] = '') THEN
		MessageBox(monsys.msg_title, "Release Control is required!", Exclamation! ) 
		RETURN
	END IF

	IF isnull ( dw_header.object.po_date[1] ) THEN
		MessageBox(monsys.msg_title, "Enter a valid PO date!", Exclamation! ) 
		RETURN
	END IF
	
	l_s_shipType	= dw_header.Object.Ship_type[1]

	IF IsNull(l_s_shipType) or (l_s_shipType = '') THEN
		MessageBox(monsys.msg_title, "Ship Type is required!", Exclamation! ) 
		RETURN
	END IF

   IF l_s_shipType = "DropShip" THEN
		IF IsNull(dw_header.Object.ship_to_destination[1]) OR (dw_header.Object.ship_to_destination[1] = '') THEN
			MessageBox(monsys.msg_title, "Ship To Destination is required!", Exclamation! ) 
			RETURN
		END IF
   END IF
  
//	OpenWithParm(w_get_parm_value, "purchase_order")																	-  CHG 01-26-2000 KAZ
//
//	Do while Not bFinish	//Waiting for the new PO number																-  CHG 01-26-2000 KAZ
//	Loop																																-  CHG 01-26-2000 KAZ
//
//	iPO	= Message.DoubleParm																									-  CHG 01-26-2000 KAZ
//
//	IF iPO < 0 THEN		//Fail to get current value																	-  CHG 01-26-2000 KAZ
//		MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Exclamation! )	-  CHG 01-26-2000 KAZ
//		iPO	= 0																													-  CHG 01-26-2000 KAZ
//		RETURN																														-  CHG 01-26-2000 KAZ

	if not sqlca.of_getnextparmvalue ( "purchase_order", iPO ) then    // Failed to get current value 	-  ADD 01-26-2000 KAZ
		Rollback;																													// ADD 01-26-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Exclamation! )	// ADD 01-26-2000 KAZ
		iPO	= 0																													// ADD 01-26-2000 KAZ
		Return																														// ADD 01-26-2000 KAZ

	Else
		dw_header.SetItem(1, "po_number", iPO)		
		dw_header.SetItem(1, "status", "A")
		IF l_s_shipType = 'Normal' THEN
			If isnull(dw_header.object.ship_to_destination[1],'') = '' then			
				dw_header.SetItem(1, "ship_to_destination", l_s_plant)
			end if	
		END IF
	END IF

Else			

	IF l_s_shipType = 'Normal' THEN
		If isnull(dw_header.object.ship_to_destination[1],'') = '' then		
			l_s_plant	= dw_header.GetItemString(1, "plant")
			dw_header.SetItem(1, "ship_to_destination", l_s_plant)
		end if 	
	END IF

END IF

IF dw_header.Update() > 0 THEN
	Commit;
	in_tax_rate = dw_header.Object.tax_Rate[1]
	is_vENDor 	= dw_header.object.vENDor_code[1]
	is_plant		= dw_header.object.plant[1]
	ib_saved = true
	bitemchanged = false
	ib_new = false
//	Included on 8/7/01 to allow the user to update due date and quantity on the main
//	screen itself instead of going to the 2nd screen. Applicable only to existing line
//	items
	if dw_detail.rowcount() > 0 then
		dw_detail.accepttext()		
		if dw_detail.update() > 0 then
			commit;
		else
			rollback;
		end if 
	end if
	dw_detail.retrieve ( ipo )
Else
	Rollback;
END IF



end event

event ue_add_release;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

s_po.po_no 	= iPO
s_po.new    = 'Y'
setnull(s_po.part )
setnull(s_po.row_id)
s_po.due	 = date ( dw_header.object.po_date [1] )
s_po.scheduled_time = dw_header.object.scheduled_time [1]

OpenwithParm ( w_normal_po_popup, s_po )
end event

event ue_delete_release;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

Integer li_rtn_code

Dec     ln_received

string  l_s_part

long	  ll_row

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
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
		
			ln_Received  = dw_detail.object.received [ ll_row ] 
			l_s_part		 = dw_detail.object.part_number [ ll_row ]
	    	
	      dw_detail.setitem(ll_row, "Deleted", "Y")
		   ln_Received  = dw_detail.Getitemnumber( ll_row, "received" )
				 
			IF ln_received > 0 AND dw_header.object.release_control[1] = 'A' THEN
				em_over_received.text = string ( dec ( em_over_received.text ) + ln_received )
 			END IF
				  
			dw_detail.SetItem(ll_row, "printed", "N")
			dw_detail.SetItem(ll_row, "quantity", 0)
			dw_detail.SetItem(ll_row, "received", 0)
			dw_detail.SetItem(ll_row, "balance",  0)
			dw_detail.SetItem(ll_row, "standard_qty", 0)
			dw_detail.SetItem(ll_row, "price", 0)
   	   
			If wf_nonreocurring_item( l_s_Part ) Then
				
				Messagebox( monsys.msg_title, 'Since this is a non reoccuring item,' + &
					' the system will automatically delete vendor/part profile.', StopSign!)
				
				IF wf_delete_profile( is_Vendor, l_s_Part ) THEN
					dw_detail.deleterow ( ll_row )
					IF dw_Detail.Update() > 0 THEN
						COMMIT ;
						dw_detail.retrieve ( ipo )
						SetMicroHelp ( 'Ready' )
					ELSE
						ROLLBACK ;
					END IF							
				END IF
				
			End If
					
			IF wf_update_over_received ( is_vendor, l_s_part, dec ( em_over_received.text ) ) THEN

				IF dw_Detail.Update() > 0 THEN
				  Commit ;
				  ib_detail = False
			 	  bNoCommit = FALSE
			     SetMicroHelp ( 'Recalculating PO detail for part : ' + l_s_part )
				  f_recalc_po_detail_per_part ( iPO, l_s_part, this )
			 	  SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + l_s_part )
				  f_update_qty_asgnd_part ( l_s_part ) 
			
				  IF dw_header.object.release_control [1] = 'A' THEN	
						
					 If ( dw_detail.object.quantity[1] > dec ( em_over_received.text ) ) Then
						em_over_received.Text	= '0'
					 Else
						em_over_received.Text = string ( truncate ( wf_get_over_received ( l_s_part, is_Vendor ) , 0 ) )  
					 End If
						 
				  END IF

				ELSE
				  Rollback ;
				END IF

			END IF

			SetMicroHelp ( 'Ready' )

		END IF

	  END IF

	NEXT 

END IF

dw_detail.Retrieve ( ipo )
end event

on ue_exit;close (this)
end on

event ue_close_po;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

Long iTotalRows

Int  ideleted
String l_s_SQLErrorText																// ADD 04-04-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ


If iPO > 0 then

	SELECT count(po_detail.po_number ),
			 count(deleted)  
   INTO :iTotalRows,
		  :ideleted  
   FROM po_detail  
   WHERE po_detail.po_number = :iPO   ;

	If iTotalRows > 0  and iTotalRows > ideleted then

		MessageBox(monsys.msg_title, "You can not close a P.O. with active releases. " + &
		"You must wait until the order has been received or you must delete the open releases.", StopSign!)

	Else

		If MessageBox(monsys.msg_title, "Sure to close this Purchase Order?", Question!, YesNo!) = 1 then

		  	UPDATE po_header  
	     	SET status = 'C'  
		  	WHERE po_number = :iPO   ;

			If SQLCA.SQLCode = 0 then
	    		  	UPDATE po_detail 
	   		  	SET status = 'C'  
				  	WHERE po_number = :iPO   ;

            If sqlca.sqlcode = 0 then
					Commit;
      	      Close( w_normal_po_entry )
				Else
					l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/04/2000 KAZ
					Rollback ;
					MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/04/2000 KAZ
				End If				
			End if      
		End If
	End If
End If	
end event

event ue_save_detail;IF dw_Detail.update() > 0 THEN
  commit ;
ELSE
  rollback ;
END IF
end event

event ue_header_note;/* 03-13-2000 KAZ Modified to properly update the appropriate Header or Detail note field. */
/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

string ls_note																							// ADD 03-13-2000 KAZ

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																					// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return														// ADD 03-23-2000 KAZ
End If																									// ADD 03-23-2000 KAZ


Select 	notes 																						// ADD 03-13-2000 KAZ
into		:ls_note																						// ADD 03-13-2000 KAZ
from 		po_header 																					// ADD 03-13-2000 KAZ
where 	po_number = :ipo; 																		// ADD 03-13-2000 KAZ

openuserobjectwithparm (uo_normal_note, 'char', 622,161)									// ADD 03-13-2000 KAZ
uo_normal_note.bringtotop = True																	// ADD 03-13-2000 KAZ
uo_normal_note.borderstyle = StyleRaised!														// ADD 03-13-2000 KAZ
uo_normal_note.mle_note.text = ls_note															// ADD 03-13-2000 KAZ
ib_HeaderNote = True																					// ADD 03-13-2000 KAZ



//string ls_note, &																					-  CHG 03-13-2000 KAZ
//		 ls_syntax, &																					-  CHG 03-13-2000 KAZ
//		 ls_error, &																					-  CHG 03-13-2000 KAZ
//		 ls_datatype																					-  CHG 03-13-2000 KAZ
//
//datastore  lds_ponote																				-  CHG 03-13-2000 KAZ
//
//ib_header = true																					-  CHG 03-13-2000 KAZ
//
//lds_ponote = create datastore 																	-  CHG 03-13-2000 KAZ
//
//ls_syntax  = 'Select notes from po_header where po_number = ' + string ( ipo )	-  CHG 03-13-2000 KAZ
//ls_syntax  = SQLCA.SyntaxFromSQL ( ls_syntax, "style(type=grid)",  ls_error )	-  CHG 03-13-2000 KAZ
//
//If ls_error <= '' or isnull ( ls_error ) then 											-  CHG 03-13-2000 KAZ
//	lds_ponote.create ( ls_syntax, ls_error ) 												-  CHG 03-13-2000 KAZ
//	lds_ponote.settransobject ( sqlca )															-  CHG 03-13-2000 KAZ
//	if lds_ponote.retrieve () > 0 then															-  CHG 03-13-2000 KAZ
//		ls_note = lds_ponote.object.#1 [1] 														-  CHG 03-13-2000 KAZ
//	end if																								-  CHG 03-13-2000 KAZ
//end if																									-  CHG 03-13-2000 KAZ
//
//ls_datatype = lds_ponote.object.#1.coltype													-  CHG 03-13-2000 KAZ
//
//destroy lds_ponote ;																				-  CHG 03-13-2000 KAZ
//
//openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)						-  CHG 03-13-2000 KAZ
//uo_normal_note.bringtotop = True																-  CHG 03-13-2000 KAZ
//uo_normal_note.borderstyle = StyleRaised!													-  CHG 03-13-2000 KAZ
//
//uo_normal_note.mle_note.text = ls_note														-  CHG 03-13-2000 KAZ



end event

event ue_detail_note;/* 03-13-2000 KAZ Modified to properly update the appropriate Header or Detail note field. */
/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

string ls_note, &
		 ls_datatype

long 	 ll_row

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ


ll_row = dw_detail.getselectedrow ( 0 )

If ll_row > 0 then
	
	ls_datatype  = dw_detail.object.notes.coltype
	
	openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!

	ls_note = dw_detail.getitemstring(ll_row, "notes")
   il_Row_id = dw_Detail.getitemnumber(ll_Row, "row_id")
	uo_normal_note.mle_note.text = ls_note
//	ib_detail = True																		-  CHG 03-13-2000 KAZ
	ib_DetailNote = True																	// CHG 03-13-2000 KAZ

else

   MessageBox (monsys.msg_title, "You have to select a release first!", Information! )
   return
  
end if	
end event

event close_uo_for_print;if IsValid(uo_print) then
   closeuserobject(uo_print)
	dw_detail.retrieve ( iPO )
end if
end event

event ue_save_note;string ls_note

ls_note = uo_normal_note.mle_note.text

if ib_HeaderNote then
	
	dw_header.SetItem ( 1, "notes", ls_note )
	
	if dw_header.Update ( ) = 1 then
		commit ;
	else
	   	rollback ;
		messagebox ( monsys.msg_title, "Unable to save the note!" )
	end if

elseif ib_DetailNote then

	If il_row > 0 then
	
		dw_detail.setitem ( il_row, "notes", ls_note )
	
		if dw_detail.update() = 1 then
			commit;
		else
			rollback;
			messagebox ( monsys.msg_title, "Unable to save the note!" )
		end if
	end if

end if

ib_HeaderNote = false
ib_DetailNote = false
closeuserobject(uo_normal_note)
end event

event ue_close_uo_note;/* 03-13-2000 KAZ Modified to properly update the appropriate Header or Detail note field. */

if isvalid(uo_normal_note) then
  closeuserobject(uo_normal_note)
  dw_header.Retrieve(iPO)
end if
ib_HeaderNote = false															// ADD 03-13-2000 KAZ
ib_DetailNote = false															// ADD 03-13-2000 KAZ
end event

event start_to_print_po;n_cst_associative_array	lnv_Parm

If uo_print.ddlb_style.text = 'Release' then
	lnv_Parm.of_SetItem("Report", "PO - Release")
Elseif uo_print.ddlb_style.text = 'Normal PO' then
	lnv_Parm.of_SetItem("Report", "Normal PO")
Elseif uo_print.ddlb_style.text = 'Blanket PO' then
	Return
End If

//IF NOT uo_print.cbx_freeze.checked THEN
//	wf_update_release ( '+' )
//END IF

uo_print.visible	= FALSE

lnv_Parm.of_SetItem("Arg1", iPO)
Print (lnv_Parm)

end event

event ue_print;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

Date dStartDate, dEndDate

string ls_part

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ


setnull(ls_part)

IF dw_detail.RowCount() > 0 THEN
	IF iPO > 0 THEN
		dStartDate	= Date ( dw_detail.Object.date_due[1] )
		dEndDate	= Date ( dw_detail.Object.date_due[dw_detail.RowCount()] )
		OpenUserObject(uo_print, 622, 161)
		uo_print.visible		= TRUE
		uo_print.bringtotop	= TRUE
		uo_print.uf_setup(iPO, ls_part, dStartDate, dEndDate )
		uo_print.taborder = 1
		uo_print.em_date_from.setfocus()		
	ELSE
		MessageBox( monsys.msg_title, "You should select a P.O. first.", StopSign! )
	END IF
ELSE
	MessageBox( monsys.msg_title, "There are no detail items to print.", StopSign! )
END IF
end event

event setup_parts_for_print;Long l_l_Row
Long l_l_TotalRows

String ls_part

l_l_TotalRows	= dw_detail.RowCount()

uo_print.dw_parts.Reset()

FOR l_l_Row = l_l_TotalRows TO 1 STEP -1

	ls_part = dw_detail.Object.part_number[l_l_Row]
	uo_print.dw_parts.InsertRow (1)
	uo_print.dw_parts.SetItem ( 1, 1, ls_part )

NEXT

uo_print.dw_parts.SelectRow ( 0, TRUE )



end event

event ue_refresh_releases;dw_header.retrieve ( ipo )
dw_detail.retrieve ( iPO )
end event

event ue_print_update;/* 01-19-2000 KAZ Modified rollback to release database before message box */

String l_s_SQLErrorText																// ADD 04-04-2000 KAZ

IF NOT uo_print.cbx_freeze.checked THEN
	wf_update_release ( '+' )
END IF

IF wf_delete_marked_releases( ) THEN

		UPDATE po_detail
		SET 	Printed = 'Y'
		WHERE Po_number = :iPO AND
				selected_for_print = 'Y' ;

		IF SQLCA.SQLCODE = 0 THEN
			COMMIT;
			TriggerEvent("ue_refresh_releases")
		ELSE
			l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/04/2000 KAZ
			Rollback ;
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/04/2000 KAZ
	   END IF

ELSE

	l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/04/2000 KAZ
	Rollback ;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/04/2000 KAZ

END IF
end event

event ue_history;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

long 	 l_l_row

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ


l_l_row  = dw_detail.GetSelectedRow (0)

IF l_l_row > 0 THEN

	stParm.value1	= String(iPO)
	stParm.value2	= dw_detail.object.part_number [ l_l_row ]
	
	OpenWithParm ( w_smart_po_receiving_history, stParm )

ELSE

   MessageBox (monsys.msg_title, "You have to select a release first!", Information! )
   return
  
END IF
end event

event ue_objects;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */

long 	 l_l_row

string	l_s_part

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ


l_l_row  = dw_detail.GetselectedRow (0)

IF l_l_row > 0 THEN

	l_s_part = dw_detail.object.part_number [l_l_row]

	OpenWithParm(w_smart_po_objects, l_s_Part)

ELSE

   MessageBox (monsys.msg_title, "You have to select a release first!", Information! )
   return

END IF
end event

event ue_batch_create;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

Openwithparm ( w_batch_release, this )
end event

event ue_save_batch;Integer	l_i_Count, &
	l_i_period
Date	l_d_Date
Long	l_l_count
decimal	l_n_price, &
			l_n_other_charge
string	l_s_account, &
	l_s_unit
String	l_s_SQLErrorText																// ADD 04-04-2000 KAZ
string	ls_part
datawindowchild	ldwc_dddw

IF a_dw.Rowcount() <= 0 THEN RETURN

a_dw.accepttext()
l_d_Date	= a_dw.object.#3[1]  
l_s_account	= f_get_part_info(a_dw.object.#1[1], "GL ACCOUNT")
l_s_unit	= a_dw.object.unit[1] //f_get_part_info(a_dw.object.#1[1], "STANDARD UNIT")
l_n_price    	= a_dw.object.#7[1] 
l_i_period    	= a_dw.object.#4[1]
l_n_other_charge = a_dw.object.#10[1]

DATASTORE  l_dw_detail

l_dw_detail = CREATE DATASTORE
l_dw_detail.dataobject = 'dw_smart_po_detail_entry'
l_dw_detail.settransobject ( sqlca )
l_dw_detail.GetChild ( "unit_of_measure", ldwc_dddw )
ldwc_dddw.InsertRow ( 1 )

// MB 01/27/04 Modifed to get next seq no from po header table
l_l_count = f_get_podet_next_seqno ( ipo )

IF a_dw.object.#4[1] > 0 THEN

	For l_i_Count = 1 to  a_dw.object.#4[1]

		l_dw_detail.InsertRow(1)
		l_dw_detail.SetItem(1, "part_number", a_dw.object.#1[1] )
		l_dw_detail.SetItem(1, "description", a_dw.object.#2[1])
		l_dw_detail.SetItem(1, "po_number", iPO)
		l_dw_detail.SetItem(1, "status", "A")
		l_dw_detail.SetItem(1, "vendor_code", is_vendor )
		l_dw_detail.SetItem(1, "unit_of_measure", l_s_unit)	
		l_dw_detail.SetItem(1, "terms", dw_header.object.terms[1])
		l_dw_detail.SetItem(1, "printed", 'N' )
		l_dw_detail.SetItem(1, "account_code", l_s_account )
		l_dw_detail.SetItem(1, "ship_via", dw_header.object.ship_via[1] )
		l_dw_detail.SetItem(1, "week_no", f_get_week_no(l_d_date) )
		l_dw_detail.SetItem(1, "price", l_n_price )
		l_dw_detail.SetItem(1, "date_due",  l_d_date )
		l_dw_detail.SetItem(1, "quantity", a_dw.object.#6[1])
		l_dw_detail.SetItem(1, "received", 0)
		l_dw_detail.SetItem(1, "balance", a_dw.object.#6[1])
		l_dw_detail.SetItem(1, "release_no", dw_header.object.release_no[1])
		l_dw_detail.SetItem(1, "row_id", l_l_count )
		l_dw_detail.SetItem(1, "taxable", a_dw.object.#8[1])
	   l_dw_detail.SetItem(1, "other_charge", l_n_other_charge )

		l_l_count++
		l_d_Date	= wf_next_day ( l_d_Date, 1, a_dw.object.#5[1] )

	Next

	l_dw_detail.accepttext()

	IF l_dw_detail.Update () > 0 THEN
		
		// MB 01/27/04 update po_header with next seq no 
		Update po_header
		Set  next_seqno = :l_l_count 
		Where po_number = :Ipo ;
			
		IF sqlca.sqlcode <> 0 THEN
			rollback ;
			messagebox ( monsys.msg_title, "Unable to update next sequence number in PO Header table!" )
		END IF
			
		COMMIT ;			
		ls_part = a_dw.object.#1[1]
		SetMicroHelp ( 'Recalculating PO detail for part : ' + ls_part)
		f_recalc_po_detail_per_part ( iPO, ls_part, this )
  		SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + ls_part)
		f_update_qty_asgnd_part ( ls_part ) 
		dw_detail.retrieve ( iPO )
		Setmicrohelp ( 'Ready' )
	ELSE
		l_s_SQLErrorText = SQLCA.SQLErrText																					// ADD 04/04/2000 KAZ
		Rollback ;
		messagebox ( monsys.msg_title, 'Unable to add batch releases. '+ l_s_SQLErrorText, Stopsign! )	// ADD 04/04/2000 KAZ
	END IF

END IF

DESTROY l_dw_detail 


end event

event ue_add_nr_item;/* 03-23-2000 KAZ Modified to prompt the user to save if the Header has been modified
						before continuing processing.  Issue # 13228 */
/* 04-06-2000 KAZ Modified to return if PO has been closed.  Issue # 13305. */

St_generic_structure l_st_parm

If wf_closed_po ( ipo ) Then																									// ADD 04-06-2000 KAZ
	MessageBox ( monsys.msg_title, 'Purchase Order: '+String(ipo)+' Has Been Closed!', exclamation!)	// ADD 04-06-2000 KAZ
	Return																															// ADD 04-06-2000 KAZ
End If																																// ADD 04-06-2000 KAZ

If bitemchanged Then																		// ADD 03-23-2000 KAZ
	If not wf_save_changes() Then Return											// ADD 03-23-2000 KAZ
End If																						// ADD 03-23-2000 KAZ

IF dw_header.RowCount() <= 0 OR ipo < 0 THEN  RETURN

l_st_parm.value1 = string ( iPO )
l_st_parm.value2 = '' 
OpenWithParm ( w_non_recurring_item, l_st_parm )



end event

event save_non_reoccuring_item;/* 01-14-2000 KAZ Modified rollback to release database before message box */

String 	ls_VendorPart 
String	ls_Part
String	ls_PartName
String l_s_SQLErrorText																// ADD 04-04-2000 KAZ

ls_part		= ast_parm.value1
ls_partname	= ast_parm.value2

SetNull(ls_vendorpart)

SELECT part_vendor.part  
  INTO :ls_vendorpart  
  FROM part_vendor  
 WHERE ( part_vendor.part = :ls_part ) AND  
       ( part_vendor.vendor = :is_vendor )   ;

If SQLCA.SQLCode = 0 then
	UPDATE part_vendor  
   SET part_name = :ls_partname  
	WHERE ( part = :ls_part ) AND  
         ( vendor = :is_vendor )   ;

Else
	INSERT INTO part_vendor  
         ( part,   
           vendor,   
           vendor_part,   
           vendor_standard_pack,   
           accum_received,   
           accum_shipped,   
           outside_process,   
           qty_over_received,   
           receiving_um,   
           part_name )  
  VALUES ( :ls_part,   
           :is_vendor,   
           null,   
           null,   
           null,   
           null,   
           null,   
           0,   
           'EA',   
           :ls_partname ); 

End If		

If SQLCA.SQLCode = -1 then
	l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/04/2000 KAZ
	Rollback ;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/04/2000 KAZ
Else
	Commit;
End If

wf_save_po_detail( ast_parm )
dw_Detail.retrieve ( ipo )



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

public function boolean wf_plant_is_required ();String szPlantRequired

SELECT parameters.plant_required  
  INTO :szPlantRequired  
  FROM parameters  ;

Return (szPlantRequired = 'Y')
end function

public function boolean wf_delete_marked_releases ();String l_s_CurrentPart
String l_s_PartList[]
String l_s_part

Integer 	l_i_Count = 0

Decimal  l_n_TotalReceived

Boolean	l_b_OK	 = TRUE	

Declare curPart1 Cursor For
Select Distinct po_detail.part_number  
From  po_detail  
Where po_detail.po_number = :iPO AND
		po_detail.deleted = 'Y' AND
		po_detail.selected_for_print = 'Y'  ;

Open curPart1;
Fetch curPart1 into :l_s_CurrentPart;

Do While SQLCA.SQLCode = 0

	l_i_Count ++
	l_s_PartList[l_i_Count]	= l_s_CurrentPart

	Fetch curPart1 into :l_s_CurrentPart;		

Loop

Close curPart1;

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

			If wf_update_over_received ( is_vendor, l_s_CurrentPart, l_n_TotalReceived ) then
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

public function boolean wf_update_overreceived (string a_s_vendor, string a_s_part);return true
end function

public subroutine wf_update_release (string a_s_flag);Long		l_l_Release

SELECT release_no 
  INTO :l_l_Release  
  FROM po_header  
 WHERE po_number = :iPO;

l_l_Release	 = f_get_value(l_l_Release)

If a_s_flag = '+' then

	l_l_release = l_l_release + 1
	
ELSE
	
	l_l_release = l_l_release - 1 

END IF

UPDATE  po_header  
SET  release_no 	= :l_l_Release  
WHERE  po_number	= :iPO;

IF wf_partial_update_release ( is_vendor ) THEN

		UPDATE po_detail  
	   	SET release_no = :l_l_Release
	 	WHERE po_number 	= :iPO AND selected_for_print = 'Y'  ;

ELSE

		UPDATE po_detail  
	   	SET release_no = :l_l_Release
	 	WHERE po_number 	= :iPO   ;

END IF

IF SQLCA.SQLCode = 0 THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF
end subroutine

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

public function boolean wf_update_over_received (string a_s_vendor, string a_s_part, decimal a_n_qty);UPDATE 	part_vendor  
SET 		qty_over_received = :a_n_qty
WHERE 	( vendor = :a_s_vendor ) AND  
         ( part = :a_s_Part )   ;

Return ( SQLCA.SQLCode = 0 )
end function

public function decimal wf_get_over_received (string a_s_vendor, string a_s_part);Decimal l_n_QtyOverReceived

SELECT part_vendor.qty_over_received  
  INTO :l_n_QtyOverReceived  
  FROM part_vendor  
 WHERE ( part_vendor.part = :a_s_Part ) AND  
       ( part_vendor.vendor = :a_s_Vendor )   ;

RETURN ISNULL( TRUNCATE ( l_n_QtyOverReceived , 0 ), 0 )
end function

public function boolean wf_nonreocurring_item (string a_s_part);string l_s_part

select part
into   :l_s_part
from 	part
where part = :a_s_part ;

IF SQLCA.SQLCODE <> 0 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public function boolean wf_delete_profile (string a_s_vendor, string a_s_part);DELETE FROM part_vendor  
 WHERE ( part_vendor.vendor = :a_s_vendor ) AND  
       ( part_vendor.part = :a_s_part )   ;

if SQLCA.SQLCode = 0 then
	DELETE FROM part_vendor_price_matrix
	WHERE	( part_vendor_price_matrix.vendor = :a_s_vendor ) AND
			( part_vendor_price_matrix.part = :a_s_part );

	if SQLCA.SQLCode = 0 then
		return true ;
	else
 		return false ;
	end if
else
	return false ;
end if
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
 WHERE po_number = :ipo  
 AND	 deleted <> 'Y' 
 AND 	 received <= 0 ;

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

public subroutine wf_save_po_detail (st_generic_structure ast_parm);/* 01-14-2000 KAZ Modified rollback to release database before message box */

String 	ls_ShipTo
String	ls_Term
String	ls_Plant
String	ls_Project
String	ls_GLAccount
String	ls_PartName
STRING  	ls_unit, &
			ls_date, &
			ls_time, &
			ls_part
String taxable
String l_s_SQLErrorText																// ADD 04-04-2000 KAZ

Datetime ld_datetime

Decimal	ln_Qty
Decimal	ln_Price
decimal	ldec_stdqty
decimal  ln_other_charge

Long		ll_RowId
Long		ll_WeekNo
Long		ll_CurrentPO
long		ll_po

ls_part			= ast_parm.value1
ls_PartName		= ast_parm.value2
ls_Plant			= dw_header.GetItemString(1, "plant")
ls_ShipTo		= dw_header.GetItemString(1, "ship_to_destination")
ls_Term			= dw_header.GetItemString(1, "terms")

ls_date			= LeftA ( ast_parm.value3, LenA (ast_parm.value3 ) - 9 ) 
ls_time			= RightA ( ast_parm.value3, 8 )  

ld_datetime	=   Datetime ( Date ( ls_date ) , time ( '00:00:00' ) )

ls_unit			= ast_parm.value8
ls_Project		= ast_parm.value7
ls_GLAccount	= ast_parm.value6

ln_Qty			= Dec(ast_parm.value4)
ldec_stdqty = f_convert_units ( ls_unit, '', ls_part, ln_qty )
ln_Price			= Dec(ast_parm.value5)
ln_other_charge = Dec(ast_parm.value9)

select
	max(row_id) + 1
into
	:ll_RowID
from
	po_detail
where
	po_number = :iPO  ;

if	isNull(ll_RowID) then
	ll_RowID = 0
end if

ll_WeekNo		= f_get_week_no( Date ( ls_Date) )

taxable = ast_parm.value10

select	po_number
into	:ll_po
from	po_detail
where	po_number = :iPO and
		part_number = :ls_part ;
		
if sqlca.sqlcode = 0 then
	
	update	po_detail
	set		part_number = :ls_part,
				description = :ls_partname,
				date_due = :ld_datetime,
				unit_of_measure = :ls_unit,
				account_code = :ls_glaccount,
				requisition_number = :ls_project,
				quantity = :ln_qty,
				balance = :ln_qty - isnull(received,0),
				alternate_price = :ln_price,
				standard_qty = :ldec_stdqty,
				other_charge = :ln_other_charge,
				taxable = :taxable
	where		po_number = :iPO and
				part_number = :ls_part ;
			
else
	
	//DELETE FROM po_detail
	// WHERE ( po_detail.po_number = :iPO ) AND  
	//       ( po_detail.part_number = :ls_part );
	
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
			 invoice_number,   
			 invoice_date,   
			 invoice_qty,   
			 invoice_unit_price,   
			 release_no,   
			 ship_to_destination,   
			 terms,   
			 week_no,   
			 plant,
			 standard_qty,
			 other_charge,
			 taxable)  

	VALUES ( :iPO,   
			 :is_vendor,   
			 :ls_part,   
			 :ls_PartName,   
			 :ls_unit,   
			 :ld_Datetime,   
			 :ls_Project,   
			 'A',   
			 null,   
			 null,   
			 null,   
			 null,   
			 :ls_GLAccount,   
			 null,   
			 :ln_Qty,   
			 0,   
			 :ln_Qty,   
			 0,   
			 0,   
			 :ln_Price,   
			 :ll_RowId,   
			 null,   
			 null,   
			 null,   
			 null,   
			 null,   
			 null,   
			 :ls_ShipTo,   
			 :ls_Term,   
			 :ll_WeekNo,   
			 :ls_Plant,
			 :ldec_stdqty,
			 :ln_other_charge,
			 :taxable);

end if

IF SQLCA.SQLCode = 0 then
	Commit;
Else
	l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 04/04/2000 KAZ
	Rollback ;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 04/04/2000 KAZ
End If

end subroutine

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
		If Isvalid (w_normal_po_entry ) then close ( w_normal_po_entry )
  		Return False

	Case 3

		Return False

End Choose

end function

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

public function decimal wf_moq (string as_part, string as_vendor);Decimal ln_Qty

SELECT part_vendor.min_on_order  
  INTO :ln_Qty  
  FROM part_vendor  
 WHERE ( part_vendor.part = :as_Part ) AND  
       ( part_vendor.vendor = :as_Vendor );

IF ISNULL(ln_Qty) THEN
	RETURN 0
ELSE
	RETURN ln_qty
END IF
end function

public function decimal wf_get_price (decimal a_n_qty, string as_part, string as_unit);Integer l_i_totalrows
Integer l_i_Row
Decimal l_n_Price
Boolean l_b_Found
string	ls_po_currency
l_b_Found		= FALSE
DATASTORE  l_dw_price_matrix
l_dw_price_matrix = CREATE DATASTORE
l_dw_price_matrix.dataobject = 'dw_smart_vendor_part_price_matrix'
l_dw_price_matrix.SetTransobject ( SQLCA )
l_dw_price_matrix.Retrieve ( is_vendor, as_part )
l_i_totalrows	= l_dw_price_matrix.RowCount()
l_i_Row	= l_i_totalrows

Do while (Not l_b_Found) AND (l_i_Row > 0)

	l_b_Found = (a_n_Qty >= l_dw_price_matrix.GetItemNumber(l_i_Row, "break_qty"))

	If Not l_b_Found then
		l_i_Row --
	End If

Loop

If l_i_Row = 0 then
	l_b_Found	= FALSE
End If

ls_po_currency = dw_header.object.currency_unit[1]

If l_b_Found then
	sqlca.of_calculate_multicurrency_price ( l_dw_price_matrix.GetItemString ( l_i_row, 5 ), ls_po_currency, &
		Truncate(l_dw_price_matrix.GetItemNumber(l_i_Row, 6) + 0.0000009, 6), l_n_Price )
Else
	sqlca.of_calculate_multicurrency_price ( '', ls_po_currency, &
		Truncate(Dec(f_get_part_info(as_part, "STANDARD COST")) + 0.0000009, 6), l_n_price )
	If a_n_Qty > 0 then
		l_n_Price	= f_convert_units(as_unit, "", as_part, a_n_Qty) * l_n_Price / a_n_Qty
	Else
		l_n_Price	= f_convert_units(as_unit, "", as_part, 1)
	End If
End If

DESTROY l_dw_price_matrix

Return l_n_Price

end function

event open;call super::open;Int	iCount

Datawindowchild ldwc

iPO = f_get_value ( Message.DoubleParm )

IF iPO > -1 THEN
 
   ib_new = false
	dw_header.Retrieve ( iPO )
   dw_detail.Retrieve ( iPO )
	is_vendor 	= dw_header.object.vendor_code[1]
	in_tax_Rate = dw_header.object.tax_Rate[1]
	is_plant		= dw_header.object.plant[1]
   
ELSE
	
	ib_new = true
	
	dw_header.getchild ( "ship_to_destination",  ldwc )
	ldwc.settransobject ( sqlca )
	ldwc.retrieve ( 'None' )

	dw_header.InsertRow ( 1 )


END IF





end event

on w_normal_po_entry.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_normal_po_entry" then this.MenuID = create m_normal_po_entry
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

on w_normal_po_entry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_over_received)
destroy(this.st_over_received)
destroy(this.dw_detail)
destroy(this.dw_header)
end on

event closequery;call super::closequery;Int iRtnCode

If bitemchanged Then

	iRtnCode = messagebox( monsys.msg_title, 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1

			This.TriggerEvent( 'ue_save_header' )

          If bitemchanged = True AND iRtnCode = 1 Then
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

type em_over_received from statictext within w_normal_po_entry
string tag = "LCA.SyntaxFromSQL ( ls_syntax, ~"style(type=grid)~",  ls_error )"
integer x = 2770
integer y = 644
integer width = 558
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_over_received from statictext within w_normal_po_entry
integer x = 2341
integer y = 656
integer width = 411
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77633680
boolean enabled = false
string text = "Over Received :"
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_normal_po_entry
integer x = 18
integer y = 728
integer width = 3314
integer height = 984
integer taborder = 20
string dataobject = "d_normal_po_detail_display"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;st_generic_structure lst_parm

il_row = row

IF row > 0 THEN

	selectrow(0, false)
	selectrow(row, true)

	IF String( object.deleted[row]) <> 'Y' OR ISNULL(String( object.deleted[row]) ) THEN
		
		if f_get_part_info ( object.part_number[row], "NAME" ) > '' then

			s_po.part  	= object.part_number[row]
			s_po.po_no 	= iPO
			s_po.due	= date ( GetItemdatetime ( row, "date_due" ) )
			s_po.row_id	= GetItemNumber ( row, "row_id" )
			s_po.new	= 'N'
	
			OpenwithParm( w_normal_po_popup, s_po )
		
		else

			lst_parm.value1 = string ( iPO )
			lst_parm.value2 = object.part_number[row]
			lst_parm.value3 = string ( GetItemNumber ( row, "row_id" ) )
			OpenWithParm ( w_non_recurring_item, lst_parm )
		
		end if

	else

		messagebox ( monsys.msg_title, 'Item is already marked for deletion!', Information! )
		selectrow ( row, false )
		return

	end if

end if


end event

event clicked;il_row = row

long ll_previousrow, &
	  ll_count

IF row > 0 THEN
	em_over_received.text = string ( truncate ( wf_get_over_received ( is_vendor, this.object.part_number[row] ) , 0 ) )
	IF String(this.object.deleted[row]) = 'Y' THEN
		SetMicroHelp ( 'Item is marked for deletion! ')
		this.selectrow ( row, false )
	END IF
END IF

If KeyDown ( keyShift! ) Then
   
	ll_PreviousRow = dw_Detail.GetselectedRow(0) 
   SelectRow (this, 0, False) 
   If ll_PreviousRow < Row Then
		For ll_Count = ll_PreviousRow to Row
			SelectRow ( This, ll_Count, True )
		Next
   Else
    	For ll_Count = Row to ll_PreviousRow
			SelectRow ( This, ll_Count, True )
		Next
   End If

Elseif KeyDown ( keyControl! ) Then

	ll_Count = row
	SelectRow ( dw_Detail, ll_Count, True )

Else
 
   SelectRow ( this, 0, False )
   SelectRow ( this, Row, True )

End if

ll_PreviousRow = ll_Count

end event

on constructor;settransobject(sqlca)
end on

event editchanged;//dec	ld_moq, &
//	ld_value, &
//	ld_balance
//	
//if row > 0 then
//	ld_moq	= wf_moq ( object.part_number[row], is_vendor ) 	
//	if dwo.name = 'quantity' then
//		ld_value = Dec ( data )			
//		IF  ld_value < ld_moq THEN		
//			MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( ld_moq , 0 ) ) + " .", StopSign!	)
//			SetText("")
//			Return 2
//		ELSEIF ISNULL ( ld_value ) OR ld_value = 0 THEN
//			MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
//			SetText("")
//			Return 2
//		ELSE
//			ld_balance =  ld_value - object.received [ row ]
//			setitem(row, "balance", ld_balance)
//		//	setitem(row, "price", wf_get_price ( ln_balance ) ) //Truncate(Dec(f_get_part_info(ls_vendor, "STANDARD COST")) + 0.0000009, 6) )
//			bitemchanged = true		
//			RETURN 0
//		END IF
//	elseif dwo.name = 'balance' then
//		ld_value = Dec ( data )	- object.received [ row ]
//		IF  ld_value < ld_moq THEN		
//			MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( ld_moq , 0 ) ) + " .", StopSign!	)
//			SetText("")
//			Return 2
//		ELSEIF ISNULL ( ld_value ) OR ld_value = 0 THEN
//			MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
//			SetText("")
//			Return 2
//		ELSE
//			setitem ( row, 'quantity', ld_value )
//			bitemchanged = true		
//			RETURN 0
//		END IF
//	end if 	
//end if 	
//
end event

event itemchanged;dec	ld_moq, &
	ld_value, &
	ld_balance
string	ls_part
string	ls_unit

if row > 0 then
	ls_unit = object.unit_of_measure[row]
	ls_part = object.part_number[row]			
	ld_moq	= wf_moq ( object.part_number[row], is_vendor ) 	
	if dwo.name = 'quantity' then
		ld_value = Dec ( data )			
		IF  ld_value < ld_moq THEN		
			MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( ld_moq , 0 ) ) + " .", StopSign!	)
			SetText("")
			Return 2
		ELSEIF ISNULL ( ld_value ) OR ld_value = 0 THEN
			MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
			SetText("")
			Return 2
		ELSE
			ld_balance = ld_value - object.received [ row ]
			setitem(row, "balance", ld_balance)
			setitem(row, "price", wf_get_price ( ld_value, ls_part, ls_unit ))
			bitemchanged = true		
			RETURN 0
		END IF
	elseif dwo.name = 'balance' then
		ld_value = Dec ( data )	+ object.received [ row ]
		IF  ld_value < ld_moq THEN		
			MessageBox(monsys.msg_title, "You cannot order less than ~rMinimum On Order Quantity : " + string ( truncate ( ld_moq , 0 ) ) + " .", StopSign!	)
			SetText("")
			Return 2
		ELSEIF ISNULL ( ld_value ) OR ld_value = 0 THEN
			MessageBox(monsys.msg_title, "You must enter order Quantity!", StopSign!	)
			SetText("")
			Return 2
		ELSE
			setitem ( row, 'quantity', ld_value )
			setitem(row, "price", wf_get_price ( ld_value, ls_part, ls_unit ))			
			bitemchanged = true		
			RETURN 0
		END IF
	end if 	
end if 	

end event

type dw_header from datawindow within w_normal_po_entry
integer x = 18
integer y = 12
integer width = 3314
integer height = 616
integer taborder = 10
string dataobject = "dw_normal_po_header"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on editchanged;bitemchanged = true
end on

event constructor;settransobject(sqlca)
end event

event itemchanged;bitemchanged = true

string  ls_value

string   ls_default_currency_unit[]
int		li_show_euro_amount[]

choose case dwo.name
		
	case "tax_rate" 
	 
		in_tax_rate = dec ( data )	
		if isnull(in_tax_Rate) then in_Tax_rate = 0  
	
	case "plant"
		is_plant = data
		wf_update_detail_plants ( is_Plant )
		
		if object.ship_type [1] > '' then wf_create_ship_to ( object.ship_type [1] )			
		
	case "ship_type"
		setnull ( ls_value )
		setitem ( 1, "ship_to_destination", ls_value )
		wf_create_ship_to ( data )
		SetNull(is_Plant)
		wf_update_detail_plants(is_Plant)
		
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
		
		setitem ( 1, "terms", wf_get_terms (data) )
		setitem ( 1, "freight_type", is_freighttype )
		setitem ( 1, "fob", is_fob )
		setitem ( 1, "ship_via", is_shipvia )
		sqlca.of_get_currency_unit ( '', data, '', 0, 0, 0, ls_default_currency_unit[], li_show_euro_amount[] )
		SetItem ( 1, "currency_unit", ls_default_currency_unit[1] )
		SetItem ( 1, "show_euro_amount", li_show_euro_amount[1] )
end choose
end event


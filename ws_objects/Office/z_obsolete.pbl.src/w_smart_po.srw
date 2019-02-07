$PBExportHeader$w_smart_po.srw
forward
global type w_smart_po from w_sheet_4t
end type
type ddlb_type from dropdownlistbox within w_smart_po
end type
type dw_value from datawindow within w_smart_po
end type
type st_10 from statictext within w_smart_po
end type
type p_3 from picture within w_smart_po
end type
type st_mode from statictext within w_smart_po
end type
type dw_vendors from datawindow within w_smart_po
end type
type dw_update_future_note from datawindow within w_smart_po
end type
type dw_vendor_parts from datawindow within w_smart_po
end type
type dw_po_detail_2 from datawindow within w_smart_po
end type
type dw_po_exists2 from datawindow within w_smart_po
end type
type dw_price_matrix from datawindow within w_smart_po
end type
type dw_part_vendors from datawindow within w_smart_po
end type
type dw_po_row_id from datawindow within w_smart_po
end type
type dw_po_per_vendor from datawindow within w_smart_po
end type
type st_new_po from statictext within w_smart_po
end type
type p_delete from picture within w_smart_po
end type
type p_receive from picture within w_smart_po
end type
type lb_price_search from listbox within w_smart_po
end type
type gb_3 from groupbox within w_smart_po
end type
type gb_1 from groupbox within w_smart_po
end type
type dw_po_detail from datawindow within w_smart_po
end type
type dw_active_po_per_vendor from datawindow within w_smart_po
end type
type mle_message from multilineedit within w_smart_po
end type
type uo_print from u_smart_po_printing_processor within w_smart_po
end type
type cb_note from commandbutton within w_smart_po
end type
type dw_po_header from datawindow within w_smart_po
end type
type gb_2 from groupbox within w_smart_po
end type
type dw_crosstab from datawindow within w_smart_po
end type
end forward

global type w_smart_po from w_sheet_4t
string title = "Purchase Order Processor"
string menuname = "m_smart_po"
event new_po pbm_custom01
event print_po pbm_custom02
event save_po pbm_custom03
event close_po pbm_custom04
event exit_po pbm_custom05
event save_non_reoccuring_item ( st_generic_structure a_st_structure )
event setup_parts_for_print pbm_custom09
event close_uo_for_print pbm_custom10
event start_to_print_po pbm_custom11
event set_release pbm_custom12
event ue_freeze_release_update pbm_custom13
event ue_refresh_releases pbm_custom14
event ue_delete_profile pbm_custom15
event ue_print_update pbm_custom16
event ue_add_non_reoccurring pbm_custom17
event ue_header_note pbm_custom18
event ue_save_note pbm_custom19
event ue_close_uo_note pbm_custom20
event ue_detail_note pbm_custom21
event ue_viewdate pbm_custom22
event ue_mode ( string as_mode )
event ue_displayactiveparts ( string as_value )
event dw_vendors_doubleclicked ( )
ddlb_type ddlb_type
dw_value dw_value
st_10 st_10
p_3 p_3
st_mode st_mode
dw_vendors dw_vendors
dw_update_future_note dw_update_future_note
dw_vendor_parts dw_vendor_parts
dw_po_detail_2 dw_po_detail_2
dw_po_exists2 dw_po_exists2
dw_price_matrix dw_price_matrix
dw_part_vendors dw_part_vendors
dw_po_row_id dw_po_row_id
dw_po_per_vendor dw_po_per_vendor
st_new_po st_new_po
p_delete p_delete
p_receive p_receive
lb_price_search lb_price_search
gb_3 gb_3
gb_1 gb_1
dw_po_detail dw_po_detail
dw_active_po_per_vendor dw_active_po_per_vendor
mle_message mle_message
uo_print uo_print
cb_note cb_note
dw_po_header dw_po_header
gb_2 gb_2
dw_crosstab dw_crosstab
end type
global w_smart_po w_smart_po

type variables
Long iPO          = 0         	//Current PO number
Long iCrosstabRow      	//Crosstab row
Long iCrosstabCol        	//Crosstab col

Integer iBeepCounter = 1

String szVendor           	//Current Vendor Code
String szPart               	//Current Part Number
String szNote              	//Current note
String szPartNote         	//Part note
String szPlant              	//Plant code
String szUM		//Unit of Measurement	
String i_s_type                        // type of po

Date dDate1, & 
         ddate2, &
         ddate3, &
         ddate4, &
         ddate5, &
         ddate6, &
         ddate7

Date dDatelist[]
Date dDate
Date dStartDate, dEndDate

Boolean bCrosstab       	//Dragging cross tab
Boolean bNewPo         	//Whether this is a new PO
Boolean bPastDue       	//Whether clicked on past due col
Boolean bPOHeader     	//Whether drag PO header
Boolean bHaveNote     	//Whether have note
Boolean bHavePartNote 	//Whether have part note
Boolean bPartNote       	//Whether have part note
Boolean bFootNote       	//Whether have foot note
Boolean bFirstTime = TRUE 	//First time entered the program
Boolean bPartMode       	//Part mode
Boolean bVendorMode =  TRUE //Vendor mode
Boolean bDropShip		//Whether this is drop shipment
Boolean bPrintMode = FALSE	//Whether this is in print mode now	
Boolean bFreezeRel = FALSE //Whether to freeze the release update
boolean i_b_future_note

Decimal nQty               	//Current qty in crosstab cell

st_generic_structure stParm

u_generic_note uo_normal_note

SingleLineEdit sle_release[]

DataWindowChild dwShipTo, dwPlant

end variables

forward prototypes
public subroutine wf_build_crosstab ()
public subroutine wf_create_ship_to ()
public function boolean wf_plant_is_required ()
public subroutine wf_build_crosstab_in_part_mode ()
public subroutine wf_highlight_po_row ()
public subroutine wf_recalc_parts ()
public function boolean wf_objects_in_release ()
public function boolean wf_check_for_releases (string as_type, long al_po, string as_part, date ad_date)
public subroutine wf_reset_fly_wheel ()
public function boolean wf_partial_update_release (string as_vendor)
public function boolean wf_delete_marked_releases ()
public function boolean wf_update_overreceived (string a_s_vendor, string a_s_part, decimal a_n_qty)
public subroutine wf_search_first_and_last_day (long a_l_po)
public subroutine wf_update_detail_plants (string a_s_plant)
public function string wf_get_part_name (string as_part)
public function boolean wf_have_releases_in_po (long a_l_po)
public subroutine wf_show_price_matrix (string as_vendor, string as_part, integer ai_posx, integer ai_posy)
public function boolean wf_have_releases (string a_s_value, date a_d_date)
public function string wf_get_term (string a_s_vendor)
public subroutine wf_save_po_detail (st_generic_structure a_st_parm)
public subroutine wf_update_release (string a_s_flag)
public subroutine wf_build_values (string as_value)
public subroutine wf_retrieve_vendor_parts ()
end prototypes

event new_po;string	ls_units[]
int		li_show_euro[]

If IsNull(szVendor)  OR szVendor = '' then
	MessageBox(monsys.msg_title, "Please specify vendor first.", StopSign!)
	Return 
End If

dw_crosstab.Reset()
dw_crosstab.enabled	= FALSE

dw_po_header.Reset()
dw_po_header.InsertRow(1)
dw_po_header.SetItem(1, "vendor_code", szVendor)
dw_po_header.SetItem(1, "po_date", Today())
dw_po_header.SetItem(1, "terms", wf_get_term(szVendor))

sqlca.of_get_currency_unit ( '', szVendor, '', 0, 0, 0, ls_units[], li_show_euro[])

if UpperBound ( ls_units ) > 0 then &
	dw_po_header.SetItem ( 1, "currency_unit", ls_units[1] )

if UpperBound ( li_show_euro ) > 0 then &
	dw_po_header.SetItem ( 1, "show_euro_amount", li_show_euro[1] )

st_new_po.visible	= TRUE
bNewPo				= TRUE
SetNull ( iPO )
end event

event print_po;String l_s_Part

SetNull ( l_s_Part )

If iPO > 0 then
	
	wf_search_first_and_last_day(iPO)
	
	If IsNull(dStartDate) then
		MessageBox(monsys.msg_title, "There are no releases to print.", StopSign!)
	Else
		OpenUserObject(uo_print, 842, 193)
		uo_print.visible		= TRUE
		uo_print.bringtotop	= TRUE
		uo_print.uf_setup(iPO, l_s_Part, dStartDate, dEndDate )
		uo_print.taborder = 1
		uo_print.em_date_from.setfocus()		
	End If
	
Else
	
	MessageBox(monsys.msg_title, "You should select a P.O. first.", StopSign!)
	
End If
end event

event save_po;/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iPO' (next PO number).  */

String szShipType
String l_s_Plant
String ls_ShipDest
String sz_release_control

If dw_po_header.RowCount() = 0 then
	MessageBox(monsys.msg_title, "Please click NEW button first.", StopSign!)
	Return
End If

If IsNull(szVendor) OR szVendor = '' then
	MessageBox(monsys.msg_title, "Please click the vendor first.", StopSign!)
	Return
End If

gf_get_info ( 'w_smart_po', 0 )

//dw_po_header.SetRow(1)
//dw_po_header.SetColumn("plant")
//
l_s_Plant	= dw_po_header.object.plant[1]

If IsNull(l_s_plant) or (l_s_plant = '') then
	If wf_plant_is_required() then
		MessageBox(monsys.msg_title, "Plant code is required!", StopSign!) 
		Return
	End If
End If

If bNewPO then

//	dw_po_header.SetRow(1)
//	dw_po_header.SetColumn("ship_type")

	szShipType	= dw_po_header.object.ship_type[1]

	If IsNull(szShipType) or (szShipType = '') then
		MessageBox(monsys.msg_title, "Ship Type is required!", StopSign!) 
		Return
	End If

//	dw_po_header.SetRow(1)
//	dw_po_header.SetColumn("release_control")

	sz_release_control = dw_po_header.object.release_control[1]

	If IsNull(sz_release_control) or (sz_release_control = '') then
		MessageBox(monsys.msg_title, "Release Control is required!", StopSign!) 
		Return
	End If

//	dw_po_header.SetRow(1)
//	dw_po_header.SetColumn("ship_to_destination")

	ls_ShipDest	= dw_po_header.object.ship_to_destination[1]

	If szShipType = "DropShip" Then
		If IsNull(ls_ShipDest) OR (ls_ShipDest = '') Then
			MessageBox(monsys.msg_title, "Ship To Destination is required!", StopSign!) 
			Return
		End If
	End If

//	bFinish	= FALSE																												-  CHG 01-26-2000 KAZ
//	OpenWithParm(w_get_parm_value, "purchase_order")																	-  CHG 01-26-2000 KAZ
//
//	Do while Not bFinish	//Waiting for the new PO number																-  CHG 01-26-2000 KAZ
//	Loop																																-  CHG 01-26-2000 KAZ
//
//	iPO	= Message.DoubleParm																									-  CHG 01-26-2000 KAZ
//
//	If iPO < 0 then		//Fail to get current value																	-  CHG 01-26-2000 KAZ
//		MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Information!)	-  CHG 01-26-2000 KAZ
//		iPO	= 0																													-  CHG 01-26-2000 KAZ
//		Return																														-  CHG 01-26-2000 KAZ

	if not sqlca.of_getnextparmvalue ( "purchase_order", iPO ) then    // Failed to get current value 	-  ADD 01-26-2000 KAZ
		Rollback;																													// ADD 01-26-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new PO number, Please try again", Exclamation! )	// ADD 01-26-2000 KAZ
		iPO	= 0																													// ADD 01-26-2000 KAZ
		Return																														// ADD 01-26-2000 KAZ

	Else
		dw_po_header.SetItem(1, "po_number", iPO)		
		dw_po_header.SetItem(1, "status", "A")
		If szShipType = 'Normal' then
			If isnull(dw_po_header.object.ship_to_destination[1],'') = '' then			
				dw_po_header.SetItem(1, "ship_to_destination", l_s_Plant)
			end if 	
		End If
	End If

Else			//If this is an existing P.O.
	If szShipType = 'Normal' Then
		If isnull(dw_po_header.object.ship_to_destination[1],'') = '' then		
			l_s_Plant	= dw_po_header.GetItemString(1, "plant")
			dw_po_header.SetItem(1, "ship_to_destination", l_s_Plant)
		end if 	
	End If
End If


If dw_po_header.Update() > 0 then
	Commit;
	bNewPO	= FALSE
	l_s_Plant	= dw_po_header.object.plant[1]

	If bVendorMode then
		wf_build_crosstab()
	Else
		wf_build_crosstab_in_part_mode()
	End If
	dw_crosstab.enabled	= true
Else
	Rollback;
End If

bPOHeader	= FALSE

dw_active_po_per_vendor.visible	= FALSE
st_new_po.visible	= FALSE
							
end event

event close_po;Long ll_TotalRows

Int  li_deleted

String ls_mode

If iPO > 0 then

	SELECT count(po_detail.po_number ),
			 count(deleted)  
   INTO :ll_TotalRows,
		  :li_deleted  
   FROM po_detail  
   WHERE po_detail.po_number = :iPO   ;

	If ll_TotalRows > 0  and ll_TotalRows > li_deleted then

		MessageBox(monsys.msg_title, "You cannot close a P.O. with active releases. " + &
		"You must wait until the order has been received or you must delete the open releases.", Information!)

	Else

		If MessageBox(monsys.msg_title, "Sure to close this po?", Question!, YesNo!) = 1 then

		  	UPDATE po_header  
	     	SET status = 'C'  
		  	WHERE po_number = :iPO   ;

			If SQLCA.SQLCode = 0 then
				Commit;
				wf_reset_fly_wheel ()	
				dw_crosstab.Reset ()
				dw_po_header.Reset ()
			Else
				Rollback;
				MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
			End If				

		End If

	End If

End If	
end event

event exit_po;Close ( w_smart_po )
end event

event save_non_reoccuring_item;/* 01-14-2000 KAZ Modified rollback to release database before message box */

String 	szVendorPart
String	l_s_Part
String	szPartName
String 	l_s_SQLErrorText																// ADD 01-14-2000 KAZ

l_s_Part		= a_st_structure.value1
szPartName	= a_st_structure.value2

If f_valid_part_number(l_s_part) AND f_get_part_info(l_s_Part, "CLASS") <> "N" then
	MessageBox(monsys.msg_title, "This area is to add non-recurring items only. You cannot add an existing part already in the part master! To add an existing part, you must go to the vendor profile.", StopSign!)
	Return
End If

SetNull(szVendorPart)

SELECT part_vendor.part  
  INTO :szVendorPart  
  FROM part_vendor  
 WHERE ( part_vendor.part = :l_s_Part ) AND  
       ( part_vendor.vendor = :szVendor )   ;

If SQLCA.SQLCode = 0 then
	UPDATE part_vendor  
   SET part_name = :szPartName  
	WHERE ( part = :l_s_Part ) AND  
         ( vendor = :szVendor )   ;

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
  VALUES ( :l_s_Part,   
           :szVendor,   
           null,   
           null,   
           null,   
           null,   
           null,   
           0,   
           'EA',   
           :szPartName ); 

End If		


If SQLCA.SQLCode = -1 then
	l_s_SQLErrorText = sqlca.sqlerrtext																	// ADD 01-14-2000 KAZ
	Rollback;
	MessageBox(monsys.msg_title, l_s_SQLErrorText, Stopsign!)
//	Rollback; - 01-14-2000 KAZ
Else
	Commit;
End If

wf_save_po_detail( a_st_structure )
dw_vendor_parts.Retrieve(szVendor)
dw_vendor_parts.SetSort("1a")
dw_vendor_parts.Sort()
wf_build_crosstab()


end event

event setup_parts_for_print;Long iRow
Long iTotalRows

String szCondition

//If cbx_active.checked then
//	szCondition	= "(qty_past_due > 0) or (qty_date1 > 0) or (qty_date2 > 0) or (qty_date3 > 0) or (qty_date4 > 0) or (qty_date5 >0) or (qty_date6 > 0) or (qty_date7 > 0)"
//
//	dw_crosstab.SetFilter(szCondition)
//	dw_crosstab.Filter()
//
//	dw_crosstab.SetSort("part a")
//	dw_crosstab.Sort()
//End If

iTotalRows	= dw_crosstab.RowCount()

uo_print.dw_parts.Reset()
For iRow = iTotalRows to 1 Step -1
	uo_print.dw_parts.InsertRow(1)
	uo_print.dw_parts.SetItem(1, 1, dw_crosstab.GetItemString(iRow, "part"))
Next

uo_print.dw_parts.SelectRow(0, TRUE)

//If Not cbx_active.checked then
//	szCondition	= "part > ' '"
//
//	dw_crosstab.SetFilter(szCondition)
//	dw_crosstab.Filter()
//
//	dw_crosstab.SetSort("part a")
//	dw_crosstab.Sort()
//End If

end event

event close_uo_for_print;If IsValid ( uo_print ) then CloseUserObject(uo_print)

end event

event start_to_print_po;n_cst_associative_array	lnv_Parm

If uo_print.ddlb_style.text = 'Release' then
	lnv_Parm.of_SetItem("Report", "PO - Release")
Elseif uo_print.ddlb_style.text = 'Normal PO' then
	lnv_Parm.of_SetItem("Report", "Normal PO")
Elseif uo_print.ddlb_style.text = 'Blanket PO' then
	lnv_Parm.of_SetItem("Report", "Blanket PO")
End If

//IF NOT uo_print.cbx_freeze.checked THEN wf_update_release ( '+' )

uo_print.visible	= FALSE

bFinish		= FALSE
bPrintMode	= TRUE
Timer(0.5)

lnv_Parm.of_SetItem("Arg1", iPO)

Print (lnv_Parm)

end event

event set_release;
String 	l_s_SQLErrorText																// ADD 04-06-2000 KAZ

Long	iRelease

If Not uo_print.cbx_freeze.checked then

	iRelease	= f_get_value(dw_po_header.GetItemNumber(1, "release_no")) + 1
	dw_po_header.SetItem(1, "release_no", iRelease)

	If dw_po_header.Update() > 0 then
		UPDATE 	po_detail  
		SET 		release_no = :iRelease  
	   WHERE 	po_number = :iPO ;

		If SQLCA.SQLCode = 0 then
			Commit;
		Else
			l_s_SQLErrorText = sqlca.sqlerrtext																	// ADD 04-06-2000 KAZ
			Rollback;
			MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)
//			Rollback;																									-  CHG 04-06-2000 KAZ
		End If
	End If
End If
end event

on ue_freeze_release_update;uo_print.cbx_freeze.checked	= TRUE
end on

on ue_refresh_releases;dw_po_header.Retrieve(iPO)

end on

on ue_delete_profile;/*
Description	:	To delete the part/vendor profile relation
Author		:	Jim Wu
Start Date	:	02/24/96
Modification:
*/

/* Declaration */


/* Initialization */


/* Main Process */

if bVendorMode then
	dw_vendor_parts.retrieve( szVendor )
else
	dw_part_vendors.retrieve( szPart)
end if

	 
end on

event ue_print_update;if not uo_print.cbx_freeze.checked then wf_update_release ( '+' )

if wf_delete_marked_releases( ) then

		update po_detail
		set 	Printed = 'Y'
		where Po_number = :iPO AND
				selected_for_print = 'Y' ;

		if SQLCA.SQLCODE = 0 then
			commit;
			TriggerEvent("ue_refresh_releases")
		else
			MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
			rollback ;
	   end if

else

	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
	rollback ;

end if

end event

event ue_add_non_reoccurring;St_generic_structure l_st_parm

IF iPO = 0 OR dw_po_header.RowCount() <= 0 THEN 
	Messagebox ( monsys.msg_title, "You must select a PO first!", StopSign! )
	RETURN
END IF

If bVendorMode then

	IF i_s_type = 'B' THEN
		MessageBox(monsys.msg_title, "You cannot add Non Reocurring parts to a blanket PO!", StopSign!)		
		RETURN
	END IF
	
	l_st_parm.value1 = string ( iPO )
	l_st_parm.value2 = '' //szPart
   OpenWithParm ( w_non_recurring_item, l_st_parm )

End If


end event

event ue_header_note;string ls_note, &
		 ls_syntax, &
		 ls_error, &
		 ls_datatype

datastore  lds_ponote

if not bnewpo and ipo > 0 then

	bfootnote = true
	
	lds_ponote = create datastore 
	
	ls_syntax  = 'Select notes from po_header where po_number = ' + string ( ipo )
	ls_syntax  = SQLCA.SyntaxFromSQL ( ls_syntax, "style(type=grid)",  ls_error )
	
	If ls_error <= '' or isnull ( ls_error ) then 
		lds_ponote.create ( ls_syntax, ls_error ) 
		lds_ponote.settransobject ( sqlca )
		if lds_ponote.retrieve () > 0 then
			ls_note = lds_ponote.object.#1 [1] 
		end if
	end if
	
	ls_datatype = lds_ponote.object.#1.coltype
	
	destroy lds_ponote ;
	
	openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!
	
	uo_normal_note.mle_note.text = ls_note

end if

end event

event ue_save_note;String  ls_note
Datetime dt_ddate

ls_note = uo_normal_note.mle_note.Text

if i_b_future_note then
	
	i_b_future_note = FALSE
	
	dw_update_future_note.SetItem ( 1, "notes", ls_note )

	if dw_update_future_note.Update ( ) = -1 then
		rollback;
	else
		commit;
	end if
	
else
	
	dt_ddate = datetime ( ddate, time ( '00:00:00' ) )

	If bFootNote then

	  UPDATE po_header  
	     SET notes = :ls_note  
	   WHERE po_number = :iPO   ;
	
	End If
	
	If bPartNote then
	
	  UPDATE po_detail  
	     SET notes = :ls_note  
	   WHERE ( po_number = :iPO ) AND  
	         ( part_number = :szPart ) AND  
	         ( date_due = :dt_dDate )  ;
		
	End If

	If SQLCA.SQLCode	= 0 then
		
		Commit;
		
		If bFootNote then
			dw_po_header.retrieve ( ipo )
			bFootNote = False
		Elseif bPartNote then
			bPartNote = false			
		End If
		
	Else
		Rollback;
	End If
	
end if

closeuserobject ( uo_normal_note )
end event

event ue_close_uo_note;if isvalid ( uo_normal_note ) then
  closeuserobject(uo_normal_note)
  dw_po_header.Retrieve(iPO)
end if
end event

event ue_detail_note;Long		l_l_row

String   ls_note, &
			ls_Datatype, &
			ls_syntax, &
			ls_error
		
Datastore lds_ponote

If bPastDue then
	
	MessageBox(monsys.msg_title, "You can not edit/create part note for past due releases", StopSign!)
	Return
	
End If

If nQty > 0 then

	bPartNote		= TRUE
	
	lds_ponote = create datastore 

	lds_ponote.dataobject = 'dw_check_po_exists' 
	lds_ponote.settransobject ( sqlca )
	ls_datatype = lds_ponote.object.notes.coltype
	
	if lds_ponote.Retrieve ( iPO, dDate, szPart  ) > 0 then
		ls_note = lds_ponote.object.notes [1] 
	end if
	
	destroy lds_ponote ;
	
	openuserobjectwithparm ( uo_normal_note, ls_datatype, 622,161 )
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!
	uo_normal_note.mle_note.text = ls_note

Else

	l_l_row = dw_crosstab.GetRow ( )

	if l_l_row < 1 then
		MessageBox ( monsys.msg_title, "There is no quantity required, you cannot create part note!", Information! )
	else
		if dw_crosstab.GetItemNumber ( l_l_row, "flag" ) > 0 then
			if dw_update_future_note.Retrieve ( iPo, szPart, dDate7 ) > 0 then
				i_b_future_note = TRUE
				bPartNote		= TRUE
				ls_note 			= dw_update_future_note.object.notes[1]
				ls_Datatype		= dw_update_future_note.object.notes.coltype
				openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)

				uo_normal_note.bringtotop = True
				uo_normal_note.borderstyle = StyleRaised!
				uo_normal_note.mle_note.text = ls_note
			end if
		end if
	end if
End If

end event

event ue_viewdate;String szDate

bFinish	= FALSE

Timer(0.5)

OpenWithParm(w_view_calendar, String(dDate1))
end event

event ue_mode;ddlb_type.reset()
dw_value.visible	= FALSE
dw_vendors.Reset()
dw_crosstab.Reset()
dw_po_header.Reset()

mle_message.visible	= FALSE

SetNull(szPart)		//Reset part number
SetNull(szVendor)		//Reset vendor code

If as_mode = 'vendor' then
	dw_crosstab.object.part_h.text = 'Part'
	lb_price_search.visible		= FALSE
	bVendorMode = TRUE
	bPartMode	= FALSE
	ddlb_type.AddItem("All")
	ddlb_type.AddItem("Vendor")
	ddlb_type.AddItem("DropShip")
	ddlb_type.AddItem("Buyer")
	ddlb_type.AddItem("Plant")
	st_mode.text = "Vendors"
	m_smart_po.m_file.m_nonreoccuring.enabled = true
	m_smart_po.m_file.m_displayactive.toolbaritemtext = 'Display Active'
Elseif as_mode = 'part' then
	dw_crosstab.object.part_h.text = 'Vendor'
	bFirstTime				= FALSE
	ddlb_type.BackColor	= w_smart_po.BackColor
	bVendorMode	= FALSE
	bPartMode	= TRUE
	ddlb_type.AddItem("All")
	ddlb_type.AddItem("Buyer")
	ddlb_type.AddItem("Commodity")
	st_mode.text = "Parts"
	m_smart_po.m_file.m_nonreoccuring.enabled = false
	m_smart_po.m_file.m_displayactive.toolbaritemtext = 'Show Price'
	dw_active_po_per_vendor.visible = FALSE
End If


end event

event ue_displayactiveparts;String ls_Condition

if bvendormode then
	if as_value = 'Display Active' then
		m_smart_po.m_file.m_displayactive.toolbaritemtext = 'Display All'
		ls_condition = ''
	else
		m_smart_po.m_file.m_displayactive.toolbaritemtext = 'Display Active'
		ls_Condition	= "(qty_past_due > 0) or (qty_date1 > 0) or (qty_date2 > 0) or (qty_date3 > 0) or (qty_date4 > 0) or (qty_date5 >0) or (qty_date6 > 0) or (qty_date7 > 0)"
	end If

	dw_crosstab.SetFilter(ls_Condition)
	dw_crosstab.Filter()
else
	if not lb_price_search.visible	 then
		lb_price_search.visible	= true
	else
		lb_price_search.visible	= false
	end if
end if
end event

event dw_vendors_doubleclicked();
dw_vendors.TriggerEvent (doubleclicked!)

end event

public subroutine wf_build_crosstab ();dw_crosstab.retrieve ( ipo, datetime ( ddate1, time ( '00:00:00' ) ), '', 'V' )


end subroutine

public subroutine wf_create_ship_to ();If Not bDropShip	THEN		//If this is a normal ship type

	dw_po_header.object.ship_to_destination.dddw.name='d_dddw_ship_to_normal'
	dw_po_header.object.ship_to_destination.dddw.displaycolumn='code'
	dw_po_header.object.ship_to_destination.dddw.datacolumn='code'
	dw_po_header.getchild ( "ship_to_destination", dwShipTo )
	dwShipTo.settransobject ( sqlca )
	dwShipTo.Retrieve ( )
		
	IF szplant > '' THEN
		dwShipTo.setfilter ( "plant='"+szplant+"'" )
		dwShipTo.filter ()
	ELSE
		dwShipTo.reset()
	END IF

Else					//This is a drop shipment

	dw_po_header.modify ( "ship_to_destination.dddw.name = 'd_dddw_ship_to_dropship'" )
	dw_po_header.modify ( "ship_to_destination.dddw.displaycolumn='destination'" )
	dw_po_header.modify ( "ship_to_destination.dddw.datacolumn='destination'" )
	dw_po_header.getchild ( 'ship_to_destination', dwshipto )
	dwShipTo.settransobject ( sqlca )
	dwShipTo.Retrieve ( )

End If




end subroutine

public function boolean wf_plant_is_required ();String szPlantRequired

SELECT parameters.plant_required  
  INTO :szPlantRequired  
  FROM parameters  ;

Return (szPlantRequired = 'Y')
end function

public subroutine wf_build_crosstab_in_part_mode ();long ll_po

SetNull ( ll_po )

dw_crosstab.retrieve ( ll_po, datetime ( ddate1, time ( '00:00:00' ) ), szpart, 'P' )


end subroutine

public subroutine wf_highlight_po_row ();Long l_l_Row
Long l_l_TotalRows
Long l_l_PO

l_l_TotalRows	= dw_active_po_per_vendor.RowCount()

For l_l_Row = 1 to l_l_TotalRows
	l_l_PO	= dw_active_po_per_vendor.GetItemNumber(l_l_Row, "po_number")
	If wf_have_releases_in_po(l_l_PO) then
		dw_active_po_per_vendor.SelectRow(l_l_Row, TRUE)
	Else
		dw_active_po_per_vendor.SelectRow(l_l_Row, False)		
	End If
Next
end subroutine

public subroutine wf_recalc_parts ();Long l_l_Row

String l_s_Part

For l_l_Row = 1 to uo_print.dw_parts.RowCount()
	If uo_print.dw_parts.IsSelected(l_l_Row) then
		l_s_Part		= uo_print.dw_parts.GetItemString(l_l_Row, "value1")
		bNoCommit	= FALSE
		f_recalc_po_detail_per_part(iPO, l_s_Part, w_smart_po)
	End If		
Next
end subroutine

public function boolean wf_objects_in_release ();Decimal ld_Received
Decimal ld_TotReceived

Long    ll_RowCount
Long    ll_Row

ll_RowCount = dw_po_exists2.RowCount ( )

For ll_Row = 1 TO ll_RowCount
	ld_Received    = dw_po_exists2.GetItemNumber ( ll_Row, "received" )
	ld_TotReceived = ld_TotReceived + ld_Received
Next

If ld_TotReceived > 0 Then
	Return TRUE
Else
	Return FALSE
End If
end function

public function boolean wf_check_for_releases (string as_type, long al_po, string as_part, date ad_date);//  This function checks for existing releases for a non-recurring item

Boolean lb_ReleaseExists

Decimal ldec_Quantity

Datetime dt_ad_date

dt_ad_date = datetime(ad_date)

If as_Type = "N" Then		// Normal release that is not past due.

	DECLARE check_for_releases CURSOR FOR
	SELECT quantity
	  FROM po_detail
	 WHERE ( po_number   = :al_PO ) AND
			 ( part_number = :as_Part ) AND
			 ( date_due    < :dt_ad_Date ) AND
			 ( date_due    > :dt_ad_Date )	;

	Open check_for_releases	;

	Fetch check_for_releases Into :ldec_Quantity		;

	If SQLCA.SQLCode = 0 Then
		lb_ReleaseExists = TRUE
	Else
		lb_ReleaseExists = FALSE
	End If

	Close check_for_releases	;

ElseIf as_Type = "P" Then		// Releases that are past due.

	DECLARE check_for_past_releases CURSOR FOR
	SELECT quantity
	  FROM po_detail
	 WHERE ( po_number   = :al_PO ) AND
			 ( part_number = :as_Part ) AND
			 ( date_due   >= :dt_ad_Date )	;

	Open check_for_past_releases	;

	Fetch check_for_past_releases Into :ldec_Quantity		;

	If SQLCA.SQLCode = 0 Then
		lb_ReleaseExists = TRUE
	Else
		lb_ReleaseExists = FALSE
	End If

	Close check_for_past_releases	;

End If

If lb_ReleaseExists Then
	Return TRUE
Else
	Return FALSE
End If
end function

public subroutine wf_reset_fly_wheel ();String 	ls_mode

// Reset the flags on vendors
If bpartmode Then
	ls_mode = 'P'
else
	ls_mode = 'V'
end if

dw_vendors.Retrieve ( ls_mode, datetime ( ddate1, time ( '00:00:00' ) ), ddlb_type.text, dw_value.object.#1 [ 1 ]  )


/*
Int i_deleted, &
    i_po_number

Long l_Row

Datetime dt_ddate

dt_ddate = datetime(ddate)

If bVendorMode then 

	SELECT count(po_number),
   	    count(deleted)
	INTO	 :i_po_number, &
			 :i_deleted
	FROM   po_detail
	WHERE  vendor_code = :szVendor  AND
      	   ( po_detail.date_due <= :dt_dDate ) AND
				( po_detail.status = 'A') ;

	l_row = dw_vendors.Find( "value = '"+szVendor+"'", 0, dw_vendors.Rowcount())

Else

	SELECT count(po_number),
   	    count(deleted)
	INTO	 :i_po_number, &
			 :i_deleted
	FROM   po_detail
	WHERE  part_number = :szPart  AND
      	   ( po_detail.date_due <= :dt_dDate ) AND
				( po_detail.status = 'A') ;

	l_row = dw_vendors.Find( "value = '"+szpart+"'", 0, dw_vendors.Rowcount())

End If

If i_po_number <> i_deleted THEN
	dw_vendors.SetItem(l_row, "flag", 1)
Else
	dw_vendors.SetItem(l_row, "flag", 0)   
End If
*/


end subroutine

public function boolean wf_partial_update_release (string as_vendor);String l_s_PartialUpdate

SELECT partial_release_update  
  INTO :l_s_PartialUpdate  
  FROM vendor  
 WHERE code = :as_vendor   ;

If l_s_PartialUpdate = 'Y' then
	Return TRUE
Else
	Return FALSE
End If

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

			If wf_update_overreceived ( szvendor, l_s_CurrentPart, l_n_TotalReceived ) then
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

public function boolean wf_update_overreceived (string a_s_vendor, string a_s_part, decimal a_n_qty);Decimal ln_OverReceived

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

public subroutine wf_search_first_and_last_day (long a_l_po);datetime dt_ddate,dt_ddate1,dt_ddate7

dt_ddate1 = datetime(ddate1)
dt_ddate7 = datetime(ddate7)

 DECLARE curDate CURSOR FOR  
  SELECT po_detail.date_due  
    FROM po_detail  
   WHERE po_detail.po_number = :a_l_PO
ORDER BY po_detail.date_due ASC  ;

Open curDate;

Fetch curDate into :dt_dDate;

If SQLCA.SQLCode = 0 then
	dStartDate	= date(dt_dDate)
Else
	dStartDate	= date(dt_dDate1)
	dEndDate		= date(dt_dDate7)
End If

Do while SQLCA.SQLCode = 0 
	dEndDAte	= date(dt_dDate)
	Fetch curDate into :dt_dDate;
Loop

If dEndDate < date(dt_dDate7) then
	dEndDate	= date(dt_dDate7)
End If 

end subroutine

public subroutine wf_update_detail_plants (string a_s_plant);UPDATE po_detail  
   SET plant = :a_s_Plant  
 WHERE po_number = :iPO   ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If

end subroutine

public function string wf_get_part_name (string as_part);String szPartName

SetNull(szPartName)

SELECT part_vendor.part_name  
  INTO :szPartName  
  FROM part_vendor  
 WHERE part_vendor.part = :as_Part   ;

If IsNull(szPartName) then
	szPartName	= f_get_part_info(as_Part, "NAME")
End If

Return szPartName	

end function

public function boolean wf_have_releases_in_po (long a_l_po);Long 		l_l_TotalReleases
datetime dt_ddate7

Integer 	l_i_Deleted

Dt_ddate7 = datetime(ddate7)

If ddlb_type.text <> "DropShip" then
	SELECT count(po_detail.po_number ),
			 count(po_detail.deleted)  
	  INTO :l_l_TotalReleases,
			 :l_i_Deleted  
	  FROM po_detail  
	 WHERE ( po_detail.po_number = :a_l_PO ) AND  
	       ( po_detail.date_due  <= :dt_dDate7 ) AND
			 ( po_detail.status = 'A') ;
Else
	SELECT count(po_detail.po_number ),
			 count(po_detail.deleted)  
	  INTO :l_l_TotalReleases,
			 :l_i_Deleted
	  FROM po_detail  
	 WHERE ( po_detail.po_number = :a_l_PO ) AND  
	       ( po_detail.date_due  <= :dt_dDate7 ) AND
			 ( po_detail.ship_type = 'D') AND
			 ( po_detail.status = 'A') ;
End If

If l_l_TotalReleases = l_i_Deleted Then
	l_l_TotalReleases = 0
End If

Return (l_l_TotalReleases > 0)

end function

public subroutine wf_show_price_matrix (string as_vendor, string as_part, integer ai_posx, integer ai_posy);Long l_l_Row
Long l_l_TotalRows
Long l_l_Qty
Decimal l_n_Price

String l_s_Temp

dw_price_matrix.Retrieve(as_vendor, as_part)

l_l_TotalRows	= dw_price_matrix.RowCount()
lb_price_search.Reset()

l_s_Temp		= "Qty       Price"

lb_price_search.AddItem(l_s_Temp)

For l_l_Row = 1 to l_l_TotalRows

	l_l_Qty		= dw_price_matrix.GetItemNumber(l_l_Row, "break_qty")
	l_n_Price	= dw_price_matrix.GetItemNumber(l_l_Row, 6)

	l_s_Temp	= LeftA(String(l_l_Qty) + Space(10), 10) + " $" + String(Truncate(l_n_Price,4))
	lb_price_search.AddItem(l_s_Temp)

Next


end subroutine

public function boolean wf_have_releases (string a_s_value, date a_d_date);Long 	l_l_TotalReleases
Int  	l_i_deleted

Datetime dt_ddate7

Dt_ddate7 = datetime(ddate7)

If bVendorMode then

	If ddlb_type.text <> 'DropShip' then	
		SELECT count(po_detail.vendor_code ),
				 count(po_detail.deleted)  
    	INTO :l_l_TotalReleases,
				:l_i_deleted   
		    FROM po_detail  
		   WHERE ( po_detail.vendor_code = :a_s_Value ) AND  
		         ( po_detail.date_due <= :dt_dDate7 ) AND
					( po_detail.status = 'A')  ;
	Else
		SELECT count(po_detail.vendor_code ),
				 count(po_detail.deleted)  
    	INTO :l_l_TotalReleases,
				:l_i_deleted  
		    FROM po_detail  
		   WHERE ( po_detail.vendor_code = :a_s_Value ) AND  
		         ( po_detail.date_due <= :dt_dDate7 ) AND
					( po_detail.status = 'A') AND
					( po_detail.ship_type = 'D') ;
	End If

	If l_l_TotalReleases=l_i_deleted Then
       l_l_TotalReleases = 0
   End If

Else
	If ddlb_type.text <> 'DropShip' then
		SELECT count(po_detail.vendor_code ),
				 count(po_detail.deleted)  
    	INTO :l_l_TotalReleases,
				:l_i_deleted  
    	FROM po_detail  
   	WHERE ( po_detail.part_number = :a_s_Value ) AND
      	   ( po_detail.date_due <= :dt_dDate7 ) AND
				( po_detail.status = 'A') ;
	Else
		SELECT count(po_detail.vendor_code ),
				 count(po_detail.deleted)  
    	INTO :l_l_TotalReleases,
				:l_i_deleted  
    	FROM po_detail  
   	WHERE ( po_detail.part_number = :a_s_Value ) AND  
      	   ( po_detail.date_due <= :dt_dDate7 ) AND
				( po_detail.status = 'A') AND
				( po_detail.ship_type = 'D') ;
	End If

	If l_l_TotalReleases=l_i_deleted Then
       l_l_TotalReleases = 0
   End If
End If

Return (l_l_TotalReleases > 0)


end function

public function string wf_get_term (string a_s_vendor);String l_s_Term

  SELECT vendor.terms  
    INTO :l_s_Term  
    FROM vendor  
   WHERE vendor.code = :a_s_Vendor   ;

Return l_s_Term
end function

public subroutine wf_save_po_detail (st_generic_structure a_st_parm);/* 01-14-2000 KAZ Modified rollback to release database before message box */

String 	l_s_ShipTo
String	l_s_Term
String	l_s_Plant
String	l_s_Project
String	l_s_GLAccount
String	l_s_PartName
STRING  	l_s_unit, &
			l_s_date, &
			l_s_time
String taxable
String l_s_SQLErrorText																// ADD 01-14-2000 KAZ

Datetime l_d_datetime

Decimal	l_n_Qty
Decimal	l_n_Price
Decimal  l_n_other_charge

Long		l_l_RowId
Long		l_l_WeekNo
Long		l_l_CurrentPO

szPart			= a_st_parm.value1
l_s_PartName	= a_st_parm.value2
l_s_Plant		= dw_po_header.GetItemString(1, "plant")
l_s_ShipTo		= dw_po_header.GetItemString(1, "ship_to_destination")
l_s_Term			= dw_po_header.GetItemString(1, "terms")

l_s_date			= LeftA ( a_st_parm.value3, LenA (a_st_parm.value3 ) - 9 ) 
l_s_time			= RightA ( a_st_parm.value3, 8 )  

l_d_datetime	=   Datetime ( Date ( l_s_date ) , time ( '00:00:00' ) )

l_s_unit			= a_st_parm.value8
l_s_Project		= a_st_parm.value7
l_s_GLAccount	= a_st_parm.value6

l_n_Qty			= Dec(a_st_parm.value4)
l_n_Price		= Dec(a_st_parm.value5)
l_n_other_charge = Dec(a_st_parm.value9)

select
	max(row_id) + 1
into
	:l_l_RowID
from
	po_detail
where
	po_number = :iPO  ;

if	isNull(l_l_RowID) then
	l_l_RowID = 0
end if

l_l_WeekNo		= f_get_week_no( Date ( l_s_Date) )

taxable = a_st_parm.value10

DELETE FROM po_detail
 WHERE ( po_detail.po_number = :iPO ) AND  
       ( po_detail.part_number = :szPart );

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
		other_charge,
		taxable)  
VALUES ( :iPO,   
         :szVendor,   
         :szPart,   
         :l_s_PartName,   
         :l_s_unit,   
         :l_d_Datetime,   
         :l_s_Project,   
         'A',   
         null,   
         null,   
         null,   
         null,   
         :l_s_GLAccount,   
         null,   
         :l_n_Qty,   
         0,   
         :l_n_Qty,   
         0,   
         0,   
         :l_n_Price,   
         :l_l_RowId,   
         null,   
         null,   
         null,   
         null,   
         null,   
         null,   
         :l_s_ShipTo,   
         :l_s_Term,   
         :l_l_WeekNo,   
         :l_s_Plant,
		:l_n_other_charge,
		:taxable);

IF SQLCA.SQLCode = 0 then
	Commit;
Else
	l_s_SQLErrorText = SQLCA.SQLErrText																	// ADD 01-14-2000 KAZ
	Rollback;  // 01-14-2000  KAZ
   MessageBox(monsys.msg_title, l_s_SQLErrorText, StopSign!)									// ADD 01-14-2000 KAZ
//	Rollback;  -  01-14-2000  KAZ
End If

end subroutine

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

public subroutine wf_build_values (string as_value);datawindowchild l_dwc

dw_value.Reset ()

/* set the dddw name and columns */

CHOOSE CASE as_value

	CASE 'Commodity'
		dw_value.modify ( "data.dddw.name='d_dddw_commodity'" )
		dw_value.modify ( "data.dddw.displaycolumn='id'" )
		dw_value.modify ( "data.dddw.datacolumn='id'" )

	CASE 'Vendor'
		dw_value.modify ( "data.dddw.name='d_dddw_vendors'" )
		dw_value.modify ( "data.dddw.displaycolumn='code'" )
		dw_value.modify ( "data.dddw.datacolumn='code'" )

	CASE 'Plant'
		dw_value.modify ( "data.dddw.name='d_dddw_plants'" )
		dw_value.modify ( "data.dddw.displaycolumn='destination'" )
		dw_value.modify ( "data.dddw.datacolumn='destination'" )

	CASE 'Buyer'
		IF bvendormode then
			dw_value.modify ( "data.dddw.name='d_dddw_buyer'" )
			dw_value.modify ( "data.dddw.displaycolumn='buyer'" )
			dw_value.modify ( "data.dddw.datacolumn='buyer'" )
		else
			dw_value.modify ( "data.dddw.name='d_dddw_part_buyer'" )
			dw_value.modify ( "data.dddw.displaycolumn='buyer'" )
			dw_value.modify ( "data.dddw.datacolumn='buyer'" )
		end if
END CHOOSE

dw_value.insertrow(1)
dw_value.getchild ( "data" , l_dwc )

l_dwc.settransobject ( sqlca )
l_dwc.retrieve ()
l_dwc.selectrow ( 0, false )

end subroutine

public subroutine wf_retrieve_vendor_parts ();If bVendorMode then
	dw_vendor_parts.Retrieve(szVendor)
	dw_vendor_parts.SetSort("1a")
	dw_vendor_parts.Sort()
Else
	dw_part_vendors.Retrieve(szPart)
	dw_part_vendors.SetSort("1a")
	dw_part_vendors.Sort()
End If
end subroutine

event timer;call super::timer;String szDate, &
		 ls_mode
		 
If bFinish then

	If Not bPrintMode then
		Timer(0)
		bFinish	= FALSE
		szDate	= szReturnedString

		If szDate > " " then
			dDate1	= Date(szDate)
			If bpartmode Then
				ls_mode = 'P'
			else
				ls_mode = 'V'
			end if
			
			dw_vendors.Retrieve ( ls_mode, datetime ( ddate1, time ( '00:00:00' ) ), ddlb_type.text, dw_value.object.#1 [ 1 ]  )

			If bVendorMode then
				wf_build_crosstab()
			Else
				wf_build_crosstab_in_part_mode()
			End If
		End If

		Timer(0.5)

	Else
		Timer(0)
		wf_recalc_parts()
		bPrintMode = FALSE
	End If

End If

If bFirstTime then
	If ddlb_type.backcolor	= this.backcolor then
		ddlb_type.backcolor	= f_get_color_value("white")
	Else
		ddlb_type.backcolor	= this.backcolor
	End If
End If
		
		
	
end event

event open;call super::open;// Initialization
dDate = Today()
dDate1 = dDate
dDate2 = relativedate ( ddate1, 1 )
dDate3 = relativedate ( ddate1, 2 )
dDate4 = relativedate ( ddate1, 3 )
dDate5 = relativedate ( ddate1, 4 ) 
dDate6 = relativedate ( ddate1, 5 )
dDate7 = relativedate ( ddate1, 6 )

dDateList[1]  = ddate1 
dDateList[2] =  ddate2 
dDateList[3] =  ddate3 
dDateList[4] =  ddate4 
dDateList[5] =  ddate5 
dDateList[6] =  ddate6 
dDateList[7] =  ddate7

dw_po_header.GetChild ( 'Ship_to_destination', dwShipTo )

Timer (0.5)

end event

event close;call super::close;If IsValid(uo_print) then CloseUserObject(uo_print)

end event

event activate;call super::activate;if bVendormode then
	m_smart_po.m_file.m_nonreoccuring.enabled = true
else
	m_smart_po.m_file.m_nonreoccuring.enabled = false
end if
Timer ( .5 )
end event

on w_smart_po.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_smart_po" then this.MenuID = create m_smart_po
this.ddlb_type=create ddlb_type
this.dw_value=create dw_value
this.st_10=create st_10
this.p_3=create p_3
this.st_mode=create st_mode
this.dw_vendors=create dw_vendors
this.dw_update_future_note=create dw_update_future_note
this.dw_vendor_parts=create dw_vendor_parts
this.dw_po_detail_2=create dw_po_detail_2
this.dw_po_exists2=create dw_po_exists2
this.dw_price_matrix=create dw_price_matrix
this.dw_part_vendors=create dw_part_vendors
this.dw_po_row_id=create dw_po_row_id
this.dw_po_per_vendor=create dw_po_per_vendor
this.st_new_po=create st_new_po
this.p_delete=create p_delete
this.p_receive=create p_receive
this.lb_price_search=create lb_price_search
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_po_detail=create dw_po_detail
this.dw_active_po_per_vendor=create dw_active_po_per_vendor
this.mle_message=create mle_message
this.uo_print=create uo_print
this.cb_note=create cb_note
this.dw_po_header=create dw_po_header
this.gb_2=create gb_2
this.dw_crosstab=create dw_crosstab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_type
this.Control[iCurrent+2]=this.dw_value
this.Control[iCurrent+3]=this.st_10
this.Control[iCurrent+4]=this.p_3
this.Control[iCurrent+5]=this.st_mode
this.Control[iCurrent+6]=this.dw_vendors
this.Control[iCurrent+7]=this.dw_update_future_note
this.Control[iCurrent+8]=this.dw_vendor_parts
this.Control[iCurrent+9]=this.dw_po_detail_2
this.Control[iCurrent+10]=this.dw_po_exists2
this.Control[iCurrent+11]=this.dw_price_matrix
this.Control[iCurrent+12]=this.dw_part_vendors
this.Control[iCurrent+13]=this.dw_po_row_id
this.Control[iCurrent+14]=this.dw_po_per_vendor
this.Control[iCurrent+15]=this.st_new_po
this.Control[iCurrent+16]=this.p_delete
this.Control[iCurrent+17]=this.p_receive
this.Control[iCurrent+18]=this.lb_price_search
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_1
this.Control[iCurrent+21]=this.dw_po_detail
this.Control[iCurrent+22]=this.dw_active_po_per_vendor
this.Control[iCurrent+23]=this.mle_message
this.Control[iCurrent+24]=this.uo_print
this.Control[iCurrent+25]=this.cb_note
this.Control[iCurrent+26]=this.dw_po_header
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.dw_crosstab
end on

on w_smart_po.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_type)
destroy(this.dw_value)
destroy(this.st_10)
destroy(this.p_3)
destroy(this.st_mode)
destroy(this.dw_vendors)
destroy(this.dw_update_future_note)
destroy(this.dw_vendor_parts)
destroy(this.dw_po_detail_2)
destroy(this.dw_po_exists2)
destroy(this.dw_price_matrix)
destroy(this.dw_part_vendors)
destroy(this.dw_po_row_id)
destroy(this.dw_po_per_vendor)
destroy(this.st_new_po)
destroy(this.p_delete)
destroy(this.p_receive)
destroy(this.lb_price_search)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_po_detail)
destroy(this.dw_active_po_per_vendor)
destroy(this.mle_message)
destroy(this.uo_print)
destroy(this.cb_note)
destroy(this.dw_po_header)
destroy(this.gb_2)
destroy(this.dw_crosstab)
end on

event deactivate;call super::deactivate;Timer ( 0 )
end event

type ddlb_type from dropdownlistbox within w_smart_po
integer width = 512
integer height = 336
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean vscrollbar = true
string item[] = {"All","Buyer","Plant","Vendor","DropShip"}
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;MessageBox(monsys.msg_title, "Select search method", Information!)
end event

event selectionchanged;bFirstTime				= FALSE
this.BackColor			= Parent.BackColor
mle_message.visible	= FALSE
dw_vendors.Reset ()
dw_active_po_per_vendor.Visible = false

SetNull(szPart)
SetNull(szVendor)

Choose Case this.text

	Case "All"

		dw_value.visible			= FALSE

		If bVendorMode then
			dw_vendors.Retrieve ( 'V', datetime ( ddate1, time ( '00:00:00' ) ), 'All', '' )
		Else
			dw_vendors.Retrieve ( 'P', datetime ( ddate1, time ( '00:00:00' ) ), 'All', ''  )
		End If

	Case "DropShip"

		dw_value.visible			= FALSE

		If bVendorMode then
			dw_vendors.Retrieve ( 'V', datetime ( ddate1, time ( '00:00:00' ) ), 'DropShip',  '' )
		End If

	Case Else 
		dw_value.visible		= TRUE
		
END CHOOSE

wf_build_values ( this.text ) 
end event

type dw_value from datawindow within w_smart_po
boolean visible = false
integer y = 80
integer width = 503
integer height = 76
integer taborder = 30
string dataobject = "d_external_drop_down_dw"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_value.Modify ( "data.Width=480" )
dw_value.Modify ( "data.height=52" )
dw_value.Modify ( "data.dddw.PercentWidth	= 250" )
end event

event itemchanged;string ls_mode

dw_crosstab.Reset()
dw_po_header.Reset()

if bVendorMode then
	ls_mode = 'V'
else
	ls_mode = 'P'
end if

If ddlb_type.text	= "Vendor" then
	SetNull(szVendor)
End If

dw_vendors.Retrieve ( ls_mode, datetime ( ddate1, time ( '00:00:00' ) ), ddlb_type.text, data )
dw_active_po_per_vendor.visible	= FALSE
end event

type st_10 from statictext within w_smart_po
integer x = 302
integer y = 152
integer width = 215
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "Releases"
boolean focusrectangle = false
end type

type p_3 from picture within w_smart_po
integer x = 242
integer y = 156
integer width = 50
integer height = 40
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type st_mode from statictext within w_smart_po
integer y = 152
integer width = 233
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "Vendors"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_vendors from datawindow within w_smart_po
event ue_reset pbm_custom01
event ue_header_note pbm_custom02
event ue_save_note pbm_custom03
event ue_close_uo_note pbm_custom04
event ue_detail_note pbm_custom05
integer y = 204
integer width = 512
integer height = 864
integer taborder = 40
string dataobject = "d_msp_build_vendor_part_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_reset;Long l_row

string PassedString

PassedString = String(Message.LongParm, "address")

If bVendormode Then
	l_row = dw_vendors.Find( "value = '"+szVendor+"'", 0, dw_vendors.Rowcount())
Else
	l_row = dw_vendors.Find( "value = '"+szPart+"'", 0, dw_vendors.Rowcount())	
End If

If l_row > 0 then
	If passedstring = "Y" THEN
		dw_vendors.SetItem(l_row, "flag", 1)
	Else
		dw_vendors.SetItem(l_row, "flag", 0)   
	End If
End If

wf_highlight_po_row()
end event

event ue_header_note;string ls_note, &
		 ls_syntax, &
		 ls_error, &
		 ls_datatype

datastore  lds_ponote

if not bnewpo then

	bfootnote = true
	
	lds_ponote = create datastore 
	
	ls_syntax  = 'Select notes from po_header where po_number = ' + string ( ipo )
	ls_syntax  = SQLCA.SyntaxFromSQL ( ls_syntax, "style(type=grid)",  ls_error )
	
	If ls_error <= '' or isnull ( ls_error ) then 
		lds_ponote.create ( ls_syntax, ls_error ) 
		lds_ponote.settransobject ( sqlca )
		if lds_ponote.retrieve () > 0 then
			ls_note = lds_ponote.object.#1 [1] 
		end if
	end if
	
	ls_datatype = lds_ponote.object.#1.coltype
	
	destroy lds_ponote ;
	
	openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!
	
	uo_normal_note.mle_note.text = ls_note

end if

end event

event ue_save_note;String  ls_note
Datetime dt_ddate

ls_note = uo_normal_note.mle_note.Text

if i_b_future_note then
	
	i_b_future_note = FALSE
	
	dw_update_future_note.SetItem ( 1, "notes", ls_note )

	if dw_update_future_note.Update ( ) = -1 then
		rollback;
	else
		commit;
	end if
else
	
	dt_ddate = datetime(ddate)

	If bFootNote then

	  UPDATE po_header  
	     SET notes = :ls_note  
	   WHERE po_number = :iPO   ;
	
	End If
	
	If bPartNote then
	
	  UPDATE po_detail  
	     SET notes = :ls_note  
	   WHERE ( po_number = :iPO ) AND  
	         ( part_number = :szPart ) AND  
	         ( date_due = :dt_dDate )  ;
		
	End If

	If SQLCA.SQLCode	= 0 then
		Commit;
		If bFootNote then
			dw_po_header.retrieve ( ipo )
			bFootNote = False
		Elseif bPartNote then
			bPartNote = false			
		End If
	Else
		Rollback;
	End If
	
end if

closeuserobject ( uo_normal_note )


end event

event ue_close_uo_note;if isvalid ( uo_normal_note ) then
  closeuserobject(uo_normal_note)
  dw_po_header.Retrieve(iPO)
end if
end event

event ue_detail_note;long		l_l_row

string   ls_note, &
			ls_Datatype, &
			ls_syntax, &
			ls_error
			
datastore   lds_ponote	

lds_ponote = create datastore 
lds_ponote.dataobject = 'dw_check_po_exists'
lds_ponote.settransobject ( sqlca )

If bPastDue then
	MessageBox(monsys.msg_title, "You can not edit/create part note for past due releases", StopSign!)
	Return
End If

If nQty > 0 then

	bPartNote		= TRUE

	ls_Datatype		= lds_ponote.object.notes.coltype
	if lds_ponote.retrieve ( iPO, dDate, szPart  ) > 0 then
		ls_note = lds_ponote.object.notes [1] 
	end if

	destroy lds_ponote ;
	
	openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)
	uo_normal_note.bringtotop = True
	uo_normal_note.borderstyle = StyleRaised!
	uo_normal_note.mle_note.text = ls_note

Else

	l_l_row = dw_crosstab.GetRow ( )

	if l_l_row < 1 then
		MessageBox(monsys.msg_title, "There is no quantity required, you cannot create part note!", StopSign!)
	else
		if dw_crosstab.GetItemNumber ( l_l_row, "flag" ) > 0 then
			if dw_update_future_note.Retrieve ( iPo, szPart, dDate7 ) > 0 then
				i_b_future_note = TRUE
				bPartNote		= TRUE
				ls_note 			= dw_update_future_note.object.notes[1]
				ls_Datatype		= dw_update_future_note.object.notes.coltype
				openuserobjectwithparm (uo_normal_note, ls_datatype, 622,161)

				uo_normal_note.bringtotop = True
				uo_normal_note.borderstyle = StyleRaised!
				uo_normal_note.mle_note.text = ls_note
			end if
		end if
	end if
End If
end event

event clicked;Long 		iRow
Long     l_Rows

iRow	= row

If iRow <= 0 then Return

iPO = 0

dw_vendors.SelectRow(0, False)    
dw_vendors.SelectRow(iRow, True) 

If bVendorMode then /* Vendor mode */

	If iRow > 0 then
		dw_crosstab.Reset()
		dw_po_header.Reset()
		szVendor	= this.GetItemString(iRow, 1)
		dw_vendor_parts.Retrieve(szVendor)
		dw_vendor_parts.SetSort("1a")
		dw_vendor_parts.Sort()

		dw_crosstab.Enabled	= FALSE
		
      l_Rows = dw_active_po_per_vendor.Retrieve(szVendor)
		
		If l_Rows < 1 Then
         dw_active_po_per_vendor.Visible = False
			MessageBox(monsys.msg_title, "There is no active PO for the current vendor", StopSign!)
 		Else
			wf_highlight_po_row()
			dw_active_po_per_vendor.Visible	= TRUE
		End If
		
	End If

Else		/* Part mode */
	
	lb_price_search.visible	= FALSE

	szPart	= this.GetItemString(iRow, 1)
	dw_part_vendors.Retrieve(szPart)
	dw_part_vendors.SetSort("1a")
	dw_part_vendors.Sort()

	dw_crosstab.Reset()
	dw_po_header.Reset()
	wf_build_crosstab_in_part_mode ()

End If	
end event

event constructor;settransobject ( sqlca )
end event

event doubleclicked;OpenSheetWithParm(w_smart_price_matrix, szVendor, gnv_App.of_GetFrame(), 0, Original!)
end event

event rbuttondown;MessageBox(monsys.msg_title, "Select vendor or part", Information!)
end event

type dw_update_future_note from datawindow within w_smart_po
boolean visible = false
integer x = 1486
integer y = 1688
integer width = 274
integer height = 352
integer taborder = 120
string dataobject = "d_update_note_for_release"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_vendor_parts from datawindow within w_smart_po
boolean visible = false
integer x = 5
integer y = 1684
integer width = 261
integer height = 360
integer taborder = 150
string dataobject = "d_vendor_part_list_invisible"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_po_detail_2 from datawindow within w_smart_po
boolean visible = false
integer x = 2432
integer y = 1688
integer width = 229
integer height = 360
integer taborder = 140
string dataobject = "dw_po_detail_demand_after_date"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_po_exists2 from datawindow within w_smart_po
boolean visible = false
integer x = 2121
integer y = 1688
integer width = 274
integer height = 360
integer taborder = 130
string dataobject = "dw_check_po_exists2"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_price_matrix from datawindow within w_smart_po
boolean visible = false
integer x = 1783
integer y = 1692
integer width = 293
integer height = 352
integer taborder = 200
string dataobject = "dw_smart_vendor_part_price_matrix"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_part_vendors from datawindow within w_smart_po
boolean visible = false
integer x = 1166
integer y = 1688
integer width = 279
integer height = 352
integer taborder = 190
string dataobject = "dw_active_po_per_part"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_po_row_id from datawindow within w_smart_po
boolean visible = false
integer x = 896
integer y = 1684
integer width = 261
integer height = 352
integer taborder = 180
string dataobject = "dw_smart_po_row_id"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_po_per_vendor from datawindow within w_smart_po
boolean visible = false
integer x = 608
integer y = 1688
integer width = 270
integer height = 352
integer taborder = 170
string dataobject = "dw_po_per_vendor"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type st_new_po from statictext within w_smart_po
boolean visible = false
integer x = 2642
integer y = 992
integer width = 229
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = "New PO"
alignment alignment = center!
long bordercolor = 255
boolean focusrectangle = false
end type

type p_delete from picture within w_smart_po
integer x = 160
integer y = 1312
integer width = 178
integer height = 96
string picturename = "trash.bmp"
boolean border = true
boolean focusrectangle = false
end type

event dragdrop;Decimal nReceived
Decimal ld_quantity

Datetime dt_ddate,dt_ddate1

Int li_Counter

string ls_mode

Datastore lds_po_exists

lds_po_exists = create datastore 

lds_po_exists.dataobject = 'dw_check_po_exists' 
lds_po_exists.settransobject ( sqlca )

If Not bPastDue Then

	If lds_po_exists.Retrieve ( iPO, dDate, szPart ) > 0 Then
		nReceived   = lds_po_exists.GetItemNumber ( 1, "received" )
		ld_Quantity = lds_po_exists.GetItemNumber ( 1, "quantity" )
	End If
	
Else
	
	dw_po_exists2.Retrieve ( iPO, dDate1, szPart )

	If dw_po_exists2.RowCount ( ) > 0 Then
		nReceived   = dw_po_exists2.GetItemNumber ( 1, "received" )
		ld_Quantity = dw_po_exists2.GetItemNumber ( 1, "quantity" )
	End If
End If

If ( lds_po_exists.RowCount ( ) = 0 AND dw_po_exists2.RowCount ( ) = 0 ) OR &
	( nReceived = 0 AND ld_Quantity = 0 ) Then
	If Not bPastDue Then
		MessageBox ( monsys.msg_title, "There is no active release for Part: " + &
                	 szPart + " on Date: " + String ( dDate ) + ".  Please" + &
                	 " choose releases that are active.", StopSign!, OK! )
		bCrosstab	= FALSE
		Return
	Else
		MessageBox ( monsys.msg_title, "There are no active releases for Part: " + &
                	 szPart + " that are past due.  Please" + &
                	 " choose releases that are active.", StopSign!, OK! )
		bCrosstab	= FALSE
		Return		
	End If
End If 

dt_ddate = datetime(ddate)
dt_ddate1 = datetime(ddate1)

If source = dw_crosstab Then
	If Not bPastDue then
		If MessageBox( monsys.msg_title, "This will set the release (Part: " + &
                     szPart + ", Date: " + String(dDate) + ") to be " + &
                     "marked for deletion.  Do you wish to continue?", &
                     Question!, YesNo! ) = 1 Then

			SetPointer ( HourGlass! )

			SELECT po_detail.received  
	    	INTO :nReceived  
	    	FROM po_detail  
	   	WHERE ( po_detail.po_number = :iPO ) AND  
	      	   ( po_detail.part_number = :szPart ) AND  
	         	( po_detail.date_due = :dt_dDate )   ;

			If nReceived > 0 Then 
				MessageBox ( monsys.msg_title, "You cannot delete a release that " + &
							    "objects have already been received against." + &
                         "  If you want to close out the release, simply" + &
                         " change the required quantity to equal the " + &
                         "received quantity in the release.", StopSign!, OK! )
				bCrosstab	= FALSE
				Return
			Else
				If f_valid_part_number(szPart) AND &
				f_get_part_info(szPart, "CLASS") <> "N" Then
					UPDATE   po_detail
					SET      quantity           = 0,
   	   	            received           = 0,
      	   	         balance            = 0,
         	   	      price              = 0,
            	   	   standard_qty       = 0,
               	   	printed            = 'N',
	               	   selected_for_print = 'N',
   	               	deleted            ='Y'
		   		WHERE    ( po_detail.po_number = :iPO ) AND  
		      		      ( po_detail.part_number = :szPart ) AND  
	   	      		   ( po_detail.date_due = :dt_dDate )   ;

				Else		//  If part is a non-recurring item

					If wf_check_for_releases ( "N", iPO, szPart, dDate ) Then
						DELETE FROM po_detail
 						 WHERE ( po_number   = :iPO ) AND  
						       ( part_number = :szPart ) AND
								 ( date_due    = :dt_dDate )   ;
					Else
						DELETE FROM po_detail
 						 WHERE ( po_number   = :iPO ) AND  
						       ( part_number = :szPart ) AND
								 ( date_due    = :dt_dDate )   ;

						DELETE FROM part_vendor
						 WHERE ( part   = :szPart ) AND
								 ( vendor = :szVendor )		;
													
					End If
				End If
	
				If SQLCA.SQLCode = -1 then
					Rollback;
					MessageBox ( monsys.msg_title, "Unable to mark release for deletion.", Information!, OK! )
				Else
					Commit;
					bNoCommit	= FALSE
					f_recalc_po_detail_per_part(iPO, szPart, w_smart_po)
	  				SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + szpart )
				   f_update_qty_asgnd_part ( szpart ) 
					SetMicroHelp ( 'Ready' )
					dw_po_detail.Reset ( )
					wf_reset_fly_wheel()
					If bVendormode Then
						wf_build_crosstab ( )
					Else
						wf_build_crosstab_in_part_mode( )
					End If
				End If
			End If	
		End If

	Else	//  Delete past due releases

		If MessageBox( monsys.msg_title, "This will set all releases before date" + &
                     ": " + String(dDate1) + " to be marked for deletion" + &
                     " for part: " + szPart + ".  Do you wish to continue?", &
                     Question!, YesNo!) = 1 Then

			SetPointer ( HourGlass! )

			If wf_objects_in_release ( ) Then 
				MessageBox ( monsys.msg_title, "You cannot delete releases that " + &
						   	 "objects have already been received against." + &
                       	 "  If you want to close out a release, simply" + &
                       	 " change the required quantity to equal the " + &
                       	 "received quantity in the release.", StopSign!, OK! )
				bCrosstab	= FALSE
				Return
			Else
				If f_valid_part_number(szPart) AND &
				f_get_part_info(szPart, "CLASS") <> "N" Then
					UPDATE   po_detail
					SET      quantity           = 0,
      		            received           = 0,
         		         balance            = 0,
  	         		      price              = 0,
     	         		   standard_qty       = 0,
        	         		printed            = 'N',
         	         	selected_for_print = 'N',
	  	         	      deleted            ='Y'
   				WHERE ( po_number = :iPO ) AND  
  	   				   ( part_number = :szPart ) AND  
     	   				( date_due < :dt_dDate1 )   ;

				Else  //  If part is a non-recurring item

					If wf_check_for_releases ( "N", iPO, szPart, dDate1 ) Then
						DELETE FROM po_detail
 						 WHERE ( po_number   = :iPO ) AND  
						       ( part_number = :szPart ) AND
								 ( date_due    < :dt_dDate1 )   ;
					Else
						DELETE FROM po_detail
 						 WHERE ( po_number   = :iPO ) AND  
						       ( part_number = :szPart ) AND
								 ( date_due    < :dt_dDate1 )   ;

						DELETE FROM part_vendor
						 WHERE ( part   = :szPart ) AND
								 ( vendor = :szVendor )		;
													
					End If
				End If	

				If SQLCA.SQLCode = -1 then
					Rollback;
					MessageBox(monsys.msg_title, "Unable to mark releases for deletion.", Information!)
				Else
					Commit;
					SetMicroHelp ( 'Recalculating assigned quantities in MPS : ' + szpart )
				   f_update_qty_asgnd_part ( szpart ) 
					SetMicroHelp ( 'Ready' )
					dw_po_detail.Reset ( )
					wf_reset_fly_wheel ( ) 
					If bVendormode Then
						wf_build_crosstab ( )
					Else
						wf_build_crosstab_in_part_mode( )
					End If
				End If
			End If
		End If	
	End If
End If

destroy lds_po_exists	;

end event

event rbuttondown;MessageBox ( monsys.msg_title, "Drag and drop releases here for deletion.", Information! )
end event

event clicked;MessageBox ( monsys.msg_title, "To delete a P.O. release, simply drag and drop the P.O. release to the trash icon!", Information! )

end event

type p_receive from picture within w_smart_po
integer x = 160
integer y = 1136
integer width = 178
integer height = 96
string picturename = "truck.bmp"
boolean border = true
boolean focusrectangle = false
end type

event dragdrop;Long 		iRowId

If bNewPO then
	MessageBox(monsys.msg_title, "You must create PO first!" , StopSign!)
	bCrosstab  = FALSE
	Return
End If

If wf_plant_is_required() then
	If IsNull(dw_po_header.GetItemString(1, "plant"))  OR dw_po_header.GetItemString(1, "plant") = '' then
		MessageBox(monsys.msg_title, "Plant code is required!", StopSign!) 
		bCrosstab	= FALSE
		Return
	End If
End If

If source = dw_crosstab then
	
	dw_po_row_id.Retrieve ( iPO, szPart )

	If dw_po_row_id.RowCount() > 0 then 	

		iRowId	= dw_po_row_id.GetItemNumber ( 1, "row_id" )

		stParm.value1	= String ( iPO )
		stParm.value2	= dw_po_header.GetItemString ( 1, "plant" )
		stParm.value3	= String(iRowId)

//		OpenSheetWithParm ( w_visual_receiving_dock_version2, stParm, gnv_App.of_GetFrame(), 0, Original! )

	Else
		
		MessageBox ( monsys.msg_title, "There is no schedule for receiving!", StopSign! )
		
	End If

End If
end event

event clicked;If dw_po_header.RowCount() > 0 then
	If wf_plant_is_required() then
		If IsNull(dw_po_header.GetItemString(1, "plant")) OR dw_po_header.GetItemString(1, "plant") = '' then
			MessageBox(monsys.msg_title, "Plant code is required!", StopSign!) 
			bCrosstab	= FALSE
			Return
		End If
	End If
End If

SetPointer ( Hourglass! )

stParm.value1	= String(0)
stParm.value2	= ''

//OpenSheetWithParm(w_visual_receiving_dock_version2, stParm, gnv_App.of_GetFrame(), 0, Original!)
end event

event rbuttondown;MessageBox(monsys.msg_title, "Click or dragdrop will start receiving dock from here", Information!)
end event

type lb_price_search from listbox within w_smart_po
boolean visible = false
integer x = 937
integer y = 1008
integer width = 837
integer height = 368
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77897888
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_smart_po
integer y = 1248
integer width = 517
integer height = 176
integer taborder = 210
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "Delete Releases"
end type

type gb_1 from groupbox within w_smart_po
integer y = 1072
integer width = 512
integer height = 176
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "Receiving Dock"
end type

type dw_po_detail from datawindow within w_smart_po
boolean visible = false
integer x = 297
integer y = 1692
integer width = 229
integer height = 352
integer taborder = 160
boolean bringtotop = true
string dataobject = "dw_po_detail_demand_before_date"
boolean livescroll = true
end type

event constructor;settransobject ( sqlca )
end event

type dw_active_po_per_vendor from datawindow within w_smart_po
boolean visible = false
integer x = 553
integer y = 336
integer width = 2286
integer height = 488
integer taborder = 110
string dataobject = "dw_active_po_per_vendor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;If row > 0 then

	st_new_po.visible		= FALSE

	szPlant					= this.object.plant[row]
	iPO						= this.object.po_number[row]
	i_s_type					= this.object.comp_type[row]
	
	dw_po_header.Retrieve(iPO)
	
	dw_crosstab.Enabled	= TRUE
	this.visible			= FALSE
	bNewPO					= FALSE
	bDropShip				= (dw_po_header.object.ship_type[1] = 'Drop')

	wf_create_ship_to()
	wf_build_crosstab()		//Create crosstab
	
End If
end event

event constructor;settransobject ( sqlca )
end event

type mle_message from multilineedit within w_smart_po
integer x = 1230
integer y = 500
integer width = 882
integer height = 184
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
boolean enabled = false
string text = " Please use dropdown list to make selection"
borderstyle borderstyle = styleraised!
end type

type uo_print from u_smart_po_printing_processor within w_smart_po
boolean visible = false
integer x = 837
integer y = 192
long backcolor = 77897888
end type

on uo_print.destroy
call u_smart_po_printing_processor::destroy
end on

type cb_note from commandbutton within w_smart_po
boolean visible = false
integer x = 768
integer y = 448
integer width = 1833
integer height = 592
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type dw_po_header from datawindow within w_smart_po
integer x = 535
integer y = 1008
integer width = 2318
integer height = 400
integer taborder = 80
string dragicon = "DRAG1PG.ICO"
string dataobject = "dw_po_header_for_crosstab"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String szShipType, &
		 ls_value 
 
If this.GetColumnName() = "ship_type" then
	setnull ( ls_value )
	setitem ( 1, "ship_to_destination", ls_value )
	szShipType	= this.GetText()
	bDropShip	= (szShipType = 'DropShip')

	this.SetTabOrder("plant", 70)
	wf_create_ship_to()

	SetNull(szPlant)
	wf_update_detail_plants(szPlant)

End If
	
If this.GetColumnName() = "plant" then
	szPlant		= this.GetText()
	bDropShip	= FALSE
	wf_update_detail_plants(szPlant)

	szShipType	= this.object.ship_type[row]
	bDropShip	= (szShipType = 'DropShip')
	wf_create_ship_to()

End If	
end event

on dragdrop;bCrosstab	= FALSE
bPOHeader	= FALSE
end on

event rbuttondown;Messagebox(monsys.msg_title, "This is the P.O. header information", Information!)
end event

event constructor;settransobject ( sqlca )
end event

type gb_2 from groupbox within w_smart_po
integer x = 526
integer y = 960
integer width = 2336
integer height = 464
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77897888
string text = "P.O. Header Information"
end type

type dw_crosstab from datawindow within w_smart_po
string tag = "crosstab"
integer x = 530
integer width = 2327
integer height = 948
integer taborder = 20
string dragicon = "DRAG1PG.ICO"
string dataobject = "dw_crosstab_for_po_grid"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer 	li_col

string 	ls_col

if row > 0 then
	
	dw_crosstab.SelectRow(Row, TRUE)		// ZZ
	li_col = Getclickedcolumn()
	
	if dwo.name <> 'part'  and li_col > 3 and li_col <= 11 then
		
			nQty		= GetItemNumber ( Row, li_Col)

			If bVendorMode then

				szPart		= object.part [ row ]
				
			Else
				
				szVendor		= object.part [ row ]
				iPO			= object.po_number [ row ]
				dw_po_header.Retrieve(iPO)
				bDropShip	= (dw_po_header.GetItemString(1, "ship_type") = 'DropShip')
				szPlant		= dw_po_header.GetItemString(1, "plant") 

				wf_create_ship_to()
		
				If lb_price_search.visible	then
					wf_show_price_matrix(szVendor, szPart, this.PointerX(), this.PointerY())
				End If
				
			End If

			bPastDue	= ( li_Col = 4 )
			dDate	= RelativeDate ( ddate1, ( li_Col - 5 ) )
	
			this.Drag(Begin!)
	
	end if	
	
end if



end event

event constructor;settransobject ( sqlca )
end event

event doubleclicked;Pointer pOrigPointer

Integer	li_col

St_generic_structure lst_parm

pOrigPointer	= SetPointer(HourGlass!)
li_col			= GetClickedColumn ()

if iPO = 0 or dw_po_header.RowCount() <= 0  or rowcount() <= 0 then return

if bVendorMode then

	if dwo.name = 'part' then

		szPart	=  GetItemString ( Row, "part" )
		
		if f_valid_part_number(szPart) and f_get_part_info(szPart, "CLASS") <> "N" then
			MessageBox(monsys.msg_title, "You have just double clicked on a recurring part. To access recurring part information, simply double click anywhere on the grid within the part's row.  If you wish to create a non-recurring part, please click in the empty field at the bottom of the grid.", Information!)
			Return
		End If

		lst_parm.value1 = string ( iPO )
		lst_parm.value2 = szPart
      OpenWithParm ( w_non_recurring_item, lst_parm )

	End If

End If

OpenUserObject(uo_print, 842, 193)
uo_print.cbx_freeze.checked	= FALSE 

If ( Row > 0) And ( li_Col > 3 ) then
	
	If bVendorMode then
		szPart		= GetItemString ( Row, "part")
	Else
		szVendor		= GetItemString ( Row, "part")
	End If

	nQty				= GetItemNumber ( Row, li_Col)

	If iPO = 0 then
		
		MessageBox(monsys.msg_title, "You must click save button to create a new PO first", StopSign!)
		
	Else		
		
		lst_parm.value1	= String(iPO)		
		lst_parm.value2	= szPart
		lst_parm.value3	= dw_po_header.GetItemString(1, "ship_to_destination")
		lst_parm.value4	= dw_po_header.GetItemString(1, "terms")
		lst_parm.value5	= dw_po_header.GetItemString(1, "ship_type")
		lst_parm.value6	= dw_po_header.GetItemString(1, "plant")
		lst_parm.value7	= szVendor
		lst_parm.value8	= String(f_get_value(dw_po_header.GetItemNumber(1, "release_no")))
		lst_parm.value9	= dw_po_header.getItemString(1, "ship_via")
		lst_parm.value10 = String(dDate7)
//		OpenSheetWithParm(w_smart_po_detail_entry_version3, lst_parm, gnv_App.of_GetFrame(), 0, Original!)
//		w_smart_po_detail_entry_version3.wf_get_host_window(w_smart_po)
		
	End If
	
End If

SetPointer(pOrigPointer)	
end event

event rbuttondown;MessageBox(monsys.msg_title, "Double click to view/edit releases. Dragdrop to receiving dock to start receving", Information!)
end event


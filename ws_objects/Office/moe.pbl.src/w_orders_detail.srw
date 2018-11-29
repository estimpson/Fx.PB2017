$PBExportHeader$w_orders_detail.srw
$PBExportComments$moe
forward
global type w_orders_detail from w_sheet_4t
end type
type st_10 from statictext within w_orders_detail
end type
type st_9 from statictext within w_orders_detail
end type
type st_8 from statictext within w_orders_detail
end type
type st_7 from statictext within w_orders_detail
end type
type st_6 from statictext within w_orders_detail
end type
type rb_customerpart from radiobutton within w_orders_detail
end type
type rb_internalpart from radiobutton within w_orders_detail
end type
type dw_pc_su from datawindow within w_orders_detail
end type
type cb_notes_ok from commandbutton within w_orders_detail
end type
type cb_selectall from commandbutton within w_orders_detail
end type
type cb_get_profile from commandbutton within w_orders_detail
end type
type pb_2 from picturebutton within w_orders_detail
end type
type pb_1 from picturebutton within w_orders_detail
end type
type dw_price_matrix from datawindow within w_orders_detail
end type
type sle_package_unit from singlelineedit within w_orders_detail
end type
type dw_detail from datawindow within w_orders_detail
end type
type cb_popup_availability from commandbutton within w_orders_detail
end type
type cb_popup_save from commandbutton within w_orders_detail
end type
type cb_popup_exit from commandbutton within w_orders_detail
end type
type p_1 from picture within w_orders_detail
end type
type st_5 from statictext within w_orders_detail
end type
type st_4 from statictext within w_orders_detail
end type
type p_3 from picture within w_orders_detail
end type
type p_2 from picture within w_orders_detail
end type
type dw_order_detail_notes from datawindow within w_orders_detail
end type
type lb_1 from listbox within w_orders_detail
end type
type st_2 from statictext within w_orders_detail
end type
type dw_detail_taxable from datawindow within w_orders_detail
end type
type st_notes from statictext within w_orders_detail
end type
type mle_notes from multilineedit within w_orders_detail
end type
type cb_popup_drop_ship from commandbutton within w_orders_detail
end type
type uo_notes from uo_notes_entry within w_orders_detail
end type
type dw_header from datawindow within w_orders_detail
end type
type uo_shipper_header from u_create_shipper_header within w_orders_detail
end type
type cb_notes from commandbutton within w_orders_detail
end type
type cb_notes_cancel from commandbutton within w_orders_detail
end type
type gb_3 from groupbox within w_orders_detail
end type
type gb_4 from groupbox within w_orders_detail
end type
type dw_detail_info from datawindow within w_orders_detail
end type
type cb_1 from commandbutton within w_orders_detail
end type
type cb_background from commandbutton within w_orders_detail
end type
type st_3 from statictext within w_orders_detail
end type
type rb_2 from radiobutton within w_orders_detail
end type
type rb_1 from radiobutton within w_orders_detail
end type
type st_1 from statictext within w_orders_detail
end type
type em_3 from editmask within w_orders_detail
end type
type em_2 from editmask within w_orders_detail
end type
type em_4 from editmask within w_orders_detail
end type
type em_1 from editmask within w_orders_detail
end type
end forward

global type w_orders_detail from w_sheet_4t
integer height = 1560
string title = "Sales Order Detail"
string menuname = "m_normal_order_main"
event add_new_item pbm_custom01
event edit_note pbm_custom02
event save_item pbm_custom03
event delete_item pbm_custom04
event print_item pbm_custom05
event availability pbm_custom06
event create_shipper pbm_custom07
event create_shipper_header pbm_custom08
event close_shipper_uo pbm_custom09
event save_note pbm_custom10
event close_uo_note pbm_custom12
event ue_order_promise_date pbm_custom13
event ue_retrieve_detail pbm_custom14
event print_work_order pbm_custom15
event ue_exit pbm_custom16
event ue_unapproved_message ( )
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
rb_customerpart rb_customerpart
rb_internalpart rb_internalpart
dw_pc_su dw_pc_su
cb_notes_ok cb_notes_ok
cb_selectall cb_selectall
cb_get_profile cb_get_profile
pb_2 pb_2
pb_1 pb_1
dw_price_matrix dw_price_matrix
sle_package_unit sle_package_unit
dw_detail dw_detail
cb_popup_availability cb_popup_availability
cb_popup_save cb_popup_save
cb_popup_exit cb_popup_exit
p_1 p_1
st_5 st_5
st_4 st_4
p_3 p_3
p_2 p_2
dw_order_detail_notes dw_order_detail_notes
lb_1 lb_1
st_2 st_2
dw_detail_taxable dw_detail_taxable
st_notes st_notes
mle_notes mle_notes
cb_popup_drop_ship cb_popup_drop_ship
uo_notes uo_notes
dw_header dw_header
uo_shipper_header uo_shipper_header
cb_notes cb_notes
cb_notes_cancel cb_notes_cancel
gb_3 gb_3
gb_4 gb_4
dw_detail_info dw_detail_info
cb_1 cb_1
cb_background cb_background
st_3 st_3
rb_2 rb_2
rb_1 rb_1
st_1 st_1
em_3 em_3
em_2 em_2
em_4 em_4
em_1 em_1
end type
global w_orders_detail w_orders_detail

type variables
String 			szCustomer
String			szDestination
String			szPart
String 			szDescription
String			cType
String			szUnit
String			szOriginalUnit
String			szDesc
String			szStdUnit
String			is_OriginalShipType
String			szHeadNote
String			is_Part_without_Suffix
string			is_inv_reg_col,&
			is_price_type
Long			lSeq
Long   			lIssue
Long			lQty
Long 			lOrder
Long			lFlag
Long   			lCurrentRow
Long   			lRowId
Long			iShipper
long			il_maxrowid
st_generic_structure 	stParm
st_return_units_for_part 	stUnitParm
Dec 	{6}		dPrice
Dec			dTaxRate
Dec			dBreakQty
Dec			dQty
Dec 			dOriginalQty
Dec			dStdQty
Int 			iSequence
Date 			dOrderDate
Date			dDueDate
DataWindowChild 		dwcOEUnits
Boolean 			bOpen
Boolean			bHeaderNotes
Boolean			bAddDetail
Boolean			bDetailUO
Boolean			bReset
Boolean			bDblClick
Boolean			bMiniCop
Boolean			ib_Changed = FALSE
Boolean			ib_ship_saved = FALSE
Boolean			bShowSearch = True
Boolean                               bDesterror = False
Boolean                               bShowAll = True
Boolean                               ib_Add = False
boolean			ib_selectall = TRUE
str_super_cop_parms            istr_super_cop_parms
st_dda_parmlist                      st_prmlst
boolean			ib_getprofile
boolean	ib_fromquotes=FALSE

end variables

forward prototypes
public subroutine wf_screen_attrib (boolean bmode)
public subroutine wf_show_price_matrix ()
public subroutine wf_popup (boolean bmode, string sztype)
public subroutine wf_re_sequence ()
public subroutine wf_header_notes (boolean bmode)
public subroutine wf_detail_popup (boolean bmode, long lorder_f, long lrowid_f, string szcustomer_f, string szdestination_f, long lnextseq, boolean bshowquicksearch, string szaddingpart, string szheadplant)
public subroutine wf_unit_list (string szpartnumber)
public subroutine wf_set_tab (string ls_addingpart)
public function boolean wf_part_exists (string ls_part, long ll_OrderNo)
public subroutine wf_set_screen_tab_order (string ls_type)
public function decimal wf_find_break (decimal dquantity, boolean bviewonly)
public function boolean wf_get_profile (string as_customer)
public function decimal wf_get_price (ref datawindow adw_sourcedw, string as_price_type)
public function decimal wf_recalc_prices (string ls_part, string ls_customer)
public function long wf_create_order_from_quote (long a_l_quote)
public function boolean wf_create_shipper_detail (long a_l_shipper, long a_l_row)
public function boolean wf_suffix (long a_l_order, string a_s_part)
public subroutine wf_setup_values_part (string a_s_part, string a_s_desc)
public subroutine wf_updatedestinall (string as_dest, string as_olddest, string as_customer)
end prototypes

event add_new_item;String	ls_TabSequence

If lOrder = -1 Then
	MessageBox ( monsys.msg_title, "You must enter and save header information before you add order detail.", StopSign! )
	Return
End if

ib_Add = TRUE

wf_screen_attrib ( False )
wf_detail_popup ( True, lOrder, 0, szCustomer, szDestination, dw_detail.RowCount ( ) + 1, True, "" , dw_header.GetItemString(1, "plant") )


end event

event save_item;//	Declarations
String	szPlants
String	ls_Destination
String	ls_PlantRequired
Int	iRtnCode,&
	li_count
boolean	lb_ask_zero_qty
long	ll_row
String	ls_olddest, l_s_dest
string	ls_customer

szPlants = f_get_string_value ( dw_header.GetItemString ( 1, "Plant" ) )
SELECT	plant_required
INTO	:ls_PlantRequired
FROM	parameters;
If (ls_PlantRequired = 'Y' And szPlants = "") and not(ib_fromquotes) Then
	MessageBox ( monsys.msg_title, "You must select a plant.", StopSign! )
	dw_header.SetColumn ( "plant" )
	dw_header.SetFocus ( )
	Return
End If
If szDestination = dw_header.GetItemString (1, "destination" ) Then
	If Not f_valid_destination(szDestination) Then	
		bdesterror = True
	End If
End If
If f_get_string_value ( dw_header.GetItemString ( 1, "destination" ) ) = "" OR + &
	bdesterror Then
	MessageBox ( monsys.msg_title, "Enter a valid destination.", StopSign! )
	bdesterror = True
	Return
End if
If lOrder < 0 Then
	if not sqlca.of_getnextparmvalue ( "sales_order", lOrder ) then    // Failed to get current value 				-  ADD 01-27-2000 KAZ
		Rollback;																																// ADD 01-27-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new Sales Order number, Please try again", Exclamation! )	// ADD 01-27-2000 KAZ
		lOrder	= 0																															// ADD 01-27-2000 KAZ
		Return																																	// ADD 01-27-2000 KAZ
	end if																																		// ADD 01-27-2000 KAZ
	dw_header.SetItem ( 1, "order_no", lOrder )
	dw_header.SetItem ( 1, "type", 'N' )

	If dw_header.Update ( ) = -1 Then
		RollBack ;
		lOrder = 0
		ib_Changed = TRUE
		MessageBox ( monsys.msg_title, SQLCA.SQLErrText, Information! )
		Return
	Else
		Commit ;
		ll_row = dw_header.Retrieve ( lOrder )
		ib_Changed = False
		lFlag = 0
		szDestination = dw_header.GetItemString ( 1, "destination" )
		szCustomer    = dw_header.GetItemString ( 1, "customer" )
		SELECT	salestax_rate  
		INTO	:dTaxRate  
		FROM	destination  
		WHERE	destination = :szDestination;
		if isnull(dTaxRate,0) > 0 then
			dTaxRate = dTaxRate / 100
		else
			dTaxRate = 0
		end if
		dw_detail.Enabled = True
	End if
	cb_get_profile.Enabled = TRUE
	rb_internalpart.Enabled = TRUE
	rb_customerpart.Enabled = TRUE
	if dw_header.GetItemString ( 1, "status_type" ) <> 'A' then
		MessageBox ( "Existing Order", "The order has been saved, however, this order's status is " + dw_header.GetItemString ( 1, "cs_status" ) + ".  You will be able to do everything except physically ship out the order.", Information! )
	end if
Else
	dw_detail.AcceptText ( )
	if dw_detail.RowCount ( ) > 0 then
		li_count = dw_detail.Find ( "quantity = 0 or weight = 0", 1, dw_detail.RowCount ( ) )
		if li_count > 0 then
			if dw_detail.GetItemNumber ( li_count, "quantity" ) = 0 or &
				dw_detail.GetItemNumber ( li_count, "weight" ) = 0 then &
				lb_ask_zero_qty = TRUE
		end if
	end if
	if lb_ask_zero_qty then
		if MessageBox (monsys.msg_title, "Would you like to delete the releases with a quantity/weight of 0?", Question!, YesNo!, 1 ) = 1 then
			datastore	lds_list
			lds_list = CREATE datastore
			lds_list.DataObject = "d_customer_getprofile_list"
			lds_list.SetTransObject ( sqlca )
			dw_detail.SetFilter ( "quantity = 0" )
			dw_detail.Filter ( )
			dw_detail.RowsMove ( 1, dw_detail.RowCount ( ), Primary!, lds_list, 1, Primary! )
			dw_detail.SetFilter ( "" )
			dw_detail.Filter ( )
			DESTROY lds_list
		end if
	end if
	dw_detail.Sort ( )
	wf_re_sequence ( )
	If dw_header.Update ( ) = -1 then
		RollBack ;
		ib_Changed = TRUE
		MessageBox ( monsys.msg_title, SQLCA.SQLErrText, Information! )
		Return
	Else
		ls_olddest = dw_header.object.destination.original[1]
		l_s_dest = dw_header.object.destination.current[1]
		ls_customer = dw_header.object.customer.current[1]

		if ls_olddest <> l_s_dest then wf_updatedestinall(l_s_dest, ls_olddest, ls_customer)			
		
		if dw_detail.update ( ) = -1 Then
			RollBack ;
			ib_Changed = True
		Else
			dw_detail.Retrieve ( lOrder )
			If f_ask_minicop ( ) Then
				If MessageBox(monsys.msg_title, "Do you want to run MiniCOP?", Question!, YesNo!) = 1 then				
					istr_super_cop_parms.a_regen_all = 'N'
					istr_super_cop_parms.a_order_no  = lorder
					OpenWithParm ( w_bom_explode , istr_super_cop_parms)         
					gnv_App.of_GetFrame().Setmicrohelp("System has successfully updated the information...")
				End if
			End If
			Commit ;
			ib_Changed = False
		End if
	End if
End if
if ib_getprofile then ib_getprofile = FALSE
gnv_App.of_GetFrame().Setmicrohelp("Ready")
gf_get_info ( 'w_orders_detail', 2 )

end event

event delete_item;Long		ll_Suffix
Long		ll_Dummy
Long		ll_Row
String	ls_Part

If lCurrentRow < 1 Then 
	MessageBox (monsys.msg_title, "First select the row you want to delete" )
	Return
End If

ll_Suffix 	= dw_detail.GetItemNumber ( lCurrentRow, "suffix" )
ls_Part		= dw_detail.GetItemString ( lCurrentRow, "part_number" )

If ll_Suffix < 1 Then

	SELECT shipper_detail.shipper  
	  INTO :ll_Dummy  
	  FROM shipper_detail,   
	       shipper  
	 WHERE ( shipper.id = shipper_detail.shipper ) AND
	       ( ( shipper_detail.part = :ls_Part ) AND
	       ( shipper_detail.order_no = :lOrder ) AND  
	       ( shipper.status = 'O' OR  
	       shipper.status = 'S' ) )   ;
		
Else

	ls_Part = ls_Part + "-" + String ( ll_Suffix )

	SELECT shipper_detail.shipper  
	  INTO :ll_Dummy  
	  FROM shipper_detail,   
	       shipper  
	 WHERE ( shipper.id = shipper_detail.shipper ) AND
	       ( ( shipper_detail.part = :ls_Part ) AND
	       ( shipper_detail.order_no = :lOrder ) AND  
	       ( shipper.status = 'O' OR  
	       shipper.status = 'S' ) )   ;

End if	

If SQLCA.SQLCode = 0 Then
	MessageBox ( monsys.msg_title, "You are trying to delete a release that is scheduled to a shipper!  You must first unschedule the release.", StopSign! )
	Return
End if


If MessageBox ( monsys.msg_title, "Are you sure about deleting item " + String ( lCurrentRow ), Question!, YesNo!, 2  ) = 1 Then
	
	dw_detail.DeleteRow ( lCurrentRow )

	if dw_detail.update ( ) = 1 then
		COMMIT ;
		lCurrentRow = 0
		dw_detail.Retrieve ( lOrder )
		wf_re_sequence ( )
	else
		ROLLBACK ;
	end if

End if


end event

on availability;st_generic_structure stSendParm

stSendParm.Value1 = szPart
stSendParm.Value2 = String ( lOrder )
//stSendParm.Value3 = dw_detail.GetItemString(1, "unit")
//stSendParm.Value4 = String(dw_detail.GetItemNumber(1, "price"))

OpenWithParm ( w_detail_info_of_demand_parm, stSendParm )
end on

event create_shipper;Long 		iRow
Long 		iTotalRows

String	l_s_Destination
String	l_s_Customer
String	l_s_Plant

Boolean	bOk	= FALSE

iTotalRows	= dw_detail.RowCount()
iRow			= 1

Do while (Not bOk) AND (iRow	<= iTotalRows)

	If dw_detail.IsSelected(iRow) then		
		bOK	= TRUE
	End If
	iRow ++
Loop

If bOk then
	if dw_header.GetItemString ( 1, "status_type" ) <> 'A' then
		MessageBox ( "Existing Order", "This order's status is " + dw_header.GetItemString ( 1, "cs_status" ) + ".  You will be able to do everything except physically ship out the order.", Information! )
	end if
	l_s_Destination					= dw_header.GetItemString(1, "destination")
	l_s_Customer						= dw_header.GetItemString(1, "customer")
	l_s_Plant							= dw_header.GetItemString(1, "plant")
	uo_shipper_header.visible	= TRUE
	uo_shipper_header.uf_setup(w_orders_detail, l_s_Destination, l_s_Customer, l_s_Plant)
Else
	MessageBox(monsys.msg_title, "Please use single click to highlight rows first.", StopSign!)
End If
end event

event create_shipper_header;/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'l_l_Shipper' (next Shipper number).  Also placed the  
						rollback before the message box to release the database to avoid deadlocks. */


Long 		l_l_Row
Long 		l_l_TotalRows

Long		l_l_Shipper

Boolean	bOk						= TRUE

//uo_shipper_header.visible		=  FALSE

//bFinish	= FALSE																							-  CHG 01-26-2000 KAZ
//OpenWithParm(w_get_parm_value, "shipper")															-  CHG 01-26-2000 KAZ
//Do While Not bFinish																						-  CHG 01-26-2000 KAZ
//Loop																											-  CHG 01-26-2000 KAZ
//
//l_l_Shipper	= Message.DoubleParm																		-  CHG 01-26-2000 KAZ

If uo_shipper_header.dw_shipper_header.AcceptText() < 1 Then
	ib_ship_saved = False
	Return
End If

//If l_l_Shipper > 0 then									-  CHG 01-26-2000 KAZ

if sqlca.of_getnextparmvalue ( "shipper", l_l_Shipper ) then    // Get current value 	 - ADD 01-26-2000 KAZ

	uo_shipper_header.dw_shipper_header.SetItem(1, "id", l_l_Shipper)
	uo_shipper_header.dw_shipper_header.SetItem(1, "notes", szHeadNote)
	uo_shipper_header.dw_shipper_header.SetItem(1, "currency_unit", dw_header.GetItemString ( 1, "currency_unit" ) )
	
	bOK	= (uo_shipper_header.dw_shipper_header.Update() > 0)

	If bOK then
		l_l_TotalRows	= dw_detail.RowCount()
		l_l_Row			= 1

		Do while bOk AND (l_l_Row	<= l_l_TotalRows)

			If dw_detail.IsSelected(l_l_Row) then		
				bOk 	= wf_create_shipper_detail(l_l_Shipper, l_l_Row)
				dw_detail.SelectRow(l_l_Row, FALSE)
			End If
			l_l_Row ++
		Loop
	End If

	If bOk then
		Commit;
		ib_ship_saved = TRUE
		MessageBox(monsys.msg_title, "Shipper " + String(l_l_Shipper) + " has been created successfully.", StopSign!)
		uo_shipper_header.visible		=  FALSE
		dw_detail.Retrieve ( lOrder )
	Else
		Rollback;																								// CHG 01-26-2000 KAZ
		MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
//		Rollback;																								-  CHG 01-26-2000 KAZ
		ib_ship_saved = False
	End If

Else
	Rollback;																									// ADD 01-26-2000 KAZ
	MessageBox(monsys.msg_title, "Can not generate new shipper number.", StopSign!)
	l_l_Shipper	= 0
	ib_ship_saved = False
End If

end event

event close_shipper_uo;Integer i_mess1
If ib_ship_saved = False Then
	i_mess1 = Messagebox (monsys.msg_title, "Do you want to save shipper?", Exclamation!, YesNoCancel!, 1)

	If i_mess1 = 1 Then
		w_orders_detail.TriggerEvent ("create_shipper_header")
		If ib_ship_saved = True Then
			uo_shipper_header.visible		=  FALSE
		Else
			Return
		End If
	Elseif i_mess1 = 2 Then
		ib_ship_saved = False
		uo_shipper_header.visible		=  FALSE
	Else
		Return
	End If
End If

uo_shipper_header.visible		=  FALSE
end event

on save_note;szHeadNote	= uo_shipper_header.uo_header_note.mle_note.text
uo_shipper_header.uo_header_note.visible	= FALSE
uo_shipper_header.cb_save.visible				= TRUE
uo_shipper_header.cb_exit.visible				= TRUE

If szHeadNote > " " then
	uo_shipper_header.p_note.PictureName		= "noteyes.bmp"
Else
	uo_shipper_header.p_note.PictureName		= "noteno.bmp"
End If
uo_shipper_header.szHeadNote					= szHeadNote

end on

on close_uo_note;uo_shipper_header.uo_header_note.visible	= FALSE
uo_shipper_header.cb_save.visible				= TRUE
uo_shipper_header.cb_exit.visible				= TRUE
uo_shipper_header.p_note.PictureName			= "noteyes.bmp"
end on

event ue_order_promise_date;/*
Description		:To open the order promise date processor
Author			:Jim Wu
Start Date		:01/26/96
Modification	:02/13/96
					Added the value check to lCurrentRow
*/

/* Declaration */
st_generic_structure lstr_Parm

/* Initialization */

/* Modification */
If lCurrentRow > 0 Then

	lstr_Parm.value1	= String(lOrder)
	lstr_Parm.value2	= String(dw_detail.GetItemNumber(lCurrentRow, "row_id"))

	OpenSheetWithParm(w_order_promise_date_processor, lstr_Parm, gnv_App.of_GetFrame(), 3, Original!)

	w_order_promise_date_processor.wf_get_parent_window(w_orders_detail)

Else
	MessageBox ( monsys.msg_title, "Please select a detail line first.", StopSign! )
End if

end event

on ue_retrieve_detail;/* 
Description	:To retrieve the datawindow again after the promise date being
				 saved.
Author		:Jim Wu
Start Date	:1/26/96
Modification:
*/

/* Declaration */

/* Initialization */

/* Main Process */
dw_detail.Retrieve(lOrder)

end on

event print_work_order;
n_cst_associative_array	lnv_Parm
lnv_Parm.of_SetItem("Report", "Sales Order - Normal")
lnv_Parm.of_SetItem("Arg1", lOrder)
Print (lnv_Parm)


gf_get_info ( 'w_orders_detail', 1 )

end event

event ue_unapproved_message;MessageBox ( "Existing Order", "This order's status is " + dw_header.GetItemString ( 1, "cs_status" ) + ".  You will be able to do everything except physically ship out the order.", Information! )

end event

public subroutine wf_screen_attrib (boolean bmode);dw_header.Enabled = bMode
dw_detail.Enabled = bMode
rb_1.Enabled      = bMode
rb_2.Enabled 		= bMode
p_1.Enabled			= bMode
m_normal_order_main.m_file.m_add.Enabled = bMode
m_normal_order_main.m_file.m_delete.Enabled = bMode
m_normal_order_main.m_file.m_save.Enabled = bMode
m_normal_order_main.m_file.m_print.Enabled = bMode
m_normal_order_main.m_file.m_ship.Enabled = bMode
m_normal_order_main.m_file.m_close.Enabled = bMode

end subroutine

public subroutine wf_show_price_matrix ();
end subroutine

public subroutine wf_popup (boolean bmode, string sztype);//If bMode Then
//	wf_screen_attrib ( False )
//	cb_popup.Show ( )
//	cb_popup_save.Show ( )
//	cb_popup_cancel.Show ( )
//	If szType = "current" Then
//		dw_popup_detail.DataObject = "d_normal_order_detail_info"
//		cb_popup_drop_ship.Show ( )
//		cb_popup_availability.Show ( )
//		dw_popup_detail.SetTransObject ( sqlca )
//		dw_popup_detail.Retrieve ( lOrder, lRowId )
//		wf_show_price_matrix ( )
//	Else
//		bAddDetail = True
//		dw_popup_detail.DataObject = "d_normal_order_detail_info_add"
//		dw_popup_detail.Reset ( )
//		dw_popup_detail.SetTransObject ( sqlca )
//		dw_popup_detail.InsertRow ( 1 )
//		dw_popup_detail.SetItem ( 1, "sequence", dw_detail.RowCount ( ) + 1 )
//		dw_popup_detail.SetItem ( 1, "row_id", f_get_random_number ( ) )
//		dw_popup_detail.SetItem ( 1, "order_no", lOrder )
//		dw_popup_detail.SetItem ( 1, "status", 'O' )
//		dw_popup_detail.SetItem ( 1, "due_date", Today ( ) )
//	End if
//	dw_popup_detail.Show ( )
//	dw_price_matrix.Show ( )
//	st_popup_title.Show ( )
//	dw_popup_detail.SetFocus ( )
//Else
//	cb_popup_save.Hide ( )
//	cb_popup_cancel.Hide ( )
//	cb_popup_drop_ship.Hide ( )
//	cb_popup_availability.Hide ( )
//	dw_popup_detail.Hide ( )
//	dw_price_matrix.Hide ( )
//	st_popup_title.Hide ( )
//	cb_popup.Hide ( )
//	wf_screen_attrib ( True )
//	dw_detail.Retrieve ( lOrder, dTaxRate )
//End if
end subroutine

public subroutine wf_re_sequence ();Int iCount

For iCount = 1 to dw_detail.RowCount ( )
	dw_detail.SetItem ( iCount, "sequence", iCount )
Next

If dw_detail.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
End if
end subroutine

public subroutine wf_header_notes (boolean bmode);If bMode Then
	wf_set_screen_tab_order ( "Notes" )
   SELECT order_header.notes  
     INTO :mle_notes.Text  
     FROM order_header  
    WHERE order_header.order_no = :lOrder   ;
	cb_notes.Show ( )
	cb_notes_ok.Show ( )
	cb_notes_cancel.Show ( )
	st_notes.Show ( )
	mle_notes.Show ( )
	mle_notes.SetFocus ( )
Else
	wf_set_screen_tab_order ( "Main" )
	cb_notes_ok.Hide ( )


	cb_notes_cancel.Hide ( )
	st_notes.Hide ( )
	mle_notes.Hide ( )
	cb_notes.Hide ( )
End if

end subroutine

public subroutine wf_detail_popup (boolean bmode, long lorder_f, long lrowid_f, string szcustomer_f, string szdestination_f, long lnextseq, boolean bshowquicksearch, string szaddingpart, string szheadplant);datawindowchild	ldwc_dddw

If bMode Then

	String	       ls_PlantRequired
	String          s_Package
	String          s_PackageType
	String		    s_PackageUnit
	Int		       li_TabOrder
	Long		       ll_Dummy
	Long		       ll_Suffix
	Boolean         b_Search
	DataWindowChild dwc_Package, &
						 dwc_Type

	//  Reset Variables and datawindows

	szPart					= ""
	szDestination			= ""
	szCustomer				= ""
	szUnit					= ""
	szOriginalUnit			= ""
	szDesc					= ""
	szStdUnit				= ""
	is_OriginalShipType	= ""
	lSeq						= 0
	lOrder					= 0
	lRowId					= 0
	dPrice					= 0
	dBreakQty				= 0
	dQty						= 0
	dOriginalQty			= 0
	dStdQty					= 0
	dDueDate					= Today ( )
	bDblClick				= False
	bMiniCop					= False

	dw_detail_info.SetFocus ( )

	dw_detail_info.SetTransObject ( SQLCA )
	dw_detail_info.GetChild ( "unit", dwcUnits )

	wf_set_tab ( szAddingPart )

	szCustomer = szCustomer_f
	szDestination = szDestination_f
	lOrder = lOrder_f
	lRowId = f_get_value ( lRowId_f )
	lSeq   = lNextSeq

	dw_price_matrix.Reset ( )

	dw_detail_info.GetChild ( "customer_part", ldwc_dddw )
	if ldwc_dddw.Retrieve ( dw_header.GetItemString ( 1, "customer" ) ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if

	If lRowId = 0 Then
		dw_detail_info.Reset ( )
		dw_detail_info.InsertRow ( 1 )
		
		if isdate ( String ( Date ( dw_header.GetItemDateTime ( 1, "due_date" ) ) ) ) then
			dw_detail_info.SetItem ( 1, "due_date", dw_header.GetItemDateTime ( 1, "due_date" ) )
		else
			dw_detail_info.SetItem ( 1, "due_date", Today ( ) )
		end if

		If szAddingPart <> "" Then
	
			dw_detail_info.Modify ( "part_number.TabSequence=0" )
			dw_detail_info.SetItem ( 1, "part_number", szAddingPart )
	
		   SELECT name  
		     INTO :szDesc  
		     FROM part  
		    WHERE part = :szAddingPart   ;
		
			If SQLCA.SQLCode <> 0 Then
				MessageBox ( monsys.msg_title, "Invalid part number!", StopSign! )
				dw_detail_info.SetColumn ( "part_number" )
				dw_detail_info.SetItem ( 1, "part_number", "" )
				Return
			End if
		
			dw_detail_info.SetItem ( 1, "product_name", szDesc )
		
			If dw_price_matrix.Retrieve ( szAddingPart, szCustomer, dw_header.GetItemString ( 1, "currency_unit" ) ) < 1 Then
				SELECT price
			     INTO :dPrice  
			     FROM part_standard  
			    WHERE part = :szAddingPart   ;
				If SQLCA.SQLCode = 0 Then
					sqlca.of_calculate_multicurrency_price ( '', dw_header.GetItemString ( 1, "currency_unit" ), dPrice, dPrice )
					dw_detail_info.SetItem ( 1, "price", dPrice )
				End if
			End if
		
   		SELECT standard_unit  
		     INTO :szStdUnit  
		     FROM part_inventory  
		    WHERE part = :szAddingPart   ;
		
			dw_detail_info.SetItem ( 1, "unit", szStdUnit )	
		
			wf_unit_list ( szPart )
	
			szPart = szAddingPart

			s_PackageType = dw_detail_info.GetItemString ( 1, "packaging_type" )

			SELECT unit
			  INTO :s_PackageUnit
		  	  FROM part_packaging
			 WHERE part = :szPart AND
					 code = :s_PackageType	;

			IF NOT IsNull ( s_PackageUnit ) OR s_PackageUnit <> "" THEN
				sle_package_unit.Text = s_PackageUnit
			END IF
	
		End if
	
		dw_detail_info.SetItem ( 1, "status", 'O' )
		dw_detail_info.SetItem ( 1, "order_no", lOrder_f )
		dw_detail_info.SetItem ( 1, "sequence", lNextSeq )
		dw_detail_info.SetItem ( 1, "week_no", f_get_week_no ( Today ( ) ) )
		dw_detail_info.SetItem ( 1, "plant", szHeadPlant)
		
	Else
		
		if dw_detail.GetItemDecimal(dw_detail.GetRow ( ), "quantity") <= dw_detail.GetItemDecimal(dw_detail.GetRow ( ), "committed_qty") then
			cb_popup_save.Enabled = FALSE
		end if

		bDblClick = True

		dw_detail_info.Modify ( "part_number.TabSequence=0" )
		If dw_detail_info.Retrieve ( lOrder_f, lRowId_f ) > 0 Then
			szPart 	= dw_detail_info.GetItemString ( 1, "part_number" )
			is_part_without_suffix = szPart
			szUnit 	= dw_detail_info.GetItemString ( 1, "unit" )
			szOriginalUnit = szUnit
			szDesc 	= dw_detail_info.GetItemString ( 1, "product_name" )
			dQty	 	= dw_detail_info.GetItemNumber ( 1, "quantity" )
			dOriginalQty = dQty
			dStdQty 	= dw_detail_info.GetItemNumber ( 1, "std_qty" )
			dPrice	= dw_detail_info.GetItemNumber ( 1, "price" )
			dDueDate = Date ( dw_detail_info.GetItemDateTime ( 1, "due_date" ) )
			ll_Suffix = f_get_value ( dw_detail_info.GetItemNumber ( 1, "suffix" ) )
			is_OriginalShipType = dw_detail_info.GetItemString ( 1, "ship_type" )
			dw_price_matrix.Retrieve ( szPart, szCustomer_f, dw_header.GetItemString ( 1, "currency_unit" ) )	
			If f_get_value ( dw_detail_info.GetItemNumber ( 1, "suffix" ) ) > 0 Then &
				dw_detail_info.Modify ( "notes.TabSequence=0" )

			s_PackageType = dw_detail_info.GetItemString ( 1, "packaging_type" )

			SELECT unit
			  INTO :s_PackageUnit
		  	  FROM part_packaging
			 WHERE part = :szPart AND
					 code = :s_PackageType	;

			IF NOT IsNull ( s_PackageUnit ) OR s_PackageUnit <> "" THEN
				sle_package_unit.Text = s_PackageUnit
			END IF

			dw_detail_info.GetChild ( "packaging_type", dwc_Package )
			dwc_Package.SetTransObject ( SQLCA )
			dwc_Package.Reset ( )

			DECLARE package_list CURSOR FOR
			 SELECT code
				FROM part_packaging
			  WHERE part = :szPart
			ORDER BY code ASC	;

			Open package_list	;

			DO
				FETCH package_list INTO :s_Package	;
				IF SQLCA.SQLCode = 0 THEN
					dwc_Package.InsertRow ( 0 )
					dwc_Package.SetItem ( dwc_Package.RowCount ( ), "code", s_Package )
				END IF
			LOOP WHILE SQLCA.SQLCode = 0

			Close package_list	;
	
			If ll_Suffix < 1 Then

				SELECT shipper_detail.shipper  
				  INTO :ll_Dummy  
				  FROM shipper_detail,   
				       shipper  
				 WHERE ( shipper.id = shipper_detail.shipper ) AND
				       ( ( shipper_detail.part = :szPart ) AND
				       ( shipper_detail.order_no = :lOrder ) AND  
				       ( shipper.status = 'O' OR  
				       shipper.status = 'S' ) )   ;
		
			Else

				szPart = szPart + "-" + String ( ll_Suffix )

				SELECT shipper_detail.shipper  
				  INTO :ll_Dummy  
				  FROM shipper_detail,   
				       shipper  
				 WHERE ( shipper.id = shipper_detail.shipper ) AND
				       ( ( shipper_detail.part = :szPart ) AND
				       ( shipper_detail.order_no = :lOrder ) AND  
				       ( shipper.status = 'O' OR  
				       shipper.status = 'S' ) )   ;

			End if	

			If SQLCA.SQLCode = 0 Then
				dw_detail_info.Modify ( "part_number.TabSequence=0" )
				dw_detail_info.Modify ( "customer_part.TabSequence=0" )
				dw_detail_info.Modify ( "product_name.TabSequence=0" )
				dw_detail_info.Modify ( "due_date.TabSequence=0" )
				dw_detail_info.Modify ( "quantity.TabSequence=0" )
				dw_detail_info.Modify ( "unit.TabSequence=0" )
				dw_detail_info.Modify ( "price.TabSequence=0" )
				dw_detail_info.Modify ( "plant.TabSequence=0" )
				dw_detail_info.Modify ( "release_no.TabSequence=0" )
				dw_detail_info.Modify ( "packaging_type.TabSequence=0" )
				dw_detail_info.Modify ( "ship_type.TabSequence=0" )
				dw_detail_info.Modify ( "group_no.TabSequence=0" )
				dw_detail_info.Modify ( "notes.TabSequence=0" )
				dw_detail_info.Modify ( "weight.TabSequence=0" )
				dw_detail_info.Modify ( "type.TabSequence=0" )
				dw_price_matrix.Enabled = False
				wf_find_break ( dQty, True )
			Else
				wf_find_break ( dQty, False )
				wf_set_tab ( szAddingPart )
				dw_price_matrix.Enabled = True
				wf_unit_list ( szPart )
			End if
	
		Else
			MessageBox ( monsys.msg_title, "An error occurred while retrieving data!", StopSign! )
	 		Return
		End if
	End if
	
	If f_get_string_value ( dw_detail_info.GetItemString ( 1, "ship_type" ) ) = "" Then
		dw_detail_info.SetItem ( 1, "ship_type", 'N' )
		If lRowId <> 0 Then
			dw_detail_info.Update ( )
			Commit ;
		Else
			lRowId = lRowId_f
		End if
	End if
	
	wf_screen_attrib ( False )

	dw_detail_info.SetFocus ( )

	cb_background.x = 352
	cb_background.y = 9
	st_2.x = 371
	st_2.y = 25
	dw_detail_info.x = 430
	dw_detail_info.y = 89
	dw_price_matrix.x = dw_detail_info.x + 9
	dw_price_matrix.y = dw_detail_info.y + 832
	cb_popup_availability.x = cb_background.x + cb_background.width - 400 //2120
	cb_popup_availability.y = cb_background.height - 125 //1241
	cb_popup_save.x = dw_detail_info.x //439
	cb_popup_save.y = cb_popup_availability.y //1241
	cb_popup_exit.x = dw_detail_info.x + cb_popup_save.width + 50 //859
	cb_popup_exit.y = cb_popup_availability.y //1241
	pb_1.x = 874 //1798
	pb_1.y = 39 //119
	pb_2.x = 874 //1798
	pb_2.y = 39 //119
	sle_package_unit.x = 2357
	sle_package_unit.y = 436//502
	cb_background.Show ( )
	st_2.Show ( )
	cb_popup_availability.Show ( )
	cb_popup_save.Show ( )
	cb_popup_exit.Show ( )
	dw_detail_info.Show ( )
	dw_price_matrix.Show ( )
	sle_package_unit.Show ( )
	cb_background.BringToTop = True
	st_2.BringToTop = True
	cb_popup_availability.BringToTop = True
	cb_popup_save.BringToTop = True
	cb_popup_exit.BringToTop = True
	dw_detail_info.BringToTop = True
	dw_price_matrix.BringToTop = True
	sle_package_unit.BringToTop = True
	wf_set_screen_tab_order ( "Detail" )
	If bShowSearch OR ib_Add Then
		pb_1.Show ( )	
		pb_1.Show ( )
		pb_1.BringToTop = True
		b_Search = TRUE
	Else
		pb_1.Hide ( )	
		pb_1.Hide ( )
		pb_1.BringToTop = False
		b_Search = FALSE
	End if
	IF bShowAll AND NOT b_Search AND NOT ib_Add THEN
		pb_2.Show ( )
		pb_2.Show ( )
		pb_2.BringToTop = TRUE
	ELSE
		pb_2.Hide ( )	
		pb_2.Hide ( )
		pb_2.BringToTop = False
	END IF
//	If bShowQuickSearch then 
//		cb_quick_search.Show ( )
//		cb_quick_search.BringToTop = True
//	End if
Else
	st_2.Hide ( )
	cb_popup_availability.Hide ( )
	cb_popup_save.Hide ( )
	cb_popup_exit.Hide ( )
	dw_detail_info.Hide ( )
	dw_price_matrix.Hide ( )
	pb_1.Hide ( )
	pb_2.Hide ( )
	cb_background.Hide ( )
	sle_package_unit.Hide ( )
	rb_2.BringToTop = TRUE
	wf_screen_attrib ( True )
	wf_set_screen_tab_order ( "Main" )
	dw_header.Retrieve ( lOrder )
End if


end subroutine

public subroutine wf_unit_list (string szpartnumber);Int 	iCount

dwcUnits.Reset ( )
lb_1.Reset ( )

lb_1 = f_get_units_for_part ( "", szPart, lb_1 )

For iCount = 1 to lb_1.TotalItems ( )
	dwcUnits.InsertRow ( 0 )
	lb_1.SelectItem ( iCount )
	dwcUnits.SetItem ( dwcUnits.RowCount ( ), "data", lb_1.SelectedItem ( ) )
Next 

end subroutine

public subroutine wf_set_tab (string ls_addingpart);String	ls_PlantRequired
Int		li_TabOrder

SELECT parameters.plant_required  
  INTO :ls_PlantRequired  
  FROM parameters  ;

If ls_AddingPart <> "" Then
	li_TabOrder = 0
Else
	li_TabOrder = 10
End if
dw_detail_info.Modify ( "part_number.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "product_name.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "customer_part.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "due_date.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "quantity.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "unit.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "weight.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "price.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "box_label.TabSequence=" + String ( li_TabOrder ) )
If f_get_string_value ( ls_PlantRequired ) = 'Y' Then
	li_TabOrder = li_TabOrder + 10
	dw_detail_info.Modify ( "plant.TabSequence=" + String ( li_TabOrder ) )
Else
	dw_detail_info.Modify ( "plant.TabSequence=0" )
End if
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "type.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "release_no.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "packaging_type.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "ship_type.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "group_no.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "pallet_label.TabSequence=" + String ( li_TabOrder ) )
li_TabOrder = li_TabOrder + 10
dw_detail_info.Modify ( "notes.TabSequence=" + String ( li_TabOrder ) )

end subroutine

public function boolean wf_part_exists (string ls_part, long ll_OrderNo);Long	ll_Dummy

SELECT order_no  
  INTO :ll_Dummy
  FROM order_detail
 WHERE ( order_no = :ll_OrderNo ) AND  
       ( part_number = :ls_Part )   ;

If SQLCA.SQLCode <> 0 Then
	Return False
Else
	Return True
End if
end function

public subroutine wf_set_screen_tab_order (string ls_type);dw_header.TabOrder = 10
dw_detail.TabOrder = 0
mle_notes.TabOrder = 0
cb_notes_ok.TabOrder = 0
cb_notes_cancel.TabOrder = 0
dw_detail_info.TabOrder = 0
cb_popup_save.TabOrder = 0
cb_popup_exit.TabOrder = 0
cb_popup_availability.TabOrder = 0

If ls_Type = "Main" Then
	dw_header.TabOrder = 10
	dw_detail.TabOrder = 20
	dw_header.setfocus()
Elseif ls_Type = "Notes" Then
	mle_notes.TabOrder = 10
	cb_notes_ok.TabOrder = 20
	cb_notes_cancel.TabOrder = 30
Elseif ls_Type = "Detail" Then
	dw_detail_info.TabOrder = 10
	cb_popup_save.TabOrder = 20
	cb_popup_exit.TabOrder = 30
	cb_popup_availability.TabOrder = 40
End if
end subroutine

public function decimal wf_find_break (decimal dquantity, boolean bviewonly);Long	lRow,&
		ll_rowcount
Dec	ld_LowestPrice, d_price

If bViewOnly Then
	MessageBox ( monsys.msg_title, "This release has already been scheduled to a shipper.  You may view only.", Information! )
End if


ll_rowcount = dw_price_matrix.Rowcount ( )

If ll_rowcount > 0 Then

	ld_LowestPrice = f_get_value ( dw_price_matrix.GetItemNumber ( 1, "qty_break" ) )

	If dQuantity < ld_LowestPrice Then

		SelectRow ( dw_price_matrix, 0, False )

	   SELECT part_standard.price  
	     INTO :dPrice  
	     FROM part_standard  
	    WHERE part_standard.part = :szPart   ;
	
		If SQLCA.SQLCode <> 0 Then 
			dPrice = 0
		else
			sqlca.of_calculate_multicurrency_price ( '', dw_header.GetitemString ( 1, "currency_unit" ), dPrice, dPrice )
		end if

	Else

		lRow = dw_price_matrix.Find ( "qty_break > " + String ( dQuantity ), 1, ll_rowcount ) - 1

		If lRow < 1 Then
			SelectRow ( dw_price_matrix, 0, False )
			SelectRow ( dw_price_matrix, ll_rowcount, True )
			dw_price_matrix.ScrollToRow ( ll_rowcount )
			sqlca.of_calculate_multicurrency_price ( dw_price_matrix.GetItemString ( ll_rowcount, "currency_unit" ), &
				dw_header.GetItemString ( 1, "currency_unit" ), dw_price_matrix.GetItemNumber ( ll_rowcount, "price" ), dPrice )
		Else
			SelectRow ( dw_price_matrix, 0, False )
			SelectRow ( dw_price_matrix, lRow, True )
			dw_price_matrix.ScrollToRow ( lRow )
			sqlca.of_calculate_multicurrency_price ( dw_price_matrix.GetItemString ( ll_rowcount, "currency_unit" ), &
				dw_header.GetItemString ( 1, "currency_unit" ), dw_price_matrix.GetItemNumber ( lrow, "price" ), dPrice )
		End if

	End if

Else

	SelectRow ( dw_price_matrix, 0, False )

	SELECT part_standard.price  
	  INTO :dPrice  
	  FROM part_standard  
	 WHERE part_standard.part = :is_part_without_suffix   ;

	If SQLCA.SQLCode <> 0 Then 
		dPrice = 0
	else
		sqlca.of_calculate_multicurrency_price ( '', dw_header.GetitemString ( 1, "currency_unit" ), dPrice, dPrice )
	end if

	If dw_detail_info.GetItemDecimal (1, "Price") > 0 and dw_detail_info.GetItemDecimal (1, "Price") <> dPrice Then
		dPrice = dw_detail_info.GetItemDecimal (1, "Price")
	End If

End if

Return dPrice
end function

public function boolean wf_get_profile (string as_customer);integer			li_return
string			ls_sort
uo_getprofilepartlist	luo_list

luo_list = CREATE uo_getprofilepartlist

if rb_internalpart.Checked then
	ls_sort = "part"
else
	ls_sort = "customer_part"
end if

if luo_list.Retrieve ( as_customer, lOrder, ls_sort ) > 0 then
	li_return = luo_list.RowsCopy ( 1, luo_list.RowCount ( ), Primary!, dw_detail, 1, Primary! )
end if

DESTROY luo_list

return TRUE
end function

public function decimal wf_get_price (ref datawindow adw_sourcedw, string as_price_type);int		li_row
string	ls_price_type,&
			ls_part,&
			ls_customer
dec		ldec_qty,&
			ldec_qty_break,&
			ldec_price

adw_sourcedw.AcceptText ( )

li_row 			= adw_sourcedw.GetRow ( )
ls_part			= adw_sourcedw.GetItemString ( li_row, "part_number" )
ls_customer		= dw_header.GetItemString ( 1, "customer" )

if f_get_calc_type ( ) = "quantity" then
	ldec_qty = adw_sourcedw.GetItemNumber ( li_row, "quantity" )
else
	ldec_qty = adw_sourcedw.GetItemNumber ( li_row, "weight" )
end if

if as_price_type = "B" then
	SELECT max(qty_break)
	  INTO :ldec_qty_break
	  FROM part_customer_price_matrix  
	 WHERE ( part = :ls_part ) AND  
	       ( customer = :ls_customer ) AND  
	       ( qty_break < :ldec_qty )   ;
	if sqlca.sqlcode = 0 then
	  	SELECT price
	     INTO :ldec_price  
	     FROM part_customer_price_matrix  
	    WHERE ( part = :ls_part ) AND  
	          ( customer = :ls_customer ) AND  
	          ( qty_break = :ldec_qty_break )   ;
	end if
	if f_get_value ( ldec_price ) = 0 then
  		SELECT part_standard.price  
    	  INTO :ldec_price  
    	  FROM part_standard  
   	 WHERE part_standard.part = :ls_part   ;
	end if
else
  	SELECT price
     INTO :ldec_price  
     FROM part_customer_price_matrix as a, part_customer as b
    WHERE ( a.part = b.part ) AND
			 ( a.customer = b.customer ) AND
			 ( a.part = :ls_part ) AND  
          ( a.customer = :ls_customer ) ;
	
	ldec_price = f_get_value ( ldec_price )

	If ldec_price <= 0 and as_price_type = 'C' then
		ldec_price =  wf_recalc_prices(ls_part, ls_customer)
	End If

	if ldec_price = 0 then
  		SELECT part_standard.price  
    	  INTO :ldec_price  
    	  FROM part_standard  
   	 WHERE part_standard.part = :ls_part   ;
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

public function long wf_create_order_from_quote (long a_l_quote);//	Declare local variables
String	l_s_destination,&
	l_s_terms,&
	l_s_salesman,&
	l_s_customer,&
	l_s_contact,&
	l_s_notes,&
	l_s_part,&
	l_s_name,&
	l_s_unit
string	ls_status
string	ls_currency_unit
dec	l_dec_unit_weight,&
	l_dec_qty,&
	l_dec_weight,&
	l_dec_calc_qty,&
	l_dec_stdqty
datastore	l_ds_quotedetail
long	l_l_count
integer	li_show_euro

//	Generate order_header record
dw_header.DataObject = "d_order_header_info"
dw_header.SetTransObject ( sqlca )
dw_header.BringToTop = True
p_1.BringToTop = True
dw_detail.Enabled = False
dw_header.InsertRow ( 1 )
dw_header.SetItem ( 1, "order_date", Today ( ) )
dw_header.SetItem ( 1, "status", "O" )

//	Get data from quote table
select	customer, 
	destination, 
	salesman, 
	contact,  
	notes
into	:l_s_customer, 
	:l_s_destination, 
	:l_s_salesman, 
	:l_s_contact,  
	:l_s_notes
from	quote 
where	quote_number = :a_l_quote ; 

//	Get data from customer table
select	terms ,
	cs_status,
	default_currency_unit,
	show_euro_amount
into	:l_s_terms ,
	:ls_status,
	:ls_currency_unit,
	:li_show_euro
from	customer
where	customer = :l_s_customer ;

//	Set values to the columns in the datawindow
dw_header.object.customer[1]	= l_s_customer
dw_header.object.destination[1]	= l_s_destination
dw_header.object.term[1]	= l_s_terms
dw_header.object.salesman[1]	= l_s_salesman
dw_header.object.contact[1]	= l_s_contact
dw_header.object.cs_status[1]	= ls_status
dw_header.object.currency_unit[1]	= ls_currency_unit
dw_header.object.show_euro_amount[1]	= li_show_euro
//dw_header.object.notes[1]		= l_s_notes

//	Get data from destination table
select	default_currency_unit,
	show_euro_amount
into	:ls_currency_unit,
	:li_show_euro
from	destination
where	destination = :l_s_destination ;

if ls_currency_unit <> dw_header.object.currency_unit[1] then
	dw_header.object.currency_unit[1] = ls_currency_unit
end if

if li_show_euro <> dw_header.object.show_euro_amount[1] then
	dw_header.object.show_euro_amount[1] = li_show_euro
end if

//	Save header data
lOrder = -1
TriggerEvent ( "save_item" )
lOrder = dw_header.object.order_no[1]

//	Generate order_detail record
l_ds_quotedetail = CREATE datastore
l_ds_quotedetail.DataObject = "d_quote_detail_for_convert"
l_ds_quotedetail.SetTransObject ( sqlca )
l_ds_quotedetail.Retrieve ( a_l_quote )

//	Create detail records
For l_l_count = 1 to l_ds_quotedetail.RowCount ( )
	dw_detail.InsertRow ( 0 )
	l_s_part	= l_ds_quotedetail.object.part[l_l_count]
	select	part_inventory.unit_weight  
	into	:l_dec_unit_weight  
	from	part_inventory  
	where	part_inventory.part = :l_s_part ;
	l_s_unit	= l_ds_quotedetail.object.unit[l_l_count]
	l_dec_qty	= l_ds_quotedetail.object.quantity[l_l_count]
	l_dec_stdqty	= f_convert_units ( l_s_unit, '', l_s_part, l_dec_qty )
	l_dec_weight	= l_dec_stdqty * l_dec_unit_weight
	dw_detail.object.order_no[l_l_count]	= lOrder
	dw_detail.object.status[l_l_count]	= 'O'
	dw_detail.object.sequence[l_l_count]	= l_ds_quotedetail.object.sequence[l_l_count]
	dw_detail.object.weight[l_l_count]	= l_dec_weight
	dw_detail.object.quantity[l_l_count]	= l_dec_qty
	dw_detail.object.price[l_l_count]	= l_ds_quotedetail.object.price[l_l_count]
	dw_detail.object.product_name[l_l_count]= l_ds_quotedetail.object.product_name[l_l_count]
	dw_detail.object.unit[l_l_count]	= l_s_unit
	dw_detail.object.row_id[l_l_count]	= f_get_random_number ( )	
	dw_detail.object.due_date[l_l_count]	= DateTime ( Today ( ), Time ( '00:00' ) )
	dw_detail.object.week_no[l_l_count]	= f_get_week_no ( Today ( ) )
	dw_detail.object.part_number[l_l_count]	= l_s_part
	dw_detail.object.committed_qty[l_l_count]= 0	
	dw_detail.object.std_qty[l_l_count]	= l_dec_stdqty
next
//	Save data
if dw_detail.RowCount ( ) > 0 then
	If dw_detail.Update ( ) = -1 then
		rollback;
	else
		commit;
	end if
end if
//	Return order no
return lOrder

end function

public function boolean wf_create_shipper_detail (long a_l_shipper, long a_l_row);String 	l_s_Part
String 	l_s_GLAccount
String	szShipperPart
String	szNote
String	szUM
String	szCustomerPart
String	szName
String	szRelease
String	szCustomerPO
String	szSalesman
String	szGroup
String   s_StageFlag
string	ls_taxable

Decimal 	nPrice
Decimal	nQty
Decimal	nQtyCommitted
Decimal	nStdQty

Long		l_l_Suffix
Long		l_l_Sequence
Long		l_l_WeekNo

Integer	li_count

l_l_Sequence		= dw_detail.GetItemNumber(a_l_row, "sequence")
nPrice			= dw_detail.GetItemNumber(a_l_row, "price")
l_s_Part			= dw_detail.GetItemString(a_l_row, "part_number")
nQty				= dw_detail.GetItemNumber(a_l_row, "quantity")
nQtyCommitted	= dw_detail.GetItemNumber(a_l_row, "committed_qty")
l_l_Suffix			= dw_detail.GetItemNumber(a_l_row, "suffix")
szCustomerPart	= dw_detail.GetItemString(a_l_row, "customer_part")
szNote			= dw_detail.GetItemString(a_l_row, "notes")
szGroup			= dw_detail.GetItemString(a_l_row, "group_no")
szUM				= f_get_string_value(dw_detail.GetItemString(a_l_row, "Unit"))
szName			= f_get_part_info(l_s_Part, "NAME")
szRelease		= dw_detail.GetItemString(a_l_row, "release_no")
szSalesman		= dw_header.GetItemString(1, "salesman")
szCustomerPO	= dw_header.GetItemString(1, "customer_po")
l_l_WeekNo			= f_get_week_no(Date(uo_shipper_header.dw_shipper_header.GetItemDateTime(1, "date_stamp")))
l_s_GLAccount		= f_get_part_info(l_s_Part, "MFG GL ACCOUNT")
if isnull(l_s_GLAccount,'') = '' then
	l_s_GLAccount = f_get_part_info (l_s_part, "GL ACCOUNT" )
end if
s_StageFlag    = f_get_staging_info ( lOrder, l_s_Part )

If l_l_Suffix > 0 then	 
	szShipperPart	= l_s_Part + '-' + String(l_l_Suffix)
Else
	szShipperPart	= l_s_Part
End If

select	taxable
into		:ls_taxable
from		part_customer
where		part = :l_s_part and
			customer = :szCustomer ;
			
select	count ( shipper )
into		:li_count
from		shipper_detail
where		shipper = :a_l_shipper and
			part = :szShipperPart ;
			
nQty = nQty - nQtyCommitted

if li_count > 0 then
	UPDATE	shipper_detail
	SET		qty_required = qty_required + :nQty,
				qty_original = qty_original + :nQty
	WHERE		shipper = :a_l_shipper and
				part = :szShipperPart ;
else

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
           suffix,   
           part_name,   
           part_original,
			  group_no,
			  dropship_po_serial,
			  dropship_invoice_serial,
			  stage_using_weight )  
  VALUES ( :a_l_shipper,   
           :szShipperPart,   
           :nQty,   
			  0,
           :nQty,   
           null,   
           :lOrder,   
           :szCustomerPO,   
           :szRelease,   
           null,   
           null,   
           :nPrice,   
           :l_s_GLAccount,   
           :szSalesman,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :szNote,   
           null,   
           null,   
           0,   
           0,   
           :szUM,   
           :l_l_WeekNo,   
           :ls_taxable,   
           'P',   
           null,   
           :szCustomerPart,   
           null,   
           null,   
           null,   
           :l_l_Suffix,   
           :szName,   
           :l_s_Part,
			  :szGroup,
			  0,
			  0,
			  :s_StageFlag )  ;

end if

If SQLCA.SQLCode = 0 then
	If dw_detail.Update() > 0 then
		Return TRUE
	Else
		Return FALSE
	End If
Else
	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
	Return FALSE
End If



end function

public function boolean wf_suffix (long a_l_order, string a_s_part);String	ls_Notes
Long		ll_RowId
Boolean	bStatus

ll_RowId = dw_detail_info.GetItemNumber(1, "row_id")

dw_detail_info.Retrieve( a_l_Order , ll_RowId )  

bStatus = True

If dw_detail_info.Rowcount() > 0 then

	ls_Notes = dw_detail_info.GetItemString(1, "notes")
	If ls_notes > '' Then
		If Not f_setup_suffix ( a_l_Order, a_s_Part, ls_Notes, ll_RowId ) And bStatus = True Then
			bStatus = False
		End if
	End if

End If

Return bStatus


end function

public subroutine wf_setup_values_part (string a_s_part, string a_s_desc);datawindowchild dwc_package

//dw_price_matrix.SetTransObject ( SQLCA )

string l_s_customerpart, &
		 l_s_category, &
		 l_s_package

dw_detail_info.SetItem ( 1, "product_name", a_s_Desc )
	
SELECT part_customer.customer_part,
		 type  
  INTO :l_s_CustomerPart,
		 :is_price_type  
FROM part_customer  
 WHERE ( part_customer.part = :a_s_Part ) AND  
       ( part_customer.customer = :szCustomer )   ;

IF SQLCA.SQLCode = 0 THEN
	dw_detail_info.SetItem ( 1, "customer_part", l_s_CustomerPart )
END IF
	
is_price_type = f_get_string_value ( is_price_type )

If is_price_type = "B" then
	IF dw_price_matrix.Retrieve ( a_s_Part, szCustomer, dw_header.GetItemString ( 1, "currency_unit" ) ) < 1 THEN
		SELECT 	part_standard.price  
		INTO 		:dPrice  
		FROM 		part_standard  
		WHERE 	part_standard.part = :a_s_Part   ;
		
		IF SQLCA.SQLCode = 0 THEN
			sqlca.of_calculate_multicurrency_price ( '', dw_header.GetItemString ( 1, "currency_unit" ), dPrice, dPrice )
			dw_detail_info.SetItem ( 1, "price", dPrice )
		END IF
	END IF
elseif is_price_type = "" then
	SELECT 	customer.category  
	INTO 		:l_s_category  
	FROM 		customer  
	WHERE 	customer.customer = :szCustomer   ;
			
	if f_get_string_value ( l_s_category ) > "" then is_price_type = 'C'

end if

SELECT part_inventory.standard_unit  
 INTO :szStdUnit  
 FROM part_inventory  
WHERE part_inventory.part = :a_s_Part   ;

dw_detail_info.SetItem ( 1, "unit", szStdUnit )	
dw_detail_info.SetItem ( 1, "type", "F" )

wf_unit_list ( a_s_Part )

dw_detail_info.GetChild ( "packaging_type", dwc_Package )
dwc_Package.SetTransObject ( SQLCA )
dwc_Package.Reset ( )


DECLARE package_list CURSOR FOR
SELECT code
FROM part_packaging
WHERE part = :a_s_Part
ORDER BY code ASC	;

Open package_list	;

DO
FETCH package_list INTO :l_s_Package	;
	IF SQLCA.SQLCode = 0 THEN
		dwc_Package.Insertrow( 0 )
		dwc_Package.SetItem ( dwc_Package.RowCount ( ), "code", l_s_Package )
	END IF
LOOP WHILE SQLCA.SQLCode = 0

Close package_list	;

if dwc_package.Rowcount() = 1 then
	dw_detail_info.SetItem ( 1, "packaging_type", dwc_package.GetItemString ( 1, "code" ) )
end if
end subroutine

public subroutine wf_updatedestinall (string as_dest, string as_olddest, string as_customer);//if quote > 0 then 
//	update	quote
//	set	destination = @newdest
//	where 	quote_number = @quote
//end if 

update	shipper
set	destination = :as_dest,
	customer = :as_customer
where	id in (select	sd.shipper
from	shipper_detail sd
	join shipper s on s.id = sd.shipper
where	sd.order_no = :lorder and
	isnull(s.status,'O') not in ('C','Z','E'));

update	bill_of_lading
set	destination = :as_dest
where	destination = :as_olddest and
	isnull(status,'O') <> 'C';

update	work_order
set	destination = :as_dest,
	customer = :as_customer
where	order_no = :lorder and
	destination = :as_olddest;
Return
end subroutine

event activate;call super::activate;STRING	ls_dest

If bDetailUO Then
	wf_screen_attrib ( True )
	dw_detail.Retrieve ( lOrder )
	bDetailUO = False
End if

//ls_dest = dw_header.object.destination[1]
//if ls_dest > '' then 
//	dw_header.object.destination[1] = ''
//	dw_header.object.destination[1] = ls_dest
//end if
end event

event open;call super::open;// 04/03/00	cbr	added initialization of il_maxrowid to 0
Int						iCount
String					ls_PlantRequired,&
							ls_status_type,&
							ls_status
st_generic_structure	l_str_parm
datawindowchild		ldwc_dddw

dw_detail.settransobject ( sqlca )
dw_header.SetTransObject ( sqlca )

il_maxrowid = 0			// 04/03/00 cbr	added

SELECT plant_required,
		 inv_reg_col
  INTO :ls_PlantRequired,
		 :is_inv_reg_col
  FROM parameters ;

//	Not sure why this was enforced. Removing the same. 1/31/02
/*
If f_get_string_value ( ls_PlantRequired ) <> 'Y' Then
	dw_header.Modify ( "plant.TabSequence=0" )
End if
*/

ib_fromquotes = FALSE

// Check for st_generic_structure, if so, create order from quote sent
if IsValid ( Message.PowerObjectParm ) then
	l_str_parm = Message.PowerObjectParm
	if isnull(l_str_parm.value1,'') > '' then
		ib_fromquotes = true
		lOrder = wf_create_order_from_quote ( long ( l_str_parm.value1 ) )
	else
		lOrder = -1
		szCustomer = l_str_parm.value2
		szDestination = l_str_parm.value3
	end if
else
	lOrder = f_get_value ( Message.DoubleParm )
end if

If lOrder > -1 Then
 
 //	dw_header.BringToTop = True
	p_1.BringToTop = True
	dw_header.Retrieve ( lOrder )
	szCustomer    = dw_header.GetItemString ( 1, "customer" )
	szDestination = dw_header.GetItemString ( 1, "destination" )
	ls_status_type = dw_header.GetItemString ( 1, "status_type" )
	If f_get_string_value ( dw_header.GetItemString ( 1, "notes" ) ) <> "" Then 
		bHeaderNotes = True
		Timer ( .5, This )
	End if
   SELECT salestax_rate
     INTO :dTaxRate  
     FROM destination
    WHERE destination = :szDestination   ;
	if isnull(dTaxRate,0) > 0 then
		dTaxRate = dTaxRate / 100
	else
		dTaxRate = 0
	end if
	dw_detail.retrieve ( lOrder )

	if dw_detail.RowCount ( ) = 0 then
		cb_get_profile.Enabled = TRUE
		rb_internalpart.Enabled = TRUE
		rb_customerpart.Enabled = TRUE
	end if

	if ls_status_type <> 'A' then
		Post Event ue_unapproved_message ( )
	end if
Else

	dw_header.BringToTop = True
	p_1.BringToTop = True
	dw_detail.Enabled = False
	dw_header.InsertRow ( 0 )
	dw_header.SetItem ( 1, "order_date", Today ( ) )
	dw_header.SetItem ( 1, "status", "O" )
	dw_header.SetItem ( 1, "customer", szCustomer )
	if szCustomer > '' then
		select cs_status into :ls_status from customer where customer = :szCustomer ;
		dw_header.GetChild ( "destination", ldwc_dddw )
		ldwc_dddw.SetFilter ( "customer=~"" + szcustomer + "~"" )
		ldwc_dddw.Filter ( )
		dw_header.SetItem ( 1, "cs_status", ls_status )
	end if
	dw_header.SetItem ( 1, "destination", szDestination )
	
End if

//wf_set_screen_tab_order ( "Main" )
//gf_get_info ( 'w_orders_detail', 0 )

dw_header.SetFocus ( )
end event

on timer;If bHeaderNotes Then
	If p_1.PictureName = "noteno.bmp" Then
		p_1.PictureName = "noteyes.bmp"
	Else
		p_1.PictureName = "noteno.bmp"
	End if
Else
	p_1.PictureName = "noteno.bmp"
	Timer ( 0, This )
End if

end on

on w_orders_detail.create
int iCurrent
call super::create
if this.MenuName = "m_normal_order_main" then this.MenuID = create m_normal_order_main
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.rb_customerpart=create rb_customerpart
this.rb_internalpart=create rb_internalpart
this.dw_pc_su=create dw_pc_su
this.cb_notes_ok=create cb_notes_ok
this.cb_selectall=create cb_selectall
this.cb_get_profile=create cb_get_profile
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_price_matrix=create dw_price_matrix
this.sle_package_unit=create sle_package_unit
this.dw_detail=create dw_detail
this.cb_popup_availability=create cb_popup_availability
this.cb_popup_save=create cb_popup_save
this.cb_popup_exit=create cb_popup_exit
this.p_1=create p_1
this.st_5=create st_5
this.st_4=create st_4
this.p_3=create p_3
this.p_2=create p_2
this.dw_order_detail_notes=create dw_order_detail_notes
this.lb_1=create lb_1
this.st_2=create st_2
this.dw_detail_taxable=create dw_detail_taxable
this.st_notes=create st_notes
this.mle_notes=create mle_notes
this.cb_popup_drop_ship=create cb_popup_drop_ship
this.uo_notes=create uo_notes
this.dw_header=create dw_header
this.uo_shipper_header=create uo_shipper_header
this.cb_notes=create cb_notes
this.cb_notes_cancel=create cb_notes_cancel
this.gb_3=create gb_3
this.gb_4=create gb_4
this.dw_detail_info=create dw_detail_info
this.cb_1=create cb_1
this.cb_background=create cb_background
this.st_3=create st_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.em_3=create em_3
this.em_2=create em_2
this.em_4=create em_4
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_10
this.Control[iCurrent+2]=this.st_9
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.rb_customerpart
this.Control[iCurrent+7]=this.rb_internalpart
this.Control[iCurrent+8]=this.dw_pc_su
this.Control[iCurrent+9]=this.cb_notes_ok
this.Control[iCurrent+10]=this.cb_selectall
this.Control[iCurrent+11]=this.cb_get_profile
this.Control[iCurrent+12]=this.pb_2
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.dw_price_matrix
this.Control[iCurrent+15]=this.sle_package_unit
this.Control[iCurrent+16]=this.dw_detail
this.Control[iCurrent+17]=this.cb_popup_availability
this.Control[iCurrent+18]=this.cb_popup_save
this.Control[iCurrent+19]=this.cb_popup_exit
this.Control[iCurrent+20]=this.p_1
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.st_4
this.Control[iCurrent+23]=this.p_3
this.Control[iCurrent+24]=this.p_2
this.Control[iCurrent+25]=this.dw_order_detail_notes
this.Control[iCurrent+26]=this.lb_1
this.Control[iCurrent+27]=this.st_2
this.Control[iCurrent+28]=this.dw_detail_taxable
this.Control[iCurrent+29]=this.st_notes
this.Control[iCurrent+30]=this.mle_notes
this.Control[iCurrent+31]=this.cb_popup_drop_ship
this.Control[iCurrent+32]=this.uo_notes
this.Control[iCurrent+33]=this.dw_header
this.Control[iCurrent+34]=this.uo_shipper_header
this.Control[iCurrent+35]=this.cb_notes
this.Control[iCurrent+36]=this.cb_notes_cancel
this.Control[iCurrent+37]=this.gb_3
this.Control[iCurrent+38]=this.gb_4
this.Control[iCurrent+39]=this.dw_detail_info
this.Control[iCurrent+40]=this.cb_1
this.Control[iCurrent+41]=this.cb_background
this.Control[iCurrent+42]=this.st_3
this.Control[iCurrent+43]=this.rb_2
this.Control[iCurrent+44]=this.rb_1
this.Control[iCurrent+45]=this.st_1
this.Control[iCurrent+46]=this.em_3
this.Control[iCurrent+47]=this.em_2
this.Control[iCurrent+48]=this.em_4
this.Control[iCurrent+49]=this.em_1
end on

on w_orders_detail.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.rb_customerpart)
destroy(this.rb_internalpart)
destroy(this.dw_pc_su)
destroy(this.cb_notes_ok)
destroy(this.cb_selectall)
destroy(this.cb_get_profile)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_price_matrix)
destroy(this.sle_package_unit)
destroy(this.dw_detail)
destroy(this.cb_popup_availability)
destroy(this.cb_popup_save)
destroy(this.cb_popup_exit)
destroy(this.p_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.dw_order_detail_notes)
destroy(this.lb_1)
destroy(this.st_2)
destroy(this.dw_detail_taxable)
destroy(this.st_notes)
destroy(this.mle_notes)
destroy(this.cb_popup_drop_ship)
destroy(this.uo_notes)
destroy(this.dw_header)
destroy(this.uo_shipper_header)
destroy(this.cb_notes)
destroy(this.cb_notes_cancel)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.dw_detail_info)
destroy(this.cb_1)
destroy(this.cb_background)
destroy(this.st_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.em_4)
destroy(this.em_1)
end on

event closequery;call super::closequery;If ib_Changed Then
	Choose case Messagebox (monsys.msg_title, "Do you want to save changes?", Question!, YesNoCancel!,1)
		case 1
			w_Orders_detail.TriggerEvent ("save_item")

			If ib_Changed Then Return 1
	
		case 2

			Return 0
			
		case 3
			
			return 1

	End Choose
End If

end event

type st_10 from statictext within w_orders_detail
integer x = 1765
integer y = 1324
integer width = 238
integer height = 48
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Total"
boolean focusrectangle = false
end type

type st_9 from statictext within w_orders_detail
integer x = 1765
integer y = 1264
integer width = 238
integer height = 48
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Sales Tax"
boolean focusrectangle = false
end type

type st_8 from statictext within w_orders_detail
integer x = 1765
integer y = 1200
integer width = 238
integer height = 48
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Sub Total"
boolean focusrectangle = false
end type

type st_7 from statictext within w_orders_detail
integer x = 1536
integer y = 1200
integer width = 229
integer height = 48
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Total Wt."
boolean focusrectangle = false
end type

type st_6 from statictext within w_orders_detail
integer x = 859
integer y = 544
integer width = 128
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sort"
boolean focusrectangle = false
end type

type rb_customerpart from radiobutton within w_orders_detail
integer x = 1353
integer y = 544
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Customer Part"
end type

type rb_internalpart from radiobutton within w_orders_detail
integer x = 987
integer y = 544
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Internal Part"
boolean checked = true
end type

type dw_pc_su from datawindow within w_orders_detail
boolean visible = false
integer x = 5321
integer y = 64
integer width = 475
integer height = 288
integer taborder = 20
string dataobject = "d_part_customer_std_unit"
boolean livescroll = true
end type

on constructor;settransobject(sqlca)
end on

type cb_notes_ok from commandbutton within w_orders_detail
boolean visible = false
integer x = 1221
integer y = 816
integer width = 270
integer height = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ok"
end type

on clicked;UPDATE order_header  
   SET notes = :mle_notes.Text  
 WHERE order_no = :lOrder   ;

If SQLCA.SQLCode <> 0 Then
	RollBack ;
	Return
Else
	Commit ;
	If mle_notes.Text <> "" Then
		bHeaderNotes = True
		Timer ( .5, Parent )
	Else
		bHeaderNotes = False
		Timer ( 0, Parent )
	End if
End if


wf_header_notes ( False )
end on

type cb_selectall from commandbutton within w_orders_detail
integer x = 73
integer y = 544
integer width = 389
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Select All/None"
end type

event clicked;long		ll_row
long		ll_rowcount

ll_rowcount = dw_detail.RowCount ( )

for ll_row = 1 to ll_rowcount
	dw_detail.SelectRow ( ll_row, ib_selectall )
next

ib_selectall = ( not ib_selectall )
end event

type cb_get_profile from commandbutton within w_orders_detail
integer x = 457
integer y = 544
integer width = 384
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Get Profile"
end type

event clicked;LONG	ll_rows,&
		ll_row
		
wf_get_profile ( dw_header.GetItemString ( 1, "customer" ) )

if dw_detail.RowCount ( ) > 0 then
	ib_getprofile = TRUE
	Enabled = FALSE
end if

end event

type pb_2 from picturebutton within w_orders_detail
boolean visible = false
integer x = 4512
integer y = 92
integer width = 87
integer height = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "logo90.bmp"
string disabledname = "blank.bmp"
end type

event clicked;DataWindowChild 	dwcParts
String				szPartNumber
String				ls_Desc

dw_detail_info.GetChild ( "part_number", dwcParts )

dwcParts.SetTransObject ( sqlca )
dwcParts.Reset ( )

pb_2.Hide ( )
bShowAll = FALSE

cb_1.x = 1318
cb_1.y = 513
st_3.x = 1409
st_3.y = 577
cb_1.Show ( )
cb_1.BringToTop = TRUE
st_3.Show ( )
st_3.BringToTop = TRUE

 DECLARE part_list CURSOR FOR  
  SELECT part,
         name
    FROM part  
   WHERE type = 'F'   
ORDER BY part ASC  ;

Open part_list ;

Do
	Fetch part_list Into :szPartNumber, :ls_Desc ;
	IF SQLCA.SQLCode = 0 THEN
		dwcParts.InsertRow ( 0 )
		dwcParts.SetItem ( dwcParts.RowCount ( ), "part", szPartNumber )
		dwcParts.SetItem ( dwcParts.RowCount ( ), "desc", ls_Desc )
	END IF
Loop While SQLCA.SQLCode = 0

Close part_list ;

st_3.Hide ( )
cb_1.Hide ( )
pb_1.Show ( )

dw_detail_info.SetFocus ( )
end event

type pb_1 from picturebutton within w_orders_detail
boolean visible = false
integer x = 3374
integer y = 80
integer width = 87
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "search.bmp"
end type

event clicked;DataWindowChild	dwcParts
String		szPartNumber
String		ls_Desc
String		ls_CustomerCheck
dw_detail_info.GetChild ( "part_number", dwcParts )
dwcParts.SetTransObject ( sqlca )
dwcParts.Reset ( )
pb_1.Hide ( )
bShowSearch = FALSE
cb_1.x = 1318
cb_1.y = 513
st_3.x = 1409
st_3.y = 577
cb_1.Show ( )
cb_1.BringToTop = TRUE
st_3.Show ( )
st_3.BringToTop = TRUE

SELECT	customer
INTO	:ls_CustomerCheck
FROM	part_customer
WHERE	customer = :szCustomer;

IF IsNull ( ls_CustomerCheck ) OR ls_CustomerCheck = "" THEN
	DECLARE part_list CURSOR FOR  
	SELECT	part,
		name
	FROM	part  
	WHERE	type = 'F'   
	ORDER BY part ASC  ;
	
	Open	part_list ;
	Fetch	part_list Into :szPartNumber, :ls_Desc ;
	
	Do While SQLCA.SQLCode = 0
		dwcParts.InsertRow ( 0 )
		dwcParts.SetItem ( dwcParts.RowCount ( ), "part", szPartNumber )
		dwcParts.SetItem ( dwcParts.RowCount ( ), "desc", ls_Desc )
		Fetch part_list Into :szPartNumber, :ls_Desc ;
	Loop
	
	Close part_list ;
ELSE
	DECLARE customer_part_list CURSOR FOR  
	SELECT	pc.part,
		p.name
	FROM	part_customer pc
		join part p on p.part = pc.part
	WHERE	customer = :szCustomer   
	ORDER BY pc.part ASC  ;
	
	Open	customer_part_list ;
	Fetch	customer_part_list Into :szPartNumber, :ls_desc;
	
	Do While SQLCA.SQLCode = 0
		dwcParts.InsertRow ( 0 )
		dwcParts.SetItem ( dwcParts.RowCount ( ), "part", szPartNumber )
		dwcParts.SetItem ( dwcParts.RowCount ( ), "desc", ls_Desc )
		Fetch	customer_part_list Into :szPartNumber, :ls_desc;
	Loop 
	
	Close	customer_part_list ;
	
	pb_2.Show ( )	
	pb_2.Show ( )
	pb_2.BringToTop = True
END IF
st_3.Hide ( )
cb_1.Hide ( )
dw_detail_info.SetFocus ( )

end event

type dw_price_matrix from datawindow within w_orders_detail
boolean visible = false
integer x = 2985
integer y = 984
integer width = 1079
integer height = 352
string dataobject = "d_customer_price_matrix_no"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row < 1 Then Return

SelectRow ( This, 0, False )
SelectRow ( This, row, True )

dPrice = This.GetItemNumber ( row, "price" )
dBreakQty = This.GetItemNumber ( row, "qty_break" )

dw_detail_info.SetItem ( 1, "price", dPrice )
dw_detail_info.SetItem ( 1, "quantity", dBreakQty )


end event

event constructor;SetTransObject ( sqlca )

end event

type sle_package_unit from singlelineedit within w_orders_detail
boolean visible = false
integer x = 4905
integer y = 500
integer width = 137
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_detail from datawindow within w_orders_detail
integer x = 69
integer y = 608
integer width = 2725
integer height = 580
string dataobject = "d_detail_no_notes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event doubleclicked;if ib_getprofile then return

//  Declare Variables
st_order_chain stOrderParm

//  Initialize Variables
lCurrentRow 			= dw_detail.Getclickedrow ( )

If lCurrentRow < 1 Then Return

Selectrow ( This,lCurrentRow,false)
//SelectRow ( This,lCurrentRow,true)

lRowId = This.GetItemNumber ( lCurrentRow, "row_id" )

wf_screen_attrib ( False )
lOrder = dw_header.GetItemNumber ( 1, "order_no" )
wf_detail_popup ( True, lOrder, lRowId, szCustomer, szDestination, This.RowCount ( ) + 1, True, This.GetItemString ( lCurrentRow, "part_number" )  , dw_header.GetItemString ( 1, "plant" ) )

end event

event itemchanged;// changes log (date	user	notes)
//	3/30/00	cbr	added checking for divisibility of standard pack
string	l_s_invoice_reg_col,&
			l_s_column_name,&
			l_s_part,&
			l_s_customer,&
			ls_unit
dec		l_dec_std_pack,&
			l_dec_unit_weight,&
			ldec_stdqty,&
			l_dec_weight,&
			l_dec_calc_qty
// cbr added following 3/20/00
decimal	ldec_qty
decimal	ldec_stdpack
// cbr end adding 3/30/00

dec {6}	ldec_price

ib_Changed = TRUE

l_s_column_name 	= GetColumnName ( )
l_s_part				= GetItemString ( GetRow ( ), "part_number" )
l_s_customer		= dw_header.GetItemString ( 1, "customer" )

SELECT type  
  INTO :is_price_type  
  FROM part_customer  
 WHERE ( part_customer.part = :l_s_part ) AND  
       ( part_customer.customer = :l_s_customer )   ;


Choose Case l_s_column_name

	Case "quantity","weight"

		SELECT part_inventory.unit_weight  
  		  INTO :l_dec_unit_weight  
  		  FROM part_inventory  
		 WHERE part_inventory.part = :l_s_part ;

		ls_unit = object.unit[1]
		
		if l_s_column_name = "quantity" then
			ldec_qty			= dec ( data )
			ldec_stdqty		= f_convert_units ( ls_unit, '', l_s_part, ldec_qty )
			l_dec_weight 	= ldec_stdqty * l_dec_unit_weight
			SetItem ( GetRow ( ), "weight", l_dec_weight )
			SetItem ( GetRow ( ), "std_qty", ldec_stdqty )
		else
			l_dec_weight 	= f_convert_units ( ls_unit, '', l_s_part, Dec ( f_get_string_value ( GetText ( ) ) ) )
			ldec_stdqty		= l_dec_weight / l_dec_unit_weight
			ldec_qty			= f_convert_units ( '', ls_unit, l_s_part, ldec_stdqty )
			SetItem ( GetRow ( ), "std_qty", ldec_stdqty )
			SetItem ( GetRow ( ), "quantity", ldec_qty )
		end if
		if f_get_calc_type ( ) = "quantity" then
			l_dec_calc_qty = ldec_stdqty
		else
			l_dec_calc_qty = l_dec_weight
		end if
		
		// cbr added the following 3/30/00
		if Isnull ( dw_header.GetItemString ( 1, "check_standard_pack" ), 'N' ) = 'Y' then
			ldec_stdpack = sqlca.of_customerstandardpack ( l_s_customer, l_s_part, ls_unit )
			if ldec_stdpack > 0 and ldec_qty > 0 then
				if ldec_stdpack < ldec_qty then
					if mod ( ldec_qty, ldec_stdpack ) <> 0 then
						MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ceiling ( ldec_qty / ldec_stdpack ) * ldec_stdpack, "##########" ) + ".", Information! )
					end if
				elseif ldec_stdpack > ldec_qty then
					MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ldec_stdpack, "##########" ) + ".", Information! )
				end if
			end if
		end if
		// cbr end adding 3/30/00

		ldec_price = f_calculate_customer_price ( l_s_part, l_s_customer, l_dec_calc_qty )

		sqlca.of_calculate_multicurrency_price ( '', dw_header.GetItemString ( 1, "currency_unit" ), &
			ldec_price, ldec_price )

		SetItem ( GetRow ( ), "price", ldec_price )
		
		AcceptText ( )
		
End Choose 

if row > 0 then 
	em_1.text = string(object.tweight[1])
	em_2.text = string(object.extended[1])
	em_3.text = string(object.f_sales_tax[1])
	em_4.text = string(object.total[1])
else
	em_1.text = '0'
	em_2.text = '0'
	em_3.text = '0'
	em_4.text = '0'
end if 	
end event

event retrieverow;// changes log (date user notes)
// 04/03/00	cbr	replaced rowcount () with row argument
//						storing max row id for new insert
String	lc_Taxable
String	ls_Part
Dec		ld_Qty
Dec		ld_Price
Long		ll_Row

ls_Part 	= f_get_string_value ( This.GetItemString ( row, "part_number" ) )
ll_Row = dw_detail_taxable.Find ( "order_no = " + String ( lOrder ) + " and part_number = '" + ls_Part + "'", 1, dw_detail_taxable.RowCount ( ) )

If ll_Row > 0 Then
	ld_Qty		= f_get_value ( This.GetItemNumber ( row, "quantity" ) )
	ld_Price		= f_get_value ( This.GetItemNumber ( row, "price" ) )
	lc_Taxable = f_get_string_value ( dw_detail_taxable.GetItemString ( ll_Row, "taxable" ) )
	If lc_Taxable = 'Y' Then
		This.SetItem ( row, "compute_0015", ( ld_Qty * ld_Price ) * dTaxRate )
	End if
Else
	This.SetItem ( row, "compute_0015", 0 )
End if

SetItem ( row, "calc_type", is_inv_reg_col )


end event

event clicked;if ib_getprofile then return

String 	szShipType,&
			ls_object_at_pointer,&
			ls_column
Decimal 	nQty
Decimal 	nQtyCommitted
int		li_pos

lCurrentRow	= This.Getclickedrow ( )

If lCurrentRow < 1 Then Return

nQty				= this.GetItemNumber(lCurrentRow, "quantity")
nQtyCommitted	= this.GetItemNumber(lCurrentRow, "committed_qty")
szShipType		= f_get_string_value ( this.GetItemString(lCurrentRow, "ship_type") )

if nQty > 0 then
	If szShipType <> 'D' then		//Only for normal not for dropship
		If nQty > nQtyCommitted then
			this.SelectRow(lCurrentRow, Not this.IsSelected(lCurrentRow))
		Else
			this.SelectRow(lCurrentRow, FALSE)
			SetMicroHelp ( "The part you clicked on has already been scheduled to a shipper." )
		End If
	Else
		this.SelectRow(lCurrentRow, FALSE)
		SetMicroHelp ( "You can not schedule shipper for dropship items." )
	End If
end if

This.SetRow ( lCurrentRow )
end event

event updateend;if RowCount ( ) > 0 then
	cb_get_profile.Enabled = FALSE
	rb_internalpart.Enabled = FALSE
	rb_customerpart.Enabled = FALSE
else
	cb_get_profile.Enabled = TRUE
	rb_internalpart.Enabled = TRUE
	rb_customerpart.Enabled = TRUE
end if
end event

on editchanged;ib_Changed = TRUE
end on

on retrievestart;dw_detail_taxable.SetTransObject ( sqlca )
dw_detail_taxable.Retrieve ( lOrder )
end on

event constructor;DataWindowChild	ldwc_units

GetChild ( "unit", ldwc_units )

ldwc_units.SetTransObject ( sqlca )
ldwc_units.InsertRow ( 1 )

object.datawindow.HorizontalScrollSplit = ProfileInt ( "monitor.ini", "Order Entry", "NormalSplitValue", 0 )

end event

event retrieveend;// 04/03/00	cbr added below
long	ll_row

for ll_row = 1 to rowcount
	if GetItemNumber ( ll_row, "row_id" ) > il_maxrowid then
		il_maxrowid = GetItemNumber ( ll_row, "row_id" )
	end if
next
// 04/03/00 cbr end adding
if rowcount > 0 then 
	em_1.text = string(object.tweight[1])
	em_2.text = string(object.extended[1])
	em_3.text = string(object.f_sales_tax[1])
	em_4.text = string(object.total[1])
else
	em_1.text = '0'
	em_2.text = '0'
	em_3.text = '0'
	em_4.text = '0'
end if 	
end event

type cb_popup_availability from commandbutton within w_orders_detail
boolean visible = false
integer x = 4663
integer y = 1372
integer width = 370
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Availability"
end type

event clicked;st_generic_structure stSendParm

stSendParm.Value1 = szPart
stSendParm.Value2 = String ( lOrder )
stSendParm.Value3 = dw_detail_info.GetItemString(1, "unit")
stSendParm.Value4 = String(dw_detail_info.GetItemNumber(1, "price"))

OpenSheetWithParm ( w_detail_info_of_demand_parm, stSendParm, gnv_App.of_GetFrame(), 3, Original! )
end event

type cb_popup_save from commandbutton within w_orders_detail
boolean visible = false
integer x = 2981
integer y = 1372
integer width = 343
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;st_generic_structure l_st_Parm
Int						iRtnCode
Long						ll_RowId
Long						ll_Dummy
Long						ll_Count
String 					szUM				//To keep the unit of measure
String 					l_s_part			//To keep the part number
String					ls_ShipType
String					ls_Notes
String					ls_ODNotes
String					ls_Dummy
String					ls_Type
Decimal 					nQty				//To keep the quantity
Decimal 					nStdQty			//To keep the standard quantity
Date						dDue
Boolean					bFoundOne

If dw_detail_info.AcceptText ( ) = -1 Then 
	ib_Changed = True
	Return
End If

szUM			= f_get_string_value ( dw_detail_info.GetItemString ( 1, "unit" ) )
nQty			= f_get_value ( dw_detail_info.GetItemNumber ( 1, "quantity") )
l_s_part		= f_get_string_value ( dw_detail_info.GetItemString ( 1, "part_number") )
dDue 			= Date ( dw_detail_info.GetItemDateTime ( 1, "due_date" ) )
ls_ShipType	= dw_detail_info.GetItemString ( 1, "ship_type" )
ll_RowId		= f_get_value ( dw_detail_info.GetItemNumber ( 1, "row_id" ) )
ls_Notes		= f_get_string_value ( dw_detail_info.GetItemString ( 1, "notes" ) )
nStdQty		= f_convert_units ( szUM, "", l_s_part, f_get_value ( nQty ) )
ls_type 		= dw_detail_info.GetItemString ( 1, "type" )

SELECT part.part  
  INTO :ls_Dummy  
  FROM part  
 WHERE part.part = :l_s_part   ;

If SQLCA.SQLCode <> 0 Or l_s_part = "" Then
	MessageBox ( monsys.msg_title, "Invalid Part Number!", StopSign! )
	dw_detail_info.SetColumn ( "part_number" )
	dw_detail_info.SetFocus ( )
	ib_changed = True
	Return
Elseif szUM = "" Then
	MessageBox ( monsys.msg_title, "Invalid Unit of Measure!", StopSign! )
	dw_detail_info.SetColumn ( "unit" )
	dw_detail_info.SetFocus ( )
	ib_changed = True
	Return
Elseif nQty = 0 Then
	MessageBox ( monsys.msg_title, "Invalid Quantity!", StopSign! )
	dw_detail_info.SetColumn ( "quantity" )
	dw_detail_info.SetFocus ( )
	ib_changed = true
	Return
End if

dw_detail_info.SetItem ( 1, "destination", szDestination)
dw_detail_info.SetItem ( 1, "std_qty", nStdQty) 
dw_detail_info.SetItem ( 1, "type", ls_type)
dw_detail_info.SetItem ( 1, "week_no", f_get_week_no ( dDue ) ) 
dw_detail_info.SetItem ( 1, "committed_qty", 0 )

If ls_ShipType = 'D' Then
	bMiniCop = False
	dw_detail_info.SetItem ( 1, "flag", 0 )
	DELETE FROM master_prod_sched  
	 WHERE ( origin = :lOrder ) AND  
	       ( source = :ll_RowId )   ;
	If SQLCA.SQLCode <> 0 Then
		RollBack ;
		Return
	End if
Else
	If ( bDblClick And ( nQty <> dOriginalQty Or szUM <> szOriginalUnit Or dDue <> dDueDate Or ( is_OriginalShipType <> ls_ShipType And ls_ShipType = 'N' ) ) ) Or Not bDblClick Then
		bMiniCop = True
		dw_detail_info.SetItem ( 1, "flag", 1 )
	Else
		bMiniCop = False
		dw_detail_info.SetItem ( 1, "flag", 0 )
	End if
End if

if ll_rowid = 0 then
	ll_rowid = il_maxrowid + 1
	dw_detail_info.SetItem ( 1, "row_id", ll_rowid )
	il_maxrowid = ll_rowid
end if

If dw_detail_info.Update (false) = -1 Then
	RollBack ;
	ib_changed = True
	Return
Else
	Commit ;	
	ib_Changed = False
End If

dw_detail.Retrieve ( lOrder )
wf_detail_popup ( False,0,0,'','',0,False,'','' )
sle_package_unit.Text = ""

If bMiniCop Then
	If f_ask_minicop ( ) Then
		If MessageBox(monsys.msg_title, "Do you want to run MiniCOP?", Question!, OkCancel!) = 1 then				
         istr_super_cop_parms.a_regen_all = 'Y'
			 istr_super_cop_parms.a_order_no  = lorder
    
          OpenWithParm ( w_bom_explode , istr_super_cop_parms)   

			gnv_App.of_GetFrame().Setmicrohelp("System has successfully updated the information...")
		End if
	End If
End if

ib_Add = FALSE
gnv_App.of_GetFrame().Setmicrohelp("Ready")
wf_screen_attrib ( True )

end event

type cb_popup_exit from commandbutton within w_orders_detail
boolean visible = false
integer x = 3374
integer y = 1372
integer width = 343
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

event clicked;ib_Add = FALSE

wf_detail_popup ( False,0,0,'','',0,False,'','' )
sle_package_unit.Text = ""

wf_screen_attrib ( True )
//dw_detail.retrieve ( lOrder )

end event

type p_1 from picture within w_orders_detail
integer x = 2702
integer y = 392
integer width = 73
integer height = 72
string picturename = "noteno.bmp"
boolean focusrectangle = false
end type

on clicked;If f_get_value ( lOrder ) > 0 Then
	wf_header_notes ( True )
End if
end on

type st_5 from statictext within w_orders_detail
integer x = 2354
integer y = 480
integer width = 306
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = " = Drop Ship"
boolean focusrectangle = false
end type

type st_4 from statictext within w_orders_detail
integer x = 1719
integer y = 480
integer width = 512
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = " =Scheduled to Ship"
boolean focusrectangle = false
end type

type p_3 from picture within w_orders_detail
integer x = 2277
integer y = 480
integer width = 78
integer height = 60
string picturename = "pick.bmp"
boolean border = true
boolean focusrectangle = false
end type

type p_2 from picture within w_orders_detail
integer x = 1641
integer y = 484
integer width = 78
integer height = 60
string picturename = "logo2.bmp"
boolean border = true
boolean focusrectangle = false
end type

type dw_order_detail_notes from datawindow within w_orders_detail
boolean visible = false
integer x = 5317
integer y = 768
integer width = 489
integer height = 356
string dataobject = "d_parts_with_notes_for_order_detail"
boolean livescroll = true
end type

event constructor;this.settransobject ( sqlca )
end event

type lb_1 from listbox within w_orders_detail
boolean visible = false
integer x = 5317
integer y = 384
integer width = 489
integer height = 356
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_orders_detail
boolean visible = false
integer x = 2912
integer y = 64
integer width = 2185
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79216776
boolean enabled = false
string text = "Detail Information"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_detail_taxable from datawindow within w_orders_detail
boolean visible = false
integer x = 2080
integer y = 1792
integer width = 489
integer height = 356
string dataobject = "d_order_detail_taxable"
boolean livescroll = true
end type

type st_notes from statictext within w_orders_detail
boolean visible = false
integer x = 1093
integer y = 400
integer width = 946
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Header Notes:"
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_notes from multilineedit within w_orders_detail
boolean visible = false
integer x = 1074
integer y = 464
integer width = 983
integer height = 336
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
integer limit = 254
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_popup_drop_ship from commandbutton within w_orders_detail
boolean visible = false
integer x = 2606
integer y = 1808
integer width = 384
integer height = 128
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Drop Ship"
end type

on clicked;dw_detail.DataObject = "d_detail_no_notes"
dw_detail.Show ( )
dw_detail.SetTransObject ( sqlca )
dw_detail.Retrieve ( lOrder, dTaxRate )

end on

type uo_notes from uo_notes_entry within w_orders_detail
boolean visible = false
integer x = 690
integer y = 1984
integer width = 1298
integer height = 640
end type

on uo_notes.destroy
call uo_notes_entry::destroy
end on

type dw_header from datawindow within w_orders_detail
event ue_stupid_powerbuilder_bug_event ( )
integer x = 73
integer y = 64
integer width = 2738
integer height = 400
integer taborder = 10
string dataobject = "d_order_header_info"
boolean border = false
boolean livescroll = true
end type

event ue_stupid_powerbuilder_bug_event;//STRING	ls_dest
//
//if rowcount() > 0 then
//	IF object.destination[1] > '' THEN
//		ls_dest = object.destination[1]
//		object.destination[1] = ''
//		object.destination[1] = ls_dest
//	END IF
//end if
end event

event itemchanged;String	l_s_destination, &
	szTerms, &
	szSalesRep, &
	szDest, &
	l_s_customer,&
	ls_default_currency,&
	ls_status
String	szContact
INT	li_show_euro_amount
DataWindowChild	l_dwc_destination
long	ll_row
long	ll_rowcount
int	li_dcnt
string	ls_cust, ls_dest
ib_Changed = True
Choose Case dwo.name
	Case "destination"
		if isnull(object.order_no[1],-1) > 0 then 
			ls_cust = object.customer[1]			
			ls_dest = object.destination[1]
			select count(1) into :li_dcnt from destination where customer = :ls_cust and destination = :data;
			
			if isnull(li_dcnt,0) = 0 then
				object.destination[1] = ls_dest				
				MessageBox(monsys.msg_title, data+" is not a valid destination for customer "+ls_cust, StopSign!)
				bDestError	= TRUE
				Return
			else
				Messagebox(monsys.msg_title, "Open Shippers & BOLs will be updated with the new destination related to this sales order!")				
			End If
		end if 	
		l_s_destination = data
		If Not f_valid_destination(l_s_destination) Then	
			MessageBox( monsys.msg_title, "Enter a valid destination.", StopSign!)
			dw_header.SetColumn("destination")
			bdesterror = True
			Return
		Else
			bdesterror = False     
		End If
		SELECT	destination.customer,
			destination.default_currency_unit,
			destination.show_euro_amount,
			destination.cs_status
		INTO	:szCustomer,
			:ls_default_currency,
			:li_show_euro_amount,
			:ls_status
		FROM 	destination  
		WHERE 	destination.destination = :l_s_destination;

		dw_header.SetItem ( 1, "customer", szCustomer )
		IF Isnull ( ls_default_currency, '' ) > '' then
			SELECT	customer.terms,   
				customer.salesrep,
				customer.contact
			INTO	:szTerms,   
				:szSalesRep,
				:szContact
			FROM	customer  
			WHERE	customer.customer = :szCustomer;
		else
			SELECT	customer.terms,   
				customer.salesrep,
				customer.contact,
				customer.default_currency_unit,
				customer.show_euro_amount
			INTO	:szTerms,   
				:szSalesRep,
				:szContact,
				:ls_default_currency,
				:li_show_euro_amount 
			FROM	customer  
			WHERE 	customer.customer = :szCustomer;
		end if
		dw_header.SetItem ( 1, "term", szTerms )
		dw_header.SetItem ( 1, "salesman", szSalesRep )
		dw_header.SetItem ( 1, "contact", szContact )
		dw_header.SetItem ( 1, "currency_unit", ls_default_currency )
		dw_header.SetItem ( 1, "show_euro_amount", li_show_euro_amount )
		dw_header.SetItem ( 1, "cs_status", ls_status )
	Case  "customer"
		GetChild ( "destination", l_dwc_destination )
		l_s_customer = data
		if isnull ( l_s_customer, '' ) > '' then
			l_dwc_destination.SetFilter ( "customer='" + l_s_customer + "'" )
			l_dwc_destination.Filter ( )
			l_s_destination = GetItemString ( 1, "destination" )
			IF l_dwc_destination.Find ( "destination='" + l_s_destination + "'", 0, &
				l_dwc_destination.RowCount ( ) ) < 1 THEN
				SetItem ( 1, "destination", "" )
			else
				if l_dwc_destination.GetItemString ( 1, "destination" ) <> l_s_destination then
					SetItem ( 1, "destination", "" )
				end if
			END IF
		else
			l_dwc_destination.SetFilter ( "" )
			l_dwc_destination.Filter ( )
		end if
	Case "due_date"
		if dw_detail.RowCount ( ) > 0 then
			if MessageBox (monsys.msg_title, "Do you want to write this date to all detail items?", Question!, YesNo!, 1 ) = 1 then
				datetime	ld_date
				ll_rowcount = dw_detail.RowCount ( )
				AcceptText ( )
				ld_date = GetItemDateTime ( 1, "due_date" )
				for ll_row = 1 to ll_rowcount
					dw_detail.SetItem ( ll_row, "due_date", ld_date )
				next
			end if
		end if
	Case "customer_po"
		if sqlca.of_customerpoexists ( data, GetItemString ( 1, "destination" ) ) then
		MessageBox ( monsys.msg_title, "The customer PO entered already exists for this destination.", Information! )
		end if
End Choose

end event

on editchanged;ib_Changed = True
end on

event retrieveend;//Post Event ue_stupid_powerbuilder_bug_event ( )
end event

type uo_shipper_header from u_create_shipper_header within w_orders_detail
boolean visible = false
integer x = 581
integer y = 256
end type

on uo_shipper_header.destroy
call u_create_shipper_header::destroy
end on

type cb_notes from commandbutton within w_orders_detail
boolean visible = false
integer x = 1038
integer y = 384
integer width = 1056
integer height = 560
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type cb_notes_cancel from commandbutton within w_orders_detail
boolean visible = false
integer x = 1641
integer y = 816
integer width = 270
integer height = 112
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

on clicked;wf_header_notes ( False )
end on

type gb_3 from groupbox within w_orders_detail
integer x = 32
integer width = 2816
integer height = 480
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Normal Order Header Information"
end type

type gb_4 from groupbox within w_orders_detail
integer x = 32
integer y = 480
integer width = 2816
integer height = 928
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Detail Items"
end type

type dw_detail_info from datawindow within w_orders_detail
event ue_keypress pbm_dwnkey
boolean visible = false
integer x = 2976
integer y = 148
integer width = 2085
integer height = 1212
string dataobject = "d_normal_order_detail_info"
boolean border = false
end type

event ue_keypress;if key = keytab! or key = keyenter! then
	If (dw_detail_info.getcolumnname()='quantity') then
		String ls_ddarequired
		String ls_Unit
		Dec    ldec_unit_weight, &
  				 ldec_weight, &
				 l_dec_calc_qty

		SELECT dda_required
		  INTO :ls_ddarequired
		  FROM parameters ;
		if (ls_ddarequired = 'Y') THEN 
		   dw_detail_info.accepttext()
			st_prmlst.s_arg_part   = dw_detail_info.getitemstring(1,'part_number')
			st_prmlst.s_arg_module = dw_detail_info.getitemstring(1,'unit')
			st_prmlst.s_rtn_qtystr = dw_detail_info.getitemstring(1,'dimension_qty_string')
			st_prmlst.s_rtn_qty    = dw_detail_info.getitemnumber(1,'quantity') 
			Openwithparm(w_dda,st_prmlst)
			st_prmlst = Message.PowerObjectparm
			dw_detail_info.setitem(1,'quantity',st_prmlst.s_rtn_qty)
			dw_detail_info.setitem(1,'dimension_qty_string',st_prmlst.s_rtn_qtystr)
//			Triggerevent('itemchanged')
			dQty   = st_prmlst.s_rtn_qty

			ls_Unit	= This.GetItemString ( 1, "unit" )
			dQty = f_convert_units ( ls_Unit, "", szPart, dQty )
		
			SELECT part_inventory.unit_weight  
			  INTO :ldec_unit_weight  
			  FROM part_inventory  
			 WHERE part_inventory.part = :szPart ;
	
			ldec_weight = ( dQty * ldec_unit_weight )
			dw_detail_info.SetItem ( 1, "weight", ldec_weight )

			if is_price_type = "B" then
				if is_inv_reg_col = "quantity" then
					dPrice = wf_find_break ( dQty, False )
				else
					dPrice = wf_find_break ( ldec_weight, False )
				end if
			else
				if f_get_calc_type ( ) = "quantity" then
					l_dec_calc_qty = dQty
				else
					l_dec_calc_qty = ldec_weight
				end if
	
				dPrice = f_calculate_customer_price ( szPart, szCustomer, l_dec_calc_qty )
				
				sqlca.of_calculate_multicurrency_price ( '', dw_header.GetItemString ( 1, "currency_unit" ), &
					dPrice, dPrice )
			end if			
			dw_detail_info.SetItem ( 1, "price", dPrice )	
		end if 	
	End if 
end if
end event

event itemchanged;// changes log (date	user	notes)
//	3/30/00	cbr	added checking for divisibility of standard pack.  added storing of package type standard pack

String	      l_s_Column
String	      l_s_CustomerPart
String	      ls_Unit
String         s_PackageType
String         s_PackageUnit,&
					ls_customer_part
dec				ldec_unit_weight,&
					ldec_std_pack,&
					ldec_weight,&
					l_dec_calc_qty, &
					l_n_qty
decimal			ldec_stdpack				// cbr added 3/30/00
string 			ls_currency[]
int				li_euro[]
					
DataWindowChild dwc_Package

ib_changed = TRUE
setnull(l_n_qty)

CHOOSE CASE getcolumnname()

	CASE "part_number"
		
		szPart = f_get_string_value ( data )
		szCustomer = dw_header.GetItemString ( 1, "customer" )

		IF szPart = "" THEN
			Settext( '' )
			MessageBox ( monsys.msg_title, "Invalid part number!", StopSign! )
			szPart = ""
      	szdesc = ""
	      szstdunit = ""
			This.SetItem ( 1, "product_name", szDesc )
			This.SetItem ( 1, "unit", szStdUnit )	
			This.SetItem ( 1, "type", "" )	
			This.SetItem ( 1, "quantity", l_n_qty )
			This.SetItem ( 1, "weight", l_n_qty )
			breset = TRUE
			Return 1
		END IF
	
	   SELECT part.name  
   	  INTO :szDesc  
	     FROM part  
	    WHERE part.part = :szPart and
		 		type = 'F' ;

		IF SQLCA.SQLCode <> 0 THEN
			MessageBox ( monsys.msg_title, "Invalid part number!", StopSign! )
			Settext( '' )
			szPart = ""

	   	szdesc = ""
	      szstdunit = ""
			This.SetItem ( 1, "product_name", szDesc )
			This.SetItem ( 1, "unit", szStdUnit )	
			This.SetItem ( 1, "type", "" )
			This.SetItem ( 1, "quantity", l_n_qty )
			This.SetItem ( 1, "weight", l_n_qty )
			breset = TRUE
			ib_Changed = TRUE
			Return 1
		END IF
		
		breset = FALSE
		wf_setup_values_part ( szpart, szdesc ) // moved all the code to the function to call the same from various places..

	CASE "quantity"

		dQty   = Dec ( data )
		ls_Unit	= This.GetItemString ( 1, "unit" )
		
		// cbr added the following 3/30/00
		if Isnull ( dw_header.GetItemString ( 1, "check_standard_pack" ), 'N' ) = 'Y' then
			ldec_stdpack = isnull ( GetItemDecimal ( row, "standard_pack" ), 0 )
			if ldec_stdpack <= 0 then
				ldec_stdpack = sqlca.of_customerstandardpack ( szcustomer, szpart, ls_unit )
			end if
			if ldec_stdpack > 0 and dqty > 0 then
				if ldec_stdpack < dqty then
					if mod ( dqty, ldec_stdpack ) <> 0 then
						MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ceiling ( dqty / ldec_stdpack ) * ldec_stdpack, "##########" ) + ".", Information! )
					end if
				elseif ldec_stdpack > dqty then
					MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ldec_stdpack, "##########" ) + ".", Information! )
				end if
			end if
		end if
		// cbr end adding 3/30/00

		dQty = f_convert_units ( ls_Unit, "", szPart, dQty )

		SELECT part_inventory.unit_weight  
		  INTO :ldec_unit_weight  
		  FROM part_inventory  
		 WHERE part_inventory.part = :szPart ;
	
		ldec_weight = ( dQty * ldec_unit_weight )
		SetItem ( GetRow ( ), "weight", ldec_weight )

		if is_price_type = "B" then
			if is_inv_reg_col = "quantity" then
				dPrice = wf_find_break ( dQty, False )
			else
				dPrice = wf_find_break ( ldec_weight, False )
			end if
		else
			if f_get_calc_type ( ) = "quantity" then
				l_dec_calc_qty = dQty
			else
				l_dec_calc_qty = ldec_weight
			end if
	
			dPrice = f_calculate_customer_price ( szPart, szCustomer, l_dec_calc_qty )
			
			sqlca.of_calculate_multicurrency_price ( '', dw_header.GetItemString ( 1, "currency_unit" ), &
				dPrice, dPrice )
		end if			
		dw_detail_info.SetItem ( 1, "price", dPrice )

	CASE "unit"

		dQty   = This.GetItemNumber ( 1, "quantity" )
		szUnit = data
		dStdQty = f_convert_units ( szUnit, "", szPart, dQty )
		dw_detail_info.SetItem ( 1, "std_qty", dStdQty )
		dPrice = wf_find_break ( dStdQty, False )
		dw_detail_info.SetItem ( 1, "price", dPrice )

	CASE "packaging_type"

		s_PackageType = data

		// cbr added quantity to column list below 3/30/00
		SELECT unit,
				 quantity
		  INTO :s_PackageUnit,
		  		 :dQty 
		  FROM part_packaging
		 WHERE part = :szPart AND
				 code = :s_PackageType	;

		IF NOT IsNull ( s_PackageUnit ) OR s_PackageUnit <> "" THEN
			sle_package_unit.Text = s_PackageUnit
		END IF

		SetItem ( row, "standard_pack", dQty )				// cbr added 3/30/00
		
		// cbr added the following 3/30/00
		ls_Unit	= This.GetItemString ( 1, "unit" )
		ldec_stdpack = dQty
		dQty = GetItemDecimal ( row, "quantity" )
		if ldec_stdpack <= 0 then
			ldec_stdpack = sqlca.of_customerstandardpack ( szcustomer, szpart, ls_unit )
		end if
		if ldec_stdpack > 0 and dqty > 0 then
			if ldec_stdpack < dqty then
				if mod ( dqty, ldec_stdpack ) <> 0 then
					MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ceiling ( dqty / ldec_stdpack ) * ldec_stdpack, "##########" ) + ".", Information! )
				end if
			elseif ldec_stdpack > dqty then
				if mod ( ldec_stdpack, dqty ) <> 0 then
//					MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ceiling ( ldec_stdpack / dqty ) * ldec_stdpack, "##########" ) + ".", Information! )
					MessageBox ( monsys.msg_title, "Quantity entered is not in standard pack increment!  Recommended quantity is " + String ( ldec_stdpack, "##########" ) + ".", Information! )
				end if
			end if
		end if
		// cbr end adding 3/30/00

	CASE "weight"

		ldec_weight = Dec ( data )

		SELECT part_inventory.unit_weight  
		  INTO :ldec_unit_weight  
		  FROM part_inventory  
		 WHERE part_inventory.part = :szPart ;
		dQty = ( ldec_weight / ldec_unit_weight )
		SetItem ( GetRow ( ), "quantity", dQty )

		if is_price_type = "B" then
			if is_inv_reg_col = "quantity" then
				dPrice = wf_find_break ( dQty, False )
			else
				dPrice = wf_find_break ( ldec_weight, False )
			end if
		else
			if f_get_calc_type ( ) = "quantity" then
				l_dec_calc_qty = dQty
			else
				l_dec_calc_qty = ldec_weight
			end if
			
			sqlca.of_calculate_multicurrency_price ( '', dw_header.GetItemString ( 1, "currency_unit" ), &
				f_calculate_customer_price ( szPart, szCustomer, l_dec_calc_qty ), dPrice )
		end if
		
		dw_detail_info.SetItem ( 1, "price", dPrice )

	CASE "customer_part"
		if isnull ( GetItemString ( 1, "part_number" ), '' ) = '' then
			szCustomer = dw_header.GetItemString ( 1, "customer" )
			ls_customer_part = String ( data )
	
			select part into :szPart from part_customer where customer_part = :ls_customer_part and customer = :szCustomer ;
			SetItem ( 1, "part_number", szPart )
			
			IF szPart = "" THEN
				Settext( '' )
				MessageBox ( monsys.msg_title, "Invalid part number!", StopSign! )
				szPart = ""
				szdesc = ""
				szstdunit = ""
				This.SetItem ( 1, "product_name", szDesc )
				This.SetItem ( 1, "unit", szStdUnit )	
				This.SetItem ( 1, "type", "" )	
				This.SetItem ( 1, "quantity", l_n_qty )
				This.SetItem ( 1, "weight", l_n_qty )
				breset = TRUE
				Return 1
			END IF
		
			SELECT part.name  
			  INTO :szDesc  
			  FROM part  
			 WHERE part.part = :szPart   ;
	
			IF SQLCA.SQLCode <> 0 THEN
				MessageBox ( monsys.msg_title, "Invalid part number!", StopSign! )
				Settext( '' )
				szPart = ""
				szdesc = ""
				szstdunit = ""
				This.SetItem ( 1, "product_name", szDesc )
				This.SetItem ( 1, "unit", szStdUnit )	
				This.SetItem ( 1, "type", "" )
				This.SetItem ( 1, "quantity", l_n_qty )
				This.SetItem ( 1, "weight", l_n_qty )
				breset = TRUE
				ib_Changed = TRUE
				Return 1
			END IF
			
			breset = FALSE
			wf_setup_values_part ( szpart, szdesc ) // moved all the code to the function to call the same from various places..
		end if
END CHOOSE


end event

event editchanged;ib_Changed = True


end event

event itemfocuschanged;szpart = this.object.part_number [1]

IF getcolumnname () <> 'part_number' AND breset THEN
   SELECT part.name  
  	  INTO :szDesc  
     FROM part  
    WHERE part.part = :szPart   ;

	IF SQLCA.SQLCode = 0 THEN
		breset = FALSE
		wf_setup_values_part ( szpart, szdesc )
	END IF
END IF

end event

event clicked;If dwo.name = 'part_number' Then
	If This.Describe ( "part_number.dddw.ShowList" ) = "yes" Then &
		This.Modify ( "part_number.dddw.ShowList=no" )
End if
end event

event itemerror;IF dwo.name = 'part_number' THEN RETURN 1

end event

event constructor;datawindowchild	ldwc_dddw

this.GetChild ( "customer_part", ldwc_dddw )
ldwc_dddw.SetTransObject ( sqlca )
if ldwc_dddw.Retrieve ( szCustomer ) < 1 then
	ldwc_dddw.Insertrow ( 1 )
end if

this.settransobject ( sqlca )
end event

type cb_1 from commandbutton within w_orders_detail
boolean visible = false
integer x = 3634
integer y = 532
integer width = 640
integer height = 336
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type cb_background from commandbutton within w_orders_detail
boolean visible = false
integer x = 2898
integer y = 56
integer width = 2217
integer height = 1432
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type st_3 from statictext within w_orders_detail
boolean visible = false
integer x = 3721
integer y = 592
integer width = 489
integer height = 208
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
boolean enabled = false
string text = "Retrieving Part    Numbers.      Please Wait..."
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_orders_detail
boolean visible = false
integer x = 2976
integer y = 464
integer width = 352
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
string text = "With Notes "
end type

on constructor;BringToTop = TRUE
end on

on clicked;dw_detail.DataObject = "d_normal_detail_with_notes"
dw_detail.Show ( )
dw_detail.SetTransObject ( sqlca )
dw_detail.Retrieve ( lOrder )

end on

type rb_1 from radiobutton within w_orders_detail
boolean visible = false
integer x = 3013
integer y = 544
integer width = 270
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77897888
string text = "Normal"
boolean checked = true
end type

on clicked;dw_detail.DataObject = "d_detail_no_notes"
dw_detail.SetTransObject ( sqlca )
dw_detail.Show ( )
dw_detail.BringToTop = True
dw_detail.Retrieve ( lOrder )

end on

type st_1 from statictext within w_orders_detail
integer x = 1943
integer y = 544
integer width = 887
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "(Single click to highlight item for shipper)"
boolean focusrectangle = false
end type

type em_3 from editmask within w_orders_detail
integer x = 2002
integer y = 1264
integer width = 256
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean border = false
alignment alignment = right!
string mask = "###,##0.00"
end type

type em_2 from editmask within w_orders_detail
integer x = 2002
integer y = 1200
integer width = 256
integer height = 60
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean border = false
alignment alignment = right!
string mask = "###,##0.00"
end type

type em_4 from editmask within w_orders_detail
integer x = 2002
integer y = 1324
integer width = 256
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean border = false
alignment alignment = right!
string mask = "###,##0.00"
end type

type em_1 from editmask within w_orders_detail
integer x = 1481
integer y = 1264
integer width = 270
integer height = 56
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean border = false
alignment alignment = right!
string mask = "###,##0.00"
end type


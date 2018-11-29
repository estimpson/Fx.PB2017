$PBExportHeader$w_customer_setup_with_destinations.srw
$PBExportComments$mad
forward
global type w_customer_setup_with_destinations from w_sheet_4t
end type
type sle_2 from singlelineedit within w_customer_setup_with_destinations
end type
type sle_1 from singlelineedit within w_customer_setup_with_destinations
end type
type rb_2 from radiobutton within w_customer_setup_with_destinations
end type
type rb_1 from radiobutton within w_customer_setup_with_destinations
end type
type p_1 from picture within w_customer_setup_with_destinations
end type
type lb_1 from listbox within w_customer_setup_with_destinations
end type
type dw_1 from datawindow within w_customer_setup_with_destinations
end type
type dw_2 from datawindow within w_customer_setup_with_destinations
end type
type dw_5 from datawindow within w_customer_setup_with_destinations
end type
type st_customer_attached from statictext within w_customer_setup_with_destinations
end type
type dw_3 from datawindow within w_customer_setup_with_destinations
end type
type lb_2 from listbox within w_customer_setup_with_destinations
end type
type gb_1 from groupbox within w_customer_setup_with_destinations
end type
type dw_4 from datawindow within w_customer_setup_with_destinations
end type
type gb_2 from groupbox within w_customer_setup_with_destinations
end type
type dw_6 from datawindow within w_customer_setup_with_destinations
end type
type cb_note from commandbutton within w_customer_setup_with_destinations
end type
type rb_note_shipper from radiobutton within w_customer_setup_with_destinations
end type
type cbx_note_print_shipper from checkbox within w_customer_setup_with_destinations
end type
type rb_note_bol from radiobutton within w_customer_setup_with_destinations
end type
type mle_note from multilineedit within w_customer_setup_with_destinations
end type
type cb_note_save from commandbutton within w_customer_setup_with_destinations
end type
type cb_note_cancel from commandbutton within w_customer_setup_with_destinations
end type
type cbx_note_print_bol from checkbox within w_customer_setup_with_destinations
end type
end forward

shared variables

end variables

global type w_customer_setup_with_destinations from w_sheet_4t
integer x = 214
integer y = 221
string title = "Customer / Destination Setup"
string menuname = "m_customer_destination_menu"
event copy_customer pbm_custom01
event save_shipper pbm_custom02
event save_customer pbm_custom03
event delete_customer pbm_custom04
event save_destination pbm_custom05
event delete_destination pbm_custom06
event ue_exit pbm_custom07
event add_customer ( )
event add_destination pbm_custom09
event ue_sync_cust pbm_custom10
sle_2 sle_2
sle_1 sle_1
rb_2 rb_2
rb_1 rb_1
p_1 p_1
lb_1 lb_1
dw_1 dw_1
dw_2 dw_2
dw_5 dw_5
st_customer_attached st_customer_attached
dw_3 dw_3
lb_2 lb_2
gb_1 gb_1
dw_4 dw_4
gb_2 gb_2
dw_6 dw_6
cb_note cb_note
rb_note_shipper rb_note_shipper
cbx_note_print_shipper cbx_note_print_shipper
rb_note_bol rb_note_bol
mle_note mle_note
cb_note_save cb_note_save
cb_note_cancel cb_note_cancel
cbx_note_print_bol cbx_note_print_bol
end type
global w_customer_setup_with_destinations w_customer_setup_with_destinations

type variables
String	is_Customer, &
	is_Destination, &
	is_CurrDest, &
	is_CurrCust, &
	is_NoteShipper, &
	is_NoteBOL, &
	is_Selection,&
	is_ai_type,&
                is_module = 'CM'

Boolean	ib_DestEDI = FALSE, &
	ib_CustChanged=FALSE, &
	ib_DestChanged=FALSE

Int                 ii_seq=1       

DataWindowChild i_dwc_custom, &
                                     i_dwc_custom2, &
                                     i_dwc_custom3, &
                                     i_dwc_custom4, &
                                     i_dwc_custom5
end variables

forward prototypes
public subroutine wf_show_note (boolean bflag)
public subroutine wf_flash_note_logo ()
public function boolean wf_check_for_orphans (string as_string, string as_mode)
public subroutine reset_destination ()
public subroutine check_changes ()
public subroutine show_destination (boolean ab_reset)
public subroutine show_destination_list ()
public subroutine show_customer ()
public subroutine show_attachment (boolean ab_show)
public subroutine wf_retrieve_child ()
end prototypes

event copy_customer;//
//  Declare Variables
//

Long 		l_Row1, &
			l_Row2, &
			l_Row3

String 	s_Code, &
			s_Name, &
			s_Add1, &
			s_Add2, &
			s_Add3, &
			s_Add4, &
			s_Add5, &
			s_Add6, &			
		 	s_Company,&
			ls_default_currency_unit,&
			ls_cs_status

INT		li_show_euro_amount


//
//  Initialize Variables
//

rb_2.Checked = False
rb_1.Checked = True

IF is_Customer = '' THEN Return

SELECT customer,   
       name,   
       address_1,   
       address_2,   
       address_3,   
       address_4,   
       address_5,   
       address_6,   
       company,
		 default_currency_unit,
		 show_euro_amount,
		 cs_status
  INTO :s_Code,   
       :s_Name,   
       :s_Add1,   
       :s_Add2,   
       :s_Add3,
       :s_Add4,   
       :s_Add5,   
       :s_Add6,
       :s_Company,
		 :ls_default_currency_unit,
		 :li_show_euro_amount,
		 :ls_cs_status
  FROM customer
 WHERE customer = :is_Customer   ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( Monsys.msg_title, "Unable to retrieve customer information!", StopSign! )
	Return
End if

INSERT INTO destination
	       ( destination,   
            name,   
            company,   
            type,   
            address_1,   
            address_2,   
            address_3,   
            address_4,   
            address_5,   
            address_6,   
            customer,   
            vendor,
				default_currency_unit,
				show_euro_amount,
				cs_status)  
	VALUES ( :s_Code,   
            :s_Name,   
            :s_Company,   
            '',   
            :s_Add1,   
            :s_Add2,   
            :s_Add3,   
            :s_Add4,   
            :s_Add5,   
            :s_Add6,   
            :is_Customer,   
            '',
				:ls_default_currency_unit,
				:li_show_euro_amount,
				:ls_cs_status )  ;

If SQLCA.SQLCode = -1 Then
	MessageBox ( Monsys.msg_title, "Destination already assigned; Cannot override!" , StopSign! )
	RollBack ;
	Return
Else
	COmmit;
 	INSERT INTO destination_shipping
	          ( destination,   
	            scac_code,   
	            trans_mode,   
	            dock_code_flag,   
	            model_year_flag,   
	            fob,   
	            freight_type,   
	            note_for_shipper,   
	            note_for_bol,   
	            print_shipper_note,   
	            print_bol_note )  
 	   VALUES ( :s_Code,   
	            ' ',   
	            ' ',   
	            ' ',   
	            '',   
	            '',   
	            '',   
	            '',   
	            '',   
	            '',   
    		      '' )  ;
	
	If SQLCA.SQLCode = -1 Then
		MessageBox ( Monsys.msg_title, "Unable to save to destination_shipper!", StopSign! )
		RollBack ;
	Else
	   INSERT INTO edi_setups
		 	       ( destination,   
		            supplier_code,   
		            trading_partner_code,   
		            release_flag,   
		            auto_create_asn,   
		            asn_overlay_group,   
		            equipment_description,   
		            pool_flag,   
		            pool_code,   
		            material_issuer,   
		            id_code_type,   
		            check_model_year,   
		            check_po,   
		            prev_cum_in_asn,   
		            parent_destination )  


		   VALUES ( :s_Code,   
		            ' ',   
		            ' ',   
		            ' ',   
		            ' ',   
		            '',   
		            '',   
		            ' ',   
		            '',   
		            '',   
		            '',   
		            '',   
		            '',   
		            '',   
		            '' )  ;
		If SQLCA.SQLCode = -1 Then
			MessageBox ( Monsys.msg_title, "Unable to save to EDI_Setups!"+ SQLCA.SQLERRTEXT, StopSign! )
			RollBack ;
		Else
			Commit ;
		End if
	End if
End if

is_Destination = s_Code
is_CurrDest = is_Destination
lb_2.SelectItem ( "Standard", 0 )
Show_Destination_List ( )
Show_Destination ( TRUE )
end event

event save_shipper;LONG		l_Row1

IF ib_DestChanged = FALSE THEN Return

If dw_4.DataObject <> "d_destination_shipping" Then
	MessageBox ( Monsys.msg_title, "Use 'Save Dest' button on toolbar to save standard information!", StopSign! )
	Return
End if

If dw_4.Update ( ) = -1 Then
	RollBack ;
	gnv_App.of_GetFrame().SetMicroHelp ( "Save failed!" )
	Return
Else
	ib_DestChanged = FALSE
	commit;
	gnv_App.of_GetFrame().SetMicroHelp ( "Setup saved!" )
End If
wf_flash_note_logo ( )
end event

event save_customer;//
//  Declare Variables
//

Long 		l_Row
int		li_count
string	ls_status,&
			ls_type

//
//  Initialize Variables
//

l_Row = dw_3.GetRow ( )
is_CurrCust = dw_3.GetItemString ( l_Row, "customer" )

//
//	Check for required save conditions
//

IF dw_3.RowCount ( ) = 0 THEN Return
IF ib_CustChanged = FALSE THEN Return

ls_status = dw_3.GetItemString ( 1, "cs_status" )

select 	status_type
into		:ls_type
from		customer_service_status
where		status_name = :ls_status ;

if isnull(ls_type,'') = 'C' then
	select	count(order_detail.order_no)
	into		:li_count
	from		order_header, order_detail
	where		order_header.order_no = order_detail.order_no and
				order_header.customer = :is_currcust ;
				
	if li_count > 0 then
		MessageBox ( "Save Customer", "Customer's status can not be changed to a closed type status with open orders.", Information! )
		return
	end if
	
	select	count(*)
	into		:li_count
	from		shipper
	where		shipper.customer = :is_currcust and
				shipper.status = 'O' or
				shipper.status = 'S' ;
				
	if li_count > 0 then
		MessageBox ( "Save Customer", "Customer's status can not be changed to a closed type status with open shippers.", Information! )
		return
	end if
end if

//
//	Perform Save
//

If dw_3.Update ( ) = -1 Then
	RollBack ;
	Return
End if
 
//update customer 

dw_6.Update()
ib_CustChanged = FALSE

SELECT count(*)
INTO		:li_count
FROM		customer_additional
WHERE		customer = :is_CurrCust ;

if li_count < 1 then
	INSERT INTO customer_additional ( 
		customer,
		type,
		platinum_id )
		VALUES (
		:is_currcust,
		'',
		'' ) ;
	if sqlca.sqlcode <> 0 then
		RollBack ;
		Return
	end if		
end if

Commit ;

IF is_Customer = '' THEN
	dw_1.Retrieve ( )
	l_Row = dw_1.Find ( "customer = '" + is_CurrCust + "'", 1, dw_1.RowCount ( ) )
	dw_1.ScrollToRow ( l_Row )
	SelectRow ( dw1, 0, False )
	SelectRow ( dw1, l_Row, True )
	is_Customer = is_CurrCust
END IF
end event

event delete_customer;//
//  Declare Variables
//

Long 		l_Row
string	l_s_message
Int 		i_Answer

l_row = dw_1.getselectedrow(0)
//
// Check for required delete conditions
//

IF is_Customer = '' THEN Return

//
//  Check for dependencies
//

If wf_check_for_orphans ( is_Customer, "Customer" ) Then
	MessageBox ( Monsys.msg_title, "This customer is referenced somewhere in the system.  Unable to delete!", StopSign! )
	Return
End if

//
//	Give last chance then perform delete
//

i_Answer = MessageBox ( Monsys.msg_title, "Are you sure you want~rto delete " + is_Customer + "?", Question!, OkCancel!, 2 )
If i_Answer = 2 Then Return

DELETE FROM customer_additional
WHERE customer = :is_currcust ;

if sqlca.sqlcode <> 0 then
	l_s_message = sqlca.sqlerrtext

	Rollback;
	MessageBox ( Monsys.msg_title, "Deletion of record failed!~r" + l_s_message, StopSign! )
	Return
end if

dw_1.DeleteRow ( l_Row )
If dw_1.Update ( ) = -1 Then
	l_s_message = sqlca.sqlerrtext
	RollBack ;
	MessageBox ( Monsys.msg_title, "Deletion of record failed!~r" + l_s_message, StopSign! )
	Return
Else
	Commit ;
	ib_CustChanged = FALSE
End if

dw_1.SelectRow ( 0, FALSE )
is_Customer = ''
is_CurrCust = ''
dw_2.Reset ( )
dw_3.Reset ( )
lb_1.SelectItem ( 0 )
lb_2.SelectItem ( 0 )
end event

event save_destination;//	Save changes to destination
//	May 16, 1997

//
//  Declare Variables
//

String	ls_Customer, &
		ls_Dummy

//	If no changes then get out.
IF ib_DestChanged = FALSE THEN Return

//	If not destination setups, but rather shipper setups, pop message and get out.
IF NOT dw_4.DataObject = "d_destination_setup" THEN
	MessageBox ( Monsys.msg_title, "Use 'Save Ship' button on toolbar to save shipping information!", StopSign! )
	Return
END IF

//	If nothing to update then get out.
IF dw_4.RowCount ( ) = 0 THEN Return

//	If per customer is selected then set ls_Customer = is_CurrCust, otherwise ls_Customer remains null.
IF rb_1.Checked = TRUE THEN
	ls_Customer = is_CurrCust
END IF

//	Prepare datawindow for update.
dw_4.SetItem ( 1, "customer", ls_Customer )
dw_4.AcceptText ( )

//	Update datawindow.
If dw_4.Update ( ) = -1 Then
	RollBack ;		
	Return
End If

is_CurrDest = dw_4.GetItemString(1, "destination")

//	Check dependant tables and insert record if needed
SELECT destination_shipping.destination  
  INTO :ls_Dummy
  FROM destination_shipping  
 WHERE destination_shipping.destination = :is_CurrDest   ;

If SQLCA.SQLCode <> 0 Then

	INSERT INTO destination_shipping
	          ( destination,   
	            scac_code,   
	            trans_mode,   
	            dock_code_flag,   
	            model_year_flag,   
	            fob,   
	            freight_type,   
	            note_for_shipper,   
   	         note_for_bol,   
	            print_shipper_note,   
	            print_bol_note,
					will_call_customer
					)  
	   VALUES ( :is_CurrDest,   
	            ' ',   
	            ' ',   
	            ' ',   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,
					'N'
					)  ; 

	If SQLCA.SQLCode = -1 Then
		Rollback ;
		Return
	End if
End if

SELECT edi_setups.destination  
  INTO :ls_Dummy
  FROM edi_setups  
 WHERE edi_setups.destination = :is_CurrDest   ;

If SQLCA.SQLCode <> 0 Then

	INSERT INTO edi_setups  
	          ( destination,   
	            supplier_code,   
	            trading_partner_code,   
	            release_flag,   
	            auto_create_asn,   
	            asn_overlay_group,   
	            equipment_description,   
	            pool_flag,   
	            pool_code,   
	            material_issuer,   
	            id_code_type,   
	            check_model_year,   
	            check_po,   
	            prev_cum_in_asn,   
	            parent_destination
					)  
	   VALUES ( :is_CurrDest,   
	            '',   
	            '',   
	            '',   
	            '',   
	            null,   
	            null,   
	            '',   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null,   
	            null
					)  ;

	If SQLCA.SQLCode = -1 Then
		RollBack ;
		Return
	End if
End if

//	Finish.
ib_DestChanged = FALSE
is_Destination = is_CurrDest
Commit ;
Show_Destination_List ( )
end event

event delete_destination;//
//  Declare Variables
//

Long l_Row

Int i_Answer

//
//  Initialize Variables
//

IF is_Destination = '' THEN Return

IF lb_2.SelectedItem ( ) <> "Standard" THEN
	dw_4.DataObject = "d_destination_setup"
	dw_4.SetTransObject ( sqlca )
	dw_4.Show ( )
	dw_4.Retrieve ( is_Destination )
END IF

////  If it is also referenced by a vendor then don't allow delete.
//
//If f_get_string_value ( dw_4.GetItemString ( 1, "vendor" ) ) <> "" AND &
//	Not IsNull (f_get_string_value ( dw_4.GetItemString ( 1, "vendor" ) ) THEN
//	MessageBox ( "Error", "This destination is attached to a vendor!  Unable to delete!", StopSign! )
//	Return
//End if

//  Check for dependencies
If wf_check_for_orphans ( is_Destination, "Destination" ) Then
	MessageBox ( Monsys.msg_title, "This destination is referenced somewhere in the system.  Unable to delete!", StopSign! )
	Return
End if


//
//  Ask if delete is ok
//

i_Answer = MessageBox ( Monsys.msg_title, "Are you sure you want~rto delete " + is_Destination + "?", Question!, YesNo!, 2 )


//
//  If not go back to main screen
//

If i_Answer = 2 Then Return

//
//  Otherwise delete the record
//

DELETE FROM destination_shipping  
 WHERE destination = :is_Destination   ;

If SQLCA.SQLCode = -1 Then 

	MessageBox ( Monsys.msg_title, "Deletion of record failed!~r" + SQLCA.SQLErrText, StopSign! )
	RollBack ;
	Return

End if

DELETE FROM edi_setups  
 WHERE destination = :is_Destination   ;

If SQLCA.SQLCode = -1 Then 

	MessageBox ( Monsys.msg_title, "Deletion of record failed!~r" + SQLCA.SQLErrText, StopSign! )
	RollBack ;
	Return

End if

dw_2.DeleteRow ( l_Row )

If dw_2.Update ( ) = -1 Then
	MessageBox ( Monsys.msg_title, "Deletion of record failed!~r" + SQLCA.SQLErrText, StopSign! )
	RollBack ;
	Return
Else
	Commit ;
End if

ib_DestChanged = FALSE
is_Destination = ''
is_CurrDest = ''
Reset_Destination ( )
Show_Destination_List ( )
lb_2.SelectItem ( 0 )
end event

event ue_exit;
close (this)

end event

event add_customer;LONG 		l_Row
string	ls_status

dw_1.SelectRow ( 0, False )

IF rb_1.Checked = TRUE THEN
	dw_2.Reset ( )
END IF
Reset_Destination ( )
dw_5.Reset ( )
p_1.Visible = FALSE

select 	max ( status_name )
into		:ls_status
from		customer_service_status
where		default_value = 'Y' ;

is_Customer = ''
dw3.Reset ( )
dw3.Modify ( "customer.TabSequence=10" )
dw3.InsertRow ( 0 )
dw3.SetItem ( 1, "cs_status", ls_status )
dw3.SetColumn ( "customer" )
dw3.SetFocus ( )


end event

event add_destination;string	ls_status

IF is_CurrCust = '' THEN
	MessageBox ( Monsys.msg_title, "You have to have a customer selected to add a destination!", StopSign! )
	RETURN
END IF

lb_2.SelectItem ( 0 )
lb_2.SelectItem ( 'Standard', 0 )
dw_5.Visible = FALSE
p_1.Visible = FALSE

select	cs_status
into		:ls_status
from		customer
where		customer = :is_currcust  ;

if isnull(ls_status,'') = '' then
	select 	max ( status_name )
	into		:ls_status
	from		customer_service_status
	where		default_value = 'Y' ;
end if

dw4.DataObject = 'd_destination_setup'
dw4.SetTransObject ( SQLCA )
dw4.Modify ( "destination.TabSequence=10" )
dw4.InsertRow ( 0 )
dw4.SetItem ( 1, "cs_status", ls_status )
dw4.SetColumn ( "destination" )
dw4.SetFocus ( )
dw2.SelectRow ( 0, FALSE )
dw2.visible = TRUE
end event

event ue_sync_cust;Open ( w_ai_customer_sync )
end event

public subroutine wf_show_note (boolean bflag);cb_note.visible					= bFlag
cb_note_save.visible				= bFlag
cb_note_cancel.visible        = bFlag
rb_note_bol.visible				= bFlag
rb_note_shipper.visible			= bFlag
cbx_note_print_bol.visible		= bFlag
cbx_note_print_shipper.visible= bFlag
mle_note.visible					= bFlag

end subroutine

public subroutine wf_flash_note_logo ();	If dw_4.RowCount() > 0 then
		is_NoteShipper						= dw_4.GetItemString(1, "note_for_shipper")
		is_NoteBOL							= dw_4.GetItemString(1, "note_for_bol")	
		If (Trim(is_NoteShipper) > " ") or (Trim(is_NoteBOL) > " ") then
		Timer(0.5)
		Else 
			Timer(0)
			p_1.picturename	= "noteno.bmp"
		End If		
	Else
		Timer(0)
		p_1.picturename		= "noteno.bmp"
	End If

end subroutine

public function boolean wf_check_for_orphans (string as_string, string as_mode);Long		l_Dummy
String	s_Dummy

If as_Mode = "Customer" Then
	
	 SELECT customer 
	  INTO :s_dummy
	  FROM customer
	 WHERE customer= :as_string ;

	DECLARE valid_customers CURSOR FOR  
	 SELECT destination.destination  
      FROM destination  
     WHERE destination.customer = :as_String   ;

	Open valid_customers ;
	Fetch valid_customers Into :s_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_customers ;
		Return True
	End if
	Close valid_customers ;

	DECLARE valid_order_customer CURSOR FOR  
	 SELECT order_header.order_no  
	   FROM order_header  
	  WHERE order_header.customer = :as_String  ;
	
	Open valid_order_customer ;
	Fetch valid_order_customer Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_order_customer ;
		Return True
	End if
	Close valid_order_customer ;
	
	
	DECLARE valid_shipper_customer CURSOR FOR  
	 SELECT shipper.id  
	   FROM shipper  
	  WHERE shipper.customer = :as_String  ;
	
	Open valid_shipper_customer ;
	Fetch valid_shipper_customer Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_shipper_customer ;
		Return True
	End if
	Close valid_shipper_customer ;
	
	DECLARE valid_part_customer CURSOR FOR  
	 SELECT part_customer.customer_standard_pack  
	   FROM part_customer  
	  WHERE part_customer.customer = :as_String   ;

	Open valid_part_customer ;
	Fetch valid_part_customer Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_shipper_customer ;
		Return True
	End if
	Close valid_shipper_customer ;
	
//	 SELECT customer 
//	  INTO :s_dummy
//	  FROM customer
//	 WHERE customer= :as_string ;
	IF SQLCA.sqlcode=0 THEN
		Return True
	END IF 		

Elseif as_Mode = "Destination" Then

	DECLARE valid_order_destination CURSOR FOR  
	 SELECT order_header.order_no  
	   FROM order_header  
	  WHERE order_header.destination = :as_String   ;

	Open valid_order_destination ;
	Fetch valid_order_destination Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_order_destination ;
		Return True
	End if
	Close valid_order_destination ;


	DECLARE valid_shipper_destination CURSOR FOR  
	 SELECT shipper.id  
	   FROM shipper  
	  WHERE shipper.destination = :as_String   ;

	Open valid_shipper_destination ;
	Fetch valid_shipper_destination Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_shipper_destination ;
		Return True
	End if
	Close valid_shipper_destination ;


	DECLARE valid_po_destination CURSOR FOR  
	 SELECT po_header.po_number  
	   FROM po_header  
	  WHERE po_header.ship_to_destination = :as_String   ;

	Open valid_po_destination ;
	Fetch valid_po_destination Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_po_destination ;
		Return True
	End if
	Close valid_po_destination ;


End if

Return False
end function

public subroutine reset_destination ();Check_Changes ( )
dw_5.Reset ( )
p_1.Visible = FALSE
dw_4.Reset ( )
end subroutine

public subroutine check_changes ();//integer	i_mess1, i_mess2

// Any changes in customer that is not saved ?

/*If ib_CustChanged THEN
	IF is_CurrCust = "" THEN
		dw_3.AcceptText ( )
		is_CurrCust = dw_3.GetItemString ( dw_3.GetRow ( ), "customer" )
	END IF
	IF is_CurrCust = "" THEN Return
	i_mess1=Messagebox ( "Warning", " Do you want save changes to " + is_CurrCust + "'s standard information?", Question!, YesNo!, 1 )
	If  i_mess1 = 1 Then
		If	dw_3.update () = 1 Then
			commit;
		Else
			Rollback;
			Messagebox ("warning", "Invalid datatype!, changes cannot be updated" )
			Return
		End If
	End If
	ib_CustChanged = FALSE
End If

// Any changes in destination that is not saved ?

If ib_DestChanged = TRUE Then
	IF dw_4.DataObject = "d_destination_shipping" Then
		i_mess2 = Messagebox ( "Warning", "Do you want to save changes to " + is_CurrDest + "'s shipping information?", Question!, YesNo!, 1 )
	ELSE
		i_mess2 = Messagebox ( "Warning", "Do you want to save changes to " + is_CurrDest + "'s standard information?", Question!, YesNo!, 1 )
	END IF
	If  i_mess2 = 1 Then
		If dw_4.DataObject = "d_destination_shipping" Then
			This.TriggerEvent ("save_shipper")
		ELSE
			This.TriggerEvent ("save_destination")
		End if
	End If
	ib_DestChanged = FALSE
End If*/

integer	i_mess1, i_mess2, l_row

// Any changes in customer that is not saved ?

If ib_CustChanged THEN
	IF is_CurrCust = "" THEN
		dw_3.AcceptText ( )
		dw_3.SetColumn("customer")
		is_CurrCust = dw_3.GetText() 
	END IF
	IF is_CurrCust = "" THEN Return
	i_mess1=Messagebox ( Monsys.msg_title, " Do you want save changes to " + is_CurrCust + "'s standard information?", Question!, YesNo!, 1 )
	If  i_mess1 = 1 Then
		If	dw_3.update () = 1 Then
			COMMIT ;
			dw_1.Retrieve ( )
			l_Row = dw1.Find ( "customer = '" + is_CurrCust + "'", 1, dw1.RowCount ( ) )
			dw1.ScrollToRow ( l_Row )
			ib_CustChanged = FALSE
			is_Customer = is_CurrCust	
		ELSE
			ROLLBACK;
			MessageBox (Monsys.msg_title, "Invalid Data!, Changes could not be saved" )
			RETURN
		END IF
	End If
End If

// Any changes in destination that is not saved ?

If ib_DestChanged = TRUE Then
	IF dw_4.DataObject = "d_destination_shipping" Then
		i_mess2 = Messagebox ( Monsys.msg_title, "Do you want to save changes to " + is_CurrDest + "'s shipping information?", Question!, YesNo!, 1 )
	ELSE
		i_mess2 = Messagebox ( Monsys.msg_title, "Do you want to save changes to " + is_CurrDest + "'s standard information?", Question!, YesNo!, 1 )
	END IF
	If  i_mess2 = 1 Then
		If dw_4.DataObject = "d_destination_shipping" Then
			This.TriggerEvent ("save_shipper")
		ELSE
			This.TriggerEvent ("save_destination")
		End if
	End If
	ib_DestChanged = FALSE
End If

end subroutine

public subroutine show_destination (boolean ab_reset);//
//	Declare Variables
//

Long 		l_Column

String 	s_ScacDesc, &
			s_Scac, &
			s_TransModeDesc, &
			s_TransMode

//
// Check for changes before changing and data windows
//

Check_Changes ( )

IF ab_Reset THEN
	//
	//	Clear area for destination data window
	//
	Reset_Destination ( )
END IF

//
//	Change dw_4 to Standard or Shipping
//

IF lb_2.SelectedItem ( ) = "Standard" THEN
	dw_4.DataObject = "d_destination_setup"
ELSE
	dw_4.DataObject = "d_destination_shipping"
END IF
dw_4.SetTransObject ( sqlca )

//
//	Display new destination
//

dw_4.Show ( )
dw_4.Retrieve ( is_Destination )
dw_4.Modify ( "destination.TabSequence=0" )
dw_4.SetFocus ( )

//
//	Displays dw_5 and note logo if "Shipping" is selected.  Otherwise
//	turn them off.
//

IF lb_2.SelectedItem ( ) = "Shipping" THEN
	dw_5.Reset ( )
	dw_5.Visible = TRUE
	dw_5.InsertRow ( 1 )
	p_1.Visible = TRUE
   rb_2.BringToTop = True
	wf_flash_note_logo ( )
	IF dw_4.RowCount ( ) > 0 THEN
		s_Scac = dw_4.GetItemString ( dw_4.GetRow ( ), 2 )
		s_TransMode = dw_4.GetItemString ( dw_4.GetRow ( ), 3 )
		If s_Scac <> '' THEN

				SELECT name
				  INTO	:s_ScacDesc
				  FROM	carrier
				 WHERE	scac = :s_Scac  ;

				SELECT description
				  INTO :s_TransModeDesc  
		        FROM trans_mode
		       WHERE code = :s_TransMode   ;

			dw_5.SetItem ( 1, "scac_description", s_ScacDesc )
			dw_5.SetItem ( 1, "trans_mode_description", s_TransModeDesc )
		End If
	ELSE
		dw_4.InsertRow ( 1 )
		dw_4.SetItem ( 1, 1, is_CurrDest )
		dw_4.SetItem ( 1, 2, '' )
		dw_4.SetItem ( 1, 3, '' )
		dw_4.SetItem ( 1, 4, '' )
	END IF
ELSE
	dw_5.Reset ( )
	p_1.Visible = FALSE
END IF
end subroutine

public subroutine show_destination_list ();//
//  Declare Variables
//

Long l_Row

//
//	Check for don't show conditions.
//

IF rb_1.Checked = TRUE THEN
	Show_Attachment ( FALSE )
END IF

IF rb_1.Checked = TRUE and is_Customer = '' THEN
	dw_2.Reset ( )
	dw_2.Visible = FALSE
	is_Destination = ''

	is_CurrDest = ''
	Reset_Destination ( )
	Return
END IF

//
//  Initialize destination list
//

dw_2.Reset ( )
dw_2.Visible = FALSE
dw_2.Retrieve ( )
dw_2.SelectRow ( 0, FALSE )
dw_2.SetFilter ( "" )
dw_2.Filter ( )
IF rb_1.Checked = TRUE THEN
	dw_2.SetFilter ( "customer = '" + is_Customer + "'" )
	dw_2.Filter ( )
END IF
dw_2.SetSort ( "destination A" )
dw_2.Sort ( )
dw_2.Visible = TRUE

//
//	If destination and per customer is selected, search destination list
//	for current destination, else reset destination.  Then return
//

IF rb_1.Checked = TRUE THEN
	Show_Attachment ( FALSE )
	IF is_Destination <> '' THEN
		l_Row	= dw_2.Find ( "destination = '" + is_Destination + "'", 1, dw_2.RowCount ( ) )
		IF l_Row > 0 THEN
			dw_2.SelectRow ( 0, FALSE )
			dw_2.SelectRow ( l_Row, TRUE )
			dw_2.ScrollToRow ( l_Row )
		ELSE
			Check_Changes ( )
			is_Destination = ''
			is_CurrDest = ''
			Reset_Destination ( )
		END IF
		Return
	END IF
	Reset_Destination ( )
END IF

//
//	Show all is selected.  If destination is not selected, exit.
//

IF is_destination = '' THEN Return

//
//	Find destination in destination list
//

l_Row	= dw_2.Find ( "destination = '" + is_Destination + "'", 1, dw_2.RowCount ( ) )
dw_2.SelectRow ( 0, FALSE )
dw_2.SelectRow ( l_Row, TRUE )
dw_2.ScrollToRow ( l_Row )

//
//	If show attached information
//

Show_Attachment ( TRUE )
end subroutine

public subroutine show_customer ();IF rb_1.Checked = TRUE THEN
	Show_Destination_List ( )
END IF

Check_Changes ( )

dw_3.Modify ( "customer.TabSequence=0" )
wf_retrieve_child()
dw_3.Retrieve ( is_Customer )
end subroutine

public subroutine show_attachment (boolean ab_show);STRING s_DestCust

IF ab_Show THEN
	st_customer_attached.Visible = TRUE
	 SELECT destination.customer  
   	INTO :s_DestCust  
	   FROM destination  
	  WHERE destination.destination = :is_Destination   ;

	If SQLCA.SQLCode = 0 Then
		If f_get_string_value ( s_DestCust ) = '' Then
			st_customer_attached.Text = "No Customer Attached!"
		Else
			st_customer_attached.Show ( )
			st_customer_attached.Text = is_Destination + " is attached to customer: " + s_DestCust
		End if
	Else
		st_customer_attached.Text = "No Customer Attached!"
	End if
ELSE
	st_customer_attached.Visible = FALSE
END IF
end subroutine

public subroutine wf_retrieve_child ();   // custom1 
	i_dwc_custom.Settransobject(SQLCA)
   i_dwc_custom.Insertrow(0)
   i_dwc_custom.Retrieve(is_module,ii_seq)
	// custom2 
   i_dwc_custom2.Settransobject(SQLCA)
   i_dwc_custom2.Insertrow(0)
   i_dwc_custom2.Retrieve(is_module,ii_seq)
	// custom3 
   i_dwc_custom3.Settransobject(SQLCA)
   i_dwc_custom3.Insertrow(0)
   i_dwc_custom3.Retrieve(is_module,ii_seq)	
   // custom4 
   i_dwc_custom4.Settransobject(SQLCA)
   i_dwc_custom4.Insertrow(0)
   i_dwc_custom4.Retrieve(is_module,ii_seq)
	// custom5 
   i_dwc_custom5.Settransobject(SQLCA)
   i_dwc_custom5.Insertrow(0)
   i_dwc_custom5.Retrieve(is_module,ii_seq)	
end subroutine

on timer;If p_1.picturename	= "noteno.bmp" then
	p_1.picturename	= "noteyes.bmp"
Else
	p_1.picturename	= "noteno.bmp"
End If
end on

event activate;call super::activate;
if is_ai_type = "Platinum" then
	m_customer_destination_menu.m_file.m_acctsync.Visible = TRUE
	m_customer_destination_menu.m_file.m_acctsync.ToolBarItemVisible = TRUE
end if

If ib_DestEDI = True Then
	lb_2.SelectItem ( "Standard", 0 )
	ib_DestEDI = False
	Show_Destination ( FALSE )
	p_1.visible	= FALSE
End If
end event

event open;call super::open;//
//  If show program name parameter is 'Y' then append the title with it
//

String	s_ShowProgName
long		l_l_row

 SELECT	parameters.show_program_name,
			parameters.accounting_type
	INTO	:s_ShowProgName,
			:is_ai_type  
	FROM	parameters  ;

If s_ShowProgName = 'Y' Then 
	This.Title = This.Title + " [w_customer_setup_with_destinations]"
END IF

//
//  Declare Variables
//

Long l_Row

//
//	Initialize Variables
//

If IsNull ( Message.StringParm, '' ) > '' then
	IF LeftA ( Message.StringParm, 2 ) = "%%" THEN
		is_destination = RightA ( Message.StringParm, LenA ( Message.StringParm ) - 2 )
		SELECT	customer
		INTO		:is_customer
		FROM		destination
		WHERE		destination = :is_destination ;
	ELSE
		is_customer = Message.StringParm
	END IF
end if


is_ai_type = f_get_string_value ( is_ai_type )

dw1 = dw_1
dw2 = dw_2
dw3 = dw_3
dw4 = dw_4
rb1 = rb_1

dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )
dw_3.SetTransObject ( sqlca )
dw_4.SetTransObject ( sqlca )
dw_1.Retrieve ( )

//
//  Show customer enter update screen
//

dw_3.SetTransobject ( sqlca )
dw_3.Modify ( "customer.TabSequence=0" )

//
//  Retrieve destinations for customer
//

dw_2.SetTransObject ( sqlca )
rb_1.Checked = TRUE
Show_Destination_List ( )

rb_note_shipper.visible	= FALSE

//
//	Set listboxes to unselected
//

lb_1.SelectItem ( 0 )
lb_2.SelectItem ( 0 )

if is_customer > '' then
	l_l_row = dw_1.find ( "customer = '" + is_customer + "'", 1, dw_1.RowCount ( ) )
	if l_l_row > 0 then
		if dw_1.object.customer[l_l_row] = is_customer then
			dw_1.SelectRow ( 0, FALSE )
			dw_1.SelectRow ( l_l_row, TRUE )
			dw_3.Retrieve ( is_customer )
		end if
	end if
	IF is_destination > '' THEN
		l_l_row = dw_2.find ( "destination = '" + is_destination + "'", 1, dw_2.RowCount ( ) )
		if l_l_row > 0 then
			if dw_2.object.destination[l_l_row] = is_destination then
				dw_2.SelectRow ( 0, FALSE )
				dw_2.SelectRow ( l_l_row, TRUE )
				dw_4.Retrieve ( is_destination )
			end if
		end if
	END IF
else
	Trigger Event add_customer ( )
end if

sle_1.SetFocus ( )


end event

on w_customer_setup_with_destinations.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_customer_destination_menu" then this.MenuID = create m_customer_destination_menu
this.sle_2=create sle_2
this.sle_1=create sle_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.p_1=create p_1
this.lb_1=create lb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_5=create dw_5
this.st_customer_attached=create st_customer_attached
this.dw_3=create dw_3
this.lb_2=create lb_2
this.gb_1=create gb_1
this.dw_4=create dw_4
this.gb_2=create gb_2
this.dw_6=create dw_6
this.cb_note=create cb_note
this.rb_note_shipper=create rb_note_shipper
this.cbx_note_print_shipper=create cbx_note_print_shipper
this.rb_note_bol=create rb_note_bol
this.mle_note=create mle_note
this.cb_note_save=create cb_note_save
this.cb_note_cancel=create cb_note_cancel
this.cbx_note_print_bol=create cbx_note_print_bol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_2
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.lb_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.st_customer_attached
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.lb_2
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.dw_4
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.dw_6
this.Control[iCurrent+17]=this.cb_note
this.Control[iCurrent+18]=this.rb_note_shipper
this.Control[iCurrent+19]=this.cbx_note_print_shipper
this.Control[iCurrent+20]=this.rb_note_bol
this.Control[iCurrent+21]=this.mle_note
this.Control[iCurrent+22]=this.cb_note_save
this.Control[iCurrent+23]=this.cb_note_cancel
this.Control[iCurrent+24]=this.cbx_note_print_bol
end on

on w_customer_setup_with_destinations.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.p_1)
destroy(this.lb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.st_customer_attached)
destroy(this.dw_3)
destroy(this.lb_2)
destroy(this.gb_1)
destroy(this.dw_4)
destroy(this.gb_2)
destroy(this.dw_6)
destroy(this.cb_note)
destroy(this.rb_note_shipper)
destroy(this.cbx_note_print_shipper)
destroy(this.rb_note_bol)
destroy(this.mle_note)
destroy(this.cb_note_save)
destroy(this.cb_note_cancel)
destroy(this.cbx_note_print_bol)
end on

event close;call super::close;Check_Changes()
end event

type sle_2 from singlelineedit within w_customer_setup_with_destinations
event keyup pbm_keyup
integer x = 329
integer y = 896
integer width = 329
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event keyup;long	ll_row

ll_row = dw_2.Find ( "destination >= '" + text + "'", 1, dw_2.RowCount ( ) )
if ll_row > 0 then
	dw_2.ScrollToRow ( ll_row )
	dw_2.SelectRow ( 0, FALSE )
	dw_2.SelectRow ( ll_row, TRUE )
end if
end event

type sle_1 from singlelineedit within w_customer_setup_with_destinations
event keyup pbm_keyup
integer x = 311
integer width = 329
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event keyup;long	ll_row

ll_row = dw_1.Find ( "customer >= '" + text + "'", 1, dw_1.RowCount ( ) )
if ll_row > 0 then
	dw_1.ScrollToRow ( ll_row )
	dw_1.SelectRow ( 0, FALSE )
	dw_1.SelectRow ( ll_row, TRUE )
end if
end event

type rb_2 from radiobutton within w_customer_setup_with_destinations
integer x = 91
integer y = 1484
integer width = 398
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
string text = "Show All"
end type

on clicked;Show_Destination_List ( )
end on

type rb_1 from radiobutton within w_customer_setup_with_destinations
integer x = 91
integer y = 1412
integer width = 512
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
string text = "Per Customer"
end type

on clicked;Show_Destination_List ( )
end on

type p_1 from picture within w_customer_setup_with_destinations
boolean visible = false
integer x = 2505
integer y = 1312
integer width = 82
integer height = 76
string picturename = "noteno.bmp"
boolean focusrectangle = false
end type

on clicked;wf_show_note(TRUE)

mle_note.text				= " "

If dw_4.RowCount() > 0 then
	is_NoteShipper						= dw_4.GetItemString(1, "note_for_shipper")
	is_NoteBOL							= dw_4.GetItemString(1, "note_for_bol")
	
	If Trim(is_NoteShipper) > " " then
		mle_note.text				= dw_4.GetItemString(1, "note_for_shipper")
		rb_note_shipper.checked	= TRUE
	Else
		mle_note.text				= dw_4.GetItemString(1, "note_for_bol")
		rb_note_bol.checked		= TRUE
	End If

	cbx_note_print_shipper.checked= (dw_4.GetItemString(1, "print_shipper_note") = "Y") 
	cbx_note_print_bol.checked		= (dw_4.GetItemString(1, "print_bol_note")= "Y")
End If

end on

type lb_1 from listbox within w_customer_setup_with_destinations
integer x = 2459
integer y = 76
integer width = 361
integer height = 784
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean vscrollbar = true
string item[] = {"Standard","User Defined"}
end type

event selectionchanged;String szSelection
Long   l_l_rowno	

szSelection = lb_1.SelectedItem()
IF szSelection = "User Defined" THEN 
	IF is_currcust > '' THEN
	dw_6.retrieve(is_currcust)	
	IF dw_6.Rowcount() = 0 THEN
		l_l_rowno=dw_6.INSERTROW(0)
		IF l_l_rowno > 0 THEN 
			ib_custchanged=TRUE
			dw_6.SCROLLTOROW(l_l_rowno)
			dw_6.setitem(l_l_rowno,'customer',is_currcust)
		END IF
	END IF 
  END IF
	dw_3.BringToTop=FALSE
   dw_6.SHOW()
ELSE
   dw_6.HIDE()
	dw_3.BringToTop=TRUE
END IF

//If szSelection = "Contacts" OR szSelection = "Documents" OR szSelection = "Standard" Then
//	MessageBox ( "Information", "Sorry, this option will not be available~runtil a future release.", Information! )
//End If





//If szSelection = "Contacts" OR szSelection = "Documents" OR szSelection = "Standard" Then
//	MessageBox ( "Information", "Sorry, this option will not be available~runtil a future release.", Information! )
//End If
end event

type dw_1 from datawindow within w_customer_setup_with_destinations
integer x = 69
integer y = 80
integer width = 581
integer height = 784
string dataobject = "d_dddw_customers"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event clicked;//  Declare Variables
Long	l_Row

//  If no Row1 clicked then get out
l_Row = this.GetClickedRow ( )
IF l_Row < 1 THEN Return

//  Initialize Variables
is_CurrCust = is_Customer
is_Customer = this.GetItemString ( l_Row, "Customer" )

//  highlight current Row1
this.SelectRow ( 0, False )
this.SelectRow ( l_Row, True )

//	Show customer, destination list, etc.
Show_Customer ( )
is_CurrCust = is_Customer
is_CurrDest = ''
is_Destination = ''

dw_6.HIDE()
dw_3.BringToTop=TRUE
lb_1.Selectitem(0)
end event

type dw_2 from datawindow within w_customer_setup_with_destinations
integer x = 73
integer y = 976
integer width = 581
integer height = 416
string dragicon = "MONITOR.ICO"
string dataobject = "d_dddw_destination"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event clicked;//
//  Declare Variables
//

String 	s_Selection
String	s_Customer
Long 		lRow

lRow = This.GetClickedRow ( )

If lRow < 1 Then Return


//
//  Initialize Variables
//

SelectRow ( This, 0, False )
SelectRow ( This, lRow, True )

is_CurrDest = is_Destination
is_Destination = This.GetItemString ( lRow, "destination" )

lb_2.SelectItem ( "Standard", 0 )
IF rb_2.Checked = TRUE THEN Show_Attachment ( TRUE )
Show_Destination ( TRUE )
is_CurrDest = is_Destination
If (rb_1.Checked = False) and (dw_1.GetSelectedRow ( 0 ) >= 1) Then dw2.Drag ( BEGIN! )
end event

type dw_5 from datawindow within w_customer_setup_with_destinations
boolean visible = false
integer x = 1673
integer y = 968
integer width = 690
integer height = 152
string dataobject = "d_dest_shipping_setup_descriptions"
boolean border = false
end type

on getfocus;dw_4.SetFocus ( )
end on

type st_customer_attached from statictext within w_customer_setup_with_destinations
boolean visible = false
integer x = 370
integer y = 900
integer width = 1975
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_customer_setup_with_destinations
integer x = 672
integer y = 56
integer width = 1774
integer height = 824
string dataobject = "d_customer_eu"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String	s_Cust, &
			s_Temp

Long		ll_row

ib_CustChanged = TRUE
Choose case dwo.name
	Case "customer"
		s_Cust = dw_3.GetText ( )
	
		SELECT customer  
		  INTO :s_Temp  
		  FROM customer  
		 WHERE customer = :s_Cust   ;
	
		If SQLCA.SQLCode = 0 Then
			dw_3.SetTransObject ( sqlca )
			dw_3.Retrieve ( s_Cust )
			dw_3.Modify("customer.Tabsequence=0")
			ll_row = dw_1.Find ( "customer = '" + s_Cust + "'", 1, dw_1.RowCount ( ) )
			SelectRow ( dw_1, 0, False )
			SelectRow ( dw_1, ll_row, True )
			is_Customer = s_Cust
			is_CurrCust = is_Customer
			Show_Destination_List ( )
		End if
End choose
end event

event editchanged;ib_CustChanged=TRUE

end event

event constructor;DataWindowChild	ldwc_Terms
String				ls_Temp

 DECLARE terms CURSOR FOR  
  SELECT term.description  
    FROM term  
ORDER BY term.description ASC  ;

GetChild ( "term", ldwc_Terms )

Open terms ;
Do
	Fetch terms Into :ls_Temp ;
	If SQLCA.SQLCode = 0 Then
		ldwc_Terms.InsertRow ( 0 )
		ldwc_Terms.SetItem ( ldwc_Terms.RowCount ( ), "data", ls_Temp )
	End if
Loop While SQLCA.SQLCode = 0
Close terms ;

end event

event dragdrop;Long lRow 

String szCustomer,sTemp,l_s_customer


lRow = dw_1.GetRow ()

select customer
into :l_s_customer
from destination
where destination = :is_currdest;

If sqlca.sqlcode = 0 then
If MessageBox( monsys.msg_title, 'Destination already assigned to'  +  l_s_customer  +  '~r' + 'Reassigning will delete the destination from '  +  l_s_customer  +  '!', information!, OkCancel!, 1 ) = 2 Then
	dw_4.Reset()
	dw_4.SetColumn(1)
	Return
end if
end if

 szCustomer = dw_1.GetItemString( lRow, "customer" )
 lRow = dw_4.GetRow ()
 dw_4.SetItem ( lRow, "customer", szCustomer )
 

If dw_4.Update ( ) = -1 Then
	MessageBox ( "Monsys.msg_title", "Update to destination failed!~r" + SQLCA.SQLErrText, StopSign! )
	RollBack ;
	Return
End if

Commit ;

dw_2.Retrieve ( )

end event

type lb_2 from listbox within w_customer_setup_with_destinations
integer x = 2464
integer y = 972
integer width = 366
integer height = 424
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean vscrollbar = true
string item[] = {"EDI","Shipping","Standard"}
end type

event selectionchanged;LONG l_Row

l_Row = dw_2.GetSelectedRow ( 0 )
IF l_Row = 0 THEN
	lb_2.SelectItem ( 0 )	
	Return
END IF

is_CurrDest = is_Destination
Show_Destination ( FALSE )

is_Selection = lb_2.SelectedItem ( )
If is_Selection = '' Then Return
If is_Selection = 'EDI' Then
	ib_DestEDI = TRUE
	OpenSheetWithParm (w_destination_edi, is_Destination, gnv_App.of_GetFrame(), 3, Original! )
	Timer(0)
END IF

end event

type gb_1 from groupbox within w_customer_setup_with_destinations
integer x = 37
integer y = 16
integer width = 2816
integer height = 880
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
string text = "Customer"
end type

type dw_4 from datawindow within w_customer_setup_with_destinations
integer x = 672
integer y = 960
integer width = 1774
integer height = 612
integer taborder = 30
string dataobject = "d_destination_setup"
boolean vscrollbar = true
boolean border = false
end type

on editchanged;ib_DestChanged = TRUE
end on

event itemchanged;String	s_Column, &
			s_Dest, &
			s_Temp

Long		l_Row

ib_DestChanged = TRUE
If dw_4.DataObject = "d_destination_shipping" Then
 
	//
	//  Declare
	//

	Long l_Column
	
	String s_ScacDesc, s_Scac
	String s_TransModeDesc, s_TransMode, l_s_customer


	//
	//  Initialize
	//

	l_Column = dw_4.GetColumn ( )

	If l_Column = 2 Then

		s_Scac = dw_4.GetText ( )

	   SELECT trans_mode,   
   	       name  
	     INTO :s_TransMode,   
   	       :s_ScacDesc  
	     FROM carrier
	    WHERE scac = :s_Scac   ;

		dw_5.SetItem ( 1, "scac_description", s_ScacDesc )
		
		dw_4.SetItem ( 1, "trans_mode", s_TransMode )
		
		SELECT description
		  INTO :s_TransModeDesc  
        FROM trans_mode
       WHERE code = :s_TransMode   ;
	
		dw_5.SetItem ( 1, "trans_mode_description", s_TransModeDesc )

	Elseif l_Column = 3 Then

		s_TransMode = dw_4.GetText ( )

		SELECT description 
		  INTO :s_TransModeDesc  
        FROM trans_mode
       WHERE code = :s_TransMode   ;
	
		dw_5.SetItem ( 1, "trans_mode_description", s_TransModeDesc )
	End if
ELSE
	s_Column = dw_4.GetColumnName ( )

	If s_Column = "destination" Then
		s_Dest = dw_4.GetText ( )

	   SELECT destination, customer 
	   	 INTO :s_Temp ,
			      :l_s_customer
	     FROM destination 
	    WHERE destination = :s_Dest   ;

		If SQLCA.SQLCode = 0 Then
		 If l_s_customer > '' Then
		  If MessageBox( monsys.msg_title, 'Destination already assigned to'  +  l_s_customer   +  '~r'  +  'Reassigning will delete the destination from '  +  l_s_customer  +  '!', information!, OkCancel!, 1 ) = 2 Then	 	
			dw_4.reset()
			dw_4.setcolumn (1)
			RETURN
		  End If
		  	dw_4.SetTransObject ( sqlca )				
			dw_4.Retrieve ( s_Dest )
			l_Row = dw_2.Find ( "destination = '" + s_Dest + "'", 1, dw_2.RowCount ( ) )
			SelectRow ( dw_2, 0, False )
			SelectRow ( dw_2, l_Row, True )
			is_Destination = s_Dest
			is_CurrDest = is_Destination
		 End If
	   End If  
	  End If
	 End If
end event

type gb_2 from groupbox within w_customer_setup_with_destinations
integer x = 37
integer y = 892
integer width = 2816
integer height = 688
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
string text = "Destination"
end type

type dw_6 from datawindow within w_customer_setup_with_destinations
boolean visible = false
integer x = 663
integer y = 68
integer width = 1778
integer height = 680
integer taborder = 20
string dataobject = "d_customer_user_defined"
boolean border = false
boolean livescroll = true
end type

event constructor;GetChild ( "custom1", i_dwc_custom )
GetChild ( "custom2", i_dwc_custom2 )
GetChild ( "custom3", i_dwc_custom3 )
GetChild ( "custom4", i_dwc_custom4 )
GetChild ( "custom5", i_dwc_custom5 )
wf_retrieve_child()
This.Settransobject(SQLCA)
end event

event itemfocuschanged;Int l_i_col
l_i_col=This.GetColumn()
IF l_i_col>0 THEN ii_seq=l_i_col
CHOOSE CASE l_i_col
	CASE 1
		// custom1 
	   i_dwc_custom.Settransobject(SQLCA)
		i_dwc_custom.Insertrow(0)
	   i_dwc_custom.Retrieve(is_module,l_i_col)
	CASE 2		
		// custom2 
	   i_dwc_custom2.Settransobject(SQLCA)
		i_dwc_custom2.Insertrow(0)
	   i_dwc_custom2.Retrieve(is_module,l_i_col)
	CASE 3		
		// custom3 
	   i_dwc_custom3.Settransobject(SQLCA)
		i_dwc_custom3.Insertrow(0)
	   i_dwc_custom3.Retrieve(is_module,l_i_col)	
	CASE 4		
	   // custom4 
	   i_dwc_custom4.Settransobject(SQLCA)
		i_dwc_custom4.Insertrow(0)		
   	i_dwc_custom4.Retrieve(is_module,l_i_col)
	CASE 5				
		// custom5 
	   i_dwc_custom5.Settransobject(SQLCA)
		i_dwc_custom5.Insertrow(0)		
   	i_dwc_custom5.Retrieve(is_module,l_i_col)	
END CHOOSE
end event

event editchanged;ib_custchanged = TRUE
end event

event itemchanged;ib_custchanged = TRUE
end event

type cb_note from commandbutton within w_customer_setup_with_destinations
boolean visible = false
integer x = 315
integer y = 68
integer width = 2194
integer height = 1328
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type rb_note_shipper from radiobutton within w_customer_setup_with_destinations
boolean visible = false
integer x = 1883
integer y = 244
integer width = 517
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Note for Shipper"
end type

on clicked;If rb_note_bol.checked then
	is_NoteBOL			= mle_note.text
End If

rb_note_bol.checked	= FALSE

mle_note.text			= is_NoteShipper
end on

type cbx_note_print_shipper from checkbox within w_customer_setup_with_destinations
boolean visible = false
integer x = 1883
integer y = 348
integer width = 430
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Print on Shipper"
end type

type rb_note_bol from radiobutton within w_customer_setup_with_destinations
boolean visible = false
integer x = 1883
integer y = 456
integer width = 553
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Note for Bill of Lading"
end type

on clicked;If rb_note_shipper.checked then
	is_NoteShipper			= mle_note.text
End If

rb_note_shipper.checked	= FALSE

mle_note.text				= is_NoteBOL
end on

type mle_note from multilineedit within w_customer_setup_with_destinations
boolean visible = false
integer x = 375
integer y = 144
integer width = 1349
integer height = 1196
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

type cb_note_save from commandbutton within w_customer_setup_with_destinations
boolean visible = false
integer x = 1842
integer y = 1244
integer width = 242
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ok"
end type

on clicked;ib_DestChanged = TRUE

String s_BOLFlag				//Whether print note on BOL
String s_ShipperFlag			//Whether print note on shipper

If rb_note_shipper.checked then
	is_NoteShipper	= mle_note.text
Else
	is_NoteBOL		= mle_note.text
End If

wf_show_note(FALSE)

If dw_4.RowCount() <= 0 then
	dw_4.InsertRow(1)
	dw_4.SetItem(1, "destination", is_Destination)
End If

If cbx_note_print_shipper.checked then
	s_ShipperFlag 	= "Y"
Else
	s_ShipperFlag	= "N"
End If

If cbx_note_print_bol.checked then
	s_BOLFlag 		= "Y"
Else
	s_BOLFlag		= "N"
End If

dw_4.SetItem(1, "print_shipper_note", s_ShipperFlag)
dw_4.SetItem(1, "print_bol_note", s_BOLFlag)
dw_4.SetItem(1, "note_for_shipper", is_NoteShipper)
dw_4.SetItem(1, "note_for_bol", is_NoteBOL)






end on

type cb_note_cancel from commandbutton within w_customer_setup_with_destinations
boolean visible = false
integer x = 2117
integer y = 1244
integer width = 242
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

on clicked;wf_show_note ( False )
dw_4.SetFocus ( )
end on

type cbx_note_print_bol from checkbox within w_customer_setup_with_destinations
boolean visible = false
integer x = 1883
integer y = 564
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Print on Bill of Lading"
end type


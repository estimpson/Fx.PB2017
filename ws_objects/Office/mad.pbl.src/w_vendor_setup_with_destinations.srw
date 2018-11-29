$PBExportHeader$w_vendor_setup_with_destinations.srw
$PBExportComments$mad
forward
global type w_vendor_setup_with_destinations from w_sheet_4t
end type
type sle_2 from singlelineedit within w_vendor_setup_with_destinations
end type
type sle_1 from singlelineedit within w_vendor_setup_with_destinations
end type
type rb_2 from radiobutton within w_vendor_setup_with_destinations
end type
type rb_1 from radiobutton within w_vendor_setup_with_destinations
end type
type p_1 from picture within w_vendor_setup_with_destinations
end type
type lb_2 from listbox within w_vendor_setup_with_destinations
end type
type lb_1 from listbox within w_vendor_setup_with_destinations
end type
type dw_1 from datawindow within w_vendor_setup_with_destinations
end type
type dw_2 from datawindow within w_vendor_setup_with_destinations
end type
type dw_5 from datawindow within w_vendor_setup_with_destinations
end type
type st_vendor_attached from statictext within w_vendor_setup_with_destinations
end type
type rb_note_bol from radiobutton within w_vendor_setup_with_destinations
end type
type rb_note_shipper from radiobutton within w_vendor_setup_with_destinations
end type
type cbx_note_print_bol from checkbox within w_vendor_setup_with_destinations
end type
type cb_note_save from commandbutton within w_vendor_setup_with_destinations
end type
type cbx_note_print_shipper from checkbox within w_vendor_setup_with_destinations
end type
type cb_note_cancel from commandbutton within w_vendor_setup_with_destinations
end type
type dw_vendor_custom from datawindow within w_vendor_setup_with_destinations
end type
type mle_note from multilineedit within w_vendor_setup_with_destinations
end type
type cb_note from commandbutton within w_vendor_setup_with_destinations
end type
type dw_3 from datawindow within w_vendor_setup_with_destinations
end type
type gb_1 from groupbox within w_vendor_setup_with_destinations
end type
type dw_4 from datawindow within w_vendor_setup_with_destinations
end type
type gb_2 from groupbox within w_vendor_setup_with_destinations
end type
end forward

shared variables

end variables

global type w_vendor_setup_with_destinations from w_sheet_4t
integer x = 214
integer y = 221
string title = "Vendor / Destination Setup"
string menuname = "m_vendor_destination_menu"
event copy_vendor pbm_custom01
event save_shipper pbm_custom02
event save_vendor pbm_custom03
event delete_vendor pbm_custom04
event save_destination pbm_custom05
event delete_destination pbm_custom06
event ue_exit pbm_custom07
event add_vendor pbm_custom08
event add_destination pbm_custom09
event ue_sync_vend pbm_custom10
sle_2 sle_2
sle_1 sle_1
rb_2 rb_2
rb_1 rb_1
p_1 p_1
lb_2 lb_2
lb_1 lb_1
dw_1 dw_1
dw_2 dw_2
dw_5 dw_5
st_vendor_attached st_vendor_attached
rb_note_bol rb_note_bol
rb_note_shipper rb_note_shipper
cbx_note_print_bol cbx_note_print_bol
cb_note_save cb_note_save
cbx_note_print_shipper cbx_note_print_shipper
cb_note_cancel cb_note_cancel
dw_vendor_custom dw_vendor_custom
mle_note mle_note
cb_note cb_note
dw_3 dw_3
gb_1 gb_1
dw_4 dw_4
gb_2 gb_2
end type
global w_vendor_setup_with_destinations w_vendor_setup_with_destinations

type variables
String	is_vendor, &
	is_Destination, &
	is_CurrDest, &
	is_Currvend, &
	is_NoteShipper, &
	is_NoteBOL, &
	is_Selection,&
	is_ai_type, &
                     is_module='VM'

Int                 ii_seq=1                   

Boolean	ib_DestEDI = FALSE, &
	ib_vendChanged=FALSE, &
	ib_DestChanged=FALSE

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
public subroutine show_vendor ()
public subroutine show_attachment (boolean ab_show)
public subroutine wf_retrieve_child ()
public function string wf_status ()
end prototypes

event copy_vendor;//
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
			ls_status

INT		li_show_euro_amount

//
//  Initialize Variables
//

rb_2.Checked = False
rb_1.Checked = True

IF is_vendor = '' THEN Return

SELECT code,   
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
		 status
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
		 :ls_status
  FROM vendor
 WHERE code = :is_vendor   ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( Monsys.msg_title, "Unable to retrieve vendor information!", StopSign! )
	Return
End if

//ls_status = wf_status()

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
            vendor,   
            customer,
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
            :is_vendor,   
            '',
				:ls_default_currency_unit,
				:li_show_euro_amount,
				:ls_status)  ;

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

event save_vendor;//
//  Declare Variables
//

Long 	l_Row
int	l_i_count
 
//
//  Initialize Variables
//

l_Row = dw_3.GetRow ( )
is_Currvend = dw_3.GetItemString ( l_Row, "code" )

//
//	Check for required save conditions
//

IF dw_3.RowCount ( ) = 0 THEN Return
IF ib_vendChanged = FALSE THEN Return

//
//	Perform Save
//

If dw_3.Update ( ) = -1 Then
	RollBack ;
	Return
End if

// updating vendor_custom table inc by gph
dw_vendor_custom.Update()
ib_vendChanged = FALSE

//SELECT count(*)
//INTO		:l_i_count
//FROM		vendor_additional
//WHERE		vendor = :is_Currvend ;

//if l_i_count < 1 then
//	INSERT INTO vendor_additional ( 
//		vendor,
//		type,
//		platinum_id )
//		VALUES (
//		:is_currvend,
//		'',
//		'' ) ;
//	if sqlca.sqlcode <> 0 then
//		RollBack ;
//		Return
//	end if		
//end if
//
Commit ;

IF is_vendor = '' THEN
	dw_1.Retrieve ( )
	l_Row = dw_1.Find ( "code = '" + is_Currvend + "'", 1, dw_1.RowCount ( ) )
	dw_1.ScrollToRow ( l_Row )
	SelectRow ( dw1, 0, False )
	SelectRow ( dw1, l_Row, True )
	is_vendor = is_Currvend
END IF
end event

event delete_vendor;//
//  Declare Variables
//

Long 		l_Row
string	l_s_message
Int 		i_Answer

//
// Check for required delete conditions
//

IF is_vendor = '' THEN Return

//
//  Check for dependencies
//

If wf_check_for_orphans ( is_vendor, "vendor" ) Then
	MessageBox ( Monsys.msg_title, "This vendor is referenced somewhere in the system.  Unable to delete!", StopSign! )
	Return
End if

//
//	Give last chance then perform delete
//

i_Answer = MessageBox ( Monsys.msg_title, "Are you sure you want~rto delete " + is_vendor + "?", Question!, OkCancel!, 2 )
If i_Answer = 2 Then Return

//DELETE FROM vendor_additional
//WHERE vendor = :is_currvend ;
//
//if sqlca.sqlcode <> 0 then
//	l_s_message = sqlca.sqlerrtext
//	Rollback;
//	MessageBox ( "Error", "Deletion of record failed!~r" + l_s_message, StopSign! )
//	Return
//end if

dw_1.DeleteRow ( l_Row )
If dw_1.Update ( ) = -1 Then
	l_s_message = sqlca.sqlerrtext
	RollBack ;
	MessageBox ( Monsys.msg_title, "Deletion of record failed!~r" + l_s_message, StopSign! )
	Return
Else
	Commit ;
	ib_vendChanged = FALSE
End if

dw_1.SelectRow ( 0, FALSE )
is_vendor = ''
is_Currvend = ''
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

String	ls_Vendor, &
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

//	If per Vendor is selected then set ls_Vendor = is_CurrVend, otherwise ls_Vendor remains null.
IF rb_1.Checked = TRUE THEN
	ls_Vendor = is_CurrVend
END IF

//	Prepare datawindow for update.
dw_4.SetItem ( 1, "vendor", ls_Vendor )
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
	            print_bol_note )  
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
	            null )  ; 

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
	            parent_destination )  
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
	            null )  ;

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

event ue_exit;//Check_Changes ( )
close (this)
end event

event add_vendor;LONG l_Row
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
from		vendor_service_status
where		default_value = 'Y' ;

is_vendor = ''
dw3.Reset ( )
dw3.Modify ( "code.TabSequence=10" )
dw3.InsertRow ( 0 )
dw3.SetItem ( 1, "vendor_status", ls_status )
dw3.SetColumn ( "code" )
dw3.SetFocus ( )


end event

event add_destination;String ls_status

IF is_Currvend = '' THEN
	MessageBox ( Monsys.msg_title, "You have to have a vendor selected to add a destination!", StopSign! )
	RETURN
END IF

select	status
into	:ls_status
from	vendor
where	code = :is_vendor;

if isnull(ls_status,'')='' then ls_status = wf_status()

lb_2.SelectItem ( 0 )
lb_2.SelectItem ( 'Standard', 0 )
dw_5.Visible = FALSE
p_1.Visible = FALSE
dw4.DataObject = 'd_destination_setup'
dw4.SetTransObject ( SQLCA )
dw4.Modify ( "destination.TabSequence=10" )
dw4.InsertRow ( 0 )
dw4.SetItem(dw4.Rowcount(), "cs_status",ls_status)
dw4.SetColumn ( "destination" )
dw4.SetFocus ( )
dw2.SelectRow ( 0, FALSE )
dw2.visible = TRUE

end event

on ue_sync_vend;Open ( w_ai_vendor_sync )
end on

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

If as_Mode = "vendor" Then
	
	DECLARE valid_vendors CURSOR FOR  
	 SELECT destination.destination  
      FROM destination  
     WHERE destination.vendor = :as_String   ;

	Open valid_vendors ;
	Fetch valid_vendors Into :s_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_vendors ;
		Return True
	End if
	Close valid_vendors ;
	
	DECLARE valid_part_vendor CURSOR FOR  
	 SELECT part_vendor.vendor_standard_pack  
	   FROM part_vendor  
	  WHERE part_vendor.vendor = :as_String   ;

	Open valid_part_vendor ;
	Fetch valid_part_vendor Into :l_Dummy ;
	If SQLCA.SQLCode = 0 Then
		Close valid_part_vendor ;
		Return True
	End if
	Close valid_part_vendor ;
	
   SELECT vendor 
	  INTO :s_dummy
	  FROM vendor_custom
	 WHERE vendor= :as_string ;
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


//	DECLARE valid_order_vendor CURSOR FOR  
//	 SELECT order_header.order_no  
//	   FROM order_header  
//	  WHERE order_header.vendor = :as_String  ;
	
//	Open valid_order_vendor ;
//	Fetch valid_order_vendor Into :l_Dummy ;
//	If SQLCA.SQLCode = 0 Then
//		Close valid_order_vendor ;
//		Return True
//	End if
//	Close valid_order_vendor ;
	
	
//	DECLARE valid_shipper_vendor CURSOR FOR  
//	 SELECT shipper.id  
//	   FROM shipper  
//	  WHERE shipper.vendor = :as_String  ;
	
//	Open valid_shipper_vendor ;
//	Fetch valid_shipper_vendor Into :l_Dummy ;
//	If SQLCA.SQLCode = 0 Then
//		Close valid_shipper_vendor ;
//		Return True
//	End if
//	Close valid_shipper_vendor ;
end function

public subroutine reset_destination ();Check_Changes ( )
dw_5.Reset ( )
p_1.Visible = FALSE
dw_4.Reset ( )
end subroutine

public subroutine check_changes ();//integer	i_mess1, i_mess2

// Any changes in vendor that is not saved ?

/*If ib_vendChanged THEN
	IF is_Currvend = "" THEN
		dw_3.AcceptText ( )
		is_Currvend = dw_3.GetItemString ( dw_3.GetRow ( ), "vendor" )
	END IF
	IF is_Currvend = "" THEN Return
	i_mess1=Messagebox ( "Warning", " Do you want save changes to " + is_Currvend + "'s standard information?", Question!, YesNo!, 1 )
	If  i_mess1 = 1 Then
		If	dw_3.update () = 1 Then
			commit;
		Else
			Rollback;
			Messagebox ("warning", "Invalid datatype!, changes cannot be updated" )
			Return
		End If
	End If
	ib_vendChanged = FALSE
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

// Any changes in vendor that is not saved ?

If ib_vendChanged THEN
	IF is_Currvend = "" THEN
		dw_3.AcceptText ( )
		dw_3.SetColumn("code")
		is_Currvend = dw_3.GetText() 
	END IF
	IF is_Currvend = "" THEN Return
	i_mess1=Messagebox ( Monsys.msg_title, " Do you want save changes to " + is_Currvend + "'s standard information?", Question!, YesNo!, 1 )
	If  i_mess1 = 1 Then
		If	dw_3.update () = 1 Then
			COMMIT ;
			dw_1.Retrieve ( )
			l_Row = dw1.Find ( "code = '" + is_Currvend + "'", 1, dw1.RowCount ( ) )
			dw1.ScrollToRow ( l_Row )
			ib_vendChanged = FALSE
			is_vendor = is_Currvend	
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

IF rb_1.Checked = TRUE and is_vendor = '' THEN
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
	dw_2.SetFilter ( "vendor = '" + is_vendor + "'" )
	dw_2.Filter ( )
END IF
dw_2.SetSort ( "destination A" )
dw_2.Sort ( )
dw_2.Visible = TRUE

//
//	If destination and per vendor is selected, search destination list
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

public subroutine show_vendor ();IF rb_1.Checked = TRUE THEN
	Show_Destination_List ( )
END IF

Check_Changes ( )

dw_3.Modify ( "code.TabSequence=0" )
wf_retrieve_child()
dw_3.Retrieve ( is_vendor )
end subroutine

public subroutine show_attachment (boolean ab_show);STRING s_Destvend

IF ab_Show THEN
	st_vendor_attached.Visible = TRUE
	 SELECT destination.vendor  
   	INTO :s_Destvend  
	   FROM destination  
	  WHERE destination.destination = :is_Destination   ;

	If SQLCA.SQLCode = 0 Then
		If f_get_string_value ( s_Destvend ) = '' Then
			st_vendor_attached.Text = "No vendor Attached!"
		Else
			st_vendor_attached.Show ( )
			st_vendor_attached.Text = is_Destination + " is attached to vendor: " + s_Destvend
		End if
	Else
		st_vendor_attached.Text = "No vendor Attached!"
	End if
ELSE
	st_vendor_attached.Visible = FALSE
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

public function string wf_status ();String ls_cs_status

Select status_name Into :ls_cs_status
From vendor_service_status
Where default_value = 'Y';

Return ls_cs_status
end function

event open;call super::open;//
//  If show program name parameter is 'Y' then append the title with it
//

String	s_ShowProgName

 SELECT	parameters.show_program_name,
			parameters.accounting_type
	INTO	:s_ShowProgName,
			:is_ai_type  
	FROM	parameters  ;

If s_ShowProgName = 'Y' Then 
	This.Title = This.Title + " [w_vendor_setup_with_destinations]"
END IF

//
//  Declare Variables
//

Long l_Row

//
//	Initialize Variables
//

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
//  Show vendor enter update screen
//

dw_3.SetTransobject ( sqlca )
dw_3.Modify ( "vendor.TabSequence=0" )

//
//  Retrieve destinations for vendor
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

sle_1.SetFocus ( )
end event

on timer;If p_1.picturename	= "noteno.bmp" then
	p_1.picturename	= "noteyes.bmp"
Else
	p_1.picturename	= "noteno.bmp"
End If
end on

on w_vendor_setup_with_destinations.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_vendor_destination_menu" then this.MenuID = create m_vendor_destination_menu
this.sle_2=create sle_2
this.sle_1=create sle_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.p_1=create p_1
this.lb_2=create lb_2
this.lb_1=create lb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_5=create dw_5
this.st_vendor_attached=create st_vendor_attached
this.rb_note_bol=create rb_note_bol
this.rb_note_shipper=create rb_note_shipper
this.cbx_note_print_bol=create cbx_note_print_bol
this.cb_note_save=create cb_note_save
this.cbx_note_print_shipper=create cbx_note_print_shipper
this.cb_note_cancel=create cb_note_cancel
this.dw_vendor_custom=create dw_vendor_custom
this.mle_note=create mle_note
this.cb_note=create cb_note
this.dw_3=create dw_3
this.gb_1=create gb_1
this.dw_4=create dw_4
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_2
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.lb_2
this.Control[iCurrent+7]=this.lb_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.st_vendor_attached
this.Control[iCurrent+12]=this.rb_note_bol
this.Control[iCurrent+13]=this.rb_note_shipper
this.Control[iCurrent+14]=this.cbx_note_print_bol
this.Control[iCurrent+15]=this.cb_note_save
this.Control[iCurrent+16]=this.cbx_note_print_shipper
this.Control[iCurrent+17]=this.cb_note_cancel
this.Control[iCurrent+18]=this.dw_vendor_custom
this.Control[iCurrent+19]=this.mle_note
this.Control[iCurrent+20]=this.cb_note
this.Control[iCurrent+21]=this.dw_3
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.dw_4
this.Control[iCurrent+24]=this.gb_2
end on

on w_vendor_setup_with_destinations.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.p_1)
destroy(this.lb_2)
destroy(this.lb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.st_vendor_attached)
destroy(this.rb_note_bol)
destroy(this.rb_note_shipper)
destroy(this.cbx_note_print_bol)
destroy(this.cb_note_save)
destroy(this.cbx_note_print_shipper)
destroy(this.cb_note_cancel)
destroy(this.dw_vendor_custom)
destroy(this.mle_note)
destroy(this.cb_note)
destroy(this.dw_3)
destroy(this.gb_1)
destroy(this.dw_4)
destroy(this.gb_2)
end on

event close;call super::close;check_changes()
end event

event activate;call super::activate;
If ib_DestEDI = True Then
	lb_2.SelectItem ( "Standard", 0 )
	ib_DestEDI = False
	Show_Destination ( FALSE )
	p_1.visible	= FALSE
End If
end event

type sle_2 from singlelineedit within w_vendor_setup_with_destinations
event keyup pbm_keyup
integer x = 329
integer y = 784
integer width = 329
integer height = 80
integer taborder = 20
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

type sle_1 from singlelineedit within w_vendor_setup_with_destinations
event keyup pbm_keyup
integer x = 329
integer width = 329
integer height = 80
integer taborder = 20
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

ll_row = dw_1.Find ( "code >= '" + text + "'", 1, dw_1.RowCount ( ) )
if ll_row > 0 then
	dw_1.ScrollToRow ( ll_row )
	dw_1.SelectRow ( 0, FALSE )
	dw_1.SelectRow ( ll_row, TRUE )
end if
end event

type rb_2 from radiobutton within w_vendor_setup_with_destinations
integer x = 96
integer y = 1376
integer width = 398
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77633680
string text = "Show All"
end type

on clicked;Show_Destination_List ( )
end on

type rb_1 from radiobutton within w_vendor_setup_with_destinations
integer x = 101
integer y = 1304
integer width = 512
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77633680
string text = "Per Vendor"
end type

on clicked;Show_Destination_List ( )
end on

type p_1 from picture within w_vendor_setup_with_destinations
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

type lb_2 from listbox within w_vendor_setup_with_destinations
integer x = 2487
integer y = 860
integer width = 338
integer height = 428
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
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

type lb_1 from listbox within w_vendor_setup_with_destinations
integer x = 2491
integer y = 84
integer width = 338
integer height = 684
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Standard","User defined"}
end type

event selectionchanged;String szSelection
Long   l_l_rowno		 

szSelection = lb_1.SelectedItem()
IF szSelection = "User defined" THEN
   IF is_currvend > '' THEN						  //   wf_retrieve_child()   
	dw_vendor_custom.retrieve(is_currvend)	
	 IF dw_vendor_custom.Rowcount() = 0 THEN
		l_l_rowno=dw_vendor_custom.INSERTROW(0)
		IF l_l_rowno > 0 THEN 
			ib_vendchanged=TRUE
			dw_vendor_custom.SCROLLTOROW(l_l_rowno)
			dw_vendor_custom.setitem(l_l_rowno,'code',is_currvend)
		END IF
	 END IF 
   END IF
	dw_3.BringToTop=FALSE
   dw_vendor_custom.SHOW()
ELSE
   dw_vendor_custom.HIDE()
	dw_3.BringToTop=TRUE
END IF

//If szSelection = "Contacts" OR szSelection = "Documents" OR szSelection = "Standard" Then
//	MessageBox ( "Information", "Sorry, this option will not be available~runtil a future release.", Information! )
//End If
end event

type dw_1 from datawindow within w_vendor_setup_with_destinations
integer x = 73
integer y = 80
integer width = 581
integer height = 672
string dataobject = "d_dddw_vendors"
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
is_Currvend = is_vendor
is_vendor = this.GetItemString ( l_Row, "code" )

//  highlight current Row1
this.SelectRow ( 0, False )
this.SelectRow ( l_Row, True )

//	Show vendor, destination list, etc.
Show_vendor ( )
is_Currvend = is_vendor
is_CurrDest = ''
is_Destination = ''

dw_vendor_custom.HIDE()
dw_3.BringToTop=TRUE
lb_1.Selectitem(0)
end event

type dw_2 from datawindow within w_vendor_setup_with_destinations
integer x = 73
integer y = 864
integer width = 581
integer height = 416
string dragicon = "MONITOR.ICO"
string dataobject = "d_destination_list_grey_vendor"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//
//  Declare Variables
//

String 	s_Selection
String	s_vendor
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

type dw_5 from datawindow within w_vendor_setup_with_destinations
boolean visible = false
integer x = 1600
integer y = 852
integer width = 690
integer height = 192
string dataobject = "d_dest_shipping_setup_descriptions"
boolean border = false
end type

on getfocus;dw_4.SetFocus ( )
end on

type st_vendor_attached from statictext within w_vendor_setup_with_destinations
boolean visible = false
integer x = 439
integer y = 784
integer width = 1989
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type rb_note_bol from radiobutton within w_vendor_setup_with_destinations
boolean visible = false
integer x = 1353
integer y = 588
integer width = 649
integer height = 76
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

type rb_note_shipper from radiobutton within w_vendor_setup_with_destinations
boolean visible = false
integer x = 823
integer y = 592
integer width = 517
integer height = 76
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

type cbx_note_print_bol from checkbox within w_vendor_setup_with_destinations
boolean visible = false
integer x = 1353
integer y = 684
integer width = 645
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Print on Bill of Lading"
end type

type cb_note_save from commandbutton within w_vendor_setup_with_destinations
boolean visible = false
integer x = 2048
integer y = 572
integer width = 242
integer height = 92
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

type cbx_note_print_shipper from checkbox within w_vendor_setup_with_destinations
boolean visible = false
integer x = 832
integer y = 684
integer width = 512
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Print on Shipper"
end type

type cb_note_cancel from commandbutton within w_vendor_setup_with_destinations
boolean visible = false
integer x = 2048
integer y = 680
integer width = 242
integer height = 92
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

type dw_vendor_custom from datawindow within w_vendor_setup_with_destinations
boolean visible = false
integer x = 672
integer y = 56
integer width = 1751
integer height = 732
integer taborder = 10
string dataobject = "d_vendor_custom"
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

event editchanged;ib_vendchanged = TRUE
end event

event itemchanged;ib_vendchanged = TRUE
end event

type mle_note from multilineedit within w_vendor_setup_with_destinations
boolean visible = false
integer x = 818
integer y = 152
integer width = 1472
integer height = 416
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_note from commandbutton within w_vendor_setup_with_destinations
boolean visible = false
integer x = 658
integer y = 48
integer width = 1792
integer height = 796
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type dw_3 from datawindow within w_vendor_setup_with_destinations
integer x = 667
integer y = 56
integer width = 1801
integer height = 716
string dataobject = "d_vendor_eu"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String	s_Column, &
			s_vend, &
			s_Temp

Long		l_Row

ib_vendChanged = TRUE
s_Column = dw_3.GetColumnName ( )

If s_Column = "code" Then
	s_vend = dw_3.GetText ( )

   SELECT code  
     INTO :s_Temp  
     FROM vendor  
    WHERE code = :s_vend   ;

	If SQLCA.SQLCode = 0 Then
		dw_3.SetTransObject ( sqlca )
		dw_3.Retrieve ( s_vend )
		dw_3.Modify("code.TabSequence=0")
		l_Row = dw_1.Find ( "code = '" + s_vend + "'", 1, dw_1.RowCount ( ) )
		SelectRow ( dw_1, 0, False )
		SelectRow ( dw_1, l_Row, True )
		is_vendor = s_vend
		is_Currvend = is_vendor
		Show_Destination_List ( )
	End if
End if
end event

on editchanged;ib_vendChanged=TRUE
end on

on constructor;DataWindowChild	ldwc_SalesRep, &
						ldwc_Terms
String				ls_Temp

 DECLARE salesrep CURSOR FOR  
  SELECT salesrep.salesrep  
    FROM salesrep  
ORDER BY salesrep.salesrep ASC  ;

 DECLARE terms CURSOR FOR  
  SELECT term.description  
    FROM term  
ORDER BY term.description ASC  ;

GetChild ( "salesrep", ldwc_SalesRep )
GetChild ( "term", ldwc_Terms )

Open salesrep ;
Do
	Fetch salesrep Into :ls_Temp ;
	If SQLCA.SQLCode = 0 Then
		ldwc_SalesRep.InsertRow ( 0 )
		ldwc_SalesRep.SetItem ( ldwc_SalesRep.RowCount ( ), "data", ls_Temp )
	End if
Loop While SQLCA.SQLCode = 0
Close salesrep ;

Open terms ;
Do
	Fetch terms Into :ls_Temp ;
	If SQLCA.SQLCode = 0 Then
		ldwc_Terms.InsertRow ( 0 )
		ldwc_Terms.SetItem ( ldwc_Terms.RowCount ( ), "data", ls_Temp )
	End if
Loop While SQLCA.SQLCode = 0
Close terms ;

end on

event dragdrop;Long lRow 

String l_s_code, l_s_vendor


lRow = dw_1.GetRow()

Select  vendor
into  :l_s_vendor
from destination 
where destination = :is_currdest;

If sqlca.sqlcode = 0 then
If MessageBox( monsys.msg_title, 'Destination already assigned to ' + l_s_vendor +  ' Reassigning will delete the destination from ' + l_s_vendor + '!', information!, OkCancel!, 1 ) = 2 Then
	dw_4.Reset()
	dw_4.SetColumn(1)
	Return
end if
end if

l_s_code = dw_1.GetItemString ( lRow , "code" )
lRow = dw_4.GetRow()
dw_4.SetItem (lRow, "vendor", l_s_code)

If dw_4.Update ( ) = -1 Then
	MessageBox ( Monsys.msg_title, "Update to destination failed!~r" + SQLCA.SQLErrText, StopSign! )	
	RollBack ;
	Return
end if 

Commit ;

dw_2.Retrieve ( )

end event

type gb_1 from groupbox within w_vendor_setup_with_destinations
integer x = 32
integer y = 16
integer width = 2816
integer height = 768
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77633680
string text = "Vendor"
end type

type dw_4 from datawindow within w_vendor_setup_with_destinations
integer x = 667
integer y = 852
integer width = 1801
integer height = 612
string dataobject = "d_destination_setup"
boolean border = false
end type

event itemchanged;String		s_Column, &
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
	String s_TransModeDesc, s_TransMode,l_s_vendor


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

	   SELECT destination, vendor
	   	 INTO :s_Temp, :l_s_vendor   
	     FROM destination 
	    WHERE destination = :s_Dest   ;

		If SQLCA.SQLCode = 0 Then
			 If l_s_vendor > '' Then
				If MessageBox(monsys.msg_title,'Destination already assigned to' + l_s_vendor + 'Reassigning will delete destination from' + l_s_vendor + '!', Information!, OkCancel!, 1 ) = 2 Then
					dw_4.Reset()
					dw_4.SetColumn(1)
					Return
				End If
			dw_4.SetTransObject ( sqlca )
			dw_4.Retrieve ( s_Dest )
			l_Row = dw_2.Find ( "destination = '" + s_Dest + "'", 1, dw_2.RowCount ( ) )
			SelectRow ( dw_2, 0, False )
			SelectRow ( dw_2, l_Row, True )
			is_Destination = s_Dest
			is_CurrDest = is_Destination
	End if
  End if
 End If
End If

end event

on editchanged;ib_DestChanged = TRUE
end on

type gb_2 from groupbox within w_vendor_setup_with_destinations
integer x = 37
integer y = 784
integer width = 2816
integer height = 688
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77633680
string text = "Destination"
end type


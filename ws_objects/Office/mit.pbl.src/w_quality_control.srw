$PBExportHeader$w_quality_control.srw
forward
global type w_quality_control from window
end type
type dw_transactions from datawindow within w_quality_control
end type
type sle_status from statictext within w_quality_control
end type
type st_1 from statictext within w_quality_control
end type
type cb_57 from commandbutton within w_quality_control
end type
type cb_55 from commandbutton within w_quality_control
end type
type cb_48 from commandbutton within w_quality_control
end type
type dw_object from datawindow within w_quality_control
end type
type sle_operator from singlelineedit within w_quality_control
end type
type sle_serial from singlelineedit within w_quality_control
end type
type cb_47 from commandbutton within w_quality_control
end type
type cb_46 from commandbutton within w_quality_control
end type
type cb_44 from commandbutton within w_quality_control
end type
type cb_42 from commandbutton within w_quality_control
end type
type dw_1 from datawindow within w_quality_control
end type
type cb_41 from commandbutton within w_quality_control
end type
type cb_43 from commandbutton within w_quality_control
end type
type cb_40 from commandbutton within w_quality_control
end type
type cb_39 from commandbutton within w_quality_control
end type
type cb_38 from commandbutton within w_quality_control
end type
type cb_37 from commandbutton within w_quality_control
end type
type cb_36 from commandbutton within w_quality_control
end type
type cb_35 from commandbutton within w_quality_control
end type
type cb_34 from commandbutton within w_quality_control
end type
type cb_33 from commandbutton within w_quality_control
end type
type cb_32 from commandbutton within w_quality_control
end type
type cb_31 from commandbutton within w_quality_control
end type
type cb_30 from commandbutton within w_quality_control
end type
type cb_29 from commandbutton within w_quality_control
end type
type cb_28 from commandbutton within w_quality_control
end type
type cb_27 from commandbutton within w_quality_control
end type
type cb_26 from commandbutton within w_quality_control
end type
type cb_25 from commandbutton within w_quality_control
end type
type cb_24 from commandbutton within w_quality_control
end type
type cb_23 from commandbutton within w_quality_control
end type
type cb_22 from commandbutton within w_quality_control
end type
type cb_21 from commandbutton within w_quality_control
end type
type cb_20 from commandbutton within w_quality_control
end type
type cb_19 from commandbutton within w_quality_control
end type
type cb_18 from commandbutton within w_quality_control
end type
type cb_17 from commandbutton within w_quality_control
end type
type cb_16 from commandbutton within w_quality_control
end type
type cb_15 from commandbutton within w_quality_control
end type
type cb_14 from commandbutton within w_quality_control
end type
type cb_13 from commandbutton within w_quality_control
end type
type cb_12 from commandbutton within w_quality_control
end type
type cb_11 from commandbutton within w_quality_control
end type
type cb_10 from commandbutton within w_quality_control
end type
type cb_9 from commandbutton within w_quality_control
end type
type cb_8 from commandbutton within w_quality_control
end type
type cb_7 from commandbutton within w_quality_control
end type
type cb_6 from commandbutton within w_quality_control
end type
type cb_5 from commandbutton within w_quality_control
end type
type cb_4 from commandbutton within w_quality_control
end type
type cb_3 from commandbutton within w_quality_control
end type
type cb_2 from commandbutton within w_quality_control
end type
type cb_1 from commandbutton within w_quality_control
end type
type sle_title from statictext within w_quality_control
end type
type gb_serial_number from groupbox within w_quality_control
end type
type mle_qc_notes from multilineedit within w_quality_control
end type
type dw_misc from datawindow within w_quality_control
end type
type gb_qc_notes from groupbox within w_quality_control
end type
type gb_dwbox from groupbox within w_quality_control
end type
type gb_operator from groupbox within w_quality_control
end type
end forward

global type w_quality_control from window
integer width = 6679
integer height = 3452
boolean titlebar = true
string title = "Quality Control"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 77897888
string icon = "mit.ico"
event ue_close_audit_trail pbm_custom04
dw_transactions dw_transactions
sle_status sle_status
st_1 st_1
cb_57 cb_57
cb_55 cb_55
cb_48 cb_48
dw_object dw_object
sle_operator sle_operator
sle_serial sle_serial
cb_47 cb_47
cb_46 cb_46
cb_44 cb_44
cb_42 cb_42
dw_1 dw_1
cb_41 cb_41
cb_43 cb_43
cb_40 cb_40
cb_39 cb_39
cb_38 cb_38
cb_37 cb_37
cb_36 cb_36
cb_35 cb_35
cb_34 cb_34
cb_33 cb_33
cb_32 cb_32
cb_31 cb_31
cb_30 cb_30
cb_29 cb_29
cb_28 cb_28
cb_27 cb_27
cb_26 cb_26
cb_25 cb_25
cb_24 cb_24
cb_23 cb_23
cb_22 cb_22
cb_21 cb_21
cb_20 cb_20
cb_19 cb_19
cb_18 cb_18
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
sle_title sle_title
gb_serial_number gb_serial_number
mle_qc_notes mle_qc_notes
dw_misc dw_misc
gb_qc_notes gb_qc_notes
gb_dwbox gb_dwbox
gb_operator gb_operator
end type
global w_quality_control w_quality_control

type variables
boolean			ib_forward,&
			ib_back
String			is_field
GraphicObject		igo_last
st_generic_structure 	stParm
Int 			iThisInstance
Int 			iddlbIndex
Int			iHandle
Boolean			bAuditTrail
Boolean			bNoKey
Boolean			bUserNotes
Boolean			bUserOperator
Boolean 			bOperator
Boolean 			bLocationTo
Boolean 			bLocationFrom
Boolean 			bSerialNumber
Boolean 			bUnits
Boolean 			bMachines
Boolean 			bPackaging
Boolean 			bLot
Boolean 			bQty
Boolean 			bNumberOf
Boolean 			bParts
Boolean 			bWriteParent
Boolean 			bZeroParent
Boolean 			bSuper
Boolean 			bNoCheck
Boolean 			bChars, bNumbers
Boolean 			bLoseFocus
Boolean 			bDelete
Boolean 			bEnabled
Boolean 			bLabelNeeded
Boolean 			bCurrentObject
Boolean 			bNewObject
Boolean 			bPopulateParts
Boolean 			bPopulateLocations
Boolean 			bPopulateMachines
Boolean 			bPartsLoseFocus
Boolean 			bExit
Boolean 			bMessageBox
Boolean 			bMandatoryLot=False
Boolean 			bRequired
Boolean 			bClicked
Boolean 			bModified
Boolean 			bBreakoutMore
Boolean 			bDifferentPart
Boolean 			bInvalidCombineSerial
Boolean 			bStagedObject
Boolean 			bCombineSameSerial
Boolean 			bCombineDifferentStatus
Boolean 			bIssueMoreQuantity
Boolean 			bDifferentStatus
Boolean 			bStatusSame
Boolean 			bInvalidSuperObject
Boolean 			bExternalMessage
Boolean 			bOpen
Boolean 			bNoClickCheck
Boolean 			bButton
Boolean 			bCombineSerial
Boolean 			bCB48
Boolean 			bMessage
Boolean 			bSetToThis
Boolean 			bTab
Boolean 			bAction
Boolean 			bQCNotes
Boolean 			bMandatoryQCNotes
Boolean			bJCNumberOfMode
Boolean			bJCLotMode
Boolean			bJCQtyMode
Boolean			bJCUnitMode
Boolean			bMIUnitMode
Boolean			bBONumberOfMode
Boolean			bBOUnitMode 
Boolean			bDeleteScrap
Boolean			bSetBack
Boolean			bLabel, &
			ib_Scale, &
			ib_PopupScaleInterface, &
			ib_ScaleOpen, &
			ib_Auto, &
			ib_Password, &
			ib_Notes
String 			szOperator
String 			szTo
String 			szLocation
String 			szNewLoc
String 			szRemarks
String 			cType
String 			cObjectType
String 			szMessage
String 			szPart
String 			szLot
String 			szStatus
String 			szPoNumber
String 			szUnit
String 			cStatus
String 			szWorkOrder
String 			szTextCheck
String 			szField
String 			szSelectedText
String 			szRealityText
String 			cCharacterTouched
String 			cIssueType, &
			is_Notes,&
			is_UserStatus
DateTime 		dtToday
DateTime 		dDateTime
Date 			dToday
Time 			tTime
Dec 			dQuantity
Dec 			dWeight
Dec 			dPrice
Dec 			dOnHand, &
			idec_ScaleWeight
Long	 		lParent
Long 			lSerial
Long 			lLoop
Long 			lRow
Long 			lColumn
Long 			lSerialParm
Long			il_AuditRow
DataWindow 		dwObject

st_dda_parmlist_mit_sf            st_prmlst
string                                       szdimensionqtystring 
string                                       szparentqty
string                                       szparentdimqtystr
string                                       s_org_str[]
decimal                                   d_org_value[]
long                                         llnonconstantdim
end variables

forward prototypes
public subroutine disable_chars ()
public subroutine enable_chars ()
public subroutine disable_numbers ()
public subroutine enable_numbers ()
public subroutine wf_key_pressed (string ccharacter)
public subroutine wf_setup_screen ()
public subroutine wf_reset_indicators ()
public subroutine wf_enable_screen ()
public subroutine wf_disable_screen ()
public function boolean wf_modified ()
public subroutine wf_set_focus ()
public subroutine wf_reset_colors ()
public subroutine wf_change_color_focus ()
public function string wf_get_character ()
public function boolean wf_valid_key ()
public subroutine wf_show_message ()
public subroutine wf_hide_message ()
public function boolean wf_delete_object (long ll_serial)
public subroutine wf_disable_except_buttons ()
public subroutine wf_enable_except_buttons ()
end prototypes

event ue_close_audit_trail;bAuditTrail = FALSE
CloseUserObject ( u_audit_trail )
wf_enable_screen ( )
wf_set_focus ( )
end event

public subroutine disable_chars ();bChars = False
cb_1.Enabled = False
cb_2.Enabled = False
cb_3.Enabled = False
cb_4.Enabled = False
cb_5.Enabled = False
cb_6.Enabled = False
cb_7.Enabled = False
cb_8.Enabled = False
cb_9.Enabled = False
cb_10.Enabled = False
cb_11.Enabled = False
cb_12.Enabled = False
cb_13.Enabled = False
cb_14.Enabled = False
cb_15.Enabled = False
cb_16.Enabled = False
cb_17.Enabled = False
cb_18.Enabled = False
cb_19.Enabled = False
cb_20.Enabled = False
cb_21.Enabled = False
cb_22.Enabled = False
cb_23.Enabled = False
cb_24.Enabled = False
cb_31.Enabled = False
cb_32.Enabled = False
cb_40.Enabled = False
cb_41.Enabled = False
If bSerialNumber Then cb_43.Enabled = False
cb_55.Enabled = False


end subroutine

public subroutine enable_chars ();bChars = True

cb_1.Enabled = True
cb_2.Enabled = True
cb_3.Enabled = True
cb_4.Enabled = True
cb_5.Enabled = True
cb_6.Enabled = True
cb_7.Enabled = True
cb_8.Enabled = True
cb_9.Enabled = True
cb_10.Enabled = True
cb_11.Enabled = True
cb_12.Enabled = True
cb_13.Enabled = True
cb_14.Enabled = True
cb_15.Enabled = True
cb_16.Enabled = True
cb_17.Enabled = True
cb_18.Enabled = True
cb_19.Enabled = True
cb_20.Enabled = True
cb_21.Enabled = True
cb_22.Enabled = True
cb_23.Enabled = True
cb_24.Enabled = True
cb_31.Enabled = True
cb_32.Enabled = True
cb_40.Enabled = True
cb_41.Enabled = True
cb_43.Enabled = True
cb_55.Enabled = True

end subroutine

public subroutine disable_numbers ();bNumbers = False
cb_25.Enabled = False
cb_26.Enabled = False
cb_27.Enabled = False
cb_28.Enabled = False
cb_29.Enabled = False
cb_33.Enabled = False
cb_34.Enabled = False
cb_35.Enabled = False
cb_36.Enabled = False
cb_39.Enabled = False

end subroutine

public subroutine enable_numbers ();bNumbers = True
cb_25.Enabled = True
cb_26.Enabled = True
cb_27.Enabled = True
cb_28.Enabled = True
cb_29.Enabled = True
cb_33.Enabled = True
cb_34.Enabled = True
cb_35.Enabled = True
cb_36.Enabled = True
cb_39.Enabled = True

end subroutine

public subroutine wf_key_pressed (string ccharacter);wf_hide_message ( )
/*  Initialize Variables  */
If bOperator Then
	sle_operator.Text = sle_operator.Text + cCharacter
	sle_operator.SetFocus ( )
Elseif bSerialNumber Then
	sle_serial.Text = sle_serial.Text + cCharacter
	sle_serial.SetFocus ( )
Elseif bQCNotes Then
	mle_qc_notes.Text = mle_qc_notes.Text + cCharacter
	mle_qc_notes.SetFocus ( )
End if

end subroutine

public subroutine wf_setup_screen ();/*  Declare Variables  */

String	cMandatoryQCNotes
String	cDeleteScrap

SELECT mandatory_qc_notes
  INTO :cMandatoryQCNotes  
  FROM parameters  ;

If cMandatoryQCNotes = 'Y' Then bMandatoryQCNotes = True

bOpen = True

/*  Main  */

SELECT parameters.delete_scrapped_objects  
  INTO :cDeleteScrap  
  FROM parameters  ;

If f_get_string_value ( cDeleteScrap ) = 'Y' Then bDeleteScrap = True

dw_misc.SetTransObject ( sqlca )
dw_misc.Retrieve ( )

sle_serial.Text = stParm.Value2

sle_operator.SetFocus ( )


end subroutine

public subroutine wf_reset_indicators ();bOperator 		= False
bSerialNumber 	= False
bQCNotes 		= False

wf_reset_colors ( )
end subroutine

public subroutine wf_enable_screen ();cb_1.Enabled = True
cb_2.Enabled = True
cb_3.Enabled = True
cb_4.Enabled = True
cb_5.Enabled = True
cb_6.Enabled = True
cb_7.Enabled = True
cb_8.Enabled = True
cb_9.Enabled = True
cb_10.Enabled = True
cb_11.Enabled = True
cb_12.Enabled = True
cb_13.Enabled = True
cb_14.Enabled = True
cb_15.Enabled = True
cb_16.Enabled = True
cb_17.Enabled = True
cb_18.Enabled = True
cb_19.Enabled = True
cb_20.Enabled = True
cb_21.Enabled = True
cb_22.Enabled = True
cb_23.Enabled = True
cb_24.Enabled = True
cb_31.Enabled = True
cb_32.Enabled = True
cb_40.Enabled = True
cb_41.Enabled = True
cb_25.Enabled = True
cb_26.Enabled = True
cb_27.Enabled = True
cb_28.Enabled = True
cb_29.Enabled = True
cb_33.Enabled = True
cb_34.Enabled = True
cb_35.Enabled = True
cb_36.Enabled = True
cb_39.Enabled = True
cb_42.Enabled = True
cb_44.Enabled = True
cb_47.Enabled = True
cb_48.Enabled = True
cb_43.Enabled = True
cb_30.Enabled = True
cb_37.Enabled = True
cb_38.Enabled = True
cb_55.Enabled = True
cb_57.Enabled = True
//cb_51.Enabled = True


//  Common Stuff
sle_operator.Enabled = True
dw_misc.Enabled = True

sle_serial.Enabled = True

bNoKey = False
end subroutine

public subroutine wf_disable_screen ();bNoKey = True
cb_1.Enabled = False
cb_2.Enabled = False
cb_3.Enabled = False
cb_4.Enabled = False
cb_5.Enabled = False
cb_6.Enabled = False
cb_7.Enabled = False
cb_8.Enabled = False
cb_9.Enabled = False
cb_10.Enabled = False
cb_11.Enabled = False
cb_12.Enabled = False
cb_13.Enabled = False
cb_14.Enabled = False
cb_15.Enabled = False
cb_16.Enabled = False
cb_17.Enabled = False
cb_18.Enabled = False
cb_19.Enabled = False
cb_20.Enabled = False
cb_21.Enabled = False
cb_22.Enabled = False
cb_23.Enabled = False
cb_24.Enabled = False
cb_31.Enabled = False
cb_32.Enabled = False
cb_40.Enabled = False
cb_41.Enabled = False
cb_25.Enabled = False
cb_26.Enabled = False
cb_27.Enabled = False
cb_28.Enabled = False
cb_29.Enabled = False
cb_33.Enabled = False
cb_34.Enabled = False
cb_35.Enabled = False
cb_36.Enabled = False
cb_39.Enabled = False
cb_42.Enabled = False
cb_44.Enabled = False
//cb_46.Enabled = False
cb_47.Enabled = False
cb_48.Enabled = False
cb_43.Enabled = False
cb_30.Enabled = False
cb_37.Enabled = False
cb_38.Enabled = False
cb_55.Enabled = False
cb_57.Enabled = False
//cb_51.Enabled = False

//  Common Stuff
sle_operator.Enabled = False
dw_misc.Enabled = False

sle_serial.Enabled = False

end subroutine

public function boolean wf_modified ();//If bButton Then Return True
//
///*  Declare Variables  */
//
//String 	ls_Temp
//String	ls_Type
//String 	ls_TempPackaging
//String 	ls_OriginalUnit
//String 	ls_TempStatus
//String 	ls_NewStatus
//String 	ls_PartNumber
//String	ls_LimitLocs
//String	ls_ShowInInventory, &
//			s_ScaleAttached
//Int 		iRtnCode
//Int 		iLoop
//Dec 		dStdPack
//Dec 		dAddedQty, dTotalQty
//Dec 		dStdQuantity, dNewObjectQty
//Dec 		dStdQty
//Boolean 	bCheckLocation
//Long 		lNewSerial
//Long 		lTempShipper
//Long 		lTemp
//Date 		dToday
//Time 		tNow	
//
//dToday = Today ( )
//tNow   = Now ( )
//
//
///*  Main  */
//
//If bMachines Then
//
//	If bPopulateMachines Then ddlb_machines.Text = szSelectedText
//
//	If Not bBack Then
//
//		ls_Temp = ddlb_machines.Text
//
//		If dw_limit_locs.RowCount ( ) > 0 Then
//
//		  SELECT code  
//		    INTO :ls_Temp  
//		    FROM location,   
//		         location_limits  
//		   WHERE ( code = location_code ) and  
//		         ( ( location_code = :ls_Temp ) AND  
//		         ( trans_code = Left ( :stParm.Value1, 1 ) ) AND  
//		         ( type = 'MC' ) )   ;
//
//		Else
//
//		  SELECT code  
//		    INTO :ls_Temp  
//		    FROM location  
//		   WHERE ( code = :ls_Temp ) AND  
//		         ( type = 'MC' )   ;
//
//		End if
//	
//		If SQLCA.SQLCode <> 0 Then
//
//			f_beep ( 5 )
//	
//			If Not bPopulateMachines Then
//				iRtnCode = MessageBox ( "Error", "A valid machine is required! Would you like to use drop down list?", Question!, YesNo!, 1 )
//				If iRtnCode = 1 Then
//					bPopulateMachines = True
//					ddlb_machines.ShowList = True
//					If ddlb_machines.TotalItems ( ) < 1 Then wf_get_machines ( )
//				End if
//			Else
//				MessageBox ( "Error", "A valid machine is required!  Please select a valid one from list.", StopSign! )
//			End if
//			ddlb_machines.Text = ""
//			szRealityText = ""
//			szSelectedText = ""
//			ddlb_machines.SetFocus ( )
//			Return False
//	
//		Else
//	
//			ddlb_location_to.Text = ddlb_machines.Text
//	
//			SELECT machine_policy.scale_attached   
//			  INTO :s_ScaleAttached   
//			  FROM machine_policy  
//			 WHERE machine_policy.machine = :ddlb_machines.Text   ;
//
//			If SQLCA.SQLCode = 0 Then
//				If s_ScaleAttached = 'Y' Then &
//					ib_Scale = TRUE
//			End if
//
//		End if
//	
//	End if
//
//Elseif bParts Then
//	
//	If bPopulateParts Then ddlb_parts.Text = szSelectedText
//	ddlb_parts.Text = Upper ( ddlb_parts.Text )
//	
//	If Not bBack Then
//
//	   SELECT part.class  
//	     INTO :ls_Temp
//	     FROM part  
//            WHERE part.part = :ddlb_parts.Text  ;
//	
//		If SQLCA.SQLCode <> 0 Or ls_Temp <> 'M' Or ddlb_parts.Text = "" Then
//	
//			f_beep ( 5 )
//		
//			If Not bPopulateParts Then
//				iRtnCode = MessageBox ( "Error", "Invalid part number! Would you like to use drop down list?", Question!, YesNo!, 1 )
//				If iRtnCode = 1 Then
//					bPopulateParts = True
//					ddlb_parts.ShowList = True
//					If ddlb_parts.TotalItems ( ) < 1 Then wf_get_parts ( )
//				End if
//			Else
//				MessageBox ( "Error", "Invalid part number!  Please select a valid one from the list.", StopSign! )
//			End if
//			ddlb_parts.Text = ""
//			szRealityText = ""
//			szSelectedText = ""
//			ddlb_parts.SetFocus ( )
//			ddlb_packaging.ShowList = False
//			Return False
//		
//		Else
//		
//			dw_misc.SetTransObject ( sqlca )
//		
//			If dw_misc.Retrieve ( ddlb_parts.Text ) < 1 Then 
//				ddlb_parts.SetFocus ( ) 
//				ddlb_packaging.ShowList = False
//				Return False
//			End if
//			
//			dw_misc.SetItem ( 1, "standard_pack", "" )
//		
//			ddlb_parts.ShowList = False
//		
//			wf_get_unit_list ( ddlb_parts.Text, "" )
//	
//			ls_TempPackaging = ""
//			If ddlb_packaging.Text <> "" Then ls_TempPackaging = ddlb_packaging.Text
//			
//			If wf_packaging ( ddlb_parts.Text, ls_TempPackaging ) Then
//				ddlb_packaging.Text = ls_TempPackaging
//			End if
//		
//			If ib_Scale Then wf_check_for_scale ( )
//
//		End if
//		
//	End if
//
//Elseif bLocationTo Then
//	
//	If bPopulateLocations Then ddlb_location_to.Text = szSelectedText
//
//	If Not bBack Then
//
//		If stParm.Value1 = "Transfer" Then
//	
//			If rb_2.Checked Then
//	
//				dw_misc.Retrieve ( Long ( ddlb_location_to.Text ) )
//		
//			Else
//	
//				bCheckLocation = True
//	
//			End if
//	
//		End if
//	
//		If stParm.Value1 <> "Transfer" Or bCheckLocation Then
//	
//			ls_Temp = ddlb_location_to.Text
//	
//			If dw_limit_locs.RowCount ( ) > 0 Then
//
//			  SELECT location_code
//			    INTO :ls_Temp  
//			    FROM location_limits  
//			   WHERE ( trans_code = Left ( :stParm.Value1, 1 ) ) AND  
//			         ( location_code = :ls_Temp )   ;
//
//			Else
//
//			  SELECT code
//			    INTO :ls_Temp  
//			    FROM location 
//			   WHERE code = :ls_Temp   ;
//
//			End if
//	
//			If SQLCA.SQLCode <> 0 Then
//	
//				f_beep ( 5 )
//		
//				If Not bPopulateLocations Then
//					iRtnCode = MessageBox ( "Error", "Invalid location! Would you like to use drop down list?", Question!, YesNo!, 1 )
//					If iRtnCode = 1 Then
//						bPopulateLocations = True
//						ddlb_location_to.ShowList = True
//						If ddlb_location_to.TotalItems ( ) < 1 Then wf_get_location_tos ( )
//					End if
//				Else
//					MessageBox ( "Error", "Invalid location!  Please select a valid one from the list.", StopSign! )
//				End if
//				ddlb_location_to.Text = ""
//				szRealityText = ""
//				szSelectedText = ""
//				ddlb_location_to.SetFocus ( )
//				Return False
//
//			End if
//		
//		End if 
//
//	End if
//
//Elseif bPackaging Then
//
//	If ddlb_packaging.Text <> "" And Not bBack Then
//	
//		ddlb_packaging.Text = szSelectedText
//		If stParm.Value1 <> "JobComplete" Then
//			ls_PartNumber = dw_misc.GetItemString ( 1, "part" )
//		Else
//			ls_PartNumber = ddlb_parts.Text
//		End if
//
//		SELECT part_packaging.quantity  
//		  INTO :dStdPack  
//		  FROM part_packaging  
//		 WHERE ( part_packaging.part = :ls_PartNumber ) AND  
//		       ( part_packaging.code = :ddlb_packaging.Text )   ;
//		
//		If SQLCA.SQLCode <> 0 Then
//	
//			f_beep ( 5 )
//
//			MessageBox ( "Error", "Invalid package type!", StopSign! )
//			ddlb_packaging.Text = ""
//			szRealityText = ""
//			szSelectedText = ""
//			ddlb_packaging.SetFocus ( )
//			Return False
//	
//		Else
//
//			If stParm.Value1 = "JobComplete" Then
//				dw_misc.SetItem ( 1, "standard_pack", dStdPack )
//				If f_get_string_value ( sle_qty.Text ) = "" Then &
//					sle_qty.Text = String ( dStdPack )
//				If ib_Scale Then wf_check_for_scale ( )
//			Else
//				If dw_object.GetItemNumber ( 1, "quantity" ) > dStdPack Then
//					If f_get_string_value ( sle_qty.Text ) = "" Then &
//						sle_qty.Text = String ( dStdPack )
//				Else
//					sle_qty.Text = String ( dw_object.GetItemNumber ( 1, "quantity" ) )
//				End if
//			End if
//
//		End if
//
//	End if
//
//Elseif bLot Then
//
//	If f_get_string_value ( sle_lot.Text ) = "" And Not bBack Then
//
//		f_beep ( 5 )
//
//		iRtnCode = MessageBox ( "Error", "A material lot number is required to continue!", StopSign! )
//		sle_lot.SetFocus ( )
//
//		Return False
//
//	End if
//
//Elseif bOperator Then
//
//	If Not bBack Then
//
//		szOperator = ""
//
//		SELECT employee.operator_code  
//		  INTO :szOperator  
//		  FROM employee  
//		 WHERE employee.password = :sle_operator.Text   ;
//
//		szOperator = f_get_string_value ( szOperator )
//
//		If SQLCA.SQLCode = 0 Then
//	
//			gb_operator.Text = "Operator - " + szOperator
//
//		Else
//
//			f_beep ( 5 )
//
//			gb_operator.Text = "Operator -"
//			MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
//			sle_operator.Text = ""
//			sle_operator.SetFocus ( )
//			Return False
//
//		End if
//
//	End if
//
//Elseif bQty Then
//
//	If ib_PopupScaleInterface Then Return TRUE
//
//	If stParm.Value1 = "Material Issue" Or stParm.Value1 = "BreakOut" Then
//		If cIssueType = "U" And Dec ( sle_qty.Text ) <= 0 And Not bBack Then


//			f_beep ( 5 )
//			MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
//			sle_qty.SetFocus ( )
//			Return False
//		End if
//	ElseIf Dec ( sle_qty.Text ) <= 0 And Not bBack Then
//		f_beep ( 5 )
//		MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
//		sle_qty.SetFocus ( )
//		Return False
//	End if
//
//Elseif bNumberOf Then
//
//	If Dec ( sle_numberof.Text ) < 1 And Not bBack Then
//		f_beep ( 5 )
//		MessageBox ( "Error", "Number of objects must be greater than 0!", StopSign! )
//		sle_numberof.SetFocus ( )
//		Return False
//	End if
//
//Elseif bSerialNumber Then
//
//	/*  Main  */
//
//	//If Not bLoseFocus And Not bBack Then
//	If Not bBack Then
//
//		If Upper ( Left ( sle_serial.Text, 1 ) ) = 'S' Then
//			sle_serial.Text = Right ( sle_serial.Text, Len ( sle_serial.Text ) - 1 )
//		Elseif Not IsNumber ( Left ( sle_serial.Text, 1 ) ) Then
//			f_beep ( 5 )
//			sle_serial.Text = ""
//			MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
//			sle_serial.SetFocus ( )
//			Return False
//		End if
//	
//		lSerial = f_get_value ( Long ( sle_serial.Text ) )
//
//		If lSerial < 1 Then 
//			f_beep ( 5 )
//			sle_serial.Text = ""
//			MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
//			sle_serial.SetFocus ( )
//			Return False
//		End if
//	
//		SELECT object.serial,
//				 object.shipper,
//				 object.status
//		  INTO :lTemp,
//				 :lTempShipper,
//				 :ls_TempStatus
//		  FROM object  
//		 WHERE object.serial = :lSerial   ;
//	
//		If SQLCA.SQLCode <> 0 Then
//			f_beep ( 5 )
//			MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
//			sle_serial.Text = ""
//			sle_serial.SetFocus ( )
//			Return False
//		Elseif f_get_string_value ( ls_TempStatus ) <> "A" And stParm.Value1 = "Material Issue" Then
//			f_beep ( 5 )
//			MessageBox ( "Error", "You cannot perform this transaction on an object with status other than approved!", StopSign! )
//			sle_serial.Text = ""
//			sle_serial.SetFocus ( )
//			Return False
//		Elseif f_get_value ( lTempShipper ) > 0 Then
//			f_beep ( 5 )
//			MessageBox ( "Error", "You cannot perform this transaction on a staged object!", StopSign! )
//			sle_serial.Text = ""
//			sle_serial.SetFocus ( )
//			Return False
//		End if
//	
//		If stParm.Value1 = "Transfer" Then
//	
//			If KeyDown ( keyTab! ) And Not KeyDown ( keyEnter! ) Then Return False
//
//			/*  Check for operator  */
//	
//			If szOperator = "" Then
//				f_beep ( 5 )
//				MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
//				bOperator = True
//				wf_set_focus ( )
//				Return False
//			End if
//
//			If ddlb_location_to.Text = "" Then
//				If rb_1.Checked Then
//					f_beep ( 5 )
//					If Not bPopulateLocations Then
//						iRtnCode = MessageBox ( "Error", "Invalid location! Would you like to use drop down list?", Question!, YesNo!, 1 )
//						If iRtnCode = 1 Then
//							bPopulateLocations = True
//							ddlb_location_to.ShowList = True
//							wf_get_location_tos ( )
//						End if
//					Else
//						MessageBox ( "Error", "Invalid location!  Please select a valid one from the list.", StopSign! )
//					End if
//					ddlb_location_to.Text = ""
//					ddlb_location_to.SetFocus ( )
//					Return False
//				Else
//					f_beep ( 5 )
//					MessageBox ( "Error", "Invalid super object!  Please enter a valid one.", StopSign! )
//					ddlb_location_to.SetFocus ( )
//					Return False
//				End if
//
//			End if
//
//			dw_object.SetTransObject ( sqlca )
//			dw_object.Retrieve ( lSerial )
//			
//			/*
//			Figure out From and To Locations
//			*/
//			
//			cObjectType = f_get_string_value ( &
//				dw_object.GetItemString ( 1, "type" ) )
//			lParent = f_get_value ( &
//				dw_object.GetItemNumber ( 1, "parent_serial" ) )
//			
//			szNewLoc     = f_get_string_value ( ddlb_location_to.Text )
//			bSuper       = False
//			bZeroParent  = False
//			bNoCheck     = False
//			bWriteParent = False
//		
//			szMessage = "message"
//
//			If cObjectType = "S" Then	  // Object is a super one
//
//				/*
//				Super Object can only be transfered to a location and not another
//				super object.
//				*/
//		
//				If rb_2.Checked = True Then     
//			
//					MessageBox ( "Error", "You cannot transfer a super object to another super object!", StopSign! )
//					sle_serial.Text = ""
//					sle_serial.SetFocus ( )
//					Return False
//				
//				End if
//			
//				szLocation = wf_location_of_super_object ( lSerial )
//
//				szMessage = "You cannot transfer super " + &
//								"object to the same location!"
//
//				bSuper = True
//
//		 	Else   // Just a normal object
//		
//				szLocation = f_get_string_value ( &
//					dw_object.GetItemString ( 1, "Location" ) )
//		
//				If lParent > 0 Then     //  Object is attached to a super object
//
//					/*
//					Object attached to a Super-object -> location
//					*/
//					If rb_1.Checked Then  
//
//						szLocation = wf_location_of_super_object ( lSerial )
//						szMessage = "You cannot transfer to the same location!"
//						bZeroParent = True
//				
//					/*
//					Object attached to a Super-object -> Super-object
//					*/
//					Else        //  Normal object
//	
//						szLocation = String ( lParent )
//						szMessage = "You cannot transfer an object " + &
//										"to the same Super Object!"
//						bWriteParent = True
//		  
//					End if
//		
//				/*
//				Object
//				*/
//				Else
//				
//					/*
//					Object -> Location
//					*/
//					If rb_1.Checked Then
//
//						szMessage = "You cannot transfer to the same location!"
//
//					/*
//					Object -> Super-object
//					*/
//					Else
//
//						bNoCheck = True
//						bWriteParent = True
//
//					End if
//						
//				End if
//
//			End if
//
//
//			If Not bNoCheck Then
//
//				If szLocation = szNewLoc Then
//
//					f_beep ( 5 )
//					MessageBox ( "Error", szMessage, StopSign! )
//					sle_serial.Text = ''	
//					sle_serial.SetFocus ( )
//					Return False
//
//				End if
//
//			End if
//	
//			If bSuper Then
//
//				dw_misc.SetTransObject ( sqlca )
//				dw_misc.Retrieve ( lSerial )
//		
//				wf_transfer_update_objects ( )
//
//			Else
//
//				lParent = Long ( ddlb_location_to.Text )
//				dwObject = dw_object
//				wf_transfer_update_object ( )
//	
//			End if
//	
//			If rb_2.Checked Then &
//				dw_misc.Retrieve ( lParent )	
//
//		ElseIf stParm.Value1 = "BreakOut" Then
//	
//			bLoseFocus = True
//	
//			dw_misc.SetTransObject ( sqlca )
//			dw_misc.Retrieve ( lSerial )
//	
//			szPart = dw_misc.GetItemString ( 1, "part" )
//			ls_OriginalUnit = dw_misc.GetItemString ( 1, "unit" )
//	
//			dw_object.SetTransObject ( sqlca )
//			dw_object.Retrieve ( lSerial )
//	
//			wf_get_unit_list ( szPart, ls_OriginalUnit )
//	
//			ddlb_unit.Text = ls_OriginalUnit
//
//			ls_TempPackaging = ""
//			If ddlb_packaging.Text <> "" Then ls_TempPackaging = ddlb_packaging.Text
//			
//			If wf_packaging ( szPart, ls_TempPackaging ) Then
//				ddlb_packaging.Text = ls_TempPackaging
//			End if
//
//		Elseif stParm.Value1 = "Material Issue" Then
//	
//			bLoseFocus = True
//	
//			dw_misc.SetTransObject ( sqlca )
//			dw_misc.Retrieve ( lSerial )
//
//			szPart = dw_misc.GetItemString ( 1, "part" )
//			ls_OriginalUnit = dw_misc.GetItemString ( 1, "unit" )
//
//			SELECT part_inventory.material_issue_type  
//			  INTO :cIssueType  
//			  FROM part_inventory  
//			 WHERE part_inventory.part = :szPart   ;
//	
//			wf_get_unit_list ( szPart, ls_OriginalUnit )
//	
//			ddlb_unit.Text = ls_OriginalUnit
//
//			dw_object.SetTransObject ( sqlca )
//			dw_object.Retrieve ( lSerial )
//
//			If cIssueType = "U" Then
//				gb_qty.Text = "Quantity Used"
//				sle_qty.Text = String ( dw_object.GetItemNumber ( 1, "quantity" ) )
//			Else
//				gb_qty.Text = "Quantity Remaining"
//			End if
//
//			szField = "qty"
//			wf_set_focus ( )
//
//		Elseif stParm.Value1 = "Quality Control" Then
//
//			dw_object.SetTransObject ( sqlca )
//
//			String cCurrentStatus
//
//			Dec dPrice, dOnHand, dWeight, dQuantity
//
//			lSerial = f_get_value ( Long ( sle_serial.Text ) )
//	
//			If lSerial < 1 Then Return False
//
//			If dw_object.Retrieve ( lSerial ) < 1 Then
//				f_beep ( 5 )
//				MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
//				sle_serial.Text = ""
//				sle_serial.Setfocus ( )
//				Return False
//			End if
//
//			cCurrentStatus = dw_object.GetItemString ( 1, "status" )
//			ls_NewStatus = dw_misc.GetItemString ( 1, "status" )
//
//			If cCurrentStatus = ls_NewStatus Then
//				f_beep ( 5 )
//				MessageBox ( "Error", "This object is already at the selected status!", StopSign! )
//				sle_serial.Text = ""
//				sle_serial.SetFocus ( )
//				Return False
//			End if
//
//			dw_object.SetItem ( 1, "status", ls_NewStatus )
//			dw_object.SetItem ( 1, "last_date", dToday )
//			dw_object.SetItem ( 1, "last_time", tNow )
//			dw_object.SetItem ( 1, "operator", szOperator )
//
//			If dw_object.Update ( ) = -1 Then
//				RollBack ;
//				sle_serial.Text = ""
//				f_beep ( 5 )
//				Return False
//			Else
//			
//				If Not f_create_audit_trail ( lSerial, "Q", cCurrentStatus, ls_NewStatus, "", "", "", "", "", "", "", "" ) Then
//
//					Return False
//
//				End if
//
//				f_beep ( 1 )
//				wf_show_message ( )	
//				sle_serial.SetFocus ( )
//
//			End if
//
//		End if
//
//	Else
//
//		bLoseFocus = False
//
//	End if
//
//Elseif bQCNotes Then
//
//	If bMandatoryQCNotes and f_get_string_value ( mle_qc_notes.Text ) = "" And cStatus <> 'A' Then
//		mle_qc_notes.SetFocus ( )
//		Return False
//	Else
//		sle_serial.Setfocus ( )
//	End if	
//
//End if
//	
Return True
//
//
end function

public subroutine wf_set_focus ();Choose Case ClassName ( igo_last )

	Case "sle_operator"
		sle_operator.SetFocus ( )

	Case "sle_serial"
		sle_serial.SetFocus ( )

	Case "mle_qc_notes"
		mle_qc_notes.SetFocus ( )

End Choose


end subroutine

public subroutine wf_reset_colors ();//gb_operator.TextColor = f_get_color_value ( "darkred" )
//gb_serial_number.TextColor = f_get_color_value ( "darkred" )
//gb_qc_notes.TextColor = f_get_color_value ( "darkred" )
//
gb_operator.TextColor = f_get_color_value ( "black" )
gb_serial_number.TextColor = f_get_color_value ( "black" )
gb_qc_notes.TextColor = f_get_color_value ( "black" )

end subroutine

public subroutine wf_change_color_focus ();wf_reset_colors ( )
//Choose Case ClassName ( igo_last )
//	Case "sle_operator"
//		gb_operator.TextColor = f_get_color_value ( "blue" )
//	Case "sle_serial"
//		gb_serial_number.TextColor = f_get_color_value ( "blue" )
//	Case "mle_qc_notes"
//		gb_qc_notes.TextColor = f_get_color_value ( "blue" )
//End Choose

Choose Case ClassName ( igo_last )
	Case "sle_operator"
		gb_operator.TextColor = f_get_color_value ( "black" )
	Case "sle_serial"
		gb_serial_number.TextColor = f_get_color_value ( "black" )
	Case "mle_qc_notes"
		gb_qc_notes.TextColor = f_get_color_value ( "black" )
End Choose

end subroutine

public function string wf_get_character ();If KeyDown ( keyA! ) Then
	Return "A"
Elseif KeyDown ( keyB! ) Then
	Return "B"
Elseif KeyDown ( keyC! ) Then
	Return "C"
Elseif KeyDown ( keyD! ) Then
	Return "D"
Elseif KeyDown ( keyE! ) Then
	Return "E"
Elseif KeyDown ( keyF! ) Then
	Return "F"
Elseif KeyDown ( keyG! ) Then
	Return "G"
Elseif KeyDown ( keyH! ) Then
	Return "H"
Elseif KeyDown ( keyI! ) Then
	Return "I"
Elseif KeyDown ( keyJ! ) Then
	Return "J"
Elseif KeyDown ( keyK! ) Then
	Return "K"
Elseif KeyDown ( keyL! ) Then
	Return "L"
Elseif KeyDown ( keyM! ) Then
	Return "M"
Elseif KeyDown ( keyN! ) Then
	Return "N"
Elseif KeyDown ( keyO! ) Then
	Return "O"
Elseif KeyDown ( keyP! ) Then
	Return "P"
Elseif KeyDown ( keyQ! ) Then
	Return "Q"
Elseif KeyDown ( keyR! ) Then
	Return "R"
Elseif KeyDown ( keyS! ) Then
	Return "S"
Elseif KeyDown ( keyT! ) Then
	Return "T"
Elseif KeyDown ( keyU! ) Then
	Return "U"
Elseif KeyDown ( keyV! ) Then
	Return "V"
Elseif KeyDown ( keyW! ) Then
	Return "W"
Elseif KeyDown ( keyX! ) Then
	Return "X"
Elseif KeyDown ( keyY! ) Then
	Return "Y"
Elseif KeyDown ( keyZ! ) Then
	Return "Z"
Elseif KeyDown ( key0! ) Then
	Return "0"
Elseif KeyDown ( key1! ) Then
	Return "1"
Elseif KeyDown ( key2! ) Then
	Return "2"
Elseif KeyDown ( key3! ) Then
	Return "3"
Elseif KeyDown ( key4! ) Then
	Return "4"
Elseif KeyDown ( key5! ) Then
	Return "5"
Elseif KeyDown ( key6! ) Then
	Return "6"
Elseif KeyDown ( key7! ) Then
	Return "7"
Elseif KeyDown ( key8! ) Then
	Return "8"
Elseif KeyDown ( key9! ) Then
	Return "9"
Elseif KeyDown ( keyDash! ) Then
	Return "_"
Elseif KeyDown ( keyNumPad0! ) Then
	Return "0"
Elseif KeyDown ( keyNumPad1! ) Then
	Return "1"
Elseif KeyDown ( keyNumPad2! ) Then
	Return "2"
Elseif KeyDown ( keyNumPad3! ) Then
	Return "3"
Elseif KeyDown ( keyNumPad4! ) Then
	Return "4"
Elseif KeyDown ( keyNumPad5! ) Then
	Return "5"
Elseif KeyDown ( keyNumPad6! ) Then
	Return "6"
Elseif KeyDown ( keyNumPad7! ) Then
	Return "7"
Elseif KeyDown ( keyNumPad8! ) Then
	Return "8"
Elseif KeyDown ( keyNumPad9! ) Then
	Return "9"
End if

Return ""

end function

public function boolean wf_valid_key ();If KeyDown ( keyA! ) Or &
   KeyDown ( keyB! ) Or &
   KeyDown ( keyC! ) Or &
   KeyDown ( keyD! ) Or &
   KeyDown ( keyE! ) Or &
   KeyDown ( keyF! ) Or &
   KeyDown ( keyG! ) Or &
   KeyDown ( keyH! ) Or &
   KeyDown ( keyI! ) Or &
   KeyDown ( keyJ! ) Or &
   KeyDown ( keyK! ) Or &
   KeyDown ( keyL! ) Or &
   KeyDown ( keyM! ) Or &
   KeyDown ( keyN! ) Or &
   KeyDown ( keyO! ) Or &
   KeyDown ( keyP! ) Or &
   KeyDown ( keyQ! ) Or &
   KeyDown ( keyR! ) Or &
   KeyDown ( keyS! ) Or &
   KeyDown ( keyT! ) Or &
   KeyDown ( keyU! ) Or &
   KeyDown ( keyV! ) Or &
   KeyDown ( keyW! ) Or &
   KeyDown ( keyX! ) Or &
   KeyDown ( keyY! ) Or &
   KeyDown ( keyZ! ) Or &
   KeyDown ( key0! ) Or &
   KeyDown ( key1! ) Or &
   KeyDown ( key2! ) Or &
   KeyDown ( key3! ) Or &
   KeyDown ( key4! ) Or &
   KeyDown ( key5! ) Or &
   KeyDown ( key6! ) Or &
   KeyDown ( key7! ) Or &
   KeyDown ( key8! ) Or &
   KeyDown ( key9! ) Or &
   KeyDown ( keyDash! ) Or &
   KeyDown ( keyNumPad0! ) Or &
   KeyDown ( keyNumPad1! ) Or &
   KeyDown ( keyNumPad2! ) Or &
   KeyDown ( keyNumPad3! ) Or &
   KeyDown ( keyNumPad4! ) Or &
   KeyDown ( keyNumPad5! ) Or &
   KeyDown ( keyNumPad6! ) Or &
   KeyDown ( keyNumPad7! ) Or &
   KeyDown ( keyNumPad8! ) Or &
   KeyDown ( keyNumPad9! ) Then

	Return True

End if

Return False
end function

public subroutine wf_show_message ();bMessage = True
Timer ( .25, This )
end subroutine

public subroutine wf_hide_message ();sle_status.visible=false
Timer ( 0 )
bMessage = False
end subroutine

public function boolean wf_delete_object (long ll_serial);DELETE FROM object  
 WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	Return False
End if

Return True
end function

public subroutine wf_disable_except_buttons ();cb_42.Enabled = False
cb_44.Enabled = False
//cb_46.Enabled = False
cb_47.Enabled = False
cb_48.Enabled = False
cb_38.Enabled = False
sle_operator.Enabled = False
dw_misc.Enabled = False
sle_serial.Enabled = False

end subroutine

public subroutine wf_enable_except_buttons ();cb_42.Enabled = TRUE
cb_44.Enabled = TRUE
cb_47.Enabled = TRUE
cb_48.Enabled = TRUE
cb_38.Enabled = TRUE
sle_operator.Enabled = TRUE
dw_misc.Enabled = TRUE
sle_serial.Enabled = TRUE

end subroutine

event key;//If bNoKey Or bUserOperator Or bUserNotes Or bAuditTrail Then Return
//
///*  Declare Variables  */
//DropDownListBox ddlbCurrentObject
//String szLeft, szRight
//
//If bMessage Then wf_hide_message ( )
//
//
//IF ib_Password OR bAuditTrail OR ib_Notes THEN RETURN
//
///*  Main  */
//If KeyDown ( keyEnter! ) And Not KeyDown ( keyTab! ) And &
//	( stParm.Value1 = "Transfer" Or stParm.Value1 = "Quality Control" ) And &
//	bSerialNumber Then
//	sle_serial.TriggerEvent ( "button_clicked" )
//
//Elseif bMachines Or bParts Or bLocationTo Or bPackaging Then
//
//	If ( bMachines And bPopulateMachines ) Or ( bParts And bPopulateParts ) &
//		Or ( bLocationTo And bPopulateLocations ) Then
//
//		If Not IsNull ( GetFocus ( ) ) Then &
//			ddlbCurrentObject = GetFocus ( )
//
//		If wf_valid_key ( ) Then
//
//			cCharacterTouched = wf_get_character ( )
//	
//			Timer ( .055, This )
//
//		Elseif KeyDown ( keyBack! ) Then
//
//			ddlbCurrentObject.Text = Left ( ddlbCurrentObject.Text, Len ( ddlbCurrentObject.Text ) - 1 )
//			szRealityText = Left ( szRealityText, len ( szRealityText ) - 1 )
//			cCharacterTouched = ""
//			Timer ( .055, This )
//
//		Elseif KeyDown ( keyDelete! ) Then
//
//			ddlbCurrentObject.Text = Right ( ddlbCurrentObject.Text, Len ( ddlbCurrentObject.Text ) - 1 )
//			szRealityText = Right ( szRealityText, len ( szRealityText ) - 1 )
//			cCharacterTouched = ""
//			Timer ( .055, This )
//	
//		End if
//
//	End if
//
//Elseif KeyDown ( keyTab! ) Then
//
//	bTab = True
//
//End if
//
end event

event open;/*  Initialize Variables  */

bChars = True
bNumbers = True

stParm        = Message.PowerObjectParm

lSerialParm   = Long ( stParm.Value2 )
If stParm.Value2 = "0" Then stParm.Value2 = ""
cb_46.text = 'No Label'

dtToday = DateTime ( Today ( ), Now ( ) )

/*  Determine type of transaction and prime the dataobject of dw_1  */

wf_setup_screen ( )


end event

event timer;If bMessage Then
	If sle_status.Visible = True Then
		sle_status.Visible = False
	Else
		sle_status.Visible = True
	End if
	Return
End if

end event

on w_quality_control.create
this.dw_transactions=create dw_transactions
this.sle_status=create sle_status
this.st_1=create st_1
this.cb_57=create cb_57
this.cb_55=create cb_55
this.cb_48=create cb_48
this.dw_object=create dw_object
this.sle_operator=create sle_operator
this.sle_serial=create sle_serial
this.cb_47=create cb_47
this.cb_46=create cb_46
this.cb_44=create cb_44
this.cb_42=create cb_42
this.dw_1=create dw_1
this.cb_41=create cb_41
this.cb_43=create cb_43
this.cb_40=create cb_40
this.cb_39=create cb_39
this.cb_38=create cb_38
this.cb_37=create cb_37
this.cb_36=create cb_36
this.cb_35=create cb_35
this.cb_34=create cb_34
this.cb_33=create cb_33
this.cb_32=create cb_32
this.cb_31=create cb_31
this.cb_30=create cb_30
this.cb_29=create cb_29
this.cb_28=create cb_28
this.cb_27=create cb_27
this.cb_26=create cb_26
this.cb_25=create cb_25
this.cb_24=create cb_24
this.cb_23=create cb_23
this.cb_22=create cb_22
this.cb_21=create cb_21
this.cb_20=create cb_20
this.cb_19=create cb_19
this.cb_18=create cb_18
this.cb_17=create cb_17
this.cb_16=create cb_16
this.cb_15=create cb_15
this.cb_14=create cb_14
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_title=create sle_title
this.gb_serial_number=create gb_serial_number
this.mle_qc_notes=create mle_qc_notes
this.dw_misc=create dw_misc
this.gb_qc_notes=create gb_qc_notes
this.gb_dwbox=create gb_dwbox
this.gb_operator=create gb_operator
this.Control[]={this.dw_transactions,&
this.sle_status,&
this.st_1,&
this.cb_57,&
this.cb_55,&
this.cb_48,&
this.dw_object,&
this.sle_operator,&
this.sle_serial,&
this.cb_47,&
this.cb_46,&
this.cb_44,&
this.cb_42,&
this.dw_1,&
this.cb_41,&
this.cb_43,&
this.cb_40,&
this.cb_39,&
this.cb_38,&
this.cb_37,&
this.cb_36,&
this.cb_35,&
this.cb_34,&
this.cb_33,&
this.cb_32,&
this.cb_31,&
this.cb_30,&
this.cb_29,&
this.cb_28,&
this.cb_27,&
this.cb_26,&
this.cb_25,&
this.cb_24,&
this.cb_23,&
this.cb_22,&
this.cb_21,&
this.cb_20,&
this.cb_19,&
this.cb_18,&
this.cb_17,&
this.cb_16,&
this.cb_15,&
this.cb_14,&
this.cb_13,&
this.cb_12,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.sle_title,&
this.gb_serial_number,&
this.mle_qc_notes,&
this.dw_misc,&
this.gb_qc_notes,&
this.gb_dwbox,&
this.gb_operator}
end on

on w_quality_control.destroy
destroy(this.dw_transactions)
destroy(this.sle_status)
destroy(this.st_1)
destroy(this.cb_57)
destroy(this.cb_55)
destroy(this.cb_48)
destroy(this.dw_object)
destroy(this.sle_operator)
destroy(this.sle_serial)
destroy(this.cb_47)
destroy(this.cb_46)
destroy(this.cb_44)
destroy(this.cb_42)
destroy(this.dw_1)
destroy(this.cb_41)
destroy(this.cb_43)
destroy(this.cb_40)
destroy(this.cb_39)
destroy(this.cb_38)
destroy(this.cb_37)
destroy(this.cb_36)
destroy(this.cb_35)
destroy(this.cb_34)
destroy(this.cb_33)
destroy(this.cb_32)
destroy(this.cb_31)
destroy(this.cb_30)
destroy(this.cb_29)
destroy(this.cb_28)
destroy(this.cb_27)
destroy(this.cb_26)
destroy(this.cb_25)
destroy(this.cb_24)
destroy(this.cb_23)
destroy(this.cb_22)
destroy(this.cb_21)
destroy(this.cb_20)
destroy(this.cb_19)
destroy(this.cb_18)
destroy(this.cb_17)
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_title)
destroy(this.gb_serial_number)
destroy(this.mle_qc_notes)
destroy(this.dw_misc)
destroy(this.gb_qc_notes)
destroy(this.gb_dwbox)
destroy(this.gb_operator)
end on

type dw_transactions from datawindow within w_quality_control
boolean visible = false
integer x = 3232
integer y = 480
integer width = 1865
integer height = 480
integer taborder = 10
string dataobject = "d_audit_trail_by_date"
boolean livescroll = true
end type

type sle_status from statictext within w_quality_control
boolean visible = false
integer x = 969
integer y = 12
integer width = 672
integer height = 112
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
boolean underline = true
long textcolor = 65280
long backcolor = 77897888
boolean enabled = false
string text = "Successful"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_quality_control
integer x = 1733
integer y = 20
integer width = 1184
integer height = 128
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "[Enter Button] / [Tab Key]-Next Field            [Back Button] / [<Shift>Tab]-Previous Field "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_57 from commandbutton within w_quality_control
integer x = 2194
integer y = 1728
integer width = 311
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Back"
end type

event clicked;If bMessage Then wf_hide_message ( )

ib_forward = FALSE

igo_last.Event Dynamic ue_validate ( )

//SingleLineEdit	sle_last
//MultiLineEdit	mle_last
//
//If bMessage Then wf_hide_message ( )
//
//ib_forward = TRUE
//
//Choose Case TypeOf ( igo_last )
//	Case singlelineedit!
//		sle_last = igo_last
//		sle_last.Setfocus ( )
//	Case multilineedit!
//		mle_last = igo_last
//		mle_last.Setfocus ( )
//End Choose
//
//if bOperator Then
//	sle_operator.TriggerEvent ( "ue_validate" )
//Elseif bSerialNumber Then
//	sle_serial.TriggerEvent ( "ue_validate" )
//Elseif bQCNotes Then
//	mle_qc_notes.TriggerEvent ( "ue_validate" )
//End if
//
end event

type cb_55 from commandbutton within w_quality_control
integer x = 1573
integer y = 1728
integer width = 311
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Space"
end type

on clicked;wf_key_pressed ( " " )
end on

type cb_48 from commandbutton within w_quality_control
integer x = 2450
integer y = 480
integer width = 475
integer height = 160
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

type dw_object from datawindow within w_quality_control
boolean visible = false
integer x = 2341
integer y = 2320
integer width = 494
integer height = 364
string dataobject = "d_object_data"
boolean livescroll = true
end type

type sle_operator from singlelineedit within w_quality_control
event button_clicked pbm_custom01
event ue_key pbm_keyup
event ue_validate ( )
integer x = 73
integer y = 256
integer width = 731
integer height = 128
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event ue_key;//if KeyDown ( keyShift! ) Then 
//	if key = keyTab! or key = keyEnter! then
//		ib_forward = FALSE
//		TriggerEvent ( "ue_validate" )
//	end if
//else
//	if key = keyTab! or key = keyEnter! then
//		ib_forward = TRUE
//		TriggerEvent ( "ue_validate" )
//	end if
//end if


boolean	l_b_shift

if KeyDown ( keyShift! ) Then l_b_shift = TRUE
if key = keyTab! or key = keyEnter! then
	if l_b_shift then
		ib_back = TRUE
		TriggerEvent ( "ue_validate" )
	else
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if

end event

event ue_validate;String	cNumberOfMode
String	cQtyMode
String	cUnitMode

szOperator = ""

If ib_forward Then

	SELECT employee.operator_code  
	  INTO :szOperator  
	  FROM employee  
	 WHERE employee.password = :sle_operator.Text   ;
	
	szOperator = f_get_string_value ( szOperator )
	
	If SQLCA.SQLCode = 0 Then
	
		gb_operator.Text = "Operator - " + szOperator
      boperator=false 
		mle_qc_notes.SetFocus ( )

	Else

		f_beep ( 5 )
		gb_operator.Text = "Operator -"
		MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
		Text = ""
		SetFocus ( )
		Return
	
	End if

Else

	SetFocus ( )
	
End if

end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )

If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_Last = This
boperator=True
wf_change_color_focus ( )


end event

type sle_serial from singlelineedit within w_quality_control
event ue_key pbm_keyup
event ue_validate ( )
integer x = 78
integer y = 944
integer width = 731
integer height = 128
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event ue_key;if KeyDown ( keyShift! ) Then 
	if key = keyTab! or key = keyEnter! then
		ib_forward = FALSE
		TriggerEvent ( "ue_validate" )
	end if
else
	if key = keyTab! or key = keyEnter! then
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if
end event

event ue_validate();/*  Declare Variables  */

String szOriginalUnit
String cTempStatus
String cNewStatus
String szTempPackaging
String ls_CurrentUserDefinedStatus
String ls_DefectCode
String ls_Part
String ls_Machine
	
Long lTemp
Long lTempShipper
	
 Date dToday
	
Time tNow
		
Int iRtnCode
Int iLoop
String l_s_serial
st_generic_structure stParm2
			
/*  Initialize Variables  */

dToday = Today ( )
tNow   = Now ( )

/*  Main  */

If ib_forward Then
		
	lSerial = f_get_value ( Long ( f_serial_validate(Text )) )
	If lSerial < 1 Then 
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
		SetFocus ( )
		Return
	End if
	
	If cstatus = '' Then 
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid status, please select a proper status ", StopSign! )
		dw_misc.SetFocus ( )
		Return
	End if
	
	
	SELECT object.serial,
			 object.shipper,
			 object.status
	  INTO :lTemp,
			 :lTempShipper,
			 :cTempStatus
	  FROM object  
	 WHERE object.serial = :lSerial   ;
		
	If SQLCA.SQLCode <> 0 Then
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
		Text = ""
		SetFocus ( )
		Return
	Elseif f_get_value ( lTempShipper ) > 0 Then
		f_beep ( 5 )
		MessageBox ( "Error", "You cannot perform this transaction on a staged object!", StopSign! )
		Text = ""
		SetFocus ( )
		Return
	End if
		
//	If dw_misc.GetRow ( ) < 1 Or Not dw_misc.IsSelected ( dw_misc.GetRow ( ) ) Then
//		f_beep ( 5 )
//		MessageBox ( "Error", "Please select a new status before continuing!", StopSign! )
////		Text = ""
//		dw_misc.Setfocus ( )
//		Return
//	End if
	
	if sle_operator.Text <= '' then
		f_beep ( 5 )
		MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
		sle_operator.SetFocus ( )
		Return
	else
		SELECT employee.operator_code  
		  INTO :szOperator  
		  FROM employee  
		 WHERE employee.password = :sle_operator.Text   ;
		if LenA(szOperator) <= 0 then
			f_beep ( 5 )
			MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
			sle_operator.SetFocus ( )
			Return
		end if 			
	end if

	// boolean var check was inc by me on 11/11/98 5.59 pm
	if (bmandatoryqcnotes=True and (mle_qc_notes.Text <= '' and cStatus <> 'A')) then
		f_beep ( 5 )
		MessageBox ( "Error", "Notes must be entered if the new status is anything but approved!", StopSign! )
		mle_qc_notes.SetFocus ( )
		Return
	end if
	
	dw_object.SetTransObject ( sqlca )
	
	String cCurrentStatus
	
	Dec dPrice, dOnHand, dWeight, dQuantity
	
	lSerial = f_get_value ( Long ( f_serial_validate(Text )) )
	
	If lSerial < 1 Then Return
	
	If dw_object.Retrieve ( lSerial ) < 1 Then
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
		Text = ""
		Setfocus ( )
		Return
	End if
	
	ls_CurrentUserDefinedStatus = dw_object.GetItemString ( 1, "user_defined_status" )
	cCurrentStatus = dw_object.GetItemString ( 1, "status" )
	cNewStatus = cStatus //dw_misc.GetItemString ( 1, "status" )
	
	If ls_CurrentUserDefinedStatus = is_UserStatus then //cCurrentStatus = cNewStatus Then
		f_beep ( 5 )
		MessageBox ( "Error", "This object is already at the selected status!", StopSign! )
		Text = ""
		SetFocus ( )
		Return
	End if
		
	dw_object.SetItem ( 1, "status", cNewStatus )
	dw_object.SetItem ( 1, "last_date", dToday )
	dw_object.SetItem ( 1, "last_time", tNow )
	dw_object.SetItem ( 1, "operator", szOperator )
	dw_object.SetItem ( 1, "user_defined_status", is_UserStatus )
	dw_object.SetItem ( 1, "note", mle_qc_notes.Text )
	
	If cCurrentStatus = "A" And cNewStatus <> "A" Then
	
		dOnHand = f_update_onhand ( dw_object.GetItemString ( 1, "part" ), &
								dw_object.GetItemNumber ( 1, "std_quantity" ), &
								"-*" )
	ElseIf cCurrentStatus <> "A" And cNewStatus = "A" Then
	
		dOnHand = f_update_onhand ( dw_object.GetItemString ( 1, "part" ), &
								dw_object.GetItemNumber ( 1, "std_quantity" ), &
								"+*" )
	End if
	
	If dw_object.Update ( ) = -1 Then
		RollBack ;
		Text = ""
		f_beep ( 5 )
		Return
	Else
	
		If Not f_create_audit_trail ( lSerial, "Q", cCurrentStatus, cNewStatus, mle_qc_notes.Text, "", "", "", "", "", "", "" ) Then
			RollBack ;
			f_beep ( 5 )
			Return
		End if
	
		if cb_46.text = 'Label' then 
			//  print label
			f_beep ( 1 )
			stParm2.value1 = String ( lSerial )
			f_print_label ( stParm2 )
		end if 
		
		If cNewStatus = 'S' Then
			
			If bDeleteScrap Then
				If Not f_create_audit_trail ( lSerial, "D", szOperator, String ( dOnHand ), "", "", "", "", "", "", "", "" ) Then
					RollBack ;
					f_beep ( 5 )
					Return
				End if
				
				DELETE FROM object  
				 WHERE serial = :lSerial   ;
	
				If SQLCA.SQLCode <> 0 Then
					RollBack ;
					f_beep ( 5 )
					Return
				Else
					Commit ;
				End if
	
			End if
	
			if MessageBox ( "Defects", "Report any defects?", Question!, YesNo!, 1 ) = 1 Then
	
				Open ( w_defects_entry_no_quantity )
	
				ls_DefectCode = Message.StringParm
	
				If ls_DefectCode > "" Then
	
					dQuantity = dw_object.GetItemNumber ( 1, "std_quantity" )
					ls_Machine = dw_object.GetItemString ( 1, "location" )
					dToday = Today ( )
					tNow = Now ( )
					ls_Part = dw_object.GetItemString ( 1, "part" )
					l_s_serial=String(lserial)
	
					INSERT INTO defects  
								( machine,   
								part,   
								reason,   
								quantity,   
								operator,   
								shift,   
								work_order,   
								data_source,   
								defect_date,   
								defect_time )  
						VALUES ( :ls_Machine,   
								:ls_Part,   
								:ls_DefectCode,   
								:dQuantity,   
								:szoperator,   
								null,   
								:szWorkOrder,   
								:l_s_serial,   
								:dToday,   
								:tNow )  ;
					If sqlca.sqlcode = 0 then
						Commit;
					else
						Rollback;
					end if	
	
				End if
	
			End if
	
		End if
	
		f_beep ( 1 )
		Text = ""
		bserialnumber=false
		wf_show_message ( )						
	
	End if
	
Else
   bserialnumber=false
//	mle_qc_notes.SetFocus ( )
    dw_misc.setfocus()

End if
end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )

If bChars Then Disable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_Last = This
bserialnumber=true
wf_change_color_focus ( )


end event

type cb_47 from commandbutton within w_quality_control
integer x = 2450
integer y = 800
integer width = 475
integer height = 160
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

type cb_46 from commandbutton within w_quality_control
integer x = 2450
integer y = 960
integer width = 475
integer height = 160
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "No Label"
end type

event clicked;if text = 'No Label' then 
	text = 'Label'
else
	text = 'No Label'
end if 	
end event

type cb_44 from commandbutton within w_quality_control
integer x = 2450
integer y = 640
integer width = 475
integer height = 160
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
end type

type cb_42 from commandbutton within w_quality_control
integer x = 2450
integer y = 320
integer width = 475
integer height = 160
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Audit Trail"
end type

event clicked;str_audit_trail	str_Parm

If bMessage Then wf_hide_message ( )

SetPointer ( HourGlass! )

bAuditTrail = True

wf_disable_screen ( )

str_Parm.adt_Today = dtToday
str_Parm.as_TransactionType = "QC"

OpenUserObjectWithParm ( u_audit_trail, str_Parm, 55, 150 )
u_audit_trail.BringToTop = TRUE

end event

type dw_1 from datawindow within w_quality_control
boolean visible = false
integer x = 3730
integer y = 1312
integer width = 2926
integer height = 1152
boolean livescroll = true
end type

type cb_41 from commandbutton within w_quality_control
integer x = 1317
integer y = 1728
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "_"
end type

on clicked;wf_key_pressed ( "_" )
end on

type cb_43 from commandbutton within w_quality_control
integer x = 293
integer y = 1728
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "."
end type

on clicked;wf_key_pressed ( "." )
end on

type cb_40 from commandbutton within w_quality_control
integer x = 549
integer y = 1728
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

on clicked;wf_key_pressed ( "-" )
end on

type cb_39 from commandbutton within w_quality_control
integer x = 37
integer y = 1728
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "0"
end type

on clicked;wf_key_pressed ( "0" )
end on

type cb_38 from commandbutton within w_quality_control
integer x = 2450
integer y = 160
integer width = 475
integer height = 160
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exit"
end type

event clicked;IF is_Transaction > '' THEN
	IF MessageBox ( "Exit", "Are you sure you want to exit?", Question!, YesNo!, 2 ) = 1 THEN
		Halt
	END IF
ELSE
	Close ( Parent )
END IF

end event

on getfocus;//bExit = True
end on

type cb_37 from commandbutton within w_quality_control
integer x = 1883
integer y = 1728
integer width = 311
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Clear"
end type

event clicked;If bMessage Then wf_hide_message ( )

Choose Case ClassName ( igo_last )
	Case "sle_serial"
		sle_serial.Text = ""
		sle_serial.Setfocus ( )
	Case "sle_operator"
		sle_operator.Text = ""
		sle_operator.SetFocus ( )
	Case "mle_qc_notes"
		mle_qc_notes.Text = ""
		mle_qc_notes.SetFocus ( )
End Choose

end event

type cb_36 from commandbutton within w_quality_control
integer x = 549
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "9"
end type

on clicked;wf_key_pressed ( "9" )
end on

type cb_35 from commandbutton within w_quality_control
integer x = 293
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "8"
end type

on clicked;wf_key_pressed ( "8" )
end on

type cb_34 from commandbutton within w_quality_control
integer x = 37
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "7"
end type

on clicked;wf_key_pressed ( "7" )
end on

type cb_33 from commandbutton within w_quality_control
integer x = 549
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "6"
end type

on clicked;wf_key_pressed ( "6" )
end on

type cb_32 from commandbutton within w_quality_control
integer x = 805
integer y = 1728
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Y"
end type

on clicked;wf_key_pressed ( "Y" )
end on

type cb_31 from commandbutton within w_quality_control
integer x = 1061
integer y = 1728
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Z"
end type

on clicked;wf_key_pressed ( "Z" )
end on

type cb_30 from commandbutton within w_quality_control
integer x = 2505
integer y = 1728
integer width = 347
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Enter"
end type

event clicked;If bMessage Then wf_hide_message ( )

ib_forward = TRUE

igo_last.Event Dynamic ue_validate ( )

//Choose Case TypeOf ( igo_last )
//	Case singlelineedit!
//		sle_last = igo_last
//		sle_last.Setfocus ( )
//	Case multilineedit!
//		mle_last = igo_last
//		mle_last.Setfocus ( )
//End Choose

//if bOperator Then
//	sle_operator.TriggerEvent ( "ue_validate" )
//Elseif bSerialNumber Then
//	sle_serial.TriggerEvent ( "ue_validate" )
//Elseif bQCNotes Then
//	mle_qc_notes.TriggerEvent ( "ue_validate" )
//End if


end event

type cb_29 from commandbutton within w_quality_control
integer x = 37
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "1"
end type

on clicked;wf_key_pressed ( "1" )
end on

type cb_28 from commandbutton within w_quality_control
integer x = 293
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "2"
end type

on clicked;wf_key_pressed ( "2" )
end on

type cb_27 from commandbutton within w_quality_control
integer x = 549
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "3"
end type

on clicked;wf_key_pressed ( "3" )
end on

type cb_26 from commandbutton within w_quality_control
integer x = 37
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "4"
end type

on clicked;wf_key_pressed ( "4" )
end on

type cb_25 from commandbutton within w_quality_control
integer x = 293
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "5"
end type

on clicked;wf_key_pressed ( "5" )
end on

type cb_24 from commandbutton within w_quality_control
integer x = 805
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Q"
end type

on clicked;wf_key_pressed ( "Q" )
end on

type cb_23 from commandbutton within w_quality_control
integer x = 1061
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "R"
end type

on clicked;wf_key_pressed ( "R" )
end on

type cb_22 from commandbutton within w_quality_control
integer x = 1317
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "S"
end type

on clicked;wf_key_pressed ( "S" )
end on

type cb_21 from commandbutton within w_quality_control
integer x = 1573
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "T"
end type

on clicked;wf_key_pressed ( "T" )
end on

type cb_20 from commandbutton within w_quality_control
integer x = 1829
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "U"
end type

on clicked;wf_key_pressed ( "U" )
end on

type cb_19 from commandbutton within w_quality_control
integer x = 2085
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "V"
end type

on clicked;wf_key_pressed ( "V" )
end on

type cb_18 from commandbutton within w_quality_control
integer x = 2341
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "W"
end type

on clicked;wf_key_pressed ( "W" )
end on

type cb_17 from commandbutton within w_quality_control
integer x = 2597
integer y = 1536
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "X"
end type

on clicked;wf_key_pressed ( "X" )
end on

type cb_16 from commandbutton within w_quality_control
integer x = 805
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "I"
end type

on clicked;wf_key_pressed ( "I" )
end on

type cb_15 from commandbutton within w_quality_control
integer x = 1061
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "J"
end type

on clicked;wf_key_pressed ( "J" )
end on

type cb_14 from commandbutton within w_quality_control
integer x = 1317
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "K"
end type

on clicked;wf_key_pressed ( "K" )
end on

type cb_13 from commandbutton within w_quality_control
integer x = 1573
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "L"
end type

on clicked;wf_key_pressed ( "L" )
end on

type cb_12 from commandbutton within w_quality_control
integer x = 1829
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "M"
end type

on clicked;wf_key_pressed ( "M" )
end on

type cb_11 from commandbutton within w_quality_control
integer x = 2085
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "N"
end type

on clicked;wf_key_pressed ( "N" )
end on

type cb_10 from commandbutton within w_quality_control
integer x = 2341
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "O"
end type

on clicked;wf_key_pressed ( "O" )
end on

type cb_9 from commandbutton within w_quality_control
integer x = 2597
integer y = 1344
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "P"
end type

on clicked;wf_key_pressed ( "P" )
end on

type cb_8 from commandbutton within w_quality_control
integer x = 2597
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "H"
end type

on clicked;wf_key_pressed ( "H" )
end on

type cb_7 from commandbutton within w_quality_control
integer x = 2341
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "G"
end type

on clicked;wf_key_pressed ( "G" )
end on

type cb_6 from commandbutton within w_quality_control
integer x = 2085
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "F"
end type

on clicked;wf_key_pressed ( "F" )
end on

type cb_5 from commandbutton within w_quality_control
integer x = 1829
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E"
end type

on clicked;wf_key_pressed ( "E" )
end on

type cb_4 from commandbutton within w_quality_control
integer x = 1573
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "D"
end type

on clicked;wf_key_pressed ( "D" )
end on

type cb_3 from commandbutton within w_quality_control
integer x = 1317
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "C"
end type

on clicked;wf_key_pressed ( "C" )
end on

type cb_2 from commandbutton within w_quality_control
integer x = 1061
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "B"
end type

on clicked;wf_key_pressed ( "B" )
end on

type cb_1 from commandbutton within w_quality_control
integer x = 805
integer y = 1152
integer width = 256
integer height = 192
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A"
end type

on clicked;wf_key_pressed ( "A" )
end on

type sle_title from statictext within w_quality_control
integer width = 2926
integer height = 160
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
boolean underline = true
long textcolor = 33554432
long backcolor = 77897888
boolean enabled = false
string text = "Quality Control"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_serial_number from groupbox within w_quality_control
integer x = 37
integer y = 880
integer width = 805
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
string text = "Serial Number"
end type

type mle_qc_notes from multilineedit within w_quality_control
event ue_key pbm_keyup
event ue_validate ( )
integer x = 73
integer y = 512
integer width = 731
integer height = 320
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autovscroll = true
integer limit = 50
borderstyle borderstyle = stylelowered!
end type

event ue_key;if KeyDown ( keyShift! ) Then 
	if key = keyTab! or key = keyEnter! then
		ib_forward = FALSE
		TriggerEvent ( "ue_validate" )
	end if
else
	if key = keyTab! or key = keyEnter! then
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if
end event

event ue_validate;IF ib_forward THEN
	If bMandatoryQCNotes and f_get_string_value ( Text ) = "" And cStatus <> 'A' Then
		SetFocus ( )
		Return
	Else
		bqcnotes=false
//		sle_serial.Setfocus ( )
		dw_misc.setfocus()
	End if
ELSE
	bqcnotes=false	
//	sle_operator.SetFocus ( )
	dw_misc.setfocus()	
END IF
end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )

If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_Last = This
bqcnotes=true
wf_change_color_focus ( )

end event

type dw_misc from datawindow within w_quality_control
event type long ue_set_focus ( )
event ue_key pbm_dwnkey
event ue_validate ( )
integer x = 987
integer y = 272
integer width = 1353
integer height = 832
string dataobject = "d_status_list"
boolean vscrollbar = true
boolean border = false
end type

event ue_set_focus;Choose Case ClassName ( igo_last )
	Case "sle_operator"
		sle_operator.SetFocus ( )
	Case "mle_qc_notes"
		mle_qc_notes.SetFocus ( )
	Case "sle_serial"
		sle_serial.Setfocus ( )
end choose

return 1
end event

event ue_key;if KeyDown ( keyShift! ) Then 
	if key = keyTab! or key = keyEnter! then
		ib_forward = FALSE
		TriggerEvent ( "ue_validate" )
	end if
else
	if key = keyTab! or key = keyEnter! then
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if
end event

event ue_validate;IF ib_forward THEN
	If 	bdifferentstatus then //and f_get_string_value ( dw_misc.object.display_name[getclickedrow()] ) = ""  Then
		SetFocus ( )
		Return
	Else
		bdifferentstatus = false
		sle_serial.Setfocus ( )
	End if
ELSE
	bdifferentstatus = false	
	sle_operator.SetFocus ( )
END IF
end event

event getfocus;If bMessage Then wf_hide_message ( )

end event

event clicked;IF row < 1 then return

SelectRow ( 0, FALSE )
SelectRow ( row, TRUE )

cStatus = GetItemString ( row, "type" )
is_UserStatus = GetItemString ( row, "display_name" )

////If f_get_string_value ( sle_operator.Text ) = "" Then
////	wf_reset_indicators ( )
////	igo_last = sle_operator
////	Post Event ue_set_focus ( )
////ElseIf cStatus <> 'A' And f_get_string_value ( mle_qc_notes.Text ) = "" Then
////	wf_reset_indicators ( )
////	igo_last = mle_qc_notes
////	Post Event ue_set_focus ( )
////Else
//	wf_reset_indicators ( )
//	Post Event ue_set_focus ( )
////End if
//
end event

type gb_qc_notes from groupbox within w_quality_control
integer x = 37
integer y = 448
integer width = 805
integer height = 416
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
string text = "Notes:"
end type

type gb_dwbox from groupbox within w_quality_control
integer x = 951
integer y = 192
integer width = 1426
integer height = 928
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
string text = "Choose Object~'s New Status"
end type

type gb_operator from groupbox within w_quality_control
integer x = 37
integer y = 192
integer width = 805
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 77897888
string text = "Operator - "
end type


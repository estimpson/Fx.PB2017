$PBExportHeader$w_break_out.srw
forward
global type w_break_out from Window
end type
type rb_2 from radiobutton within w_break_out
end type
type rb_1 from radiobutton within w_break_out
end type
type sle_location from singlelineedit within w_break_out
end type
type sle_unit from singlelineedit within w_break_out
end type
type sle_packaging from singlelineedit within w_break_out
end type
type lb_list from u_it_list_box within w_break_out
end type
type dw_limit_locs from datawindow within w_break_out
end type
type dw_transactions from datawindow within w_break_out
end type
type lb_1 from listbox within w_break_out
end type
type sle_status from statictext within w_break_out
end type
type st_1 from statictext within w_break_out
end type
type cb_57 from commandbutton within w_break_out
end type
type lb_unit_list from listbox within w_break_out
end type
type dw_unit_list from datawindow within w_break_out
end type
type cb_55 from commandbutton within w_break_out
end type
type sle_numberof from singlelineedit within w_break_out
end type
type sle_qty from singlelineedit within w_break_out
end type
type cb_48 from commandbutton within w_break_out
end type
type dw_object from datawindow within w_break_out
end type
type sle_operator from singlelineedit within w_break_out
end type
type sle_serial from singlelineedit within w_break_out
end type
type cb_47 from commandbutton within w_break_out
end type
type cb_46 from commandbutton within w_break_out
end type
type cb_44 from commandbutton within w_break_out
end type
type cb_42 from commandbutton within w_break_out
end type
type dw_1 from datawindow within w_break_out
end type
type cb_41 from commandbutton within w_break_out
end type
type cb_43 from commandbutton within w_break_out
end type
type cb_40 from commandbutton within w_break_out
end type
type cb_39 from commandbutton within w_break_out
end type
type cb_38 from commandbutton within w_break_out
end type
type cb_37 from commandbutton within w_break_out
end type
type cb_36 from commandbutton within w_break_out
end type
type cb_35 from commandbutton within w_break_out
end type
type cb_34 from commandbutton within w_break_out
end type
type cb_33 from commandbutton within w_break_out
end type
type cb_32 from commandbutton within w_break_out
end type
type cb_31 from commandbutton within w_break_out
end type
type cb_30 from commandbutton within w_break_out
end type
type cb_29 from commandbutton within w_break_out
end type
type cb_28 from commandbutton within w_break_out
end type
type cb_27 from commandbutton within w_break_out
end type
type cb_26 from commandbutton within w_break_out
end type
type cb_25 from commandbutton within w_break_out
end type
type cb_24 from commandbutton within w_break_out
end type
type cb_23 from commandbutton within w_break_out
end type
type cb_22 from commandbutton within w_break_out
end type
type cb_21 from commandbutton within w_break_out
end type
type cb_20 from commandbutton within w_break_out
end type
type cb_19 from commandbutton within w_break_out
end type
type cb_18 from commandbutton within w_break_out
end type
type cb_17 from commandbutton within w_break_out
end type
type cb_16 from commandbutton within w_break_out
end type
type cb_15 from commandbutton within w_break_out
end type
type cb_14 from commandbutton within w_break_out
end type
type cb_13 from commandbutton within w_break_out
end type
type cb_12 from commandbutton within w_break_out
end type
type cb_11 from commandbutton within w_break_out
end type
type cb_10 from commandbutton within w_break_out
end type
type cb_9 from commandbutton within w_break_out
end type
type cb_8 from commandbutton within w_break_out
end type
type cb_7 from commandbutton within w_break_out
end type
type cb_6 from commandbutton within w_break_out
end type
type cb_5 from commandbutton within w_break_out
end type
type cb_4 from commandbutton within w_break_out
end type
type cb_3 from commandbutton within w_break_out
end type
type cb_2 from commandbutton within w_break_out
end type
type cb_1 from commandbutton within w_break_out
end type
type dw_misc from datawindow within w_break_out
end type
type sle_title from statictext within w_break_out
end type
type gb_location from groupbox within w_break_out
end type
type gb_qty from groupbox within w_break_out
end type
type gb_serial_number from groupbox within w_break_out
end type
type gb_unit from groupbox within w_break_out
end type
type gb_operator from groupbox within w_break_out
end type
type gb_numberof from groupbox within w_break_out
end type
type gb_dwbox from groupbox within w_break_out
end type
type gb_packaging from groupbox within w_break_out
end type
end forward

global type w_break_out from Window
int X=0
int Y=0
int Width=3045
int Height=2220
boolean TitleBar=true
string Title="Break Out"
long BackColor=77897888
boolean ControlMenu=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
string Icon="mit.ico"
event ue_close_audit_trail pbm_custom04
event ue_close_uo_note pbm_custom05
event ue_save_note pbm_custom06
event ue_return_value ( string a_s_return_value )
rb_2 rb_2
rb_1 rb_1
sle_location sle_location
sle_unit sle_unit
sle_packaging sle_packaging
lb_list lb_list
dw_limit_locs dw_limit_locs
dw_transactions dw_transactions
lb_1 lb_1
sle_status sle_status
st_1 st_1
cb_57 cb_57
lb_unit_list lb_unit_list
dw_unit_list dw_unit_list
cb_55 cb_55
sle_numberof sle_numberof
sle_qty sle_qty
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
dw_misc dw_misc
sle_title sle_title
gb_location gb_location
gb_qty gb_qty
gb_serial_number gb_serial_number
gb_unit gb_unit
gb_operator gb_operator
gb_numberof gb_numberof
gb_dwbox gb_dwbox
gb_packaging gb_packaging
end type
global w_break_out w_break_out

type variables
GraphicObject		igo_last
st_generic_structure 	stParm
Int			iHandle
boolean			ib_forward,&
			ib_back
Boolean			bAuditTrail
Boolean			bUserNotes
Boolean			bUserOperator
Boolean 			bWriteParent
Boolean 			bZeroParent
Boolean 			bNoCheck
Boolean 			bChars, bNumbers
Boolean 			bLoseFocus
Boolean 			bDelete
Boolean 			bEnabled
Boolean 			bLabelNeeded
Boolean 			bExit
Boolean 			bMessageBox
Boolean 			bMandatoryLot
Boolean 			bRequired
Boolean 			bClicked
Boolean 			bModified
Boolean 			bBreakoutMore
Boolean 			bDifferentPart
Boolean 			bStagedObject
Boolean 			bDifferentStatus
Boolean 			bStatusSame
Boolean 			bExternalMessage
Boolean 			bOpen
Boolean 			bNoClickCheck
Boolean 			bMessage
Boolean 			bSetToThis
Boolean 			bTab
Boolean 			bAction
Boolean			bBONumberOfMode
Boolean			bBOUnitMode 
Boolean			bDeleteScrap
Boolean			bSetBack
Boolean			bLabel, &
			ib_Auto, &
			ib_Password, &
			ib_Notes
string			is_field
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
boolean			bPopulateLocations
long			il_PalletSerial
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
public subroutine wf_set_focus ()
public subroutine wf_get_unit_list (string szpartnumber, string szoriginalunit)
public subroutine wf_loop_for_avail_units (string szunit, int iorder)
public subroutine wf_reset_colors ()
public subroutine wf_change_color_focus ()
public function string wf_get_character ()
public subroutine wf_show_message ()
public subroutine wf_hide_message ()
public function boolean wf_delete_audit_trail (long ll_serial)
public function boolean wf_create_object (long ll_serial, datetime ldt_date, string ls_operator)
public function boolean wf_update_onhand (long ll_serial, string ls_mode)
public function boolean wf_breakout ()
public function boolean wf_delete_object (long ll_serial)
public function boolean wf_add_to_object (long ll_serial, decimal ld_qty, decimal ld_stdqty, decimal ld_objectqty, decimal ld_objectstdqty, string ls_operator)
public subroutine wf_disable_except_buttons ()
public subroutine wf_enable_except_buttons ()
public function string wf_location_of_super_object (long al_serial)
end prototypes

event ue_close_audit_trail;bAuditTrail = FALSE
CloseUserObject ( u_audit_trail )
wf_enable_screen ( )
wf_set_focus ( )
end event

on ue_close_uo_note;This.CloseUserObject ( u_generic_it_note )
wf_enable_except_buttons ( )
wf_set_focus ( )
ib_Notes = FALSE
end on

on ue_save_note;is_Notes = u_generic_it_note.mle_note.Text
This.CloseUserObject ( u_generic_it_note )
wf_enable_except_buttons ( )
wf_set_focus ( )
ib_Notes = FALSE
end on

event ue_return_value;lb_list.Hide ( )
ib_Forward = TRUE
Choose Case is_field
	Case "unit"
		sle_unit.Text = a_s_return_value
		sle_unit.TriggerEvent ( "ue_validate" )
	Case "packaging"
		sle_packaging.Text = a_s_return_value
		sle_packaging.TriggerEvent ( "ue_validate" )
	Case "location"
		sle_location.Text = a_s_return_value
		sle_location.TriggerEvent ( "ue_validate" )
End Choose
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
If is_field = "serial" Then cb_43.Enabled = False
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

public subroutine wf_key_pressed (string ccharacter);String szSerial
String szPreviousText

wf_hide_message ( )

/*  Initialize Variables  */

IF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = u_audit_trail.sle_operator_password.Text + cCharacter
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = u_generic_it_note.mle_note.Text + cCharacter
ELSEIF bAuditTrail THEN
	u_audit_trail.em_serial.Text = u_audit_trail.em_serial.Text + cCharacter
ELSE
	Choose Case is_field
		Case "operator"
			sle_operator.Text = sle_operator.Text + cCharacter
			sle_operator.SetFocus ( )
		Case "serial"
			sle_serial.Text = sle_serial.Text + cCharacter
			sle_serial.SetFocus ( )
		Case "packaging"
			sle_packaging.Text = sle_packaging.Text + cCharacter
			sle_packaging.SetFocus ( )
			lb_list.uf_find_item ( sle_packaging.Text )
//		Case "unit"
//			sle_unit.Text = sle_unit.Text + cCharacter
//			sle_unit.SetFocus ( )
		Case "qty"
			sle_qty.Text = sle_qty.Text + cCharacter
			sle_qty.SetFocus ( )
		Case "numberof"
			sle_numberof.Text = sle_numberof.Text + cCharacter
			sle_numberof.SetFocus ( )
	End Choose
END IF
end subroutine

public subroutine wf_setup_screen ();/*  Declare Variables  */

dw_misc.SetTransObject ( sqlca )

String 	szNull
String	cBONumberOfMode
String	cBOUnitMode
String	cDeleteScrap

SetNull ( szNull )

SELECT inventory_parameters.bo_number_of,   
       inventory_parameters.bo_unit  
  INTO :cBONumberOfMode,   
       :cBOUnitMode  
  FROM inventory_parameters  ;

If cBONumberOfMode = 'R' Then bBONumberOfMode = True
If cBOUnitMode = 'R' Then bBOUnitMode = True

/*  Main  */

//wf_set_dw_position ( dw_misc,1244,257,481,1026,"d_object_info_bo",False,False )

if isvalid ( stparm ) then
	if stParm.value2 > '' then
		sle_serial.Text = stParm.Value2
		sle_serial.TriggerEvent ( Modified! )
	end if
end if

sle_operator.SetFocus ( )
end subroutine

public subroutine wf_reset_indicators ();wf_reset_colors ( )
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
cb_46.Enabled = True
cb_47.Enabled = True
cb_48.Enabled = True
cb_43.Enabled = True
cb_30.Enabled = True
cb_37.Enabled = True
cb_38.Enabled = True
cb_55.Enabled = True
cb_57.Enabled = True

//  Common Stuff
sle_operator.Enabled = True
dw_misc.Enabled = True
sle_serial.Enabled = True
sle_qty.Enabled = True
sle_unit.Enabled = True
sle_packaging.Enabled = True
sle_numberof.Enabled = True

end subroutine

public subroutine wf_disable_screen ();cb_1.Enabled = False
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
cb_46.Enabled = False
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
sle_qty.Enabled = False
sle_unit.Enabled = False
sle_packaging.Enabled = False
sle_numberof.Enabled = False

end subroutine

public subroutine wf_set_focus ();Choose Case is_field

	Case "packaging"
		sle_packaging.SetFocus ( )

	Case "unit"
		sle_unit.SetFocus ( )

	Case "operator"
		sle_operator.SetFocus ( )

	Case "qty"
		sle_qty.SetFocus ( )

	Case "numberof"
		sle_numberof.SetFocus ( )

	Case "serial"
		sle_serial.SetFocus ( )

End Choose


end subroutine

public subroutine wf_get_unit_list (string szpartnumber, string szoriginalunit);//  Declare Variables

Int iPos
Int iLoop

String szTempUnit


//  Initialize Variables

dw_unit_list.DataObject = "d_unit_conversion_list_per_part"
dw_unit_list.SetTransObject ( sqlca )
lb_unit_list.Reset ( )

If IsNull ( szOriginalUnit ) Or szOriginalUnit = "" Then

  SELECT part_inventory.standard_unit  
    INTO :szOriginalUnit  
    FROM part_inventory  
   WHERE part_inventory.part = :szPartNumber   ;

End if

dw_unit_list.Retrieve ( szPartNumber )

If dw_unit_list.RowCount ( ) < 1 Then Goto THE_END

//  Loop through forward and look for chain

wf_loop_for_avail_units ( szOriginalUnit, 1 )


//  Loop through backwards and look for chain

wf_loop_for_avail_units ( szOriginalUnit, 2 )

THE_END:

If lb_unit_list.FindItem ( szOriginalUnit, 1 ) < 1 Then &
	lb_unit_list.AddItem ( szOriginalUnit )

sle_unit.Text = szOriginalUnit

end subroutine

public subroutine wf_loop_for_avail_units (string szunit, int iorder);//  Declare Variables

String     szCurrentUnit

Long       lCount
Long       lItem


//  Initialize Variables

If iOrder = 1 Then
	dw_unit_list.SetFilter ( "unit1 = ~"" + szUnit + "~"" )
	dw_unit_list.SetSort ( "unit2 A" )
Else
	dw_unit_list.SetFilter ( "unit2 = ~"" + szUnit + "~"" )
	dw_unit_list.SetSort ( "unit1 A" )
End if

dw_unit_list.Filter ( )
dw_unit_list.Sort ( )
 
//  Loop through the possible units and check each one

For lCount = 1 to dw_unit_list.RowCount ( )

	If iOrder = 1 Then
		szCurrentUnit = dw_unit_list.GetItemString ( lCount, "unit2" )
	Else
		szCurrentUnit = dw_unit_list.GetItemString ( lCount, "unit1" )
	End if

	If lb_unit_list.FindItem ( szCurrentUnit, 1 ) < 1 Then
		lb_unit_list.AddItem ( szCurrentUnit )
		wf_loop_for_avail_units ( szCurrentUnit, iOrder )
	End if

	If iOrder = 1 Then
		dw_unit_list.SetFilter ( "unit1 = ~"" + szUnit + "~"" )
		dw_unit_list.SetSort ( "unit2 A" )
	Else
		dw_unit_list.SetFilter ( "unit2 = ~"" + szUnit + "~"" )
		dw_unit_list.SetSort ( "unit1 A" )
	End if
	
	dw_unit_list.Filter ( )
	dw_unit_list.Sort ( )
 
Next


end subroutine

public subroutine wf_reset_colors ();//gb_packaging.TextColor = f_get_color_value ( "darkred" )
//gb_operator.TextColor = f_get_color_value ( "darkred" )
//gb_numberof.TextColor = f_get_color_value ( "darkred" )
//gb_qty.TextColor = f_get_color_value ( "darkred" )
//gb_unit.TextColor = f_get_color_value ( "darkred" )
//gb_serial_number.TextColor = f_get_color_value ( "darkred" )
//
gb_packaging.TextColor = f_get_color_value ( "black" )
gb_operator.TextColor = f_get_color_value ( "black" )
gb_numberof.TextColor = f_get_color_value ( "black" )
gb_qty.TextColor = f_get_color_value ( "black" )
gb_unit.TextColor = f_get_color_value ( "black" )
gb_serial_number.TextColor = f_get_color_value ( "black" )

end subroutine

public subroutine wf_change_color_focus ();wf_reset_colors ( )
Choose Case is_field
	Case "packaging"
		gb_packaging.TextColor = f_get_color_value ( "black" )
	Case "operator"
		gb_operator.TextColor = f_get_color_value ( "black" )
	Case "numberof"
		gb_numberof.TextColor = f_get_color_value ( "black" )
	Case "qty"
		gb_qty.TextColor = f_get_color_value ( "black" )
	Case "unit"
		gb_unit.TextColor = f_get_color_value ( "black" )
	Case "serial"
		gb_serial_number.TextColor = f_get_color_value ( "black" )
End Choose

//Choose Case is_field
//	Case "packaging"
//		gb_packaging.TextColor = f_get_color_value ( "blue" )
//	Case "operator"
//		gb_operator.TextColor = f_get_color_value ( "blue" )
//	Case "numberof"
//		gb_numberof.TextColor = f_get_color_value ( "blue" )
//	Case "qty"
//		gb_qty.TextColor = f_get_color_value ( "blue" )
//	Case "unit"
//		gb_unit.TextColor = f_get_color_value ( "blue" )
//	Case "serial"
//		gb_serial_number.TextColor = f_get_color_value ( "blue" )
//End Choose
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

public subroutine wf_show_message ();bMessage = True
Timer ( .25, This )
end subroutine

public subroutine wf_hide_message ();sle_status.Hide ( )
Timer ( 0 )
bMessage = False
end subroutine

public function boolean wf_delete_audit_trail (long ll_serial);DELETE FROM audit_trail
 WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	Return False
Else
	Return True
End if


end function

public function boolean wf_create_object (long ll_serial, datetime ldt_date, string ls_operator);// Declare Variables

String	ls_type
String	ls_part
String	ls_remarks
String	ls_salesman
String	ls_customer
String	ls_vendor
String	ls_po
String	ls_from
String	ls_to
String	ls_lot
String	ls_status
String	ls_flag
String	ls_activity
String	ls_unit
String	ls_workorder
String	ls_controlnumber
String	ls_custom1
String	ls_custom2
String	ls_custom3
String	ls_custom4
String	ls_custom5
String	ls_plant
String	ls_notes
String	ls_glaccount
String	ls_package_type
Long		ll_invoicenumber
Dec		ld_cost
Dec		ld_onhand
Dec		ld_weight
Dec		ld_quantity
Dec		ld_price
Dec		ld_std_qty
Dec		ld_tare_weight
Dec		ldec_std_cost
Date		ld_today
Time		lt_now
DateTime	dDateStamp

//  Grab audit trail record

SELECT type,   
       part,   
       quantity,   
       remarks,   
       price,   
       salesman,   
       customer,   
       vendor,   
       po_number,   
       operator,   
       from_loc,   
       to_loc,   
       on_hand,   
       lot,   
       weight,   
       status,   
       flag,   
       activity,   
       unit,   
       workorder,   
       std_quantity,   
       cost,   
       control_number,   
       custom1,   
       custom2,   
       custom3,   
       custom4,   
       custom5,   
       plant,   
       invoice_number,   
       notes,   
       gl_account,
		 package_type,
		 std_cost
  INTO :ls_type,   
       :ls_part,   
       :ld_quantity,   
       :ls_remarks,   
       :ld_price,   
       :ls_salesman,   
       :ls_customer,   
       :ls_vendor,   
       :ls_po,   
       :ls_operator,   
       :ls_from,   
       :ls_to,   
       :ld_onhand,   
       :ls_lot,   
       :ld_weight,   
       :ls_status,   
       :ls_flag,   
       :ls_activity,   
       :ls_unit,   
       :ls_workorder,   
       :ld_quantity,   
       :ld_cost,   
       :ls_controlnumber,   
       :ls_custom1,   
       :ls_custom2,   
       :ls_custom3,   
       :ls_custom4,   
       :ls_custom5,   
       :ls_plant,   
       :ll_invoicenumber,   
       :ls_notes,   
       :ls_glaccount,
		 :ls_package_type,
		 :ldec_std_cost  
  FROM audit_trail  
 WHERE ( audit_trail.serial = :ll_Serial ) AND  
       ( audit_trail.date_stamp = :ldt_Date ) AND
		 ( audit_trail.type = 'M' ) ;


//  Error checking

If SQLCA.SQLCode <> 0 Then

	MessageBox ( "Error", "Unable to open audit trail history!", StopSign! )
	Return	False

Else

	//  Prime needed values

	ld_today = Today ( )
	lt_now	= Now ( )
	dDateStamp = DateTime(Today(),Now())

	SELECT package_materials.weight  
	  INTO :ld_tare_weight  
	  FROM package_materials  
	 WHERE package_materials.code = :ls_package_type   ;

	ld_tare_weight = f_get_value ( ld_tare_weight )

	ld_std_qty = f_convert_units ( ls_unit, "", ls_part, ld_quantity )

	//  Add object

	INSERT INTO object  
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
	            show_on_shipper,   
 	            tare_weight,
					std_cost )  
	   VALUES ( :ll_serial,   
	            :ls_part,   
	            :ls_to,   
	            :dDateStamp,   
	            :ls_unit,   
	            :ls_operator,   
	            :ls_status,   
	            null,   
	            null,   
	            null,   
	            :ld_cost,   
	            :ld_weight,   
	            null,   
 	            :ls_notes,   
 	            :ld_quantity,   
	            :dDateStamp,   
	            null,   
	            :ls_customer,   
	            null,   
	            null,   
	            :ls_lot,   
	            null,   
	            :ls_po,   
	            null,   
	            :ls_plant,   
	            null,   
	            :ld_std_qty,   
	            :ls_package_type,   
 	            null,   
	            null,   
	            :ls_custom1,   
	            :ls_custom2,   
	            :ls_custom3,   
	            :ls_custom4,   
	            :ls_custom5,   
	            null,   
	            :ld_tare_weight,
					:ldec_std_cost )  ;
	 	
	If SQLCA.SQLCode <> 0 Then
		
		MessageBox ( "Error", "Unable to create object:~r" + SQLCA.SQLErrText, StopSign! )
		Return	False

	End if

End if

Return True
end function

public function boolean wf_update_onhand (long ll_serial, string ls_mode);String	ls_Part
Dec		ld_Std_qty

  SELECT object.part,   
         object.std_quantity
    INTO :ls_Part,   
         :ld_Std_qty  
    FROM object  
   WHERE object.serial = :ll_Serial   ;

f_update_onhand ( ls_Part, ld_Std_qty, ls_mode + "*" )

Return True
end function

public function boolean wf_breakout ();SetPointer ( HourGlass! )

//	Declarations
Boolean bProgress
Boolean bNoChange

Date	dLastDate
DateTime dtRightNow, &
         dtdatedue

Dec	dObjectQty
Dec	dStdQuantity
Dec	dConvObjectQty
Dec	dLowestQty
Dec	dCost
Dec	dNewQty
Dec	dStdObjectQty
Dec	dNewStdQty
Dec	dTareWeight
Dec	dstdcost
Dec	ld_originalqty

Int	iCount
Int	iCounter
Int	iLoop

Long	lSerialCheck
Long	lParentSerial
Long	lSuffix
Long	l_l_serial[]
Long	ll_serial

String	szObjectUnit
String	szStandardUnit
String	szVendor
String	szShipper
String	szPlant
String	szNewPackage
String	szNotes
string	ls_custom1,&
	ls_custom2,&
	ls_custom3,&
	ls_custom4,&
	ls_custom5,&
	ls_userdefinedstatus,&
	ls_field1,&
	ls_field2,&
	ls_workorder,&
	ls_ecn, &
	ls_name, &
	ls_origin, &
	ls_temp, & 
	ls_data, &
	ls_label

str_progress	stProgress
st_generic_structure	str_Parm

Time	tLastTime

int	irtncode

dec	ld_unitweight, ld_weight

//  Check required fields
If szOperator = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
	bOpen = True
	sle_operator.SetFocus ( )
	Return False
End if

If sle_serial.Text = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "Invalid serial number!", StopSign! )
	sle_serial.SetFocus ( )
	Return False
End if


If Dec ( sle_numberof.Text ) < 1 Then
	f_beep ( 5 )
	MessageBox ( "Error", "Number of objects must be greater than 0!", StopSign! )
	sle_numberof.Text = ""
	szField = "numberof"
	wf_set_focus ( )
	Return False
End if

If Dec ( sle_qty.Text ) <= 0 Then
	f_beep ( 5 )
	MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
	sle_qty.Text = ""
	szField = "qty"
	wf_set_focus ( )
	Return False
End if

If sle_unit.Text = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid unit of measure is required to continue!", StopSign! )
	sle_unit.SetFocus ( )
	Return False
End if


if rb_1.checked = true then 
	ls_Temp = sle_location.Text
	ls_data = ''
	If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
		SELECT	code  
		INTO	:ls_data
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :ls_Temp ) AND  
			( trans_code = 'T' );
	Else
		SELECT	code
		INTO	:ls_data
		FROM	location  
		WHERE	( code = :ls_Temp );
	End if
	If SQLCA.SQLCode <> 0 Then
		f_beep ( 2 )
		iRtnCode = MessageBox ( "Error", "Invalid location! Would you like to use drop down list?", Question!, YesNo!, 1 )
		sle_location.Text = ""
		If iRtnCode = 1 Then
			bPopulateLocations = True
		End if
		sle_location.SetFocus ( )
		Return false
	End if
elseif rb_2.checked = true then 
	lserialcheck= long(sle_location.Text)
	
	select	part
	into	:ls_data
	from	object
	where	(serial = :lserialcheck and type ='S');

	If SQLCA.SQLCode <> 0 Then
		f_beep ( 2 )
		iRtnCode = MessageBox ( "Error", "Invalid Super Object! Would you like to use drop down list?", Question!, YesNo!, 1 )
		sle_location.Text = ""
		If iRtnCode = 1 Then
			bPopulateLocations = True
		End if
		sle_location.SetFocus ( )
		Return false
	End if
end if 	
		
//  Convert to object's quantity
SetPointer ( HourGlass! )

szPart = dw_misc.GetItemString ( 1, "part" )

dConvObjectQty = f_get_value ( &
	f_convert_units ( sle_unit.Text, dw_misc.GetItemString ( 1, "unit" ), szPart, Dec ( sle_qty.Text ) ) )


SetPointer ( HourGlass! )

//  Convert to standard unit
dLowestQty = f_get_value ( &
	f_convert_units ( sle_unit.Text, "", szPart, Dec ( sle_qty.Text ) ) )

SetPointer ( HourGlass! )

//  Check to see if they are trying to break out more than the object
If ( dConvObjectQty * f_get_value ( Dec ( sle_numberof.Text ) ) ) > f_get_value ( dw_misc.GetItemNumber ( 1, "quantity" ) ) Then
	f_beep ( 5 )
	MessageBox ( "Error", "You cannot breakout more than the original objects quantity!", StopSign! )
	sle_numberof.Text = ""
	sle_qty.Text = ""
	szField = "numberof"
	wf_set_focus ( )
	Return False
End if

lParentSerial = f_get_value ( Long ( f_serial_validate(sle_serial.Text) ) )
dQuantity = f_get_value ( Dec ( sle_qty.Text ) )
szNotes = is_Notes

//  Prime and show progress window
stProgress.Title = 'Break Out Objects'

bProgress = True

OpenWithParm ( w_progress, stProgress )

iCount = 0
iCounter = 0

if mod( ( dec(sle_numberof.text) * dquantity ),  dw_misc.GetItemNumber ( 1, "quantity" ) ) = 0 then 
	if Messagebox ( 'Information', 'Object/Serial ' + string(lParentSerial) +' will be deleted as the quantity will be 0 after break out', Information!, OkCancel!, 2 ) = 2 then 	
		Close ( w_progress )
		Goto THE_END
	end if 	
end if 	

//  Create new objects and update original object
dw_object.SetTransObject ( sqlca )

iCount++

For lLoop = 1 to Dec ( sle_numberof.Text )

	//  Get Time Stamp
	tLastTime = Now ( )
	dLastDate = Today ( )
	dtRightNow = DateTime(Today(),Now())
	Yield ( )

	//  Grab next serial number and update parameter file
	dw_object.SetTransObject ( sqlca )

	iCounter++
	w_progress.wf_progress ( iCounter / ( Dec ( sle_numberof.Text ) * 4 ), "Updating Parm File..." )

	dw_object.Retrieve ( lParentSerial )

	szPart = f_get_string_value ( dw_object.GetItemString ( 1, "part" ) )
	szLot  = f_get_string_value ( dw_object.GetItemString ( 1, "lot" ) )
	szStatus = f_get_string_value ( dw_object.GetItemString ( 1, "status" ) )
	szPoNumber	= f_get_string_value ( dw_object.GetItemString ( 1, "po_number" ) )
	if sle_location.text > '' then
		if rb_1.checked = true then
			szLocation	= sle_location.text
			setnull(il_PalletSerial)
		else
			il_PalletSerial = Long ( sle_location.text ) 						
			szLocation	= wf_location_of_super_object(il_palletserial) //f_get_string_value ( dw_object.GetItemString ( 1, "location" ) )

		end if 	
	else
		szLocation	= f_get_string_value ( dw_object.GetItemString ( 1, "location" ) )		
	end if 
	dWeight		= f_get_value ( dw_object.GetItemNumber ( 1, "weight" ) )
	dCost		= f_get_value ( dw_object.GetItemNumber ( 1, "cost" ) )
	dStdObjectQty	= f_get_value ( dw_object.GetItemNumber ( 1, "std_quantity" ) )
	szPlant		= f_get_string_value ( dw_object.GetItemString ( 1, "plant" ) )	
	dStdQuantity	= f_convert_units ( sle_unit.Text, "", szPart, dQuantity )
	szNewPackage	= f_get_string_value ( sle_packaging.Text )
	lSuffix		= dw_object.GetItemNumber ( 1, "suffix" )
	ls_custom1	= isnull ( dw_object.GetItemString ( 1, "custom1" ),'' )
	ls_custom2	= isnull ( dw_object.GetItemString ( 1, "custom2" ),'' )
	ls_custom3	= isnull ( dw_object.GetItemString ( 1, "custom3" ),'' )
	ls_custom4	= isnull ( dw_object.GetItemString ( 1, "custom4" ),'' )
	ls_custom5	= isnull ( dw_object.GetItemString ( 1, "custom5" ),'' )
	ls_userdefinedstatus = isnull ( dw_object.GetItemString ( 1, "user_defined_status" ), '' )
	ls_name   	= isnull ( dw_object.GetItemString ( 1, "name" ),'' )	
	ls_field1	= isnull ( dw_object.GetItemString ( 1, "field1" ),'' )
	ls_field2	= isnull ( dw_object.GetItemString ( 1, "field2" ),'' )
	ls_workorder	= isnull ( dw_object.GetItemString ( 1, "workorder" ),'' )
	ls_ecn  	= isnull ( dw_object.GetItemString ( 1, "engineering_level" ),'' )
	sznotes 	= isnull ( dw_object.GetItemString ( 1, "note" ),'' )
	dstdCost	= f_get_value ( dw_object.GetItemNumber ( 1, "std_cost" ) )
	ls_origin	= isnull ( dw_object.GetItemString ( 1, "origin" ),'' )
	dtdatedue	= dw_object.Getitemdatetime(1,"date_due")
	
	SELECT	package_materials.weight 
	INTO	:dTareWeight  
	FROM	package_materials  
	WHERE	package_materials.code = :szNewPackage   ;

	if SQLCA.of_getnextparmvalue ( 'next_serial', ll_serial) then 

		l_l_serial[UpperBound ( l_l_serial ) + 1] = ll_serial
		iCounter++
		w_progress.wf_progress ( iCounter / ( Dec ( sle_numberof.Text ) * 4 ), "Breaking Out Object # " + String ( l_l_serial[lLoop] ) )
	
		//  Create object record
		szObjectUnit = f_get_string_value ( sle_unit.Text )
	
		INSERT INTO object  
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
			suffix,
			dimension_qty_string,
			varying_dimension_code,
			user_defined_status,
			custom1,
			custom2,
			custom3,
			custom4,
			custom5,
			std_cost,
			workorder,
			field1,
			field2,
			engineering_level)  
		VALUES ( :l_l_serial[lLoop],   
			:szPart,   
			:szLocation,   
			:dtRightNow,   
			:szObjectUnit,   
			:szOperator,   
			:szStatus,   
			null,   
			null,   
			:ls_origin,   
			:dCost,   
			:il_PalletSerial,   
			:szNotes,   
			:dQuantity,   
			:dtrightnow,   
			:dtdatedue,   
			null,   
			null,   
			null,   
			:szLot,   
			null,   
			:szPoNumber,   
			:ls_name,   
			:szPlant,   
			null,
			:dStdQuantity,
			:szNewPackage,
			:lSuffix,
			:szdimensionqtystring,
			:llnonconstantdim,
			:ls_userdefinedstatus,
			:ls_custom1,
			:ls_custom2,
			:ls_custom3,
			:ls_custom4,
			:ls_custom5,
			:dstdcost,
			:ls_workorder,
			:ls_field1,
			:ls_field2,
			:ls_ecn)  ;
	
		If SQLCA.SQLCode = -1 Then
			RollBack ;
			f_beep ( 5 )
		Else
			iCounter++
			w_progress.wf_progress ( iCounter / ( Dec ( sle_numberof.Text ) * 4 ), "Creating Audit Trail..." )
		
			SELECT	audit_trail.vendor,   
				audit_trail.shipper  
			INTO	:szVendor,   
				:szShipper  
			FROM	audit_trail  
			WHERE	( audit_trail.serial = :lParentSerial ) AND  
				( audit_trail.type = 'R' )   ;
	
			If SQLCA.SQLCode <> 0 Then
				szVendor = ""
				szShipper = ""
			End if
	
			If Not f_create_audit_trail ( l_l_serial[lLoop], "B", String ( lParentSerial ), szVendor, szShipper, "", "", "", "", "", "", "No Commit" ) Then
				RollBack ;
				f_beep ( 5 )
			Else
				//  Calculate object's new quantity
				dObjectQty = f_convert_units ( sle_unit.Text, dw_misc.GetItemString ( 1, "unit" ), szPart, dQuantity ) 
				dNewQty = dw_misc.GetItemNumber ( 1, "quantity" ) - dObjectQty
	
				//  If new quantity is greater than 0, update object
				iCounter++
				w_progress.wf_progress ( iCounter / ( Dec ( sle_numberof.Text ) * 4 ), "Updating Object # " + String ( lParentSerial ) )
	
				dNewStdQty = dStdObjectQty - dStdQuantity
	
				select	unit_weight
				into	:ld_unitweight
				from	part_inventory
				where	part = :szpart;
				
				ld_weight = dnewstdqty * ld_unitweight
				
				UPDATE object  
				SET	quantity     = :dNewQty,
					std_quantity = :dNewStdQty,
					last_date    = :dtRightNow,
					last_time    = :dtRightNow,
					operator     = :szOperator,
					weight	     = :ld_weight,
					dimension_qty_string = :szparentdimqtystr,
					dim_qty_string_other = :szdimensionqtystring,
					varying_dimension_code  = :llnonconstantdim
				WHERE	serial = :lParentSerial   ;
	
				If SQLCA.SQLCode = -1 Then
					RollBack ;
					f_beep ( 5 )
				Else
					commit ;
					dw_misc.SetItem ( 1, "quantity", dNewQty )
					str_Parm.Value1 = String ( l_l_serial[lLoop] )
					f_print_label ( str_Parm )
				End if
			End if
		End if
	else
		rollback;
	end if 	
	
	If bCancel = True Then
		iCount = Dec ( sle_numberof.Text ) + 1
		bCancel = False
	End if
Next

//  Label printing for original serial, if it's quantity is greater than 0
If dNewQty > 0 Then 
	If Not f_create_audit_trail ( lParentSerial, "B", "", szVendor, szShipper, "Original", "", "", "", "", "", "No Commit" ) Then
		RollBack ;
		f_beep ( 5 )
		Close ( w_progress )
		Goto THE_END
	Else
		Commit ;
		str_Parm.Value1 = String ( lParentSerial )
		f_print_label ( str_Parm )
	End if

Else
	If Not f_create_audit_trail ( lParentSerial, "B", "", szVendor, szShipper, "Original", "", "", "", "", "", "No Commit" ) Then
		RollBack ;
		f_beep ( 5 )
		Close ( w_progress )
		Goto THE_END
	Else
		DELETE
		FROM	object
		WHERE	serial = :lParentSerial   ;
		If SQLCA.SQLCode <> 0 Then
			RollBack ;
			f_beep ( 5 )
			Close ( w_progress )
			Goto THE_END
		Else
			Commit ;
		End if
	End if
End if

Close ( w_progress )

f_beep ( 1 )
wf_show_message ( )

THE_END:

bProgress = False

If Not bNoChange Then 
	sle_numberof.Text = ''
	sle_qty.Text = ''
End if

wf_enable_screen ( )

Return True
end function

public function boolean wf_delete_object (long ll_serial);DELETE FROM object  
 WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	Return False
End if

Return True
end function

public function boolean wf_add_to_object (long ll_serial, decimal ld_qty, decimal ld_stdqty, decimal ld_objectqty, decimal ld_objectstdqty, string ls_operator);ld_ObjectQty = ld_ObjectQty + ld_Qty
ld_ObjectStdQty = ld_ObjectStdQty + ld_StdQty

UPDATE object  
   SET quantity 		= :ld_ObjectQty,   
       std_quantity 	= :ld_ObjectStdQty,
		 operator		= :ls_Operator
 WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	Return False
End if
 

Return True
end function

public subroutine wf_disable_except_buttons ();cb_42.Enabled = False
cb_44.Enabled = False
cb_46.Enabled = False
cb_47.Enabled = False
cb_48.Enabled = False
cb_38.Enabled = False
sle_operator.Enabled = False
dw_misc.Enabled = False
sle_serial.Enabled = False
sle_qty.Enabled = False
sle_unit.Enabled = False
sle_packaging.Enabled = False
sle_numberof.Enabled = False

end subroutine

public subroutine wf_enable_except_buttons ();cb_42.Enabled = TRUE
cb_44.Enabled = TRUE
cb_46.Enabled = TRUE
cb_47.Enabled = TRUE
cb_48.Enabled = TRUE
cb_38.Enabled = TRUE
sle_operator.Enabled = TRUE
dw_misc.Enabled = TRUE
sle_serial.Enabled = TRUE
sle_qty.Enabled = TRUE
sle_unit.Enabled = TRUE
sle_packaging.Enabled = TRUE
sle_numberof.Enabled = TRUE

end subroutine

public function string wf_location_of_super_object (long al_serial);String ls_location

select	location
into	:ls_location
from	object
where	serial = :al_Serial;

Return ls_location

end function

event open;/*  Initialize Variables  */

bChars = True
bNumbers = True

stParm        = Message.PowerObjectParm

if isvalid ( stParm ) then
	lSerialParm   = Long ( stParm.Value2 )
	If stParm.Value2 = "0" Then stParm.Value2 = ""
	szWorkOrder   = stParm.Value5
end if

dtToday = DateTime ( Today ( ), Now ( ) )

/*  Determine type of transaction and prime the dataobject of dw_1  */

dw_unit_list.SetTransObject ( sqlca )

dw_limit_locs.SetTransObject ( sqlca )
dw_limit_locs.Retrieve ( 'B' )

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

on w_break_out.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.sle_location=create sle_location
this.sle_unit=create sle_unit
this.sle_packaging=create sle_packaging
this.lb_list=create lb_list
this.dw_limit_locs=create dw_limit_locs
this.dw_transactions=create dw_transactions
this.lb_1=create lb_1
this.sle_status=create sle_status
this.st_1=create st_1
this.cb_57=create cb_57
this.lb_unit_list=create lb_unit_list
this.dw_unit_list=create dw_unit_list
this.cb_55=create cb_55
this.sle_numberof=create sle_numberof
this.sle_qty=create sle_qty
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
this.dw_misc=create dw_misc
this.sle_title=create sle_title
this.gb_location=create gb_location
this.gb_qty=create gb_qty
this.gb_serial_number=create gb_serial_number
this.gb_unit=create gb_unit
this.gb_operator=create gb_operator
this.gb_numberof=create gb_numberof
this.gb_dwbox=create gb_dwbox
this.gb_packaging=create gb_packaging
this.Control[]={this.rb_2,&
this.rb_1,&
this.sle_location,&
this.sle_unit,&
this.sle_packaging,&
this.lb_list,&
this.dw_limit_locs,&
this.dw_transactions,&
this.lb_1,&
this.sle_status,&
this.st_1,&
this.cb_57,&
this.lb_unit_list,&
this.dw_unit_list,&
this.cb_55,&
this.sle_numberof,&
this.sle_qty,&
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
this.dw_misc,&
this.sle_title,&
this.gb_location,&
this.gb_qty,&
this.gb_serial_number,&
this.gb_unit,&
this.gb_operator,&
this.gb_numberof,&
this.gb_dwbox,&
this.gb_packaging}
end on

on w_break_out.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.sle_location)
destroy(this.sle_unit)
destroy(this.sle_packaging)
destroy(this.lb_list)
destroy(this.dw_limit_locs)
destroy(this.dw_transactions)
destroy(this.lb_1)
destroy(this.sle_status)
destroy(this.st_1)
destroy(this.cb_57)
destroy(this.lb_unit_list)
destroy(this.dw_unit_list)
destroy(this.cb_55)
destroy(this.sle_numberof)
destroy(this.sle_qty)
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
destroy(this.dw_misc)
destroy(this.sle_title)
destroy(this.gb_location)
destroy(this.gb_qty)
destroy(this.gb_serial_number)
destroy(this.gb_unit)
destroy(this.gb_operator)
destroy(this.gb_numberof)
destroy(this.gb_dwbox)
destroy(this.gb_packaging)
end on

type rb_2 from radiobutton within w_break_out
int X=1975
int Y=576
int Width=462
int Height=76
string Text="Super Object"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer ( HourGlass! )

rb_1.Checked = False

bPopulateLocations = True
cb_47.enabled = TRUE

sle_location.SetFocus ( )
end event

type rb_1 from radiobutton within w_break_out
int X=1605
int Y=576
int Width=329
int Height=76
string Text="Location"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean RightToLeft=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer ( HourGlass! )

rb_2.Checked = False
cb_47.enabled = FALSE

sle_location.SetFocus ( )		

end event

type sle_location from singlelineedit within w_break_out
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=1646
int Y=720
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;Boolean lb_CheckLocation
String 	ls_Temp
String	ls_LotMode
String	ls_LimitLocs

Int iRtnCode

If ib_forward Then
	ib_forward = FALSE
	If rb_2.Checked Then
		If LeftA ( Text, 1 ) = 'S' Then
			Text = RightA ( Text, LenA ( Text ) - 1 )
		Elseif Not IsNumber ( LeftA ( Text, 1 ) ) Then
			f_beep ( 5 )
			Text = ""
			MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
			SetFocus ( )
			Return			
		End if
	Else
		ls_Temp = Text
		If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
			SELECT	code  
			INTO	:ls_Temp  
			FROM	location,   
				location_limits  
			WHERE	( code = location_code ) and  
				( location_code = :ls_Temp ) AND  
				( trans_code = 'T' ) ;
		Else
			SELECT	code  
			INTO	:ls_Temp  
			FROM	location  
			WHERE	( code = :ls_Temp ) ;
		End if
		If SQLCA.SQLCode <> 0 Then
			f_beep ( 5 )
	
			If Not bPopulateLocations Then
				iRtnCode = MessageBox ( "Error", "Invalid location! Would you like to use drop down list?", Question!, YesNo!, 1 )
				If iRtnCode = 1 Then
					bPopulateLocations = True
					if rb_1.Checked then
						if lb_list.uf_setup ( "location", "code", x, y, height, 1850, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then
							lb_list.Show ( )
						end if
					else
						if lb_list.uf_setup ( "object", "serial", x, y, height, 1850, TextSize, width, 'type', 'S', lb_unit_list, dw_limit_locs ) > 0 then
							lb_list.Show ( )
						end if
					end if
				End if
			Else
				MessageBox ( "Error", "Invalid location!  Please select a valid one from list.", StopSign! )
			End if
			Text = ""
			SetFocus ( )
			Return
		End if
	End if 
	cb_48.SetFocus ( )
Elseif ib_back then
	ib_back = FALSE
	sle_unit.SetFocus ( )
End if
end event

event ue_key;boolean	l_b_shift

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

event getfocus;IF bMessage THEN wf_hide_message ( )
IF bChars THEN Disable_chars ( )
IF Not bNumbers THEN Enable_Numbers ( )
igo_Last = GetFocus ( )
is_Field = "location"
wf_change_color_focus ( )
lb_list.Hide ( )
If bPopulateLocations Then 
	if rb_1.Checked then
		if lb_list.uf_setup ( "location", "code", x, y, height, 1850, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then
			lb_list.Show ( )
		end if
	else
		if lb_list.uf_setup ( "object", "serial", x, y, height, 1850, TextSize, width, 'type', 'S', lb_unit_list, dw_limit_locs ) > 0 then
			lb_list.Show ( )
		end if
	end if
End if

end event

type sle_unit from singlelineedit within w_break_out
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=914
int Y=960
int Width=366
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;If ib_forward Then
	ib_forward = FALSE
	sle_location.SetFocus ( )
Elseif ib_back then
	ib_back = FALSE
	sle_qty.SetFocus ( )
End if

end event

event ue_key;boolean	l_b_shift

if KeyDown ( keyShift! ) Then l_b_shift = TRUE
if key = keyTab! or key = keyEnter! then
	if l_b_shift then
		ib_back = TRUE
		TriggerEvent ( "ue_validate" )
	else
		Text = lb_list.uf_get_current_item ( Text )
		lb_list.Hide ( )
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
else
	lb_list.uf_find_item ( Text )
end if

end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If bChars Then disable_chars ( )
If bNumbers Then disable_numbers ( )
igo_last = GetFocus ( )
is_Field = "unit"
wf_change_color_focus ( )
lb_list.Hide ( )
if lb_list.uf_setup ( "", "", x, y, height, 1825, TextSize, width, "", "", lb_unit_list, dw_limit_locs ) > 0 then &
	lb_list.Show ( )

end event

type sle_packaging from singlelineedit within w_break_out
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=73
int Y=720
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;String	cLotMode,&
			l_s_packaging
Dec 		dStdPack 
Int		iIndex

If ib_forward Then

	ib_forward = FALSE
	
	If Text <> "" Then
	
		l_s_packaging = Text
		
		SELECT part_packaging.quantity  
		  INTO :dStdPack  
		  FROM part_packaging  
		 WHERE ( part_packaging.part = :szPart ) AND  
		       ( part_packaging.code = :l_s_packaging )   ;
		
		If SQLCA.SQLCode <> 0 Then
		
			f_beep ( 5 )

			MessageBox ( "Error", "Invalid package type!", StopSign! )
			Text = ""
			SetFocus ( )
			Return
	
		Else
	
			If dw_object.GetItemNumber ( 1, "quantity" ) > dStdPack Then
				If f_get_string_value ( sle_qty.Text ) = "" Then &
					sle_qty.Text = String ( dStdPack )
			Else
				sle_qty.Text = String ( dw_object.GetItemNumber ( 1, "quantity" ) )
			End if
	
		End if
	
		sle_numberof.SetFocus ( )

	Else

		SELECT object.package_type  
		  INTO :Text  
		  FROM object  
		 WHERE object.serial = :lSerial   ;

		sle_numberof.SetFocus ( )

	End if

Elseif ib_back then
	
	ib_back = FALSE
	sle_serial.SetFocus ( )

End if
end event

event ue_key;boolean	l_b_shift
if KeyDown ( keyShift! ) Then l_b_shift = TRUE
if key = keyTab! or key = keyEnter! then
	if l_b_shift then
		ib_back = TRUE
		TriggerEvent ( "ue_validate" )
	else
		Text = lb_list.uf_get_current_item ( Text )
		lb_list.Hide ( )
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
else
	lb_list.uf_find_item ( Text )
end if


end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_last = GetFocus ( )
is_Field = "packaging"
wf_change_color_focus ( )
lb_list.Hide ( )
if lb_list.uf_setup ( "part_packaging", "code", x, y, height, 1150, TextSize, width, "part", szPart, lb_unit_list, dw_limit_locs ) > 0 then &
	lb_list.Show ( )

end event

type lb_list from u_it_list_box within w_break_out
int X=1664
int Y=624
int TabOrder=10
boolean Visible=false
end type

type dw_limit_locs from datawindow within w_break_out
int X=1920
int Y=1952
int Width=219
int Height=176
boolean Visible=false
string DataObject="d_limit_locs"
boolean LiveScroll=true
end type

type dw_transactions from datawindow within w_break_out
int X=37
int Y=1952
int Width=384
int Height=192
boolean Visible=false
string DataObject="d_audit_trail_by_date"
boolean LiveScroll=true
end type

type lb_1 from listbox within w_break_out
int X=439
int Y=1952
int Width=311
int Height=192
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_status from statictext within w_break_out
int X=905
int Y=12
int Width=690
int Height=112
boolean Visible=false
boolean Enabled=false
string Text="Successful"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=65280
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
boolean Italic=true
boolean Underline=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_break_out
int X=1751
int Y=12
int Width=1166
int Height=144
boolean Enabled=false
string Text="[Enter Button] / [Tab Key]-Next Field            [Back Button] / [<Shift>Tab]-Previous Field "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_57 from commandbutton within w_break_out
int X=2194
int Y=1728
int Width=311
int Height=192
string Text="Back"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If bMessage Then wf_hide_message ( )

IF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = LeftA ( u_audit_trail.sle_operator_password.Text, LenA ( u_audit_trail.sle_operator_password.Text ) - 1 )
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = LeftA ( u_generic_it_note.mle_note.Text, LenA ( u_generic_it_note.mle_note.Text ) - 1 )
ELSE

	ib_back = TRUE
	
	Choose Case is_field
		Case "packaging"
			sle_packaging.TriggerEvent ( "ue_validate" )
		Case "operator"
			sle_operator.TriggerEvent ( "ue_validate" )
		Case "numberof"
			sle_numberof.TriggerEvent ( "ue_validate" )
		Case "qty"
			sle_qty.TriggerEvent ( "ue_validate" )
		Case "unit"
			sle_unit.TriggerEvent ( "ue_validate" )
		Case "serial"
			sle_serial.TriggerEvent ( "ue_validate" )
		Case "cb48"
			cb_48.TriggerEvent ( "ue_validate" )
	End Choose
	
END IF	
end event

type lb_unit_list from listbox within w_break_out
int X=1701
int Y=1952
int Width=201
int Height=160
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_unit_list from datawindow within w_break_out
int X=1061
int Y=1952
int Width=311
int Height=192
boolean Visible=false
string DataObject="d_unit_conversion_list_per_part"
boolean LiveScroll=true
end type

type cb_55 from commandbutton within w_break_out
int X=1573
int Y=1728
int Width=311
int Height=192
string Text="Space"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( " " )
end on

type sle_numberof from singlelineedit within w_break_out
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=73
int Y=960
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;String	cQtyMode
String	cUnitMode

If ib_forward Then

	ib_forward = FALSE
	
	If Dec ( Text ) < 1 Then

		f_beep ( 5 )
		MessageBox ( "Error", "Number of objects must be greater than 0!", StopSign! )
		SetFocus ( )
		Return

	End if

	sle_qty.SetFocus ( )

Elseif ib_back then
	
	ib_back = FALSE
	sle_packaging.SetFocus ( )

End if

end event

event ue_key;boolean	l_b_shift

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

event getfocus;If bMessage Then wf_hide_message ( )

If bChars Then Disable_chars ( )
If Not bNumbers Then Enable_numbers ( )
lb_list.Hide ( )
igo_Last = GetFocus ( )
is_Field = "numberof"
wf_change_color_focus ( )

end event

type sle_qty from singlelineedit within w_break_out
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=914
int Y=720
int Width=635
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;String	cAllowZeroQty
String   ls_ddarequired='N'	 

If ib_forward Then
	ib_forward = FALSE
	If Dec ( Text ) <= 0 Then
		// below lines inc by gph on 7/17/97 for dda		
		SELECT dda_required
		  INTO :ls_ddarequired
		  FROM parameters ;

		if ls_ddarequired = 'Y' THEN  		
			st_prmlst.s_arg_part   = dw_misc.getitemstring(dw_misc.getrow(),'part')
			st_prmlst.s_arg_module = dw_misc.getitemstring(dw_misc.getrow(),'unit')
			st_prmlst.s_rtn_qtystr = szdimensionqtystring
			st_prmlst.s_rtn_qty    = Dec(sle_qty.text) 
			st_prmlst.s_parent_unit= sle_unit.text
			st_prmlst.s_parent_qty = szparentqty
			st_prmlst.s_parent_dimqtystr=szparentdimqtystr
			Openwithparm(w_dda_mit_sf,st_prmlst)
			st_prmlst 				= Message.PowerObjectparm
			szdimensionqtystring = st_prmlst.s_rtn_qtystr
	      sle_qty.text         = String(st_prmlst.s_rtn_qty)
			szparentqty  			= st_prmlst.s_parent_qty
			szparentdimqtystr 	= st_prmlst.s_parent_dimqtystr
			llnonconstantdim     = st_prmlst.s_nonconstantdim
		end if 		
//		
		If Dec ( Text ) <= 0 Then 
	 		f_beep ( 5 )
	      MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
		   SetFocus ( )
		Else
			If bBOUnitMode Then
				sle_unit.SetFocus ( )			
			Else
				cb_48.SetFocus ( )
			End if
		End if 	
		
	Else
		If bBOUnitMode Then
		sle_unit.SetFocus ( )			
		Else
			cb_48.SetFocus ( )
		End if
	End if

Elseif ib_back then
	ib_back = FALSE
	If bBONumberOfMode Then
		sle_numberof.SetFocus ( )
	Else
		sle_serial.SetFocus ( )
	End if
End if
end event

event ue_key;boolean	l_b_shift

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

event getfocus;IF bMessage THEN wf_hide_message ( )

IF bChars THEN Disable_chars ( )
IF Not bNumbers THEN Enable_Numbers ( )
lb_list.Hide ( )
igo_Last = GetFocus ( )
is_Field = "qty"
wf_change_color_focus ( )


end event

type cb_48 from commandbutton within w_break_out
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=2450
int Y=480
int Width=475
int Height=160
string Text="BreakOut"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;if ib_forward then
	ib_forward = FALSE
	TriggerEvent ( clicked! )
elseif ib_back then
	ib_back = FALSE
	sle_location.SetFocus ( )
end if
end event

event ue_key;boolean	l_b_shift

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

event clicked;SetPointer ( HourGlass! )

bAction = True

wf_disable_screen ( )

wf_reset_indicators ( )
If wf_breakout ( ) Then
	szField = "serial"
	is_Field = "serial"	
	sle_serial.Text = ""
	sle_qty.Text = ""
	sle_numberof.Text = ""
	sle_location.text = ""
	wf_set_focus ( )
	dw_misc.Reset ( )
End if

wf_enable_screen ( )

bAction = False

is_Notes = ""
end event

event getfocus;lb_list.Hide ( )
wf_reset_indicators ( )
is_field = "cb48"
end event

type dw_object from datawindow within w_break_out
int X=768
int Y=1952
int Width=274
int Height=192
boolean Visible=false
string DataObject="d_object_data"
boolean LiveScroll=true
end type

type sle_operator from singlelineedit within w_break_out
event ue_validate pbm_custom02
event ue_key pbm_keyup
int X=73
int Y=240
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;String	cNumberOfMode
String	cQtyMode
String	cUnitMode

szOperator = ""

If ib_forward Then

	ib_forward = FALSE
	
	SELECT employee.operator_code  
	  INTO :szOperator  
	  FROM employee  
	 WHERE employee.password = :sle_operator.Text   ;
	
	szOperator = f_get_string_value ( szOperator )
	
	If SQLCA.SQLCode = 0 Then
	
		gb_operator.Text = "Operator - " + szOperator

		sle_serial.SetFocus ( )

	Else

		f_beep ( 5 )
		gb_operator.Text = "Operator -"
		MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
		Text = ""
		SetFocus ( )
		Return
	
	End if

Elseif ib_back then

	ib_back = FALSE
	
	SetFocus ( )
	
End if

end event

event ue_key;boolean	l_b_shift

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

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
lb_list.Hide ( )
igo_Last = GetFocus ( )
is_Field = "operator"
wf_change_color_focus ( )

end event

type sle_serial from singlelineedit within w_break_out
event ue_validate pbm_custom02
event ue_key pbm_keyup
int X=73
int Y=480
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;/*  Declare Variables  */

String szOriginalUnit
String cTempStatus
String cNewStatus
String szTempPackaging
String ls_CurrentUserDefinedStatus
String ls_DefectCode
String ls_Part
String ls_Machine
String ls_location
	
Long lTemp
Long lTempShipper
	
Date dToday
	
Time tNow
		
Int iRtnCode
Int iLoop


/*  Initialize Variables  */

dToday = Today ( )
tNow   = Now ( )


/*  Main  */

If ib_forward Then
	ib_forward = FALSE
//	If Left ( Text, 1 ) = 'S' Then
//		Text = Right ( Text, Len ( Text ) - 1 )
//	Elseif Not IsNumber ( Left ( Text, 1 ) ) Then
//		f_beep ( 5 )
//		Text = ""
//		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
//		SetFocus ( )
//		Return
//	End if
		
	lSerial = f_get_value ( Long ( f_serial_validate(Text) ) )
	
	If lSerial < 1 Then 
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
		SetFocus ( )
		Return
	End if
	
	SELECT object.serial,
			 object.shipper,
			 object.status,
			 object.quantity,
			 object.dimension_qty_string,
			 object.package_type,
			 object.location
	  INTO :lTemp,
			 :lTempShipper,
			 :cTempStatus,
			 :szparentqty,
			 :szparentdimqtystr,
			 :sztemppackaging,
			 :ls_location
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
		
	bLoseFocus = True
	
	dw_misc.SetTransObject ( sqlca )
	dw_misc.Retrieve ( lSerial )
	
	szPart = dw_misc.GetItemString ( 1, "part" )
	szOriginalUnit = dw_misc.GetItemString ( 1, "unit" )

	wf_get_unit_list ( szPart, szOriginalUnit )
	
	sle_unit.Text = szOriginalUnit
	sle_packaging.Text = szTempPackaging
	sle_location.text = ls_location
	
	dw_object.SetTransObject ( sqlca )
	dw_object.Retrieve ( lSerial )
	
	sle_packaging.SetFocus ( )

Elseif ib_back then

	ib_back = FALSE
	sle_operator.SetFocus ( )

End if
end event

event ue_key;boolean	l_b_shift

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

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )

If bChars Then disable_chars ( )
If Not bNumbers Then Enable_numbers ( )
lb_list.Hide ( )
igo_Last = GetFocus ( )
is_Field = "serial"
wf_change_color_focus ( )

end event

type cb_47 from commandbutton within w_break_out
int X=2450
int Y=800
int Width=475
int Height=160
boolean Enabled=false
string Text="New Pallet"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;INT	li_error

OpenWithParm ( w_pallet, szoperator )
il_PalletSerial = Message.DoubleParm
if il_PalletSerial < 0 then
	li_error = -1
else
	li_error = il_PalletSerial
end if

IF li_error = -1 THEN
	MessageBox ( "Error", "Unable to create a new pallet!", StopSign! )
ELSEIF li_error > 0 THEN
	sle_location.Text = String ( il_palletserial )
END IF

end event

type cb_46 from commandbutton within w_break_out
int X=2450
int Y=960
int Width=475
int Height=160
string Text="Notes"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ib_Notes = TRUE
wf_disable_except_buttons ( )
Parent.OpenUserObjectWithParm ( u_generic_it_note, is_Notes, 550, 200 )
u_generic_it_note.BringToTop = TRUE
IF is_Notes <> "" THEN u_generic_it_note.mle_note.Text = is_Notes
end event

type cb_44 from commandbutton within w_break_out
int X=2450
int Y=640
int Width=475
int Height=160
boolean Enabled=false
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_42 from commandbutton within w_break_out
int X=2450
int Y=320
int Width=475
int Height=160
string Text="Audit Trail"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;str_audit_trail	str_Parm

If bMessage Then wf_hide_message ( )

SetPointer ( HourGlass! )

bAuditTrail = True

wf_disable_screen ( )

str_Parm.adt_Today = dtToday
str_Parm.as_TransactionType = "BO"

OpenUserObjectWithParm ( u_audit_trail, str_Parm, 55, 150 )
u_audit_trail.BringToTop = TRUE

end event

type dw_1 from datawindow within w_break_out
int X=1390
int Y=1952
int Width=293
int Height=224
boolean Visible=false
boolean LiveScroll=true
end type

type cb_41 from commandbutton within w_break_out
int X=1317
int Y=1728
int Width=256
int Height=192
string Text="_"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "_" )
end on

type cb_43 from commandbutton within w_break_out
int X=293
int Y=1728
int Width=256
int Height=192
string Text="."
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "." )
end on

type cb_40 from commandbutton within w_break_out
int X=549
int Y=1728
int Width=256
int Height=192
string Text="-"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "-" )
end on

type cb_39 from commandbutton within w_break_out
int X=37
int Y=1728
int Width=256
int Height=192
string Text="0"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "0" )
end on

type cb_38 from commandbutton within w_break_out
int X=2450
int Y=160
int Width=475
int Height=160
string Text="Exit"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type cb_37 from commandbutton within w_break_out
int X=1883
int Y=1728
int Width=311
int Height=192
string Text="Clear"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If bMessage Then wf_hide_message ( )

IF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = ""
	u_audit_trail.sle_operator_code.Text = ""
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = ""
ELSE

	Choose Case is_field
		Case "serial"
			sle_serial.Text = ""
			sle_serial.Setfocus ( )
		Case "qty"
			sle_qty.Text = ""
			sle_qty.SetFocus ( )
		Case "numberof"
			sle_numberof.Text = ""
			sle_numberof.SetFocus ( )
		Case "operator"
			sle_operator.Text = ""
			sle_operator.SetFocus ( )
		Case "serial"
			sle_serial.Text = ""
			sle_serial.SetFocus ( )
		Case "packaging"
			sle_packaging.Text = ""
			sle_packaging.SetFocus ( )
	End Choose
END IF
end event

type cb_36 from commandbutton within w_break_out
int X=549
int Y=1152
int Width=256
int Height=192
string Text="9"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "9" )
end on

type cb_35 from commandbutton within w_break_out
int X=293
int Y=1152
int Width=256
int Height=192
string Text="8"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "8" )
end on

type cb_34 from commandbutton within w_break_out
int X=37
int Y=1152
int Width=256
int Height=192
string Text="7"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "7" )
end on

type cb_33 from commandbutton within w_break_out
int X=549
int Y=1344
int Width=256
int Height=192
string Text="6"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "6" )
end on

type cb_32 from commandbutton within w_break_out
int X=805
int Y=1728
int Width=256
int Height=192
string Text="Y"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "Y" )
end on

type cb_31 from commandbutton within w_break_out
int X=1061
int Y=1728
int Width=256
int Height=192
string Text="Z"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "Z" )
end on

type cb_30 from commandbutton within w_break_out
int X=2505
int Y=1728
int Width=347
int Height=192
string Text="Enter"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If bMessage Then wf_hide_message ( )

ib_forward = TRUE

Choose Case is_field
	Case "packaging"
		sle_packaging.TriggerEvent ( "ue_validate" )
	Case "operator"
		sle_operator.TriggerEvent ( "ue_validate" )
	Case "numberof"
		sle_numberof.TriggerEvent ( "ue_validate" )
	Case "qty"
		sle_qty.TriggerEvent ( "ue_validate" )
	Case "unit"
		sle_unit.TriggerEvent ( "ue_validate" )
	Case "serial"
		sle_serial.TriggerEvent ( "ue_validate" )
	Case "cb48"
		cb_48.Enabled = False
		cb_48.TriggerEvent ( "clicked" )
		cb_48.Enabled = True
End Choose


end event

type cb_29 from commandbutton within w_break_out
int X=37
int Y=1536
int Width=256
int Height=192
string Text="1"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "1" )
end on

type cb_28 from commandbutton within w_break_out
int X=293
int Y=1536
int Width=256
int Height=192
string Text="2"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "2" )
end on

type cb_27 from commandbutton within w_break_out
int X=549
int Y=1536
int Width=256
int Height=192
string Text="3"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "3" )
end on

type cb_26 from commandbutton within w_break_out
int X=37
int Y=1344
int Width=256
int Height=192
string Text="4"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "4" )
end on

type cb_25 from commandbutton within w_break_out
int X=293
int Y=1344
int Width=256
int Height=192
string Text="5"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "5" )
end on

type cb_24 from commandbutton within w_break_out
int X=805
int Y=1536
int Width=256
int Height=192
string Text="Q"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "Q" )
end on

type cb_23 from commandbutton within w_break_out
int X=1061
int Y=1536
int Width=256
int Height=192
string Text="R"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "R" )
end on

type cb_22 from commandbutton within w_break_out
int X=1317
int Y=1536
int Width=256
int Height=192
string Text="S"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "S" )
end on

type cb_21 from commandbutton within w_break_out
int X=1573
int Y=1536
int Width=256
int Height=192
string Text="T"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "T" )
end on

type cb_20 from commandbutton within w_break_out
int X=1829
int Y=1536
int Width=256
int Height=192
string Text="U"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "U" )
end on

type cb_19 from commandbutton within w_break_out
int X=2085
int Y=1536
int Width=256
int Height=192
string Text="V"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "V" )
end on

type cb_18 from commandbutton within w_break_out
int X=2341
int Y=1536
int Width=256
int Height=192
string Text="W"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "W" )
end on

type cb_17 from commandbutton within w_break_out
int X=2597
int Y=1536
int Width=256
int Height=192
string Text="X"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "X" )
end on

type cb_16 from commandbutton within w_break_out
int X=805
int Y=1344
int Width=256
int Height=192
string Text="I"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "I" )
end on

type cb_15 from commandbutton within w_break_out
int X=1061
int Y=1344
int Width=256
int Height=192
string Text="J"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "J" )
end on

type cb_14 from commandbutton within w_break_out
int X=1317
int Y=1344
int Width=256
int Height=192
string Text="K"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "K" )
end on

type cb_13 from commandbutton within w_break_out
int X=1573
int Y=1344
int Width=256
int Height=192
string Text="L"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "L" )
end on

type cb_12 from commandbutton within w_break_out
int X=1829
int Y=1344
int Width=256
int Height=192
string Text="M"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "M" )
end on

type cb_11 from commandbutton within w_break_out
int X=2085
int Y=1344
int Width=256
int Height=192
string Text="N"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "N" )
end on

type cb_10 from commandbutton within w_break_out
int X=2341
int Y=1344
int Width=256
int Height=192
string Text="O"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "O" )
end on

type cb_9 from commandbutton within w_break_out
int X=2597
int Y=1344
int Width=256
int Height=192
string Text="P"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "P" )
end on

type cb_8 from commandbutton within w_break_out
int X=2597
int Y=1152
int Width=256
int Height=192
string Text="H"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "H" )
end on

type cb_7 from commandbutton within w_break_out
int X=2341
int Y=1152
int Width=256
int Height=192
string Text="G"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "G" )
end on

type cb_6 from commandbutton within w_break_out
int X=2085
int Y=1152
int Width=256
int Height=192
string Text="F"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "F" )
end on

type cb_5 from commandbutton within w_break_out
int X=1829
int Y=1152
int Width=256
int Height=192
string Text="E"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "E" )
end on

type cb_4 from commandbutton within w_break_out
int X=1573
int Y=1152
int Width=256
int Height=192
string Text="D"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "D" )
end on

type cb_3 from commandbutton within w_break_out
int X=1317
int Y=1152
int Width=256
int Height=192
string Text="C"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "C" )
end on

type cb_2 from commandbutton within w_break_out
int X=1061
int Y=1152
int Width=256
int Height=192
string Text="B"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "B" )
end on

type cb_1 from commandbutton within w_break_out
int X=805
int Y=1152
int Width=256
int Height=192
string Text="A"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_key_pressed ( "A" )
end on

type dw_misc from datawindow within w_break_out
event ue_set_focus pbm_custom01
int X=1189
int Y=248
int Width=1079
int Height=284
string DataObject="d_object_info_bo"
boolean Border=false
end type

event getfocus;If bMessage Then wf_hide_message ( )

end event

type sle_title from statictext within w_break_out
int Width=2926
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Break Out"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="MS Sans Serif"
boolean Italic=true
boolean Underline=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_location from groupbox within w_break_out
int X=1609
int Y=656
int Width=805
int Height=224
string Text="Location"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_qty from groupbox within w_break_out
int X=878
int Y=656
int Width=709
int Height=224
string Text="Quantity Broken Out"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_serial_number from groupbox within w_break_out
int X=37
int Y=416
int Width=805
int Height=224
string Text="Serial Number"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_unit from groupbox within w_break_out
int X=878
int Y=896
int Width=439
int Height=224
string Text="Unit"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_operator from groupbox within w_break_out
int X=37
int Y=176
int Width=805
int Height=224
string Text="Operator - "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_numberof from groupbox within w_break_out
int X=37
int Y=896
int Width=805
int Height=224
string Text="Objects Broken Out"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_dwbox from groupbox within w_break_out
int X=1152
int Y=164
int Width=1134
int Height=392
string Text="Object Information"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_packaging from groupbox within w_break_out
int X=37
int Y=656
int Width=805
int Height=224
string Text="Packaging"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


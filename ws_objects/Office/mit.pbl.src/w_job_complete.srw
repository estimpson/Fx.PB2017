$PBExportHeader$w_job_complete.srw
forward
global type w_job_complete from Window
end type
type sle_unit from singlelineedit within w_job_complete
end type
type lb_list from u_it_list_box within w_job_complete
end type
type sle_packaging from singlelineedit within w_job_complete
end type
type sle_part from singlelineedit within w_job_complete
end type
type sle_location_to from singlelineedit within w_job_complete
end type
type dw_pallets from datawindow within w_job_complete
end type
type st_pallet from statictext within w_job_complete
end type
type sle_pallet from statictext within w_job_complete
end type
type cb_pallet_label from commandbutton within w_job_complete
end type
type st_2 from statictext within w_job_complete
end type
type em_1 from editmask within w_job_complete
end type
type dw_transactions from datawindow within w_job_complete
end type
type sle_status from statictext within w_job_complete
end type
type cb_back from commandbutton within w_job_complete
end type
type lb_unit_list from listbox within w_job_complete
end type
type cb_space from commandbutton within w_job_complete
end type
type cb_45 from commandbutton within w_job_complete
end type
type dw_1 from datawindow within w_job_complete
end type
type cb__ from commandbutton within w_job_complete
end type
type cb_period from commandbutton within w_job_complete
end type
type cb_- from commandbutton within w_job_complete
end type
type cb_0 from commandbutton within w_job_complete
end type
type cb_clear from commandbutton within w_job_complete
end type
type cb_9 from commandbutton within w_job_complete
end type
type cb_8 from commandbutton within w_job_complete
end type
type cb_7 from commandbutton within w_job_complete
end type
type cb_6 from commandbutton within w_job_complete
end type
type cb_y from commandbutton within w_job_complete
end type
type cb_z from commandbutton within w_job_complete
end type
type cb_enter from commandbutton within w_job_complete
end type
type cb_1 from commandbutton within w_job_complete
end type
type cb_2 from commandbutton within w_job_complete
end type
type cb_3 from commandbutton within w_job_complete
end type
type cb_4 from commandbutton within w_job_complete
end type
type cb_5 from commandbutton within w_job_complete
end type
type cb_q from commandbutton within w_job_complete
end type
type cb_r from commandbutton within w_job_complete
end type
type cb_s from commandbutton within w_job_complete
end type
type cb_t from commandbutton within w_job_complete
end type
type cb_u from commandbutton within w_job_complete
end type
type cb_v from commandbutton within w_job_complete
end type
type cb_w from commandbutton within w_job_complete
end type
type cb_x from commandbutton within w_job_complete
end type
type cb_i from commandbutton within w_job_complete
end type
type cb_j from commandbutton within w_job_complete
end type
type cb_k from commandbutton within w_job_complete
end type
type cb_l from commandbutton within w_job_complete
end type
type cb_m from commandbutton within w_job_complete
end type
type cb_n from commandbutton within w_job_complete
end type
type cb_o from commandbutton within w_job_complete
end type
type cb_p from commandbutton within w_job_complete
end type
type cb_h from commandbutton within w_job_complete
end type
type cb_g from commandbutton within w_job_complete
end type
type cb_f from commandbutton within w_job_complete
end type
type cb_e from commandbutton within w_job_complete
end type
type cb_d from commandbutton within w_job_complete
end type
type cb_c from commandbutton within w_job_complete
end type
type cb_b from commandbutton within w_job_complete
end type
type cb_a from commandbutton within w_job_complete
end type
type dw_misc from datawindow within w_job_complete
end type
type sle_title from statictext within w_job_complete
end type
type dw_object from datawindow within w_job_complete
end type
type dw_unit_list from datawindow within w_job_complete
end type
type lb_1 from listbox within w_job_complete
end type
type sle_lot from singlelineedit within w_job_complete
end type
type sle_numberof from singlelineedit within w_job_complete
end type
type sle_qty from singlelineedit within w_job_complete
end type
type sle_operator from singlelineedit within w_job_complete
end type
type cb_exit from commandbutton within w_job_complete
end type
type cb_audit_trail from commandbutton within w_job_complete
end type
type cb_complete from commandbutton within w_job_complete
end type
type cb_pallet from commandbutton within w_job_complete
end type
type cb_notes from commandbutton within w_job_complete
end type
type gb_pallet from groupbox within w_job_complete
end type
type gb_qty from groupbox within w_job_complete
end type
type gb_operator from groupbox within w_job_complete
end type
type gb_numberof from groupbox within w_job_complete
end type
type gb_parts from groupbox within w_job_complete
end type
type gb_lot from groupbox within w_job_complete
end type
type gb_dwbox from groupbox within w_job_complete
end type
type gb_location_to from groupbox within w_job_complete
end type
type gb_packaging from groupbox within w_job_complete
end type
type sle_machine from singlelineedit within w_job_complete
end type
type gb_machine from groupbox within w_job_complete
end type
type gb_unit from groupbox within w_job_complete
end type
type st_1 from statictext within w_job_complete
end type
type dw_limit_locs from datawindow within w_job_complete
end type
end forward

global type w_job_complete from Window
int X=0
int Y=0
int Width=6656
int Height=3444
boolean TitleBar=true
string Title="Job Complete"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
string Icon="mit.ico"
event undo pbm_custom01
event ue_accept pbm_custom02
event ue_cancel pbm_custom03
event ue_save_note pbm_custom05
event ue_close_uo_note pbm_custom06
event ue_close_audit_trail pbm_custom08
event ue_get_selected_text pbm_custom09
event ue_change_alt_part pbm_custom10
event ue_return_value ( string a_s_return_value )
sle_unit sle_unit
lb_list lb_list
sle_packaging sle_packaging
sle_part sle_part
sle_location_to sle_location_to
dw_pallets dw_pallets
st_pallet st_pallet
sle_pallet sle_pallet
cb_pallet_label cb_pallet_label
st_2 st_2
em_1 em_1
dw_transactions dw_transactions
sle_status sle_status
cb_back cb_back
lb_unit_list lb_unit_list
cb_space cb_space
cb_45 cb_45
dw_1 dw_1
cb__ cb__
cb_period cb_period
cb_- cb_-
cb_0 cb_0
cb_clear cb_clear
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_y cb_y
cb_z cb_z
cb_enter cb_enter
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_q cb_q
cb_r cb_r
cb_s cb_s
cb_t cb_t
cb_u cb_u
cb_v cb_v
cb_w cb_w
cb_x cb_x
cb_i cb_i
cb_j cb_j
cb_k cb_k
cb_l cb_l
cb_m cb_m
cb_n cb_n
cb_o cb_o
cb_p cb_p
cb_h cb_h
cb_g cb_g
cb_f cb_f
cb_e cb_e
cb_d cb_d
cb_c cb_c
cb_b cb_b
cb_a cb_a
dw_misc dw_misc
sle_title sle_title
dw_object dw_object
dw_unit_list dw_unit_list
lb_1 lb_1
sle_lot sle_lot
sle_numberof sle_numberof
sle_qty sle_qty
sle_operator sle_operator
cb_exit cb_exit
cb_audit_trail cb_audit_trail
cb_complete cb_complete
cb_pallet cb_pallet
cb_notes cb_notes
gb_pallet gb_pallet
gb_qty gb_qty
gb_operator gb_operator
gb_numberof gb_numberof
gb_parts gb_parts
gb_lot gb_lot
gb_dwbox gb_dwbox
gb_location_to gb_location_to
gb_packaging gb_packaging
sle_machine sle_machine
gb_machine gb_machine
gb_unit gb_unit
st_1 st_1
dw_limit_locs dw_limit_locs
end type
global w_job_complete w_job_complete

type variables
String			is_Field,&
			is_original_part,&
			is_pallet_string,&
			i_s_commport
st_generic_structure 	stParm
st_generic_structure	stTransParm
st_generic_structure 		istr_pallets[]
Int 			iThisInstance
Int 			ii_ddlbIndex
Int			iHandle
boolean			i_b_clear
Boolean			bAuditTrail
Boolean			bNoKey
Boolean			bUserNotes
Boolean			bUserOperator
Boolean 			bWriteParent
Boolean 			bZeroParent
Boolean 			bNoCheck
Boolean 			bChars, bNumbers
Boolean 			bDelete
Boolean 			bEnabled
Boolean 			bLabelNeeded
Boolean 			bCurrentObject
Boolean 			bNewObject
Boolean 			bPopulateParts
Boolean 			bPopulateLocations
Boolean 			bPopulateMachines
Boolean 			bExit
Boolean 			bMessageBox
Boolean 			bMandatoryLot
Boolean 			bRequired
Boolean 			bClicked
Boolean 			bExternalMessage
Boolean 			bOpen
Boolean 			bNoClickCheck
Boolean 			bMessage
Boolean 			bSetToThis
Boolean 			bTab
Boolean 			bAction
Boolean			bNumberOfMode
Boolean			bLotMode
Boolean			bQtyMode
Boolean			bUnitMode
Boolean			bDeleteScrap
Boolean			bSetBack
Boolean			bLabel
Boolean			ib_Forward, &
			ib_Back, &
			ib_Auto, &
			ib_Cancel, &
			ib_Notes, &
			ib_Password, &
			ib_SelectionChanged,&
			ib_enter,&
			i_b_winwedge
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
			is_Notes, &
			is_UndoOperator
DateTime 		dtToday
DateTime 		dDateTime
Date 			dToday
Time 			tTime
Dec 			dQuantity
Dec 			dWeight
Dec 			dPrice
Dec 			dOnHand
Long	 		lParent
Long 			lSerial
Long 			lLoop
Long 			lRow
Long 			lColumn
Long 			lSerialParm
Long			il_AuditRow
Long			il_PalletSerial=0
DataWindow 		dwObject
GraphicObject		igo_Last
st_generic_structure	istr_ReturnParm

st_dda_parmlist                        st_prmlst
string                                        szdimensionqtystring
Integer                                      li_nonconstantdim
end variables

forward prototypes
public subroutine disable_chars ()
public subroutine enable_chars ()
public subroutine disable_numbers ()
public subroutine enable_numbers ()
public subroutine wf_setup_screen ()
public subroutine wf_reset_indicators ()
public subroutine wf_enable_screen ()
public subroutine wf_disable_screen ()
public subroutine wf_get_unit_list (string szpartnumber, string szoriginalunit)
public subroutine wf_loop_for_avail_units (string szunit, int iorder)
public subroutine wf_reset_colors ()
public subroutine wf_change_color_focus ()
public function string wf_get_character ()
public function boolean wf_valid_key ()
public subroutine wf_show_message ()
public subroutine wf_hide_message ()
public function boolean wf_job_complete ()
public function boolean wf_delete_audit_trail (long ll_serial)
public function boolean wf_update_onhand (long ll_serial, string ls_mode)
public function boolean wf_delete_object (long ll_serial)
public subroutine wf_key_pressed (string ccharacter)
public subroutine wf_set_focus (string as_field)
public subroutine wf_setup_pallet (boolean ab_mode)
public subroutine wf_disable_except_buttons ()
public subroutine wf_enable_except_buttons ()
end prototypes

event undo;String			ls_Part
String 			ls_Type
Long				ll_Serial
Long				ll_Dummy
Long				ll_Temp
Int				iCounter
DateTime			ldt_Date
str_progress 	stProgressParm
Dec				ld_Qty
Dec				ld_StdQty
Dec				ld_NewOnHand
Dec				ld_ObjectQty
Dec				ld_ObjectStdQty

//  Initialize variables

il_AuditRow = u_audit_trail.dw_audit_trail.GetRow ( )

IF il_AuditRow < 1 THEN Return

ls_Type 		= u_audit_trail.dw_audit_trail.GetItemString ( il_AuditRow, "type" )
ldt_Date		= u_audit_trail.dw_audit_trail.GetItemDateTime ( il_AuditRow, "date_stamp" )
ll_Serial 	= u_audit_trail.dw_audit_trail.GetItemNumber ( il_AuditRow, "serial" )
ld_Qty 		= u_audit_trail.dw_audit_trail.GetItemNumber ( il_AuditRow, "quantity" )
ld_StdQty 	= u_audit_trail.dw_audit_trail.GetItemNumber ( il_AuditRow, "std_quantity" )
ls_Part		= u_audit_trail.dw_audit_trail.GetItemString ( il_AuditRow, "part" )

bFinish = False

stProgressParm.Title = "Undo Completion"
stProgressParm.Cancel_window = This

OpenWithParm ( w_progress, stProgressParm )

iCounter++
w_progress.wf_progress ( iCounter / 3, "Updating Onhand Balance..." )

If wf_update_onhand ( ll_Serial, "-" ) Then

	iCounter++
	w_progress.wf_progress ( iCounter / 3, "Deleting Object..." )

	If wf_delete_object ( ll_Serial ) Then

		iCounter++
		w_progress.wf_progress ( iCounter / 3, "Deleting Audit Trail..." )

		If wf_delete_audit_trail ( ll_Serial ) Then
			Commit ;
		Else
			RollBack ;
		End if
	Else
		RollBack ;
	End if
Else
	RollBack ;
End if

Close ( w_progress )

u_audit_trail.dw_audit_trail.SetTransObject ( sqlca )

u_audit_trail.dw_audit_trail.Retrieve ( dtToday, ls_Type, sle_machine.Text )

u_audit_trail.SetRedraw ( TRUE )
end event

event ue_accept;
end event

on ue_cancel;//gb_Cancel = TRUE
ib_Auto = FALSE
sle_qty.Text = ""
sle_qty.SetFocus ( )
end on

on ue_save_note;is_Notes = u_generic_it_note.mle_note.Text
This.CloseUserObject ( u_generic_it_note )
wf_enable_except_buttons ( )
wf_set_focus ( is_Field )
ib_Notes = FALSE
end on

on ue_close_uo_note;This.CloseUserObject ( u_generic_it_note )
wf_enable_except_buttons ( )
wf_set_focus ( is_Field )
ib_Notes = FALSE
end on

on ue_close_audit_trail;CloseUserObject ( u_audit_trail )
wf_enable_screen ( )
wf_set_focus ( is_Field )
end on

event ue_change_alt_part;//sle_part.Text = szReturnedString
//szReturnedString = ""
//
//SetRedraw ( TRUE )
end event

event ue_return_value;lb_list.Hide ( )
ib_Forward = TRUE
Choose Case is_field
	Case "machine"
		sle_machine.Text = a_s_return_value
		sle_machine.TriggerEvent ( "ue_validate" )
	Case "part"
		sle_part.Text = a_s_return_value
		sle_part.TriggerEvent ( "ue_validate" )
	Case "location"
		sle_location_to.Text = a_s_return_value
		sle_location_to.TriggerEvent ( "ue_validate" )
	Case "packaging"
		sle_packaging.Text = a_s_return_value
		sle_packaging.TriggerEvent ( "ue_validate" )
	Case "unit"
		sle_unit.Text = a_s_return_value
		sle_unit.TriggerEvent ( "ue_validate" )
End Choose
end event

public subroutine disable_chars ();bChars = False
cb_a.Enabled = False
cb_b.Enabled = False
cb_c.Enabled = False
cb_d.Enabled = False
cb_e.Enabled = False
cb_f.Enabled = False
cb_g.Enabled = False
cb_h.Enabled = False
cb_i.Enabled = False
cb_j.Enabled = False
cb_k.Enabled = False
cb_l.Enabled = False
cb_m.Enabled = False
cb_n.Enabled = False
cb_o.Enabled = False
cb_p.Enabled = False
cb_q.Enabled = False
cb_r.Enabled = False
cb_s.Enabled = False
cb_t.Enabled = False
cb_u.Enabled = False
cb_v.Enabled = False
cb_w.Enabled = False
cb_x.Enabled = False
cb_y.Enabled = False
cb_z.Enabled = False
cb_space.Enabled = False
cb__.Enabled = False
cb_-.Enabled = False


end subroutine

public subroutine enable_chars ();bChars = TRUE
cb_a.Enabled = TRUE
cb_b.Enabled = TRUE
cb_c.Enabled = TRUE
cb_d.Enabled = TRUE
cb_e.Enabled = TRUE
cb_f.Enabled = TRUE
cb_g.Enabled = TRUE
cb_h.Enabled = TRUE
cb_i.Enabled = TRUE
cb_j.Enabled = TRUE
cb_k.Enabled = TRUE
cb_l.Enabled = TRUE
cb_m.Enabled = TRUE
cb_n.Enabled = TRUE
cb_o.Enabled = TRUE
cb_p.Enabled = TRUE
cb_q.Enabled = TRUE
cb_r.Enabled = TRUE
cb_s.Enabled = TRUE
cb_t.Enabled = TRUE
cb_u.Enabled = TRUE
cb_v.Enabled = TRUE
cb_w.Enabled = TRUE
cb_x.Enabled = TRUE
cb_y.Enabled = TRUE
cb_z.Enabled = TRUE
cb_space.Enabled = TRUE
cb__.Enabled = TRUE
cb_-.Enabled = TRUE


end subroutine

public subroutine disable_numbers ();bNumbers = False
cb_1.Enabled = False
cb_2.Enabled = False
cb_3.Enabled = False
cb_4.Enabled = False
cb_5.Enabled = False
cb_6.Enabled = False
cb_7.Enabled = False
cb_8.Enabled = False
cb_9.Enabled = False
cb_0.Enabled = False
cb_period.Enabled = FALSE
end subroutine

public subroutine enable_numbers ();bNumbers = True
cb_1.Enabled = TRUE
cb_2.Enabled = TRUE
cb_3.Enabled = TRUE
cb_4.Enabled = TRUE
cb_5.Enabled = TRUE
cb_6.Enabled = TRUE
cb_7.Enabled = TRUE
cb_8.Enabled = TRUE
cb_9.Enabled = TRUE
cb_0.Enabled = TRUE
cb_period.Enabled = TRUE
end subroutine

public subroutine wf_setup_screen ();/*  Declare Variables  */

dw_misc.SetTransObject ( sqlca )

String 	szNull
String 	cPopParts
String	cPopLocations
String	cPopMachines
String	cNumberOfMode
String	cQtyMode
String	cLotMode
String	cUnitMode
string	l_s_clear_after_trans_jc

integer	li_count

SetNull ( szNull )


SELECT populate_parts,   
       populate_locations,   
       populate_machines,
		 clear_after_trans_jc
  INTO :cPopParts,   
       :cPopLocations,   
       :cPopMachines,
		 :l_s_clear_after_trans_jc
  FROM parameters  ;

If cPopParts 			= 'Y' Then bPopulateParts 		= True
If cPopLocations 		= 'Y' Then bPopulateLocations = True
If cPopMachines 		= 'Y' Then bPopulateMachines 	= True
i_b_clear 				= ( l_s_clear_after_trans_jc = 'Y' )

bOpen = True

SELECT inventory_parameters.jc_number_of,   
       inventory_parameters.jc_qty,   
       inventory_parameters.jc_unit,   
       inventory_parameters.jc_material_lot
  INTO :cNumberOfMode,   
       :cQtyMode,   
       :cUnitMode,   
       :cLotMode
  FROM inventory_parameters  ;

If cNumberOfMode 	= 'R' Then bNumberOfMode = True
If cLotMode 		= 'R' Then bLotMode 		= True
If cQtyMode 		= 'R' Then bQtyMode 		= True
If cUnitMode 		= 'R' Then bUnitMode 		= True

/*  Main  */

String cMandatoryLot
	
SELECT parameters.mandatory_lot_inventory  
  INTO :cMandatoryLot  
  FROM parameters  ;
		
If Upper ( cMandatoryLot ) = 'Y' Then bMandatoryLot = True

sle_numberof.Text = "1"

If f_get_string_value ( szMachineParm) > "" Then

	SELECT	count(*)
	INTO		:li_count
	FROM		machine_serial_comm
	WHERE		machine = :sle_machine.Text ;
	
	If SQLCA.SQLCode = 0 Then
	End if
End if

sle_machine.SetFocus ( )

end subroutine

public subroutine wf_reset_indicators ();wf_reset_colors ( )
end subroutine

public subroutine wf_enable_screen ();cb_1.Enabled = TRUE
cb_2.Enabled = TRUE
cb_3.Enabled = TRUE
cb_4.Enabled = TRUE
cb_5.Enabled = TRUE
cb_6.Enabled = TRUE
cb_7.Enabled = TRUE
cb_8.Enabled = TRUE
cb_9.Enabled = TRUE
cb_0.Enabled = TRUE
cb_a.Enabled = TRUE
cb_b.Enabled = TRUE
cb_c.Enabled = TRUE
cb_d.Enabled = TRUE
cb_e.Enabled = TRUE
cb_f.Enabled = TRUE
cb_g.Enabled = TRUE
cb_h.Enabled = TRUE
cb_i.Enabled = TRUE
cb_j.Enabled = TRUE
cb_k.Enabled = TRUE
cb_l.Enabled = TRUE
cb_m.Enabled = TRUE
cb_n.Enabled = TRUE
cb_o.Enabled = TRUE
cb_p.Enabled = TRUE
cb_q.Enabled = TRUE
cb_r.Enabled = TRUE
cb_s.Enabled = TRUE
cb_t.Enabled = TRUE
cb_u.Enabled = TRUE
cb_v.Enabled = TRUE
cb_w.Enabled = TRUE
cb_x.Enabled = TRUE
cb_y.Enabled = TRUE
cb_z.Enabled = TRUE
cb_space.Enabled = TRUE
cb_period.Enabled = TRUE
cb__.Enabled = TRUE
cb_-.Enabled = TRUE
cb_clear.Enabled = TRUE
cb_back.Enabled = TRUE
cb_enter.Enabled = TRUE
cb_exit.Enabled = TRUE
cb_audit_trail.Enabled = TRUE
cb_complete.Enabled = TRUE
cb_notes.Enabled = TRUE
cb_pallet.Enabled = TRUE
IF sle_pallet.Visible THEN
	cb_pallet_label.Enabled = TRUE
	sle_pallet.Enabled = TRUE
	st_pallet.Enabled = TRUE
END IF
sle_operator.Enabled = TRUE
dw_misc.Enabled = TRUE
sle_location_to.Enabled = TRUE
sle_machine.Enabled = TRUE
sle_part.Enabled = TRUE
sle_qty.Enabled = TRUE
sle_unit.Enabled = TRUE
sle_lot.Enabled = TRUE
sle_packaging.Enabled = TRUE
sle_numberof.Enabled = TRUE

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
cb_0.Enabled = False
cb_a.Enabled = False
cb_b.Enabled = False
cb_c.Enabled = False
cb_d.Enabled = False
cb_e.Enabled = False
cb_f.Enabled = False
cb_g.Enabled = False
cb_h.Enabled = False
cb_i.Enabled = False
cb_j.Enabled = False
cb_k.Enabled = False
cb_l.Enabled = False
cb_m.Enabled = False
cb_n.Enabled = False
cb_o.Enabled = False
cb_p.Enabled = False
cb_q.Enabled = False
cb_r.Enabled = False
cb_s.Enabled = False
cb_t.Enabled = False
cb_u.Enabled = False
cb_v.Enabled = False
cb_w.Enabled = False
cb_x.Enabled = False
cb_y.Enabled = False
cb_z.Enabled = False
cb_space.Enabled = False
cb_period.Enabled = False
cb__.Enabled = False
cb_-.Enabled = False
cb_clear.Enabled = False
cb_back.Enabled = False
cb_enter.Enabled = False
cb_exit.Enabled = False
cb_audit_trail.Enabled = False
cb_complete.Enabled = False
cb_notes.Enabled = False
cb_pallet.Enabled = False
IF sle_pallet.Visible THEN
	cb_pallet_label.Enabled = False
	sle_pallet.Enabled = FALSE
	st_pallet.Enabled = FALSE
END IF
sle_operator.Enabled = False
dw_misc.Enabled = False
sle_location_to.Enabled = False
sle_machine.Enabled = False
sle_part.Enabled = False
sle_qty.Enabled = False
sle_unit.Enabled = False
sle_lot.Enabled = False
sle_packaging.Enabled = False
sle_numberof.Enabled = False

end subroutine

public subroutine wf_get_unit_list (string szpartnumber, string szoriginalunit);//  Declare Variables

Int iPos
Int iLoop

String szTempUnit


//  Initialize Variables

dw_unit_list.DataObject = "d_unit_conversion_list_per_part"
dw_unit_list.SetTransObject ( sqlca )
//ddlb_unit.Reset ( )
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

//For iLoop = 1 to lb_unit_list.TotalItems ( )
//
//	iLoop = lb_unit_list.SelectItem ( iLoop )
//	ddlb_unit.AddItem ( lb_unit_list.SelectedItem ( ) )
//
//Next

//ddlb_unit.Text = szOriginalUnit



////  Declare Variables
//
//Int iPos
//Int iLoop
//
//String szTempUnit
//
//
////  Initialize Variables
//
//dw_unit_list.DataObject = "d_unit_conversion_list_per_part"
//dw_unit_list.SetTransObject ( sqlca )
//ddlb_unit.Reset ( )
//lb_unit_list.Reset ( )
//
//If IsNull ( szOriginalUnit ) Or szOriginalUnit = "" Then
//
//  SELECT part_inventory.standard_unit  
//    INTO :szOriginalUnit  
//    FROM part_inventory  
//   WHERE part_inventory.part = :szPartNumber   ;
//
//End if
//
//dw_unit_list.Retrieve ( szPartNumber )
//
//If dw_unit_list.RowCount ( ) < 1 Then Goto THE_END
//
////  Loop through forward and look for chain
//
//wf_loop_for_avail_units ( szOriginalUnit, 1 )
//
//
////  Loop through backwards and look for chain
//
//wf_loop_for_avail_units ( szOriginalUnit, 2 )
//
//THE_END:
//
//If lb_unit_list.FindItem ( szOriginalUnit, 1 ) < 1 Then &
//	lb_unit_list.AddItem ( szOriginalUnit )
//
//For iLoop = 1 to lb_unit_list.TotalItems ( )
//
//	iLoop = lb_unit_list.SelectItem ( iLoop )
//	ddlb_unit.AddItem ( lb_unit_list.SelectedItem ( ) )
//
//Next
//
//ddlb_unit.Text = szOriginalUnit
//
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

public subroutine wf_reset_colors ();//gb_machine.TextColor = f_get_color_value ( "darkred" )
//gb_location_to.TextColor = f_get_color_value ( "darkred" )
//gb_parts.TextColor = f_get_color_value ( "darkred" )
//gb_packaging.TextColor = f_get_color_value ( "darkred" )
//gb_lot.TextColor = f_get_color_value ( "darkred" )
//gb_operator.TextColor = f_get_color_value ( "darkred" )
//gb_numberof.TextColor = f_get_color_value ( "darkred" )
//gb_qty.TextColor = f_get_color_value ( "darkred" )
//gb_unit.TextColor = f_get_color_value ( "darkred" )
//

gb_machine.TextColor = f_get_color_value ( "black" )
gb_location_to.TextColor = f_get_color_value ( "black" )
gb_parts.TextColor = f_get_color_value ( "black" )
gb_packaging.TextColor = f_get_color_value ( "black" )
gb_lot.TextColor = f_get_color_value ( "black" )
gb_operator.TextColor = f_get_color_value ( "black" )
gb_numberof.TextColor = f_get_color_value ( "black" )
gb_qty.TextColor = f_get_color_value ( "black" )
gb_unit.TextColor = f_get_color_value ( "black" )


end subroutine

public subroutine wf_change_color_focus ();//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	User	Date	Note/Changes
//	----	----	------------
//	GPH	3/31/00	Uncommented the 1st Choose Case block & commented the 2nd choose case block
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

wf_reset_colors ( )
Choose Case is_Field
	Case "machine"
		gb_machine.TextColor = f_get_color_value ( "blue" )
	Case "part"
		gb_parts.TextColor = f_get_color_value ( "blue" )
	Case "packaging"
		gb_packaging.TextColor = f_get_color_value ( "blue" )
	Case "lot"
		gb_lot.TextColor = f_get_color_value ( "blue" )
	Case "location"
		gb_location_to.TextColor = f_get_color_value ( "blue" )
	Case "operator"
		gb_operator.TextColor = f_get_color_value ( "blue" )
	Case "numberof"
		gb_numberof.TextColor = f_get_color_value ( "blue" )
	Case "qty"
		gb_qty.TextColor = f_get_color_value ( "blue" )
	Case "unit"
		gb_unit.TextColor = f_get_color_value ( "blue" )
End Choose

//Choose Case is_Field
//	Case "machine"
//		gb_machine.TextColor = f_get_color_value ( "black" )
//	Case "part"
//		gb_parts.TextColor = f_get_color_value ( "black" )
//	Case "packaging"
//		gb_packaging.TextColor = f_get_color_value ( "black" )
//	Case "lot"
//		gb_lot.TextColor = f_get_color_value ( "black" )
//	Case "location"
//		gb_location_to.TextColor = f_get_color_value ( "black" )
//	Case "operator"
//		gb_operator.TextColor = f_get_color_value ( "black" )
//	Case "numberof"
//		gb_numberof.TextColor = f_get_color_value ( "black" )
//	Case "qty"
//		gb_qty.TextColor = f_get_color_value ( "black" )
//	Case "unit"
//		gb_unit.TextColor = f_get_color_value ( "black" )
//End Choose
//
//
//
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
	if KeyDown ( keyShift! ) then
		Return "_"
	else
		Return "-"
	end if
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
Elseif KeyDown ( keyPeriod! ) Then
	if KeyDown ( keyShift! ) Then
		Return ">"
	else
		Return "."
	end if
Elseif KeyDown ( keyDecimal! ) Then
	Return "."
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
   KeyDown ( keyNumPad9! ) Or &
	KeyDown ( keyPeriod! ) Or &
	KeyDown ( keyDecimal! ) Or &
	KeyDown ( keySubtract! ) Then

	Return True

End if

Return False
end function

public subroutine wf_show_message ();bMessage = True
Timer ( .25, This )
end subroutine

public subroutine wf_hide_message ();sle_status.Hide ( )
Timer ( 0 )
bMessage = False
end subroutine

public function boolean wf_job_complete ();/*  Declare Variables  */
String	cAllowZeroQty
string	ls_UserDefinedStatus,&
	ls_engineering_level,&
	l_s_palletlocation, &
	l_s_name, &
	ls_temp, &
	ls_data
Int 	i_RtnCode
Boolean	b_RtnValue

st_generic_structure stParm2

/*  Check all needed areas  */

If sle_machine.Text = "" Then
	f_beep ( 5 )

	If Not bPopulateMachines Then
		i_RtnCode = MessageBox ( "Error", "A valid machine is required! Would you like to use drop down list?", Question!, YesNo!, 1 )
		If i_RtnCode = 1 Then
			bPopulateMachines = True
			lb_list.uf_setup ( "location", "code", sle_machine.x, sle_machine.y, sle_machine.height, 1150, sle_machine.TextSize, sle_machine.width, '', '', lb_unit_list, dw_limit_locs )
			lb_list.Show ( )
		End if
	Else
		MessageBox ( "Error", "A valid machine is required!  Please select a valid one from list.", StopSign! )
	End if
	Return False
else
	
	ls_temp = ''
	ls_data = sle_machine.text
	If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
		SELECT	code  
		INTO	:ls_Temp  
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :ls_data ) AND  
			( trans_code = 'J' ) AND  
			( type = 'MC' ) ;
	else
		SELECT	code  
		INTO	:ls_Temp  
		FROM	location  
		WHERE	( code = :ls_data ) AND  
			( type = 'MC' )   ;
	end if 	
	if ls_temp <= '' or isnull(ls_temp) then
		MessageBox ( "Error", "A valid machine is required!  Please select a valid one from list.", StopSign! )
		return false
	end if 	
End if

If sle_part.Text = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid part number is required to continue!", StopSign! )
	Return False
else
	ls_temp=''	
	ls_data = sle_part.text
	SELECT	part.part
	INTO	:ls_Temp
	FROM	part  
	WHERE	part.part = :ls_data  ;
	if ls_temp <= '' or isnull(ls_temp) then
		MessageBox ( "Error", "A valid part number is required to continue!", StopSign! )
		return false
	end if 	
End if

If bLotMode And bMandatoryLot And sle_lot.Text = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid material lot number is required to continue!", StopSign! )
	Return False
End if

If sle_location_to.Text = "" Then
	sle_location_to.Text = sle_machine.Text
else
	ls_temp = ''
	ls_data = sle_location_to.text
	If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
		SELECT	code  
		INTO	:ls_Temp  
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :ls_data ) AND  
			( trans_code = 'J' ) AND  
			( type = 'MC' ) ;
	else
		SELECT	code  
		INTO	:ls_Temp  
		FROM	location  
		WHERE	( code = :ls_data );
	end if 
	if ls_temp <= '' or isnull(ls_temp) then
		MessageBox ( "Error", "A valid location is required!  Please select a valid one from list.", StopSign! )
		return false
	end if 		
End if

If szOperator = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
	Return False
End if

If Dec ( sle_numberof.Text ) < 1 Then
	f_beep ( 5 )
	MessageBox ( "Error", "Number of objects must be greater than 0!", StopSign! )
	Return False
End if

SELECT inventory_parameters.jc_allow_zero_qty  
  INTO :cAllowZeroQty  
  FROM inventory_parameters  ;

If cAllowZeroQty <> 'Y' And Dec ( sle_qty.Text ) <= 0 Then
	f_beep ( 5 )
	MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
	Return False
End if

If Trim ( f_get_string_value ( sle_unit.Text ) ) = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid unit of measure is required to continue!", StopSign! )
	Return False
End if

//  Declare Variables
Time tTime

Dec dQuantity, dWeight, dCost, dOnHand
Dec dStdQuantity
Dec dTare

String szStatus, szLocationTo, szFromLoc, szPartNumber, szUnit
String cQA
String szPackageType
String szPlant

Long lSerial
Long lNumberOfObjects

Date dToday

DateTime dDateStamp

Str_progress stParm

Int iCount, iTenTimes
Int iLoop

//  Prime and open progress window
stParm.Title = 'Job Completion'

OpenWithParm ( w_progress, stParm )


//  Initialize variables
iCount = 0
tTime = Now ( )
dQuantity = f_get_value ( Dec ( sle_qty.Text ) )
dToday = Today ( )
szLocationTo = f_get_string_value ( sle_location_to.Text )
szPartNumber = f_get_string_value ( sle_part.Text )
szPackageType = f_get_string_value ( sle_packaging.Text )
szFromLoc = f_get_string_value ( sle_machine.Text )
dDateStamp = DateTime ( Today ( ), Now ( ) )
szUnit = f_get_string_value ( sle_unit.Text )
lNumberOfObjects = f_get_value ( Long ( sle_numberof.Text ) )
If szLocationTo = "" Then szLocationTo = szFromLoc

SELECT location.plant  
  INTO :szPlant  
  FROM location  
 WHERE location.code = :szLocationTo   ;


// grab tare weight from packaging table

  SELECT package_materials.weight  
    INTO :dTare  
    FROM package_materials  
   WHERE package_materials.code = :szPackageType   ;

If SQLCA.SQLCOde <> 0 Then
	dTare = 0
End if

//  grab standard cost from part master
SELECT part.quality_alert  ,
       part.name
  INTO :cQA,
       :l_s_name
  FROM part  
 WHERE part.part = :szPartNumber   ;

SELECT part_standard.cost_cum  
  INTO :dCost  
  FROM part_standard
 WHERE part_standard.part = :szPartNumber   ;

dCost = f_get_value ( dCost )
cQA = f_get_string_value ( cQA )

If cQA = 'Y' Then
	szStatus = 'H'
	ls_UserDefinedStatus = "On Hold"
Else
	szStatus = 'A'
	ls_UserDefinedStatus = "Approved"
End if

//  Get engineering level from part master
SELECT engineering_level
  INTO :ls_engineering_level
  FROM part_mfg
 WHERE part = :szPartNumber ;

//  grab weight from part master
SELECT part_inventory.unit_weight  
  INTO :dWeight  
  FROM part_inventory
 WHERE part_inventory.part = :szPartNumber   ;

dWeight = f_get_value ( dWeight )

IF IsNull ( il_PalletSerial, 0 ) < 1 THEN
	SetNull ( il_PalletSerial )
ELSE
	SELECT location
	INTO :l_s_palletlocation
	FROM object
	WHERE serial = :il_palletserial ;

	IF (l_s_palletlocation <> szLocationTo) THEN
		f_beep ( 5 )	
		Messagebox("Error","Object location: "+szlocationTo+", is different from pallet location: "+l_s_palletlocation+", Select the correct object location",StopSign!)
		Close ( w_progress )	
		Return False	
	END IF 	
END IF

For lLoop = 1 to lNumberOfObjects

	dDateStamp = DateTime ( Today ( ), Now ( ) )

	Yield ( )

	//  Grab next serial number and update parameter file
	if SQLCA.of_getnextparmvalue ( 'next_serial', lSerial) then 
		
		iCount = iCount + 1
		w_progress.wf_progress ( iCount / ( 4 * lNumberOfObjects ), "Creating Object..." )
	
		//  Prime unit of measure structure and open conversion window
		dStdQuantity = f_get_value ( &
			f_convert_units ( sle_unit.Text, "", szPartNumber, Dec ( sle_qty.Text ) ) )
	
		//  Create object record
		INSERT INTO object
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
			quantity,   
			last_time,   
			date_due,   
			customer,
			package_type,
			std_quantity,   
			sequence,
			plant,
			tare_weight, 
			std_cost,
			user_defined_status,
			engineering_level,
			dimension_qty_string,
			varying_dimension_code,
			name)
		VALUES ( :lSerial,   
			:szPartNumber,   
			:sle_lot.Text,   
			:szLocationTo,   
			:ddatestamp,   
			:szUnit,   
			:szOperator,   
			:szStatus,   
			null,   
			null,   
			null,   
			:dCost,   
			:dWeight,   
			:il_PalletSerial,   
			:is_Notes,   
			null,   
			:dQuantity,   
			:tTime,   
			null,   
			null,
			:szPackageType,
			:dStdQuantity,   
			null,
			:szPlant,
			:dTare,
			:dCost,
			:ls_UserDefinedStatus,
			:ls_engineering_level,
			:szdimensionqtystring,
			:li_nonconstantdim,
			:l_s_name);
			
		If SQLCA.SQLCode = -1 Then
	
			RollBack ;
			f_beep ( 5 )
			MessageBox ( "Error", "Unable to create object!", StopSign! )
			b_RtnValue = FALSE
	
		Else
			
			iCount = iCount + 1
			w_progress.wf_progress ( iCount / ( 4 * lNumberOfObjects ), "Updating On Hand..." )
	
	
			//  update on hand
			dOnHand = f_update_onhand ( szPartNumber, dStdQuantity, "+*" )
	
			iCount = iCount + 1
			w_progress.wf_progress ( iCount / ( 4 * lNumberOfObjects ), "Creating Audit Trail..." )
	
	
			//  Create audit trail
			If Not f_create_audit_trail ( lSerial, "J", "", String ( dCost ), sle_machine.Text, "Normal", szWorkOrder, String ( dOnHand ), "", "", "", "No Commit" ) Then
	
				RollBack ;
				f_beep ( 5 )
				MessageBox ( "Error", "Unable to create audit trail!", StopSign! )
				b_RtnValue = FALSE
	
			Else
				Commit ;
				
				iCount = iCount + 1
				w_progress.wf_progress ( iCount / ( 4 * lNumberOfObjects ), "Printing Label..." )
	
				//  print label
				f_beep ( 1 )
				wf_show_message ( )
				stParm2.value1 = String ( lSerial )
				f_print_label ( stParm2 )
				b_RtnValue = TRUE
	
			End if
	
		End if
	else
		Rollback ;
	end if 
Next

Close ( w_progress )

Return b_RtnValue
end function

public function boolean wf_delete_audit_trail (long ll_serial);DELETE FROM audit_trail
 WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	Return False
Else
	Return True
End if


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

public function boolean wf_delete_object (long ll_serial);DELETE FROM object  
 WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	Return False
End if

Return True
end function

public subroutine wf_key_pressed (string ccharacter);String szSerial
String szPreviousText
String	s_Temp

wf_hide_message ( )

/*  Initialize Variables  */


IF ib_Notes THEN
	u_generic_it_note.mle_note.Text = u_generic_it_note.mle_note.Text + cCharacter
ELSEIF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = u_audit_trail.sle_operator_password.Text + cCharacter
ELSE
	Choose Case is_Field
		Case "operator"
			sle_operator.Text = sle_operator.Text + cCharacter
			wf_set_focus ( "operator" )
		Case "location"
			sle_location_to.Text = sle_location_to.Text + cCharacter
			szPreviousText = sle_location_to.Text
			wf_set_focus ( "location" )
			lb_list.uf_find_item ( sle_location_to.Text )
		Case "machine"
			sle_machine.Text = sle_machine.Text + cCharacter
			szPreviousText = sle_machine.Text
			wf_set_focus ( "machine" )
			lb_list.uf_find_item ( sle_machine.Text )
		Case "packaging"
			sle_packaging.Text = sle_packaging.Text + cCharacter
			szPreviousText = sle_packaging.Text
			wf_set_focus ( "packaging" )
			lb_list.uf_find_item ( sle_packaging.Text )
		Case "part"
			sle_part.Text = sle_part.Text + cCharacter
			szPreviousText = sle_part.Text
			wf_set_focus ( "part" )
			lb_list.uf_find_item ( sle_part.Text )
//		Case "unit"
//			ddlb_unit.Text = ddlb_unit.Text + cCharacter
//			wf_set_focus ( "unit" )
		Case "qty"
			sle_qty.Text = sle_qty.Text + cCharacter
			wf_set_focus ( "qty" )
		Case "numberof"
			sle_numberof.Text = sle_numberof.Text + cCharacter
			wf_set_focus ( "numberof" )
		Case "lot"
			sle_lot.Text = sle_lot.Text + cCharacter
			wf_set_focus ( "lot" )
	End Choose
END IF
end subroutine

public subroutine wf_set_focus (string as_field);Boolean	b_NoFocus

Choose Case as_Field

	Case "machine"
		sle_machine.SetFocus ( )

	Case "part"
		sle_part.SetFocus ( )

	Case "location"
		sle_location_to.SetFocus ( )

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

	Case "lot"
		sle_lot.SetFocus ( )

	Case "complete"
		cb_complete.SetFocus ( )

	Case Else
		b_NoFocus = True

End Choose

If ( Not b_NoFocus ) Then &
	is_Field = as_Field
end subroutine

public subroutine wf_setup_pallet (boolean ab_mode);IF ab_Mode THEN
	//st_pallet.Show ( )
	gb_pallet.Show ( )
	sle_pallet.Show ( )
	cb_pallet_label.Show ( )
	if is_pallet_string = "" then
		sle_pallet.TextSize = -12
		sle_pallet.Text = String ( il_PalletSerial )
	else
		if PosA ( is_pallet_string, "/" ) > 0 then
			sle_pallet.TextSize = -8
		else
			sle_pallet.TextSize = -12
		end if
		sle_pallet.Text = is_pallet_string
	end if
	cb_pallet.Text = "Clear Plt"
ELSE
	//st_pallet.Hide ( )
	cb_pallet_label.Hide ( )
	sle_pallet.Text = ""
	cb_pallet.Text = "Pallet"
	il_PalletSerial = 0
	sle_pallet.Hide ( )
	gb_pallet.Hide ( )
	w_job_complete.SetRedraw ( TRUE )
END IF
end subroutine

public subroutine wf_disable_except_buttons ();
cb_enter.Enabled = False
cb_exit.Enabled = False
cb_audit_trail.Enabled = False
cb_complete.Enabled = False
cb_notes.Enabled = False
cb_pallet.Enabled = False
IF sle_pallet.Visible THEN
	cb_pallet_label.Enabled = False
	sle_pallet.Enabled = FALSE
	st_pallet.Enabled = FALSE
END IF
sle_operator.Enabled = False
dw_misc.Enabled = False
sle_location_to.Enabled = False
sle_machine.Enabled = False
sle_part.Enabled = False
sle_qty.Enabled = False
sle_unit.Enabled = False
sle_lot.Enabled = False
sle_packaging.Enabled = False
sle_numberof.Enabled = False

end subroutine

public subroutine wf_enable_except_buttons ();
cb_enter.Enabled = TRUE
cb_exit.Enabled = TRUE
cb_audit_trail.Enabled = TRUE
cb_complete.Enabled = TRUE
cb_notes.Enabled = TRUE
cb_pallet.Enabled = TRUE
IF sle_pallet.Visible THEN
	cb_pallet_label.Enabled = TRUE
	sle_pallet.Enabled = TRUE
	st_pallet.Enabled = TRUE
END IF
sle_operator.Enabled = TRUE
dw_misc.Enabled = TRUE
sle_location_to.Enabled = TRUE
sle_machine.Enabled = TRUE
sle_part.Enabled = TRUE
sle_qty.Enabled = TRUE
sle_unit.Enabled = TRUE

sle_lot.Enabled = TRUE
sle_packaging.Enabled = TRUE
sle_numberof.Enabled = TRUE

end subroutine

on timer;If bMessage Then
	If sle_status.Visible = True Then
		sle_status.Visible = False
	Else
		sle_status.Visible = True
	End if
	Return
End if


IF ( is_Field = "machine" AND bPopulateMachines ) OR &
	( is_Field = "part"  And bPopulateParts ) OR &
	( is_Field = "location" And bPopulateLocations ) OR &
	is_Field = "packaging" THEN

	/*  Declare Variables  */
	DropDownListBox ddlb_Current

	/*  main  */
	ddlb_Current = GetFocus ( )
	szRealityText = szRealityText + cCharacterTouched
	ii_ddlbIndex = ddlb_Current.FindItem ( szRealityText, 1 )
	ii_ddlbIndex = ddlb_Current.SelectItem ( ii_ddlbIndex )
	szSelectedText = ddlb_Current.SelectedText ( )
	ddlb_Current.Text = szRealityText //szSelectedText  //szRealityText

	Timer ( 0, This )

END IF
end on

event open;/*  Initialize Variables  */

bChars = True
bNumbers = True

st_generic_structure lst_generic_st

lst_generic_st = Message.PowerobjectParm
//szWorkOrder   = Message.StringParm

szWorkOrder   = lst_generic_st.value5

dtToday = DateTime ( Today ( ), Now ( ) )

/*  Determine type of transaction and prime the dataobject of dw_1  */

dw_unit_list.SetTransObject ( sqlca )

dw_limit_locs.SetTransObject ( sqlca )
dw_limit_locs.Retrieve ( 'J' )

igo_Last = sle_machine

wf_setup_screen ( )

if lst_generic_st.value7 = 'Location' then
	szlocation = lst_generic_st.value6
	sle_machine.text = lst_generic_st.value6
elseif lst_generic_st.value7 = 'Part' then
	szPart = lst_generic_st.value6
	sle_part.text = lst_generic_st.value6
end if 	


end event

on w_job_complete.create
this.sle_unit=create sle_unit
this.lb_list=create lb_list
this.sle_packaging=create sle_packaging
this.sle_part=create sle_part
this.sle_location_to=create sle_location_to
this.dw_pallets=create dw_pallets
this.st_pallet=create st_pallet
this.sle_pallet=create sle_pallet
this.cb_pallet_label=create cb_pallet_label
this.st_2=create st_2
this.em_1=create em_1
this.dw_transactions=create dw_transactions
this.sle_status=create sle_status
this.cb_back=create cb_back
this.lb_unit_list=create lb_unit_list
this.cb_space=create cb_space
this.cb_45=create cb_45
this.dw_1=create dw_1
this.cb__=create cb__
this.cb_period=create cb_period
this.cb_-=create cb_-
this.cb_0=create cb_0
this.cb_clear=create cb_clear
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_y=create cb_y
this.cb_z=create cb_z
this.cb_enter=create cb_enter
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_q=create cb_q
this.cb_r=create cb_r
this.cb_s=create cb_s
this.cb_t=create cb_t
this.cb_u=create cb_u
this.cb_v=create cb_v
this.cb_w=create cb_w
this.cb_x=create cb_x
this.cb_i=create cb_i
this.cb_j=create cb_j
this.cb_k=create cb_k
this.cb_l=create cb_l
this.cb_m=create cb_m
this.cb_n=create cb_n
this.cb_o=create cb_o
this.cb_p=create cb_p
this.cb_h=create cb_h
this.cb_g=create cb_g
this.cb_f=create cb_f
this.cb_e=create cb_e
this.cb_d=create cb_d
this.cb_c=create cb_c
this.cb_b=create cb_b
this.cb_a=create cb_a
this.dw_misc=create dw_misc
this.sle_title=create sle_title
this.dw_object=create dw_object
this.dw_unit_list=create dw_unit_list
this.lb_1=create lb_1
this.sle_lot=create sle_lot
this.sle_numberof=create sle_numberof
this.sle_qty=create sle_qty
this.sle_operator=create sle_operator
this.cb_exit=create cb_exit
this.cb_audit_trail=create cb_audit_trail
this.cb_complete=create cb_complete
this.cb_pallet=create cb_pallet
this.cb_notes=create cb_notes
this.gb_pallet=create gb_pallet
this.gb_qty=create gb_qty
this.gb_operator=create gb_operator
this.gb_numberof=create gb_numberof
this.gb_parts=create gb_parts
this.gb_lot=create gb_lot
this.gb_dwbox=create gb_dwbox
this.gb_location_to=create gb_location_to
this.gb_packaging=create gb_packaging
this.sle_machine=create sle_machine
this.gb_machine=create gb_machine
this.gb_unit=create gb_unit
this.st_1=create st_1
this.dw_limit_locs=create dw_limit_locs
this.Control[]={this.sle_unit,&
this.lb_list,&
this.sle_packaging,&
this.sle_part,&
this.sle_location_to,&
this.dw_pallets,&
this.st_pallet,&
this.sle_pallet,&
this.cb_pallet_label,&
this.st_2,&
this.em_1,&
this.dw_transactions,&
this.sle_status,&
this.cb_back,&
this.lb_unit_list,&
this.cb_space,&
this.cb_45,&
this.dw_1,&
this.cb__,&
this.cb_period,&
this.cb_-,&
this.cb_0,&
this.cb_clear,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_y,&
this.cb_z,&
this.cb_enter,&
this.cb_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.cb_5,&
this.cb_q,&
this.cb_r,&
this.cb_s,&
this.cb_t,&
this.cb_u,&
this.cb_v,&
this.cb_w,&
this.cb_x,&
this.cb_i,&
this.cb_j,&
this.cb_k,&
this.cb_l,&
this.cb_m,&
this.cb_n,&
this.cb_o,&
this.cb_p,&
this.cb_h,&
this.cb_g,&
this.cb_f,&
this.cb_e,&
this.cb_d,&
this.cb_c,&
this.cb_b,&
this.cb_a,&
this.dw_misc,&
this.sle_title,&
this.dw_object,&
this.dw_unit_list,&
this.lb_1,&
this.sle_lot,&
this.sle_numberof,&
this.sle_qty,&
this.sle_operator,&
this.cb_exit,&
this.cb_audit_trail,&
this.cb_complete,&
this.cb_pallet,&
this.cb_notes,&
this.gb_pallet,&
this.gb_qty,&
this.gb_operator,&
this.gb_numberof,&
this.gb_parts,&
this.gb_lot,&
this.gb_dwbox,&
this.gb_location_to,&
this.gb_packaging,&
this.sle_machine,&
this.gb_machine,&
this.gb_unit,&
this.st_1,&
this.dw_limit_locs}
end on

on w_job_complete.destroy
destroy(this.sle_unit)
destroy(this.lb_list)
destroy(this.sle_packaging)
destroy(this.sle_part)
destroy(this.sle_location_to)
destroy(this.dw_pallets)
destroy(this.st_pallet)
destroy(this.sle_pallet)
destroy(this.cb_pallet_label)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.dw_transactions)
destroy(this.sle_status)
destroy(this.cb_back)
destroy(this.lb_unit_list)
destroy(this.cb_space)
destroy(this.cb_45)
destroy(this.dw_1)
destroy(this.cb__)
destroy(this.cb_period)
destroy(this.cb_-)
destroy(this.cb_0)
destroy(this.cb_clear)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_y)
destroy(this.cb_z)
destroy(this.cb_enter)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_q)
destroy(this.cb_r)
destroy(this.cb_s)
destroy(this.cb_t)
destroy(this.cb_u)
destroy(this.cb_v)
destroy(this.cb_w)
destroy(this.cb_x)
destroy(this.cb_i)
destroy(this.cb_j)
destroy(this.cb_k)
destroy(this.cb_l)
destroy(this.cb_m)
destroy(this.cb_n)
destroy(this.cb_o)
destroy(this.cb_p)
destroy(this.cb_h)
destroy(this.cb_g)
destroy(this.cb_f)
destroy(this.cb_e)
destroy(this.cb_d)
destroy(this.cb_c)
destroy(this.cb_b)
destroy(this.cb_a)
destroy(this.dw_misc)
destroy(this.sle_title)
destroy(this.dw_object)
destroy(this.dw_unit_list)
destroy(this.lb_1)
destroy(this.sle_lot)
destroy(this.sle_numberof)
destroy(this.sle_qty)
destroy(this.sle_operator)
destroy(this.cb_exit)
destroy(this.cb_audit_trail)
destroy(this.cb_complete)
destroy(this.cb_pallet)
destroy(this.cb_notes)
destroy(this.gb_pallet)
destroy(this.gb_qty)
destroy(this.gb_operator)
destroy(this.gb_numberof)
destroy(this.gb_parts)
destroy(this.gb_lot)
destroy(this.gb_dwbox)
destroy(this.gb_location_to)
destroy(this.gb_packaging)
destroy(this.sle_machine)
destroy(this.gb_machine)
destroy(this.gb_unit)
destroy(this.st_1)
destroy(this.dw_limit_locs)
end on

event close;IF i_b_winwedge THEN &
	ExecRemote ( "{APPEXIT}", "WinWedge", i_s_commport )
end event

type sle_unit from singlelineedit within w_job_complete
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=1682
int Y=928
int Width=293
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;IF ib_Forward THEN
	ib_Forward = FALSE
	IF Text = "" THEN
		MessageBox ( "Error", "Invalid unit of measure!", StopSign! )
		SetFocus ( )
	ELSE
		cb_complete.SetFocus ( )
	END IF
ELSEIF ib_Back THEN
	ib_Back = FALSE
	sle_qty.SetFocus ( )
END IF
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

type lb_list from u_it_list_box within w_job_complete
int X=1225
int Y=912
int Width=750
int Height=768
int TabOrder=0
boolean Visible=false
end type

type sle_packaging from singlelineedit within w_job_complete
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=18
int Y=704
int Width=914
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

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

event ue_validate;String	s_Part, &
			ls_PackageType
Dec		dec_StdPack

ls_PackageType = Text

IF ib_Forward THEN

	ib_Forward = FALSE

	If ls_PackageType <> "" Then
		
		s_Part = sle_part.Text
	
		SELECT part_packaging.quantity  
		  INTO :dec_StdPack  
		  FROM part_packaging  
		 WHERE ( part_packaging.part = :s_Part ) AND  
		       ( part_packaging.code = :Text )   ;
			
		If SQLCA.SQLCode <> 0 Then
	
			f_beep ( 5 )
	
			MessageBox ( "Error", "Invalid package type!", StopSign! )
			Text = ""
			SetFocus ( )
		
		Else
	
			dw_misc.SetItem ( 1, "standard_pack", dec_StdPack )
			//If f_get_string_value ( sle_qty.Text ) = "" Then &
				sle_qty.Text = String ( dec_StdPack )
	
			sle_lot.SetFocus ( )
	
		End if

	Else

		sle_lot.SetFocus ( )

	End if

ELSEIF ib_Back THEN

	ib_Back = FALSE
	sle_part.SetFocus ( )

END IF
end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_last = GetFocus ( )
is_Field = "packaging"
wf_change_color_focus ( )
lb_list.Hide ( )
if lb_list.uf_setup ( "part_packaging", "code", x, y, height, 1150, TextSize, width, "part", sle_part.Text, lb_unit_list, dw_limit_locs ) > 0 then &
	lb_list.Show ( )

end event

event modified;ib_forward = true
TriggerEvent ( "ue_validate" )
end event

type sle_part from singlelineedit within w_job_complete
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=18
int Y=480
int Width=1573
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_key;boolean	l_b_shift

if KeyDown ( keyShift! ) Then l_b_shift = TRUE
if bPopulateParts Then 
	if key = keyTab! or key = keyEnter! then
		if l_b_shift then
			ib_back = TRUE
			TriggerEvent ( "ue_validate" )
		else
			Text = lb_list.uf_get_current_item ( Text )
			lb_list.Hide ( )
			ib_Forward = TRUE
			TriggerEvent ( "ue_validate" )
		end if
	else
		lb_list.uf_find_item ( Text )
	end if
Else
	if key = keytab! or key = keyenter! then
		if l_b_shift then
			ib_back = TRUE
			TriggerEvent ( "ue_validate" )
		else
			ib_forward = TRUE
			TriggerEvent ( "ue_validate" )
		end if
	end if
End if

end event

event ue_validate;String	s_Temp, &
	s_TempPackaging,&
	ls_primarylocation,&
	l_s_trans_code,&
	l_s_part
Int	i_RtnCode

IF ib_Forward THEN
	l_s_part = Upper ( sle_part.Text )
	sle_part.Text = l_s_part
	SELECT	part.class  
	INTO	:s_Temp
	FROM	part  
	WHERE	part.part = :l_s_part  ;
	If SQLCA.SQLCode <> 0 Or s_Temp <> 'M' Or sle_part.Text = "" Then 
		f_beep ( 5 )
		If Not bPopulateParts Then
			i_RtnCode = MessageBox ( "Error", "Invalid part number! Would you like to use drop down list?", Question!, YesNo!, 1 )
			If i_RtnCode = 1 Then
				bPopulateParts = True
				lb_list.uf_setup ( "part", "part", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs )
				lb_list.Show ( )
			End if
		Else
			MessageBox ( "Error", "Invalid part number!  Please select a valid one from the list.", StopSign! )
		End if
		sle_part.Text = ""
		sle_packaging.Text = ''
		ib_Forward = FALSE
		SetFocus ( )
	Else
		dw_misc.SetTransObject ( sqlca )
		dw_misc.Retrieve ( sle_part.Text )
		dw_misc.SetItem ( 1, "standard_pack", "" )
		wf_get_unit_list ( sle_part.Text, "" )
		s_TempPackaging = ""
		If sle_packaging.Text <> "" Then s_TempPackaging = sle_packaging.Text
		SELECT	primary_location
		INTO	:ls_PrimaryLocation  
		FROM	part_inventory
		WHERE	part = :Text   ;

		If SQLCA.SQLCode = 0 And f_get_string_value ( ls_PrimaryLocation ) <> "" Then
			If dw_limit_locs.RowCount ( ) > 0 Then
				l_s_trans_code = LeftA ( stParm.Value1, 1 )
				if isnull(l_s_trans_code) or l_s_trans_code='' then l_s_trans_code = 'J'
				SELECT	code  
				INTO	:s_Temp  
				FROM	location,   
					location_limits  
				WHERE 	( code = location_code ) and  
					( ( location_code = :s_Temp ) AND  
					( trans_code = :l_s_trans_code ) ) ;
				if sqlca.sqlcode = 0 then
					sle_location_to.Text = ls_PrimaryLocation
				end if
			Else
				sle_location_to.Text = ls_PrimaryLocation
			End if
		End if
		ib_Forward = FALSE
		sle_packaging.SetFocus ( )
	End if
ELSEIF ib_Back THEN
	ib_Back = FALSE
	sle_machine.SetFocus ( )
END IF

end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
is_Field = "part"
igo_last = GetFocus ( )
wf_change_color_focus ( )
if text = '' then text = szpart
lb_list.Hide ( )
If bPopulateParts Then 
	if lb_list.uf_setup ( "part", "part", x, y, height, 1150, TextSize, width, 'class', 'M', lb_unit_list, dw_limit_locs ) > 0 then &
		lb_list.Show ( )
End if
end event

event modified;ib_forward = true
if NOT bPopulateParts then
	TriggerEvent ( "ue_validate" )
end if
end event

type sle_location_to from singlelineedit within w_job_complete
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=841
int Y=256
int Width=750
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_key;boolean	l_b_shift

if KeyDown ( keyShift! ) Then l_b_shift = TRUE
if bPopulateLocations Then 
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
Else
	if key = keytab! or key = keyenter! then
		if l_b_shift then
			ib_back = TRUE
			TriggerEvent ( "ue_validate" )
		else
			ib_forward = TRUE
			TriggerEvent ( "ue_validate" )
		end if
	end if
End if

end event

event ue_validate;//	Declarations
String	s_Temp,&
	l_s_trans_code
Int	i_RtnCode

//	Check the movement (forward or backword)
If ib_Forward Then
	//	Assign location to var
	s_Temp = sle_location_to.Text
	
	//	Check if limit locations dw is populated
	If dw_limit_locs.RowCount ( ) > 0 Then
		//	Get the trans code
		if isnull(l_s_trans_code) or l_s_trans_code='' then l_s_trans_code = 'J'
		SELECT	code  
		INTO	:s_Temp  
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :s_Temp ) AND  
			( trans_code = :l_s_trans_code ) AND  
			( type = 'MC' ) ;
	Else
		//	Check location code in location table
		SELECT	code
		INTO	:s_Temp  
		FROM	location 
		WHERE	code = :s_Temp;
	End if
	//	Check sql status
	If SQLCA.SQLCode <> 0 Then
		f_beep ( 5 )
		If Not bPopulateLocations Then
			i_RtnCode = MessageBox ( "Error", "Invalid location! Would you like to use drop down list?", Question!, YesNo!, 1 )
			If i_RtnCode = 1 Then
				bPopulateLocations = True
				lb_list.uf_setup ( "location", "code", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs )
				lb_list.Show ( )
			End if
		Else
			MessageBox ( "Error", "Invalid location!  Please select a valid one from the list.", StopSign! )
		End if
		sle_location_to.Text = ""
		ib_Forward = FALSE
		SetFocus ( )
	Else
		ib_Forward = FALSE
		sle_operator.SetFocus ( )
	End if
Elseif ib_Back Then
	ib_Back = FALSE
	sle_lot.SetFocus ( )
End if

end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_last = GetFocus ( )
is_Field = "location"
wf_change_color_focus ( )
lb_list.Hide ( )
If bPopulateLocations Then 
	if lb_list.uf_setup ( "location", "code", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then &
		lb_list.Show ( )
End if

end event

type dw_pallets from datawindow within w_job_complete
int X=3209
int Y=2252
int Width=485
int Height=368
boolean Visible=false
string DataObject="d_pallet_array"
boolean LiveScroll=true
end type

type st_pallet from statictext within w_job_complete
int X=2981
int Y=624
int Width=288
int Height=80
boolean Visible=false
boolean Enabled=false
string Text="Pallet #:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_pallet from statictext within w_job_complete
int X=2025
int Y=916
int Width=361
int Height=76
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16777215
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_pallet_label from commandbutton within w_job_complete
int X=2025
int Y=1012
int Width=361
int Height=100
boolean Visible=false
string Text="Print"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long		ll_pos
String	szPalletLabel

SELECT report_library.object_name  
  INTO :szPalletLabel  
  FROM report_library  
 WHERE report_library.name = 'PALLET' ;

ll_pos = PosA ( sle_pallet.Text, "/" )

if ll_pos > 0 then
	OpenWithParm ( w_print_pallet_choice, sle_pallet.Text )
	stParm.Value1 = Message.StringParm
	if stParm.Value1 = "0" then return
else
	stParm.Value1 = sle_pallet.Text
end if

If IsNull(szPalletLabel) then
	stparm.value12 = 'NOLABEL'
Else
	stparm.value12 = 'PALLET'
End If

f_print_label ( stparm )

end event

type st_2 from statictext within w_job_complete
int X=608
int Y=3328
int Width=800
int Height=128
boolean Visible=false
boolean Enabled=false
string Text="Scan / Enter Serial Number To Show Audit Trail For Undo:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554560
long BackColor=12632256
long BorderColor=128
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_job_complete
int X=1440
int Y=3344
int Width=325
int Height=96
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
string Mask="##########"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_transactions from datawindow within w_job_complete
int X=3712
int Y=208
int Width=1856
int Height=480
boolean Visible=false
string DataObject="d_audit_trail_by_date"
boolean LiveScroll=true
end type

type sle_status from statictext within w_job_complete
int X=965
int Y=8
int Width=663
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

type cb_back from commandbutton within w_job_complete
int X=2194
int Y=1728
int Width=288
int Height=192
string Text="Back"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SingleLineEdit		sle_Current
DropDownListBox	ddlb_Current
CommandButton		cb_Current


If bMessage Then wf_hide_message ( )

IF ib_Notes THEN
	u_generic_it_note.mle_note.Text = LeftA ( u_generic_it_note.mle_note.Text, LenA ( u_generic_it_note.mle_note.Text ) - 1 )
ELSEIF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = LeftA ( u_audit_trail.sle_operator_password.Text, LenA ( u_audit_trail.sle_operator_password.Text ) - 1 )
ELSE
	ib_Forward = FALSE
	ib_Back = TRUE
	CHOOSE CASE TypeOf ( igo_Last )
		CASE DropDownListBox!
			lb_list.Hide ( )
			ddlb_Current = igo_Last
			ddlb_Current.PostEvent ( "ue_validate" )
		CASE SingleLineEdit!
			sle_Current = igo_Last
			sle_Current.PostEvent ( "ue_validate" )
		CASE CommandButton!
			cb_Current = igo_Last
			cb_Current.PostEvent ( "ue_validate" )
	END CHOOSE
END IF	


end event

type lb_unit_list from listbox within w_job_complete
int X=3200
int Y=400
int Width=384
int Height=656
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

type cb_space from commandbutton within w_job_complete
int X=1573
int Y=1728
int Width=288
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

type cb_45 from commandbutton within w_job_complete
int X=3712
int Y=32
int Width=453
int Height=160
boolean Visible=false
boolean Enabled=false
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_job_complete
int X=3744
int Y=704
int Width=2912
int Height=1152
boolean Visible=false
boolean LiveScroll=true
end type

type cb__ from commandbutton within w_job_complete
int X=1312
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

type cb_period from commandbutton within w_job_complete
int X=288
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

type cb_- from commandbutton within w_job_complete
int X=544
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

type cb_0 from commandbutton within w_job_complete
int X=32
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

type cb_clear from commandbutton within w_job_complete
int X=1861
int Y=1728
int Width=288
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
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = ""
ELSE
	CHOOSE CASE is_Field
		CASE "part"
			sle_part.Text = ""
			sle_part.SetFocus ( )
		CASE "location"
			sle_location_to.Text = ""
			sle_location_to.SetFocus ( )
		CASE "machine"
			szSelectedText = ""
			sle_machine.Text = ""
			sle_machine.SetFocus ( )
		CASE "qty"
			sle_qty.Text = ""
			sle_qty.SetFocus ( )
		CASE "numberof"
			sle_numberof.Text = ""
			sle_numberof.SetFocus ( )
		CASE "operator"
			sle_operator.Text = ""
			sle_operator.SetFocus ( )
		CASE "packaging"
			sle_packaging.Text = ""
			sle_packaging.SetFocus ( )
		CASE "lot"
			sle_lot.Text = ""
			sle_lot.SetFocus ( )
	END CHOOSE
END IF 
end event

type cb_9 from commandbutton within w_job_complete
int X=544
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

type cb_8 from commandbutton within w_job_complete
int X=288
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

type cb_7 from commandbutton within w_job_complete
int X=32
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

type cb_6 from commandbutton within w_job_complete
int X=544
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

type cb_y from commandbutton within w_job_complete
int X=800
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

type cb_z from commandbutton within w_job_complete
int X=1056
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

type cb_enter from commandbutton within w_job_complete
int X=2523
int Y=1728
int Width=325
int Height=192
string Text="Enter"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;DropDownListBox	ddlb_Current
SingleLineEdit		sle_Current
CommandButton		cb_Current

If bMessage Then wf_hide_message ( )

ib_Back = FALSE
ib_Forward = TRUE

CHOOSE CASE TypeOf ( igo_Last )
	CASE DropDownListBox!
		ib_enter = TRUE
		ddlb_Current = igo_Last
		ddlb_Current.PostEvent ( "ue_validate" )
	CASE SingleLineEdit!
		sle_Current = igo_Last
		sle_Current.PostEvent ( "ue_validate" )
		if lb_list.Visible then
			sle_current.Text = lb_list.uf_get_current_item ( sle_current.Text )
			lb_list.Hide ( )
		end if
	CASE CommandButton!
		cb_complete.TriggerEvent ( clicked! )
END CHOOSE

end event

type cb_1 from commandbutton within w_job_complete
int X=32
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

type cb_2 from commandbutton within w_job_complete
int X=288
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

type cb_3 from commandbutton within w_job_complete
int X=544
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

type cb_4 from commandbutton within w_job_complete
int X=32
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

type cb_5 from commandbutton within w_job_complete
int X=288
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

type cb_q from commandbutton within w_job_complete
int X=800
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

type cb_r from commandbutton within w_job_complete
int X=1056
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

type cb_s from commandbutton within w_job_complete
int X=1312
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

type cb_t from commandbutton within w_job_complete
int X=1568
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

type cb_u from commandbutton within w_job_complete
int X=1824
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

type cb_v from commandbutton within w_job_complete
int X=2080
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

type cb_w from commandbutton within w_job_complete
int X=2336
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

type cb_x from commandbutton within w_job_complete
int X=2592
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

type cb_i from commandbutton within w_job_complete
int X=800
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

type cb_j from commandbutton within w_job_complete
int X=1056
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

type cb_k from commandbutton within w_job_complete
int X=1312
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

type cb_l from commandbutton within w_job_complete
int X=1568
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

type cb_m from commandbutton within w_job_complete
int X=1824
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

type cb_n from commandbutton within w_job_complete
int X=2080
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

type cb_o from commandbutton within w_job_complete
int X=2336
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

type cb_p from commandbutton within w_job_complete
int X=2592
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

type cb_h from commandbutton within w_job_complete
int X=2592
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

type cb_g from commandbutton within w_job_complete
int X=2336
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

type cb_f from commandbutton within w_job_complete
int X=2080
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

type cb_e from commandbutton within w_job_complete
int X=1824
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

type cb_d from commandbutton within w_job_complete
int X=1568
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

type cb_c from commandbutton within w_job_complete
int X=1312
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

type cb_b from commandbutton within w_job_complete
int X=1056
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

type cb_a from commandbutton within w_job_complete
int X=800
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

type dw_misc from datawindow within w_job_complete
int X=1682
int Y=288
int Width=731
int Height=272
string DataObject="d_part_info_jc"
boolean Border=false
end type

on getfocus;If bMessage Then wf_hide_message ( )

//If stParm.Value1 = "Quality Control" Then
//
//	cStatus = Left ( dw_misc.GetItemString ( 1, "status" ), 1 )
//
//	If szOperator = "" Then
//		szField = "operator"
//		wf_set_focus ( )
//		Return
//	ElseIf cStatus <> 'A' And f_get_string_value ( mle_qc_notes.Text ) = "" Then
//		wf_reset_indicators ( )
//		szField = "qcnotes"
//		wf_set_focus ( )
//		//mle_qc_notes.SetFocus ( )
//	Else
//		szField = "serial"
//		wf_set_focus ( )
//		//sle_serial.SetFocus ( )
//	End if
//
//End if
end on

type sle_title from statictext within w_job_complete
int Width=2912
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Job Complete"
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

type dw_object from datawindow within w_job_complete
int X=3200
int Y=1488
int Width=480
int Height=356
boolean Visible=false
string DataObject="d_object_data"
boolean LiveScroll=true
end type

type dw_unit_list from datawindow within w_job_complete
int X=3200
int Y=1872
int Width=480
int Height=356
boolean Visible=false
string DataObject="d_unit_conversion_list_per_part"
boolean LiveScroll=true
end type

type lb_1 from listbox within w_job_complete
int X=3200
int Y=1088
int Width=480
int Height=356
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

type sle_lot from singlelineedit within w_job_complete
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=18
int Y=928
int Width=914
int Height=128
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;IF ib_Forward THEN

	ib_Forward = FALSE

	If bMandatoryLot And f_get_string_value ( Text ) = "" Then

		f_beep ( 5 )

		MessageBox ( "Error", "A material lot number is required to continue!", StopSign! )

		SetFocus ( )

	Else

		sle_location_to.SetFocus ( )

	End if

ELSEIF ib_Back THEN

	ib_Back = FALSE
	sle_packaging.SetFocus ( )

END IF

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
is_Field = "lot"
wf_change_color_focus ( )

end event

type sle_numberof from singlelineedit within w_job_complete
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=987
int Y=928
int Width=603
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on ue_validate;IF ib_Forward THEN
	If Dec ( sle_numberof.Text ) < 1 Then
		f_beep ( 5 )
		MessageBox ( "Error", "Number of objects must be greater than 0!", StopSign! )
		ib_Forward = FALSE
		SetFocus ( )
	ELSE
		ib_Forward = FALSE
		sle_qty.SetFocus ( )
	End if
ELSEIF ib_Back THEN
	ib_Back = FALSE
	sle_operator.SetFocus ( )
END IF
end on

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

type sle_qty from singlelineedit within w_job_complete
event ue_validate pbm_custom01
event ue_accept pbm_custom02
event ue_cancel pbm_custom03
event ue_key pbm_keyup
int X=1696
int Y=708
int Width=672
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;String ls_ddarequired='N'

IF ib_Forward THEN
//	If Dec ( sle_qty.Text ) <= 0 Then
		SELECT dda_required
		  INTO :ls_ddarequired
		  FROM parameters ;
	
		If ls_ddarequired = 'Y' then 
	// below 8 lines inc by gph on 7/17/97 for dda		
			st_prmlst.s_arg_part   = sle_part.text
			st_prmlst.s_arg_module = sle_unit.text
			st_prmlst.s_rtn_qtystr = szdimensionqtystring
			st_prmlst.s_rtn_qty    = Dec(sle_qty.text) 
			st_prmlst.s_varying_dim= li_nonconstantdim
			Openwithparm(w_dda,st_prmlst)
			st_prmlst = Message.PowerObjectparm
			szdimensionqtystring = st_prmlst.s_rtn_qtystr
		   sle_qty.text         = String(st_prmlst.s_rtn_qty)
			li_nonconstantdim		= st_prmlst.s_varying_dim 

		End if 
		
		If Dec ( sle_qty.Text ) <= 0 then 
			f_beep ( 5 )
			MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
			ib_Forward = FALSE
			SetFocus ( )
		Else
			ib_Forward = FALSE
			sle_unit.SetFocus ( )
		End if 	
//	Else
//		ib_Forward = FALSE
//		sle_unit.SetFocus ( )
//	End if
	
ELSEIF ib_Back THEN
	ib_Back = FALSE
	sle_numberof.SetFocus ( )
END IF

//IF ib_Forward THEN
//	If Dec ( sle_qty.Text ) <= 0 Then
//		
//// below 8 lines inc by gph on 7/17/97 for dda		
//		st_prmlst.s_arg_part   = sle_part.text
//		st_prmlst.s_arg_module = sle_unit.text
//		st_prmlst.s_rtn_qtystr = szdimensionqtystring
//		st_prmlst.s_rtn_qty    = Dec(sle_qty.text) 
//		st_prmlst.s_varying_dim= li_nonconstantdim
//		Openwithparm(w_dda,st_prmlst)
//		st_prmlst = Message.PowerObjectparm
//		szdimensionqtystring = st_prmlst.s_rtn_qtystr
//	   sle_qty.text         = String(st_prmlst.s_rtn_qty)
//		li_nonconstantdim		= st_prmlst.s_varying_dim 
//		
//		If Dec ( sle_qty.Text ) <= 0 then 
//			f_beep ( 5 )
//			MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
//			ib_Forward = FALSE
//			SetFocus ( )
//		Else
//			ib_Forward = FALSE
//			sle_unit.SetFocus ( )
//		End if 	
//	Else
//		ib_Forward = FALSE
//		sle_unit.SetFocus ( )
//	End if
//ELSEIF ib_Back THEN
//	ib_Back = FALSE
//	sle_numberof.SetFocus ( )
//END IF
end event

event ue_accept;
end event

on ue_cancel;ib_Auto = FALSE
sle_qty.Text = ""
sle_qty.SetFocus ( )

end on

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

type sle_operator from singlelineedit within w_job_complete
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=987
int Y=704
int Width=603
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
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;If ib_Forward THEN

	szOperator = ""

	SELECT employee.operator_code  
	  INTO :szOperator  
	  FROM employee  
	 WHERE employee.password = :sle_operator.Text   ;

	szOperator = f_get_string_value ( szOperator )

	If SQLCA.SQLCode = 0 Then
	
		gb_operator.Text = "Operator - " + szOperator
		ib_Forward = FALSE
		sle_numberof.SetFocus ( )

	Else

		f_beep ( 5 )

		gb_operator.Text = "Operator -"
		MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
		sle_operator.Text = ""
		ib_Forward = FALSE
		SetFocus ( )

	End if

ELSEIF ib_Back THEN

	ib_Back = FALSE
	sle_location_to.SetFocus ( )

END IF

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

event modified;ib_forward = true
TriggerEvent ( "ue_validate" )
end event

type cb_exit from commandbutton within w_job_complete
int X=2450
int Y=160
int Width=453
int Height=160
string Text="Exit"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;IF is_Transaction > '' THEN
	IF MessageBox ( "Exit", "Are you sure you want to exit?", Question!, YesNo!, 2 ) = 1 THEN
		Halt
	END IF
ELSE
	Close ( Parent )
END IF

end on

on getfocus;//bExit = True
end on

type cb_audit_trail from commandbutton within w_job_complete
int X=2450
int Y=320
int Width=453
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

str_Parm.adt_Today = dtToday
str_Parm.as_TransactionType = "JC"
str_Parm.as_Machine = sle_machine.Text

wf_disable_screen ( )

OpenUserObjectWithParm ( u_audit_trail, str_Parm, 55, 150 )
u_audit_trail.BringToTop = TRUE
end event

type cb_complete from commandbutton within w_job_complete
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=2450
int Y=480
int Width=453
int Height=160
string Text="Complete"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;IF ib_Forward THEN
	ib_Forward = FALSE
//	SetFocus ( )
	TriggerEvent ( clicked! )
ELSEIF ib_Back THEN
	ib_Back = FALSE
	sle_Unit.SetFocus ( )
END IF
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

event clicked;DropDownListBox	ddlb_Current
SingleLineEdit		sle_Current

SetPointer ( HourGlass! )

bAction = True

wf_disable_screen ( )

If wf_job_complete ( ) AND NOT ib_Auto Then
	if i_b_clear then
		sle_part.Text = ""
		sle_packaging.Text = ""
		sle_numberof.Text = "1"
		sle_qty.Text = ""
		// inc on 6/30/99 4.59 pm 
		sle_machine.text=""
		sle_location_to.text=""
		sle_lot.text=""
		sle_unit.text=""
		bOpen = True
		wf_enable_screen ( )
//		sle_part.Setfocus ( )
		// inc on 6/30/99 4.59 pm 
		sle_machine.Setfocus( )
	else
		wf_enable_screen ( )
	end if
Elseif ib_Auto Then
	wf_enable_screen ( )
	bAction = False
	szField = ""
	//gb_Cancel = FALSE
	//sle_qty.SetFocus ( )
	ib_Auto = FALSE
	Return
Else
	wf_enable_screen ( )
	CHOOSE CASE TypeOf ( igo_Last )
		CASE DropDownListBox!
			ddlb_Current = igo_Last
			ddlb_Current.SetFocus ( )
		CASE SingleLineEdit!
			sle_Current = igo_Last
			sle_Current.SetFocus ( )
	END CHOOSE	
End if

bAction = False

is_Notes = ""

end event

on getfocus;wf_reset_colors ( )
is_Field = "cb48"
igo_Last = GetFocus ( )
end on

type cb_pallet from commandbutton within w_job_complete
int X=2450
int Y=640
int Width=453
int Height=160
string Text="Pallet"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long						li_error
long						ll_new_row,&
							ll_palletserial,&
							li_count
string					ls_alt_part
st_generic_structure	lstr_parm

IF Text = "Clear Plt" THEN
	wf_setup_pallet ( FALSE )
	is_pallet_string = ""
ELSE
	IF f_get_string_value ( szOperator ) = "" THEN
		MessageBox ( "Error", "You must enter your operator password to continue with this operation!", StopSign! )
		wf_set_focus ( is_Field )
		Return
	END IF
	// location check was included on 9/28/98 
	IF f_get_string_value ( sle_location_to.text ) = "" THEN
		MessageBox ( "Error", "You must select a location to continue with this operation!", StopSign! )
		wf_set_focus ( is_Field )
		Return
	END IF

	//if f_get_string_value ( ddlb_parts.Text ) = "" then
	//	MessageBox ( "Error", "You must choose a valid part number to continue with this operation!", StopSign! )
	//	wf_set_focus ( is_Field )
	//	Return
	//end if

	SELECT count(*)  
	  INTO :li_count  
	  FROM alternative_parts  
	 WHERE alternative_parts.main_part = :sle_part.Text   ;

	if li_count > 0 then

		dw_pallets.Reset ( )

		 DECLARE alt_parts CURSOR FOR  
		  SELECT alternative_parts.alt_part  
		    FROM alternative_parts  
		   WHERE alternative_parts.main_part = :sle_part.Text   
		ORDER BY alternative_parts.alt_part ASC  ;

		lstr_parm.value1 = szoperator
		lstr_parm.value2 = sle_part.Text
		// included the 3rd argument as location as part of the structure
		lstr_parm.value3 = sle_location_to.text 

		OpenWithParm ( w_pallet, lstr_parm )
		il_PalletSerial = Message.DoubleParm
		ll_new_row = dw_pallets.InsertRow ( 0 )
		dw_pallets.SetItem ( ll_new_row, "part", lstr_parm.value2 )
		if il_PalletSerial > 0 then
			is_pallet_string = string ( il_PalletSerial )
			dw_pallets.SetItem ( ll_new_row, "pallet_number", il_PalletSerial )
		else
			is_pallet_string = ""
			dw_pallets.SetItem ( ll_new_row, "pallet_number", 0 )
		end if

		Open alt_parts;
		Fetch alt_parts into :ls_alt_part;
		Do While SQLCA.SQLCode = 0
			lstr_parm.value2 = ls_alt_part
			OpenWithParm ( w_pallet, lstr_parm )
			ll_PalletSerial = Message.DoubleParm
			ll_new_row = dw_pallets.InsertRow ( 0 )
			dw_pallets.SetItem ( ll_new_row, "part", lstr_parm.value2 )
			if ll_PalletSerial > 0 then
				if is_pallet_string = "" then
					is_pallet_string = string ( ll_palletserial )
				else
					is_pallet_string = is_pallet_string + "/" + string ( ll_palletserial )
				end if
				dw_pallets.SetItem ( ll_new_row, "pallet_number", ll_PalletSerial )
			else
				dw_pallets.SetItem ( ll_new_row, "pallet_number", 0 )
			end if
			Fetch alt_parts into :ls_alt_part;
		Loop
		Close alt_parts;
		wf_setup_pallet ( TRUE )
	else
		// included the parameters, changed from just operator to operator & location code
		lstr_parm.value1 = szoperator
		lstr_parm.value2 = ''
		lstr_parm.value3 = sle_location_to.text 
		// changed the parameter
		OpenWithParm ( w_pallet, lstr_parm )
		
		il_PalletSerial = Message.DoubleParm
		if il_PalletSerial < 0 then
			li_error = -1
		else
			li_error = il_PalletSerial
		end if

		IF li_error = -1 THEN
			MessageBox ( "Error", "Unable to create a new pallet!", StopSign! )
		ELSEIF li_error > 0 THEN
			wf_setup_pallet ( TRUE )
		END IF
	end if

END IF

Yield ( )
wf_set_focus ( is_Field )
end event

type cb_notes from commandbutton within w_job_complete
int X=2450
int Y=960
int Width=453
int Height=160
string Text="Notes"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//wf_disable_screen ( )
//wf_notes_attrib ( True )
ib_Notes = TRUE
wf_disable_except_buttons ( )
Parent.OpenUserObjectWithParm ( u_generic_it_note, is_Notes, 550, 200 )
u_generic_it_note.BringToTop = TRUE
IF is_Notes <> "" THEN u_generic_it_note.mle_note.Text = is_Notes
end on

type gb_pallet from groupbox within w_job_complete
int X=2016
int Y=864
int Width=389
int Height=272
boolean Visible=false
string Text="Pallet"
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

type gb_qty from groupbox within w_job_complete
int X=1664
int Y=640
int Width=768
int Height=224
string Text="Quantity"
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

type gb_operator from groupbox within w_job_complete
int X=969
int Y=640
int Width=640
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

type gb_numberof from groupbox within w_job_complete
int X=969
int Y=864
int Width=640
int Height=224
string Text="Number Of"
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

type gb_parts from groupbox within w_job_complete
int Y=416
int Width=1609
int Height=208
string Text="Part Number"
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

type gb_lot from groupbox within w_job_complete
int Y=864
int Width=960
int Height=224
string Text="Material Lot Number"
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

type gb_dwbox from groupbox within w_job_complete
int X=1664
int Y=192
int Width=768
int Height=448
string Text="Part Info"
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

type gb_location_to from groupbox within w_job_complete
int X=818
int Y=192
int Width=791
int Height=212
string Text="Location To"
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

type gb_packaging from groupbox within w_job_complete
int Y=640
int Width=960
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

type sle_machine from singlelineedit within w_job_complete
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=18
int Y=256
int Width=750
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_key;boolean 	l_b_shift

if KeyDown ( keyShift! ) then l_b_shift = TRUE

if bPopulateMachines Then 
	if key = keytab! or key = keyenter! then
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
Else
	if key = keytab! or key = keyenter! then
		if l_b_shift then
			ib_back = TRUE
			TriggerEvent ( "ue_validate" )
		else
			ib_forward = TRUE
			TriggerEvent ( "ue_validate" )
		end if
	end if
End if


end event

event ue_validate;//	Declare local variables
STRING	l_s_winwedge_loc,&
	l_s_winwedge_config,&
	s_Temp, &
	l_s_trans_code,&
	l_s_commport,&
	l_s_amount_field,&
	l_s_steady_field
int	l_i_port,&
	l_i_return,&
	l_i_amount_field,&
	l_i_steady_field

Int	i_RtnCode

IF ib_Forward THEN
	s_Temp = Text // get the selected machine into a var
	
	If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
		l_s_trans_code = LeftA ( stParm.Value1, 1 )
		if isnull(l_s_trans_code) or l_s_trans_code='' then l_s_trans_code = 'J'
		SELECT	code  
		INTO	:s_Temp  
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :s_Temp ) AND  
			( trans_code = :l_s_trans_code ) AND  
			( type = 'MC' ) ;
	Else
		SELECT	code  
		INTO	:s_Temp  
		FROM	location  
		WHERE	( code = :s_Temp ) AND  
			( type = 'MC' )   ;
	End if
	If SQLCA.SQLCode <> 0 Then
		f_beep ( 5 )
		If Not bPopulateMachines Then
			i_RtnCode = MessageBox ( "Error", "A valid machine is required! Would you like to use drop down list?", Question!, YesNo!, 1 )
			If i_RtnCode = 1 Then
				bPopulateMachines = True
				lb_list.uf_setup ( "location", "code", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs )
				lb_list.Show ( )
			End if
		Else
			MessageBox ( "Error", "A valid machine is required!  Please select a valid one from list.", StopSign! )
		End if
		ib_Forward = FALSE
		SetFocus ( )
	Else
		sle_location_to.Text = Text
		ib_Forward = FALSE
		sle_part.SetFocus ( )
	End if
ELSEIF ib_Back THEN
	ib_Back = FALSE
	SetFocus ( )
END IF
end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_last = GetFocus ( )
is_Field = "machine"
wf_change_color_focus ( )
if text = '' then text = szlocation
lb_list.Hide ( )
If bPopulateMachines Then 
	if lb_list.uf_setup ( "machine", "machine_no", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then &
		lb_list.Show ( )
End if


end event

type gb_machine from groupbox within w_job_complete
int Y=192
int Width=791
int Height=212
string Text="Machine Number"
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

type gb_unit from groupbox within w_job_complete
int X=1664
int Y=864
int Width=334
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

type st_1 from statictext within w_job_complete
int X=1723
int Y=16
int Width=1179
int Height=128
boolean Enabled=false
boolean BringToTop=true
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

type dw_limit_locs from datawindow within w_job_complete
int X=3205
int Y=16
int Width=480
int Height=356
boolean Visible=false
boolean BringToTop=true
string DataObject="d_limit_locs"
end type


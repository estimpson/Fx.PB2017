$PBExportHeader$w_material_issue.srw
forward
global type w_material_issue from Window
end type
type ddlb_finishedpart from dropdownlistbox within w_material_issue
end type
type sle_unit from singlelineedit within w_material_issue
end type
type lb_list from u_it_list_box within w_material_issue
end type
type sle_machine from singlelineedit within w_material_issue
end type
type dw_limit_locs from datawindow within w_material_issue
end type
type dw_transactions from datawindow within w_material_issue
end type
type lb_1 from listbox within w_material_issue
end type
type sle_status from statictext within w_material_issue
end type
type st_1 from statictext within w_material_issue
end type
type cb_57 from commandbutton within w_material_issue
end type
type lb_unit_list from listbox within w_material_issue
end type
type dw_unit_list from datawindow within w_material_issue
end type
type cb_55 from commandbutton within w_material_issue
end type
type sle_qty from singlelineedit within w_material_issue
end type
type cb_48 from commandbutton within w_material_issue
end type
type dw_object from datawindow within w_material_issue
end type
type sle_operator from singlelineedit within w_material_issue
end type
type sle_serial from singlelineedit within w_material_issue
end type
type cb_47 from commandbutton within w_material_issue
end type
type cb_46 from commandbutton within w_material_issue
end type
type cb_45 from commandbutton within w_material_issue
end type
type cb_44 from commandbutton within w_material_issue
end type
type cb_42 from commandbutton within w_material_issue
end type
type dw_1 from datawindow within w_material_issue
end type
type cb_41 from commandbutton within w_material_issue
end type
type cb_43 from commandbutton within w_material_issue
end type
type cb_40 from commandbutton within w_material_issue
end type
type cb_39 from commandbutton within w_material_issue
end type
type cb_38 from commandbutton within w_material_issue
end type
type cb_37 from commandbutton within w_material_issue
end type
type cb_36 from commandbutton within w_material_issue
end type
type cb_35 from commandbutton within w_material_issue
end type
type cb_34 from commandbutton within w_material_issue
end type
type cb_33 from commandbutton within w_material_issue
end type
type cb_32 from commandbutton within w_material_issue
end type
type cb_31 from commandbutton within w_material_issue
end type
type cb_30 from commandbutton within w_material_issue
end type
type cb_29 from commandbutton within w_material_issue
end type
type cb_28 from commandbutton within w_material_issue
end type
type cb_27 from commandbutton within w_material_issue
end type
type cb_26 from commandbutton within w_material_issue
end type
type cb_25 from commandbutton within w_material_issue
end type
type cb_24 from commandbutton within w_material_issue
end type
type cb_23 from commandbutton within w_material_issue
end type
type cb_22 from commandbutton within w_material_issue
end type
type cb_21 from commandbutton within w_material_issue
end type
type cb_20 from commandbutton within w_material_issue
end type
type cb_19 from commandbutton within w_material_issue
end type
type cb_18 from commandbutton within w_material_issue
end type
type cb_17 from commandbutton within w_material_issue
end type
type cb_16 from commandbutton within w_material_issue
end type
type cb_15 from commandbutton within w_material_issue
end type
type cb_14 from commandbutton within w_material_issue
end type
type cb_13 from commandbutton within w_material_issue
end type
type cb_12 from commandbutton within w_material_issue
end type
type cb_11 from commandbutton within w_material_issue
end type
type cb_10 from commandbutton within w_material_issue
end type
type cb_9 from commandbutton within w_material_issue
end type
type cb_8 from commandbutton within w_material_issue
end type
type cb_7 from commandbutton within w_material_issue
end type
type cb_6 from commandbutton within w_material_issue
end type
type cb_5 from commandbutton within w_material_issue
end type
type cb_4 from commandbutton within w_material_issue
end type
type cb_3 from commandbutton within w_material_issue
end type
type cb_2 from commandbutton within w_material_issue
end type
type cb_1 from commandbutton within w_material_issue
end type
type dw_misc from datawindow within w_material_issue
end type
type sle_title from statictext within w_material_issue
end type
type gb_qty from groupbox within w_material_issue
end type
type gb_serial_number from groupbox within w_material_issue
end type
type gb_unit from groupbox within w_material_issue
end type
type gb_operator from groupbox within w_material_issue
end type
type gb_machine from groupbox within w_material_issue
end type
type gb_dwbox from groupbox within w_material_issue
end type
type mle_notes from multilineedit within w_material_issue
end type
type notes_dwbox from groupbox within w_material_issue
end type
end forward

global type w_material_issue from Window
int X=0
int Y=0
int Width=6679
int Height=3452
boolean TitleBar=true
string Title="Material Issue"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
string Icon="mit.ico"
event undo pbm_custom01
event ue_close_audit_trail pbm_custom04
event ue_close_uo_note pbm_custom05
event ue_save_note pbm_custom06
event ue_return_value ( string a_s_return_value )
ddlb_finishedpart ddlb_finishedpart
sle_unit sle_unit
lb_list lb_list
sle_machine sle_machine
dw_limit_locs dw_limit_locs
dw_transactions dw_transactions
lb_1 lb_1
sle_status sle_status
st_1 st_1
cb_57 cb_57
lb_unit_list lb_unit_list
dw_unit_list dw_unit_list
cb_55 cb_55
sle_qty sle_qty
cb_48 cb_48
dw_object dw_object
sle_operator sle_operator
sle_serial sle_serial
cb_47 cb_47
cb_46 cb_46
cb_45 cb_45
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
gb_qty gb_qty
gb_serial_number gb_serial_number
gb_unit gb_unit
gb_operator gb_operator
gb_machine gb_machine
gb_dwbox gb_dwbox
mle_notes mle_notes
notes_dwbox notes_dwbox
end type
global w_material_issue w_material_issue

type variables
string			is_field
st_generic_structure 	stParm
Int 			iThisInstance
Int 			iddlbIndex
Int			iHandle
Boolean			ib_forward,&
			ib_back,&
			ib_enter
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
Boolean 			bMandatoryLot
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
GraphicObject		igo_last

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
public subroutine wf_set_dw_position (datawindow dw, int x, int y, int height, int width, string data_object, boolean h_scroll, boolean v_scroll)
public subroutine wf_reset_indicators ()
public subroutine wf_set_em_position (editmask em, int x, int y, boolean spin_control)
public subroutine wf_enable_screen ()
public subroutine wf_disable_screen ()
public subroutine wf_set_focus ()
public subroutine wf_get_unit_list (string szpartnumber, string szoriginalunit)
public subroutine wf_loop_for_avail_units (string szunit, int iorder)
public subroutine wf_reset_colors ()
public subroutine wf_change_color_focus ()
public function string wf_get_character ()
public function boolean wf_valid_key ()
public subroutine wf_show_message ()
public subroutine wf_hide_message ()
public function boolean wf_material_issue ()
public function boolean wf_delete_audit_trail (long ll_serial)
public function boolean wf_create_object (long ll_serial, datetime ldt_date, string ls_operator)
public function boolean wf_update_onhand (long ll_serial, string ls_mode)
public function boolean wf_delete_object (long ll_serial)
public function boolean wf_add_to_object (long ll_serial, decimal ld_qty, decimal ld_stdqty, decimal ld_objectqty, decimal ld_objectstdqty, string ls_operator)
public subroutine wf_disable_except_buttons ()
public subroutine wf_enable_except_buttons ()
public subroutine wf_breakupdimqty (string sz_originalstr)
public subroutine wf_getfp ()
end prototypes

event undo;String			ls_Part
String 			ls_Type
String			ls_Operator
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

String         ls_dim_qty_str
String         ls_curdimqtystr
String         ls_newdimstr
Dec            d_storedno[]
Int            i_start
Int            i_pos
Int            i_currow
Int            i_len

//  Initialize variables

il_AuditRow = u_audit_trail.dw_audit_trail.GetRow ( )

ls_Type 		= u_audit_trail.dw_audit_trail.GetItemString ( il_AuditRow, "type" )
ldt_Date		= u_audit_trail.dw_audit_trail.GetItemDateTime ( il_AuditRow, "date_stamp" )
ll_Serial 	= u_audit_trail.dw_audit_trail.GetItemNumber ( il_AuditRow, "serial" )
ld_Qty 		= u_audit_trail.dw_audit_trail.GetItemNumber ( il_AuditRow, "quantity" )
ld_StdQty 	= u_audit_trail.dw_audit_trail.GetItemNumber ( il_AuditRow, "std_quantity" )
ls_Part		= u_audit_trail.dw_audit_trail.GetItemString ( il_AuditRow, "part" )

//
select dim_qty_string_other,
       varying_dimension_code
  into :ls_dim_qty_str,
       :llnonconstantdim
  from audit_trail
 where serial   = :ll_serial
	and quantity = :ld_Qty
   and type     = 'M' ; 

// retrieving the data back from the string
i_len = len(trim(ls_dim_qty_str))
If i_len > 0 then 
	i_currow = 0 
	i_start = 1
	Do
		i_pos = pos(ls_dim_qty_str,',',i_start)
		If i_pos <= 0 then 
			Exit
		End if 
		i_pos -- 
		i_currow ++ 
		d_storedno[i_currow] = dec(mid(ls_dim_qty_str,i_start,i_pos))
	   i_pos += 2
		i_start = i_pos 
	Loop While (true)
	i_pos = (i_len + 1) - i_start
	i_currow ++ 
	d_storedno[i_currow] = dec(mid(ls_dim_qty_str,i_start,i_pos))
end if 

//  Prompt for operator and loop until value returned

bFinish = False

stProgressParm.Title = "Undo Material Issue"
stProgressParm.Cancel_window = This

OpenWithParm ( w_progress, stProgressParm )

iCounter++
w_progress.wf_progress ( iCounter / 4, "Searching for object..." )

ls_curdimqtystr=''

SELECT object.quantity,
		 object.std_quantity,
		 object.dimension_qty_string
  INTO :ld_ObjectQty,
		 :ld_ObjectStdQty,
		 :ls_curdimqtystr
  FROM object  
 WHERE object.serial = :ll_Serial   ;

// delete this line later & the variable should be populated in a dif
// place

//llnonconstantdim = 1
ls_newdimstr=''
i_len = len(trim(ls_curdimqtystr))
If i_len > 0 then 
	i_currow = 0 
	i_start = 1
	Do
		i_pos = pos(ls_curdimqtystr,',',i_start)
		If i_pos <= 0 then 
			Exit
		End if 
		i_pos -- 
		i_currow ++ 
		if i_currow = llnonconstantdim  then 
			d_storedno[i_currow] += dec(mid(ls_curdimqtystr,i_start,i_pos))
		else	
			d_storedno[i_currow] = dec(mid(ls_curdimqtystr,i_start,i_pos))			
		end if 	
		ls_newdimstr += trim(string(d_storedno[i_currow]))+','
	   i_pos += 2
		i_start = i_pos 
	Loop While (true)
	i_pos = (i_len + 1) - i_start
	i_currow ++ 
	if i_currow = llnonconstantdim then
		d_storedno[i_currow] += dec(mid(ls_curdimqtystr,i_start,i_pos))
	else
		d_storedno[i_currow] = dec(mid(ls_curdimqtystr,i_start,i_pos))		
	end if 	
	ls_newdimstr += trim(string(d_storedno[i_currow]))
end if 

iCounter++
w_progress.wf_progress ( iCounter / 4, "Reconciling object..." )

If SQLCA.SQLCode = 0 Then
	If Not wf_add_to_object ( ll_Serial, ld_Qty, ld_StdQty, ld_ObjectQty, ld_ObjectStdQty, ls_Operator ) Then
		RollBack ;
		Close ( w_progress )
		MessageBox ( "Error", "Unable to return object to inventory!", StopSign! )
		Return
	End if
Else
	If Not wf_create_object ( ll_Serial, ldt_Date, ls_Operator ) Then
		RollBack ;
		Close ( w_progress )
		MessageBox ( "Error", "Unable to re-create object in inventory!", StopSign! )
		Return
	End if
End if

iCounter++
w_progress.wf_progress ( iCounter / 4, "Updating on hand..." )

ld_NewOnHand = f_update_onhand ( ls_Part, ld_StdQty, "+*" )
If ld_NewOnHand = -1 Then
	RollBack ;
	Close ( w_progress )
	MessageBox ( "Error", "Unable to update on hand!", StopSign! )
	Return
End if

ls_curdimqtystr = ls_newdimstr 

update object 
   set object.dimension_qty_string = :ls_curdimqtystr
 where (object.serial = :ll_serial) ;
 
If sqlca.sqlcode = -1 Then
	RollBack ;
	Close ( w_progress )
	MessageBox ( "Error", "Unable to update dimension data", StopSign! )
	Return
End if

iCounter++
w_progress.wf_progress ( iCounter / 4, "Deleting audit trail..." )

DELETE FROM audit_trail  
 WHERE ( serial = :ll_Serial ) AND  
       ( date_stamp = :ldt_Date )   ;

If SQLCA.SQLCode <> 0 Then
	RollBack ;
	Close ( w_progress )
	MessageBox ( "Error", "Unable to delete audit trail!", StopSign! )
	Return
End if

Commit ;

Close ( w_progress )

u_audit_trail.dw_audit_trail.SetTransObject ( sqlca )

If u_audit_trail.dw_audit_trail.DataObject = "d_generic_audit_trail_undo_mi" Then
	u_audit_trail.dw_audit_trail.Retrieve ( "M", ll_Serial )
Else
	u_audit_trail.dw_audit_trail.Retrieve ( dtToday, ls_Type, sle_machine.Text )
End if

u_audit_trail.SetRedraw ( TRUE )
end event

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
	Case "machine"
		sle_machine.Text = a_s_return_value
		sle_machine.TriggerEvent ( "ue_validate" )
	Case "unit"
		sle_unit.Text = a_s_return_value
		sle_unit.TriggerEvent ( "ue_validate" )
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
ELSEIF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = u_audit_trail.sle_operator_password.Text + cCharacter
ELSE
	Choose Case is_field
		Case "operator"
			sle_operator.Text = sle_operator.Text + cCharacter
			sle_operator.SetFocus ( )
		Case "serial"
			sle_serial.Text = sle_serial.Text + cCharacter
			sle_serial.SetFocus ( )
		Case "machine"
			sle_machine.Text = sle_machine.Text + cCharacter
			szPreviousText = sle_machine.Text
			If bPopulateMachines Then 
//				if lb_list.uf_setup ( "location", "code", sle_machine.x, sle_machine.y, sle_machine.height, 1150, sle_machine.TextSize, sle_machine.width, '', '', lb_unit_list ) > 0 then &
				if lb_list.uf_setup ( "machine", "machine_no", x, y, height, 1150, sle_machine.TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then &	
					lb_list.Show ( )
			End if
			sle_machine.SetFocus ( )
			lb_list.uf_find_item ( sle_machine.Text )
		Case "unit"
			sle_unit.Text = sle_unit.Text + cCharacter
			sle_unit.SetFocus ( )
			lb_list.uf_find_item ( sle_unit.Text )
		Case "quantity"
			sle_qty.Text = sle_qty.Text + cCharacter
			sle_qty.SetFocus ( )
	End Choose
END IF
end subroutine

public subroutine wf_setup_screen ();/*  Declare Variables  */

dw_misc.SetTransObject ( sqlca )

String 	szNull
String 	cPopParts
String	cPopLocations
String	cPopMachines
String	cMandatoryQCNotes
String	cJCNumberOfMode
String	cJCQtyMode
String	cJCLotMode
String	cJCUnitMode
String	cMIUnitMode
String	cBONumberOfMode
String	cBOUnitMode
String	cDeleteScrap
Int		iTabSeq

SetNull ( szNull )


SELECT populate_machines
  INTO :cPopMachines
  FROM parameters  ;

If cPopMachines = 'Y' Then bPopulateMachines = True

bOpen = True

SELECT inventory_parameters.mi_unit
  INTO :cMIUnitMode
  FROM inventory_parameters  ;

If cMIUnitMode = 'R' Then bMIUnitMode = True

/*  Main  */

if isvalid ( stparm ) then
	sle_serial.Text = stParm.Value2
	sle_serial.TriggerEvent ( Modified! )
end if

If szMachineParm = "" Then
	sle_machine.SetFocus ( )
Else
	sle_machine.Text = szMachineParm
	sle_operator.SetFocus ( )
End if


end subroutine

public subroutine wf_set_dw_position (datawindow dw, int x, int y, int height, int width, string data_object, boolean h_scroll, boolean v_scroll);dw.DataObject = data_object
dw.x = x
dw.y = y
dw.Height = height
dw.Width = width
dw.VScrollBar = v_scroll
dw.HScrollBar = h_scroll
dw.Visible = True
end subroutine

public subroutine wf_reset_indicators ();bOperator 		= False
bSerialNumber 	= False
bLocationTo 	= False
bLocationFrom 	= False
bParts 			= False
bMachines 		= False
bQty 				= False
bLot 				= False
bNumberOf 		= False
bUnits 			= False
bPackaging 		= False
bCombineSerial = False
bCB48 			= False
bQCNotes 		= False

wf_reset_colors ( )
end subroutine

public subroutine wf_set_em_position (editmask em, int x, int y, boolean spin_control);em.x = x
em.y = y
em.Spin = spin_control
em.Visible = True
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
cb_45.Enabled = True
cb_46.Enabled = True
cb_47.Enabled = True
cb_48.Enabled = True
cb_43.Enabled = True
cb_30.Enabled = True
cb_37.Enabled = True
cb_38.Enabled = True
cb_55.Enabled = True
cb_57.Enabled = True
sle_operator.Enabled = True
dw_misc.Enabled = True
sle_serial.Enabled = True
sle_machine.Enabled = True
sle_qty.Enabled = True
sle_unit.Enabled = True
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
cb_45.Enabled = False
cb_46.Enabled = False
cb_47.Enabled = False
cb_48.Enabled = False
cb_43.Enabled = False
cb_30.Enabled = False
cb_37.Enabled = False
cb_38.Enabled = False
cb_55.Enabled = False
cb_57.Enabled = False
sle_operator.Enabled = False
dw_misc.Enabled = False
sle_serial.Enabled = False
sle_machine.Enabled = False
sle_qty.Enabled = False
sle_unit.Enabled = False

end subroutine

public subroutine wf_set_focus ();Choose Case szField

	Case "machine"
		sle_machine.SetFocus ( )

	Case "unit"
		sle_unit.SetFocus ( )

	Case "operator"
		sle_operator.SetFocus ( )

	Case "quantity"
		sle_qty.SetFocus ( )

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
//gb_operator.TextColor = f_get_color_value ( "darkred" )
//gb_qty.TextColor = f_get_color_value ( "darkred" )
//gb_unit.TextColor = f_get_color_value ( "darkred" )
//gb_serial_number.TextColor = f_get_color_value ( "darkred" )
//
gb_machine.TextColor = f_get_color_value ( "black" )
gb_operator.TextColor = f_get_color_value ( "black" )
gb_qty.TextColor = f_get_color_value ( "black" )
gb_unit.TextColor = f_get_color_value ( "black" )
gb_serial_number.TextColor = f_get_color_value ( "black" )


end subroutine

public subroutine wf_change_color_focus ();wf_reset_colors ( )
//Choose Case is_field
//	Case "machine"
//		gb_machine.TextColor = f_get_color_value ( "blue" )
//	Case "operator"
//		gb_operator.TextColor = f_get_color_value ( "blue" )
//	Case "quantity"
//		gb_qty.TextColor = f_get_color_value ( "blue" )
//	Case "unit"
//		gb_unit.TextColor = f_get_color_value ( "blue" )
//	Case "serial"
//		gb_serial_number.TextColor = f_get_color_value ( "blue" )
//End Choose
//
Choose Case is_field
	Case "machine"
		gb_machine.TextColor = f_get_color_value ( "black" )
	Case "operator"
		gb_operator.TextColor = f_get_color_value ( "black" )
	Case "quantity"
		gb_qty.TextColor = f_get_color_value ( "black" )
	Case "unit"
		gb_unit.TextColor = f_get_color_value ( "black" )
	Case "serial"
		gb_serial_number.TextColor = f_get_color_value ( "black" )
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

public subroutine wf_hide_message ();sle_status.Hide ( )
Timer ( 0 )
bMessage = False
end subroutine

public function boolean wf_material_issue ();//  Declare Variables
str_progress stProgressParm
st_generic_structure	str_Parm

Dec l_d_Quantity, l_d_Weight, dCost, l_d_OnHand, dIssuedQty
Dec dConvertedObjectQty
Dec dNewObjectQty
Dec dStdQty
Dec dStdQuantity
Dec dObjectsQuantity

String 	l_s_Status, l_s_LocationTo, l_s_FromLoc
String 	l_s_StockUnit
String 	l_s_Lot
String 	l_s_LocationFrom
String 	l_s_Vendor
String 	l_s_Shipper
String 	l_s_Plant
String 	l_s_TempUnit
String	l_s_Custom1
String	l_s_Custom2
String	l_s_Custom3
String	l_s_Custom4
String	l_s_Custom5
String	cSafetyPart
String	cCheck1
String	cCheck2
String	cCheck3
String	cCheck4
String	cCheck5
String	cCheckLot
String	l_s_PartNumber
String	l_s_Message
String	l_s_Temp
string	ls_data
string	ls_notes

Boolean 	l_b_Changed

Long l_l_Row

DateTime dDateStamp

Int iCount
Int iLoop

//  Check all needed areas
Int iRtnCode

lSerial = f_get_value ( Long ( f_serial_validate(sle_serial.Text )) )

If sle_machine.Text = "" Then
	f_beep ( 5 )
	iRtnCode = MessageBox ( "Error", "A valid machine is required!  Would you like to use drop down list?", Question!, YesNo!, 1 )
	If iRtnCode = 1 Then
		bPopulateMachines = True
		//Show List
	End if
	sle_machine.SetFocus ( )
	Return False
else
	l_s_temp =''
	ls_data = sle_machine.text
	
	If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
		SELECT	code  
		INTO	:l_s_Temp  
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :ls_data ) AND  
			( trans_code = 'M' ) AND  
			( type = 'MC' ) ;
	Else
		SELECT	code  
		INTO	:l_s_Temp  
		FROM	location  
		WHERE	( code = :ls_data ) AND  
			( type = 'MC' )   ;
	End if	
	If l_s_temp = "" Then
		f_beep ( 5 )
		iRtnCode = MessageBox ( "Error", "A valid machine is required!  Would you like to use drop down list?", Question!, YesNo!, 1 )
		If iRtnCode = 1 Then
			bPopulateMachines = True
		End if
		sle_machine.SetFocus ( )
		Return False
	end if 	
End if
If szOperator = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid operator is required to continue!", StopSign! )
	bOperator = False
	sle_operator.SetFocus ( )
	Return False
End if

If lSerial < 1 Or sle_serial.Text = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid serial number is required to continue!", StopSign! )
	bSerialNumber = False
	sle_serial.SetFocus ( )
	Return False
End if

If sle_unit.Text = "" Then
	f_beep ( 5 )
	MessageBox ( "Error", "A valid unit of measure is required to continue!", StopSign! )
	bUnits = False	
	sle_unit.SetFocus ( )
	Return False
End if

If cIssueType = "U" And Dec ( sle_qty.Text ) <= 0 Then
	f_beep ( 5 )
	MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
	sle_qty.Text = ""
	bQty = False
	sle_qty.SetFocus ( )
	Return False
End if

dConvertedObjectQty = f_convert_units ( sle_unit.Text, dw_misc.GetItemString ( 1, "unit" ), dw_misc.GetItemString ( 1, "part" ), Dec ( sle_qty.Text ) )
dObjectsQuantity = f_get_value ( dw_misc.GetItemNumber ( 1, "quantity" ) )

If dConvertedObjectQty > dObjectsQuantity Then
	f_beep ( 5 )
	MessageBox ( "Error", "Quantity must be less than original object's quantity!", StopSign! )
	sle_qty.Text = ""
	bQty = False
	sle_qty.SetFocus ( )
	Return False
End if

//  Check for lot control
SELECT part,
		 custom1,
		 custom2,
		 custom3,
		 custom4,
		 custom5,
		 lot
  INTO :l_s_PartNumber,
		 :l_s_Custom1,
		 :l_s_Custom2,
		 :l_s_Custom3,
		 :l_s_Custom4,
		 :l_s_Custom5,
		 :l_s_Lot
  FROM object  
 WHERE serial = :lSerial   ;

SELECT safety_part  
  INTO :cSafetyPart  
  FROM part_inventory
 WHERE part = :l_s_PartNumber   ;

If cSafetyPart = 'Y' Then

	dw_transactions.SetTransObject ( sqlca )
	dw_transactions.Retrieve ( l_s_PartNumber, sle_machine.Text )

	If dw_transactions.RowCount ( ) > 0 Then

	   SELECT shop_floor_check_u1,   
	          shop_floor_check_u2,   
	          shop_floor_check_u3,   
	          shop_floor_check_u4,   
	          shop_floor_check_u5,   
	          shop_floor_check_lot  
	     INTO :cCheck1,   
	          :cCheck2,   
	          :cCheck3,   
	          :cCheck4,   
	          :cCheck5,   
	          :cCheckLot  
	     FROM parameters  ;
	
		If cCheck1 = 'Y' Then
			l_s_Temp = dw_transactions.GetItemString ( 1, "custom1" )
			If l_s_Custom1 <> l_s_Temp Then &
				l_b_Changed = True
		End if
		If cCheck2 = 'Y' And Not l_b_Changed Then
			If l_s_Custom2 <> dw_transactions.GetItemString ( 1, "custom2" ) Then &
				l_b_Changed = True
		End if
		If cCheck3 = 'Y' And Not l_b_Changed Then
			If l_s_Custom3 <> dw_transactions.GetItemString ( 1, "custom3" ) Then &
				l_b_Changed = True
		End if
		If cCheck4 = 'Y' And Not l_b_Changed Then
			If l_s_Custom4 <> dw_transactions.GetItemString ( 1, "custom4" ) Then &
				l_b_Changed = True
		End if
		If cCheck5 = 'Y' And Not l_b_Changed Then
			If l_s_Custom5 <> dw_transactions.GetItemString ( 1, "custom5" ) Then &
				l_b_Changed = True
		End if
		If cCheckLot = 'Y' And Not l_b_Changed Then
			If l_s_Lot <> dw_transactions.GetItemString ( 1, "lot" ) Then &
				l_b_Changed = True
		End if

		If l_b_Changed Then
			SELECT parameters.lot_control_message  
			  INTO :l_s_Message  
			  FROM parameters  ;
			MessageBox ( "Lot Control", l_s_Message, StopSign! )
		End if

	End if

End if

//  Initialize variables
dw_object.SetTransObject ( sqlca )
dw_object.Retrieve ( lSerial )

tTime = Now ( )
l_d_Quantity = Dec ( sle_qty.Text )
l_d_Weight = dw_object.GetItemNumber ( 1, "weight" )
dCost = dw_object.GetItemNumber ( 1, "cost" )
dToday = Today ( )
l_s_LocationFrom = f_get_string_value ( dw_object.GetItemString ( 1, "location" ) )
l_s_LocationTo   = sle_machine.Text
szPart = dw_misc.GetItemString ( 1, "part" )
dDateStamp = DateTime ( Today ( ), Now ( ) )
lSerial = Long ( f_serial_validate(sle_serial.Text ))
iCount = 0

SELECT location.plant  
  INTO :l_s_Plant  
  FROM location  
 WHERE location.code = :l_s_LocationTo   ;

//  Make sure issued quantity is not greater than object qty.
SELECT part_inventory.material_issue_type  
  INTO :cIssueType  
  FROM part_inventory  
 WHERE part_inventory.part = :szPart   ;

If cIssueType = 'R' Then
	If dConvertedObjectQty < 0 Then
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid quantity!  Please enter a value greater than or equal to 0!", StopSign! )
		sle_qty.Text = ""
		bQty = False
		sle_qty.SetFocus ( )
		Return False
	Elseif dConvertedObjectQty >= dObjectsQuantity Then
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid quantity!  Quantity remaining must be less than the object's original quantity!", StopSign! )
		sle_qty.Text = ""
		bQty = False
		sle_qty.SetFocus ( )
		Return False
	End if
	dIssuedQty = dObjectsQuantity - dConvertedObjectQty  
	dNewObjectQty = Dec ( sle_qty.Text )
Else
	If dConvertedObjectQty <= 0 Then
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid quantity!  Please enter a value greater than 0!", StopSign! )
		sle_qty.Text = ""
		bQty = False
		sle_qty.SetFocus ( )
		Return False
	ElseIf dConvertedObjectQty > dObjectsQuantity Then 
		f_beep ( 5 )
		MessageBox ( "Error", "You can not issue more than the object's quantity!", StopSign! )
		bQty = False
		sle_qty.SetFocus ( )
		Return False
	End if
	dIssuedQty = dConvertedObjectQty
	dNewObjectQty = dObjectsQuantity - dIssuedQty  
End if

stProgressParm.Title = 'Material Issue'

OpenWithParm ( w_progress, stProgressParm )

//  Grab Stock Unit from part master
SELECT part_inventory.standard_unit
  INTO :l_s_StockUnit
  FROM part_inventory  
 WHERE part_inventory.part = :szPart   ;

//  Convert to Stock Unit
dStdQty = f_convert_units ( dw_misc.GetItemString ( 1, "unit" ), "", szPart, dIssuedQty )

iCount = iCount + 1
w_progress.wf_progress ( iCount / 4, "Updating On Hand..." )

l_d_OnHand = f_update_onhand ( szPart, dStdQty, "-*" )

iCount = iCount + 1
w_progress.wf_progress ( iCount / 4, "Updating Object Quantity..." )
ls_notes = mle_notes.text
l_s_custom2 = ddlb_finishedpart.text

If dNewObjectQty > 0 Then

	If cIssueType = "U" Then
		l_s_TempUnit = dw_misc.GetItemString ( 1, "unit" )
	Else
		l_s_TempUnit = sle_unit.Text
	End if

	dStdQuantity = f_get_value ( &
		f_convert_units ( l_s_TempUnit, "", szPart, dNewObjectQty ) )
	
  	UPDATE object
	   SET quantity = :dNewObjectQty,
			 std_quantity = :dStdQuantity,
			 last_date = :dDateStamp,
			 last_time = :dDateStamp,
			 operator  = :szOperator,
			 unit_measure = :l_s_TempUnit,
			 dimension_qty_string = :szparentdimqtystr,
			 dim_qty_string_other = :szdimensionqtystring,
			 varying_dimension_code = :llnonconstantdim,
			 note = :ls_notes,
			 custom2 = :l_s_custom2
    		WHERE serial = :lSerial   ;
    
Else
  	UPDATE object
	   SET 	 note = :ls_notes,
		 custom2 = :l_s_custom2
    	WHERE serial = :lSerial   ;	
	bDelete = True
End if

If SQLCA.SQLCode = -1 Then
	RollBack ;
	Close ( w_progress )
	wf_enable_screen ( )
	f_beep ( 5 )
	Return False
Else
		

	iCount = iCount + 1
	w_progress.wf_progress ( iCount / 4, "Creating Audit Trail..." )

	//  Convert Qty back to issued/left unit

	dIssuedQty = f_convert_units ( dw_misc.GetItemString ( 1, "unit" ), sle_unit.Text, szPart, dIssuedQty )

	szPart  = f_get_string_value ( szPart )
	dIssuedQty = f_get_value ( dIssuedQty )
	dCost   = f_get_value ( dCost )
	sle_operator.Text = f_get_string_value ( sle_operator.Text )
//	szOperator = sle_operator.Text
	l_d_OnHand = f_get_value ( l_d_OnHand )
	l_s_Lot = f_get_string_value ( dw_object.GetItemString ( 1, "lot" ) )
	l_d_Weight = f_get_value ( l_d_Weight )
	l_s_Status = f_get_string_value ( l_s_Status )
	sle_unit.Text = f_get_string_value ( sle_unit.Text )

   SELECT audit_trail.vendor,   
          audit_trail.shipper  
     INTO :l_s_Vendor,   
          :l_s_Shipper  
     FROM audit_trail  
    WHERE ( audit_trail.serial = :lSerial ) AND  
          ( audit_trail.type = 'R' )   ;

//	stTransParm.Value1 = is_Notes
	stTransParm.Value1 = ls_Notes	

	If Not f_create_audit_trail ( lSerial, "M", String ( dIssuedQty ), String ( dStdQty ), sle_unit.Text, sle_machine.Text, l_s_Vendor, l_s_Shipper, l_s_Plant, szWorkOrder, szOperator, "No Commit" ) Then

		RollBack ;
		wf_enable_screen ( )
		f_beep ( 5 )

	Else

		If bDelete Then

			DELETE FROM object
			WHERE serial = :lSerial   ;
			sle_serial.Text = ""
			dw_object.Reset ( )
			dw_misc.Reset ( )
			bDelete = False

		End if

		Commit ;

		If dNewObjectQty > 0 Then
			iCount = iCount + 1
			w_progress.wf_progress ( iCount / 4, "Printing Label..." )
			str_Parm.Value1 = String ( lSerial )
			f_print_label ( str_Parm )
		Else
			iCount = iCount + 1
			w_progress.wf_progress ( iCount / 4, "No Label To Print..." )
		End if

		f_beep ( 1 )
		wf_show_message ( )

	End if

	Close ( w_progress )

End if

dw_misc.Retrieve ( lSerial )
wf_enable_screen ( )

Return True
end function

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
String	ls_invoicenumber
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
       :ls_invoicenumber,   
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
sle_machine.Enabled = False
sle_qty.Enabled = False
sle_unit.Enabled = False

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
sle_machine.Enabled = TRUE
sle_qty.Enabled = TRUE
sle_unit.Enabled = TRUE

end subroutine

public subroutine wf_breakupdimqty (string sz_originalstr);// pre-requisite is declare a decimal array of 2 d_org_value
// in the calling program. should be a instance variable 

string ls_orgdimstr,ls_str1,ls_str2
int    li_pos,li_pos1

ls_orgdimstr = trim(sz_originalstr)

li_pos = pos(ls_orgdimstr,',',1)

if li_pos > 0 then
	ls_str1 = left(ls_orgdimstr, (li_pos - 1))
	ls_str2 = right(ls_orgdimstr, (li_pos - 1))
	
	d_org_value[1]= dec(ls_str1)
	d_org_value[2]= dec(ls_str2)

ELSE
	d_org_value ={0,0}
end if	

end subroutine

public subroutine wf_getfp ();string	ls_part

DECLARE Part_cur CURSOR FOR
SELECT	part
FROM	part
WHERE	type = 'F' and class <> 'O';

open	part_cur;

fetch	part_cur into :ls_part;

do while sqlca.sqlcode = 0 
	ddlb_finishedpart.additem(ls_part)
	fetch	part_cur into :ls_part;
loop
close	part_cur;

end subroutine

event open;/*  Initialize Variables  */

bChars = True
bNumbers = True

stParm        = Message.PowerObjectParm

if IsValid ( stParm ) then
	lSerialParm   = Long ( stParm.Value2 )
	If stParm.Value2 = "0" Then stParm.Value2 = ""
	szWorkOrder   = stParm.Value5
end if

dtToday = DateTime ( Today ( ), Now ( ) )


/*  Determine type of transaction and prime the dataobject of dw_1  */

dw_unit_list.SetTransObject ( sqlca )

dw_limit_locs.SetTransObject ( sqlca )
dw_limit_locs.Retrieve ( 'M' )

wf_setup_screen ( )

wf_getfp()
end event

event timer;If bMessage Then
	If sle_status.Visible = True Then
		sle_status.Visible = False
	Else
		sle_status.Visible = True
	End if
	Return
End if

Timer ( 0, This )


end event

on w_material_issue.create
this.ddlb_finishedpart=create ddlb_finishedpart
this.sle_unit=create sle_unit
this.lb_list=create lb_list
this.sle_machine=create sle_machine
this.dw_limit_locs=create dw_limit_locs
this.dw_transactions=create dw_transactions
this.lb_1=create lb_1
this.sle_status=create sle_status
this.st_1=create st_1
this.cb_57=create cb_57
this.lb_unit_list=create lb_unit_list
this.dw_unit_list=create dw_unit_list
this.cb_55=create cb_55
this.sle_qty=create sle_qty
this.cb_48=create cb_48
this.dw_object=create dw_object
this.sle_operator=create sle_operator
this.sle_serial=create sle_serial
this.cb_47=create cb_47
this.cb_46=create cb_46
this.cb_45=create cb_45
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
this.gb_qty=create gb_qty
this.gb_serial_number=create gb_serial_number
this.gb_unit=create gb_unit
this.gb_operator=create gb_operator
this.gb_machine=create gb_machine
this.gb_dwbox=create gb_dwbox
this.mle_notes=create mle_notes
this.notes_dwbox=create notes_dwbox
this.Control[]={this.ddlb_finishedpart,&
this.sle_unit,&
this.lb_list,&
this.sle_machine,&
this.dw_limit_locs,&
this.dw_transactions,&
this.lb_1,&
this.sle_status,&
this.st_1,&
this.cb_57,&
this.lb_unit_list,&
this.dw_unit_list,&
this.cb_55,&
this.sle_qty,&
this.cb_48,&
this.dw_object,&
this.sle_operator,&
this.sle_serial,&
this.cb_47,&
this.cb_46,&
this.cb_45,&
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
this.gb_qty,&
this.gb_serial_number,&
this.gb_unit,&
this.gb_operator,&
this.gb_machine,&
this.gb_dwbox,&
this.mle_notes,&
this.notes_dwbox}
end on

on w_material_issue.destroy
destroy(this.ddlb_finishedpart)
destroy(this.sle_unit)
destroy(this.lb_list)
destroy(this.sle_machine)
destroy(this.dw_limit_locs)
destroy(this.dw_transactions)
destroy(this.lb_1)
destroy(this.sle_status)
destroy(this.st_1)
destroy(this.cb_57)
destroy(this.lb_unit_list)
destroy(this.dw_unit_list)
destroy(this.cb_55)
destroy(this.sle_qty)
destroy(this.cb_48)
destroy(this.dw_object)
destroy(this.sle_operator)
destroy(this.sle_serial)
destroy(this.cb_47)
destroy(this.cb_46)
destroy(this.cb_45)
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
destroy(this.gb_qty)
destroy(this.gb_serial_number)
destroy(this.gb_unit)
destroy(this.gb_operator)
destroy(this.gb_machine)
destroy(this.gb_dwbox)
destroy(this.mle_notes)
destroy(this.notes_dwbox)
end on

type ddlb_finishedpart from dropdownlistbox within w_material_issue
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=1422
int Y=896
int Width=837
int Height=448
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AllowEdit=true
long TextColor=33554432
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_key;boolean	l_b_shift

if KeyDown ( keyShift! ) Then l_b_shift = TRUE
if key = keyTab! or key = keyEnter! then
	if l_b_shift then
		ib_back = TRUE
		MessageBox ("FYI", "BACK")
		TriggerEvent ( "ue_validate" )
	else
		ib_forward = TRUE
		MessageBox ("FYI", "FORWARD")
		TriggerEvent ( "ue_validate" )
	end if
end if

end event

event ue_validate;If ib_forward Then
	ib_forward = FALSE
	cb_48.SetFocus()
Elseif ib_back then

	ib_back = FALSE
	mle_notes.SetFocus ( )

End if


end event

event getfocus;igo_Last = GetFocus ( )
is_Field = "fpart"
wf_change_color_focus ( )


end event

type sle_unit from singlelineedit within w_material_issue
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=914
int Y=928
int Width=366
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
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

event ue_validate;If ib_forward Then
	ib_forward = FALSE
	ddlb_finishedpart.SetFocus ( )
Elseif ib_back then
	ib_back = FALSE
	mle_notes.SetFocus ( )
End if

end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If bChars Then disable_chars ( )
If bNumbers Then disable_numbers ( )
igo_last = GetFocus ( )
is_Field = "unit"
wf_change_color_focus ( )
lb_list.Hide ( )
//if lb_list.uf_setup ( "", "", x, y, height, 1825, TextSize, width, "", "", lb_unit_list ) > 0 then &
  if lb_list.uf_setup ( "", "", x, y, height, 1825, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then &	
	lb_list.Show ( )

end event

type lb_list from u_it_list_box within w_material_issue
int X=1591
int Y=720
int TabOrder=0
boolean Visible=false
end type

type sle_machine from singlelineedit within w_material_issue
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=73
int Y=256
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_key;boolean	l_b_shift

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

event ue_validate;String 	ls_Temp, &
	ls_LimitLocs, &
	ls_Type, &
	ls_ShowInInventory, &
	s_ScaleAttached,&
	l_s_trans_code
Int	iRtnCode

If ib_forward Then
	ib_forward = FALSE
	ls_temp = sle_machine.Text
	If dw_limit_locs.RowCount ( ) > 0 Then // check whether locations are limited
		l_s_trans_code = Left ( stParm.Value1, 1 )
		if isnull(l_s_trans_code) or l_s_trans_code='' then l_s_trans_code = 'M'
		SELECT	code  
		INTO	:ls_Temp  
		FROM	location,   
			location_limits  
		WHERE	( code = location_code ) and  
			( location_code = :ls_Temp ) AND  
			( trans_code = :l_s_trans_code ) AND  
			( type = 'MC' ) ;
	Else
		SELECT	code  
		INTO	:ls_Temp  
		FROM	location  
		WHERE	( code = :ls_Temp ) AND  
			( type = 'MC' )   ;
	End if
	If SQLCA.SQLCode <> 0 Then
		f_beep ( 5 )
		If Not bPopulateMachines Then
			iRtnCode = MessageBox ( "Error", "A valid machine is required! Would you like to use drop down list?", Question!, YesNo!, 1 )
			If iRtnCode = 1 Then
				bPopulateMachines = True
//				if lb_list.uf_setup ( "location", "code", x, y, height, 1150, TextSize, width, '', '', lb_unit_list ) > 0 then &
				if lb_list.uf_setup ( "machine", "machine_no", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then &	
					lb_list.Show ( )
			End if
		Else
			MessageBox ( "Error", "A valid machine is required!  Please select a valid one from list.", StopSign! )
		End if
		Text = ""
		SetFocus ( )
		
	Else
		
		sle_operator.SetFocus ( )

	End if

Elseif ib_back then

	ib_back = FALSE
	sle_machine.SetFocus ( )

End if
end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )
If Not bChars Then Enable_chars ( )
If Not bNumbers Then Enable_numbers ( )
igo_last = GetFocus ( )
is_Field = "machine"
wf_change_color_focus ( )
lb_list.Hide ( )
If bPopulateMachines Then 
//	if lb_list.uf_setup ( "machine", "machine_no", x, y, height, 1150, TextSize, width, '', '', lb_unit_list ) > 0 then &
	if lb_list.uf_setup ( "machine", "machine_no", x, y, height, 1150, TextSize, width, '', '', lb_unit_list, dw_limit_locs ) > 0 then &	
		lb_list.Show ( )
End if

end event

type dw_limit_locs from datawindow within w_material_issue
int X=3218
int Y=1248
int Width=494
int Height=364
boolean Visible=false
string DataObject="d_limit_locs"
boolean LiveScroll=true
end type

type dw_transactions from datawindow within w_material_issue
int X=425
int Y=1996
int Width=1865
int Height=480
boolean Visible=false
string DataObject="d_audit_trail_by_date"
boolean LiveScroll=true
end type

type lb_1 from listbox within w_material_issue
int X=2341
int Y=1952
int Width=494
int Height=364
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

type sle_status from statictext within w_material_issue
int X=978
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

type st_1 from statictext within w_material_issue
int X=1755
int Y=8
int Width=1161
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

type cb_57 from commandbutton within w_material_issue
int X=2213
int Y=1728
int Width=293
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
	u_generic_it_note.mle_note.Text = Left ( u_generic_it_note.mle_note.Text, Len ( u_generic_it_note.mle_note.Text ) - 1 )
ELSEIF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = Left ( u_audit_trail.sle_operator_password.Text, Len ( u_audit_trail.sle_operator_password.Text ) - 1 )
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

type lb_unit_list from listbox within w_material_issue
int X=2985
int Y=1120
int Width=402
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

type dw_unit_list from datawindow within w_material_issue
int X=2341
int Y=2672
int Width=494
int Height=364
boolean Visible=false
string DataObject="d_unit_conversion_list_per_part"
boolean LiveScroll=true
end type

type cb_55 from commandbutton within w_material_issue
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

type sle_qty from singlelineedit within w_material_issue
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=73
int Y=928
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
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
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if

end event

event ue_validate;String	cAllowZeroQty
String   ls_ddarequired='N'	 

If ib_forward Then
	
	ib_forward = FALSE

  SELECT inventory_parameters.jc_allow_zero_qty  
    INTO :cAllowZeroQty  
    FROM inventory_parameters  ;

	If cIssueType = "U" And Dec ( sle_qty.Text ) <= 0 Then

		// below lines inc by gph on 7/17/97 for dda		
		SELECT dda_required
		  INTO :ls_ddarequired
		  FROM parameters ;

		IF ls_ddarequired = 'Y' THEN  		
			IF sle_qty.text='' or isnull(sle_qty.text) then 
				SELECT object.quantity,
						 object.dimension_qty_string
				  INTO :szparentqty,
						 :szparentdimqtystr
				  FROM object  
				 WHERE object.serial = :lSerial   ;			
			end if 	 
			st_prmlst.s_arg_part   = dw_misc.getitemstring(dw_misc.getrow(),'part')
			st_prmlst.s_arg_module = dw_misc.getitemstring(dw_misc.getrow(),'unit')
			st_prmlst.s_rtn_qtystr = szdimensionqtystring
			st_prmlst.s_rtn_qty    = Dec(sle_qty.text) 
			st_prmlst.s_parent_unit= sle_unit.text 
			st_prmlst.s_parent_qty = szparentqty
			st_prmlst.s_parent_dimqtystr = szparentdimqtystr		
			Openwithparm(w_dda_mit_sf,st_prmlst)
			st_prmlst = Message.PowerObjectparm
			szdimensionqtystring = st_prmlst.s_rtn_qtystr
		   sle_qty.text         = String(st_prmlst.s_rtn_qty)
	      szparentqty          = st_prmlst.s_parent_qty
			szparentdimqtystr    = st_prmlst.s_parent_dimqtystr
			llnonconstantdim     = st_prmlst.s_nonconstantdim
		end if 
		
		If Dec ( Text ) <= 0 Then 		
			f_beep ( 5 )
			MessageBox ( "Error", "Quantity must be greater than 0!", StopSign! )
			sle_qty.SetFocus ( )
		Else
			If bMIUnitMode Then
				sle_unit.SetFocus ( )			
			Else
//				cb_48.SetFocus ( )
				mle_notes.SetFocus()
			End if
		End if
	Else
		If bMIUnitMode Then
			sle_unit.SetFocus ( )			
		Else
//			cb_48.SetFocus ( )
			mle_notes.SetFocus()
		End if
	End if

Elseif ib_back then

	ib_back = FALSE
	sle_serial.SetFocus ( )

End if


end event

event getfocus;IF bMessage THEN wf_hide_message ( )

IF bChars THEN Disable_chars ( )
IF Not bNumbers THEN Enable_Numbers ( )
lb_list.Hide ( )
igo_Last = GetFocus ( )
is_Field = "quantity"
wf_change_color_focus ( )


end event

type cb_48 from commandbutton within w_material_issue
event button_clicked pbm_custom01
event ue_validate pbm_custom02
event ue_key pbm_keyup
int X=2450
int Y=480
int Width=475
int Height=160
string Text="Issue"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_validate;If bMessage Then wf_hide_message ( )

If ib_forward Then
	ib_forward = FALSE
	cb_48.TriggerEvent ( clicked! )
Elseif ib_back then
	ib_back = FALSE
	If bMIUnitMode Then
		sle_unit.SetFocus ( )
	Else
		sle_qty.SetFocus ( )
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

event clicked;SetPointer ( HourGlass! )

bAction = True

wf_disable_screen ( )

wf_reset_indicators ( )
If wf_material_issue ( ) Then
	//bSerialNumber = True
	szField = "serial"
	sle_serial.Text = ""
	sle_qty.Text = ""
	is_notes = ""
	mle_notes.text = ""
	wf_set_focus ( )
	dw_misc.Reset ( )
End if

wf_enable_screen ( )

bAction = False

is_Notes = ""
end event

on getfocus;wf_reset_indicators ( )
bCB48 = True
end on

type dw_object from datawindow within w_material_issue
int X=2341
int Y=2320
int Width=494
int Height=364
boolean Visible=false
string DataObject="d_object_data"
boolean LiveScroll=true
end type

type sle_operator from singlelineedit within w_material_issue
event ue_validate pbm_custom01
event ue_key pbm_keyup
int X=73
int Y=480
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
int Weight=400
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

	If szMachineParm = "" Then
		sle_machine.SetFocus ( )
	else
		setfocus ( )
	end if
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

type sle_serial from singlelineedit within w_material_issue
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=73
int Y=704
int Width=731
int Height=128
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
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
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if

end event

event ue_validate;/*  Declare Variables  */

String szOriginalUnit
String cTempStatus
String cNewStatus
String szTempPackaging
String ls_CurrentUserDefinedStatus
String ls_DefectCode
String ls_Part
String ls_Machine
string	ls_class
	
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
	
//	If Left ( sle_serial.Text, 1 ) = 'S' Then
//		sle_serial.Text = Right ( sle_serial.Text, Len ( sle_serial.Text ) - 1 )
//	Elseif Not IsNumber ( Left ( sle_serial.Text, 1 ) ) Then
//		f_beep ( 5 )
//		sle_serial.Text = ""
//		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
//		sle_serial.SetFocus ( )
//		Return
//	End if
		
	lSerial = f_get_value ( Long ( f_serial_validate(sle_serial.Text ) ))
	If lSerial < 1 Then 
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
		sle_serial.SetFocus ( )
		Return
	End if
	
	SELECT object.serial,
			 object.shipper,
			 object.status,
			 object.quantity,
			 object.dimension_qty_string,
			 part.class
	  INTO :lTemp,
			 :lTempShipper,
			 :cTempStatus,
			 :szparentqty,
			 :szparentdimqtystr,
			 :ls_class
	  FROM object 
	  	join part on part.part = object.part
	 WHERE object.serial = :lSerial   ;
		
	If SQLCA.SQLCode <> 0 Then
		f_beep ( 5 )
		MessageBox ( "Error", "Invalid serial number!  Please enter a valid one.", StopSign! )
		sle_serial.Text = ""
		sle_serial.SetFocus ( )
		Return
	Elseif ls_class <> "P" and ls_class <> "M" Then		
		f_beep ( 5 )
		MessageBox ( "Error", "You cannot perform this transaction as the class is not 'M/P'", StopSign! )
		sle_serial.Text = ""
		sle_serial.SetFocus ( )
		Return
	Elseif f_get_string_value ( cTempStatus ) <> "A" Then
		f_beep ( 5 )
		MessageBox ( "Error", "You cannot perform this transaction on an object with status other than approved!", StopSign! )
		sle_serial.Text = ""
		sle_serial.SetFocus ( )
		Return
	Elseif f_get_value ( lTempShipper ) > 0 Then
		f_beep ( 5 )
		MessageBox ( "Error", "You cannot perform this transaction on a staged object!", StopSign! )
		sle_serial.Text = ""
		sle_serial.SetFocus ( )
		Return
	End if
		
	
	bLoseFocus = True
	
	dw_misc.SetTransObject ( sqlca )
	dw_misc.Retrieve ( lSerial )

	szPart = f_get_string_value ( dw_misc.GetItemString ( 1, "part" ) )
	szOriginalUnit = f_get_string_value ( dw_misc.GetItemString ( 1, "unit" ) )

	If szPart = "" Then
		f_beep ( 10 )
		MessageBox ( "Error", "Object has an invalid part number or the part number has an error.", StopSign! )
		sle_serial.Text = ""
		sle_serial.SetFocus ( )
		Return			
	End if

	SELECT part_inventory.material_issue_type  
	  INTO :cIssueType  
	  FROM part_inventory  
	 WHERE part_inventory.part = :szPart   ;
	
	wf_get_unit_list ( szPart, szOriginalUnit )
	
	sle_unit.Text = szOriginalUnit

	dw_object.SetTransObject ( sqlca )
	dw_object.Retrieve ( lSerial )

	If cIssueType = "U" Then
		gb_qty.Text = "Quantity Used"
		sle_qty.Text = String ( dw_object.GetItemNumber ( 1, "quantity" ) )
	Else
		gb_qty.Text = "Quantity Remaining"
	End if
	sle_qty.SetFocus ( )

Elseif ib_back then
	
	ib_back = FALSE
	sle_operator.SetFocus ( )
	
End if
end event

event getfocus;If Not bAction And bMessage Then wf_hide_message ( )

If bChars Then disable_chars ( )
If Not bNumbers Then Enable_numbers ( )
lb_list.Hide ( )
igo_Last = GetFocus ( )
is_Field = "serial"
wf_change_color_focus ( )

end event

type cb_47 from commandbutton within w_material_issue
int X=2450
int Y=800
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

type cb_46 from commandbutton within w_material_issue
int X=2450
int Y=960
int Width=475
int Height=160
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//ib_Notes = TRUE
//wf_disable_except_buttons ( )
//Parent.OpenUserObjectWithParm ( u_generic_it_note, is_Notes, 550, 200 )
//u_generic_it_note.BringToTop = TRUE
//IF is_Notes <> "" THEN u_generic_it_note.mle_note.Text = is_Notes
//
end event

type cb_45 from commandbutton within w_material_issue
int X=3360
int Y=192
int Width=475
int Height=160
boolean Visible=false
boolean Enabled=false
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_44 from commandbutton within w_material_issue
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

type cb_42 from commandbutton within w_material_issue
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
		str_Parm.as_TransactionType = "MI"
		enable_numbers ( )
		cb_37.Enabled = TRUE
		cb_57.Enabled = TRUE
str_Parm.as_Machine = sle_machine.Text

if NOT bchars then enable_chars ( )

OpenUserObjectWithParm ( u_audit_trail, str_Parm, 55, 150 )
u_audit_trail.BringToTop = TRUE

end event

type dw_1 from datawindow within w_material_issue
int X=3730
int Y=1312
int Width=2926
int Height=1152
boolean Visible=false
boolean LiveScroll=true
end type

type cb_41 from commandbutton within w_material_issue
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

type cb_43 from commandbutton within w_material_issue
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

type cb_40 from commandbutton within w_material_issue
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

type cb_39 from commandbutton within w_material_issue
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

type cb_38 from commandbutton within w_material_issue
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

type cb_37 from commandbutton within w_material_issue
int X=1902
int Y=1728
int Width=293
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
		Case "machine"
			sle_machine.Text = ""
			sle_machine.SetFocus ( )
		Case "quantity"
			sle_qty.Text = ""
			sle_qty.SetFocus ( )
		Case "operator"
			sle_operator.Text = ""
			sle_operator.SetFocus ( )
		Case "serial"
			sle_serial.Text = ""
			sle_serial.SetFocus ( )
	End Choose
END IF
end event

type cb_36 from commandbutton within w_material_issue
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

type cb_35 from commandbutton within w_material_issue
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

type cb_34 from commandbutton within w_material_issue
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

type cb_33 from commandbutton within w_material_issue
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

type cb_32 from commandbutton within w_material_issue
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

type cb_31 from commandbutton within w_material_issue
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

type cb_30 from commandbutton within w_material_issue
int X=2523
int Y=1728
int Width=329
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
		cb_current.TriggerEvent ( clicked! )
END CHOOSE

end event

type cb_29 from commandbutton within w_material_issue
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

type cb_28 from commandbutton within w_material_issue
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

type cb_27 from commandbutton within w_material_issue
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

type cb_26 from commandbutton within w_material_issue
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

type cb_25 from commandbutton within w_material_issue
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

type cb_24 from commandbutton within w_material_issue
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

type cb_23 from commandbutton within w_material_issue
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

type cb_22 from commandbutton within w_material_issue
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

type cb_21 from commandbutton within w_material_issue
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

type cb_20 from commandbutton within w_material_issue
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

type cb_19 from commandbutton within w_material_issue
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

type cb_18 from commandbutton within w_material_issue
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

type cb_17 from commandbutton within w_material_issue
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

type cb_16 from commandbutton within w_material_issue
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

type cb_15 from commandbutton within w_material_issue
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

type cb_14 from commandbutton within w_material_issue
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

type cb_13 from commandbutton within w_material_issue
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

type cb_12 from commandbutton within w_material_issue
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

type cb_11 from commandbutton within w_material_issue
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

type cb_10 from commandbutton within w_material_issue
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

type cb_9 from commandbutton within w_material_issue
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

type cb_8 from commandbutton within w_material_issue
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

type cb_7 from commandbutton within w_material_issue
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

type cb_6 from commandbutton within w_material_issue
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

type cb_5 from commandbutton within w_material_issue
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

type cb_4 from commandbutton within w_material_issue
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

type cb_3 from commandbutton within w_material_issue
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

type cb_2 from commandbutton within w_material_issue
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

type cb_1 from commandbutton within w_material_issue
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

type dw_misc from datawindow within w_material_issue
event ue_set_focus pbm_custom01
int X=896
int Y=256
int Width=1042
int Height=304
string DataObject="d_object_info_bo"
boolean Border=false
end type

event ue_set_focus;sle_serial.Setfocus ( )

end event

event getfocus;If bMessage Then wf_hide_message ( )

end event

type sle_title from statictext within w_material_issue
int Width=2926
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Material Issue"
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

type gb_qty from groupbox within w_material_issue
int X=37
int Y=864
int Width=805
int Height=224
string Text="Quantity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_serial_number from groupbox within w_material_issue
int X=37
int Y=640
int Width=805
int Height=224
string Text="Serial Number"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_unit from groupbox within w_material_issue
int X=878
int Y=864
int Width=439
int Height=224
string Text="Unit"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_operator from groupbox within w_material_issue
int X=37
int Y=416
int Width=805
int Height=224
string Text="Operator - "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_machine from groupbox within w_material_issue
int X=37
int Y=192
int Width=805
int Height=224
string Text="Machine Number"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_dwbox from groupbox within w_material_issue
int X=859
int Y=192
int Width=1115
int Height=376
string Text="Object Info"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_notes from multilineedit within w_material_issue
event ue_key pbm_keyup
event ue_validate pbm_custom01
int X=896
int Y=644
int Width=1042
int Height=188
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
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
		ib_forward = TRUE
		TriggerEvent ( "ue_validate" )
	end if
end if

end event

event ue_validate;If ib_forward Then
	ib_forward = FALSE
	ddlb_finishedpart.SetFocus()
Elseif ib_back then

	ib_back = FALSE
	sle_qty.SetFocus ( )

End if


end event

event getfocus;igo_Last = GetFocus ( )
is_Field = "notes"
wf_change_color_focus ( )


end event

type notes_dwbox from groupbox within w_material_issue
int X=859
int Y=580
int Width=1115
int Height=280
string Text="Notes"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


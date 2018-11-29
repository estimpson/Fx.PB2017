$PBExportHeader$w_combo_scan.srw
forward
global type w_combo_scan from Window
end type
type dw_fp_list from datawindow within w_combo_scan
end type
type dw_3 from datawindow within w_combo_scan
end type
type st_4 from statictext within w_combo_scan
end type
type st_2 from statictext within w_combo_scan
end type
type dw_return_parent_part from datawindow within w_combo_scan
end type
type dw_object_data from datawindow within w_combo_scan
end type
type dw_1 from datawindow within w_combo_scan
end type
type sle_serial from singlelineedit within w_combo_scan
end type
type sle_operator from singlelineedit within w_combo_scan
end type
type sle_status from statictext within w_combo_scan
end type
type st_1 from statictext within w_combo_scan
end type
type cb_back from commandbutton within w_combo_scan
end type
type cb_space from commandbutton within w_combo_scan
end type
type cb_48 from commandbutton within w_combo_scan
end type
type cb_47 from commandbutton within w_combo_scan
end type
type cb_notes from commandbutton within w_combo_scan
end type
type cb_44 from commandbutton within w_combo_scan
end type
type cb_audit_trail from commandbutton within w_combo_scan
end type
type cb__ from commandbutton within w_combo_scan
end type
type cb_period from commandbutton within w_combo_scan
end type
type cb_- from commandbutton within w_combo_scan
end type
type cb_0 from commandbutton within w_combo_scan
end type
type cb_exit from commandbutton within w_combo_scan
end type
type cb_clear from commandbutton within w_combo_scan
end type
type cb_9 from commandbutton within w_combo_scan
end type
type cb_8 from commandbutton within w_combo_scan
end type
type cb_7 from commandbutton within w_combo_scan
end type
type cb_6 from commandbutton within w_combo_scan
end type
type cb_y from commandbutton within w_combo_scan
end type
type cb_z from commandbutton within w_combo_scan
end type
type cb_enter from commandbutton within w_combo_scan
end type
type cb_1 from commandbutton within w_combo_scan
end type
type cb_2 from commandbutton within w_combo_scan
end type
type cb_3 from commandbutton within w_combo_scan
end type
type cb_4 from commandbutton within w_combo_scan
end type
type cb_5 from commandbutton within w_combo_scan
end type
type cb_q from commandbutton within w_combo_scan
end type
type cb_r from commandbutton within w_combo_scan
end type
type cb_s from commandbutton within w_combo_scan
end type
type cb_t from commandbutton within w_combo_scan
end type
type cb_u from commandbutton within w_combo_scan
end type
type cb_v from commandbutton within w_combo_scan
end type
type cb_w from commandbutton within w_combo_scan
end type
type cb_x from commandbutton within w_combo_scan
end type
type cb_i from commandbutton within w_combo_scan
end type
type cb_j from commandbutton within w_combo_scan
end type
type cb_k from commandbutton within w_combo_scan
end type
type cb_l from commandbutton within w_combo_scan
end type
type cb_m from commandbutton within w_combo_scan
end type
type cb_n from commandbutton within w_combo_scan
end type
type cb_o from commandbutton within w_combo_scan
end type
type cb_p from commandbutton within w_combo_scan
end type
type cb_h from commandbutton within w_combo_scan
end type
type cb_g from commandbutton within w_combo_scan
end type
type cb_f from commandbutton within w_combo_scan
end type
type cb_e from commandbutton within w_combo_scan
end type
type cb_d from commandbutton within w_combo_scan
end type
type cb_c from commandbutton within w_combo_scan
end type
type cb_b from commandbutton within w_combo_scan
end type
type cb_a from commandbutton within w_combo_scan
end type
type sle_title from singlelineedit within w_combo_scan
end type
type dw_2 from datawindow within w_combo_scan
end type
type gb_3 from groupbox within w_combo_scan
end type
type gb_2 from groupbox within w_combo_scan
end type
type gb_1 from groupbox within w_combo_scan
end type
type gb_serial from groupbox within w_combo_scan
end type
type gb_operator from groupbox within w_combo_scan
end type
type sle_1 from singlelineedit within w_combo_scan
end type
end forward

global type w_combo_scan from Window
int X=0
int Y=0
int Width=6679
int Height=3452
boolean TitleBar=true
string Title="Combo Scan"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
string Icon="mit.ico"
event undo pbm_custom01
event ue_close_audit_trail pbm_custom02
event ue_save_note pbm_custom03
event ue_close_uo_note pbm_custom04
dw_fp_list dw_fp_list
dw_3 dw_3
st_4 st_4
st_2 st_2
dw_return_parent_part dw_return_parent_part
dw_object_data dw_object_data
dw_1 dw_1
sle_serial sle_serial
sle_operator sle_operator
sle_status sle_status
st_1 st_1
cb_back cb_back
cb_space cb_space
cb_48 cb_48
cb_47 cb_47
cb_notes cb_notes
cb_44 cb_44
cb_audit_trail cb_audit_trail
cb__ cb__
cb_period cb_period
cb_- cb_-
cb_0 cb_0
cb_exit cb_exit
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
sle_title sle_title
dw_2 dw_2
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_serial gb_serial
gb_operator gb_operator
sle_1 sle_1
end type
global w_combo_scan w_combo_scan

type variables
String 		szOldChildPart
String 		szNewChildPart
String 		szParentPart
String		szOperator
String		szLocation
String		szRealityText
String		szLastOperation
String		is_Notes	
Boolean		bUserOperator
Boolean		bUserNotes
Boolean 		bChars
Boolean		bNumbers
Boolean		bMessage
Boolean		bSerial
Boolean		bOperator
Boolean		bLocation
Boolean		bSetFocus
Boolean		bKeyPressed
Boolean		bBack
Boolean		bForward
Boolean		bFinished
Boolean		bAuditTrail
Boolean		ib_Password
Boolean		ib_Notes
Boolean                   bfinishedpartlist
DateTime		dtToday

Long		lSerial
Long		il_AuditRow
datawindowchild          i_dwc_child
end variables

forward prototypes
public subroutine disable_chars ()
public subroutine enable_chars ()
public subroutine disable_numbers ()
public subroutine enable_numbers ()
public subroutine wf_reset_indicators ()
public subroutine wf_enable_screen ()
public subroutine wf_disable_screen ()
public subroutine wf_reset_colors ()
public subroutine wf_change_color_focus ()
public function string wf_get_character ()
public function boolean wf_valid_key ()
public subroutine wf_show_message ()
public subroutine wf_hide_message ()
public subroutine wf_key_pressed (character ccharacter)
public function boolean wf_check_operator ()
public function boolean wf_combo_scan ()
public subroutine wf_set_focus ()
public subroutine wf_enter_defects ()
public function boolean wf_update_onhand (long ll_serial, string ls_mode)
public subroutine wf_disable_except_buttons ()
public subroutine wf_enable_except_buttons ()
public subroutine wf_get_parents_part (long arg_serial)
end prototypes

event undo;DateTime			ldt_Date
Date				ld_Date
Date				ld_Today
Time				lt_Time
Time				lt_LastTime
Long				ll_Serial
Long				ll_JCRow
Long				ll_MIRow
Dec				ld_TareWeight
Dec				ld_OnHand
Dec				ld_Qty
Dec				ld_Price
Dec				ld_Weight
Dec				ld_StdQty
Dec				ld_Cost
String			ls_Status
String			ls_Shipper
String			ls_Unit
String			ls_WorkOrder
String			ls_Customer
String			ls_Vendor
String			ls_PoNumber
String			ls_Operator
String			ls_From
String			ls_Lot
String			ls_Part
String			ls_PackageType
String			ls_Type
String			ls_Custom1
String			ls_Custom2
String			ls_Custom3
String			ls_Custom4
String			ls_Custom5
String			ls_Plant
String			ls_Notes
String			ls_Serial

str_progress 	stProgressParm
Int				iCounter = 0
Int				li_Shipper
stProgressParm.Title = "Undo Combo Scan"
stProgressParm.Cancel_window = This

OpenWithParm ( w_progress, stProgressParm )

//  Determine JC and MI Rows

il_AuditRow = u_audit_trail.dw_audit_trail.GetRow ( )

If u_audit_trail.dw_audit_trail.GetItemString ( il_AuditRow, "type" ) = 'J' Then
	ll_JCRow = il_AuditRow
	ll_MIRow = il_AuditRow + 1
Else
	ll_JCRow = il_AuditRow - 1
	ll_MIRow = il_AuditRow
End if

ld_Today = Today ( ) 
lt_LastTime = Now ( )

//  Update On hand and Delete audit trail for JC Function

iCounter++
w_progress.wf_progress ( iCounter / 5, "Updating Onhand For Completed Object..." )

ldt_Date 	= u_audit_trail.dw_audit_trail.GetItemDateTime ( ll_JCRow, "date_stamp" )
ll_Serial 	= u_audit_trail.dw_audit_trail.GetItemNumber ( ll_JCRow, "serial" )
ld_StdQty   = u_audit_trail.dw_audit_trail.GetItemNumber ( ll_JCRow, "std_quantity" )
ls_Part		= u_audit_trail.dw_audit_trail.GetItemString ( ll_JCRow, "part" )

ld_OnHand = f_update_onhand ( ls_Part, ld_StdQty, "-*" )

If ld_OnHand = -1 Then
	RollBack ;
	Close ( w_progress )
	Return
End if

iCounter++
w_progress.wf_progress ( iCounter / 5, "Deleting Audit Trail For Completed Object..." )

DELETE FROM audit_trail  
 WHERE ( serial = :ll_Serial ) AND  
       ( date_stamp = :ldt_Date )   ;

If SQLCA.SQLCode <> 0 Then
	RollBack ;
	Close ( w_progress )
	Return
End if

//  Create object, update onhand and delete audit trail for MI Function

iCounter++
w_progress.wf_progress ( iCounter / 5, "Re-creating Issued Object..." )

ldt_Date 	= u_audit_trail.dw_audit_trail.GetItemDateTime ( ll_MIRow, "date_stamp" )
ll_Serial 	= u_audit_trail.dw_audit_trail.GetItemNumber ( ll_MIRow, "serial" )

SELECT audit_trail.serial,   
       audit_trail.date_stamp,   
       audit_trail.type,   
       audit_trail.part,   
       audit_trail.quantity,   
       audit_trail.price,   
       audit_trail.customer,   
       audit_trail.vendor,   
       audit_trail.po_number,   
       audit_trail.operator,   
       audit_trail.from_loc,   
       audit_trail.lot,   
       audit_trail.weight,   
       audit_trail.status,   
       audit_trail.shipper,   
       audit_trail.unit,   
       audit_trail.workorder,   
       audit_trail.std_quantity,   
       audit_trail.custom2,   
       audit_trail.custom3,   
       audit_trail.custom4,   
       audit_trail.custom5,   
       audit_trail.plant,   
       audit_trail.notes,   
       audit_trail.package_type,   
       audit_trail.cost,   
       audit_trail.custom1  
  INTO :ll_Serial,   
       :ldt_Date,   
       :ls_Type,   
       :ls_Part,   
       :ld_Qty,   
       :ld_Price,   
       :ls_Customer,   
       :ls_Vendor,   
       :ls_PoNumber,   
       :ls_Operator,   
       :ls_From,   
       :ls_Lot,   
       :ld_Weight,   
       :ls_Status,   
       :ls_Shipper,   
       :ls_Unit,   
       :ls_WorkOrder,   
       :ld_StdQty,   
       :ls_Custom2,   
       :ls_Custom3,   
       :ls_Custom4,   
       :ls_Custom5,   
       :ls_Plant,   
       :ls_Notes,   
       :ls_PackageType,   
       :ld_Cost,   
       :ls_Custom1  
  FROM audit_trail
 WHERE ( audit_trail.serial = :ll_Serial ) AND  
       ( audit_trail.date_stamp = :ldt_Date )   ;

If SQLCA.SQLCode <> 0 Then
	MessageBox ( "Error", "An error occured while opening audit trail!", StopSign! )
	Close ( w_progress )
	Return
End if

li_Shipper = integer(ls_Shipper)

  UPDATE object  
     SET part = :ls_Part,   
         location = :ls_From,   
         last_date = :ld_Today,   
         unit_measure = :ls_Unit,   
         operator = :ls_Operator,   
         status = :ls_Status,   
         cost = :ld_Cost,   
         weight = :ld_Weight,   
         note = :ls_Notes,   
         quantity = :ld_Qty,   
         last_time = :lt_Time,   
         customer = :ls_Customer,   
         shipper = :li_Shipper,   
         lot = :ls_Lot,   
         po_number = :ls_PoNumber,   
         plant = :ls_Plant,   
         std_quantity = :ld_StdQty,   
         package_type = :ls_PackageType,   
         custom1 = :ls_Custom1,   
         custom2 = :ls_Custom2,   
         custom3 = :ls_Custom3,   
         custom4 = :ls_Custom4,   
         custom5 = :ls_Custom5,   
         tare_weight = :ld_TareWeight  
   WHERE serial = :ll_Serial   ;

If SQLCA.SQLCode <> 0 Then
	RollBack ;
	Close ( w_progress )
	Return
End if

iCounter++
w_progress.wf_progress ( iCounter / 5, "Updating Onhand For Issued Object..." )

ld_OnHand = f_update_onhand ( ls_Part, ld_StdQty, "+*" )

If ld_OnHand = -1 Then
	RollBack ;
	Close ( w_progress )
	Return
End if

iCounter++
w_progress.wf_progress ( iCounter / 5, "Deleting Audit Trail For Issued Object..." )

DELETE FROM audit_trail  
 WHERE ( serial = :ll_Serial ) AND  
       ( date_stamp = :ldt_Date ) ;
		 
If SQLCA.SQLCode <> 0 Then
	RollBack ;
	Close ( w_progress )
	Return
End if

//	Delete all the scrapped items against this object or serial
ls_Serial = String ( ll_Serial ) 
delete
from	defects
where	data_source = :ls_Serial;

If SQLCA.SQLCode <> 0 Then
	RollBack ;
	Return
End if

Commit ;

Close ( w_progress )

u_audit_trail.dw_audit_trail.SetTransObject ( sqlca )
u_audit_trail.dw_audit_trail.Retrieve ( ll_serial )

u_audit_trail.SetRedraw ( TRUE )
end event

on ue_close_audit_trail;CloseUserObject ( u_audit_trail )
wf_enable_screen ( )
wf_set_focus ( )
end on

on ue_save_note;is_Notes = u_generic_it_note.mle_note.Text
This.CloseUserObject ( u_generic_it_note )
wf_enable_except_buttons ( )
wf_set_focus ( )
ib_Notes = FALSE
end on

on ue_close_uo_note;This.CloseUserObject ( u_generic_it_note )
wf_enable_except_buttons ( )
wf_set_focus ( )
ib_Notes = FALSE
end on

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
cb__.Enabled = False
cb_space.Enabled = False
cb_-.Enabled = False


end subroutine

public subroutine enable_chars ();bChars = True
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
cb__.Enabled = TRUE
cb_space.Enabled = TRUE
cb_-.Enabled = TRUE

end subroutine

public subroutine disable_numbers ();bNumbers = False
cb_0.Enabled = False
cb_1.Enabled = False
cb_2.Enabled = False
cb_3.Enabled = False
cb_4.Enabled = False
cb_5.Enabled = False
cb_6.Enabled = False
cb_7.Enabled = False
cb_8.Enabled = False
cb_9.Enabled = False

end subroutine

public subroutine enable_numbers ();bNumbers = True
cb_0.Enabled = True
cb_1.Enabled = True
cb_2.Enabled = True
cb_3.Enabled = True
cb_4.Enabled = True
cb_5.Enabled = True
cb_6.Enabled = True
cb_7.Enabled = True
cb_8.Enabled = True
cb_9.Enabled = True

end subroutine

public subroutine wf_reset_indicators ();bOperator = False
bSerial   = False
bfinishedpartlist = False
wf_reset_colors ( )
end subroutine

public subroutine wf_enable_screen ();cb_a.Enabled = TRUE
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
cb_back.Enabled = TRUE
cb_enter.Enabled = TRUE
cb_space.Enabled = TRUE
cb__.Enabled = TRUE
cb_period.Enabled = TRUE
cb_0.Enabled = TRUE
cb_1.Enabled = TRUE
cb_2.Enabled = TRUE
cb_3.Enabled = TRUE
cb_4.Enabled = TRUE
cb_5.Enabled = TRUE
cb_6.Enabled = TRUE
cb_7.Enabled = TRUE
cb_8.Enabled = TRUE
cb_9.Enabled = TRUE
cb_-.Enabled = TRUE
cb_exit.Enabled = TRUE
cb_audit_trail.Enabled = TRUE
cb_notes.Enabled = TRUE
cb_clear.Enabled = TRUE
sle_operator.Enabled = TRUE
sle_serial.Enabled = TRUE
dw_1.Enabled = TRUE
dw_2.Enabled = TRUE
end subroutine

public subroutine wf_disable_screen ();cb_a.Enabled = False
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
cb_back.Enabled = False
cb_enter.Enabled = False
cb_space.Enabled = False
cb__.Enabled = False
cb_period.Enabled = False
cb_0.Enabled = False
cb_1.Enabled = False
cb_2.Enabled = False
cb_3.Enabled = False
cb_4.Enabled = False
cb_5.Enabled = False
cb_6.Enabled = False
cb_7.Enabled = False
cb_8.Enabled = False
cb_9.Enabled = False
cb_-.Enabled = False
cb_exit.Enabled = False
cb_audit_trail.Enabled = False
cb_notes.Enabled = False
cb_clear.Enabled = False
sle_operator.Enabled = FALSE
sle_serial.Enabled = FALSE
dw_1.Enabled = FALSE
dw_2.Enabled = FALSE
end subroutine

public subroutine wf_reset_colors ();//gb_operator.TextColor = f_get_color_value ( "darkred" )
//gb_serial.TextColor   = f_get_color_value ( "darkred" )
//gb_3.TextColor        = f_get_color_value ( "darkred" )

gb_operator.TextColor = f_get_color_value ( "black" )
gb_serial.TextColor   = f_get_color_value ( "black" )
gb_3.TextColor        = f_get_color_value ( "black" )
end subroutine

public subroutine wf_change_color_focus ();//If bOperator Then
//	gb_operator.TextColor = f_get_color_value ( "blue" )
//Elseif bSerial Then
//	gb_serial.TextColor = f_get_color_value ( "blue" )
//Elseif bfinishedpartlist Then
//	gb_3.TextColor = f_get_color_value ( "blue" )
//End if
//

If bOperator Then
	gb_operator.TextColor = f_get_color_value ( "black" )
Elseif bSerial Then
	gb_serial.TextColor = f_get_color_value ( "black" )
Elseif bfinishedpartlist Then
	gb_3.TextColor = f_get_color_value ( "black" )
End if

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
Timer ( .25 )
end subroutine

public subroutine wf_hide_message ();Timer ( 0 )
sle_status.Visible = False
bMessage = False

end subroutine

public subroutine wf_key_pressed (character ccharacter);Int iSelectedPosition

IF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = u_audit_trail.sle_operator_password.Text + cCharacter
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = u_generic_it_note.mle_note.Text + cCharacter
ELSE
	bKeyPressed = True

	If bOperator Then
		sle_operator.Text = sle_operator.Text + cCharacter
		sle_operator.SetFocus ( )
	Elseif bSerial Then
		sle_serial.Text = sle_serial.Text + cCharacter
		sle_serial.SetFocus ( )
	End if
END IF
end subroutine

public function boolean wf_check_operator ();SELECT operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE password = :sle_operator.Text   ;

If SQLCA.SQLCode <> 0 Then
	f_beep ( 3 )
	gb_operator.Text = "Operator - "
	MessageBox ( "Error", "Invalid Operator Password!  Please try again.", StopSign! )
	sle_operator.Text = ""
	Return False
Else
	gb_operator.Text = "Operator - " + szOperator
	Return True
End if
end function

public function boolean wf_combo_scan ();String 	szFromLoc
String	szPlant
String	szNewLocation
String	ls_Temp
Long 		lRow
Dec		dCost
Dec		dUnitWeight
Dec		ld_StdQty
Dec		ld_NewOnHand
Int		iCounter = 0
Int 		iRtnCode

st_generic_structure stParm
str_progress stProgress

stProgress.Title = "Combo Scan"

dw_1.SetTransObject ( sqlca )
dw_2.SetTransObject ( sqlca )
dw_object_data.SetTransObject ( sqlca )

st_2.Visible = False

//lSerial = Long ( f_serial_validate(sle_serial.Text ))

If f_get_value ( lSerial ) = 0 Then 
	dw_2.Reset ( )
	dw_1.Reset ( )
   sle_serial.text = ""
  	MessageBox ( "Error", "Invalid Serial Number!", StopSign! )
	Return False
End if

SELECT object.status  
  INTO :ls_Temp  
  FROM object  
 WHERE object.serial = :lSerial   ;

If SQLCA.SQLCode <> 0 Then 
	dw_2.Reset ( )
	dw_1.Reset ( )
   sle_serial.text = ""
  	MessageBox ( "Error", "Invalid Serial Number!", StopSign! )
   wf_set_focus ( )
   Return False
End if

If ls_Temp <> 'A' Then
	dw_2.Reset ( )
	dw_1.Reset ( )
	MessageBox ( "Error", "This function is only allowed on approved objects!", StopSign! )
	Return False
End if

OpenWithParm ( w_progress, stProgress )

If dw_2.Retrieve ( lSerial ) < 1 Then 
	Close ( w_progress )
	dw_2.Reset ( )
	dw_1.Reset ( )
	MessageBox ( "Error", "Unable to get object information!", StopSign! )
	Return False
End if

If dw_object_data.Retrieve ( lSerial ) < 1 Then 
	Close ( w_progress )
	dw_2.Reset ( )
	dw_1.Reset ( )
	MessageBox ( "Error", "Unable to get object information!", StopSign! )
	Return False
End if

iCounter++
w_progress.wf_progress ( iCounter / 10,"Grabbing current part number..." )

szOldChildPart = f_get_string_value ( dw_object_data.GetItemString ( 1, "part" ) )

iCounter++
w_progress.wf_progress ( iCounter / 10,"Grabbing parent part number..." )

If dw_fp_list.rowcount()  < 1 Then 
	Close ( w_progress )
	dw_2.Reset ( )
	dw_1.Reset ( )
	MessageBox ( "Error", "Unable to locate parent part in flow router!  Please check flow router setups.", StopSign! )
	Return False
ElseIf dw_fp_list.RowCount ( ) > 1 Then	
	Close ( w_progress )
	dw_2.Reset ( )
	dw_1.Reset ( )
	MessageBox ( "Error", "This function is only allowed on one->one relationship in flow router.~rYou must do a Job Completion and Material Issue on this Part.", StopSign! )
	Return False
End if

szParentPart = f_get_string_value ( dw_fp_list.GetItemString ( 1, "part" ) )

// ** commented code was here 

szNewChildPart 	= szparentpart
szLastOperation 	= ''
szNewLocation		= dw_2.GetItemString ( 1, "location" )

iCounter++
w_progress.wf_progress ( iCounter / 10,"Grabbing new unit cost..." )


SELECT cost  
  INTO :dCost  
  FROM part_standard  
 WHERE part = :szNewChildPart   ;  

dCost = f_get_value ( dCost )
SELECT location
  INTO :szFromLoc
  FROM object
 WHERE serial = :lSerial ;

SELECT plant  
  INTO :szPlant  
  FROM location  
 WHERE code = :szFromLoc   ;

iCounter++
w_progress.wf_progress ( iCounter / 10,"Issuing material..." )

ld_StdQty = dw_2.GetItemNumber ( 1, "std_quantity" )

ld_NewOnHand = f_update_onhand ( dw_2.GetItemSTring ( 1, "part" ), ld_StdQty, "- " )

If ld_NewOnHand = -1 Then
	RollBack ;
	Return False
End if

if not (f_create_audit_trail ( lSerial, &
	'M', &
	String ( dw_2.GetItemNumber ( 1, "quantity" ) ), &
	String ( ld_StdQty ), &
	dw_2.GetItemString ( 1, "unit_measure" ), &
	szNewLocation, &
	"", &
	"", &
	szPlant, &
	"", &
	szOperator, &
	"No Commit" ) ) then 
	RollBack ;
	Return False
end if 

dw_object_data.SetITem ( 1, "part", szNewChildPart )
dw_object_data.SetItem ( 1, "cost", dCost )
dw_object_data.SetItem ( 1, "location", szNewLocation )
dw_object_data.SetItem ( 1, "operator", szOperator )
dw_object_data.SetItem ( 1, "last_date", Today ( ) )
dw_object_data.SetItem ( 1, "last_time", Now ( ) )
dw_object_data.SetItem ( 1, "note", is_Notes )

iCounter++
w_progress.wf_progress ( iCounter / 10,"Completing new part..." )

If dw_object_data.Update ( ) = -1 Then
	RollBack ;
	Return False	
End if

dw_1.Retrieve ( lSerial )

iCounter++
w_progress.wf_progress ( iCounter / 10,"Creating audit trail..." )

ld_NewOnHand = f_update_onhand ( szNewChildPart, ld_StdQty, "+ " )

If ld_NewOnHand = -1 Then
	RollBack ;
	Return False
End if

if not (f_create_audit_trail ( lSerial, &
	'J', &
	"", &
	String ( dCost ), &
	dw_2.GetItemString ( 1, "location" ), &
	'Normal', &
	"", &
	String ( ld_NewOnHand ), &
	"", &
	"", &
	szOperator, &
	"No Commit" ) ) then 
	RollBack ;
	Return False
end if 

stParm.Value1  = String ( lSerial )
stParm.Value2  = szParentPart
stParm.Value7  = szLastOperation
stParm.Value11 = String ( 1 )

if cb_47.text = 'Defects-Yes' then
	iRtnCode = MessageBox ( "Defects", "Report any defects?", Question!, YesNo!, 2 )
	If iRtnCode = 1 Then wf_enter_defects ( )
end if 	

commit ;


iCounter++
w_progress.wf_progress ( iCounter / 10,"Printing smart label..." )

f_print_label ( stParm )

wf_show_message ( )

sle_serial.Text = ""

Close ( w_progress )

Return True
end function

public subroutine wf_set_focus ();bSetFocus = True
bKeyPressed = true

If bOperator Then
	sle_operator.SetFocus ( )
Elseif bSerial Then
	sle_serial.Text = ""
	sle_serial.SetFocus ( )
End if
end subroutine

public subroutine wf_enter_defects ();Long 		lQty
Long 		lPriorQty
Long 		lNewQty
Long 		lStdQty
Long     lDividerPos
Long		ld_NewOnHand
String 	szString
String	szReason

st_generic_structure stParm

If dw_1.RowCount ( ) < 1 Then Return

stParm.Value1 = dw_2.GetItemString ( 1, "location" )
stParm.Value2 = dw_1.GetItemString ( 1, "part" )
stParm.Value3 = String ( dw_2.GetItemNumber ( 1, "quantity" ) )
stParm.Value4 = String (lserial)
stParm.Value5 = szoperator

OpenWithParm ( w_defects_entry, stParm )

szString = Message.StringParm

lDividerPos = PosA ( szString, "/" )

lQty = Long ( LeftA ( szString, lDividerPos - 1 ) )
szReason = RightA ( szString, LenA ( szString ) - lDividerPos )

If lQty > 0 Then
	lPriorQty = dw_object_data.GetItemNumber ( 1, "quantity" )
	lNewQty = lPriorQty - lQty
	lStdQty = f_convert_units ( dw_object_data.GetItemString ( 1, "unit_measure" ), "", szNewChildPart, lNewQty )
	dw_object_data.SetItem ( 1, "quantity", lNewQty )
	dw_object_data.SetItem ( 1, "std_quantity", lStdQty )
	If dw_object_data.Update ( ) = -1 Then
		RollBack ;
	Else
		ld_NewOnHand = f_update_onhand ( szNewChildPart, lQty, "-*" )
		If ld_NewOnHand = -1 Then
			RollBack ;
		Else
			dw_3.SetTransObject ( sqlca )
			dw_3.Retrieve ( lSerial )
			dw_3.SetItem ( 1, "quantity", lNewQty )
			dw_3.SetItem ( 1, "std_quantity", lStdQty )
			dw_3.SetItem ( 1, "remarks", szReason )
			dw_3.SetItem ( 1, "on_hand", ld_NewOnHand )
			If dw_3.Update ( ) = -1 Then
				RollBack ;
			Else
				Commit ;
			End if
		End if
		dw_1.Retrieve ( lSerial )
	End if
End if

sle_serial.SetFocus ( )
end subroutine

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

public subroutine wf_disable_except_buttons ();cb_enter.Enabled = False
cb_exit.Enabled = False
cb_audit_trail.Enabled = False
cb_notes.Enabled = False
sle_operator.Enabled = FALSE
sle_serial.Enabled = FALSE
dw_1.Enabled = FALSE
dw_2.Enabled = FALSE
end subroutine

public subroutine wf_enable_except_buttons ();cb_enter.Enabled = TRUE
cb_exit.Enabled = TRUE
cb_audit_trail.Enabled = TRUE
cb_notes.Enabled = TRUE
sle_operator.Enabled = TRUE
sle_serial.Enabled = TRUE
dw_1.Enabled = TRUE
dw_2.Enabled = TRUE
end subroutine

public subroutine wf_get_parents_part (long arg_serial);STRING l_s_serial_part,&
  	    l_s_Temp

//lSerial = arg_serial 

SELECT object.status,
       object.part
  INTO :l_s_Temp,
       :l_s_serial_part
  FROM object  
 WHERE object.serial = :lserial ;

If SQLCA.SQLCode <> 0 Then 
	dw_2.Reset ( )
	dw_1.Reset ( )
   sle_serial.text = ""
  	MessageBox ( "Error", "Invalid Serial Number!", StopSign! )
   wf_set_focus ( )
   Return 
End if

If l_s_Temp <> 'A' Then
	dw_2.Reset ( )
	dw_1.Reset ( )
	MessageBox ( "Error", "This function is only allowed on approved objects!", StopSign! )
	Return
End if
If not isnull(l_s_serial_part) and l_s_serial_part<>'' Then 
	dw_fp_list.getchild('part',i_dwc_child)
	i_dwc_child.settransobject(sqlca)
	If i_dwc_child.retrieve(l_s_serial_part) = -1 Then i_dwc_child.insertrow(0)
	IF i_dwc_child.rowcount()=0 THEN
		dw_2.Reset ( )
		dw_1.Reset ( )
		Messagebox("Error", "This object can not be combo scanned, it has reached the last step of the flow router.", StopSign! )
		sle_serial.text=''
		Return 
	End if 
	dw_fp_list.insertrow(0) 						
	IF i_dwc_child.rowcount() > 1 THEN
		gb_3.show()
	   	dw_fp_list.show()	
		dw_fp_list.setfocus()
	ELSE
		gb_3.hide()
	   	dw_fp_list.hide()	
		IF i_dwc_child.getitemstring(1,'parent_part')='' or ISNULL(i_dwc_child.getitemstring(1,'parent_part')) THEN
			dw_2.Reset ( )
			dw_1.Reset ( )
			Messagebox("Error", "This object can not be combo scanned, it has reached the last step of the flow router.", StopSign! )
			sle_serial.text=''
			Return 
		Else	
			dw_fp_list.setitem(1,'part',i_dwc_child.getitemstring(1,'parent_part')) 
		   	wf_combo_scan ( )
		END IF 	
	END IF 	
ELSE
	dw_2.Reset ( )
	dw_1.Reset ( )
	Messagebox("Error", "This object can not be combo scanned, it has reached the last step of the flow router.", StopSign! )
	sle_serial.text=''
END IF 	
end subroutine

on timer;If sle_status.Visible = True Then
	sle_status.Visible = False
Else
	sle_status.Visible = True
End if

end on

event open;/*  Initialize Variables  */

bChars   = True
bNumbers = True
szRealityText   = ""
dtToday  = DateTime ( Today ( ) ) //, Now ( ) )

end event

on w_combo_scan.create
this.dw_fp_list=create dw_fp_list
this.dw_3=create dw_3
this.st_4=create st_4
this.st_2=create st_2
this.dw_return_parent_part=create dw_return_parent_part
this.dw_object_data=create dw_object_data
this.dw_1=create dw_1
this.sle_serial=create sle_serial
this.sle_operator=create sle_operator
this.sle_status=create sle_status
this.st_1=create st_1
this.cb_back=create cb_back
this.cb_space=create cb_space
this.cb_48=create cb_48
this.cb_47=create cb_47
this.cb_notes=create cb_notes
this.cb_44=create cb_44
this.cb_audit_trail=create cb_audit_trail
this.cb__=create cb__
this.cb_period=create cb_period
this.cb_-=create cb_-
this.cb_0=create cb_0
this.cb_exit=create cb_exit
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
this.sle_title=create sle_title
this.dw_2=create dw_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_serial=create gb_serial
this.gb_operator=create gb_operator
this.sle_1=create sle_1
this.Control[]={this.dw_fp_list,&
this.dw_3,&
this.st_4,&
this.st_2,&
this.dw_return_parent_part,&
this.dw_object_data,&
this.dw_1,&
this.sle_serial,&
this.sle_operator,&
this.sle_status,&
this.st_1,&
this.cb_back,&
this.cb_space,&
this.cb_48,&
this.cb_47,&
this.cb_notes,&
this.cb_44,&
this.cb_audit_trail,&
this.cb__,&
this.cb_period,&
this.cb_-,&
this.cb_0,&
this.cb_exit,&
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
this.sle_title,&
this.dw_2,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.gb_serial,&
this.gb_operator,&
this.sle_1}
end on

on w_combo_scan.destroy
destroy(this.dw_fp_list)
destroy(this.dw_3)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.dw_return_parent_part)
destroy(this.dw_object_data)
destroy(this.dw_1)
destroy(this.sle_serial)
destroy(this.sle_operator)
destroy(this.sle_status)
destroy(this.st_1)
destroy(this.cb_back)
destroy(this.cb_space)
destroy(this.cb_48)
destroy(this.cb_47)
destroy(this.cb_notes)
destroy(this.cb_44)
destroy(this.cb_audit_trail)
destroy(this.cb__)
destroy(this.cb_period)
destroy(this.cb_-)
destroy(this.cb_0)
destroy(this.cb_exit)
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
destroy(this.sle_title)
destroy(this.dw_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_serial)
destroy(this.gb_operator)
destroy(this.sle_1)
end on

type dw_fp_list from datawindow within w_combo_scan
event ue_validate pbm_custom01
int X=55
int Y=932
int Width=731
int Height=120
int TabOrder=50
boolean Visible=false
string DataObject="d_parent_parts_list"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_validate;if dw_fp_list.object.part [ 1 ] <>  "" then  
	wf_combo_scan ( )	
	dw_fp_list.reset()
	gb_3.hide()
	dw_fp_list.hide()
end if 
end event

event constructor;dw_fp_list.getchild('part',i_dwc_child)
i_dwc_child.settransobject(sqlca)
If i_dwc_child.retrieve('')= -1 Then i_dwc_child.insertrow(0)
This.settransobject(sqlca)
end event

event itemchanged;IF dw_fp_list.rowcount()=0 THEN dw_fp_list.insertrow(0)
dw_fp_list.Accepttext()

end event

event getfocus;wf_reset_indicators()
wf_reset_colors()
bfinishedpartlist= True
wf_change_color_focus()
end event

event losefocus;if dw_fp_list.object.part [ 1 ] <>  "" then  
	TriggerEvent('ue_validate')	
end if 	

end event

type dw_3 from datawindow within w_combo_scan
int X=1573
int Y=2020
int Width=494
int Height=364
int TabOrder=30
boolean Visible=false
string DataObject="d_audit_trail"
boolean LiveScroll=true
end type

type st_4 from statictext within w_combo_scan
int Y=12
int Width=846
int Height=140
boolean Enabled=false
string Text="Combo Scan"
Alignment Alignment=Center!
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

type st_2 from statictext within w_combo_scan
int X=1024
int Y=784
int Width=1262
int Height=256
boolean Visible=false
boolean Enabled=false
string Text="This object can not be combo scanned, it has reached the last step of the flow router."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=255
long BackColor=77897888
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_return_parent_part from datawindow within w_combo_scan
int X=549
int Y=2016
int Width=494
int Height=364
int TabOrder=60
boolean Visible=false
string DataObject="d_get_parent_for_part"
boolean LiveScroll=true
end type

type dw_object_data from datawindow within w_combo_scan
int X=37
int Y=2016
int Width=494
int Height=364
boolean Visible=false
string DataObject="d_object_information_all_for_update"
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_combo_scan
int X=882
int Y=752
int Width=1536
int Height=336
string DataObject="d_object_information"
boolean Border=false
end type

type sle_serial from singlelineedit within w_combo_scan
int X=55
int Y=608
int Width=731
int Height=128
int TabOrder=40
boolean AutoHScroll=false
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

event modified;If KeyDown ( keyEnter! )  OR KeyDown ( keyTab! ) Then
	dw_fp_list.reset()
	lserial = Long(f_serial_validate(sle_serial.text))
	wf_get_parents_part( lserial )
	//   wf_combo_scan ( )	// this will be called from the above function or from the dddw
	is_Notes = ""
End if
end event

on getfocus;If Not bSerial And Not bBack And Not bForward And Not KeyDown ( keyTab! ) And sle_serial.PointerX ( ) > 0 Then 
	wf_set_focus ( )
	Return
End if

If Not bOperator And Not bKeyPressed And Not bSetFocus Then

	bKeyPressed = False
	bSetFocus = False
	wf_set_focus ( )

ElseIf wf_check_operator ( ) Then

	If bChars Then disable_chars ( )
	If Not bNumbers Then enable_numbers ( )

	bKeyPressed = False
	bSetFocus = False

	wf_reset_indicators ( )

	bSerial = True

	wf_change_color_focus ( )

Else

	bKeyPressed = False
	bSetFocus = False

	sle_operator.SetFocus ( )

End if

If bBack Or bForward Then

	bBack    = False
	bForward = False

End if


end on

type sle_operator from singlelineedit within w_combo_scan
int X=55
int Y=320
int Width=731
int Height=128
int TabOrder=20
boolean AutoHScroll=false
boolean PassWord=true
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=16777215
int TextSize=-20
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;if KeyDown ( keyTab! ) or KeyDown ( keyEnter! ) then
	sle_1.Text = ""
	If wf_check_operator ( ) Then 
		sle_serial.SetFocus ( )
		sle_1.Text = ""
	Else
		sle_1.Text = ""
	End if
end if

end on

on getfocus;wf_reset_indicators ( )

If Not bChars Then enable_chars ( )
If Not bNumbers Then enable_numbers ( )

bOperator = True

wf_change_color_focus ( )


end on

type sle_status from statictext within w_combo_scan
int X=942
int Y=12
int Width=695
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

type st_1 from statictext within w_combo_scan
int X=1710
int Y=8
int Width=1207
int Height=144
boolean Enabled=false
string Text="[Enter Button] / [Tab Key]-Next Field           [Back Button] / [<Shift>Tab]-Previous Field "
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

type cb_back from commandbutton within w_combo_scan
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

on clicked;If bMessage Then wf_hide_message ( )

IF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = LeftA ( u_audit_trail.sle_operator_password.Text, LenA ( u_audit_trail.sle_operator_password.Text ) - 1 )
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = LeftA ( u_generic_it_note.mle_note.Text, LenA ( u_generic_it_note.mle_note.Text ) - 1 )
ELSE
	bBack = True

	If bOperator Then
		sle_operator.SetFocus ( )
	Elseif bSerial Then
		sle_operator.SetFocus ( )
	End if
END IF
end on

type cb_space from commandbutton within w_combo_scan
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

type cb_48 from commandbutton within w_combo_scan
event button_clicked pbm_custom01
int X=2450
int Y=480
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

on clicked;//Long 		lQty
//Long 		lPriorQty
//Long 		lNewQty
//Long 		lStdQty
//Long     lDividerPos
//String 	szString
//String	szReason
//
//st_generic_structure stParm
//
//If dw_1.RowCount ( ) < 1 Then Return
//
//stParm.Value1 = dw_2.GetItemString ( 1, "location" )
//stParm.Value2 = dw_1.GetItemString ( 1, "part" )
//
//OpenWithParm ( w_defects_entry, stParm )
//
//szString = Message.StringParm
//
//lDividerPos = Pos ( szString, "/" )
//
//lQty = Long ( Left ( szString, lDividerPos - 1 ) )
//szReason = Right ( szString, Len ( szString ) - lDividerPos )
//
//If lQty > 0 Then
//	lPriorQty = dw_object_data.GetItemNumber ( 1, "quantity" )
//	lNewQty = lPriorQty - lQty
//	lStdQty = f_convert_units ( dw_object_data.GetItemString ( 1, "unit_measure" ), "", szNewChildPart, lNewQty )
//	dw_object_data.SetItem ( 1, "quantity", lNewQty )
//	dw_object_data.SetItem ( 1, "std_quantity", lStdQty )
//	If dw_object_data.Update ( ) = -1 Then
//		RollBack ;
//	Else
//		Commit ;
//		dw_3.SetTransObject ( sqlca )
//		dw_3.Retrieve ( dtToday )
//		dw_3.SetItem ( 1, "quantity", lNewQty )
//		dw_3.SetItem ( 1, "std_quantity", lStdQty )
//		dw_3.SetItem ( 1, "remarks", szReason )
//		If dw_3.Update ( ) = -1 Then
//			RollBack ;
//		Else
//			Commit ;
//		End if
//		dw_1.Retrieve ( lSerial )
//	End if
//	
//End if
//
//sle_serial.SetFocus ( )
end on

type cb_47 from commandbutton within w_combo_scan
int X=2450
int Y=800
int Width=475
int Height=160
string Text="Defects-Yes"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if text = 'Defects-Yes' then
	text = 'Defects-No'
else
	text = 'Defects-Yes'
end if

	
end event

type cb_notes from commandbutton within w_combo_scan
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

on clicked;//wf_disable_screen ( )
//wf_notes_attrib ( True )
//

ib_Notes = TRUE
wf_disable_except_buttons ( )
Parent.OpenUserObjectWithParm ( u_generic_it_note, is_Notes, 550, 200 )
u_generic_it_note.BringToTop = TRUE
IF is_Notes <> "" THEN u_generic_it_note.mle_note.Text = is_Notes
end on

type cb_44 from commandbutton within w_combo_scan
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

type cb_audit_trail from commandbutton within w_combo_scan
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

str_Parm.adt_Today = dtToday
str_Parm.as_TransactionType = "CS"
str_parm.as_machine=string(lserial)

wf_disable_screen ( )

OpenUserObjectWithParm ( u_audit_trail, str_Parm, 55, 150 )
u_audit_trail.BringToTop = TRUE


//If bMessage Then wf_hide_message ( )
//
//SetPointer ( HourGlass! )
//
//wf_disable_screen ( )
//dw_3.Reset ( )
//wf_show_audit_trail ( )
//
//
end event

type cb__ from commandbutton within w_combo_scan
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

type cb_period from commandbutton within w_combo_scan
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

type cb_- from commandbutton within w_combo_scan
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

type cb_0 from commandbutton within w_combo_scan
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

type cb_exit from commandbutton within w_combo_scan
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

on clicked;IF is_Transaction > '' THEN
	IF MessageBox ( "Exit", "Are you sure you want to exit?", Question!, YesNo!, 2 ) = 1 THEN
		Halt
	END IF
ELSE
	Close ( Parent )
END IF

end on

type cb_clear from commandbutton within w_combo_scan
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

on clicked;If bMessage Then wf_hide_message ( )

IF ib_Password THEN
	u_audit_trail.sle_operator_password.Text = ""
	u_audit_trail.sle_operator_code.Text = ""
ELSEIF ib_Notes THEN
	u_generic_it_note.mle_note.Text = ""
ELSE
	If bSerial Then
		sle_serial.Text = ""
		sle_serial.SetFocus ( )
	Elseif bOperator Then
		sle_operator.Text = ""
		sle_operator.SetFocus ( )
	End if
END IF
end on

type cb_9 from commandbutton within w_combo_scan
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

type cb_8 from commandbutton within w_combo_scan
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

type cb_7 from commandbutton within w_combo_scan
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

type cb_6 from commandbutton within w_combo_scan
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

type cb_y from commandbutton within w_combo_scan
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

type cb_z from commandbutton within w_combo_scan
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

type cb_enter from commandbutton within w_combo_scan
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

bForward = True

If bOperator Then
	If wf_check_operator ( ) Then	
		sle_serial.SetFocus ( )
	Else
		sle_operator.SetFocus ( )
	End if
Elseif bSerial Then
   wf_get_parents_part(Long(f_serial_validate(sle_serial.text)))	
Elseif bfinishedpartlist Then
	dw_fp_list.Triggerevent('ue_validate')
End if

end event

type cb_1 from commandbutton within w_combo_scan
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

type cb_2 from commandbutton within w_combo_scan
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

type cb_3 from commandbutton within w_combo_scan
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

type cb_4 from commandbutton within w_combo_scan
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

type cb_5 from commandbutton within w_combo_scan
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

type cb_q from commandbutton within w_combo_scan
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

type cb_r from commandbutton within w_combo_scan
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

type cb_s from commandbutton within w_combo_scan
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

type cb_t from commandbutton within w_combo_scan
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

type cb_u from commandbutton within w_combo_scan
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

type cb_v from commandbutton within w_combo_scan
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

type cb_w from commandbutton within w_combo_scan
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

type cb_x from commandbutton within w_combo_scan
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

type cb_i from commandbutton within w_combo_scan
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

type cb_j from commandbutton within w_combo_scan
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

type cb_k from commandbutton within w_combo_scan
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

type cb_l from commandbutton within w_combo_scan
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

type cb_m from commandbutton within w_combo_scan
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

type cb_n from commandbutton within w_combo_scan
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

type cb_o from commandbutton within w_combo_scan
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

type cb_p from commandbutton within w_combo_scan
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

type cb_h from commandbutton within w_combo_scan
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

type cb_g from commandbutton within w_combo_scan
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

type cb_f from commandbutton within w_combo_scan
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

type cb_e from commandbutton within w_combo_scan
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

type cb_d from commandbutton within w_combo_scan
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

type cb_c from commandbutton within w_combo_scan
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

type cb_b from commandbutton within w_combo_scan
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

type cb_a from commandbutton within w_combo_scan
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

type sle_title from singlelineedit within w_combo_scan
int Width=2926
int Height=160
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="Arial"
boolean Italic=true
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_combo_scan
int X=878
int Y=304
int Width=1536
int Height=336
string DataObject="d_object_information"
boolean Border=false
end type

type gb_3 from groupbox within w_combo_scan
int X=9
int Y=828
int Width=805
int Height=280
int TabOrder=70
boolean Visible=false
string Text="Finished Parts List"
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

type gb_2 from groupbox within w_combo_scan
int X=841
int Y=672
int Width=1591
int Height=448
string Text="New Object Information"
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

type gb_1 from groupbox within w_combo_scan
int X=841
int Y=224
int Width=1591
int Height=448
string Text="Previous Object Information"
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

type gb_serial from groupbox within w_combo_scan
int X=14
int Y=516
int Width=805
int Height=256
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

type gb_operator from groupbox within w_combo_scan
int X=18
int Y=224
int Width=805
int Height=256
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

type sle_1 from singlelineedit within w_combo_scan
int X=914
int Width=841
int Height=80
int TabOrder=10
boolean Visible=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type


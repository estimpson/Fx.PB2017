$PBExportHeader$w_package_qty.srw
forward
global type w_package_qty from Window
end type
type sle_cover from singlelineedit within w_package_qty
end type
type dw_1 from datawindow within w_package_qty
end type
type cb_2 from commandbutton within w_package_qty
end type
type cb_1 from commandbutton within w_package_qty
end type
end forward

global type w_package_qty from Window
int X=96
int Y=412
int Width=2725
int Height=832
boolean TitleBar=true
string Title="Packaging Attributes"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
sle_cover sle_cover
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_package_qty w_package_qty

type variables
Boolean bExit
boolean		ib_messagebox
Long il_Counter = 0
end variables

forward prototypes
public subroutine wf_build_unit_list (string as_part)
end prototypes

public subroutine wf_build_unit_list (string as_part);DataWindowChild	ldwc_unit_list
Long					ll_sequence,&
						ll_new_row
String				ls_Unit1,&
						ls_Unit2, &
						ls_StdUnit

SELECT standard_unit
  INTO :ls_StdUnit
  FROM part_inventory
 WHERE part = :as_Part	;

DECLARE cu_units CURSOR for
SELECT unit_conversion.unit1,   
       unit_conversion.unit2  
  FROM part_unit_conversion,   
       unit_conversion  
 WHERE ( part_unit_conversion.code = unit_conversion.code ) and  
       ( ( part_unit_conversion.part = :as_Part ) )   ;

dw_1.GetChild ( "unit", ldwc_unit_list )

Open cu_units;
Fetch cu_units into :ls_Unit1, :ls_Unit2;
Do While sqlca.sqlcode = 0
	ll_sequence = ldwc_unit_list.Find ( "data = '" + ls_Unit1 + "'", 1, ldwc_unit_list.RowCount ( ) )
	If ll_sequence < 1 then
		ll_new_row = ldwc_unit_list.InsertRow ( 0 )
		ldwc_unit_list.SetItem ( ll_new_row, "data", ls_Unit1 )
	End if
	ll_sequence = ldwc_unit_list.Find ( "data = '" + ls_Unit2 + "'", 1, ldwc_unit_list.RowCount ( ) )
	If ll_sequence < 1 then
		ll_new_row = ldwc_unit_list.InsertRow ( 0 )
		ldwc_unit_list.SetItem ( ll_new_row, "data", ls_Unit2 )
	End if
	Fetch cu_units into :ls_Unit1, :ls_Unit2;
Loop
Close cu_units;

ll_sequence = ldwc_unit_list.Find ( "data = '" + ls_StdUnit + "'", 1, ldwc_unit_list.RowCount ( ) )
If ll_sequence < 1 then
	ll_new_row = ldwc_unit_list.InsertRow ( 0 )
	ldwc_unit_list.SetItem ( ll_new_row, "data", ls_StdUnit )
End if

end subroutine

event open;String	s_UseScale, &
			s_ScaleType, &
			s_Unit, &
			s_Part, &
			s_PartType,&
			l_s_std_unit
DataWindowChild	l_dwc_unit

st_generic_structure	str_Parm

str_Parm = Message.PowerObjectParm

dw_1.SetTransObject ( sqlca )

dw_1.GetChild ( "unit", l_dwc_unit )
l_dwc_unit.SetTransObject ( sqlca )
l_dwc_unit.Retrieve ( str_parm.value1 )

If str_Parm.Value3 = "Add" Then
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "part", str_Parm.Value1 )
	dw_1.SetItem ( 1, "code", str_Parm.Value2 )
	dw_1.SetItem ( 1, "serial_type", "(None)" )
	SELECT 	part_inventory.standard_unit  
   INTO 		:l_s_std_unit  
   FROM 		part_inventory  
   WHERE 	part_inventory.part = :str_Parm.Value1   ;
	dw_1.SetItem ( 1, "unit", l_s_std_unit )
Else
	dw_1.Retrieve ( str_Parm.Value1, str_Parm.Value2 )
End if

//s_ScaleType	= dw_1.GetItemString ( 1, "trigger_type" )
//s_UseScale 	= dw_1.GetItemString ( 1, "scale_interface" )

s_Part = dw_1.GetItemString ( 1, "part" )

SELECT type
  INTO :s_PartType
  FROM part
 WHERE part = :s_Part	;

//wf_build_unit_list ( s_Part )
s_Unit = dw_1.GetItemString ( 1, "unit" )

//IF IsNull ( s_Unit ) OR s_Unit = "" THEN
//	dw_1.Modify ( "stage_using_weight.color = 8421504"  )
//	dw_1.Modify ( "stage_using_weight.TabSequence = 0" )
//ELSE
//	dw_1.Modify ( "stage_using_weight.color = 8388608"  )
//	dw_1.Modify ( "stage_using_weight.TabSequence=150" )
//END IF

dw_1.SetColumn ( "quantity" )
dw_1.SetFocus ( )
end event

on w_package_qty.create
this.sle_cover=create sle_cover
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.sle_cover,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_package_qty.destroy
destroy(this.sle_cover)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type sle_cover from singlelineedit within w_package_qty
int X=215
int Y=736
int Width=2336
int Height=108
int TabOrder=20
boolean Visible=false
boolean Enabled=false
boolean Border=false
boolean AutoHScroll=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_package_qty
int X=18
int Y=16
int Width=2670
int Height=592
int TabOrder=10
string DataObject="d_part_package_setup"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;String	s_Column, &
			s_Unit

s_Column = GetColumnName ( )

Choose Case s_Column
	Case "scale_interface"
		If GetText ( ) = 'Y' Then
			SetItem ( 1, "serial_type", "Piece Weight" )
			SetItem ( 1, "threshold_upper", 0 )
			SetItem ( 1, "threshold_lower", 0 )
			SetItem ( 1, "threshold_upper_type", 'P' )
			SetItem ( 1, "threshold_lower_type", 'P' )
		end if
//			Modify ( "manual_tare.TabSequence=40" )
//			Modify ( "round_to_whole_number.TabSequence=50" )
//			Modify ( "inactivity_time.TabSequence=60" )
//			Modify ( "inactivity_weight.TabSequence=70" )
//			Modify ( "trigger_type.TabSequence=80" )
//			Modify ( "threshold_percent.TabSequence=90" )
//			Modify ( "threshold_lower.TabSequence=100" )
//			Modify ( "threshold_upper.TabSequence=110" )
//			Modify ( "unit.TabSequence=140" )
//		Else
//			Modify ( "manual_tare.TabSequence=0" )
//			Modify ( "round_to_whole_number.TabSequence=0" )
//			Modify ( "trigger_type.TabSequence=0" )
//			Modify ( "trigger_weight.TabSequence=0" )
//			Modify ( "tolerance.TabSequence=0" )
//			Modify ( "inactivity_time.TabSequence=0" )
//			Modify ( "inactivity_weight.TabSequence=0" )
//			Modify ( "trigger_weight.TabSequence=0" )
//			Modify ( "threshold_percent.TabSequence=0" )
//			Modify ( "threshold_lower.TabSequence=0" )
//			Modify ( "threshold_upper.TabSequence=0" )
//			Modify ( "user_input_trigger.TabSequence=0" )
//			Modify ( "unit.TabSequence=40" )
//		End if
//	CASE "trigger_type"
//		IF Left ( GetText ( ), 1 ) = 'W' OR Left ( GetText ( ), 1 ) = 'A' THEN
//			Modify ( "trigger_weight.TabSequence=120" )
//		ELSEIF GetText ( ) = "AE" THEN
//			Modify ( "user_input_trigger.TabSequence=120" )
//		END IF
//	CASE "unit"
//		s_Unit = GetText ( )
//		IF IsNull ( s_Unit ) OR s_Unit = "" THEN
//			dw_1.Modify ( "stage_using_weight.color = 8421504"  )
//			dw_1.Modify ( "stage_using_weight.TabSequence = 0" )
//		ELSE
//			dw_1.Modify ( "stage_using_weight.color = 8388608"  )
//			dw_1.Modify ( "stage_using_weight.TabSequence=150" )
//		END IF
End Choose



end event

type cb_2 from commandbutton within w_package_qty
int X=2286
int Y=624
int Width=306
int Height=92
int TabOrder=40
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//szReturnedString = "-1"
Close ( w_package_qty )
end event

type cb_1 from commandbutton within w_package_qty
int X=1865
int Y=624
int Width=306
int Height=92
int TabOrder=30
string Text="&OK"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	l_s_shipping_unit
long     ll_quantity

		  
if dw_1.AcceptText ( ) < 0 then return

ll_quantity = dw_1.getitemnumber(1,'quantity')

if IsNull(ll_quantity) then
	MessageBox ( monsys.msg_title, "Quantity cannot be null", Information!)
	return
end if

l_s_shipping_unit = f_get_string_value ( dw_1.GetItemString ( 1, "unit" ) )

if isnull(l_s_shipping_unit) then
	MessageBox ( "Error", "You must choose a default shipping unit to continue!", StopSign! )
	Return
end if

If dw_1.Update ( ) = -1 Then
	MessageBox ( "Error", "Unable to save package/part relationship!", StopSign! )
	RollBack ;
Else
	Commit ;
End If

Close ( w_package_qty )

end event


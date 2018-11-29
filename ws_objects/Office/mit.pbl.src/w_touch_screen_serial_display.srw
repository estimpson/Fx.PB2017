$PBExportHeader$w_touch_screen_serial_display.srw
forward
global type w_touch_screen_serial_display from Window
end type
type sle_title from statictext within w_touch_screen_serial_display
end type
type em_1 from editmask within w_touch_screen_serial_display
end type
type cb_3 from commandbutton within w_touch_screen_serial_display
end type
type st_1 from statictext within w_touch_screen_serial_display
end type
type cb_9 from commandbutton within w_touch_screen_serial_display
end type
type cb_8 from commandbutton within w_touch_screen_serial_display
end type
type cb_6 from commandbutton within w_touch_screen_serial_display
end type
type cb_5 from commandbutton within w_touch_screen_serial_display
end type
type cb_4 from commandbutton within w_touch_screen_serial_display
end type
type cb_51 from commandbutton within w_touch_screen_serial_display
end type
type cb_49 from commandbutton within w_touch_screen_serial_display
end type
type cb_47 from commandbutton within w_touch_screen_serial_display
end type
type cb_46 from commandbutton within w_touch_screen_serial_display
end type
type cb_45 from commandbutton within w_touch_screen_serial_display
end type
type cb_44 from commandbutton within w_touch_screen_serial_display
end type
type cb_43 from commandbutton within w_touch_screen_serial_display
end type
type cb_48 from commandbutton within w_touch_screen_serial_display
end type
type cb_39 from commandbutton within w_touch_screen_serial_display
end type
type cb_38 from commandbutton within w_touch_screen_serial_display
end type
type cb_37 from commandbutton within w_touch_screen_serial_display
end type
type cb_32 from commandbutton within w_touch_screen_serial_display
end type
type cb_31 from commandbutton within w_touch_screen_serial_display
end type
type cb_30 from commandbutton within w_touch_screen_serial_display
end type
type cb_29 from commandbutton within w_touch_screen_serial_display
end type
type cb_28 from commandbutton within w_touch_screen_serial_display
end type
type cb_27 from commandbutton within w_touch_screen_serial_display
end type
type cb_26 from commandbutton within w_touch_screen_serial_display
end type
type sle_1 from singlelineedit within w_touch_screen_serial_display
end type
type cb_2 from commandbutton within w_touch_screen_serial_display
end type
type cb_1 from commandbutton within w_touch_screen_serial_display
end type
type dw_1 from datawindow within w_touch_screen_serial_display
end type
end forward

global type w_touch_screen_serial_display from Window
int X=0
int Y=12
int Width=2907
int Height=2864
boolean TitleBar=true
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
sle_title sle_title
em_1 em_1
cb_3 cb_3
st_1 st_1
cb_9 cb_9
cb_8 cb_8
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_51 cb_51
cb_49 cb_49
cb_47 cb_47
cb_46 cb_46
cb_45 cb_45
cb_44 cb_44
cb_43 cb_43
cb_48 cb_48
cb_39 cb_39
cb_38 cb_38
cb_37 cb_37
cb_32 cb_32
cb_31 cb_31
cb_30 cb_30
cb_29 cb_29
cb_28 cb_28
cb_27 cb_27
cb_26 cb_26
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_touch_screen_serial_display w_touch_screen_serial_display

type variables
st_generic_structure stParm

String szLocation, szPart
String szColumn

Long lCurrentRow
Long lSerial
Long lCount

Boolean bMouseDown
Boolean bFirstTime
Boolean bPart
Boolean bLocation
Boolean bNotNormal=false
Boolean bSchedule
Boolean bTrans

Int iStartPosition
Int iBlockPosition
Int iStartBlockPosition
Int iIncrement
Int iTotalArea
Int iFloor
Int iCeiling
end variables

forward prototypes
public subroutine wf_find_in_dw ()
public subroutine wf_setup_screen ()
public subroutine wf_select_new_row ()
public function boolean wf_valid_search_key ()
end prototypes

public subroutine wf_find_in_dw ();String szExpression
String szColumnName

If sle_1.Text = "" Then Return

If bNotNormal Then
	If bSchedule Then
		szExpression = "work_order >= ~'" + sle_1.Text + "~'"
	Else
		sle_1.Text = ""
		Return
	End if
Else
	szExpression = "serial >= " + sle_1.Text
End if

If KeyDown ( key0! ) Then
	szExpression = szExpression + "0"
ElseIf KeyDown ( key1! ) Then
	szExpression = szExpression + "1"
ElseIf KeyDown ( key2! ) Then
	szExpression = szExpression + "2"
ElseIf KeyDown ( key3! ) Then
	szExpression = szExpression + "3"
ElseIf KeyDown ( key4! ) Then
	szExpression = szExpression + "4"
ElseIf KeyDown ( key5! ) Then
	szExpression = szExpression + "5"
ElseIf KeyDown ( key6! ) Then
	szExpression = szExpression + "6"
ElseIf KeyDown ( key7! ) Then
	szExpression = szExpression + "7"
ElseIf KeyDown ( key8! ) Then
	szExpression = szExpression + "8"
ElseIf KeyDown ( key9! ) Then
	szExpression = szExpression + "9"
ElseIf KeyDown ( keyBack! ) Then
	If LeftA ( sle_1.Text, LenA ( sle_1.Text ) - 1 ) = "" Then Return
	szExpression = LeftA ( szExpression, LenA ( szExpression ) -1 ) 
ElseIf KeyDown ( keyNumpad1! ) Then
	szExpression = szExpression + "1"
ElseIf KeyDown ( keyNumpad2! ) Then
	szExpression = szExpression + "2"
ElseIf KeyDown ( keyNumpad3! ) Then
	szExpression = szExpression + "3"
ElseIf KeyDown ( keyNumpad4! ) Then
	szExpression = szExpression + "4"
ElseIf KeyDown ( keyNumpad5! ) Then
	szExpression = szExpression + "5"
ElseIf KeyDown ( keyNumpad6! ) Then
	szExpression = szExpression + "6"
ElseIf KeyDown ( keyNumpad7! ) Then
	szExpression = szExpression + "7"
ElseIf KeyDown ( keyNumpad8! ) Then
	szExpression = szExpression + "8"
ElseIf KeyDown ( keyNumpad9! ) Then
	szExpression = szExpression + "9"
ElseIf KeyDown ( keyNumpad0! ) Then
	szExpression = szExpression + "0"
ElseIf KeyDown ( keyDecimal! ) Then
	szExpression = szExpression + "."
ElseIf KeyDown ( keyPeriod! ) Then
	szExpression = szExpression + "."
End if

lCurrentRow = dw_1.Find ( szExpression , 1, dw_1.RowCount ( ) )

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lCurrentRow, True )

dw_1.ScrollToRow ( lCurrentRow )
dw_1.SetRow ( lCurrentRow )


end subroutine

public subroutine wf_setup_screen ();String szText, szStdUnit

szText = stParm.Value2

If bPart Then

	sle_Title.Text = "Part Number: " + szText

	cb_8.Enabled = True
	cb_1.Enabled = False
	cb_5.Enabled = True
	cb_4.Enabled = False
	cb_6.Enabled = True

   SELECT part_inventory.standard_unit  
     INTO :szStdUnit  
     FROM part_inventory  
    WHERE part_inventory.part = :szText   ;

	dw_1.DataObject = "dw_it_part_onhand"
	st_1.Text = "On Hand - " + szStdUnit

Elseif bLocation Then

	sle_Title.Text = "Location: " + szText

	cb_8.Enabled = True
	cb_1.Enabled = True
	cb_5.Enabled = True
	cb_4.Enabled = True
	cb_6.Enabled = True

	dw_1.DataObject = "dw_it_objects"
	st_1.Text = "Total Objects"

End if

szColumn = "serial"


end subroutine

public subroutine wf_select_new_row ();SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lCurrentRow, True )

dw_1.ScrollToRow ( lCurrentRow )

end subroutine

public function boolean wf_valid_search_key ();If KeyDown ( key0! ) Or &
	KeyDown ( key1! ) Or &
	KeyDown ( key2! ) Or &
	KeyDown ( key3! ) Or &
	KeyDown ( key4! ) Or &
	KeyDown ( key5! ) Or &
	KeyDown ( key6! ) Or &
	KeyDown ( key7! ) Or &
	KeyDown ( key8! ) Or &
	KeyDown ( key9! ) Or &
	KeyDown ( keyBack! ) Or &
	KeyDown ( keyDelete! ) Or &
	KeyDown ( keyNumpad0! ) Or &
	KeyDown ( keyNumpad1! ) Or &
	KeyDown ( keyNumpad2! ) Or &
	KeyDown ( keyNumpad3! ) Or &
	KeyDown ( keyNumpad4! ) Or &
	KeyDown ( keyNumpad5! ) Or &
	KeyDown ( keyNumpad6! ) Or &
	KeyDown ( keyNumpad7! ) Or &
	KeyDown ( keyNumpad8! ) Or &
	KeyDown ( keyNumpad9! ) Or &
	KeyDown ( keyNumpad0! ) Or &
	KeyDown ( keyDecimal! ) Or &
	KeyDown ( keyPeriod! ) Then

	Return True

End if

Return False
end function

on activate;Long		l_Row

IF bTrans THEN
	bTrans = FALSE
	IF bPart THEN
		dw_1.Retrieve ( szPart )
	ELSE
		dw_1.Retrieve ( szLocation )
	END IF
	l_Row = dw_1.Find ( "serial=" + String ( lSerial ), 1, dw_1.RowCount ( ) )
	IF l_Row > 0 THEN
		dw_1.SelectRow ( 0, FALSE )
		dw_1.SelectRow ( l_Row, TRUE )
		dw_1.ScrollToRow ( l_Row )
	else
		lSerial = 0
	END IF
END IF
sle_1.SetFocus ( )
end on

event open;SetPointer ( HourGlass! )

stParm = Message.PowerObjectParm

bLocation = False
bPart = False

If stParm.Value1 = "Location" Then
	bLocation = True
	szLocation = stParm.Value2
	this.title = "Objects by Location"
Elseif stParm.Value1 = "Part" Then
	bPart = True
	szPart = stParm.Value2
	this.title = "Objects by Part"
End if

This.Show ( )
Timer ( .05, This )

end event

event timer;Timer ( 0, This )

wf_setup_screen ( )

dw_1.SetTransObject ( sqlca )

If bPart Then
	dw_1.Retrieve ( szPart )
Else
	dw_1.Retrieve ( szLocation )
End if

SetPointer ( Arrow! )
end event

on key;If wf_valid_search_key ( ) Then &
	wf_find_in_dw ( )
end on

on w_touch_screen_serial_display.create
this.sle_title=create sle_title
this.em_1=create em_1
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_51=create cb_51
this.cb_49=create cb_49
this.cb_47=create cb_47
this.cb_46=create cb_46
this.cb_45=create cb_45
this.cb_44=create cb_44
this.cb_43=create cb_43
this.cb_48=create cb_48
this.cb_39=create cb_39
this.cb_38=create cb_38
this.cb_37=create cb_37
this.cb_32=create cb_32
this.cb_31=create cb_31
this.cb_30=create cb_30
this.cb_29=create cb_29
this.cb_28=create cb_28
this.cb_27=create cb_27
this.cb_26=create cb_26
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.sle_title,&
this.em_1,&
this.cb_3,&
this.st_1,&
this.cb_9,&
this.cb_8,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_51,&
this.cb_49,&
this.cb_47,&
this.cb_46,&
this.cb_45,&
this.cb_44,&
this.cb_43,&
this.cb_48,&
this.cb_39,&
this.cb_38,&
this.cb_37,&
this.cb_32,&
this.cb_31,&
this.cb_30,&
this.cb_29,&
this.cb_28,&
this.cb_27,&
this.cb_26,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_touch_screen_serial_display.destroy
destroy(this.sle_title)
destroy(this.em_1)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_51)
destroy(this.cb_49)
destroy(this.cb_47)
destroy(this.cb_46)
destroy(this.cb_45)
destroy(this.cb_44)
destroy(this.cb_43)
destroy(this.cb_48)
destroy(this.cb_39)
destroy(this.cb_38)
destroy(this.cb_37)
destroy(this.cb_32)
destroy(this.cb_31)
destroy(this.cb_30)
destroy(this.cb_29)
destroy(this.cb_28)
destroy(this.cb_27)
destroy(this.cb_26)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type sle_title from statictext within w_touch_screen_serial_display
int X=37
int Y=16
int Width=2267
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_touch_screen_serial_display
int X=2341
int Y=1760
int Width=512
int Height=128
int TabOrder=20
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
string Mask="########0.##"
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_touch_screen_serial_display
int X=1134
int Y=2148
int Width=549
int Height=160
int TabOrder=260
boolean Visible=false
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_touch_screen_serial_display
int X=2341
int Y=1660
int Width=512
int Height=80
boolean Enabled=false
string Text="On Hand"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_9 from commandbutton within w_touch_screen_serial_display
int X=1792
int Y=1728
int Width=512
int Height=192
int TabOrder=270
string Text="E&xit"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_8 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=800
int Width=549
int Height=160
int TabOrder=150
string Text="Normal Display"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;bSchedule = False
bNotNormal = false
SetPointer ( HourGlass! )

If bLocation Then
	dw_1.DataObject = "dw_it_objects"
	dw_1.settransobject ( sqlca )
	dw_1.Retrieve ( szLocation )
Elseif bPart Then
	dw_1.DataObject = "dw_it_part_onhand"
	dw_1.settransobject ( sqlca )
	dw_1.Retrieve ( szPart )
End if

sle_1.SetFocus ( )

end event

type cb_6 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=1120
int Width=549
int Height=160
int TabOrder=70
string Text="Age"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;bSchedule = False
bNotNormal = False
SetPointer ( HourGlass! )

If bLocation Then
	dw_1.DataObject = "dw_location_object_1"
	dw_1.settransobject ( sqlca )
	dw_1.Retrieve ( szLocation )
Elseif bPart Then
	dw_1.DataObject = "dw_part_object_1"
	dw_1.settransobject ( sqlca )
	dw_1.Retrieve ( szPart )
End if

sle_1.SetFocus ( )
end event

type cb_5 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=1440
int Width=549
int Height=160
int TabOrder=110
string Text="Print Label"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If f_get_value ( lSerial ) <> 0 Then
//	print_label ( lSerial ) old code to call a print out routine
	
	st_generic_structure stParm2

	stParm2.value1 = String ( lSerial )
	f_print_label ( stParm2 )
	

End if



//bNotNormal = True
//SetPointer ( HourGlass! )
//dw_1.DataObject = "dw_it_objects_location_gr"
//dw_1.settransobject ( sqlca )
//dw_1.Retrieve ( szLocation )
//sle_1.SetFocus ( )

end event

type cb_4 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=1280
int Width=549
int Height=160
int TabOrder=100
string Text="Sum Parts"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;bSchedule = False
/*  Declare Variables  */

String szTempPart
String szCurrentPart

Dec dTempQty
Dec dTempWeight
Dec dTotalPartQty
Dec dTotalPartWeight
Dec dTareWeight

Long lTotalObjects
Long lRow

Boolean bFirstTime = True

 DECLARE sum_parts_by_location CURSOR FOR  
  SELECT object.part,   
         object.std_quantity,
			object.weight,
			object.tare_weight
    FROM object  
   WHERE object.location = :szLocation   
ORDER BY object.part ASC  ;


/*  Initialize Variables  */

bNotNormal = True
SetPointer ( HourGlass! )
dw_1.DataObject = "d_external_part_onhand_bylocation"


/*  Main  */

Open sum_parts_by_location ;

Do

	Fetch sum_parts_by_location Into :szTempPart, :dTempQty, :dTempWeight, :dTareWeight ;

	szTempPart = Upper ( f_get_string_value ( szTempPart ) )

	If bFirstTime Then
		szCurrentPart = szTempPart
		bFirstTime = False
	End if

	If SQLCA.SQLCode = 0 Then

		dTareWeight = f_get_value ( dTareWeight )
		dTempWeight	= f_get_value ( dTempWeight )

		If szTempPart = szCurrentPart Then
			dTotalPartQty = dTotalPartQty + dTempQty
			dTotalPartWeight = dTotalPartWeight + dTempWeight + dTareWeight
			lTotalObjects++
		Else
			dw_1.InsertRow ( 0 )
			lRow = dw_1.RowCount ( )
			dw_1.SetItem ( lRow, "part", szCurrentPart )
			dw_1.SetItem ( lRow, "total_weight", dTotalPartWeight )
			dw_1.SetItem ( lRow, "total_on_hand", dTotalPartQty )
			dw_1.SetItem ( lRow, "total_objects", lTotalObjects )
			szCurrentPart = szTempPart
			dTotalPartQty = dTempQty
			dTotalPartWeight = dTempWeight + dTareWeight
			lTotalObjects = 1
		End if

	End if

Loop while SQLCA.SQLCode = 0

Close sum_parts_by_location ;

dw_1.InsertRow ( 0 )
lRow = dw_1.RowCount ( )
dw_1.SetItem ( lRow, "part", szCurrentPart )
dw_1.SetItem ( lRow, "total_weight", dTotalPartWeight )
dw_1.SetItem ( lRow, "total_on_hand", dTotalPartQty )
dw_1.SetItem ( lRow, "total_objects", lTotalObjects )



end event

type cb_51 from commandbutton within w_touch_screen_serial_display
int X=1024
int Y=1728
int Width=256
int Height=192
int TabOrder=290
string Text="."
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_49 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=640
int Width=549
int Height=160
int TabOrder=90
string Text="Quality"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer ( HourGlass! )
/*  Declare Variables  */

st_generic_structure stParm


/*  Initialize Variables  */

stParm.Value1 = "Quality Control"
stParm.Value2 = String ( lSerial )

bTrans = True

OpenWithParm ( w_quality_control, stParm )

end event

type cb_47 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=480
int Width=549
int Height=160
int TabOrder=80
string Text="Combine"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;SetPointer ( HourGlass! )
/*  Declare Variables  */

st_generic_structure stParm


/*  Initialize Variables  */

stParm.Value1 = "Combine"
stParm.Value2 = String ( lSerial )

bTrans = True

OpenWithParm ( w_touch_screen_generic_trans, stParm )

end on

type cb_46 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=320
int Width=549
int Height=160
int TabOrder=50
string Text="Transfer"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer ( HourGlass! )
/*  Declare Variables  */

st_generic_structure stParm


/*  Initialize Variables  */

stParm.Value2 = String ( lSerial )

bTrans = True

OpenWithParm ( w_transfer, stParm )

end event

type cb_45 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=160
int Width=549
int Height=160
int TabOrder=40
string Text="Break Out"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer ( HourGlass! )
/*  Declare Variables  */

st_generic_structure stParm


/*  Initialize Variables  */

stParm.Value2 = String ( lSerial )

bTrans = True

OpenWithParm ( w_break_out, stParm )

end event

type cb_44 from commandbutton within w_touch_screen_serial_display
int X=2341
int Width=549
int Height=160
int TabOrder=30
string Text="Material Issue"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer ( HourGlass! )
/*  Declare Variables  */

st_generic_structure stParm

/*  Initialize Variables  */

stParm.Value2 = String ( lSerial )

bTrans = True

OpenWithParm ( w_material_issue, stParm )

end event

type cb_43 from commandbutton within w_touch_screen_serial_display
int X=2523
int Width=146
int Height=96
int TabOrder=60
boolean Visible=false
boolean Enabled=false
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;cb_43.Drag ( Begin! )
end on

type cb_48 from commandbutton within w_touch_screen_serial_display
int X=1280
int Y=1728
int Width=512
int Height=192
int TabOrder=280
string Text="Clear"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = ""
sle_1.SetFocus ( )
end on

type cb_39 from commandbutton within w_touch_screen_serial_display
int X=2048
int Y=1536
int Width=256
int Height=192
int TabOrder=140
string Text="9"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "9"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_38 from commandbutton within w_touch_screen_serial_display
int X=1792
int Y=1536
int Width=256
int Height=192
int TabOrder=130
string Text="8"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "8"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_37 from commandbutton within w_touch_screen_serial_display
int X=1536
int Y=1536
int Width=256
int Height=192
int TabOrder=120
string Text="7"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "7"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_32 from commandbutton within w_touch_screen_serial_display
int X=768
int Y=1728
int Width=256
int Height=192
int TabOrder=160
string Text="0"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "0"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_31 from commandbutton within w_touch_screen_serial_display
int Y=1536
int Width=256
int Height=192
int TabOrder=170
string Text="1"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "1"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_30 from commandbutton within w_touch_screen_serial_display
int X=256
int Y=1536
int Width=256
int Height=192
int TabOrder=180
string Text="2"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "2"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_29 from commandbutton within w_touch_screen_serial_display
int X=512
int Y=1536
int Width=256
int Height=192
int TabOrder=200
string Text="3"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "3"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_28 from commandbutton within w_touch_screen_serial_display
int X=768
int Y=1536
int Width=256
int Height=192
int TabOrder=210
string Text="4"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "4"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_27 from commandbutton within w_touch_screen_serial_display
int X=1024
int Y=1536
int Width=256
int Height=192
int TabOrder=220
string Text="5"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "5"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_26 from commandbutton within w_touch_screen_serial_display
int X=1280
int Y=1536
int Width=256
int Height=192
int TabOrder=230
string Text="6"
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_1.Text = sle_1.Text + "6"

wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type sle_1 from singlelineedit within w_touch_screen_serial_display
int X=37
int Y=1760
int Width=695
int Height=128
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-14
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;//String szTemp
//String szColumn
//
//Long lRowNumber
//
//szTemp = sle_1.Text
//
//dw_1.SetColumn ( 1 )
//szColumn = dw_1.GetColumnName ( )
//
//If dw_1.RowCount ( ) < 1 Then Return
//
//lRowNumber = dw_1.Find ( szColumn + " = ~~'" + sle_1.Text + "~~'", 1, dw_1.RowCount ( ) )
//
//If lRowNumber < 1 Then Return
//
//dw_1.ScrollToRow ( lRowNumber )
//
//
end on

type cb_2 from commandbutton within w_touch_screen_serial_display
int X=1682
int Y=2144
int Width=549
int Height=160
int TabOrder=250
boolean Visible=false
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_touch_screen_serial_display
int X=2341
int Y=960
int Width=549
int Height=160
int TabOrder=240
string Text="Accuracy"
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;bSchedule = True
bNotNormal = True
SetPointer ( HourGlass! )
//dw_1.DataObject = "dw_it_work_order"
dw_1.DataObject = "dw_it_inventory_accuracy_line_chart"
dw_1.settransobject ( sqlca )
dw_1.Retrieve ( szLocation )
sle_1.SetFocus ( )

end event

type dw_1 from datawindow within w_touch_screen_serial_display
int X=37
int Y=96
int Width=2267
int Height=1392
int TabOrder=190
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;/////////////////////////////////////////////////////////////////////
//
// select the location to display
//

If bNotNormal Then Return

Long lRow
lRow = dw_1.Getclickedrow ( )

/////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If lRow < 1 Then 
	SetNull ( lSerial )
	Return
End if

Selectrow ( dw_1, 0, false )
SelectRow ( dw_1, lRow, true )

lSerial = dw_1.GetItemNumber ( lRow, "serial" )
end on

event retrieverow;SetPointer ( HourGlass! )

If bNotNormal Then Return

String cStatus
Dec dQuantity

lCount++

If bLocation Then
	em_1.Text = String ( Dec ( em_1.Text ) + 1 )
Else
	cStatus = dw_1.GetItemString ( lCount, "status" )
	dQuantity = f_get_value ( dw_1.GetItemNumber ( lCount, "std_quantity" ) )
	If cStatus = "A" Then &
		em_1.Text = String ( Dec ( em_1.Text ) + dQuantity )
End if

end event

on retrieveend;Dec	dQty

If bPart Then

	dQty = Dec ( em_1.Text )

   UPDATE part_online  
      SET on_hand = :dQty  
    WHERE part = :szPart   ;

	If SQLCA.SQLCode <> 0 Then
		RollBack ;
	Else
		Commit ;
	End if

End if

//dw_1.SetSort ( "serial A" )
//dw_1.Sort ( )
end on

on retrievestart;SetPointer ( HourGlass! )
lCount = 0
em_1.Text = "0"
end on

event dberror;return ( 1 )
end event


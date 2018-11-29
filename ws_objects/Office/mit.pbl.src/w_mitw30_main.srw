$PBExportHeader$w_mitw30_main.srw
forward
global type w_mitw30_main from window
end type
type cb_53 from commandbutton within w_mitw30_main
end type
type cb_43 from commandbutton within w_mitw30_main
end type
type cb_label from commandbutton within w_mitw30_main
end type
type st_3 from statictext within w_mitw30_main
end type
type st_2 from statictext within w_mitw30_main
end type
type st_1 from statictext within w_mitw30_main
end type
type cb_52 from commandbutton within w_mitw30_main
end type
type cb_51 from commandbutton within w_mitw30_main
end type
type cb_50 from commandbutton within w_mitw30_main
end type
type cb_49 from commandbutton within w_mitw30_main
end type
type cb_47 from commandbutton within w_mitw30_main
end type
type cb_46 from commandbutton within w_mitw30_main
end type
type cb_45 from commandbutton within w_mitw30_main
end type
type cb_44 from commandbutton within w_mitw30_main
end type
type cb_42 from commandbutton within w_mitw30_main
end type
type cb_41 from commandbutton within w_mitw30_main
end type
type rb_2 from radiobutton within w_mitw30_main
end type
type rb_1 from radiobutton within w_mitw30_main
end type
type cb_48 from commandbutton within w_mitw30_main
end type
type cb_40 from commandbutton within w_mitw30_main
end type
type cb_39 from commandbutton within w_mitw30_main
end type
type cb_38 from commandbutton within w_mitw30_main
end type
type cb_37 from commandbutton within w_mitw30_main
end type
type cb_36 from commandbutton within w_mitw30_main
end type
type cb_35 from commandbutton within w_mitw30_main
end type
type cb_34 from commandbutton within w_mitw30_main
end type
type cb_33 from commandbutton within w_mitw30_main
end type
type cb_32 from commandbutton within w_mitw30_main
end type
type cb_31 from commandbutton within w_mitw30_main
end type
type cb_30 from commandbutton within w_mitw30_main
end type
type cb_29 from commandbutton within w_mitw30_main
end type
type cb_28 from commandbutton within w_mitw30_main
end type
type cb_27 from commandbutton within w_mitw30_main
end type
type cb_26 from commandbutton within w_mitw30_main
end type
type cb_25 from commandbutton within w_mitw30_main
end type
type cb_24 from commandbutton within w_mitw30_main
end type
type cb_23 from commandbutton within w_mitw30_main
end type
type cb_22 from commandbutton within w_mitw30_main
end type
type cb_21 from commandbutton within w_mitw30_main
end type
type cb_20 from commandbutton within w_mitw30_main
end type
type cb_19 from commandbutton within w_mitw30_main
end type
type cb_18 from commandbutton within w_mitw30_main
end type
type cb_17 from commandbutton within w_mitw30_main
end type
type cb_16 from commandbutton within w_mitw30_main
end type
type cb_15 from commandbutton within w_mitw30_main
end type
type cb_14 from commandbutton within w_mitw30_main
end type
type cb_13 from commandbutton within w_mitw30_main
end type
type cb_12 from commandbutton within w_mitw30_main
end type
type cb_11 from commandbutton within w_mitw30_main
end type
type cb_10 from commandbutton within w_mitw30_main
end type
type cb_9 from commandbutton within w_mitw30_main
end type
type cb_8 from commandbutton within w_mitw30_main
end type
type cb_7 from commandbutton within w_mitw30_main
end type
type cb_6 from commandbutton within w_mitw30_main
end type
type cb_5 from commandbutton within w_mitw30_main
end type
type cb_4 from commandbutton within w_mitw30_main
end type
type sle_1 from singlelineedit within w_mitw30_main
end type
type cb_3 from commandbutton within w_mitw30_main
end type
type cb_2 from commandbutton within w_mitw30_main
end type
type cb_1 from commandbutton within w_mitw30_main
end type
type dw_1 from datawindow within w_mitw30_main
end type
end forward

global type w_mitw30_main from window
integer y = 12
integer width = 3602
integer height = 2348
boolean titlebar = true
string title = "Inventory Transactions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 79741120
string icon = "mit.ico"
cb_53 cb_53
cb_43 cb_43
cb_label cb_label
st_3 st_3
st_2 st_2
st_1 st_1
cb_52 cb_52
cb_51 cb_51
cb_50 cb_50
cb_49 cb_49
cb_47 cb_47
cb_46 cb_46
cb_45 cb_45
cb_44 cb_44
cb_42 cb_42
cb_41 cb_41
rb_2 rb_2
rb_1 rb_1
cb_48 cb_48
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
sle_1 sle_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_mitw30_main w_mitw30_main

type variables
String szLocation, szPart
String szColumn
String szWorkOrder
String szClickedPart
String szClickedLoc
Long lCurrentRow

Boolean bMouseDown
Boolean bFirstTime
Boolean bScan
Boolean bPart
Boolean bLocation
Boolean bOpened
Boolean bOpen
Boolean bPopulateParts
Boolean bPopulateLocations
Boolean bButton
Boolean bEnter

Window wLabel
end variables

forward prototypes
public subroutine wf_determine_dw (string sztype)
public subroutine wf_select_new_row ()
public subroutine wf_find_in_dw ()
public subroutine wf_disable_chars ()
public subroutine wf_enable_chars ()
public function boolean wf_valid_search_key ()
end prototypes

public subroutine wf_determine_dw (string sztype);If szType = "Location" Then

	dw_1.DataObject = "d_it_location_new"
	szColumn = "code"

Elseif szType = "Part" Then

	dw_1.DataObject = "d_it_part_search"
	szColumn = "part"

Else

	dw_1.DataObject = "d_scanned_object"

End if

dw_1.SetTransObject ( sqlca )

end subroutine

public subroutine wf_select_new_row ();SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lCurrentRow, True )

dw_1.ScrollToRow ( lCurrentRow )

end subroutine

public subroutine wf_find_in_dw ();Long lRow

lRow = dw_1.Find ( szColumn + " >= '" + sle_1.Text + "'", 1, dw_1.RowCount ( ) )

If lRow < 1 Then Return

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lRow, True )

dw_1.ScrollToRow ( lRow )
dw_1.SetRow ( lRow )

lCurrentRow = lRow

//wf_redraw_position ( )
end subroutine

public subroutine wf_disable_chars ();cb_4.Enabled = False
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
cb_25.Enabled = False
cb_36.Enabled = False
cb_35.Enabled = False
cb_34.Enabled = False
cb_33.Enabled = False
cb_40.Enabled = False
cb_41.Enabled = False
cb_42.Enabled = False
cb_51.Enabled = False

end subroutine

public subroutine wf_enable_chars ();cb_4.Enabled = True
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
cb_25.Enabled = True
cb_36.Enabled = True
cb_35.Enabled = True
cb_34.Enabled = True
cb_33.Enabled = True
cb_40.Enabled = True
cb_41.Enabled = True
cb_42.Enabled = True
cb_51.Enabled = True
end subroutine

public function boolean wf_valid_search_key ();If KeyDown ( keyA! ) Or &
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
	KeyDown ( keyBack! ) Or &
	KeyDown ( keySpaceBar! ) Or &
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
	KeyDown ( keyDivide! ) Or &
	KeyDown ( keyDash! ) Or &
	KeyDown ( keyPeriod! ) Or &
	KeyDown ( keySlash! ) Then

	Return True

End if

Return False
end function

event open;String cPopulateParts
String cPopulateLocations

this.title = monsys.title + sqlca.is_Profile

If szMachineParm = "" Then
	szWorkOrder = Message.StringParm
	szWorkOrder = f_get_string_value ( szWorkOrder )
End if

bOpen = True

SELECT parameters.populate_parts,   
       parameters.populate_locations  
  INTO :cPopulateParts,   
       :cPopulateLocations  
  FROM parameters  ;

If cPopulateParts = "Y" Then
	bPopulateParts = True
End if
If cPopulateLocations = "Y" Then
	bPopulateLocations = True
End if

dw_1.SetTransObject ( sqlca )

bFirstTime = True

szColumn = "code"

sle_1.SetFocus ()
wf_disable_chars ( )
bScan = True
cb_52.Enabled = True

end event

event activate;Long	lFindRow

If Not bOpen Then
	If bLocation Then
		If Not bScan Then //And bPopulateLocations Then 
			dw_1.Retrieve ( )
			If f_get_string_value ( szClickedLoc ) <> "" Then
				lFindRow = dw_1.Find ( "code = '" + szClickedLoc + "'", 1, dw_1.RowCount ( ) )
				dw_1.ScrollToRow ( lFindRow )
				SelectRow ( dw_1, 0, False )
				SelectRow ( dw_1, lFindRow, True )
			End if
		End if
	Else
		If Not bScan Then //And bPopulateParts Then 
			dw_1.Retrieve ( )
			If f_get_string_value ( szClickedPart ) <> "" Then
				lFindRow = dw_1.Find ( "part = '" + szClickedPart + "'", 1, dw_1.RowCount ( ) )
				dw_1.ScrollToRow ( lFindRow )
				SelectRow ( dw_1, 0, False )
				SelectRow ( dw_1, lFindRow, True )
			End if
		End if
	End if
Else
	bOpen = False
End if

If Not bOpened Then sle_1.SetFocus ( )
end event

on w_mitw30_main.create
this.cb_53=create cb_53
this.cb_43=create cb_43
this.cb_label=create cb_label
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_52=create cb_52
this.cb_51=create cb_51
this.cb_50=create cb_50
this.cb_49=create cb_49
this.cb_47=create cb_47
this.cb_46=create cb_46
this.cb_45=create cb_45
this.cb_44=create cb_44
this.cb_42=create cb_42
this.cb_41=create cb_41
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_48=create cb_48
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
this.sle_1=create sle_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_53,&
this.cb_43,&
this.cb_label,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_52,&
this.cb_51,&
this.cb_50,&
this.cb_49,&
this.cb_47,&
this.cb_46,&
this.cb_45,&
this.cb_44,&
this.cb_42,&
this.cb_41,&
this.rb_2,&
this.rb_1,&
this.cb_48,&
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
this.sle_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_mitw30_main.destroy
destroy(this.cb_53)
destroy(this.cb_43)
destroy(this.cb_label)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_52)
destroy(this.cb_51)
destroy(this.cb_50)
destroy(this.cb_49)
destroy(this.cb_47)
destroy(this.cb_46)
destroy(this.cb_45)
destroy(this.cb_44)
destroy(this.cb_42)
destroy(this.cb_41)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_48)
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
destroy(this.sle_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_53 from commandbutton within w_mitw30_main
integer x = 2304
integer y = 864
integer width = 549
integer height = 144
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Combo Scan"
end type

on clicked;Open ( w_combo_scan )
end on

type cb_43 from commandbutton within w_mitw30_main
boolean visible = false
integer x = 859
integer y = 752
integer width = 841
integer height = 336
integer taborder = 50
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Printing Label..."
end type

type cb_label from commandbutton within w_mitw30_main
integer x = 50
integer y = 724
integer width = 293
integer height = 208
integer taborder = 80
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Label"
end type

on clicked;Long		ll_Serial
st_generic_structure stParm

If dw_1.RowCount ( ) < 1 Then
	MessageBox ( "Error", "You must scan or enter a valid serial number to print a label!", StopSign! )
	sle_1.SetFocus ( )
	Return
End if

cb_43.Show ( )

ll_Serial = f_get_value ( dw_1.GetItemNumber ( 1, "serial" ) )
stParm.value1 = String ( ll_Serial )

f_print_label ( stParm )

cb_43.Hide ( )
end on

type st_3 from statictext within w_mitw30_main
integer x = 37
integer y = 1008
integer width = 402
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Serial Scan"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

on clicked;st_1.BorderStyle = StyleRaised!
st_2.BorderStyle = StyleRaised!
st_3.BorderStyle = StyleLowered!

wf_disable_chars ( )
wf_determine_dw ( "" )
sle_1.Text = ""
sle_1.SetFocus ( )
bScan = True
bPart = False
bLocation = False
cb_52.Enabled = True
cb_label.Enabled = False
cb_label.Show ( )

end on

type st_2 from statictext within w_mitw30_main
integer x = 987
integer y = 1008
integer width = 407
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Locations"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

on clicked;SetPointer ( HourGlass! )

cb_label.Hide ( )

st_1.BorderStyle = StyleRaised!
st_3.BorderStyle = StyleRaised!
st_2.BorderStyle = StyleLowered!

wf_enable_chars ( )
wf_determine_dw ( "Location" )
//If bPopulateLocations Then
	dw_1.Retrieve ( )
//End if
sle_1.Text = ""
sle_1.TextCase = AnyCase!
sle_1.SetFocus ( )
bLocation = True
bScan = False
bPart = False
szColumn = "code"
end on

type st_1 from statictext within w_mitw30_main
integer x = 475
integer y = 1008
integer width = 485
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77897888
string text = "Part Numbers"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

on clicked;SetPointer ( HourGlass! )

cb_label.Hide ( )

st_2.BorderStyle = StyleRaised!
st_3.BorderStyle = StyleRaised!
st_1.BorderStyle = StyleLowered!

wf_enable_chars ( )
wf_determine_dw ( "Part" )
//If bPopulateParts Then
	dw_1.Retrieve ( )
//End if
sle_1.Text = ""
sle_1.TextCase = Upper!
sle_1.SetFocus ( )
bPart = True
bScan = False
bLocation = False
szColumn = "part"


end on

type cb_52 from commandbutton within w_mitw30_main
integer x = 2560
integer y = 1728
integer width = 293
integer height = 192
integer taborder = 270
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Enter"
end type

on clicked;bButton = True
bEnter = True
sle_1.TriggerEvent ( modified! )
end on

on getfocus;If bEnter Then 
	bEnter = False
	sle_1.SetFocus ( )
End if

end on

type cb_51 from commandbutton within w_mitw30_main
integer x = 293
integer y = 1728
integer width = 256
integer height = 192
integer taborder = 550
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "."
end type

type cb_50 from commandbutton within w_mitw30_main
boolean visible = false
integer x = 2926
integer y = 352
integer width = 805
integer height = 128
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mode:  Locations"
end type

on clicked;If cb_50.Text = "Mode:  Scan" Then
	cb_50.Text = "Mode:  Locations"
	wf_enable_chars ( )
	wf_determine_dw ( "Location" )
	dw_1.Retrieve ( )
	sle_1.SetFocus ( )
	bScan = False
	cb_52.Enabled = False	
Elseif cb_50.Text = "Mode:  Locations" Then
	cb_50.Text = "Mode:  Part Numbers"
	wf_determine_dw ( "Part" )
	dw_1.Retrieve ( )
	sle_1.SetFocus ( )
Elseif cb_50.Text = "Mode:  Part Numbers" Then
	cb_50.Text = "Mode:  Scan"
	wf_disable_chars ( )
	sle_1.SetFocus ( )
	bScan = True
	cb_52.Enabled = True
End if
end on

type cb_49 from commandbutton within w_mitw30_main
integer x = 2304
integer y = 720
integer width = 549
integer height = 144
integer taborder = 90
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Quality"
end type

event clicked;SetPointer ( HourGlass! )
st_generic_structure stParm
If bScan Then stParm.Value2 = sle_1.Text
OpenWithParm ( w_quality_control, stParm )

end event

type cb_47 from commandbutton within w_mitw30_main
integer x = 2304
integer y = 576
integer width = 549
integer height = 144
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Combine"
end type

on clicked;SetPointer ( HourGlass! )

/*  Declare Variables  */

st_generic_structure stParm


/*  Initialize Variables  */

stParm.Value1 = "Combine"
If bScan Then stParm.Value2 = sle_1.Text

OpenWithParm ( w_touch_screen_generic_trans, stParm )

end on

type cb_46 from commandbutton within w_mitw30_main
integer x = 2304
integer y = 432
integer width = 549
integer height = 144
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Transfer"
end type

event clicked;st_generic_structure stParm
If bScan Then stParm.Value2 = sle_1.Text
OpenWithParm ( w_transfer, stParm )

end event

type cb_45 from commandbutton within w_mitw30_main
integer x = 2304
integer y = 288
integer width = 549
integer height = 144
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Break Out"
end type

event clicked;st_generic_structure stParm
If bScan Then stParm.Value2 = sle_1.Text
OpenWithParm ( w_break_out, stparm )
end event

type cb_44 from commandbutton within w_mitw30_main
integer x = 2304
integer y = 144
integer width = 549
integer height = 144
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Material Issue"
end type

event clicked;st_generic_structure stParm
If bScan Then stParm.Value2 = sle_1.Text
OpenWithParm ( w_material_issue, stparm )
end event

type cb_42 from commandbutton within w_mitw30_main
integer x = 1902
integer y = 1728
integer width = 366
integer height = 192
integer taborder = 540
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Space"
end type

event clicked;Long lRow

sle_1.Text = sle_1.Text + " "

lRow = dw_1.Find ( szColumn + " >= ~'" + sle_1.Text + "~'", 1, dw_1.RowCount ( ) )

SelectRow ( dw_1, 0, False )
SelectRow ( dw_1, lRow, True )

dw_1.ScrollToRow ( lRow )
dw_1.SetRow ( lRow )

sle_1.SetFocus ( )
end event

type cb_41 from commandbutton within w_mitw30_main
integer x = 1317
integer y = 1728
integer width = 256
integer height = 192
integer taborder = 530
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "_"
end type

on clicked;sle_1.Text = sle_1.Text + "_"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type rb_2 from radiobutton within w_mitw30_main
boolean visible = false
integer y = 2016
integer width = 704
integer height = 76
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Part Numbers"
end type

on clicked;wf_determine_dw ( "Part" )
dw_1.Retrieve ( )
sle_1.SetFocus ( )
end on

type rb_1 from radiobutton within w_mitw30_main
boolean visible = false
integer x = 37
integer y = 1952
integer width = 544
integer height = 76
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Locations"
boolean checked = true
end type

on clicked;wf_determine_dw ( "Location" )
dw_1.Retrieve ( )
sle_1.SetFocus ( )
end on

type cb_48 from commandbutton within w_mitw30_main
integer x = 2267
integer y = 1728
integer width = 293
integer height = 192
integer taborder = 520
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Clear"
end type

on clicked;sle_1.Text = ""
sle_1.SetFocus ( )
end on

type cb_40 from commandbutton within w_mitw30_main
integer x = 549
integer y = 1728
integer width = 256
integer height = 192
integer taborder = 260
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

on clicked;sle_1.Text = sle_1.Text + "-"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_39 from commandbutton within w_mitw30_main
integer x = 549
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 250
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "9"
end type

on clicked;sle_1.Text = sle_1.Text + "9"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_38 from commandbutton within w_mitw30_main
integer x = 293
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 240
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "8"
end type

on clicked;sle_1.Text = sle_1.Text + "8"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_37 from commandbutton within w_mitw30_main
integer x = 37
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 230
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "7"
end type

on clicked;sle_1.Text = sle_1.Text + "7"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_36 from commandbutton within w_mitw30_main
integer x = 2341
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 220
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "W"
end type

on clicked;sle_1.Text = sle_1.Text + "W"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_35 from commandbutton within w_mitw30_main
integer x = 2597
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 280
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "X"
end type

on clicked;sle_1.Text = sle_1.Text + "X"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_34 from commandbutton within w_mitw30_main
integer x = 805
integer y = 1728
integer width = 256
integer height = 192
integer taborder = 300
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Y"
end type

on clicked;sle_1.Text = sle_1.Text + "Y"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_33 from commandbutton within w_mitw30_main
integer x = 1061
integer y = 1728
integer width = 256
integer height = 192
integer taborder = 320
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Z"
end type

on clicked;sle_1.Text = sle_1.Text + "Z"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_32 from commandbutton within w_mitw30_main
integer x = 37
integer y = 1728
integer width = 256
integer height = 192
integer taborder = 340
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "0"
end type

on clicked;sle_1.Text = sle_1.Text + "0"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_31 from commandbutton within w_mitw30_main
integer x = 37
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 360
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "1"
end type

on clicked;sle_1.Text = sle_1.Text + "1"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_30 from commandbutton within w_mitw30_main
integer x = 293
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 380
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "2"
end type

on clicked;sle_1.Text = sle_1.Text + "2"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_29 from commandbutton within w_mitw30_main
integer x = 549
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 400
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "3"
end type

on clicked;sle_1.Text = sle_1.Text + "3"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_28 from commandbutton within w_mitw30_main
integer x = 37
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 420
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "4"
end type

on clicked;sle_1.Text = sle_1.Text + "4"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_27 from commandbutton within w_mitw30_main
integer x = 293
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 440
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "5"
end type

on clicked;sle_1.Text = sle_1.Text + "5"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_26 from commandbutton within w_mitw30_main
integer x = 549
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 460
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "6"
end type

on clicked;sle_1.Text = sle_1.Text + "6"

If Not bScan Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_25 from commandbutton within w_mitw30_main
integer x = 1573
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 210
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "L"
end type

on clicked;sle_1.Text = sle_1.Text + "L"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_24 from commandbutton within w_mitw30_main
integer x = 1829
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 290
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "M"
end type

on clicked;sle_1.Text = sle_1.Text + "M"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_23 from commandbutton within w_mitw30_main
integer x = 2085
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 310
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "N"
end type

on clicked;sle_1.Text = sle_1.Text + "N"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_22 from commandbutton within w_mitw30_main
integer x = 2341
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 330
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "O"
end type

on clicked;sle_1.Text = sle_1.Text + "O"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_21 from commandbutton within w_mitw30_main
integer x = 2597
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 350
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "P"
end type

on clicked;sle_1.Text = sle_1.Text + "P"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_20 from commandbutton within w_mitw30_main
integer x = 805
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 370
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Q"
end type

on clicked;sle_1.Text = sle_1.Text + "Q"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_19 from commandbutton within w_mitw30_main
integer x = 1061
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 390
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "R"
end type

on clicked;sle_1.Text = sle_1.Text + "R"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_18 from commandbutton within w_mitw30_main
integer x = 1317
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 410
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "S"
end type

on clicked;sle_1.Text = sle_1.Text + "S"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_17 from commandbutton within w_mitw30_main
integer x = 1573
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 430
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "T"
end type

on clicked;sle_1.Text = sle_1.Text + "T"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_16 from commandbutton within w_mitw30_main
integer x = 1829
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 450
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "U"
end type

on clicked;sle_1.Text = sle_1.Text + "U"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_15 from commandbutton within w_mitw30_main
integer x = 2085
integer y = 1536
integer width = 256
integer height = 192
integer taborder = 470
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "V"
end type

on clicked;sle_1.Text = sle_1.Text + "V"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_14 from commandbutton within w_mitw30_main
integer x = 1317
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 200
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "K"
end type

on clicked;sle_1.Text = sle_1.Text + "K"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_13 from commandbutton within w_mitw30_main
integer x = 1061
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 190
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "J"
end type

on clicked;sle_1.Text = sle_1.Text + "J"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_12 from commandbutton within w_mitw30_main
integer x = 805
integer y = 1344
integer width = 256
integer height = 192
integer taborder = 180
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "I"
end type

on clicked;sle_1.Text = sle_1.Text + "I"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_11 from commandbutton within w_mitw30_main
integer x = 2597
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 170
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "H"
end type

on clicked;sle_1.Text = sle_1.Text + "H"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_10 from commandbutton within w_mitw30_main
integer x = 2341
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 160
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "G"
end type

on clicked;sle_1.Text = sle_1.Text + "G"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_9 from commandbutton within w_mitw30_main
integer x = 2085
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 150
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "F"
end type

on clicked;sle_1.Text = sle_1.Text + "F"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_8 from commandbutton within w_mitw30_main
integer x = 1829
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 140
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E"
end type

on clicked;sle_1.Text = sle_1.Text + "E"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_7 from commandbutton within w_mitw30_main
integer x = 1573
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 130
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "D"
end type

on clicked;sle_1.Text = sle_1.Text + "D"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_6 from commandbutton within w_mitw30_main
integer x = 1317
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 120
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "C"
end type

on clicked;sle_1.Text = sle_1.Text + "C"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_5 from commandbutton within w_mitw30_main
integer x = 1061
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 110
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "B"
end type

on clicked;sle_1.Text = sle_1.Text + "B"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type cb_4 from commandbutton within w_mitw30_main
integer x = 805
integer y = 1152
integer width = 256
integer height = 192
integer taborder = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A"
end type

on clicked;sle_1.Text = sle_1.Text + "A"

If cb_50.Text <> "Mode:  Scan" Then wf_find_in_dw ( )

sle_1.SetFocus ( )
end on

type sle_1 from singlelineedit within w_mitw30_main
event change pbm_enchange
integer x = 1426
integer y = 1008
integer width = 1426
integer height = 128
integer taborder = 500
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event change;
If bScan And Not KeyDown ( keyEnter! ) Then Return

if	wf_valid_search_key ( ) then
	post wf_find_in_dw ( )
end if

end event

event modified;String szTemp
String szColumn
String szExpression
String szTempPart

st_generic_structure stParm

Long lRowNumber
Long lColor
szTemp = f_get_string_value ( f_serial_validate(sle_1.Text) )

If (sle_1.text='' and szTemp = "") Then Return

If bScan And ( KeyDown ( keyEnter! ) Or bButton ) Then

	bButton = False

	SetPointer ( HourGlass! )

//	If Left ( szTemp, 1 ) = 's' Then
//		szTemp = Right ( szTemp, Len ( szTemp ) - 1 )
//		sle_1.Text = szTemp
//	Elseif Not IsNumber ( Left ( szTemp, 1 ) ) Then
//		szTemp = ""
//	End if

	If IsNull ( szTemp ) Or szTemp = "" Or Not IsNumber ( szTemp ) Then Return

	dw_1.Retrieve ( Long ( szTemp ))

	If dw_1.RowCount ( ) < 1 Then
		MessageBox ( "Error", "Invalid Serial Number!", StopSign! )
		sle_1.Text = ""
		cb_label.Enabled = False
		Return
	End if

	cb_label.Enabled = True

Else

	If bPart And ( KeyDown ( keyEnter! ) OR bButton ) Then

		sle_1.Text = Upper ( sle_1.Text )

	   SELECT part.part  
   	  INTO :szTempPart  
	     FROM part
   	 WHERE part.part = :sle_1.Text   ;
		
		If SQLCA.SQLCode <> 0 Then
			MessageBox ( "Error", "Invalid part number!  Please try again.", StopSign! )
			sle_1.Text = ""
		Else
			SetPointer ( HourGlass! )

			stParm.Value1 = "Part"
			stParm.Value2 = sle_1.Text
			szClickedPart = stParm.Value2

			bOpened = True
			OpenWithParm ( w_touch_screen_serial_display, stParm )

		End if

	Elseif bLocation And ( KeyDown ( keyEnter! ) OR bButton ) Then

 	   SELECT location.code  
   	  INTO :szTemp  
	     FROM location  
   	 WHERE location.code = :sle_1.Text   ;

		If SQLCA.SQLCode <> 0 Then
			MessageBox ( "Error", "Invalid location!  Please try again.", StopSign! )
			sle_1.Text = ""
		Else

			SetPointer ( HourGlass! )

			stParm.Value1 = "Location"
			stParm.Value2 = sle_1.Text
			szClickedLoc  = stParm.Value2

			bOpened = True
			OpenWithParm ( w_touch_screen_serial_display, stParm )

		End if

	End if

End if

end event

type cb_3 from commandbutton within w_mitw30_main
boolean visible = false
integer x = 731
integer y = 1472
integer width = 549
integer height = 288
integer taborder = 510
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Part "
end type

on clicked;//open (w_it_part_search)
end on

type cb_2 from commandbutton within w_mitw30_main
integer x = 2304
integer width = 549
integer height = 144
integer taborder = 490
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Job Complete"
end type

event clicked;long 	ll_row 
st_generic_structure stParm

stParm.Value5 = szWorkOrder

if blocation then 
	stParm.value6 = szclickedloc
	stParm.value7 = "Location"
elseif bpart then 
	stParm.value6 = szclickedpart
	stParm.value7 = "Part"
end if 	

OpenWithParm ( w_job_complete, stparm )

end event

type cb_1 from commandbutton within w_mitw30_main
integer x = 1573
integer y = 1728
integer width = 329
integer height = 192
integer taborder = 480
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exit"
end type

on clicked;Int iRtnCode

iRtnCode = MessageBox ( "Exit", "Are you sure you want to exit?", Question!, YesNo!, 2 )
If iRtnCode = 1 Then
	close (parent)
End if
end on

type dw_1 from datawindow within w_mitw30_main
integer x = 18
integer y = 16
integer width = 2267
integer height = 976
integer taborder = 10
string dataobject = "d_scanned_object"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on scrollvertical;sle_1.SetFocus ( )
end on

event clicked;///////////////////////////////////////////////////////////////////////
////
//// select the location to display
////
//
//
st_generic_structure stParm
//
//
///////////////////////////////////////////////////////////////////////
////
////   if clicked outside dw then don't process request
////  
//
If Row < 1 Then Return

Selectrow ( dw_1, 0, false )
SelectRow ( dw_1, Row, true )

If bLocation Then
//
//	SetPointer ( HourGlass! )
//
	sle_1.text = dw_1.GetItemString ( row, "code" )
	stParm.Value1 = "Location"
	stParm.Value2 = dw_1.GetItemstring ( row, "code" )
	szClickedLoc  = stParm.Value2
//
//	bOpened = True
//	OpenWithParm ( w_touch_screen_serial_display, stParm )
//
Elseif bPart Then
//
//	SetPointer ( HourGlass! )
//
	sle_1.text = dw_1.GetItemString ( row, "part" )
	stParm.Value1 = "Part"
	stParm.Value2 = dw_1.GetItemString ( row, "part" )
	szClickedPart = stParm.Value2
//
//	bOpened = True
//	OpenWithParm ( w_touch_screen_serial_display, stParm )
//
End if
//
//
end event

event dberror;return 1
end event

on scrollhorizontal;sle_1.SetFocus ( )
end on

event doubleclicked;/////////////////////////////////////////////////////////////////////
//
// select the location to display
//

Long lRow
lRow = row

st_generic_structure stParm


/////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If lRow < 1 Then Return

Selectrow ( dw_1, 0, false )
SelectRow ( dw_1, lRow, true )

If bLocation Then

	SetPointer ( HourGlass! )

	sle_1.text = dw_1.GetItemString ( lRow, "code" )
	stParm.Value1 = "Location"
	stParm.Value2 = dw_1.GetItemstring ( lRow, "code" )
	szClickedLoc  = stParm.Value2

	bOpened = True
	OpenWithParm ( w_touch_screen_serial_display, stParm )

Elseif bPart Then

	SetPointer ( HourGlass! )

	sle_1.text = dw_1.GetItemString ( lRow, "part" )
	stParm.Value1 = "Part"
	stParm.Value2 = dw_1.GetItemString ( lRow, "part" )
	szClickedPart = stParm.Value2

	bOpened = True
	OpenWithParm ( w_touch_screen_serial_display, stParm )

End if


end event


$PBExportHeader$w_part_config_build.srw
forward
global type w_part_config_build from Window
end type
type cb_5 from commandbutton within w_part_config_build
end type
type dw_7 from datawindow within w_part_config_build
end type
type dw_6 from datawindow within w_part_config_build
end type
type st_3 from statictext within w_part_config_build
end type
type sle_2 from singlelineedit within w_part_config_build
end type
type ddlb_2 from dropdownlistbox within w_part_config_build
end type
type dw_5 from datawindow within w_part_config_build
end type
type dw_2 from datawindow within w_part_config_build
end type
type st_2 from statictext within w_part_config_build
end type
type ddlb_1 from dropdownlistbox within w_part_config_build
end type
type sle_1 from singlelineedit within w_part_config_build
end type
type st_1 from statictext within w_part_config_build
end type
type cb_4 from commandbutton within w_part_config_build
end type
type cb_3 from commandbutton within w_part_config_build
end type
type dw_3 from datawindow within w_part_config_build
end type
type dw_4 from datawindow within w_part_config_build
end type
type rb_7 from radiobutton within w_part_config_build
end type
type rb_6 from radiobutton within w_part_config_build
end type
type rb_5 from radiobutton within w_part_config_build
end type
type rb_4 from radiobutton within w_part_config_build
end type
type cb_1 from commandbutton within w_part_config_build
end type
type rb_3 from radiobutton within w_part_config_build
end type
type rb_2 from radiobutton within w_part_config_build
end type
type rb_1 from radiobutton within w_part_config_build
end type
type cb_2 from commandbutton within w_part_config_build
end type
type dw_1 from datawindow within w_part_config_build
end type
type gb_4 from groupbox within w_part_config_build
end type
type gb_3 from groupbox within w_part_config_build
end type
type gb_2 from groupbox within w_part_config_build
end type
type gb_1 from groupbox within w_part_config_build
end type
end forward

global type w_part_config_build from Window
int X=5
int Y=8
int Width=2962
int Height=2712
boolean TitleBar=true
string Title="Product Line "
long BackColor=12632256
WindowType WindowType=popup!
cb_5 cb_5
dw_7 dw_7
dw_6 dw_6
st_3 st_3
sle_2 sle_2
ddlb_2 ddlb_2
dw_5 dw_5
dw_2 dw_2
st_2 st_2
ddlb_1 ddlb_1
sle_1 sle_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
dw_3 dw_3
dw_4 dw_4
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
cb_1 cb_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
dw_1 dw_1
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_part_config_build w_part_config_build

type variables
String szPart, szName, szProduct, szColumn
String szCriteria
//String szColumnName[80]

//st_column_position_and_name stParm[80]
end variables

on open;/////////////////////////////////////////////////
//  Declare Variables
//
Long lCount, lRow, lRowArray

Boolean bFoundAMatch

String szReturnValue

/////////////////////////////////////////////////
//  Initialize Variables
//
dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( )

dw_6.SetTransObject ( sqlca )
dw_6.Retrieve ( "part" )

For lCount = 1 to dw_6.RowCount ( )
	ddlb_2.AddItem ( dw_6.GetItemString ( lCount, "pbc_hdr" ) )
Next

























//dw_4.SetTransObject ( sqlca )
//dw_4.Retrieve ( "COMPUTER" )
//
///////////////////////////////////////////////////
////  Main
////
//lRow = 0
//
//DO   
//	lRow = lRow + 1
//
//	dw_4.SetColumn ( lRow )
//
//	szReturnValue = dw_4.GetColumnName ( )
//
//	If szReturnValue <> '' Then
//		bFoundAMatch = False
//
//		For lCount = 1 to lRow - 1
//			If szReturnValue = stParm[lCount].szColumn Then
//				bFoundAMatch = True
//				lCount = lRow - 1
//			End if
//		Next
//	
//		If bFoundAMatch = False Then
//			lRowArray = lRowArray + 1
//			stParm[lRowArray].szColumn = szReturnValue
//			stParm[lRowArray].szColumnNumber = lRow
//		End if
//
//	End if
//
//LOOP WHILE szReturnValue <> ''
//
//For lCount = 1 to lRowArray
//
//	ddlb_2.AddItem ( dw_6.GetItemString ( stParm[lCount].szColumnNumber, "pbc_hdr" ) )
//
//Next


end on

on w_part_config_build.create
this.cb_5=create cb_5
this.dw_7=create dw_7
this.dw_6=create dw_6
this.st_3=create st_3
this.sle_2=create sle_2
this.ddlb_2=create ddlb_2
this.dw_5=create dw_5
this.dw_2=create dw_2
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_3=create dw_3
this.dw_4=create dw_4
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.cb_1=create cb_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_5,&
this.dw_7,&
this.dw_6,&
this.st_3,&
this.sle_2,&
this.ddlb_2,&
this.dw_5,&
this.dw_2,&
this.st_2,&
this.ddlb_1,&
this.sle_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.dw_3,&
this.dw_4,&
this.rb_7,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.cb_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_2,&
this.dw_1,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_part_config_build.destroy
destroy(this.cb_5)
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.ddlb_2)
destroy(this.dw_5)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.cb_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_5 from commandbutton within w_part_config_build
int X=2597
int Y=800
int Width=256
int Height=96
int TabOrder=70
string Text="Search"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long lNumberOfRows, lRow, lStartRow

String szExpression

dw_7.SetTransObject ( sqlca )
dw_7.Retrieve ( "part", ddlb_2.Text )

If dw_7.RowCount ( ) < 1 Then 
	MessageBox ( "Error", "No Rows Returned", Information! )
Else
	szColumn = dw_7.GetItemString ( 1, "pbc_cnam" )
	szCriteria = sle_2.Text
End if

dw_4.SetSort ( szColumn + " A" )
dw_4.Sort ( )

lNumberOfRows = dw_4.RowCount ( )

If IsDate ( szCriteria ) Then
	szExpression = szColumn + " = Date('" + szCriteria + "')"
ElseIf IsNumber ( szCriteria ) = False then
	szExpression = szColumn + " = " + "~'" + szCriteria + "~'"
Else 
	szExpression = szColumn  + " = " + szCriteria
//ElseIf IsNumber ( szCriteria ) = TRUE then
//	szExpression = szColumn + " = " + szCriteria
//Else 
//	szExpression = szColumn  + " = " + "~'" + szCriteria  + "~'"
End if

Do_again:

lRow = dw_4.Find ( szExpression, lStartRow, lNumberOfRows )
	
If lRow = 0 Then
	MessageBox ( "Error", "No Matches Found For~rSpecified Criteria", Information! )
	Return
Elseif lRow < 0 Then
	If IsNumber ( szCriteria ) = False Then
		szExpression = szColumn  + " = " + szCriteria
		Goto Do_again	
	End if
	MessageBox ( "Error", "Error Occured While~rSearching The Database!", Information! )
	Return
End if

dw_4.ScrollToRow ( lRow )

SelectRow ( dw_4, 0, FALSE )
SelectRow ( dw_4, lRow, TRUE )

lStartRow = lRow



end event

type dw_7 from datawindow within w_part_config_build
int X=2048
int Y=1504
int Width=512
int Height=352
int TabOrder=150
boolean Visible=false
string DataObject="d_label_to_column"
boolean LiveScroll=true
end type

type dw_6 from datawindow within w_part_config_build
int X=1536
int Y=1504
int Width=475
int Height=352
int TabOrder=140
boolean Visible=false
string DataObject="d_column_header"
boolean LiveScroll=true
end type

type st_3 from statictext within w_part_config_build
int X=1573
int Y=800
int Width=110
int Height=96
boolean Enabled=false
string Text="="
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_part_config_build
int X=1719
int Y=800
int Width=841
int Height=96
int TabOrder=60
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_2 from dropdownlistbox within w_part_config_build
int X=768
int Y=800
int Width=768
int Height=544
int TabOrder=50
BorderStyle BorderStyle=StyleShadowBox!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_5 from datawindow within w_part_config_build
int X=1024
int Y=1504
int Width=494
int Height=360
int TabOrder=120
boolean Visible=false
string DataObject="d_unit_conversion"
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_part_config_build
int X=512
int Y=1504
int Width=494
int Height=360
int TabOrder=130
boolean Visible=false
string DataObject="d_unit"
boolean LiveScroll=true
end type

type st_2 from statictext within w_part_config_build
int X=1975
int Y=992
int Width=256
int Height=160
boolean Enabled=false
string Text="Unit:"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_part_config_build
int X=2267
int Y=992
int Width=585
int Height=448
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_part_config_build
int X=585
int Y=992
int Width=1134
int Height=160
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_part_config_build
int X=37
int Y=992
int Width=512
int Height=160
boolean Enabled=false
string Text="Quantity:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-18
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4 from commandbutton within w_part_config_build
int X=1463
int Y=1216
int Width=1390
int Height=128
int TabOrder=110
string Text="Cancel"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close ( w_part_config_build )
end on

type cb_3 from commandbutton within w_part_config_build
int X=37
int Y=1216
int Width=1390
int Height=128
int TabOrder=100
string Text="Select"
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;szReturnedPart = szPart
dReturnedQty = Dec ( sle_1.Text )
szReturnedUnit = ddlb_1.Text

close ( parent )

end on

type dw_3 from datawindow within w_part_config_build
int Y=1504
int Width=494
int Height=360
int TabOrder=160
string DataObject="d_part_product_line"
boolean LiveScroll=true
end type

type dw_4 from datawindow within w_part_config_build
int X=768
int Y=64
int Width=2121
int Height=704
int TabOrder=40
string DataObject="dw_part_config2"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

on clicked;String szTempUnit, szStdUM, szSelectedText

Long lCount, lCount2, lTotalItems

Boolean bFoundIt


SelectRow ( dw_4, 0, False )
SelectRow ( dw_4, dw_4.GetClickedRow ( ), True )

szPart = dw_4.GetItemString ( dw_4.GetClickedRow ( ), "part" )

ddlb_1.Reset ( )

gnv_App.of_GetFrame().SetMicroHelp ( szPart )

  SELECT part_inventory.standard_unit  
    INTO :szStdUM  
    FROM part_inventory  
   WHERE part_inventory.part = :szPart   ;

dw_2.SetTransObject ( sqlca )
dw_2.Retrieve ( szPart, szStdUM )

// Loop through first unit in dw_2
For lCount = 1 to dw_2.RowCount ( )

	// Get Units Of Measure
	szTempUnit = dw_2.GetItemString ( lCount, "unit_conversion_unit1" )
	
		//  Loop through drop down list box and look for units
		bFoundIt = False
		lTotalItems = ddlb_1.TotalItems ( )
		For lCount2 = 1 to lTotalItems 
			If ddlb_1.SelectItem ( lCount2 ) < 1 Then &
				MessageBox ( "Error", SQLCA.SQLErrText, Information! )

			//  If selected text is same as unit get out of loop
			szSelectedText = ddlb_1.Text ( lCount2 )

			If szTempUnit = szSelectedText Then 
				bFoundIt = True
				lCount2 = ddlb_1.TotalItems ( )
			End if
		Next
		If bFoundIt = False then &
			ddlb_1.AddItem ( szTempUnit )
Next

// Loop through second unit in dw_2
For lCount = 1 to dw_2.RowCount ( )
	
	// Get Units Of Measure
	szTempUnit = dw_2.GetItemString ( lCount, "unit_conversion_unit2" )

		//  Loop through drop down list box and look for units
		bFoundIt = False
		For lCount2 = 1 to ddlb_1.TotalItems ( )
			ddlb_1.SelectItem ( lCount2 )

			//  If selected text is same as unit get out of loop
			If szTempUnit = ddlb_1.Text ( lCount2 ) Then 
				bFoundIt = True
				lCount2 = ddlb_1.TotalItems ( )
			End if
		Next
		If bFoundIt = False then &
				ddlb_1.AddItem ( szTempUnit )
Next

end on

event dberror;return ( 1 )
end event

type rb_7 from radiobutton within w_part_config_build
int X=73
int Y=3072
int Width=658
int Height=64
string Text="Group Technology"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_6 from radiobutton within w_part_config_build
int X=1390
int Y=2784
int Width=475
int Height=64
string Text="Availability"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_5 from radiobutton within w_part_config_build
int X=1938
int Y=2784
int Width=475
int Height=64
string Text="Schedule"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_4 from radiobutton within w_part_config_build
int X=951
int Y=2784
int Width=293
int Height=64
string Text="Pricing"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_part_config_build
int X=878
int Y=2912
int Width=1170
int Height=128
int TabOrder=200
string Text="Select"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_part_config_build
int X=73
int Y=2976
int Width=658
int Height=64
string Text="Manufacturer"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_part_config_build
int X=73
int Y=2880
int Width=622
int Height=64
string Text="Catagory"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_part_config_build
int X=73
int Y=2784
int Width=549
int Height=64
string Text="Product Line"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_part_config_build
int X=2121
int Y=2912
int Width=549
int Height=128
int TabOrder=190
string Text="Exit"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_1 from datawindow within w_part_config_build
int X=73
int Y=64
int Width=585
int Height=832
int TabOrder=30
string DataObject="dw_product_line"
BorderStyle BorderStyle=StyleShadowBox!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;////////////////////////////////////////////////////////////////////
//
// select the product line to display part
//

Long nRowNumber

nRowNumber = dw_1.Getclickedrow ( )

/////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If ( nRowNumber = 0 ) Then Return

Selectrow (dw_1,0,false)
SelectRow (dw_1,nrownumber,true)

szproduct = dw_1.GetItemString (nRowNumber, "id")

// retrieve and populate the dw.2


dw_4.settransobject ( sqlca )
dw_4.retrieve ( dw_1.GetItemString ( nRowNumber, "id" ) )


end on

type gb_4 from groupbox within w_part_config_build
int X=37
int Width=658
int Height=928
int TabOrder=10
string Text="Product Line"
BorderStyle BorderStyle=StyleLowered!
long TextColor=16711680
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_part_config_build
int X=731
int Width=2194
int Height=928
int TabOrder=20
string Text="Part Number"
BorderStyle BorderStyle=StyleLowered!
long TextColor=16711680
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_part_config_build
int X=878
int Y=2688
int Width=1792
int Height=192
int TabOrder=180
string Text="Part Information"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_part_config_build
int Y=2688
int Width=805
int Height=480
int TabOrder=170
string Text="Search by:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

